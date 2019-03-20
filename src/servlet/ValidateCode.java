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
 * ��service��ʵ�ֶ�ά������뷵��
 */
public class ValidateCode extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	private static final int[] fontStyles = { 0, 1, 2, 3 };
	private static final int[] fontSize = { 22, 23, 24, 25 };
	
	private Random r = new Random();
       
	/**
	 * �õ�����ַ���
	 * @param size �õ����ٸ��ַ�
	 * @return
	 */
	private String getNumber(int size) {
		//���Բ���������ַ�
		String str = "ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";
		Random r = new Random();
		//��¼������ɵ��ַ���
		String number = "";
		for (int i = 0; i < size; i++) {
			number += str.charAt(r.nextInt(str.length()));
		}
		return number;
	}
	
	@Override
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//����һ�ſհ�ͼƬ
		BufferedImage image = new BufferedImage(90, 40, BufferedImage.TYPE_INT_RGB);
		//��ȡͼƬ����
		Graphics g = image.getGraphics();
		//�����Զ��巽���õ������
		String number = getNumber(5);
		System.out.println("���ɵ��������" + number);
		
		//�洢
		//�����ɵ�������洢��session�У�session -- һ�λỰ��һֱ����
		HttpSession session = request.getSession();
		session.setAttribute("verifyCode", number);
		
		//��ͼƬ
		draw(g, number);
		
		//���
		//������������ݸ�ʽΪͼƬ��ʽ
		response.setContentType("image/jpeg");
		//��ȡ�����
		OutputStream ops = response.getOutputStream();
		//��ͼƬд�뵽�������      .write(ԴͼƬ, ͼƬд����ʽ, ���������)
		ImageIO.write(image, "jpeg", ops);
		//�ر������
		ops.close();
	}

	//��ͼƬ
	private void draw(Graphics g, String number) {
		g.setColor(getColor());// ������ɫ
		g.fillRect(0, 0, 90, 42);// ������
		for (int i = 0; i < number.length(); ++i) {
			g.setFont(getFont());
			g.setColor(getColor());// ������ɫ
			g.drawString(number.substring(i, i + 1), 8 + i * 17, 30);// ���ַ���
		}
		
		//����8��������
		for (int i = 0; i < 8; i++) {
			g.setColor(getColor());//������ɫ
			g.drawLine(r.nextInt(90), r.nextInt(42), r.nextInt(90), r.nextInt(42));
		}
	}

	//�����ɫ
	private Color getColor() {
		return new Color(r.nextInt(255), r.nextInt(255), r.nextInt(255));
	}
	
	//�������
	private Font getFont() {
		Font font = null;
		int style = fontStyles[r.nextInt(fontStyles.length)];
		int size = fontSize[r.nextInt(fontSize.length)];
		font = new Font(null, style, size);
		return font;
	}
}
