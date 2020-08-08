package com.gbhz;

public class UserVO {
	private String userId;
	private String userPw;
	private String userNm;
	private String userCorp;
	private String venderId;

	public String getUserId() { return userId; }
	public void setUserId(String userId) { this.userId = userId; }
	
	public String getUserPw() { return userPw; }
	public void setUserPw(String userPw) { this.userPw = userPw; }
	
	public String getUserNm() { return userNm; }
	public void setUserNm(String userNm) { this.userNm = userNm; }
	
	public String getUserCorp() { return userCorp; }
	public void setUserCorp(String userCorp) { this.userCorp = userCorp; }
	
	public String getVenderId() { return venderId; }
	public void setVenderId(String venderId) { this.venderId = venderId; }

}
