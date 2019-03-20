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
 * Servlet implementation class ModifyProductServlet
 */
public class ModifyProductServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ModifyProductServlet() {
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
	
		request.setCharacterEncoding("UTF-8");
		P_Product mp=new P_Product();
		
		mp.setP_id(Integer.parseInt(request.getParameter("p_id")));
		
		mp.setP_name(request.getParameter("p_name"));
		System.out.println(request.getParameter("price"));
		mp.setPrice(Double.parseDouble(request.getParameter("price")));
		
		mp.setTotal(Integer.parseInt(request.getParameter("total")));
		mp.setNum(Integer.parseInt(request.getParameter("num")));
		mp.setDisc(request.getParameter("disc"));
		mp.setDiscount(Double.parseDouble(request.getParameter("discount")));
		mp.setImg(request.getParameter("img"));
		mp.setStatus(Integer.parseInt(request.getParameter("status")));
		mp.setT_id(Integer.parseInt(request.getParameter("t_id")));
		
	
		String sql="update p_product set p_name="+"'"+mp.getP_name()+"',price="+mp.getPrice()+",total="+mp.getTotal()+",num="+mp.getNum()+",disc="+"'"+mp.getDisc()+"'"+",discount="+mp.getDiscount()+",status="+mp.getStatus()+",t_id="+mp.getT_id()+" where p_id="+mp.getP_id();
		System.out.println(sql);
		Statement st=JDBCUtil.getStatement();
		
	    int count=0;
	    System.out.println(sql);
	    try {
			 count=st.executeUpdate(sql);
			
			 JDBCUtil.closeAll(null, st, null);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	    if(count>=1)
	    {
	    	request.getRequestDispatcher("../product/list.jsp").forward(request, response);
	        return ;
	    }
	    else{
	    	System.out.println("Êý¾ÝÐÞ¸ÄÊ§°Ü");
	    	return ;
	    }
	}
}
