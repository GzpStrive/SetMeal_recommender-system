# encoding=utf-8
import redis
import sys
import pymysql
def get_rule(keys):

    pool = redis.ConnectionPool(host='120.78.86.208', port=6379)
    r = redis.Redis(connection_pool=pool)
    rules=r.hmget('rules',keys)
    count=0
    for r1 in rules:
        if r1==None:
            count+=1
    if count==len(rules):
        conn=pymysql.connect(host='120.78.86.208',port=3306,user='root',passwd='543998',db='hotelsys',charset='utf8')
        cur=conn.cursor()
        cur.execute(''' select name from menu ORDER BY sales desc limit 4 ''')
        rs=cur.fetchall()
        top4=[]
        for r2 in rs:
            pass
            #print(r2[0])
    else:
        s_rule=set()
        for rule in rules:
            if rule!=None:
                x=rule.decode().split(',')
                for x1 in x:

                    s_rule.add(x1)
        for s in s_rule:
            print(s)


if __name__ == '__main__':
    if len(sys.argv) > 1:
        menus = sys.argv[1].split(",")[0:-1]
        get_rule(menus)