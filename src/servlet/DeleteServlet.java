package servlet;

import java.io.IOException;
import java.sql.SQLException;
import java.sql.Statement;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import util.JDBCUtil;

/**
 * Servlet implementation class DeleteServlet
 */
public class DeleteServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		System.out.println("来了老弟：删除数据");
		
		int id = Integer.parseInt(request.getParameter("select_cust_id"));
		String sql = "delete from user where id = " + id;
		
		Statement st = JDBCUtil.getStatement();
		try {
			int i = st.executeUpdate(sql);
			if (i == 1) {
				System.out.println("数据删除成功，id：" + id);
			} else {
				System.out.println("数据删除失败，id：" + id);
			}
			request.getRequestDispatcher("../pages/user-list.jsp").forward(request, response);
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			JDBCUtil.closeAll(null, st, null);
		}
	}

}
