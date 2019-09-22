#encoding=utf-8
import sys
import io
sys.stdout = io.TextIOWrapper(sys.stdout.buffer, encoding='utf-8')

import pymysql
import numpy as np
import pandas as pd  
import operator
import math
from numpy import *
import sys
class is_order(object):
    def __init__(self,items):
        self.items=items
        #获取数据
        self.datas=self.get_data(self.items)
        #print(self.datas[-1::-50])
        #处理数据
        self.handleDatas=self.handle_data(self.datas)
        #print(self.datas[-1::-50])
        #数据归一化
        self.normDataSet=self.autoNorm(self.handleDatas)
        #print(self.normDataSet[-1::-50])
        
    
    
    #连接数据库获取数据并转成pandas形式
    def get_data(self,items):
        conn=pymysql.connect('120.78.86.208','root',"543998","hotelsys")
        cursor=conn.cursor()
        try:
            sql='select deskcount,price,source,age,Scene,append,is_xiadan from `order`'
            cursor.execute(sql)
            results=cursor.fetchall()  #返回所有的特征列数据
            columnDes = cursor.description #获取连接对象的描述信息
            #将数据转换成pandas
            columnNames = [columnDes[i][0] for i in range(len(columnDes))]  
            datas= pd.DataFrame([list(i) for i in results],columns=columnNames)
            new=pd.DataFrame({'deskcount':items['deskcount'],
                  'price':items['price'],
                  'source':items['source'],
                  'age':items['age'],
                  'Scene':items['Scene'],
                  'append':items['append']},
                 index=[0])
            datas=datas.append(new,ignore_index=True)
        except Exception:
            #如果发生异常，则回滚  
            print("发生异常",Exception)  
            conn.rollback()
        finally:  
            #最终关闭数据库连接 
            conn.close()
        return datas
    
    #处理数据
    def handle_data(self,datas):
        #处理source数据 unique() 去重
        labels=datas['source'].unique().tolist()   #得到labels['female', 'male']的列表
        '''
        循环 data['sex']取出的值为 0，1 对应到 labels['female', 'male']中判断是哪个值再去这个值所在的索引
        通过这种方法实现了将 'female','male'转为0，1值
        '''
        datas['source']=[ *map( lambda x:labels.index(x) , datas['source'] ) ]   #  *解包  map映射生成一个迭代器 需要*进行序列解包
        #print(data)
        
        #处理age  同上面处理方式
        labels=datas['age'].unique().tolist()
        datas['age']=datas['age'].apply( lambda x:labels.index(x) )
        
        #处理Scene
        labels=datas['Scene'].unique().tolist()
        datas['Scene']=datas['Scene'].apply( lambda x:labels.index(x) )
        
        #处理append
        labels=datas['append'].unique().tolist()
        datas['append']=datas['append'].apply( lambda x:labels.index(x) )
        
        #处理deskcount
        datas['deskcount']=list(map( int , datas['deskcount'] ))
        
        #处理deskcount
        datas['price']=list(map( int , datas['price'] ))
        
        return datas
    
    #数据归一化
    #新的分析 在距离运算公式中 价格对结果的影响是最大的 为了避免这种影响 我们采用归一化值进行处理
    #这样每个因素对结果的权重就统一了
    # 原理：将值取范围为0到1之间的值
    #运算公式：newValue=( oldValue-min )/( max-min )
    def autoNorm( self,datas ):
        minVals=datas.min(0)  #min( num ):num为0表示每列的最小值 num为1表示每行的最小值
        maxVals=datas.max(0)
        ranges=maxVals-minVals
        normDataSet=np.zeros( np.shape(datas) )
        m=datas.shape[0]
        normDataSet=datas-np.tile( minVals,(m,1) )  #[价格的最小值]
        normDataSet=normDataSet/np.tile( ranges,(m,1) )
        return normDataSet
    
    
    #高斯函数
    def gaussian(self,dist,a=1,b=0,c=0.3):
        return a*math.e**( -(dist-b) ** 2 / ( 2*c**2 ) )
    #反函数
    def reservefun( self,distance,const ):
        return 1/( distance+const)
    #KNN分类判断用户是否下单
    #flag=isOrder.myKNeighborsClassifier( inX,features,lables )
    def myKNeighborsClassifier(self,inX,dataSet,lables,n_neighbors=5,weights='distance',p=2):
        dataSetSize=dataSet.shape[0]  #求出数据集数据的行数
        #print(dataSetSize)
        #求出输入向量inX与数据集中各样本的距离（将输入向量复制行数与dataSet一样）
#        print( type(np.tile( inX,( dataSetSize,1 ) ) ))
#        print( np.tile( inX,( dataSetSize,1 ) ) )
#        print( type(dataSet) )
#        print( dataSet) 
#        diffMat= np.array(np.tile( inX,( dataSetSize,1 ) ))-dataSet
        inX=np.array(np.tile( inX,( dataSetSize,1 ) ))
        #print(type(inX))
        #print(inX)
       # print( type(dataSet) )
        #print(type(dataSet))
        diffMat=inX-dataSet
        sqDiffMat=diffMat**p  #秋平方
        sqDistances=sqDiffMat.sum( axis=1 )  #求和
        distances=sqDistances**( 1/p )  #开平方根
        
        '''
        p=1 : 曼哈顿距离
        p=2: 欧式距离
        p=∞ 它是各个坐标距离的最大值
        '''
    
        if weights=='distance':
            #采用距离加权法重新计算
            # 方案一： 反函数 weight=1/(distance+const)  const任意常数 1就可
            #方案二： 高斯函数 f(x)=a*e^( -(x-b)^2/2c^2 )
            distances=self.gaussian( distances )
        elif weights=='uniform':
            distances=self.reservefun( distances,1 )
        
        sorteDistIndicies=distances.argsort()  #numpy.argsort 返回对数组排序后的索引
        classCount={}  #3:10  2：4 5：19
        
        #求出前k个数据的标签 并统计
        for i in range(n_neighbors):
            voteIlabel=lables[ sorteDistIndicies[i] ] #取出标签值   此sortedDistIndicies[i]表示第几个标签 是数字
            classCount[voteIlabel]=classCount.get( voteIlabel,0 )+1  #对每一个label进行计数
        # python2对字典的操作： classCount.iteritems() python3 classCount.items()
        sortedClassCount=sorted( classCount.items(),key=operator.itemgetter(1),reverse=True )
        #print( '',sortedClassCount )
        return sortedClassCount[0][0]
    
if __name__=='__main__':

    if len(sys.argv) > 5:
        deskcount = sys.argv[1]
        price = sys.argv[2]
        source = sys.argv[3]
        age = sys.argv[4]
        Scene = sys.argv[5]
        append = sys.argv[6]
        items = {'deskcount': deskcount, 'price': price, 'source': source, 'age': age,
                 'Scene': Scene,
                 'append': append}
        isOrder=is_order(items)
        normDataSet=isOrder.normDataSet
        #print(normDataSet,'------------')
        lables=normDataSet['is_xiadan'][0:-1].values
        features=normDataSet.drop( ['is_xiadan'] ,axis=1).values[0:-1]
        #print(features,'***************')
        inX=normDataSet.drop(['is_xiadan'] ,axis=1).values[-1]
        flag=isOrder.myKNeighborsClassifier(inX, features, lables)
        print(flag)

            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            