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
 * Servlet implementation class AddTypeServlet
 */
public class AddTypeServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public AddTypeServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		//doGet(request, response);
		request.setCharacterEncoding("UTF-8");
		String t_name=request.getParameter("t_name");
		t_name = URLDecoder.decode(t_name, "UTF-8");
		String sql = null;
		Statement st1=JDBCUtil.getStatement();
		sql = "select * from p_type where t_name="+"'"+t_name+"'";
		System.out.println(sql);
		try {
			ResultSet rs = st1.executeQuery(sql);
			if(rs.next()) {//´æÔÚ
				response.getWriter().write("fail");
			}else{//²»´æÔÚ
				sql="insert into p_type(t_name)"+"value('"+t_name+"')";
				 try {
				    	Statement st=JDBCUtil.getStatement();
//						int count=
								st.executeUpdate(sql);
						JDBCUtil.closeAll(null, st, null);
						response.getWriter().write("success");
						//request.getRequestDispatcher("../type/addtype.jsp").forward(request, response);
					} catch (SQLException e) {
						//TODO Auto-generated catch block
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
