package servlet;

import java.io.IOException;
import java.sql.SQLException;
import java.sql.Statement;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import entity.User;
import util.JDBCUtil;

/**
 * Servlet implementation class AddUserServlet
 */
public class AddUserServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		System.out.println("�����ϵܣ��������");
		
		User user = new User();
		user.setUsername(request.getParameter("username"));
		user.setPassword(request.getParameter("password"));
		user.setMobile(request.getParameter("mobile"));
		user.setMailbox(request.getParameter("mailbox"));
		user.setSex(Integer.parseInt(request.getParameter("sex")));
		
		Statement st = JDBCUtil.getStatement();
		String sql = "insert into user(username,password,mobile,mailbox,sex) value('"
				+ user.getUsername() + "','"
				+ user.getPassword() + "','"
				+ user.getMobile() + "','"
				+ user.getMailbox() + "',"
				+ user.getSex() + ")";
		System.out.println(sql);
		try {
			int i = st.executeUpdate(sql);
			if (i == 1) {
				System.out.println("���������ɣ��û�����" + user.getUsername());
			} else {
				System.out.println("�������ʧ�ܣ��û�����" + user.getUsername());
			}
			response.sendRedirect("../pages/user-list.jsp");
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			JDBCUtil.closeAll(null, st, null);
		}
	}
}
