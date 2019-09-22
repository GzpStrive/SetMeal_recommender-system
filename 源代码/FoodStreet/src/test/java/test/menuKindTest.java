package test.java.test;

import java.util.List;

import org.junit.Test;

import dao.MenuDao;
import entity.menuBean;



public class menuKindTest {
	MenuDao dao=new MenuDao();
	menuBean bean =new menuBean();
	@Test
	public void testFindMenuBySerials()throws Exception{
		bean.setSerial("北京菜");
		List<menuBean> lists=dao.findMenuBySerials(bean);
		for(menuBean menu:lists) {
			System.out.println(menu.getName());
			System.out.println(menu.getPrice());
		}
		System.out.println(lists.size());
	}
	@Test
	public void testFindMenuByKind()throws Exception{
		bean.setKind("素菜");
		List<menuBean> lists=dao.findMenuByKind(bean);
		for(menuBean user:lists) {
			System.out.println(user.getName());
		}
		System.out.println(lists.size());
	}
	
	@Test
	public void testfindKind() throws Exception{
		List<menuBean> list=dao.findKind();
		for(menuBean menu:list) {
			System.out.println(menu.getKind());
		}
		System.out.println(list);
	}
	
	@Test
	public void testfindserial() throws Exception{
		List<menuBean> list=dao.findserial();
		for(menuBean menu:list) {
			System.out.println(menu.getSerial());
		}
		System.out.println(list);
	}
}
