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
		//定义存储提示消息的变量
		String message = "存储成功";
		
		//得到上传文件的保存目录，将上传的文件存放到WEB-INF下的lib目录中
		String savePath = getServletContext().getRealPath("/WEB-INF/upload");
		savePath = "D:";
		System.out.println(savePath);
		File file = new File(savePath);
		/*
		 * file.exists() 文件是否存在
		 * file.isDirectory() 文件所在目录是否存在
		 */
		if (!file.exists() && !file.isDirectory()) {
			System.out.println("文件不存在，需创建");
			file.mkdir();//创建目录
		}
		
		//使用Apache文件上传组件处理文件
		//1.创建一个DiskFileItemFactory
		DiskFileItemFactory factory = new DiskFileItemFactory();
		//2.创建文件上传解析器
		ServletFileUpload upload = new ServletFileUpload(factory);
		//3.解决  上传文件名  的中文乱码问题
		upload.setHeaderEncoding("UTF-8");
		//4.判断提交上来的数据是否不含多媒体数据
		if (!ServletFileUpload.isMultipartContent(request)) {
			//按照传统方式获取数据
			System.out.println("没有多媒体");
			message = "存储失败";
			return ;
		}
		
		//创建一个产品对象
		P_Product product = new P_Product();
		
		//继续下来执行了，说明有多媒体文件
		//5.使用ServletFileUpload解析器上传数据，解析结果返回的是一个List对象--List<FileItem>
		//每个FileItem代表一个表单对象
		try {
			List<FileItem> list = upload.parseRequest(request);
			for (FileItem fileItem : list) {
				//如果fileItem中封装的是普通输入项数据,正常处理
				if (fileItem.isFormField()) {
					setProductFromItem(fileItem, product);
				} else {//fileItem中封装的是上传的文件
					//得到上传的文件名称
					String fileName = fileItem.getName();
					if (fileName == null || fileName.trim().equals("")) {//获取到的文件名为空，跳出本次循环
						continue;
					}
					/*
					 * 处理文件
					 * 注意：不同的浏览器提交的文件名是不一样的
					 * 有些浏览器提交上来的文件名是带路径的
					 *     如：C:\a\b\1.jpg  带路径
					 *        1.jpg         不带路径
					 * 处理时应把全路径的前部去掉，只留下不带路径的文件名，即最后一个\后边的串
					 *     Str.lastIndexOf("\\");//取串中最后一个\的索引值,此处左\为转义
					 *     Str.substring(a,b);//截取范围左闭右开
					 *     
					 * 处理完成后，获取输入流（从客户端发出，往程序中流），创建输出流（从程序流出，保存到服务器本地）
					 */
					fileName = fileName.substring(fileName.lastIndexOf("\\") + 1);
					//获取fileItem中上传的输入流
					InputStream in = fileItem.getInputStream();
					//创建一个文件输出流
					FileOutputStream os = new FileOutputStream(savePath + "\\" + fileName);
					//创建缓冲区，开始写入输出流
					byte[] buffer = new byte[1024];//一次读1KB
					/*
					 * 判断输入流中数据是否已经读完
					 * 循环将输入流读到缓冲区中，(len=in.read(buffer)) > 0表示in中还有数据
					 */
					int len = 0;
					while((len=in.read(buffer)) > 0) {//len--本次读取到的字节数
						//使用输出流将缓冲区数据写入到指定目录
						os.write(buffer, 0, len);
					}
					//关闭输入流
					in.close();
					os.close();
					//删除文件上传时生成的临时文件
					fileItem.delete();
					
					product.setImg(fileName);
				}
			}
		} catch (FileUploadException e) {
			e.printStackTrace();
			message = "存储失败";
		}
		System.out.println(product.toString());
		
		//执行保存
		saveProduct(product, message);
		//存储消息提示
		request.setAttribute("message", message);
		//服务器端跳转，传递数据
		//request.getRequestDispatcher("../product/add_product_success.jsp").forward(request, response);
		request.getRequestDispatcher("../product/list.jsp").forward(request, response);
	}

	/**
	 * 功能如其名
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
			message = "存储失败";
		} finally {
			JDBCUtil.closeAll(null, st, null);
		}
	}

	/**
	 * 功能如其名
	 * @param fileItem
	 * @param product
	 * @throws UnsupportedEncodingException
	 */
	private void setProductFromItem(FileItem fileItem, P_Product product) throws UnsupportedEncodingException {
		String fileName = fileItem.getFieldName();
		//解决普通输入项的数据的中文乱码问题
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
