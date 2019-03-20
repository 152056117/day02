package servlet;

import java.io.IOException;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import javax.servlet.ServletException;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import util.JDBCUtil;

/**
 * Servlet implementation class LoginServlet
 */
public class LoginServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// 设置编码
		request.setCharacterEncoding("UTF-8");
		// 获取用户名密码
		String username = request.getParameter("username");
		String password = request.getParameter("password");

		// 组合sql语句
		String sql = "select * from user where username = '" + username + "' and password = '" + password + "'";
		System.out.println(sql);

		// 获取执行sql的对象
		Statement statement = JDBCUtil.getStatement();
		ResultSet rs = null;
		try {
			// 执行sql语句，返回结果集
			rs = statement.executeQuery(sql);
			if (rs.next()) {
				System.out.println("登陆成功");

				/*
				 * 第十一天下午：登陆态保持 Cookie存储 new Cookie("username", username);
				 * 设置Cookie在本地磁盘存储的时间为10s .setMaxAge(10); 设置Cookie存储路径（项目的名字）
				 * .setPath("/day02"); 将Cookie添加到返回信息中
				 * 存储到缓存中
				 */
				Cookie nameCookie = new Cookie("username", username);
				Cookie pwdCookie = new Cookie("password", password);
//				nameCookie.setMaxAge(3);
//				pwdCookie.setMaxAge(3);
				nameCookie.setPath("/day02");
				pwdCookie.setPath("/day02");
				response.addCookie(nameCookie);
				response.addCookie(pwdCookie);
				
				/*
				 * 第十二天，为过滤器LoginFilter提供过滤标识
				 * 存储在一次会话中
				 */
				HttpSession session = request.getSession();//一次会话
				session.setAttribute("username", username);
//				session.setMaxInactiveInterval(3);//设定session超时时间为10s，10s后此session无效

				/*
				 * 跳转到相应的页面,使用服务器端跳转 服务器端跳转:--客户端一次请求一次相应 跳转之后地址栏中地址不会发生变化
				 * 将request和response继续向后传递，可以继续使用
				 * request.getRequestDispatcher("../pages/user_login_success.jsp")
				 * .forward(request, response); getRequestDispatcher -- 获得转发器
				 * 客户端跳转：--客户端两次请求两次响应 跳转之后地址栏中地址会发生变化，请求资源会显示在地址栏中 之后的服务无法获取之前的request、response
				 * response.sendRedirect("../pages/user_login_success.jsp");
				 */
				if (username.equals("wangwei")) {// 管理员用户
					//request.getRequestDispatcher("../pages/user_list_main.jsp").forward(request, response);
					request.getRequestDispatcher("../main.jsp").forward(request, response);
				} else {// 普通用户
					request.getRequestDispatcher("../pages/user_login_success.jsp").forward(request, response);
					//request.getRequestDispatcher("../main.jsp").forward(request, response);
				}
				// response.sendRedirect("../pages/user_login_success.jsp");
			} else {
				System.out.println("登陆失败");
				// 输出验证失败，跳转回登陆页面
				/*
				 * response.setContentType("text/html;charset=UTF-8");
				 * response.getWriter().write("<script>alert('登陆失败');" +
				 * "window.location.href='../pages/user_login.jsp'</script>");
				 */
				response.sendRedirect("../pages/user_login.jsp?flag=fail");
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}

	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doGet(request, response);
	}
}
