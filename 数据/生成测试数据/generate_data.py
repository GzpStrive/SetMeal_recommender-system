import time
import random
import MySQLdb

'''
批量生成订单信息，订单菜品列表，以及修改菜品销量
'''
class generate_data():
    def __init__(self):
        self.conn = MySQLdb.connect(host='120.78.86.208', port=3306, user='root', passwd='543998', db='hotelsys',
                                    charset='utf8')
        self.cur = self.conn.cursor()
        self.cur.execute('''select name,price from menu ''')
        self.all_menu = list(self.cur.fetchall())

    def close_conn(self, conn):
        self.conn.close()

    def get_time(self):
        return time.strftime('%Y-%m-%d', time.localtime(time.time()))

    def get_ming(self):
        x = '''伊 静 琪 倩 琳 晶 婧 琦 依 轩 璇 鑫 欣 莹 一萌 婉晴 佳宁 欣遥 恩慈 媛媛 妍妍 方倩 志艳 雪朵 雨萱 雅飞 守云 翠兰 慧棋 玉霞 海云 梓妍 慧君 姝妃 思颖 安娜 云燕 津瞐 春艳 韵茹 思颍 美莹 忆璇 佳欣 以萍 弛婷 至棋 佳璇 一萌 婉晴 劭瑶 宥乔 倩妏 安婷 沛侑 仪瑶 佩欣 夙华 文旭 竹莹 雯蓁 右其 尚茵 祯映 柔妏 嘉熙 贝玺 子默 雨莹 炜婷 秀珊 欣怡 思艳 紫颖 芬璇 嫣钰 志芳 芷茹 煊悦 怡瑶 嘉懿 煜城 懿轩 烨伟 苑博 伟泽 熠彤 鸿煊 博涛 烨霖 烨华 煜祺 智宸 正豪 昊然 明杰 立诚 立轩 立辉 峻熙 弘文 熠彤 鸿煊 烨霖 哲瀚 鑫鹏 致远 俊驰 雨泽 烨磊 晟睿 天佑 文昊 修洁 黎昕 远航 旭尧 鸿涛 伟祺 荣轩 越泽 浩宇 瑾瑜 皓轩 擎苍 擎宇 志泽 睿渊 楷瑞 子轩 弘文 哲瀚 雨泽 鑫磊 修杰 伟诚 建辉 晋鹏 天磊 绍辉 泽洋 明轩 健柏 鹏煊 昊强 伟宸 博超 君浩 子骞 明辉 鹏涛 炎彬 鹤轩 越彬 风华 靖琪 明诚 高格 光华 国源 冠宇 晗昱 涵润 翰飞 翰海 昊乾 浩博 和安 弘博 宏恺 鸿朗 华奥 华灿 嘉慕 坚秉 建明 金鑫 锦程 瑾瑜 晋鹏 经赋 景同 靖琪 君昊 俊明 季同 开济 凯安 康成 乐语 力勤 良哲 理群 茂彦 敏博 明达 朋义 彭泽 鹏举'''
        x = x.split(" ")
        return x

    def get_name(self):
        x = random.choice(
            ['赵', '钱', '孙', '李', '周', '吴', '郑', '王', '冯', '陈', '褚', '卫', '蒋', '沈', '韩', '杨', '朱', '秦', '尤', '许', '何',
             '吕', '施', '张', '孔', '曹', '严', '华', '金', '魏', '陶', '姜', '戚', '谢', '邹', '喻', '柏', '水', '窦', '章', '云', '苏',
             '潘', '葛', '奚', '范', '彭', '郎', '鲁', '韦', '昌', '马', '苗', '凤', '花', '方', '俞', '任', '袁', '柳', '酆', '鲍', '史',
             '唐', '费', '廉', '岑', '薛', '雷', '贺', '倪', '汤', '滕', '殷', '罗', '毕', '郝', '邬', '安', '常', '乐', '于', '时', '傅',
             '皮', '卞', '齐', '康', '伍', '余', '元', '卜', '顾', '孟', '平', '黄', '和', '穆', '萧', '尹', '姚', '邵', '湛', '汪', '祁',
             '毛', '禹', '狄', '米', '贝', '明', '臧', '计', '伏', '成', '戴', '谈', '宋', '茅', '庞', '熊', '纪', '舒', '屈', '项', '祝',
             '董', '梁', '杜', '阮', '蓝', '闵', '席', '季', '麻', '强', '贾', '路', '娄', '危', '江', '童', '颜', '郭', '梅', '盛', '林',
             '刁', '钟', '徐', '邱', '骆', '高', '夏', '蔡', '田', '樊', '胡', '凌', '霍', '虞', '万', '支', '柯', '昝', '管', '卢', '莫',
             '经', '房', '裘', '缪', '干', '解', '应', '宗', '丁', '宣', '贲', '邓', '郁', '单', '杭', '洪', '包', '诸', '左', '石', '崔',
             '吉', '钮', '龚', '程', '嵇', '邢', '滑', '裴', '陆', '荣', '冷', '辛', '那', '简', '曾', '毋', '沙', '鞠', '须', '丰', '关',
             '相', '查', '荆', '红', '澹台', '公冶', '公孙', '仲孙', '轩辕', '令狐', '钟离', '宇文', '长孙', '慕容', '鲜于', '司徒', '司空', '丌官',
             '司寇', '端木', '拓跋', '呼延', '南宫'])
        m = random.choice(self.get_ming())
        name = x + m
        return name

    def get_tel(self):
        tel = str(random.choice([131, 137, 136, 139, 154, 156, 158, 152, 173, 176, 179, 181, 183, 187]))
        for i in range(8):
            tel = tel + str(random.randint(0, 9))
        return tel

    def get_deskcount(self):
        return random.choice([10, 15,20,25,50])

    def get_source(self):
        return random.choice(["广告推荐", "朋友推荐", "好文章推荐"])

    def get_age(self):
        return random.choice(["15-20岁", "21-30岁", "31-45岁", "46-55岁", "56-120岁"])

    def get_scene(self):
        return random.choice(["婚宴", "庆功宴", "满月酒","升学宴","生日宴"])

    def get_append(self):
        return random.choice(["1000元档/每桌", "1500元档/每桌", ])

    def get_price(self, menuList):
        count = 0
        names = ''
        for m in menuList:
            count = count + int(m[1])
            names = names + "'" + m[0] + "',"
        return count, names[:-1]

    def get_menulist(self):
        num = random.randint(8, 16)  # 随机菜品数
        menuList = set()
        print('菜品数:', num)

        while len(menuList) < num:
            menuList.add(random.choice(self.all_menu))
        menuList = list(menuList)
        return menuList

    def get_point(self):
        return random.randint(2, 5)

    def get_is_xiadan(self):
        return random.choice([0, 1])

    def set_order(self):
        name = self.get_name()
        print('客户名：', name)
        tel = self.get_tel()
        time = self.get_time()
        deskcount = self.get_deskcount()
        source = self.get_source()
        age = self.get_age()
        scene = self.get_scene()
        append = self.get_append()
        menu_List = self.get_menulist()
        price, names = self.get_price(menu_List)
        is_xiadan = self.get_is_xiadan()
        sql1 = '''insert into `order` (name,tel,time,deskcount,price,source,age,Scene,append,is_xiadan) values('{}','{}','{}','{}','{}','{}','{}','{}','{}','{}')'''.format(
            name, tel, time, deskcount, price, source, age, scene, append, is_xiadan)
        # print(sql1)
        res_order = self.cur.execute(sql1)
        print('表order增加行数:', res_order)

        self.cur.execute('select LAST_INSERT_ID() ')
        orderNo = self.cur.fetchone()[0]
        print('新增order列编号:', orderNo)

        order_list = []
        for menu in menu_List:
            point = self.get_point()
            order = (orderNo, menu[0], point)
            order_list.append(order)

        sql2 = "insert into orderlist(orderNo,menuName,point) values(%s,%s,%s)"
        suss = self.cur.executemany(sql2, order_list)
        print('新增orderlist行数：', suss)

        sql3 = 'update menu set sales=sales+1 WHERE name in({})'.format(names)
        # print(sql3)
        res2 = self.cur.execute(sql3)
        print("更新menu表sales行数:", res2)
        self.conn.commit()


if __name__=='__main__':
    data = generate_data()
    for i in range(100):
        print(
            '----------------------------------第{}个订单--------------------------------------------------'.format(i + 1))
        data.set_order()
