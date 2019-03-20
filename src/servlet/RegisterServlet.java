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
 * Servlet implementation class RegisterServlet
 */
public class RegisterServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		
		User user = new User();
		user.setUsername(request.getParameter("username"));
		user.setPassword(request.getParameter("password"));
		user.setMobile(request.getParameter("mobile"));
		user.setMailbox(request.getParameter("mailbox"));
		System.out.println(user.toString());
		
		String sql = "insert into user(username,password,mobile,mailbox,sex) values('"
				+ user.getUsername() + "','"
				+ user.getPassword() + "','"
				+ user.getMobile() + "','"
				+ user.getMailbox() + "',0)";
		Statement st = JDBCUtil.getStatement();
		try {
			int i = st.executeUpdate(sql);
			if (i == 1) {
				System.out.println("success");
				request.getRequestDispatcher("../pages/user_register_success.jsp").forward(request, response);
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			JDBCUtil.closeAll(null, st, null);
		}
	}

}
