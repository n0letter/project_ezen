package serviceDto;

import java.util.Date;

public class PayDto {
	
	private int pay_idx;
	private String pay_id;	
	private String pay_name;	
	private String pay_membership;
	private int pay_coupon_num;
	private int pay_amount;
	private String pay_start_date;
	private String pay_end_date;
	private Date pay_payment_date;	
	private int pay_member_idx;

	public PayDto() { }

	public PayDto(int pay_idx, String pay_id, String pay_name, String pay_membership, int pay_coupon_num,
			int pay_amount, String pay_start_date, String pay_end_date, Date pay_payment_date, int pay_member_idx) {
		super();
		this.pay_idx = pay_idx;
		this.pay_id = pay_id;
		this.pay_name = pay_name;
		this.pay_membership = pay_membership;
		this.pay_coupon_num = pay_coupon_num;
		this.pay_amount = pay_amount;
		this.pay_start_date = pay_start_date;
		this.pay_end_date = pay_end_date;
		this.pay_payment_date = pay_payment_date;
		this.pay_member_idx = pay_member_idx;
	}

	public int getPay_idx() {
		return pay_idx;
	}

	public void setPay_idx(int pay_idx) {
		this.pay_idx = pay_idx;
	}

	public String getPay_id() {
		return pay_id;
	}

	public void setPay_id(String pay_id) {
		this.pay_id = pay_id;
	}

	public String getPay_name() {
		return pay_name;
	}

	public void setPay_name(String pay_name) {
		this.pay_name = pay_name;
	}

	public String getPay_membership() {
		return pay_membership;
	}

	public void setPay_membership(String pay_membership) {
		this.pay_membership = pay_membership;
	}

	public int getPay_coupon_num() {
		return pay_coupon_num;
	}

	public void setPay_coupon_num(int pay_coupon_num) {
		this.pay_coupon_num = pay_coupon_num;
	}

	public int getPay_amount() {
		return pay_amount;
	}

	public void setPay_amount(int pay_amount) {
		this.pay_amount = pay_amount;
	}

	public String getPay_start_date() {
		return pay_start_date;
	}

	public void setPay_start_date(String pay_start_date) {
		this.pay_start_date = pay_start_date;
	}

	public String getPay_end_date() {
		return pay_end_date;
	}

	public void setPay_end_date(String pay_end_date) {
		this.pay_end_date = pay_end_date;
	}

	public Date getPay_payment_date() {
		return pay_payment_date;
	}

	public void setPay_payment_date(Date pay_payment_date) {
		this.pay_payment_date = pay_payment_date;
	}

	public int getPay_member_idx() {
		return pay_member_idx;
	}

	public void setPay_member_idx(int pay_member_idx) {
		this.pay_member_idx = pay_member_idx;
	}

}