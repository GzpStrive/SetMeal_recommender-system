# -*- coding: utf-8 -*-
"""
Created on Sat Jun  1 12:27:15 2019

@author: gzp
"""

import pymysql
import re

def generate_Data():
    conn = pymysql.connect(host='120.78.86.208', port=3306, user='root', passwd='543998', db='hotelsys', charset='utf8')
    cur = conn.cursor()
    fp=open('/usr/tomcat/apache-tomcat-9.0.16/webapps/FoodStreet/analysis_Img/menuPrice.txt','w')
    sql = "select material from menu "  # 所有菜品成分
    # 获取数据
    cur.execute(sql)
    res = cur.fetchall()
    materials = []
    for r in res:
        materials.append(r[0])
    
    top = set()  #获取所有的成分
    for m in materials:
        m = m.replace("。", "：").split("、")
        for p in m:
            top.add(p)
    
    method=r'肉|鸡|鱼|虾|蛙|鸭|丸|牛|羊|鸭|骨|猪|肺|肝|杂|腩'
    peilaiomethod=['花生油','水','大葱','盐','油','酱油','植物油','胡椒粉','糖','蚝油','小苏打','沙拉酱','烹饪油','酒','生抽','葱','花椒粉','小葱','八角','姜','生粉','温水','姜片','冰糖','鸡精','大蒜子','姜粒','温水','绵白糖','烹调油','姜沫','蒜肉','香油','绵白糖','糖霜','蜂蜜','橄榄油','色拉油','老干妈豉油','开水','淀粉','白砂糖','冰糖粉','凉水','蒜片','香叶','食用油','辣椒','葱花','白糖','辣椒油','糖粉','姜丝','椰蓉','红糖','大蒜','尖椒','老抽','陈醋','老干妈辣椒油']
    row=[]  #肉类
    vege=[]  #素类
    peiliao=[]  #配料
    
    #循环每种成分进行分类
    for i in top:
    
        if re.search(method,i):
            row.append(i)
    
        elif i in peilaiomethod:
            peiliao.append(i)
    
        else:
            vege.append(i)


    #获取配料和价格
    sql = "select material,price from menu"
    cur.execute(sql)
    materials=cur.fetchall()
    for material,price in materials:
        material = material.replace("。", "：").split("、")
        price=int(price)
        Hun=0
        Su=0
        PeiLiao=0
        #对每条数据的每种原料进行计数
        for i in material:
            if i in row:
                Hun=Hun+1
                continue
            elif i in vege:
                Su=Su+1
                continue
            elif i in peiliao:
                PeiLiao=PeiLiao+1
                break
        #将每条数据存入文档
        print( str(Hun)+'\t'+str(Su)+'\t'+str(PeiLiao)+'\t'+str(price) , file=fp )                
    fp.close()
    
    
if __name__=='__main__':
    generate_Data()