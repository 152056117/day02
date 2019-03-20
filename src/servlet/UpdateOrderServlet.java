package servlet;

import java.io.IOException;
import java.sql.SQLException;
import java.sql.Statement;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import entity.Order;
import util.JDBCUtil;

/**
 * Servlet implementation class UpdateOrderServlet
 */
public class UpdateOrderServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public UpdateOrderServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		request.setCharacterEncoding("UTF-8");
		int newstatus = Integer.parseInt(request.getParameter("optionsRadios"));
		int oldstatus = Integer.parseInt(request.getParameter("old-status"));
		int oid = Integer.parseInt(request.getParameter("o_id"));
		System.out.println("¸üÐÂ£º" + oid + "--" + newstatus + "--" + oldstatus);
		
		if (newstatus != oldstatus) {
			Statement st = JDBCUtil.getStatement();
			String sql;
			if (newstatus == 4) {
				Order order = new Order();
				order.setDestoryTime();
				sql = "update usersorder set o_status=" + newstatus + ",destorytime='" + order.getDestoryTime() + "' where o_id=" + oid;
			} else {
				sql = "update usersorder set o_status=" + newstatus + " where o_id=" + oid;
			}
			try {
				st.executeUpdate(sql);
			} catch (SQLException e) {
				e.printStackTrace();
			} finally {
				JDBCUtil.closeAll(null, st, null);
			}
		}
		
		request.getRequestDispatcher("../order/order-list.jsp").forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
