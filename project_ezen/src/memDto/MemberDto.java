package memDto;

import java.util.Date;

public class MemberDto {
	private int member_idx;
	private String member_id;
	private String member_pw;
	private String member_name;
	private String member_birth_date;
	private String member_gender;
	private String member_phone;
	private String member_email;
	private int member_email_receive;
	private int member_coupon01;
	private int member_coupon02;
	private int member_locker;
	private int member_pay_sum;
	private String member_agree;
	private Date member_join_date;
	
	public MemberDto() {
		
	}

	public MemberDto(int member_idx, String member_id, String member_pw, String member_name, String member_birth_date,
			String member_gender, String member_phone, String member_email, int member_email_receive,
			int member_coupon01, int member_coupon02, int member_locker, int member_pay_sum, String member_agree,
			Date member_join_date) {
		super();
		this.member_idx = member_idx;
		this.member_id = member_id;
		this.member_pw = member_pw;
		this.member_name = member_name;
		this.member_birth_date = member_birth_date;
		this.member_gender = member_gender;
		this.member_phone = member_phone;
		this.member_email = member_email;
		this.member_email_receive = member_email_receive;
		this.member_coupon01 = member_coupon01;
		this.member_coupon02 = member_coupon02;
		this.member_locker = member_locker;
		this.member_pay_sum = member_pay_sum;
		this.member_agree = member_agree;
		this.member_join_date = member_join_date;
	}

	public int getMember_idx() {
		return member_idx;
	}

	public void setMember_idx(int member_idx) {
		this.member_idx = member_idx;
	}

	public String getMember_id() {
		return member_id;
	}

	public void setMember_id(String member_id) {
		this.member_id = member_id;
	}

	public String getMember_pw() {
		return member_pw;
	}

	public void setMember_pw(String member_pw) {
		this.member_pw = member_pw;
	}

	public String getMember_name() {
		return member_name;
	}

	public void setMember_name(String member_name) {
		this.member_name = member_name;
	}

	public String getMember_birth_date() {
		return member_birth_date;
	}

	public void setMember_birth_date(String member_birth_date) {
		this.member_birth_date = member_birth_date;
	}

	public String getMember_gender() {
		return member_gender;
	}

	public void setMember_gender(String member_gender) {
		this.member_gender = member_gender;
	}

	public String getMember_phone() {
		return member_phone;
	}

	public void setMember_phone(String member_phone) {
		this.member_phone = member_phone;
	}

	public String getMember_email() {
		return member_email;
	}

	public void setMember_email(String member_email) {
		this.member_email = member_email;
	}

	public int getMember_email_receive() {
		return member_email_receive;
	}

	public void setMember_email_receive(int member_email_receive) {
		this.member_email_receive = member_email_receive;
	}

	public int getMember_coupon01() {
		return member_coupon01;
	}

	public void setMember_coupon01(int member_coupon01) {
		this.member_coupon01 = member_coupon01;
	}

	public int getMember_coupon02() {
		return member_coupon02;
	}

	public void setMember_coupon02(int member_coupon02) {
		this.member_coupon02 = member_coupon02;
	}

	public int getMember_locker() {
		return member_locker;
	}

	public void setMember_locker(int member_locker) {
		this.member_locker = member_locker;
	}

	public int getMember_pay_sum() {
		return member_pay_sum;
	}

	public void setMember_pay_sum(int member_pay_sum) {
		this.member_pay_sum = member_pay_sum;
	}

	public String getMember_agree() {
		return member_agree;
	}

	public void setMember_agree(String member_agree) {
		this.member_agree = member_agree;
	}

	public Date getMember_join_date() {
		return member_join_date;
	}

	public void setMember_join_date(Date member_join_date) {
		this.member_join_date = member_join_date;
	}
	
	
}
