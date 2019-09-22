package test.java.test;

import java.util.List;

import org.junit.Test;
import dao.combinationDao;
import entity.menuBean;

public class combinationTest {
	combinationDao dao=new combinationDao();
	menuBean bean =new menuBean();

	@Test
	public void testfindMenuNoByPKName()throws Exception{
		String PKName = "步步高升";
		List<menuBean> lists=dao.findMenuNoByPKName(PKName);
		for(menuBean user:lists) {
			System.out.println(user.getName());
		}
		System.out.println(lists.size());
	}
	
	@Test
	public void testaddCombination(){
		String packageName = "永结同心";
		String menuName = "福州肉燕";
		int number = 1;
		int price=2;
		int result = dao.addCom_Pk(packageName, menuName, number, price);  //结果为1成功，结果为0成功
		System.out.println("result=="+result);
	}
}
