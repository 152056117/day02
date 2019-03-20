package servlet;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileUploadException;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;

import entity.P_Product;
import util.JDBCUtil;

/**
 * Servlet implementation class ChangeImgServlet
 */
public class ChangeImgServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public ChangeImgServlet() {
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
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	@SuppressWarnings("unchecked")
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// �õ��ϴ��ļ��ı���Ŀ¼�����ϴ����ļ������WEB-IFN�µ�upload��

		String savePath = getServletContext().getRealPath("/WEB-INF/upload");
		savePath = "D:";
		System.out.println(savePath);
		// ����洢��Ϣ�ı���
		String message = "�洢�ɹ�";

		File file = new File(savePath);
		if (!file.exists() && !file.isDirectory()) {
			System.out.println(savePath + "Ŀ¼�����ڣ���Ҫ����");
			// ����Ŀ¼
			file.mkdir();
		}
		// ʹ��Apache�ļ��ϴ���������ļ�
		// 1.����һ��DiskFiletemFactory
		DiskFileItemFactory factory = new DiskFileItemFactory();
		// 2.����һ���ļ��ϴ�������
		ServletFileUpload upload = new ServletFileUpload(factory);
		// 3 ����ϴ��ļ�������������
		upload.setHeaderEncoding("UTF-8");
		// 4 �ύ�����������Ƿ����ϴ���������
		if (!ServletFileUpload.isMultipartContent(request)) {
			// ���մ�ͳ��ʽ��ȡ����
			System.out.println("û���ϴ�������");
			message = "�洢ʧ��";
			return;
		}
		P_Product product = new P_Product();
		// 5.ʹ��servletFileupload�������ϴ�����,����������ص���һ��
		// List<FileItem> ���ϣ�ÿ��FileItem��Ӧһ��Form����������
		try {
			List<FileItem> list = upload.parseRequest(request);
			// ����list����
			for (FileItem fileItem : list) {
				if (fileItem.isFormField()) {
					String fileName = fileItem.getFieldName();
					// �����ͨ����� ���ݵ�������������
					String value = fileItem.getString("UTF-8");
					System.out.println(fileName + ":" + value);
				} else {// ���fileIteam�з�װ�����ϴ��ļ�
						// �õ��ϴ����ļ�����
					String fileName = fileItem.getName();
					System.out.println(fileName);
					if (fileName == null || fileName.trim().equals("")) {
						continue;
					}
					// �����ļ� ע�⣺��ͬ��������ύ���ļ����ǲ�һ����
					// ��Щ������ύ�ϵ��ļ����Ǵ�·����
					// �� c:/a/b/1.jpg
					// 1.jpg
					fileName = fileName.substring(fileName.lastIndexOf("\\") + 1);
					// ��ȡfileItem���ϴ���������
					InputStream in = fileItem.getInputStream();
					// ����һ���ļ������
					FileOutputStream out = new FileOutputStream(savePath + "\\" + fileName);
					// ����һ��������
					byte[] buffer = new byte[1024];
					// �ж��������������Ƿ��Ѿ�����
					int len = 0;
					// ѭ���������������뵽�������У�(len=in.read(buffer))>0��ʾ��������
					while ((len = in.read(buffer)) > 0) {
						// ʹ��FileOutputStream�����������������д�뵽ָ��Ŀ¼
						out.write(buffer, 0, len);
					}
					// �ر�������
					in.close();
					// �ر������
					out.close();
					// ɾ���ļ��ϴ�ʱ���ɵ���ʱ�ļ�
					fileItem.delete();
					product.setP_id(Integer.parseInt(request.getParameter("p_id")));
					product.setImg(fileName);
				}
			}
		} catch (FileUploadException e) {
			message = "�洢ʧ��";
			e.printStackTrace();
		}
		System.out.println(product);
		// ��ȡִ��sql����
		Statement st = JDBCUtil.getStatement();
		String sql = "update  p_product set img=" + "'" + product.getImg() + "'" + " where p_id=" + product.getP_id();
		System.out.println(sql);
		// ִ��sql
		try {
			st.executeUpdate(sql);
		} catch (SQLException e) {
			message = "�洢ʧ��";
			e.printStackTrace();
		}
		// �洢��Ϣ��ʾ
		request.setAttribute("message", message);
		response.sendRedirect("/day02/product/list.jsp");
		// ����������ת
		// request.getRequestDispatcher("../product/list.jsp").forward(request,
		// response);
	}
}
