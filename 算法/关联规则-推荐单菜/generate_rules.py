import pymysql
import redis


def get_data():
    conn = pymysql.connect('120.78.86.208', 'root', "543998", "hotelsys")
    cursor = conn.cursor()
    # 测试数据
    sql = 'select group_concat(menuName) from orderlist GROUP BY orderNo'
    cursor.execute(sql)
    results = cursor.fetchall()
    dataSet = []
    for result in results:
        result = list(result)[0]
        result = result.split(',')[0:-1]
        print(result)
        dataSet.append(result)
    return dataSet


# 根据dataSet生成k-1 项集
def createCandidataSet(dataSet):
    result = []  # 存所有的k-1 项集（非频繁项集，因为还没有通最小支持度比较）
    for transaction in dataSet:  # 去除每条事务
        for item in transaction:  # 从事务中取出每个商品
            if not [item] in result:
                result.append([item])  # [ [1],[3],[4],[2],[5] ]
    # result.sort()
    # print( result )
    # 这里一定要用fronzenset而不是set 因为以后要将这些作为字典键值使用，而字典的建必须是不可变的元素， 而[]是可变的 所以要换成（）才行
    return map(frozenset, result)


def scanDataSet(dataSet, candidataSet, minSupport=0.02):
    z = list(
        candidataSet)  # 将map转为list  [frozenset({1}), frozenset({2}), frozenset({3}), frozenset({4}), frozenset({5})]
    numItems = float(len(dataSet))  # 统计总共有多少条事务记录
    candidataCounter = {}  # { 候选项集1：支持度计数， }  --> { frozenset({1})：3 }
    # 循环交易记录
    for tid in dataSet:
        # 循环候选集项
        for candidata in z:
            # 如果候选集项是记录的一部分 给这个候选集增加计数
            if candidata.issubset(tid):
                candidataCounter[candidata] = candidataCounter.get(candidata, 0) + 1
    resultList = []  # 存频繁项集（频繁项集值的是 大于最小支持度的项集）
    supportData = {}  # 各候选集的支持度字典
    for key in candidataCounter:
        # 支持度
        support = candidataCounter[key] / numItems  # 每个候选集的次数/总事务数  -->支持度
        if support >= minSupport:
            resultList.insert(0, key)  # 保存到resultList
            # print(resultList)
        supportData[key] = support
    return resultList, supportData


def apprioriGeneratorRequenceList(requenceList, k):
    reList = []
    requenceListLength = len(
        requenceList)  # requenceList=[frozenset({5}), frozenset({2}), frozenset({3}), frozenset({1})]
    for i in range(requenceListLength):
        for j in range(i + 1, requenceListLength):
            # 注意其生成过程中 首先对每个项集按元素排序，然后每次比较两个项集
            # 只有在前k-1项相同是才将这两项合并 这样做是因为数并非要两两合并各个集合
            # 那样生成的集合并非都是k+1项的 在限制项数为K+1的前提下
            # 只有在前k-1项相同 最后一项不相同的情况下合并才为所需要的候后选项集
            '''
            当k的2时 [:k-2]截取为-->[]
            当k=3时 此时的requenceList[j]里面为二项集 [:k-2]截取一个数据 
            若L1和L2截取的第一个数据相同就可以生成3项集 如--> (1,2) (1,3)-->(1,2,3)
            以此类推生成4 ，5 项集
            '''
            L1 = list(requenceList[i])[:k - 2]  # [:k-2]的实际作用为去列表的前k-1个元素
            L2 = list(requenceList[j])[:k - 2]
            L1.sort()
            L2.sort()
            if L1 == L2:
                reList.append(requenceList[i] | requenceList[j])
    return reList


def apriori(dataSet, minSupport=0.009):
    candidataSet = createCandidataSet(dataSet)  # 生成K-1项集
    L1, supportData = scanDataSet(dataSet, candidataSet, minSupport)  # 生成 频繁一项项集  (L1频繁项集，supportData频繁项集的支持度)
    L = [L1]  # L1 --》 [frozenset({5}), frozenset({2}), frozenset({3}), frozenset({1})]
    # [L1]-->  [  [frozenset({5}), frozenset({2}), frozenset({3}), frozenset({1})]  ]
    k = 2
    while (len(L[k - 2]) > 0):  # [frozenset({5}), frozenset({2}), frozenset({3}), frozenset({1})]
        Ck = apprioriGeneratorRequenceList(L[k - 2], k)  # 以此生成2，3，。。。项 候选项集
        # (Lk k频繁项集，supK  K频繁项集的支持度)
        Lk, supK = scanDataSet(dataSet, Ck, minSupport)  # 依据minSupport进行剪纸 生成K项频繁项集 以及支持度列表
        supportData.update(supK)
        '''
        [[frozenset({5}), frozenset({2}), frozenset({3}), frozenset({1})],
        [frozenset({2, 3}), frozenset({3, 5}), frozenset({2, 5}), frozenset({1, 3})], [frozenset({2, 3, 5})], []]
        '''
        L.append(Lk)  # 将新生成的频繁项集加入到L中
        k += 1
    return L, supportData


