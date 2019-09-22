import MySQLdb
import operator



def get_top15():
    conn = MySQLdb.connect(host='120.78.86.208', port=3306, user='root', passwd='543998', db='hotelsys', charset='utf8')
    cur = conn.cursor()
    # sql = "select material from menu "   #所有菜品成分
    sql = "select material from menu order by sales desc limit 150"  # 销量前150菜品成分

    # 获取数据
    cur.execute(sql)
    res = cur.fetchall()

    # 将(('鱼头、剁椒、蒸鱼豉油'), ('皮蛋、内脂豆腐、生抽、麻油、盐、辣椒油、花生米、香菜、榨菜、鸡精。',)...) 里的每个成分提取出来
    materials = []
    for r in res:
        materials.append(r[0])

    top = {}
    # 分割成分 去除 不需要的成分
    for m in materials:
        m = m.replace("。", "").split("、")  # 去句号，以顿号分割
        for p in m:
            if p in ["盐", "姜", "料酒", "白糖", "生抽", "葱", "蒜", "淀粉", "水", "生姜", "油", "香菜", "冰糖", "白砂糖", "蚝油", "海鲜酱油", "味精",
                     "食用油"
                , "香葱", "老抽", "八角", "红糖", "酱油", "鸡精", "花椒", "糖", "面粉", "糯米粉", "香油", "胡椒粉", "清水", "大蒜", "姜末", "葱花",
                     "玉米油", "醋", "大葱", "花生油", "酵母", "色拉油", "郫县豆瓣酱", "白胡椒粉", "豆瓣酱", "温水", "中筋面粉", "玉米淀粉", "辣椒油", "鸡粉",
                     "洋葱", "白酒", "番茄酱", "小葱", "花椒油", "蒸鱼豉油", "桂皮", "姜片", "植物油"]:
                continue
            # 存到字典里并计数
            top.setdefault(p, 0)
            top[p] += 1

    # 将计数好的降序排序
    top15 = sorted(top.items(), key=operator.itemgetter(1), reverse=True)[:15]
    # 提取菜名 生成固定格式
    a = set()
    for t in top15:
        a.add(t[0])
    return a

if __name__=='__main__':
    print(get_top15)