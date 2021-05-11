package communityDto;


import java.util.Date;

public class RecruitmentDto {
	private int 	recruitment_idx;
	private String 	recruitment_name;
	private String  recruitment_title;
	private String  recruitment_content;
	private Date  	recruitment_date;
	private int 	recruitment_hit;
	
	public RecruitmentDto() { }

	public RecruitmentDto(int recruitment_idx, String recruitment_name, String recruitment_title, String recruitment_content, Date recruitment_date,
			int recruitment_hit) {
		super();
		this.recruitment_idx = recruitment_idx;
		this.recruitment_name = recruitment_name;
		this.recruitment_title = recruitment_title;
		this.recruitment_content = recruitment_content;
		this.recruitment_date = recruitment_date;
		this.recruitment_hit = recruitment_hit;
	}

	public int getRecruitment_idx() {
		return recruitment_idx;
	}

	public void setRecruitment_idx(int recruitment_idx) {
		this.recruitment_idx = recruitment_idx;
	}

	public String getRecruitment_name() {
		return recruitment_name;
	}

	public void setRecruitment_name(String recruitment_name) {
		this.recruitment_name = recruitment_name;
	}

	public String getRecruitment_title() {
		return recruitment_title;
	}

	public void setRecruitment_title(String recruitment_title) {
		this.recruitment_title = recruitment_title;
	}

	public String getRecruitment_content() {
		return recruitment_content;
	}

	public void setRecruitment_content(String recruitment_content) {
		this.recruitment_content = recruitment_content;
	}

	public Date getRecruitment_date() {
		return recruitment_date;
	}

	public void setRecruitment_date(Date recruitment_date) {
		this.recruitment_date = recruitment_date;
	}

	public int getRecruitment_hit() {
		return recruitment_hit;
	}

	public void setRecruitment_hit(int recruitment_hit) {
		this.recruitment_hit = recruitment_hit;
	}
}

	