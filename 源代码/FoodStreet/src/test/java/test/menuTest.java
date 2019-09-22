package test.java.test;

import java.util.ArrayList;
import java.util.List;
import org.junit.Test;

import dao.MenuDao;
import entity.menuBean;


public class menuTest {
	MenuDao dao=new MenuDao();
	menuBean bean =new menuBean();

	@Test
	public void testFindMenuBySerials()throws Exception{
		bean.setSerial("鲁菜");
		List<menuBean> lists=dao.findMenuBySerials(bean);
		for(menuBean user:lists) {
			System.out.println(user.getName());
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
	public void testFindAllMenu()throws Exception{

		List<menuBean> lists=dao.findAllMenu();
		for(menuBean user:lists) {
			System.out.println(user.getName());
		}
		System.out.println(lists.size());
	}
	//测试通过  关键词  查找菜品
	@Test
	public void testFindMenuByKey()throws Exception{
		List<menuBean> lists=dao.findMenuByKey("material", "鸡蛋");
		for(menuBean user:lists) {
			System.out.println(user.getName());
		}
		System.out.println(lists.size());
	}
	
	
	//添加菜品
	@Test
	public void testAddMenu()throws Exception{		
		bean.setName("过江龙");
		bean.setSerial("川菜");
		bean.setPrice("88");
		bean.setKind("荤菜");
		bean.setMean("一帆风顺");
		bean.setProfit_margin(null);
		bean.setPhoto(null);
		bean.setMaterial("蛇肉，刺猬");
		bean.setSales(0);
		
		int result = dao.addMenu(bean);	
		System.out.println(result);
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
	
	
	@Test
	public void testfindMNBynameLi(){
		List<String> nameLi = new ArrayList<String>();
		nameLi.add("快捷版八宝粥");
		nameLi.add("皮蛋豆腐");
		try {
			List<menuBean> list =  dao.findMNBynameLi(nameLi);
			System.out.println(list);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	@Test
	public void testfindMNBynameLi2() throws Exception{
		
		List<menuBean> list =  dao.findLi();
		System.out.println(list);
	}

}
