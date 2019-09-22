# -*- coding: utf-8 -*-
"""
Created on Wed May  8 18:15:11 2019

@author: gzp
"""

#import urllib.request
import requests
from bs4 import BeautifulSoup
from urllib.parse import quote

#from saveMysql import SaveMenusData
import string
#from multiprocessing.pool import Pool
import pymysql
import random
class MenuItems(object):
    menuNo=None
    name=None
    serial=None
    price=None
    profit_margin=None
    photo=None   
    material=None
    kind=None
    
class GetMenuInfo(object):
    def __init__(self,url):
        self.url=url

        # name 过滤词，有下列词语的菜不存数据库
        self.filter = ['怎么', '如何', '的', '+', '？', '-', '——', ':', '#', '—', '——', '—']
        self.urls = self.getUrls(self.url)
        self.items = self.get_Info(self.urls)
        
        self.conn=pymysql.connect(host='120.78.86.208',
                             port=3306,
                             user='root',
                             passwd='543998',
                             db='hotelsys',
                             charset='utf8')
        self.cursor=self.conn.cursor()
        
        #SaveMenusData( self.items )
#        pool=Pool(processes=10)
#        for item in self.items:
##            print( '*****************' )
#            print( item.menuNo,item.name )
#            pool.apply_async( self.save_mysql, (item,) )
#            print( '-------------' )
#        pool.close()
#        pool.join()
        
        for item in self.items:
            #print( item.menuNo,item.name )
            self.save_mysql(item)
        
        
        self.conn.close()
        self.cursor.close()
        #self.save_kind()

        self.headers = {
            'Origin': 'https://home.meishichina.com',
            'Referer': 'https://home.meishichina.com/recipe/xiangcai/',
            'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/73.0.3683.86 Safari/537.36'
        }


    
    #获取爬取页面的地址
    def getUrls(self,url):
        #url=https://home.meishichina.com/recipe/chuancai/page/1/
        urls=[]
        for i in range(5):
            page=str(i)
            url=url.split('/')
            url[-2]=page
            url='/'.join(url)
            urls.append( url )
        return urls
    
    
    #获取url地址响应内容    
    def getResponseInfo(self,url):
        try:
            url=quote(url,safe=string.printable)  #解决url中的中文部分乱码问题
            #req=urllib.request.Request(url,headers=self.headers)
            
            #req = urllib.request.Request(url=url,headers=self.headers,method="GET")
            response=requests.get(url)
        except:
            print( u'Python数据返回失败：%s' %url )
        else:
            print( u'Python数据返回成功：%s' %url )
            return response.text

    #格式化菜名  去掉【】 和 ##
    def format_name(self, name, flag):
        if flag == 1:
            if '】' in name:
                name1 = name.split("】")[-1]
                if name1 == '':
                    print('异常菜名:', name)
                    name1 = name.split("【")[-1].replace('】', '')
                # print(name)
            elif '#' in name:
                name1 = name.split("#")[-1]
                # print(name)
            else:
                name1 = name
        if flag == 2:
            if name[0] == '【':
                name1 = name.split("】")[-1]

            elif '】' in name:
                name1 = name.split("【")[-1][:-1]
            else:
                name1 = name

        return name1

    #获取随机利润率
    def get_profit(self):
        profit = random.randint(20,50)/100
        return profit

    #给小吃分菜系
    def get_serial(self, serial): #鲁菜 川菜 湘菜 粤菜 闽菜  北京菜
        if serial == '北京小吃':
            serial = "北京菜"
        elif serial == '四川小吃':
            serial = "川菜"
        elif serial == '湖南小吃':
            serial = "湘菜"
        elif serial == '广东小吃':
            serial = "粤菜"
        elif serial == '福建小吃':
            serial = "闽菜"
        elif serial == '山东小吃':
            serial = "鲁菜"
        elif serial == '江浙小吃':
            serial = "徽菜"
        return serial


    #通过url地址获取相应页面内容，再根据内容获取节点数据        
    def get_Info(self,urls):
        items=[]
        for url in urls:
            htmlContent=self.getResponseInfo(url)
            soup=BeautifulSoup(htmlContent,'lxml')
            menuNameTag=soup.find_all( 'div',attrs={'class':'ui_title_wrap clear'} )[0]
            #print(menuNameTag)
            menuName=menuNameTag.find('h1').find('a').get_text().strip()
            #print( menuName,'****************' )
            tags=soup.find_all( 'div',attrs={ 'class':'ui_newlist_1 get_num' } )[0]
            liTags=tags.find_all('li')
            for li in liTags:
                item=MenuItems()
                item.menuNo=li.get('data-id')
                #print( item.menuNo,'------------' )
                name = li.find('a').get('title')
                # 如果名字中有过滤词，则跳过这道菜，进行下一个循环
                for w in self.filter:
                    if w in name:
                        continue

                if '小吃' in menuName:

                    item.name = self.format_name(name, 2)
                    item.serial = self.get_serial(menuName)
                    item.kind = "小吃"
                else:

                    item.name = self.format_name(name, 1)
                    item.serial = self.get_serial(menuName)
                    item.kind = self.kind(item.name)


                #print(item.name,'----------')
                #item.serial=self.get_serial(menuName)
                item.photo=li.find('img',attrs={'class':'imgLoad'}).get('data-src')
                #print( item.photo,'------------' )
                item.material=li.find_all('p',attrs={'class':'subcontent'})[0].get_text().strip()[3:]
                item.profit_margin=self.get_profit()

                #print( item.material,'-----------' )
                items.append(item)
                #self.log.info( '菜系为<<%s>>的项爬取成功' %item.menuType )
                
        return items
    
    def save_mysql(self,item):
        price=random.randint(10,100)
        means=[ '百财聚来','富足安康','团团圆圆','年年新高','精打细算','生财有道','吉祥如意','勤劳有财','平安有福','年年有余' ]
        mean=random.choice(means)        
        try:
        
