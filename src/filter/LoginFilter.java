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
		// String s = (String) sission.getAttribute("username");//����ת��
		
		//System.out.println("��������LoginFilter:" + req.getRequestURI());
		
		//��ȡ����·��
		String path = req.getRequestURI();
		
		if (initParam.contains(path) || o != null) {//�Ѿ���¼���Ǵ�ҳΪ��½ҳ
			// System.out.println(s);
			chain.doFilter(request, response);// �����������--����ͨ������
		} else {
			resp.sendRedirect("/day02/pages/no_login.jsp");
		}
	}

	/**
	 * @see Filter#init(FilterConfig)
	 */
	public void init(FilterConfig fConfig) throws ServletException {
		// TODO Auto-generated method stub
		System.out.println("���Թ���ҳ�棺" + fConfig.getInitParameter("ignore"));
		initParam = fConfig.getInitParameter("ignore");
	}
}
