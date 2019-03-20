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
 * Servlet implementation class UpdateServlet
 */
public class UpdateServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		System.out.println("来了老弟：修改数据");
		
		User user = new User();
		user.setId(Integer.parseInt(request.getParameter("id")));
		user.setUsername(request.getParameter("username"));
		user.setPassword(request.getParameter("password"));
		user.setMobile(request.getParameter("mobile"));
		user.setMailbox(request.getParameter("mailbox"));
		user.setSex(Integer.parseInt(request.getParameter("sex")));
		
		String sql = "update user set " + 
				"username='" + user.getUsername() + "'," + 
				"password='" + user.getPassword() + "'," + 
				"mobile='" + user.getMobile() + "'," + 
				"mailbox='" + user.getMailbox() + "'," + 
				"sex=" + user.getSex() + " where id = " + user.getId();
		System.out.println(sql);
		
		Statement st = JDBCUtil.getStatement();
		try {
			int i = st.executeUpdate(sql);
			if (i == 1) {
				System.out.println("数据修改成功，id：" + user.getId());
				request.getRequestDispatcher("../pages/user-list.jsp").forward(request, response);
			} else {
				System.out.println("数据修改失败，id：" + user.getId());
				request.getRequestDispatcher("../pages/user_modify.jsp").forward(request, response);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			JDBCUtil.closeAll(null, st, null);
		}
	}
}
