package main.java.util;

import java.io.UnsupportedEncodingException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class WebUtil {

	/**
	 * 设置编码机
	 * @param request
	 * @param response
	 * @throws UnsupportedEncodingException
	 */
	public static void setEncoding(HttpServletRequest request,HttpServletResponse response) throws UnsupportedEncodingException{
		request.setCharacterEncoding("UTF-8");
	 	response.setCharacterEncoding("UTF-8");
	}
}
