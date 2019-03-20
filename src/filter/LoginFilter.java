package filter;

import java.io.IOException;
import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * Servlet Filter implementation class LoginFilter
 */
public class LoginFilter implements Filter {
	private String initParam = null;

	/**
	 * Default constructor.
	 */
	public LoginFilter() {
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see Filter#destroy()
	 */
	public void destroy() {
		// TODO Auto-generated method stub
	}

	/**
	 * @see Filter#doFilter(ServletRequest, ServletResponse, FilterChain)
	 */
	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
			throws IOException, ServletException {
		// TODO Auto-generated method stub
		// place your code here
		HttpServletRequest req = (HttpServletRequest) request;
		HttpServletResponse resp = (HttpServletResponse) response;
		HttpSession sission = req.getSession();
		Object o = sission.getAttribute("username");
		// String s = (String) sission.getAttribute("username");//向下转型
		
		//System.out.println("过滤器：LoginFilter:" + req.getRequestURI());
		
		//获取请求路径
		String path = req.getRequestURI();
		
		if (initParam.contains(path) || o != null) {//已经登录或是此页为登陆页
			// System.out.println(s);
			chain.doFilter(request, response);// 继续向后请求--允许通过过滤
		} else {
			resp.sendRedirect("/day02/pages/no_login.jsp");
		}
	}

	/**
	 * @see Filter#init(FilterConfig)
	 */
	public void init(FilterConfig fConfig) throws ServletException {
		// TODO Auto-generated method stub
		System.out.println("忽略过滤页面：" + fConfig.getInitParameter("ignore"));
		initParam = fConfig.getInitParameter("ignore");
	}
}
