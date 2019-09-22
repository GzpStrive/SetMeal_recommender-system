package dao;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import entity.PackageBean;
import entity.menuBean;
import main.java.util.DbHelper;


public class PackageDao {
	DbHelper db=new DbHelper();
	//查看套餐
	public List<PackageBean> findAll() throws Exception{
		String sql = "select *  from package";
		List<PackageBean> list = db.find(sql, null, PackageBean.class);
		return list;
	}
	
	//添加套餐
	public int AddPackage(PackageBean bean) throws SQLException {
		String sql="insert into package (NAME,number,Scene,reason,price,sales) VALUES (?,?,?,?,?,?); "; 
		List<Object>params=new  ArrayList<Object>();
		params.add(bean.getName());
		params.add(bean.getNumber());
		params.add(bean.getScene());
		params.add(bean.getReason());
		params.add(bean.getPrice());
		params.add(bean.getSales());

		return db.update(sql, params);
	}
	//删除套餐
	public int DeletePackage(PackageBean bean) throws SQLException {
		String sql="DELETE from package WHERE packageNo=?;"; 
		List<Object>params=new  ArrayList<Object>();
		params.add(bean.getPackageNo());
		return db.update(sql, params);
	}
	
	
	//通过套餐场景获取每种场景套餐
	public List<PackageBean> findPKByPaKName(String Scene) throws Exception{
		String sql = "select *  from package where Scene="+Scene+"  order by sales desc";
		List<PackageBean> list = db.find(sql, null, PackageBean.class);
		return list;
	}
	
	
	
	/**
	 * //通过套餐名找到此套餐下销量最好的照片  
	 * @param PKName  套餐名
	 * @return   最好销量的图片
	 * @throws Exception
	 */
	public String findImgByPaKName(Integer PKNo) throws Exception{
		String sql = "select mn.photo from combination cb inner join menu mn "+
	" where mn.menuNo=cb.menuNo "+
	" AND cb.packageNo = "+
	"(select pk.packageNo from package pk where pk.packageNo ="+PKNo+" ) "+
    " order by mn.sales desc limit 1";
		List<menuBean> list = db.find(sql, null, menuBean.class);
		String Imgphoto = list.get(0).getPhoto();
		return Imgphoto;
	}
	
	//根据指定的套餐ID数组获取对应的套餐数组
	public List<PackageBean> findPKByPKNoLi(List<Integer> PKNoli) throws Exception{
		StringBuffer sb=new StringBuffer();
		String sql = "select * from package where packageNo IN (?";
		sb.append(sql);
		for (int i=0;i<PKNoli.size()-1;i++) {
			sb.append(",?");
		}
		sb.append(")");
		
		//System.out.println(sb.toString());
		List<Object> param1=new ArrayList<>();
		for (Integer ID : PKNoli) {
			param1.add(ID);
		}
		
		List<PackageBean> list = db.find(sb.toString(), param1, PackageBean.class);
		return list;
	}
	
	//更新套餐销量
		public int UpdatePKSales(String PKName) throws SQLException {
			String sql="update package set sales=sales+1 where `name`='"+PKName+"'"; 
			return db.update(sql, null);
		}
}
