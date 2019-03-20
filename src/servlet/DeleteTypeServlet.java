package servlet;

import java.io.IOException;
import java.net.URLDecoder;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import util.JDBCUtil;

/**
 * Servlet implementation class DeleteTypeServlet
 */
public class DeleteTypeServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public DeleteTypeServlet() {
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
		// response.getWriter().append("Served at: ").append(request.getContextPath());
		doPost(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		// doGet(request, response);

		request.setCharacterEncoding("UTF-8");
		String t_name = request.getParameter("t_name");
		t_name = URLDecoder.decode(t_name, "UTF-8");
		int t_id = Integer.parseInt(request.getParameter("t_id"));
		int i = Integer.parseInt(request.getParameter("i"));
		String sql = null;
		//System.out.println(t_id);
		//System.out.println(t_name);
		//System.out.println(i);
		sql = "select * from p_type where t_name=" + "'" + t_name + "'";
		if (i == 1) {
			Statement st1 = JDBCUtil.getStatement();
			try {
				ResultSet rs = st1.executeQuery(sql);
				if (rs.next()) {// 如果存在返回失败：
					response.getWriter().write("fail");
				} else {
					sql = "update p_type  set t_name=" + "'" + t_name + "' where t_id=" + t_id;
				    Statement st=JDBCUtil.getStatement();
					int count=st.executeUpdate(sql);  
				    if(count==1) {
				    	response.getWriter().write("success");
				    }else {
				    	response.getWriter().write("fail");
				    }
				
				}

			} catch (SQLException e1) {
				response.getWriter().write("fail");
				// TODO Auto-generated catch block
				e1.printStackTrace();
			}

		} else {
			sql="select * from p_product where t_id="+t_id;
			Statement st2 = JDBCUtil.getStatement();
			ResultSet rs;
			try {
				rs = st2.executeQuery(sql);
				if(rs.next()) {//如果他有数据返回fail
					
					response.getWriter().write("fail");
				}else {//没有数据才可以删除：
					sql = "delete from p_type where t_id=" + request.getParameter("t_id");
					System.out.println(sql);

					Statement st = JDBCUtil.getStatement();
					try {
						int count = st.executeUpdate(sql);
						System.out.println(count);
						JDBCUtil.closeAll(null, st, null);
						if (count == 1) {
							response.getWriter().write("success");
							// response.sendRedirect("../type/listtype.jsp");
						} else {
							response.getWriter().write("fail");
						}

					} catch (SQLException e) {
						// TODO Auto-generated catch block
						response.getWriter().write("fail");
						e.printStackTrace();
						
					}	
				}
			} catch (SQLException e1) {
				// TODO Auto-generated catch block
				response.getWriter().write("fail");
				e1.printStackTrace();
			}
			
			
			
		}
		
	}

}
