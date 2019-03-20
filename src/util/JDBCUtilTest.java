package util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

public class JDBCUtilTest {
	public static void main(String[] args) {
		try {
			//1.加载驱动
			Class.forName("com.mysql.jdbc.Driver");
			/*
			 * 2.获取链接对象
			 * 是java.sql.Connection
			 * getConnection(url,用户名，密码)
			 */
			Connection conn = DriverManager.getConnection(
					"jdbc:mysql://127.0.0.1:3306/blh_tlg", 
					"root",
					"root");
			//3.创建执行sql的对象
			Statement statement = conn.createStatement();
			String sql = "select * from user";
			//4.执行sql
			//statement.executeQuery(sql);
			//5.处理结果集resultset
			ResultSet rs = statement.executeQuery(sql);
			while (rs.next()) {
				/*
				 * 通过列数取值
				 */
				int id = rs.getInt(1);
				String username = rs.getString(2);
				String password = rs.getString(3);
				String mobile = rs.getString(4);
				String mailbox = rs.getString(5);
				System.out.print(id + " ");
				System.out.print(username + " ");
				System.out.print(password + " ");
				System.out.print(mobile + " ");
				System.out.println(mailbox + " ");
				/*
				 * 通过列名取值
				 */
				int id1 = rs.getInt("id");
				String username1 = rs.getString("username");
				String password1 = rs.getString("password");
				String mobile1 = rs.getString("mobile");
				String mailbox1 = rs.getString("mailbox");
				System.out.print(id1 + " ");
				System.out.print(username1 + " ");
				System.out.print(password1 + " ");
				System.out.print(mobile1 + " ");
				System.out.println(mailbox1 + " ");
			}
			//6.关闭连接
			rs.close();
			statement.close();
			conn.close();
		} catch (ClassNotFoundException e) {//多个catch块并列写时，异常类型要从小到大写
			e.printStackTrace();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
}
