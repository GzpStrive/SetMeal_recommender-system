package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import entity.Admin;
import entity.User;
import main.java.util.DBUtils;

public class AdminDao {
	DBUtils db = new DBUtils();
	
	/**
	 * 
	 * 依据用户名查询，如果找不到，返回null,
	 * 否则返回一个User对象（包含了用户的所有信息）
	 *
	 */
	public Admin selectAdmin(String str1) {
		Admin admin = null;
		Connection conn = null;
		PreparedStatement ps = null;
		ResultSet rs = null;

		try {
			conn = db.getConn();
			//conn = DBUtils.getConn();
			ps =  conn.prepareStatement("select * from admin where No=?");
			ps.setString(1, str1);
			rs = ps.executeQuery();
			while(rs.next()) {
				admin = new Admin();
				admin.setNo(rs.getInt("No"));
				admin.setPwd(rs.getString("pwd"));
				admin.setTelephone(rs.getString("telephone"));
				admin.setPosition(rs.getString("position"));
				admin.setStr2(rs.getString("str2"));
			}
		} catch (Exception e) {
			System.out.println(e);
			e.printStackTrace();
			throw new RuntimeException(e);
		}finally {
			//DBUtils.getClose(conn, ps, rs);
			db.getClose();
		}
		return admin;
	}
	
	
	/*
	 *登录
	 */
	public Admin login(String uname,String upass) throws Exception{
		String sql ="select * from admin where telephone=? and pwd=?";
		List<Object> params= new ArrayList<Object>();
		params.add(uname);
		params.add(upass);
		List<Admin> list = db.find(sql, params, Admin.class);
		if(null!=list&list.size()>0){
			return list.get(0);
		}else{
			return null;
		}
	}
	
	
	/**
	 * 注册
	 */
	public void insertUser(User user) {
		Connection conn = null;
		PreparedStatement ps = null;
		DBUtils db = new DBUtils();
		try {
			conn = db.getConn();
			//conn = DBUtils.getConn();
			ps = conn.prepareStatement("insert into user values(null,?,?,?,?,?)");
			ps.setString(1, user.getUsername());
			ps.setString(2, user.getPassword());
			ps.setString(3, user.getGender());
			ps.setInt(4, user.getAge());
			ps.setString(5, user.getEmail());
			ps.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
			throw new RuntimeException(e);
		}finally {
			//DBUtils.getClose(conn, ps, null);
			db.getClose();
		}
	}
	
	
}
