package entity;

public class menuBean {
	private int menuNo;
	private String name;
	private String serial;
	private String price;
	private String kind;
	private String mean;
	private String profit_margin;   //利润率
	private String money;
	private String photo;
	private String material;
	private int sales;
	@Override
	public String toString() {
		return "Menu [menuNo=" + menuNo + ", name=" + name + ", serial=" + serial + ", price=" + price + ", kind="
				+ kind + ", mean=" + mean + ", profit_margin=" + profit_margin + ", money=" + money + ", photo=" + photo
				+ ", material=" + material + ", sales=" + sales + "]";
	}
	public String getProfit_margin() {
		return profit_margin;
	}
	public void setProfit_margin(String profit_margin) {
		this.profit_margin = profit_margin;
	}
	public int getSales() {
		return sales;
	}
	public void setSales(int sales) {
		this.sales = sales;
	}
	public int getMenuNo() {
		return menuNo;
	}
	public void setMenuNo(int menuNo) {
		this.menuNo = menuNo;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getSerial() {
		return serial;
	}
	public void setSerial(String serial) {
		this.serial = serial;
	}
	public String getPrice() {
		return price;
	}
	public void setPrice(String price) {
		this.price = price;
	}
	public String getKind() {
		return kind;
	}
	public void setKind(String kind) {
		this.kind = kind;
	}
	public String getMean() {
		return mean;
	}
	public void setMean(String mean) {
		this.mean = mean;
	}
	public String getMoney() {
		return money;
	}
	public void setMoney(String money) {
		this.money = money;
	}
	public String getPhoto() {
		return photo;
	}
	public void setPhoto(String photo) {
		this.photo = photo;
	}
	public String getMaterial() {
		return material;
	}
	public void setMaterial(String material) {
		this.material = material;
	}
}
