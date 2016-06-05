package model;

public class Account {
	private String ssid;
	private String mac;
	private String psw;
//	private JSONObject jb = new JSONObject();
	
	public String getSsid() {
		return ssid;
	}
	
	public void setSsid(String ssid) {
		this.ssid = ssid;
	}
	
	public String getMac() {
		return mac;
	}
	
	public void setMac(String mac) {
		this.mac = mac;
	}
	
	public String getPsw() {
		return psw;
	}
	
	public void setPsw(String psw) {
		this.psw = psw;
	}
	
	public String toString(String ssid, String psw) {
		String result = "0:0";
		
		if ((ssid != null) && (psw != null)) {
			result = ssid + ":" + psw;
		}
		return result;
	}
	
//	public String toString(String mac, String psw) {
//		String result = null;
//		
//		if ((mac != null) && (psw != null)) {
//			try {
//				jb.put("mac", mac);
//				jb.put("psk", psw);
//			} catch (Exception e) {
//				e.printStackTrace();
//			}
//			result = jb.toString();
//		}
//		return result;
//	}
}