def calcConf(freqSet, premise, supportData, rules, minConf=0.2):
    # 对候选规则进行评估
    prunedH = []  # 满足最小置信度要求的规则列表
    # premise的多种组个 2-》3  3->2
    for conseq in premise:
        conf = supportData[freqSet] / supportData[freqSet - conseq]
        if conf >= minConf:
            print('前提：', freqSet - conseq, '--结论：', conseq, ',此规则置信度为：', conf)
            rules.append((freqSet - conseq, conseq, conf))
            prunedH.append(conseq)
    return prunedH  # 生成结果集合


'''
功能描述：根据当前候选规则集H生成下一层候选规则集
    参数：freqSet:频繁项集
    premise: 构件对于fronzenset((2,3))-->frozenset({2}), frozenset({3})
    supportData:所有候选项集的支持度列表
    rules:生成的满足最小置信度要求的关联规则
    minConf:最小置信度
'''


def rulesFromConseq(freqSet, premise, supportData, rules, minConf=0.2):
    # 生成候选规则集
    m = len(premise[0])
    # 每个构件有多种集合 如[frozenset({'驴打滚'}), frozenset({'葱爆羊肉'})] 可以形成：驴打滚->葱爆羊肉 葱爆羊肉->驴打滚 故两个置信度都要计算
    while len(freqSet) > m:  # 控制循环的次数
        premise = calcConf(freqSet, premise, supportData, rules, minConf=0.2)
        # Apriori使用一种逐层方法来产生关联规则，其中每层对应于规则后件的项数
        # 则通过合并这两条规则产生候选规则

        if len(premise) > 1:
            premise = apprioriGeneratorRequenceList(premise, m + 1)
            m += 1
        else:  # 不能产生下一层候选关联规则 提前退出循环
            break


'''
功能描述：关联规则生成函数
    参数:freqSet:频繁项集
    supportData:所有候选项集的支持度列表
    minConf:最小置信度
返回值：一个包含可信度的规则列表 bigRuleList
'''


def generateRules(freqSet, supportData, minConf=0.2):
    bigRuleList = []

    for i in range(1, len(freqSet)):  # 从K2频繁项集列表开始循环 构建规则
        # i=1 [frozenset({2, 3}), frozenset({3, 5}), frozenset({2, 5})
        # i=2 [frozenset({2, 3, 5})]
        for fs in freqSet[i]:
            H1 = [frozenset([item]) for item in fs]
            rulesFromConseq(fs, H1, supportData, bigRuleList, minConf)

    return bigRuleList


# 将生产的规则处理后存入redis
def set_in_redis(rules):
    rs = dict()
    for r in rules:
        # 获取前提 拼接成  ‘菜品，菜品，’的形式
        r0 = list(r[0])
        qt = ""
        for r_qt in r0:
            qt += r_qt + ','
        qt = qt[:-1]
        # 获取 结论 拼接成 ‘菜品，菜品，’
        r1 = list(r[1])
        res = ''
        for r1_res in r1:
            res += r1_res + ','

        rs.setdefault(qt, "")
        rs[qt] += res
    pool = redis.ConnectionPool(host='120.78.86.208', port=6379)
    r = redis.Redis(connection_pool=pool)
    for k, v in rs.items():
        rs[k] = v[:-1]
    r.hmset("rules", rs)

if __name__ == '__main__':
    # 2. 利用Apriori算法求频繁项集，支持度列表
    dataSet = get_data()
    requenceList, supportData = apriori(dataSet, minSupport=0.009)

    # 3. 利用频繁项集 以及支持度求有效规则
    rules = generateRules(requenceList, supportData, minConf=0.2)
    # 4. 将有效规则存入redis
    set_in_redis(rules)