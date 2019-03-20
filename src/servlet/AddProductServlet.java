package servlet;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.UnsupportedEncodingException;
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
 * Servlet implementation class AddProductServlet
 */
public class AddProductServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	@SuppressWarnings("unchecked")
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//����洢��ʾ��Ϣ�ı���
		String message = "�洢�ɹ�";
		
		//�õ��ϴ��ļ��ı���Ŀ¼�����ϴ����ļ���ŵ�WEB-INF�µ�libĿ¼��
		String savePath = getServletContext().getRealPath("/WEB-INF/upload");
		savePath = "D:";
		System.out.println(savePath);
		File file = new File(savePath);
		/*
		 * file.exists() �ļ��Ƿ����
		 * file.isDirectory() �ļ�����Ŀ¼�Ƿ����
		 */
		if (!file.exists() && !file.isDirectory()) {
			System.out.println("�ļ������ڣ��贴��");
			file.mkdir();//����Ŀ¼
		}
		
		//ʹ��Apache�ļ��ϴ���������ļ�
		//1.����һ��DiskFileItemFactory
		DiskFileItemFactory factory = new DiskFileItemFactory();
		//2.�����ļ��ϴ�������
		ServletFileUpload upload = new ServletFileUpload(factory);
		//3.���  �ϴ��ļ���  ��������������
		upload.setHeaderEncoding("UTF-8");
		//4.�ж��ύ�����������Ƿ񲻺���ý������
		if (!ServletFileUpload.isMultipartContent(request)) {
			//���մ�ͳ��ʽ��ȡ����
			System.out.println("û�ж�ý��");
			message = "�洢ʧ��";
			return ;
		}
		
		//����һ����Ʒ����
		P_Product product = new P_Product();
		
		//��������ִ���ˣ�˵���ж�ý���ļ�
		//5.ʹ��ServletFileUpload�������ϴ����ݣ�����������ص���һ��List����--List<FileItem>
		//ÿ��FileItem����һ��������
		try {
			List<FileItem> list = upload.parseRequest(request);
			for (FileItem fileItem : list) {
				//���fileItem�з�װ������ͨ����������,��������
				if (fileItem.isFormField()) {
					setProductFromItem(fileItem, product);
				} else {//fileItem�з�װ�����ϴ����ļ�
					//�õ��ϴ����ļ�����
					String fileName = fileItem.getName();
					if (fileName == null || fileName.trim().equals("")) {//��ȡ�����ļ���Ϊ�գ���������ѭ��
						continue;
					}
					/*
					 * �����ļ�
					 * ע�⣺��ͬ��������ύ���ļ����ǲ�һ����
					 * ��Щ������ύ�������ļ����Ǵ�·����
					 *     �磺C:\a\b\1.jpg  ��·��
					 *        1.jpg         ����·��
					 * ����ʱӦ��ȫ·����ǰ��ȥ����ֻ���²���·�����ļ����������һ��\��ߵĴ�
					 *     Str.lastIndexOf("\\");//ȡ�������һ��\������ֵ,�˴���\Ϊת��
					 *     Str.substring(a,b);//��ȡ��Χ����ҿ�
					 *     
					 * ������ɺ󣬻�ȡ���������ӿͻ��˷�������������������������������ӳ������������浽���������أ�
					 */
					fileName = fileName.substring(fileName.lastIndexOf("\\") + 1);
					//��ȡfileItem���ϴ���������
					InputStream in = fileItem.getInputStream();
					//����һ���ļ������
					FileOutputStream os = new FileOutputStream(savePath + "\\" + fileName);
					//��������������ʼд�������
					byte[] buffer = new byte[1024];//һ�ζ�1KB
					/*
					 * �ж��������������Ƿ��Ѿ�����
					 * ѭ���������������������У�(len=in.read(buffer)) > 0��ʾin�л�������
					 */
					int len = 0;
					while((len=in.read(buffer)) > 0) {//len--���ζ�ȡ�����ֽ���
						//ʹ�������������������д�뵽ָ��Ŀ¼
						os.write(buffer, 0, len);
					}
					//�ر�������
					in.close();
					os.close();
					//ɾ���ļ��ϴ�ʱ���ɵ���ʱ�ļ�
					fileItem.delete();
					
					product.setImg(fileName);
				}
			}
		} catch (FileUploadException e) {
			e.printStackTrace();
			message = "�洢ʧ��";
		}
		System.out.println(product.toString());
		
		//ִ�б���
		saveProduct(product, message);
		//�洢��Ϣ��ʾ
		request.setAttribute("message", message);
		//����������ת����������
		//request.getRequestDispatcher("../product/add_product_success.jsp").forward(request, response);
		request.getRequestDispatcher("../product/list.jsp").forward(request, response);
	}

	/**
	 * ����������
	 * @param product
	 * @param message 
	 */
	private void saveProduct(P_Product product, String message) {
		Statement st = JDBCUtil.getStatement();
		String sql = "insert into p_product(p_name,price,num,disc,discount,img,t_id) values('" 
				+ product.getP_name() + "',"
				+ product.getPrice() + ","
				+ product.getNum() + ",'"
				+ product.getDisc() + "',"
				+ product.getDiscount() + ",'"
				+ product.getImg() + "',"
				+ product.getT_id() + ")";
		System.out.println(sql);
		try {
			st.executeUpdate(sql);
		} catch (SQLException e) {
			e.printStackTrace();
			message = "�洢ʧ��";
		} finally {
			JDBCUtil.closeAll(null, st, null);
		}
	}

	/**
	 * ����������
	 * @param fileItem
	 * @param product
	 * @throws UnsupportedEncodingException
	 */
	private void setProductFromItem(FileItem fileItem, P_Product product) throws UnsupportedEncodingException {
		String fileName = fileItem.getFieldName();
		//�����ͨ����������ݵ�������������
		String value = fileItem.getString("UTF-8");
		if ("name".equals(fileName)) {
			product.setP_name(value);
		} else if ("price".equals(fileName)) {
			product.setPrice(Double.parseDouble(value));
		} else if ("num".equals(fileName)) {
			product.setNum(Integer.parseInt(value));
		} else if ("disc".equals(fileName)) {
			product.setDisc(value);
		} else if ("discount".equals(fileName)) {
			product.setDiscount(Double.parseDouble(value));
		} else if ("cid".equals(fileName)) {
			product.setT_id(Integer.parseInt(value));
		}
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}
}
