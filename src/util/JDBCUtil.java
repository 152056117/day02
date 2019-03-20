package util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

public class JDBCUtil {
	/*
	 * static修饰，类被加载时加载执行。所有类实例共用一个变量，节省存储空间
	 * 静态代码块在类被加载时执行，先于主函数被执行，便于将耗时操作先行开始
	 * 静态方法可以直接用类名.方法名调用，方便调用
	 * 静态方法\静态代码块只能使用静态变量
	 * static final修饰为常量，类实例共用一个变量且不可修改
	 */
	//驱动类的路径
	private static final String DREVER = "com.mysql.jdbc.Driver";
	//数据库地址
	private static final String URL = "jdbc:mysql://127.0.0.1:3306/blh_tlg";
	//用户名
	private static final String USER = "root";
	//密码
	private static final String PASSWORD = "123456";
	
	//数据库连接对象
	private static Connection conn = null;
	//执行sql语句的对象
	private static Statement statement = null;
	
	static {
		try {
			//1.加载驱动
			Class.forName(DREVER);
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		}
	}
	
	/**
	 * 获取数据库连接的方法
	 * @return
	 */
	public static Connection getConn() {
		//获取数据库连接
		try {
			conn = DriverManager.getConnection(URL, USER, PASSWORD);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return conn;
	}
	
	/**
	 * 获得执行sql的对象
	 * @return
	 */
	public static Statement getStatement() {
		try {
			statement = getConn().createStatement();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return statement;
	}
	
	/**
	 * 关闭连接
	 * 多次使用finally确保一个关闭失败了不影响其他资源的关闭
	 * @param rs
	 * @param st
	 * @param conn
	 */
	public static void closeAll(ResultSet rs, Statement st, Connection conn) {
		try {
			if (rs != null) 
				rs.close();
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			try {
				if (st != null)
					st.close();
			} catch (SQLException e) {
				e.printStackTrace();
			} finally {
				try {
					if (conn != null)
						conn.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}
		}
	}
	
	public static void main(String[] args) {
		System.out.println(JDBCUtil.getStatement());
	}
}
