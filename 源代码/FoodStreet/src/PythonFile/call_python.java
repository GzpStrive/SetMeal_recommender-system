package PythonFile;

import java.io.BufferedReader;
import java.io.File;
import java.io.InputStreamReader;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class call_python {

	public Map<Integer, String>  get_isOrder(String deskcount,String price,String source,String age,String Scene,String append) {
		Map<Integer, String> map = new HashMap<Integer, String>();
		try {
			List<String> order = new ArrayList<>();

			order.add("python");
			order.add("/usr/tomcat/apache-tomcat-9.0.16/webapps/FoodStreet/WEB-INF/classes/PythonFile/isOrder.py");

			order.add(deskcount);
			order.add(price);
			order.add(source);
			order.add(age);
			order.add(Scene);
			order.add(append);
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
	/***
	 * 传入 1. Map（String, Integer） {菜名：评分}   2.orderNo 当前订单的订单号 OrderDao获取
	 *
	 * @param name_point
	 * @param OrderNo
	 * @return
	 */
	public Map<Integer, String>  get_xtgl(Map<String, Integer> name_point,String OrderNo) {
		Map<Integer, String> map = new HashMap<Integer, String>();
		try {
			
			String menus ="";
			String points ="";
			for (String key : name_point.keySet()) {
				menus = menus+key+",";
				points = points+name_point.get(key).toString()+",";
			}
			
			List<String> order = new ArrayList<>();
			order.add("python");
			order.add("/usr/tomcat/apache-tomcat-9.0.16/webapps/FoodStreet/WEB-INF/classes/PythonFile/XTalgorithm.py");
			//order.add("D:\\Program Files\\apach\\apache-tomcat-8.0.53-windows-x64\\apache-tomcat-8.0.53\\webapps\\FoodStreet\\WEB-INF\\classes\\PythonFile\\XTalgorithm.py");
			order.add(menus);
			order.add(points);
			order.add(OrderNo);
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
	
	
	public Map<Integer, String>  get_isOrder1(String deskcount,String price,String source,String age,String Scene,String append,String reques) {
		Map<Integer, String> map = new HashMap<Integer, String>();
		try {
			List<String> order = new ArrayList<>();
			String e1= System.getenv("ANICONDA_HOME")+File.separator+"python";
			order.add(e1);
			String exe = reques+"WEB-INF"+File.separator+"classes"+File.separator+"PythonFile"+File.separator+"isOrder.py";
			
			//order.add("python");
			order.add(exe);

			order.add(deskcount);
			order.add(price);
			order.add(source);
			order.add(age);
			order.add(Scene);
			order.add(append);
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
	
	public Map<Integer, String>  get_isOrder2(String reques) {
		Map<Integer, String> map = new HashMap<Integer, String>();
		try {
			
			List<String> order = new ArrayList<>();
			String e1= System.getenv("ANICONDA_HOME")+File.separator+"python";
			order.add(e1);
			String exe = reques+"WEB-INF"+File.separator+"classes"+File.separator+"PythonFile"+File.separator+"p1.py";
			//order.add("/usr/tomcat/apache-tomcat-9.0.16/webapps/FoodTest/WEB-INF/classes/isOrder.py");
			//System.out.println(exe);
			order.add(exe);
			//order.add("邓凯中sgub");
			
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
	
	//
	public Map<Integer, String>  get_xtgl1(Map<String, Integer> name_point,String OrderNo,String reques) {
		Map<Integer, String> map = new HashMap<Integer, String>();
		try {
			
			String menus ="";
			String points ="";
			for (String key : name_point.keySet()) {
				menus = menus+key+",";
				points = points+name_point.get(key).toString()+",";
			}
			
			List<String> order = new ArrayList<>();
			String e1= System.getenv("ANICONDA_HOME")+File.separator+"python";
			order.add(e1);
			String exe = reques+"WEB-INF"+File.separator+"classes"+File.separator+"PythonFile"+File.separator+"XTalgorithm.py";
			order.add(exe);
			//order.add("D:\\Program Files\\apach\\apache-tomcat-8.0.53-windows-x64\\apache-tomcat-8.0.53\\webapps\\FoodStreet\\WEB-INF\\classes\\PythonFile\\XTalgorithm.py");
			order.add(menus);
			order.add(points);
			order.add(OrderNo);
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
