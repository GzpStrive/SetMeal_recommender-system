package dao;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import entity.menuBean;
import main.java.util.DbHelper;

public class MenuDao {
	DbHelper db = new DbHelper();
	//根据菜系查询   （湘菜  ，川菜）
	public List<menuBean> findMenuBySerials(menuBean kind) throws Exception{
		String sql = "select * from menu where serial = ? ";
		List<Object> params = new ArrayList<Object>();
		params.add(kind.getSerial());
		List<menuBean> list = db.find(sql, params, menuBean.class);
		if(null!=list && list.size()>0){
			return list;
		}
		return null;
	}
	
	//根据菜的种类查询（荤菜 素菜）
	public List<menuBean> findMenuByKind(menuBean kind) throws Exception{
		String sql = "select * from menu where kind = ? ";
		List<Object> params = new ArrayList<Object>();
		params.add(kind.getKind());
		List<menuBean> list = db.find(sql, params, menuBean.class);
		System.out.println(params);
		System.out.println(sql);
		if(null!=list && list.size()>0){
			return list;
		}
		return null;
	}
	//根据关键字查询菜品
	public List<menuBean> findMenuByKey(String key,String value){
		String sql = "select * from menu where "+key+" like "+"'%"+value+"%'"+"";
		List<menuBean> list;
		try {
			list = db.find(sql, null, menuBean.class);
			/*System.out.println(params);
			System.out.println(sql);*/
			if(null!=list && list.size()>0){
				return list;
			}
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			return null;
		}
		return null;
	}
	
	//查找所有的菜品
	public List<menuBean> findAllMenu() throws Exception{
		String sql = "select * from menu";
		List<menuBean> list = db.find(sql, null, menuBean.class);
		if(null!=list && list.size()>0){
			return list;
		}
		return null;
	}
	//添加菜品
	public int addMenu(menuBean bean) {
		String sql="INSERT into menu (menuNo,NAME,serial,price,kind,mean,profit_margin,photo,material,sales) "
				+ "VALUES((SELECT c.a+1 from (SELECT MAX(menuNo) as a FROM menu) c ),?,?,?,?,?,?,?,?,?);"  
			;
		List<Object>params=new  ArrayList<Object>();
		params.add(bean.getName());
		params.add(bean.getSerial());
		params.add(bean.getPrice());
		params.add(bean.getKind());
		params.add(bean.getMean());
		params.add(bean.getProfit_margin());
		params.add(bean.getPhoto());
		params.add(bean.getMaterial());
		params.add(bean.getSales());
		try {
			return db.update(sql, params);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			return 2;
		}
	}
	
	//查找种类
	public List<menuBean> findKind() throws Exception{
		String sql = "select DISTINCT kind from menu";
		List<menuBean> list = db.find(sql, null, menuBean.class);
		return list;
	}
	//查找菜系
		public List<menuBean> findserial() throws Exception{
			String sql = "select DISTINCT serial from menu";
			List<menuBean> list = db.find(sql, null, menuBean.class);
			return list;
	}
		
	//通过菜品名数组  获取到menu数组
	public List<menuBean> findMNBynameLi(List<String> nameLi) throws Exception{
		StringBuffer sb=new StringBuffer();
		String sql = "select * from menu where `name` IN (?";
		sb.append(sql);
		for (int i=0;i<nameLi.size()-1;i++) {
			sb.append(",?");
		}
		sb.append(")");
		
		//System.out.println(sb.toString());
		List<Object> param1=new ArrayList<>();
		for (String name : nameLi) {
			param1.add(name);
		}
		
		//System.out.println(nameLi+"====="+param1);
		
		List<menuBean> list = db.find(sb.toString(), param1, menuBean.class);
		return list;
	}
	
	
	public List<menuBean> findLi() throws Exception{
		String sql = "select * from menu where `name` IN('快捷版八宝粥','皮蛋豆腐')";
		
		
		List<menuBean> list = db.find(sql, null, menuBean.class);
		return list;
	}
	
}

