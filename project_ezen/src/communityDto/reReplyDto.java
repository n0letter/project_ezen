package communityDto;

import java.util.Date;

public class reReplyDto {
	private int reReply_idx;
	private String reReply_id;
	private String reReply_name;
	private String reReply_content;
	private Date reReply_date;
	private int reReply_review_idx;//본 게시글의 idx
	private int reReply_reviewMem_idx;//댓글 작성자의 idx
	private int reReply_reviewMem_idx2;//본 게시글 작성자의 idx
	
	public reReplyDto() {  }

	public reReplyDto(int reReply_idx, String reReply_id, String reReply_name, String reReply_content,
			Date reReply_date, int reReply_review_idx, int reReply_reviewMem_idx, int reReply_reviewMem_idx2) {
		super();
		this.reReply_idx = reReply_idx;
		this.reReply_id = reReply_id;
		this.reReply_name = reReply_name;
		this.reReply_content = reReply_content;
		this.reReply_date = reReply_date;
		this.reReply_review_idx = reReply_review_idx;
		this.reReply_reviewMem_idx = reReply_reviewMem_idx;
		this.reReply_reviewMem_idx2 = reReply_reviewMem_idx2;
	}

	public int getReReply_idx() {
		return reReply_idx;
	}

	public void setReReply_idx(int reReply_idx) {
		this.reReply_idx = reReply_idx;
	}

	public String getReReply_id() {
		return reReply_id;
	}

	public void setReReply_id(String reReply_id) {
		this.reReply_id = reReply_id;
	}

	public String getReReply_name() {
		return reReply_name;
	}

	public void setReReply_name(String reReply_name) {
		this.reReply_name = reReply_name;
	}

	public String getReReply_content() {
		return reReply_content;
	}

	public void setReReply_content(String reReply_content) {
		this.reReply_content = reReply_content;
	}

	public Date getReReply_date() {
		return reReply_date;
	}

	public void setReReply_date(Date reReply_date) {
		this.reReply_date = reReply_date;
	}

	public int getReReply_review_idx() {
		return reReply_review_idx;
	}

	public void setReReply_review_idx(int reReply_review_idx) {
		this.reReply_review_idx = reReply_review_idx;
	}

	public int getReReply_reviewMem_idx() {
		return reReply_reviewMem_idx;
	}

	public void setReReply_reviewMem_idx(int reReply_reviewMem_idx) {
		this.reReply_reviewMem_idx = reReply_reviewMem_idx;
	}

	public int getReReply_reviewMem_idx2() {
		return reReply_reviewMem_idx2;
	}

	public void setReReply_reviewMem_idx2(int reReply_reviewMem_idx2) {
		this.reReply_reviewMem_idx2 = reReply_reviewMem_idx2;
	}

	
	
}
