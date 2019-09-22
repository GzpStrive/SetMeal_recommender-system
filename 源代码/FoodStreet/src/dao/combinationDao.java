package dao;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import entity.menuBean;
import main.java.util.DbHelper;

public class combinationDao {
	DbHelper db = new DbHelper();
	//根据套餐的PackageName  获取到menu
	public List<menuBean> findMenuNoByPKName(String PKName) throws Exception{
		String sql = "select mn.* from combination cb inner join menu mn where mn.menuNo=cb.menuNo AND cb.packageNo=(select pk.packageNo from package pk where pk.name = '"+PKName+"' order by mn.sales desc) ";
		//System.out.println("combinatinDao,sql=="+sql);
		List<menuBean> list = db.find(sql, null, menuBean.class);
		if(null!=list && list.size()>0){
			return list;
		}
		return null;
	}
	
	//根据套餐的名字和套餐的菜品的名字  更新combination表    再计算出总价格和  菜品数  更新Package表
	public int addCom_Pk(String packageName,String menuName,int number,int price) {
		String sql="INSERT into combination(packageNo,menuNo) VALUES"+
				"((select packageNo from package pk where pk.name='"+packageName+"' ),(select menuNo from menu mn where mn.name='"+menuName+"'))";
		String sql2="UPDATE package SET number= '"+number+"',price='"+price+"' where name = '"+packageName+"'";
		List<String> sqls=new ArrayList<String>();
		sqls.add(sql);
		sqls.add(sql2);
		
		try {
			return db.updates(sqls, null);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			return 0;
		}
	}
}
