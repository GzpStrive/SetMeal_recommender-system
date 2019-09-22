package entity;

public class combinationBean {
	private int packageNo;
	private int menuNo;
	private String str1;
	public int getPackageNo() {
		return packageNo;
	}
	public void setPackageNo(int packageNo) {
		this.packageNo = packageNo;
	}
	public int getMenuNo() {
		return menuNo;
	}
	public void setMenuNo(int menuNo) {
		this.menuNo = menuNo;
	}
	public String getStr1() {
		return str1;
	}
	public void setStr1(String str1) {
		this.str1 = str1;
	}
	@Override
	public String toString() {
		return "conbinationBean [packageNo=" + packageNo + ", menuNo=" + menuNo + ", str1=" + str1 + "]";
	}
}
