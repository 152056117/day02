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
		// 得到上传文件的保存目录，将上传的文件存放于WEB-IFN下的upload中

		String savePath = getServletContext().getRealPath("/WEB-INF/upload");
		savePath = "D:";
		System.out.println(savePath);
		// 定义存储消息的变量
		String message = "存储成功";

		File file = new File(savePath);
		if (!file.exists() && !file.isDirectory()) {
			System.out.println(savePath + "目录不存在，需要创建");
			// 创建目录
			file.mkdir();
		}
		// 使用Apache文件上传组件处理文件
		// 1.创建一个DiskFiletemFactory
		DiskFileItemFactory factory = new DiskFileItemFactory();
		// 2.创建一个文件上传解析器
		ServletFileUpload upload = new ServletFileUpload(factory);
		// 3 解决上传文件名的中文乱码
		upload.setHeaderEncoding("UTF-8");
		// 4 提交上来的数据是否是上传表单的数据
		if (!ServletFileUpload.isMultipartContent(request)) {
			// 按照传统方式获取数据
			System.out.println("没有上传表单数据");
			message = "存储失败";
			return;
		}
		P_Product product = new P_Product();
		// 5.使用servletFileupload解析器上传数据,解析结果返回的是一个
		// List<FileItem> 集合，每个FileItem对应一个Form表单的输入项
		try {
			List<FileItem> list = upload.parseRequest(request);
			// 遍历list对象
			for (FileItem fileItem : list) {
				if (fileItem.isFormField()) {
					String fileName = fileItem.getFieldName();
					// 解决普通输入的 数据的中文乱码问题
					String value = fileItem.getString("UTF-8");
					System.out.println(fileName + ":" + value);
				} else {// 如果fileIteam中封装的是上传文件
						// 得到上传的文件名称
					String fileName = fileItem.getName();
					System.out.println(fileName);
					if (fileName == null || fileName.trim().equals("")) {
						continue;
					}
					// 处理文件 注意：不同的浏览器提交的文件名是不一样的
					// 有些浏览器提交上的文件名是带路径的
					// 如 c:/a/b/1.jpg
					// 1.jpg
					fileName = fileName.substring(fileName.lastIndexOf("\\") + 1);
					// 获取fileItem中上传的输入流
					InputStream in = fileItem.getInputStream();
					// 创建一个文件输出流
					FileOutputStream out = new FileOutputStream(savePath + "\\" + fileName);
					// 创建一个缓冲区
					byte[] buffer = new byte[1024];
					// 判断输入流中数据是否已经读完
					int len = 0;
					// 循环，将输入流读入到缓冲区中，(len=in.read(buffer))>0表示还有数据
					while ((len = in.read(buffer)) > 0) {
						// 使用FileOutputStream输出流将缓冲区数据写入到指定目录
						out.write(buffer, 0, len);
					}
					// 关闭输入流
					in.close();
					// 关闭输出流
					out.close();
					// 删除文件上传时生成的临时文件
					fileItem.delete();
					product.setP_id(Integer.parseInt(request.getParameter("p_id")));
					product.setImg(fileName);
				}
			}
		} catch (FileUploadException e) {
			message = "存储失败";
			e.printStackTrace();
		}
		System.out.println(product);
		// 获取执行sql对象
		Statement st = JDBCUtil.getStatement();
		String sql = "update  p_product set img=" + "'" + product.getImg() + "'" + " where p_id=" + product.getP_id();
		System.out.println(sql);
		// 执行sql
		try {
			st.executeUpdate(sql);
		} catch (SQLException e) {
			message = "存储失败";
			e.printStackTrace();
		}
		// 存储消息提示
		request.setAttribute("message", message);
		response.sendRedirect("/day02/product/list.jsp");
		// 服务器端跳转
		// request.getRequestDispatcher("../product/list.jsp").forward(request,
		// response);
	}
}
