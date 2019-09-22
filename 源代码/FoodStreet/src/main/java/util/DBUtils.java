package main.java.util;


import java.lang.reflect.Method;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;


public class DBUtils {
	private static Connection conn;
	private PreparedStatement pstmt;
	private ResultSet rs;
	// 加载驱动
	static {
		try {
			Class.forName("com.mysql.jdbc.Driver");
			// Class.forName(MyProperties.getInstance().getProperty("driver"));
		} catch (ClassNotFoundException e) {
			// TODO: handle exception
			e.printStackTrace();
		}
	}

	// 获取连接对象
	public Connection getConn() throws SQLException {

		conn = DriverManager.getConnection("jdbc:mysql://120.78.86.208/hotelsys", "root", "543998");
		//
		//conn=DriverManager.getConnection(MyProperties.getInstance().getProperty("url"),MyProperties.getInstance());
		return conn;
	}

	// 关闭所有对象
	public void getClose() {
		// 关闭操作
		// 关闭结果集
		if (null != rs) {
			try {
				rs.close();
			} catch (SQLException e) {
				// TODO: handle exception
				e.printStackTrace();
			}
		}
		// 关闭语句对象
		if (null != pstmt) {
			try {
				pstmt.close();
			} catch (SQLException e) {
				// TODO: handle exception
				e.printStackTrace();
			}
		}
		// 关闭连接对象
		if (null != conn) {
			try {
				conn.close();
			} catch (SQLException e) {
				// TODO: handle exception
				e.printStackTrace();
			}
		}
	}
	
	/**
	 * 设置参数
	 * 
	 * @param pstmt  预编译对象
	 * @param params 需要设置的值
	 * @throws SQLException
	 */
	private void setParams(PreparedStatement pstmt, List<Object> params) throws SQLException {

		if (null != params && params.size() > 0) {
			for (int i = 0; i < params.size(); i++) {
				pstmt.setObject(i + 1, params.get(i));
			}
		}
	}
	
	/**
	 * 获取所有列名
	 * 
	 * @param rs
	 * @return
	 * @throws SQLException
	 */
	public List<String> getAllColumsName(ResultSet rs) throws SQLException {

		List<String> columnsNames = new ArrayList<String>();
		ResultSetMetaData metaData = rs.getMetaData();
		// 获取总列数
		int count = metaData.getColumnCount();
		for (int i = 1; i <= count; i++) {
			columnsNames.add(metaData.getColumnName(i));///////////////////////// 就是这个地方错了
		}
		return columnsNames;
	}
	@SuppressWarnings({ "unchecked", "rawtypes" })
	public <T>List<T> find(String sql,List<Object> params,Class c) throws Exception{
		List<T> list = new ArrayList<T>();
		try {
			conn =getConn();
			pstmt =conn.prepareStatement(sql);
			setParams(pstmt, params);
			rs =pstmt.executeQuery();
			
			List<String> columnNames =getAllColumsName(rs);//获取所有列名
			//System.out.println(columnNames.size());
			T t=null;
			String colName =null;//set方法名
			Object obj =null;//值
			String typeName =null;//类型名
			String methodName =null;//方法名
			//获取所有方法
			Method [] methods =c.getDeclaredMethods();
			while(rs.next()){
				t=(T) c.newInstance();//创建对象
				//循环列
				for(String col:columnNames){
					colName ="set"+col;
					//System.out.println("261行："+colName);
					obj =rs.getObject(col);//根据列名获取对应的值
					for(Method m:methods){
						methodName =m.getName();
						if(colName.equalsIgnoreCase(methodName)){
							//System.out.println("267行："+methodName);
							if(obj==null){
								continue;
							}
							//获取值的数据类型
							typeName =obj.getClass().getSimpleName();
							//System.out.println("272行："+typeName);
							
							//m.invoke(t, obj);
							if("BigDecimal".equals(typeName)){//Oracle数据库的数据类型
								//System.out.println("278行：col="+col+"---m="+m+"---t="+t);
								try{
									m.invoke(t, rs.getInt(col));
								}catch (Exception e) {
									// TODO: handle exception
									m.invoke(t, rs.getDouble(col));
								}
							}else if("Integer".equals(typeName)){
								//System.out.println("285行：col="+col+"---m="+m+"---t="+t);
								m.invoke(t, rs.getInt(col));
							}else if ("Long".equals(typeName)) {
								//System.out.println("288行：col="+col+"---m="+m+"---t="+t);
								m.invoke(t, rs.getLong(col));
							}else if ("String".equals(typeName)) {
								//System.out.println("288行：col="+col+"---m="+m+"---t="+t);
								m.invoke(t, rs.getString(col));
							}else{
								//System.out.println("291行：col="+col+"---m="+m+"---t="+t);
								m.invoke(t, String.valueOf(obj));
							}/////////////////////////////////////////////////////////这里改了
						}
					}
				}
				list.add(t);
			}
			
		}finally {
			getClose();
		}
		return list;
	}
	/*private static String driver;
	private static String url;
	private static String username;
	private static String password;
	private static BasicDataSource bds;//数据源对象
	private static Connection conn;//连接对象
	private static String initial;
	private static String max;
	static {
		Properties pro = new Properties();
		InputStream is = DBUtils.class.getClassLoader().getResourceAsStream("jdbc.properties");  //这是加载src路径下的对象
		System.out.println("InputStream==="+is);
		try {
			pro.load(is);
			driver = pro.getProperty("driver");
			url = pro.getProperty("url");
			username = pro.getProperty("username");
			password = pro.getProperty("password");
			initial = pro.getProperty("initial");
			max = pro.getProperty("max");
			System.out.println("driver==="+driver);
			System.out.println("max=="+max);
			try {
				//连接池
				bds = new BasicDataSource();
				//设置数据库连接信息
				bds.setDriverClassName(driver);
				bds.setUrl(url);
				bds.setUsername(username);
				bds.setPassword(password);
				//管理参数
				bds.setInitialSize(Integer.parseInt(initial));//初始化连接数量
				bds.setMaxTotal(Integer.parseInt(max));//最大连接数量
				
			} catch (Exception e) {
				// TODO: handle exception
				System.out.println("DButils__e===="+e);
			}
			
			//Class.forName("com.mysql.jdbc.Driver");
			//conn = DriverManager.getConnection(url, username,password);
		} catch (IOException e) {
			e.printStackTrace();
			}
		}
	
	//获取连接
	public static Connection getConn() throws Exception {
		return bds.getConnection();//获取连接对象
	}

	//关闭资源
	public static void getClose(Connection conn,Statement stat,ResultSet rs) {
		try {
			if(rs!=null) {
				rs.close();
			}
			if(stat!=null) {
				stat.close();
			}
			if(conn!=null) {
				conn.setAutoCommit(true);//归还之前打开自动提交
				conn.close();
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}*/
	
}