#            sql = 'insert into menu(menuNo,name,serial,price,photo,material) value(item.menuNo,item.name, item.serial,price,item.photo,item.material)'
            #sql =  'insert into menu(menuNo,name,serial,price,mean,photo,material) values("%s","%s","%s","%s","%s","%s","%s")'%(item.menuNo,item.name, item.serial,price,mean,item.photo,item.material)
            self.cursor.execute( 'insert into menu(menuNo,name,serial,price,kind,mean,profit_margin,photo,material) values("%s","%s","%s","%s","%s","%s","%s","%s","%s")'
                                %(item.menuNo,item.name, item.serial,price,item.kind,mean,item.profit_margin,item.photo,item.material) )
            self.conn.commit()
        except Exception as e:
            print( '菜名：',item.name,'已经存储过。',e )
            self.conn.rollback()
    #判断种类
    def kind(self,name):
        materials=['鱼','肉','鸡','虾','丸','牛','羊','鸭','骨','猪']
        kind=None
        name=str(name)
        for s in name:
            if  s in materials :
                kind='荤菜' 
                break
        if kind==None:
            kind='素菜'
            
        return kind
    
    #添加菜的类型
#    def save_kind(self):
#        cursor=self.conn.cursor()
#        #cursor.execute("select name,material,kind from menu where kind is null")
#        results=cursor.fetchall()
#        materials=['鱼','肉','养','鸡','虾','丸','牛','羊','鸭','骨','猪']
#        for name,material,kind in results:
#            material=str(material)
#            if kind==None:
#                for s in material:
#                    if  s in materials :
#                        sql="update menu set kind = '荤菜' where name ='%s'" %name
#                        #print(sql)
#                        cursor.execute( sql )
#                        self.conn.commit()
#                        print(name)
#                        #print(name) 
#                        break
#                    else:
#                        sql="update menu set kind = '素菜' where name ='%s'" %name
#                        #print(sql)
#                        cursor.execute( sql )
#                        self.conn.commit()
#                        break
#        self.conn.close()
    
        
    
if __name__=='__main__':
    #url='https://home.meishichina.com/recipe/lucai/page/2/' #鲁菜
    #url = 'https://home.meishichina.com/recipe/shandongxiaochi/page/1/'  # 山东小吃

    #url='https://home.meishichina.com/recipe/chuancai/page/1/' #川菜
    #url = 'https://home.meishichina.com/recipe/sichuanxiaochi/page/1/'  # 四川小吃

    #url='https://home.meishichina.com/recipe/xiangcai/page/2/' #湘菜
    #url = 'https://home.meishichina.com/recipe/hunanxiaochi/page/1/'  # 湖南小吃

    #url='https://home.meishichina.com/recipe/yuecai/page/2/' #粤菜
    #url = 'https://home.meishichina.com/recipe/guangdongxiaochi/page/1/'  # 广东小吃

    #url='https://home.meishichina.com/recipe/mincai/page/2/' #闽菜
    #url = 'https://home.meishichina.com/recipe/fujianxiaochi/page/2/'  # 福建小吃

    #url='https://home.meishichina.com/recipe/huicai/page/2/' #徽菜
    #url = 'https://home.meishichina.com/recipe/jiangzhexiaochi/page/1/'  # 江浙小吃

    #url='https://home.meishichina.com/recipe/beijingcai/page/2/' #北京菜
    url='https://home.meishichina.com/recipe/beijingxiaochi/page/1/' #北京小吃




    GMI=GetMenuInfo(url)
    
    
    
    
    
    
    
    