package main.java.util;

import java.lang.reflect.Method;
import java.sql.*;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;


public class DbHelper {
	private Connection conn;
	private PreparedStatement pstmt;
	private ResultSet rs;
	
	private static String driver = "com.mysql.jdbc.Driver";
	private String url="jdbc:mysql://120.78.86.208:3306/hotelsys?useUnicode=true&characterEncoding=utf-8";
	private String adminName = "root";
	private String password = "543998";
	
	
	//加载驱动
	static{//在程序中只运行一次  ---》static
		try {
			Class.forName(driver);
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	//获取连接对象
	public Connection getConn(){
		try {
			conn=DriverManager.getConnection(url,adminName,password);
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return conn;
	}
	

	//关闭连接对象
	public void closeAll(){
		// 关闭结果集对象
		if (null != rs) {
			try {
				rs.close();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		// 关闭预编译对象
		if (null != pstmt) {
			try {
				pstmt.close();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		// 关闭连接对象
		if (null != conn) {
			try {
				conn.close();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}

	}
	
	
	
	
	/**
	 * 多条更新sql语句操作      事务处理
	 * @param sqls    多条更新的sql语句
	 * @param params  每一条sql语句对应一个list ， 多个list存放params
	 * @return
	 * @throws SQLException 
	 */
	public int updates(List<String> sqls,List<List<Object>> params) throws SQLException{
		int result=0;
		conn=getConn();
		try{
			//将提交方式设置为手动提交
			conn.setAutoCommit(false);
			for(int i=0;i<sqls.size();i++){
				pstmt=conn.prepareStatement(sqls.get(i));
				if(params==null){
					
				}else{
				//设置参数
				setParams(pstmt,params.get(i));
				}
				//执行
				result = pstmt.executeUpdate();
			}
			conn.commit();//事务手动提交
		}catch(Exception e){//有异常不能提交，进行事务回滚
			conn.rollback();//事务回滚
		}finally{
			conn.setAutoCommit(true);//恢复提交方式 ，自动
			closeAll();
		}
		return result;
	}	
	
	
	
	
	/**所有更新操作  参数存在List集合中
	 *    更新   update  insert  delete
	 * @param sql    单条更新的sql语句
	 * @param params  参数的值必须按照？ 顺序进行添加到List
	 * @return
	 * @throws SQLException 
	 */
	public int update(String sql,List<Object> params) throws SQLException{
		int result=0;
		try{//获取连接对象
			conn=getConn();
			//System.out.println(conn);
			pstmt=conn.prepareStatement(sql);
			//设置参数
			setParams(pstmt,params);
			//执行
			result = pstmt.executeUpdate();
		}finally{
			closeAll();
		}
		return result;
	}
	
	
	
	public int updateOrder(String sql,List<Object> params) throws SQLException{
		int result=0;
		try{//获取连接对象
			conn=getConn();
			System.out.println(conn);
			pstmt=conn.prepareStatement(sql);
			//设置参数
			setParams(pstmt,params);
			//执行
			result = pstmt.executeUpdate();
			if (result>0){
				String sql2 = "select LAST_INSERT_ID() ";
				result =Integer.parseInt(findOrder(conn, sql2, null).get("LAST_INSERT_ID()").toString());
				
			}
		}finally{
			closeAll();
		}
		return result;
	}
	public Map<String,Object> findOrder(Connection conn,String sql,List<Object> params) throws SQLException{
		Map<String,Object> map=null;
		try{
			
			pstmt=conn.prepareStatement(sql);
			//设置参数
			setParams(pstmt, params);
			//执行查询操作
			rs=pstmt.executeQuery();
			//获取所有列名
			List<String> columnNames = getAllColumnNames(rs);
			if(rs.next()){
				map=new HashMap<String,Object>();
				//循环列名
				for(String columnName : columnNames){
					map.put(columnName, rs.getObject(columnName));
				}
			}	
		}finally{
			
		}	
		return map;
	}
	
	//设置参数
	private void setParams(PreparedStatement pstmt,List<Object> params) throws SQLException{
		if(null!=params&&params.size()>0){  //有参数存在才设置
			for(int i=0;i<params.size();i++){
				pstmt.setObject(i+1, params.get(i));  //？ 从1开始  所以要i+1
			}
		}
	} 
	/**
	 * 查看多条记录
	 * @param sql
	 * @param params
	 * @return
	 * @throws SQLException
	 */
	public List<Map<String,Object>> findMutiple(String sql,List<Object> params) throws SQLException{
		List<Map<String,Object>> list = new ArrayList<Map<String,Object>>();
		Map<String,Object> map=null;
		try{
			conn=getConn();
			pstmt=conn.prepareStatement(sql);
			//设置参数
			
			setParams(pstmt, params);
			//执行查询操作
			rs=pstmt.executeQuery();
			//获取所有列名
			List<String> columnNames = getAllColumnNames(rs);
			while(rs.next()){
				map=new HashMap<String,Object>();
				//循环列名，获取列名对应的值
				for(String columnName : columnNames){	
						//列名作为key 
						map.put(columnName, rs.getObject(columnName));
				}
				//将map记录存入list集合中
				list.add(map);
			}	
		}finally{
			closeAll();
		}	
		return list;
	}
	
	
	/**
	 * 返回一条记录   <---select * from userinfo where user_id=?
	 * @param sql     查看sql语句
	 * @param params  传入的参数
	 * @return map    一条记录
	 * @throws SQLException
	 */
	public Map<String,Object> findSingle(String sql,List<Object> params) throws SQLException{
		Map<String,Object> map=null;
		try{
			conn=getConn();
			pstmt=conn.prepareStatement(sql);
			//设置参数
			setParams(pstmt, params);
			//执行查询操作
			rs=pstmt.executeQuery();
			//获取所有列名
			List<String> columnNames = getAllColumnNames(rs);
			if(rs.next()){
				map=new HashMap<String,Object>();
				//循环列名
				for(String columnName : columnNames){
					map.put(columnName, rs.getObject(columnName));
				}
			}	
		}finally{
			closeAll();
		}	
		return map;
	}
	
	/***jdbc 2.0
	 * 
	 * 获取所有列名
	 * @param rs  
	 * @return
	 * @throws SQLException
	 */
	private List<String> getAllColumnNames(ResultSet rs) throws SQLException{
		List<String> columnNames = new ArrayList<String>();
		//可用于获取关于ResultSet 对象中列的类型和属性信息的对象
		ResultSetMetaData data = rs.getMetaData();
		//获取总列数
		int count = rs.getMetaData().getColumnCount();
		for(int i=1;i<=count;i++){
			columnNames.add(data.getColumnName(i));
		}
		return columnNames;
	}
	/**
	 * 将查询结果封装在对象中
	 * @throws Exception 
	 */
	@SuppressWarnings("unchecked")
	public <T> List<T> find(String sql,List<Object> params , @SuppressWarnings("rawtypes") Class c) throws Exception{
		List<T> list = new ArrayList<T>();
		try{
			conn = getConn();
			pstmt = conn.prepareStatement(sql);
			setParams(pstmt, params);
			rs=pstmt.executeQuery();
			List<String> columnNames = getAllColumnNames(rs);
			T t = null;
			String colName = null;  //set方法名
			Object obj = null;  //值
			String typeName = null; //类型名 
			String methodName = null;  //方法名
			//获取所有的方法
			Method[] methods = c.getDeclaredMethods();
			while(rs.next()){
				t = (T)c.newInstance();  //创建对象
				//循环列
				for(String col : columnNames){
					colName = "set"+col;   //setuser_id;
					obj = rs.getObject(col);  //根据列名获取对应的值
					for(Method m : methods){
						methodName = m.getName();
						if(colName.equalsIgnoreCase(methodName)){  //set
							if(obj==null){
								continue;
							}
							//获取值的数据类型
							typeName = obj.getClass().getSimpleName();
							//System.out.println(typeName);
							if("BigDecimal".equals(typeName)){  //oracle数据库
								try{
									m.invoke(t, rs.getInt(col));
								}catch(Exception e){
									m.invoke(t, rs.getDouble(col));
								}
							}else if("Integer".equals(typeName)){
								m.invoke(t, rs.getInt(col));
							}else if("Long".equals(typeName)){
								m.invoke(t, rs.getLong(col));
							}else{
								m.invoke(t, String.valueOf(obj));
							}
							
							
						}
					}
				}
				
				list.add(t);
			}
		}finally{
			closeAll();
		}
		return list;
	}
	
	
	//使用聚合函数查看 count   avg   sum   min   max;
	//select count(*) from userinfo 
	public double getPolymer(String sql,List<Object>params)throws Exception{
		double result=0;
		try {
			conn=getConn();
			pstmt=conn.prepareStatement(sql);
			setParams(pstmt, params);
			rs=pstmt.executeQuery();
			if(rs.next()) {
				result=rs.getDouble(1);
			}
		} finally {
			closeAll();
		}
		return result;
	}
	

}
