package servlet;

import java.io.IOException;
import java.sql.SQLException;
import java.sql.Statement;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import entity.P_Product;
import util.JDBCUtil;

/**
 * Servlet implementation class DeleteProductServlet
 */
public class DeleteProductServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public DeleteProductServlet() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		request.setCharacterEncoding("UTF-8");
		P_Product p = new P_Product();
		p.setP_id(Integer.parseInt(request.getParameter("did")));
		String sql = "";
		Statement st = null;
		try {
			sql = "delete from p_product where p_id= " + p.getP_id();
			st = JDBCUtil.getStatement();
			int count = st.executeUpdate(sql);
			JDBCUtil.closeAll(null, st, null);
			if (count > 0) {
				System.out.println("É¾³ý³É¹¦:" + sql);
			} else {
				System.out.println("É¾³ýÊ§°Ü:" + sql);
			}
			request.getRequestDispatcher("../product/list.jsp").forward(request, response);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			System.out.println("É¾³ýÊ§°Ü:" + sql);
			request.getRequestDispatcher("../product/list.jsp").forward(request, response);
		}
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}
}
