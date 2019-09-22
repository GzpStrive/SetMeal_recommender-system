package dao;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import entity.UserBean;
import main.java.util.DbHelper;

public class OrderDao {
/**
 * 
 * 订单信息表  首页填完信息后点提交 把信息插入order表
 */
	DbHelper db = new DbHelper();
	
	//传入订单信息 返回成功插入的语句条数 大于0即表示成功
	
	/**
	 * 传入订单信息 返回成功插入的订单编号 orderNo
	 * @param name
	 * @param tel
	 * @param time
	 * @param deskcount
	 * @param source
	 * @param age
	 * @param Scene
	 * @param append
	 * @return
	 * @throws SQLException
	 */
	public int Generate(String name,String tel,String time,String deskcount,String source,String age,String Scene,String append) throws SQLException {
		String sql ="insert into `order` (name,tel,time,deskcount,source,age,Scene,append) values(?,?,?,?,?,?,?,?) ";

		List<Object> param1=new ArrayList<>();
		param1.add(name);
		param1.add(tel);
		param1.add(time);
		param1.add(deskcount);
		param1.add(source);
		param1.add(age);
		param1.add(Scene);
		param1.add(append);
		int result = db.updateOrder(sql, param1);
		if (result>0 ) {
			System.out.println("用户初始订单信息插入成功");
			return result;
		}else {
			System.out.println("用户初始订单信息插入失败！");
			return 0;
		}

	}
	
	/**更新  订单表
	 * 
	 * @param orderNo
	 * @param price
	 * @param Map<Integer, Integer> info =(menuName:point,menuName:point...)
	 * @return  返回一个1代表修改成功
	 * @throws SQLException 
	 */
	public int update_orderlist(Integer orderNo, String price, Map<String, Integer> info) throws SQLException {
		String sql1 = "update `order` set price=?,is_xiadan=1 where orderNo=? ";
		StringBuffer sb=new StringBuffer();
		sb.append("insert into orderlist(orderNo,menuName,point) values(?,?,?) ");
		for (int i=0;i<info.size()-1;i++) {
			sb.append(",( ?,?,? )");
		}
		String sql2 = sb.toString();
		//System.out.println(sql2);
		
		
		List<String> sqls= new ArrayList<String>();
		sqls.add(sql1);
		sqls.add(sql2);
		
		List<List<Object>> paramsList = new ArrayList<>(); 
		List<Object> param1=new ArrayList<>();
		param1.add(price);
		param1.add(orderNo);
		
		List<Object> param2=new ArrayList<>();
		for (String key : info.keySet()) {
			Integer value = info.get(key);
			param2.add(orderNo);
			param2.add(key);
			param2.add(value);
			
		}
		paramsList.add(param1);
		paramsList.add(param2);
		
		StringBuffer sb3=new StringBuffer();
		String sql3 ="update menu set sales=sales+1 WHERE name in (?";
		sb3.append(sql3);

		for (int i=0;i<info.size()-1;i++) {

			sb3.append(",?");
		}
		sb3.append(")");
		List<Object> param3=new ArrayList<>();
		for (String key : info.keySet()) {
			param3.add(key.toString());
		}
		paramsList.add(param3);
		sqls.add(sb3.toString());
		
		return db.updates(sqls, paramsList);
		
	}
	
	
	
	
	public int update_orderlist_PK(Integer orderNo, String price, Map<String, Integer> info,String PKName) throws SQLException {
		String sql1 = "update `order` set price=?,is_xiadan=1 where orderNo=? ";
		StringBuffer sb=new StringBuffer();
		sb.append("insert into orderlist(orderNo,menuName,point) values(?,?,?) ");
		for (int i=0;i<info.size()-1;i++) {
			sb.append(",( ?,?,? )");
		}
		String sql2 = sb.toString();
		//System.out.println(sql2);
		
		
		List<String> sqls= new ArrayList<String>();
		sqls.add(sql1);
		sqls.add(sql2);
		
		List<List<Object>> paramsList = new ArrayList<>(); 
		List<Object> param1=new ArrayList<>();
		param1.add(price);
		param1.add(orderNo);
		
		List<Object> param2=new ArrayList<>();
		for (String key : info.keySet()) {
			Integer value = info.get(key);
			param2.add(orderNo);
			param2.add(key);
			param2.add(value);
			
		}
		paramsList.add(param1);
		paramsList.add(param2);
		
		StringBuffer sb3=new StringBuffer();
		String sql3 ="update menu set sales=sales+1 WHERE name in (?";
		sb3.append(sql3);

		for (int i=0;i<info.size()-1;i++) {

			sb3.append(",?");
		}
		sb3.append(")");
		List<Object> param3=new ArrayList<>();
		for (String key : info.keySet()) {
			param3.add(key.toString());
		}
		paramsList.add(param3);
		sqls.add(sb3.toString());
		
		String sql4="update package set sales=sales+1 where `name`='"+PKName+"'";
		sqls.add(sql4);
		paramsList.add(null);
		
		return db.updates(sqls, paramsList);
		
	}
	
	
	/**
	 *  下单时更新menu中的 菜品的sales
	 * @param info Map<Integer, Integer> info =(menuName:point,menuName:point...)
	 * @return 成功更新的条数=即菜品数
	 * @throws SQLException
	 */
	public int update_menu( Map<String, Integer> info) throws SQLException {
		StringBuffer sb=new StringBuffer();
		String sql ="update menu set sales=sales+1 WHERE name in (?";
		sb.append(sql);

		for (int i=0;i<info.size()-1;i++) {

			sb.append(",?");
		}
		sb.append(")");
		List<Object> param1=new ArrayList<>();
		for (String key : info.keySet()) {
			param1.add(key.toString());
		}
		

		return db.update(sb.toString(), param1);
		
	}
	
	/**
	 * 
	 * 更新套餐表
	 * @param PKName
	 * @return
	 * @throws SQLException
	 */
	public int update_Package(String PKName) throws SQLException {
		String sql ="update package set sales=sales+1 WHERE name='"+PKName+"'";
		
		return db.update(sql, null);
		
	}

	/**
	 * 通过下单与否查询订单
	 * 
	 * @param way
	 * @return
	 * @throws Exception
	 */
	public List<UserBean> findOrderByXiadan(String way) throws Exception{
		String sql = "SELECT * FROM `order`";
		if(way.equals("*")){
		}else if(way.equals("1")){
			sql = "SELECT * FROM `order` WHERE is_xiadan=1";
		}else if(way.equals("0")){
			sql = "SELECT * FROM `order` WHERE is_xiadan=0";
		}
		List<UserBean> list = db.find(sql, null, UserBean.class);
		if(null!=list && list.size()>0){
			return list;
		}
		return null;
	}
}
