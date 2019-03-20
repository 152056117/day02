package servlet;

import java.io.IOException;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.text.SimpleDateFormat;
import java.util.Date;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import util.JDBCUtil;

/**
 * Servlet implementation class SolveOrderServlet
 */
public class SolveOrderServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public SolveOrderServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		request.setCharacterEncoding("UTF-8");
		int oid = Integer.parseInt(request.getParameter("oid"));
		System.out.println("处理：" + oid);
		
		Statement st = JDBCUtil.getStatement();
		String sql = "select usersorder.*,o_status.o_name ostatus,p_product.*,user.* "
				+ "from usersorder,o_status,p_product,user "
				+ "where usersorder.o_status=o_status.o_id "
				+ "and usersorder.p_id=p_product.p_id "
				+ "and usersorder.u_id=user.id "
				+ " and usersorder.o_id=" + oid;
		System.out.println(sql);
		ResultSet rs = null;
		try {
			rs = st.executeQuery(sql);
			if (rs.next()) {
				SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
				request.setAttribute("nowtime", sdf.format(new Date()));
				request.setAttribute("o_id", rs.getInt("o_id"));
				request.setAttribute("u_name", rs.getString("username"));
				request.setAttribute("u_address", rs.getString("mailbox"));//没有写地址，拿邮箱顶一顶先
				request.setAttribute("u_mobile", rs.getString("mobile"));
				request.setAttribute("o_createtime", rs.getString("createtime"));
				request.setAttribute("o_destorytime", rs.getString("destorytime"));
				request.setAttribute("status", rs.getString("ostatus"));
				request.setAttribute("o_status", rs.getString("o_status"));
				request.setAttribute("o_num", rs.getInt("p_num"));
				request.setAttribute("p_name", rs.getString("p_name"));
				request.setAttribute("p_id", rs.getInt("p_id"));
				request.setAttribute("p_disc", rs.getString("disc"));
				request.setAttribute("p_price", rs.getDouble("price"));
				request.setAttribute("o_totalprice", rs.getInt("p_num") * rs.getDouble("price"));
				
				request.getRequestDispatcher("../order/order-process.jsp").forward(request, response);
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			JDBCUtil.closeAll(rs, st, null);
		}
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
