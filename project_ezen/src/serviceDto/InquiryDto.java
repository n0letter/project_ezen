package serviceDto;

import java.util.Date;

public class InquiryDto {
	
	private int inq_idx;
	private String inq_type;
	private String inq_title;
	private String inq_name;
	private String inq_content;
	private String inq_state;
	private String inq_re_content;
	private Date inq_date;
	private int inq_member_idx;
		
	public InquiryDto() { }

	public InquiryDto(int inq_idx, String inq_type, String inq_title, String inq_name, String inq_content,
			String inq_state, String inq_re_content, Date inq_date, int inq_member_idx) {
		super();
		this.inq_idx = inq_idx;
		this.inq_type = inq_type;
		this.inq_title = inq_title;
		this.inq_name = inq_name;
		this.inq_content = inq_content;
		this.inq_state = inq_state;
		this.inq_re_content = inq_re_content;
		this.inq_date = inq_date;
		this.inq_member_idx = inq_member_idx;
	}

	public int getInq_idx() {
		return inq_idx;
	}

	public void setInq_idx(int inq_idx) {
		this.inq_idx = inq_idx;
	}

	public String getInq_type() {
		return inq_type;
	}

	public void setInq_type(String inq_type) {
		this.inq_type = inq_type;
	}

	public String getInq_title() {
		return inq_title;
	}

	public void setInq_title(String inq_title) {
		this.inq_title = inq_title;
	}

	public String getInq_name() {
		return inq_name;
	}

	public void setInq_name(String inq_name) {
		this.inq_name = inq_name;
	}

	public String getInq_content() {
		return inq_content;
	}

	public void setInq_content(String inq_content) {
		this.inq_content = inq_content;
	}

	public String getInq_state() {
		return inq_state;
	}

	public void setInq_state(String inq_state) {
		this.inq_state = inq_state;
	}

	public String getInq_re_content() {
		return inq_re_content;
	}

	public void setInq_re_content(String inq_re_content) {
		this.inq_re_content = inq_re_content;
	}

	public Date getInq_date() {
		return inq_date;
	}

	public void setInq_date(Date inq_date) {
		this.inq_date = inq_date;
	}

	public int getInq_member_idx() {
		return inq_member_idx;
	}

	public void setInq_member_idx(int inq_member_idx) {
		this.inq_member_idx = inq_member_idx;
	}
  
}