package main.java.servlet;
import java.awt.Color;
import java.awt.Font;
import java.awt.Graphics;
import java.awt.image.BufferedImage;
/**
 * 验证码处理逻辑
 */
import java.io.IOException;
import java.io.OutputStream;
import java.util.Random;

import javax.imageio.ImageIO;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
public class ValidateCode extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		Random rand = new Random();
		//1创建空白图片
		BufferedImage image = new BufferedImage(100,24,BufferedImage.TYPE_INT_RGB);
		
		//2获取图片画笔
		Graphics g =image.getGraphics();
		
		//3设置画笔颜色
		g.setColor(new Color(rand.nextInt(255),rand.nextInt(255),rand.nextInt(255)));//rgb
		
		//4绘制矩形的背景
		g.fillRect(0, 0, 100, 24);//x，y，width，height
		
		//5获取字符串的方法
		String code = getNumber(5);
		
		//6session绑定验证码
		HttpSession session = request.getSession();
		session.setAttribute("code", code);
		
		//7重新设置画笔默认颜色
		g.setColor(new Color(0,0,0));
		
		//8设置字体颜色
		g.setFont(new Font(null,Font.BOLD,24));//名字，样式粗体，大小24
		
		//9绘制字符串
		g.drawString(code, 15, 20);//str,x,y
		
		response.setContentType("image/jpeg;charset=utf-8");
		OutputStream os = response.getOutputStream();
		ImageIO.write(image, "jpeg", os);//
		
	}

	/**
	 * 获取指定长度的字母和数字组合的字符串
	 * @param size
	 * @return
	 */
	private String getNumber(int size) {
		String code = "";
		String str = "ABCDEFGHIJKMLNOPQRSTUVWSYZabcdefghijklmnopqrstuvwxyz0123456789";
		Random rand = new Random();
		for(int i=0;i<size;i++) {
			code += str.charAt(rand.nextInt(str.length()));
		}
		return code;
	}
}
