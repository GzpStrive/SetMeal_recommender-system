package test.java.test;


import dao.AdminDao;
import entity.Admin;

public class Admintest {
	public static void main(String[] args) {
		AdminDao dao1 = new AdminDao();
		Admin admin = dao1.selectAdmin("1");
		System.out.println(admin);
	}
	
	
	/*@Test
	public void insert() {
		System.out.println("emmm");
		UserDao dao = new UserDao();
		User user = new User();
		user.setUsername("我是神麼");
		user.setPassword("775881089");
		user.setGender("男");
		user.setAge(24);
		user.setEmail("13476054425@163.com");
		dao.insertUser(user);
	}
	
	
	@Test
	public void select() {
		UserDao dao = new UserDao();
		User user = dao.selectUser("我是神麼");
		System.out.println(user);
	}*/
}
