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
		// ���ñ���
		request.setCharacterEncoding("UTF-8");
		// ��ȡ�û�������
		String username = request.getParameter("username");
		String password = request.getParameter("password");

		// ���sql���
		String sql = "select * from user where username = '" + username + "' and password = '" + password + "'";
		System.out.println(sql);

		// ��ȡִ��sql�Ķ���
		Statement statement = JDBCUtil.getStatement();
		ResultSet rs = null;
		try {
			// ִ��sql��䣬���ؽ����
			rs = statement.executeQuery(sql);
			if (rs.next()) {
				System.out.println("��½�ɹ�");

				/*
				 * ��ʮһ�����磺��½̬���� Cookie�洢 new Cookie("username", username);
				 * ����Cookie�ڱ��ش��̴洢��ʱ��Ϊ10s .setMaxAge(10); ����Cookie�洢·������Ŀ�����֣�
				 * .setPath("/day02"); ��Cookie��ӵ�������Ϣ��
				 * �洢��������
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
				 * ��ʮ���죬Ϊ������LoginFilter�ṩ���˱�ʶ
				 * �洢��һ�λỰ��
				 */
				HttpSession session = request.getSession();//һ�λỰ
				session.setAttribute("username", username);
//				session.setMaxInactiveInterval(3);//�趨session��ʱʱ��Ϊ10s��10s���session��Ч

				/*
				 * ��ת����Ӧ��ҳ��,ʹ�÷���������ת ����������ת:--�ͻ���һ������һ����Ӧ ��ת֮���ַ���е�ַ���ᷢ���仯
				 * ��request��response������󴫵ݣ����Լ���ʹ��
				 * request.getRequestDispatcher("../pages/user_login_success.jsp")
				 * .forward(request, response); getRequestDispatcher -- ���ת����
				 * �ͻ�����ת��--�ͻ�����������������Ӧ ��ת֮���ַ���е�ַ�ᷢ���仯��������Դ����ʾ�ڵ�ַ���� ֮��ķ����޷���ȡ֮ǰ��request��response
				 * response.sendRedirect("../pages/user_login_success.jsp");
				 */
				if (username.equals("wangwei")) {// ����Ա�û�
					//request.getRequestDispatcher("../pages/user_list_main.jsp").forward(request, response);
					request.getRequestDispatcher("../main.jsp").forward(request, response);
				} else {// ��ͨ�û�
					request.getRequestDispatcher("../pages/user_login_success.jsp").forward(request, response);
					//request.getRequestDispatcher("../main.jsp").forward(request, response);
				}
				// response.sendRedirect("../pages/user_login_success.jsp");
			} else {
				System.out.println("��½ʧ��");
				// �����֤ʧ�ܣ���ת�ص�½ҳ��
				/*
				 * response.setContentType("text/html;charset=UTF-8");
				 * response.getWriter().write("<script>alert('��½ʧ��');" +
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
