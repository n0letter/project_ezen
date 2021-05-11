package gymManageDto;

public class trainnerDto {

	private int trainner_idx;
	private String trainner_int;
	private String trainner_content;
	private String trainner_img;


	public trainnerDto() {  }


	public trainnerDto(int trainner_idx, String trainner_int, String trainner_content, String trainner_img) {
		super();
		this.trainner_idx = trainner_idx;
		this.trainner_int = trainner_int;
		this.trainner_content = trainner_content;
		this.trainner_img = trainner_img;
	}


	public int getTrainner_idx() {
		return trainner_idx;
	}


	public void setTrainner_idx(int trainner_idx) {
		this.trainner_idx = trainner_idx;
	}


	public String getTrainner_int() {
		return trainner_int;
	}


	public void setTrainner_int(String trainner_int) {
		this.trainner_int = trainner_int;
	}


	public String getTrainner_content() {
		return trainner_content;
	}


	public void setTrainner_content(String trainner_content) {
		this.trainner_content = trainner_content;
	}


	public String getTrainner_img() {
		return trainner_img;
	}


	public void setTrainner_img(String trainner_img) {
		this.trainner_img = trainner_img;
	}

}

