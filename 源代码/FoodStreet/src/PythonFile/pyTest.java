package PythonFile;

import java.io.BufferedReader;
import java.io.File;
import java.io.InputStreamReader;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class pyTest {
	/**
	 * 传 菜名和评分的map 你懂得 和前面几个方法差不多
	 * @param name_point
	 * @return
	 */
	public Map<Integer, String>  get_pack(Map<String, Integer> name_point) {
		Map<Integer, String> map = new HashMap<Integer, String>();
		try {
			
			String menus ="";
			for (String key : name_point.keySet()) {
				menus = menus+key+",";
			}
			
			List<String> order = new ArrayList<>();
			order.add("python");
			order.add("/usr/tomcat/apache-tomcat-9.0.16/webapps/FoodStreet/WEB-INF/classes/PythonFile/get_pack.py");
			order.add(menus);
			String[] cmdArr1 = order.toArray(new String[order.size()]);

			Process process = Runtime.getRuntime().exec(cmdArr1);
			BufferedReader in = new BufferedReader(new InputStreamReader(process.getInputStream()));
			String line;
			
			int i =0;
			while ((line=in.readLine())!=null) {
				
				map.put(i,line);
				i++;
			}
			in.close();
			process.waitFor();
			System.out.println("end");
		} catch (Exception e) {
			// TODO: handle exception
		}
		return map;
	}
	/**
	 * 关联规则  的  菜品推荐
	 * 
	 * @param name_point  {菜品名：评分}的map
	 * @return  菜名map
	 */
	public Map<Integer, String>  get_rules(Map<String, Integer> name_point) {
		Map<Integer, String> map = new HashMap<Integer, String>();
		try {
			
			String menus ="";
			for (String key : name_point.keySet()) {
				menus = menus+key+",";
			}
			List<String> order = new ArrayList<>();
			order.add("python");
			order.add("/usr/tomcat/apache-tomcat-9.0.16/webapps/FoodStreet/WEB-INF/classes/PythonFile/get_rules.py");
			order.add(menus);
			String[] cmdArr1 = order.toArray(new String[order.size()]);

			Process process = Runtime.getRuntime().exec(cmdArr1);
			BufferedReader in = new BufferedReader(new InputStreamReader(process.getInputStream(),"UTF-8"));
			String line;
			
			int i =0;
			while ((line=in.readLine())!=null) {
				
				map.put(i,line);
				i++;
			}
			in.close();
			process.waitFor();
			System.out.println("end");
		} catch (Exception e) {
			// TODO: handle exception
		}
		return map;
	}
	
	//String material="面条，猪瘦肉，猪肝，虾仁，油豆腐，小青菜，沙茶酱，花生酱，番茄酱，盐，糖，料酒，胡椒粉，淀粉，葱，姜，蒜，鸡精，骨头汤";
		public Map<Integer, String>  get_price(String material) {
			Map<Integer, String> map = new HashMap<Integer, String>();
			try {
				
			
				List<String> order = new ArrayList<>();
				order.add("python");
				order.add("/usr/tomcat/apache-tomcat-9.0.16/webapps/FoodStreet/WEB-INF/classes/PythonFile/p1.py");
				order.add(material);
				String[] cmdArr1 = order.toArray(new String[order.size()]);

				Process process = Runtime.getRuntime().exec(cmdArr1);
				BufferedReader in = new BufferedReader(new InputStreamReader(process.getInputStream()));
				String line;
				
				int i =0;
				while ((line=in.readLine())!=null) {
					
					map.put(i,line);
					i++;
				}
				in.close();
				process.waitFor();
				System.out.println("end");
			} catch (Exception e) {
				// TODO: handle exception
			}
			return map;
		}
	
	
	public Map<Integer, String>  get_pack2(Map<String, Integer> name_point,String reques) {
		Map<Integer, String> map = new HashMap<Integer, String>();
		try {
			
			String menus ="";
			for (String key : name_point.keySet()) {
				menus = menus+key+",";
			}
			
			List<String> order = new ArrayList<>();
			String e1= System.getenv("ANICONDA_HOME")+File.separator+"python";
			order.add(e1);
			String exe = reques+"WEB-INF"+File.separator+"classes"+File.separator+"PythonFile"+File.separator+"get_pack.py";
			
			//order.add("python");
			order.add(exe);
			order.add(menus);
			String[] cmdArr1 = order.toArray(new String[order.size()]);

			Process process = Runtime.getRuntime().exec(cmdArr1);
			BufferedReader in = new BufferedReader(new InputStreamReader(process.getInputStream()));
			String line;
			
			int i =0;
			while ((line=in.readLine())!=null) {
				
				map.put(i,line);
				i++;
			}
			in.close();
			process.waitFor();
			System.out.println("end");
		} catch (Exception e) {
			// TODO: handle exception
		}
		return map;
	}
	public Map<Integer, String>  get_rules1(Map<String, Integer> name_point,String reques ) {
		Map<Integer, String> map = new HashMap<Integer, String>();
		try {
			
			String menus ="";
			for (String key : name_point.keySet()) {
				menus = menus+key+",";
			}
			List<String> order = new ArrayList<>();
			String e1= System.getenv("ANICONDA_HOME")+File.separator+"python";
			order.add(e1);
			String exe = reques+"WEB-INF"+File.separator+"classes"+File.separator+"PythonFile"+File.separator+"get_rules.py";
			order.add(exe);
			order.add(menus);
			String[] cmdArr1 = order.toArray(new String[order.size()]);

			Process process = Runtime.getRuntime().exec(cmdArr1);
			BufferedReader in = new BufferedReader(new InputStreamReader(process.getInputStream(),"UTF-8"));
			String line;
			
			int i =0;
			while ((line=in.readLine())!=null) {
				
				map.put(i,line);
				i++;
			}
			in.close();
			process.waitFor();
			System.out.println("end");
		} catch (Exception e) {
			// TODO: handle exception
		}
		return map;
	}
	
	//String material="面条，猪瘦肉，猪肝，虾仁，油豆腐，小青菜，沙茶酱，花生酱，番茄酱，盐，糖，料酒，胡椒粉，淀粉，葱，姜，蒜，鸡精，骨头汤";
	public Map<Integer, String>  get_price2(String material,String reques) {
		Map<Integer, String> map = new HashMap<Integer, String>();
		try {
			
			List<String> order = new ArrayList<>();
			String e1= System.getenv("ANICONDA_HOME")+File.separator+"python";
			order.add(e1);
			String exe = reques+"WEB-INF"+File.separator+"classes"+File.separator+"PythonFile"+File.separator+"ForecastPrice.py";
			order.add(exe);
			order.add(material);
			System.out.println("material--"+material);
			String[] cmdArr1 = order.toArray(new String[order.size()]);

			Process process = Runtime.getRuntime().exec(cmdArr1);
			BufferedReader in = new BufferedReader(new InputStreamReader(process.getInputStream()));
			String line;
			
			int i =0;
			while ((line=in.readLine())!=null) {
				
				map.put(i,line);
				i++;
			}
			in.close();
			process.waitFor();
			System.out.println("end");
		} catch (Exception e) {
			// TODO: handle exception
		}
		return map;
	}
	
	public Map<Integer, String>  get_p(String material) {
		Map<Integer, String> map = new HashMap<Integer, String>();
		try {
			
			
			List<String> order = new ArrayList<>();
			order.add("python");
			order.add("/usr/tomcat/apache-tomcat-9.0.16/webapps/FoodStreet/WEB-INF/classes/PythonFile/ForecastPrice.py");
			order.add(material);
			String[] cmdArr1 = order.toArray(new String[order.size()]);

			Process process = Runtime.getRuntime().exec(cmdArr1);
			BufferedReader in = new BufferedReader(new InputStreamReader(process.getInputStream(),"UTF-8"));
			String line;
			
			int i =0;
			while ((line=in.readLine())!=null) {
				
				map.put(i,line);
				i++;
			}
			in.close();
			process.waitFor();
			System.out.println("end");
		} catch (Exception e) {
			// TODO: handle exception
		}
		return map;
	}
	
	
	
}
