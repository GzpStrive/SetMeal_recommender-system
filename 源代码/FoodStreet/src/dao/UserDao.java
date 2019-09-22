package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;


import entity.User;
import main.java.util.DBUtils;

public class UserDao {
	
	/**
	 * 
	 * 依据用户名查询，如果找不到，返回null,
	 * 否则返回一个User对象（包含了用户的所有信息）
	 *
	 */
	public User selectUser(String username) {
		User user = null;
		Connection conn = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		DBUtils db = new DBUtils();
		try {
			conn = db.getConn();
			//conn = DBUtils.getConn();
			ps =  conn.prepareStatement("select*from user where username=?");
			ps.setString(1, username);
			rs = ps.executeQuery();
			while(rs.next()) {
				user = new User();
				user.setId(rs.getInt("id"));
				user.setUsername(rs.getString("username"));
				user.setPassword(rs.getString("password"));
				user.setAge(rs.getInt("age"));
				user.setGender(rs.getString("gender"));
				user.setEmail(rs.getString("email"));
				
			}
		} catch (Exception e) {
			System.out.println(e);
			e.printStackTrace();
			throw new RuntimeException(e);
		}finally {
			//DBUtils.getClose(conn, ps, rs);
			db.getClose();
		}
		return user;
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
