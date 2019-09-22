package entity;

public class PackageBean {
	@Override
	public String toString() {
		return "PackageBean [packageNo=" + packageNo + ", name=" + name + ", number=" + number + ", Scene=" + Scene
				+ ", reason=" + reason + ", price=" + price + ", sales=" + sales + "]";
	}
	private int packageNo;
	private String name;
	private String number;
	private String Scene;
	private String reason;
	private String price;
	private int sales;
	public int getPackageNo() {
		return packageNo;
	}
	public void setPackageNo(int packageNo) {
		this.packageNo = packageNo;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getNumber() {
		return number;
	}
	public void setNumber(String number) {
		this.number = number;
	}
	public String getScene() {
		return Scene;
	}
	public void setScene(String scene) {
		Scene = scene;
	}
	public String getReason() {
		return reason;
	}
	public void setReason(String reason) {
		this.reason = reason;
	}
	public String getPrice() {
		return price;
	}
	public void setPrice(String price) {
		this.price = price;
	}
	public int getSales() {
		return sales;
	}
	public void setSales(int sales) {
		this.sales = sales;
	}
	
	

}
