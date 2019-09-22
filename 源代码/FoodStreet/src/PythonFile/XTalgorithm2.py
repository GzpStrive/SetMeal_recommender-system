#encoding=utf-8
import sys
import io

import pymysql
from math import sqrt
sys.stdout = io.TextIOWrapper(sys.stdout.buffer, encoding='utf-8')
class xieTong_algorithm(object):
    
    def __init__(self,items,orderNo):
        #连接数据库获取数据
        self.orderNo=orderNo
        self.items=items
        self.datas=self.get_datas(self.items,self.orderNo)
        
        #获取推荐的菜名已经评分
        self.menu=self.getRecommendations(self.datas,self.orderNo)
        
    
    #连接数据库获取历史订单信息
    def get_datas(self,items,orderNo):        
        conn=pymysql.connect('120.78.86.208','root',"543998","hotelsys")
        cursor=conn.cursor()
        datas={}
        #测试数据
        try:
            sql=' select orderNo,menuName,point from orderlist'
            cursor.execute(sql)
            results=cursor.fetchall()
            for munber,menuName,point in results:
                datas.setdefault(munber,{})
                datas[munber].setdefault(menuName,0)
                datas[munber][menuName]=point
            #print(datas)
#            datas[1110]={'香煎风干鱼':2.0,'香菇肉馅蒸饺':3.0,'红糟焖猪蹄':5.0,'蒜香椒盐排骨':2.0,'双色剁椒鱼头':1.0,'香煎藕饼':3.0}           

            datas[orderNo]=items


        except Exception:
            #如果发生异常，则回滚
            print("发生异常",Exception)  
            conn.rollback()
        finally:  
            #最终关闭数据库连接 
            conn.close()
        return datas
    
    
    #获取相似菜的数据集
    def getSameItem( self,pref,preson1,preson2 ):
        shared_items={}  # 为两个订单看点的相似菜的数据集
        for item in pref[preson1]:
            if item in pref[preson2]:
                shared_items[item]=1   #{'Lady in the Water': 1, 'Snakes on a Plane': 1}
        return shared_items

    
    #欧几里得距离实现
    def sim_Euclid( self,pref, preson1, preson2 ):
        #首先得到共同的评分项列表
        share_items=self.getSameItem( pref, preson1, preson2 )
        #如果两个人没有共同处，则返回0 表示完全不同
        if( len(share_items)==0 ):
            return 0
        #有相同点，则计算所有差值的平方和
        sum_of_squres=sum( [ pow( pref[preson1][item]-pref[preson2][item], 2 ) for item in pref[preson1] if item in pref[preson2] ] )
        #将相似度归一
        return 1/(1+sqrt( sum_of_squres ))
    
    #下面编写一个函数找出与自己有相似品味的餐饮者
    #返回结果的个数和相似度函数均为可选参数，有默认值
    def topMatches(self,pref,preson,n=5,similarity=sim_Euclid):
        #利用python的列表推导式
        scores=[ (similarity(pref,preson,other),other) for other in pref if other!=preson ] #  值的格式 [ (相似度，人名) ]
        #对列表值进行排序
        scores.sort()
        scores.reverse()
        return scores[0:n]
    
    def getRecommendations( self,pref, preson ):
        totals={} #加权评分总和  格式：{菜名:加权评分总分}
        simSums={} #相似度之和 注意：如果没有打分的话，则这个人的相似度也不累加
        for other in pref:
            #不要和自己比较
            if other==preson:
                continue
            sim=self.sim_Euclid(pref,preson,other)
            #忽略相似度为0或小于0的情况， preson(皮尔逊相似度)系数会有负是
            if sim<0:
                continue
            for item in pref[other]:
                #只对自己还没有看过的电影进行评分
                if item not in pref[preson] or pref[preson][item]==0:
                    #相似度*评价值
                    totals.setdefault(item,0)
                    totals[item]+=pref[other][item]*sim  #格式 [ (1.25, '烧卖, ) ]
                    #相似度之和
                    simSums.setdefault(item,0)
                    simSums[item]+=sim
        #建立一个归一化的列表，格式-> [ (评分，菜单)，(评分，菜单) ]
        rankings=[ (total/(simSums[item]+1),item) for item,total in totals.items() ]
        
        #返回经过排序的列表
        rankings.sort()
        rankings.reverse()
        return rankings[:10]
    
    
if __name__=='__main__':

    items={'香煎风干鱼':2.0,'香菇肉馅蒸饺':3.0,'红糟焖猪蹄':5.0,'蒜香椒盐排骨':2.0,'双色剁椒鱼头':1.0,'香煎藕饼':3.0}
    if len(sys.argv) > 2:
        menus=sys.argv[1].split(",")[0:-1]
        points=sys.argv[2].split(",")[0:-1]
        orderNo=sys.argv[3]
        for i in range(len(menus)):
            items.setdefault(menus[i],points[i])
        print(menus)
        print(points)
        print(orderNo)
    XTalgorithm=xieTong_algorithm(items,orderNo)
    menus=XTalgorithm.menu
    for menu in menus:
        pass#print(menu[1])
    
    
    
    
    
    
    
    

    