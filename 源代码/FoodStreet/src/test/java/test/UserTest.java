package test.java.test;

public class UserTest {
	public static void main(String[] args) {
		String str = "helloo,this is my third blog";
        String str1 = removeCharAt(str, 0);
        System.out.println(str1);
        String[] list= {"鸡蛋","面粉","猪肉","鸡肉","牛肉","糖","辣椒"};
    	System.out.println(list[0]);
	}
	
	public static String removeCharAt(String s, int pos) {

        return s.substring(0, pos) + s.substring(pos + 1);// 使用substring()方法截取0-pos之间的字符串+pos之后的字符串，相当于将要把要删除的字符串删除
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
