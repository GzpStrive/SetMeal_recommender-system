package entity;

public class Admin {
	@Override
	public String toString() {
		return "Admin [No=" + No + ", pwd=" + pwd + ", telephone=" + telephone + ", position=" + position + ", str2=" + str2
				+ "]";
	}
	private int No;
	private String pwd;
	private String telephone;
	private String position;
	private String str2;
	public int getNo() {
		return No;
	}
	public void setNo(int no) {
		No = no;
	}
	public String getPwd() {
		return pwd;
	}
	public void setPwd(String pwd) {
		this.pwd = pwd;
	}
	public String getTelephone() {
		return telephone;
	}
	public void setTelephone(String telephone) {
		this.telephone = telephone;
	}
	public String getPosition() {
		return position;
	}
	public void setPosition(String position) {
		this.position = position;
	}
	public String getStr2() {
		return str2;
	}
	public void setStr2(String str2) {
		this.str2 = str2;
	}
}
