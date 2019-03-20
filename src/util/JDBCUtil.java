package util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

public class JDBCUtil {
	/*
	 * static���Σ��౻����ʱ����ִ�С�������ʵ������һ����������ʡ�洢�ռ�
	 * ��̬��������౻����ʱִ�У�������������ִ�У����ڽ���ʱ�������п�ʼ
	 * ��̬��������ֱ��������.���������ã��������
	 * ��̬����\��̬�����ֻ��ʹ�þ�̬����
	 * static final����Ϊ��������ʵ������һ�������Ҳ����޸�
	 */
	//�������·��
	private static final String DREVER = "com.mysql.jdbc.Driver";
	//���ݿ��ַ
	private static final String URL = "jdbc:mysql://127.0.0.1:3306/blh_tlg";
	//�û���
	private static final String USER = "root";
	//����
	private static final String PASSWORD = "123456";
	
	//���ݿ����Ӷ���
	private static Connection conn = null;
	//ִ��sql���Ķ���
	private static Statement statement = null;
	
	static {
		try {
			//1.��������
			Class.forName(DREVER);
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		}
	}
	
	/**
	 * ��ȡ���ݿ����ӵķ���
	 * @return
	 */
	public static Connection getConn() {
		//��ȡ���ݿ�����
		try {
			conn = DriverManager.getConnection(URL, USER, PASSWORD);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return conn;
	}
	
	/**
	 * ���ִ��sql�Ķ���
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
	 * �ر�����
	 * ���ʹ��finallyȷ��һ���ر�ʧ���˲�Ӱ��������Դ�Ĺر�
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
