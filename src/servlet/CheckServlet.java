package servlet;

import java.io.IOException;
import java.net.URLDecoder;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import util.JDBCUtil;

/**
 * Servlet implementation class CheckServlet
 */
public class CheckServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");//转码
		
		String username = request.getParameter("username");
		username = URLDecoder.decode(username, "UTF-8");
		if (username != null) {
			checkUsername(response, username);
		}
		
		String verifyCode =  request.getParameter("verifycode");
		if (verifyCode != null) {
			checkVerifyCode(request, response, verifyCode);
		}
	}

	/**
	 * 校验验证码
	 * @param request
	 * @param response
	 * @param verifyCode
	 * @throws IOException 
	 */
	private void checkVerifyCode(HttpServletRequest request, HttpServletResponse response, String verifyCode) throws IOException {
		// TODO Auto-generated method stub
		/*
		 * 向上转是自然转换
		 * 向下转是强制转换，前提是曾经发生过向上转
		 */
		String verifyCode2 = (String) request.getSession().getAttribute("verifyCode");
		if (verifyCode2.equalsIgnoreCase(verifyCode)) {
			response.getWriter().write("success");
		} else {
			response.getWriter().write("fail");
		}
	}

	/**
	 * 校验用户名
	 * @param response
	 * @param username
	 * @throws IOException
	 */
	private void checkUsername(HttpServletResponse response, String username) throws IOException {
		// TODO Auto-generated method stub
		String sql = "select * from user where username = '" + username + "'";
		System.out.println(sql);
		Statement st = JDBCUtil.getStatement();
		response.setCharacterEncoding("UTF-8");
		try {
			ResultSet rs = st.executeQuery(sql);
			if (rs.next()) {
				response.getWriter().write("fail");
				System.out.println("fail");
			} else {
				response.getWriter().write("success");
				System.out.println("success");
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
}
