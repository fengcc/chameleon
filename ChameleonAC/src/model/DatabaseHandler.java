package model;

import java.sql.PreparedStatement;
import java.sql.ResultSet;

import com.mysql.jdbc.Connection;

public class DatabaseHandler {
	private Connection conn = null;
	private PreparedStatement ps = null;
	private ResultSet rs = null;
	private DatabaseUtil DBUtil = new DatabaseUtil();
	
	public int insert(String ssid, String mac, String psw) {
		int result = 0;
		String record = select(mac);
		
		if (record == null) {
			String sql = "insert into account (ssid, mac, psw) values (?, ?, ?)";
			try {
				conn = (Connection)DBUtil.getConnection();
				ps = conn.prepareStatement(sql);
				ps.setString(1, ssid);
				ps.setString(2, mac);
				ps.setString(3, psw);
				result = ps.executeUpdate();
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				closeAll();
			}
		}
		return result;
	}
	
	public int delete(String mac) {
		int result = 0;
		String sql = "delete from account where mac = ?";
		
		try {
			conn = (Connection)DBUtil.getConnection();
			ps = conn.prepareStatement(sql);
			ps.setString(1, mac);
			result = ps.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			closeAll();
		}
		return result;
	}
	
	public int update(String mac, String psw) {
		int result = 0;
		String sql = "update account set psw = ? where mac = ?";
		
		try {
			conn = (Connection)DBUtil.getConnection();
			ps = conn.prepareStatement(sql);
			ps.setString(1, psw);
			ps.setString(2, mac);
			result = ps.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			closeAll();
		}
		return result;
	}
	
	public String select(String mac) {
		String result = "0:0";
		Account account = new Account();
		String sql = "select * from account where mac = ?";
		
		try {
			conn = (Connection)DBUtil.getConnection();
			ps = conn.prepareStatement(sql);
			ps.setString(1, mac);
			rs = ps.executeQuery();
			while (rs.next()) {
				account.setSsid(rs.getString("ssid"));
				account.setPsw(rs.getString("psw"));
			}
			result = account.toString(account.getSsid(), account.getPsw());
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			closeAll();
		}
		return result;
	}
	
	private void closeAll() {
		try {
			if (rs !=null ) {
				rs.close();
			}
			
			if (ps != null) {
				ps.close();
			}
			
			if (conn != null) {
				conn.close();
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
}