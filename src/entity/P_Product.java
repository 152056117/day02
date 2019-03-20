package entity;

public class P_Product {
	private int p_id;
	private String p_name;
	private double price;
	private int total;
	private int num;
	private String disc;
	private double discount;
	private String img;
	private int status;
	private int t_id;
	
	@Override
	public String toString() {
		return "P_Product [p_id=" + p_id + ", p_name=" + p_name + ", price=" + price + ", total=" + total + ", num="
				+ num + ", disc=" + disc + ", discount=" + discount + ", img=" + img + ", status=" + status + ", t_id="
				+ t_id + "]";
	}
	
	public int getP_id() {
		return p_id;
	}
	public void setP_id(int p_id) {
		this.p_id = p_id;
	}
	public String getP_name() {
		return p_name;
	}
	public void setP_name(String p_name) {
		this.p_name = p_name;
	}
	public double getPrice() {
		return price;
	}
	public void setPrice(double price) {
		this.price = price;
	}
	public int getTotal() {
		return total;
	}
	public void setTotal(int total) {
		this.total = total;
	}
	public int getNum() {
		return num;
	}
	public void setNum(int num) {
		this.num = num;
	}
	public String getDisc() {
		return disc;
	}
	public void setDisc(String disc) {
		this.disc = disc;
	}
	public double getDiscount() {
		return discount;
	}
	public void setDiscount(double discount) {
		this.discount = discount;
	}
	public String getImg() {
		return img;
	}
	public void setImg(String img) {
		this.img = img;
	}
	public int getStatus() {
		return status;
	}
	public void setStatus(int status) {
		this.status = status;
	}
	public int getT_id() {
		return t_id;
	}
	public void setT_id(int t_id) {
		this.t_id = t_id;
	}
}
