package communityDto;

import java.util.Date;

public class ReviewDto {
	private int 	review_idx;
	private String 	review_id;
	private String 	review_name;
	private String  review_title;
	private String  review_content;
	private Date  	review_date;
	private int 	review_hit;
	private int 	review_reply_count;
	private int 	reviewMember_idx;
	
	public ReviewDto() { }

	public ReviewDto(int review_idx, String review_id, String review_name, String review_title, String review_content,
			Date review_date, int review_hit, int review_reply_count, int reviewMember_idx) {
		super();
		this.review_idx = review_idx;
		this.review_id = review_id;
		this.review_name = review_name;
		this.review_title = review_title;
		this.review_content = review_content;
		this.review_date = review_date;
		this.review_hit = review_hit;
		this.review_reply_count = review_reply_count;
		this.reviewMember_idx = reviewMember_idx; //게시글 작성자 idx
	}

	public int getReview_idx() {
		return review_idx;
	}

	public void setReview_idx(int review_idx) {
		this.review_idx = review_idx;
	}

	public String getReview_id() {
		return review_id;
	}

	public void setReview_id(String review_id) {
		this.review_id = review_id;
	}

	public String getReview_name() {
		return review_name;
	}

	public void setReview_name(String review_name) {
		this.review_name = review_name;
	}

	public String getReview_title() {
		return review_title;
	}

	public void setReview_title(String review_title) {
		this.review_title = review_title;
	}

	public String getReview_content() {
		return review_content;
	}

	public void setReview_content(String review_content) {
		this.review_content = review_content;
	}

	public Date getReview_date() {
		return review_date;
	}

	public void setReview_date(Date review_date) {
		this.review_date = review_date;
	}

	public int getReview_hit() {
		return review_hit;
	}

	public void setReview_hit(int review_hit) {
		this.review_hit = review_hit;
	}

	public int getReview_reply_count() {
		return review_reply_count;
	}

	public void setReview_reply_count(int review_reply_count) {
		this.review_reply_count = review_reply_count;
	}

	public int getReviewMember_idx() {
		return reviewMember_idx;
	}

	public void setReviewMember_idx(int reviewMember_idx) {
		this.reviewMember_idx = reviewMember_idx;
	}

	


	
	
}
