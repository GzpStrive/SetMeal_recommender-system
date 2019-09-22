import operator
import pymysql
import sys


def get_packs(menus):
    conn = pymysql.connect(host='120.78.86.208', port=3306, user='root', passwd='543998', db='hotelsys', charset='utf8')
    cur = conn.cursor()
    sql = 'select menuNo from menu where name in ({})'.format(menus)

    cur.execute(sql)
    menus = cur.fetchall()

    menulist = [m[0] for m in menus]


    cur.execute('select packageNo,menuNo from combination')
    rs = cur.fetchall()

    pack = dict()
    for r in rs:
        pack.setdefault(r[0], 0)
        if r[1] in menulist:
            pack[r[0]] += 1
    packs = sorted(pack.items(), key=operator.itemgetter(1), reverse=True)[:4]
    res = [p[0] for p in packs]
    cur.close()
    conn.close()
    return res


if __name__ == '__main__':
    if len(sys.argv) > 1:
        menus = str(sys.argv[1].split(",")[0:-1])[1:-1]
        res = get_packs(menus)
        for i in res:
            print(i)