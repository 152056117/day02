package servlet;

import java.awt.Color;
import java.awt.Font;
import java.awt.Graphics;
import java.awt.image.BufferedImage;
import java.io.IOException;
import java.io.OutputStream;
import java.util.Random;

import javax.imageio.ImageIO;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * Servlet implementation class ValidateCode
 * 在service中实现二维码产生与返回
 */
public class ValidateCode extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	private static final int[] fontStyles = { 0, 1, 2, 3 };
	private static final int[] fontSize = { 22, 23, 24, 25 };
	
	private Random r = new Random();
       
	/**
	 * 得到随机字符串
	 * @param size 得到多少个字符
	 * @return
	 */
	private String getNumber(int size) {
		//可以产生的随机字符
		String str = "ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";
		Random r = new Random();
		//记录随机生成的字符串
		String number = "";
		for (int i = 0; i < size; i++) {
			number += str.charAt(r.nextInt(str.length()));
		}
		return number;
	}
	
	@Override
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//创建一张空白图片
		BufferedImage image = new BufferedImage(90, 40, BufferedImage.TYPE_INT_RGB);
		//获取图片画笔
		Graphics g = image.getGraphics();
		//调用自定义方法得到随机数
		String number = getNumber(5);
		System.out.println("生成的随机数：" + number);
		
		//存储
		//将生成的随机数存储到session中，session -- 一次会话中一直存在
		HttpSession session = request.getSession();
		session.setAttribute("verifyCode", number);
		
		//画图片
		draw(g, number);
		
		//输出
		//设置输出流内容格式为图片格式
		response.setContentType("image/jpeg");
		//获取输出流
		OutputStream ops = response.getOutputStream();
		//将图片写入到输出流中      .write(源图片, 图片写出格式, 输出流对象)
		ImageIO.write(image, "jpeg", ops);
		//关闭输出流
		ops.close();
	}

	//画图片
	private void draw(Graphics g, String number) {
		g.setColor(getColor());// 画笔颜色
		g.fillRect(0, 0, 90, 42);// 画背景
		for (int i = 0; i < number.length(); ++i) {
			g.setFont(getFont());
			g.setColor(getColor());// 画笔颜色
			g.drawString(number.substring(i, i + 1), 8 + i * 17, 30);// 画字符串
		}
		
		//绘制8条干扰线
		for (int i = 0; i < 8; i++) {
			g.setColor(getColor());//设置颜色
			g.drawLine(r.nextInt(90), r.nextInt(42), r.nextInt(90), r.nextInt(42));
		}
	}

	//随机颜色
	private Color getColor() {
		return new Color(r.nextInt(255), r.nextInt(255), r.nextInt(255));
	}
	
	//随机字体
	private Font getFont() {
		Font font = null;
		int style = fontStyles[r.nextInt(fontStyles.length)];
		int size = fontSize[r.nextInt(fontSize.length)];
		font = new Font(null, style, size);
		return font;
	}
}
