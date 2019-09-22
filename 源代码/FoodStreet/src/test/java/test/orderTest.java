package test.java.test;

import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.junit.Test;

import dao.OrderDao;
import entity.UserBean;

public class orderTest {
	//TRUNCATE TABLE `order` 重置表
	OrderDao orderDao = new OrderDao();
	/**
	 * 测试 orderdao 的 Generate()方法 生成订单初始数据
	 * @throws SQLException
	 */
	@Test
	public void TestGenerate() throws SQLException {
		
		int x=orderDao.Generate("yan", "123456789", "2019", "20", "gg", "22", "婚", "2000");
		System.out.println(x);
	}
	
	/**
	 * 测试 OrderDao 的 update_orderlist方法 下单时完善订单 总价和是否下单，并将菜品添加到 orderlist表
	 * @throws SQLException 
	 */
	@Test
	public  void Test_update_orderlist() throws SQLException {
		Map<String, Integer> name_point = new HashMap<>();
		
		// 因为主键原因 这些数据插入股过一次再插就没用了 请更改数据 或更改订单号
/*		name_point.put("辣椒炒肉1",1);
		name_point.put("辣椒炒肉2",2);
		name_point.put("辣椒炒肉3",3);
		name_point.put("辣椒炒肉4",4);*/
		name_point.put("厦门沙茶面",1);
		name_point.put("自制湖南剁辣椒",2);
		name_point.put("包菜牛肉丝炒粿条",3);
		name_point.put("肉饼包菜炒粿条",4);
		
		//这个1是 orderDao.Generate（）返回的订单号，name_point是  Map（菜名，评分）
		//                             订单号   价格price   菜品map
		int i=orderDao.update_orderlist(1, "123456", name_point);
		System.out.println(i);
	}
	
	@Test
	public  void Testupdate_orderlist_PK() throws SQLException {
		Map<String, Integer> name_point = new HashMap<>();
		
		// 因为主键原因 这些数据插入股过一次再插就没用了 请更改数据 或更改订单号
/*		name_point.put("辣椒炒肉1",1);
		name_point.put("辣椒炒肉2",2);
		name_point.put("辣椒炒肉3",3);
		name_point.put("辣椒炒肉4",4);*/
		name_point.put("厦门沙茶面",3);
		name_point.put("自制湖南剁辣椒",2);
		name_point.put("包菜牛肉丝炒粿条",3);
		name_point.put("肉饼包菜炒粿条",5);
		
		//这个1是 orderDao.Generate（）返回的订单号，name_point是  Map（菜名，评分）
		//                             订单号   价格price   菜品map
		int i=orderDao.update_orderlist_PK(2, "3333", name_point, "花好月圆");
		System.out.println(i);
	}
	
	/**
	 * 更新菜单表的销量
	 * 
	 * @throws SQLException
	 */
	@Test
	public void Test_update_menu() throws SQLException {
		Map<String, Integer> name_point = new HashMap<>();
		name_point.put("厦门沙茶面",1);
		name_point.put("自制湖南剁辣椒",2);
		name_point.put("包菜牛肉丝炒粿条",3);
		name_point.put("肉饼包菜炒粿条",4);
		int x=orderDao.update_menu(name_point);
		System.out.println(x);
	}
	
	/**
	 * 
	 * 更新  套餐表的销量
	 * @throws SQLException
	 */
	@Test
	public void Test_update_PK() throws SQLException {
		String PKName="花好月圆";
		int x=orderDao.update_Package(PKName);
		System.out.println(x);
	}
	
	
	
	/*
	 * 测试通过是否下单查询出对应信息
	 * */
	@Test
	public void Test_findOrder(){
		String is_xiadan = "1";
		try {
			List<UserBean> list =  orderDao.findOrderByXiadan(is_xiadan);
			for(UserBean bean:list){
				System.out.println(bean);
			}
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	

}
