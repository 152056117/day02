package servlet;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * Servlet implementation class logoutServlet
 */
public class logoutServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public logoutServlet() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		HttpSession session = request.getSession();
		session.invalidate();//销毁session
		//session.removeAttribute("username");
		Cookie[] cookies = request.getCookies(); // 迭代查找并清除Cookie
		for (Cookie cookie : cookies) {
			cookie.setPath("/day02");//必须设置一样的路径！才能生效
			if ("username".equals(cookie.getName())) {
				cookie.setMaxAge(0);
				response.addCookie(cookie);
			}
			if ("password".equals(cookie.getName())) {
				cookie.setMaxAge(0);
				response.addCookie(cookie);
			}
		}
		//request.getRequestDispatcher("../pages/user_login.jsp").forward(request, response);
		response.sendRedirect("../pages/user_login.jsp");
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
