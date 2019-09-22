package entity;

public class UserBean {
	//<!-- 订单表字段：orderNo name tel time deskcount price source age Scene append-->
	private int orderNo;
	private String name;
	private String tel;
	private String deskcount;
	private String append;
	private String age;
	private String source;
	private String Scene;
	private int is_xiadan;
	private boolean checkd;
	private String time;
	private String price;
	
	
	public String getPrice() {
		return price;
	}
	public void setPrice(String price) {
		this.price = price;
	}
	public String getTime() {
		return time;
	}
	public void setTime(String time) {
		this.time = time;
	}
	public int getOrderNo() {
		return orderNo;
	}
	public void setOrderNo(int orderNo) {
		this.orderNo = orderNo;
	}
	
	public boolean isCheckd() {
		return checkd;
	}
	public void setCheckd(boolean checkd) {
		this.checkd = checkd;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getTel() {
		return tel;
	}
	public void setTel(String tel) {
		this.tel = tel;
	}
	public String getDeskcount() {
		return deskcount;
	}
	public void setDeskcount(String deskcount) {
		this.deskcount = deskcount;
	}
	public String getAppend() {
		return append;
	}
	public void setAppend(String append) {
		this.append = append;
	}
	public String getAge() {
		return age;
	}
	public void setAge(String age) {
		this.age = age;
	}
	public String getSource() {
		return source;
	}
	public void setSource(String source) {
		this.source = source;
	}
	public String getScene() {
		return Scene;
	}
	public void setScene(String Scene) {
		this.Scene = Scene;
	}
	public int getIs_xiadan() {
		return is_xiadan;
	}
	public void setIs_xiadan(int is_xiadan) {
		this.is_xiadan = is_xiadan;
	}
	@Override
	public String toString() {
		return "UserBean [orderNo=" + orderNo + ", name=" + name + ", tel=" + tel + ", deskcount=" + deskcount
				+ ", append=" + append + ", age=" + age + ", source=" + source + ", Scene=" + Scene + ", is_xiadan="
				+ is_xiadan + ", checkd=" + checkd + ", time=" + time + ", price=" + price + "]";
	}
	
	
}
