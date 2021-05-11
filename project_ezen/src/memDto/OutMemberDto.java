package memDto;

import java.util.Date;

public class OutMemberDto {
	private int out_member_idx;
	private String out_member_id;
	private String out_member_name;
	private String out_member_pay_sum;
	private String out_member_join_date;
	private String out_member_reason;
	private String out_member_opinion;
	private Date out_member_date;
	private Date out_member_date12;
	
	public OutMemberDto() {
		
	}

	public OutMemberDto(int out_member_idx, String out_member_id, String out_member_name, String out_member_pay_sum,
			String out_member_join_date, String out_member_reason, String out_member_opinion, Date out_member_date,
			Date out_member_date12) {
		super();
		this.out_member_idx = out_member_idx;
		this.out_member_id = out_member_id;
		this.out_member_name = out_member_name;
		this.out_member_pay_sum = out_member_pay_sum;
		this.out_member_join_date = out_member_join_date;
		this.out_member_reason = out_member_reason;
		this.out_member_opinion = out_member_opinion;
		this.out_member_date = out_member_date;
		this.out_member_date12 = out_member_date12;
	}

	public int getOut_member_idx() {
		return out_member_idx;
	}

	public void setOut_member_idx(int out_member_idx) {
		this.out_member_idx = out_member_idx;
	}

	public String getOut_member_id() {
		return out_member_id;
	}

	public void setOut_member_id(String out_member_id) {
		this.out_member_id = out_member_id;
	}

	public String getOut_member_name() {
		return out_member_name;
	}

	public void setOut_member_name(String out_member_name) {
		this.out_member_name = out_member_name;
	}

	public String getOut_member_pay_sum() {
		return out_member_pay_sum;
	}

	public void setOut_member_pay_sum(String out_member_pay_sum) {
		this.out_member_pay_sum = out_member_pay_sum;
	}

	public String getOut_member_join_date() {
		return out_member_join_date;
	}

	public void setOut_member_join_date(String out_member_join_date) {
		this.out_member_join_date = out_member_join_date;
	}

	public String getOut_member_reason() {
		return out_member_reason;
	}

	public void setOut_member_reason(String out_member_reason) {
		this.out_member_reason = out_member_reason;
	}

	public String getOut_member_opinion() {
		return out_member_opinion;
	}

	public void setOut_member_opinion(String out_member_opinion) {
		this.out_member_opinion = out_member_opinion;
	}

	public Date getOut_member_date() {
		return out_member_date;
	}

	public void setOut_member_date(Date out_member_date) {
		this.out_member_date = out_member_date;
	}

	public Date getOut_member_date12() {
		return out_member_date12;
	}

	public void setOut_member_date12(Date out_member_date12) {
		this.out_member_date12 = out_member_date12;
	}




}
