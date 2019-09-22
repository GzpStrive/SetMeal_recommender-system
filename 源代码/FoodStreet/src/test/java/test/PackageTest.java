package test.java.test;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import org.junit.Test;

import dao.PackageDao;
import entity.PackageBean;

public class PackageTest {
	PackageDao dao=new PackageDao();
	PackageBean bean=new PackageBean();
	//添加套餐
	@Test
	public void testAddPackage()throws Exception{
		bean.setName("芝麻开花");
		bean.setNumber("8");
		bean.setScene("升学宴");
		bean.setReason("芝麻开花节节高");
		bean.setPrice("666");
		bean.setSales(97);
		int x=dao.AddPackage(bean);
		System.out.println(x);
	}
	//删除套餐
	@Test
	public void testDeletePackage()throws Exception{		
		bean.setPackageNo(1003);
		dao.DeletePackage(bean);
	}
	
	//查找所有
	@Test
	public void testfindAll() throws Exception{
		List<PackageBean> list =  dao.findAll();
		System.out.println(list);
	}
	
	//通过场景查找
	@Test
	public void testfindPKByPaKName(){
		String Scene = "'"+"婚宴"+"'";
		try {
			List<PackageBean> list =  dao.findPKByPaKName(Scene);
			System.out.println(list);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	//通过对应ID数组查找
	@Test
	public void testfindPKByPKNoLi(){
		List<Integer> PKNoli = new ArrayList<Integer>();
		PKNoli.add(1001);
		PKNoli.add(1007);
		try {
			List<PackageBean> list =  dao.findPKByPKNoLi(PKNoli);
			System.out.println(list);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	//查找封面图片
	@Test
	public void testfindImgByPaKName(){
		Integer PKName = 1001;
		try {
			String  Image =  dao.findImgByPaKName(PKName);
			System.out.println(Image);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	@Test
	public void testUpdatePKSales() throws SQLException{
		String PKName="花好月圆";
		int x=dao.UpdatePKSales(PKName);
		System.out.println(x);
	}
	
}
  