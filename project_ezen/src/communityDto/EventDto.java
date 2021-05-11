package communityDto;


import java.util.Date;

public class EventDto {
	private int 	event_idx;
	private String 	event_name;
	private String  event_title;
	private String  event_content;
	private Date  	event_date;
	private int 	event_hit;
	
	public EventDto() { }

	public EventDto(int event_idx, String event_name, String event_title, String event_content, Date event_date,
			int event_hit) {
		super();
		this.event_idx = event_idx;
		this.event_name = event_name;
		this.event_title = event_title;
		this.event_content = event_content;
		this.event_date = event_date;
		this.event_hit = event_hit;
	}

	public int getEvent_idx() {
		return event_idx;
	}

	public void setEvent_idx(int event_idx) {
		this.event_idx = event_idx;
	}

	public String getEvent_name() {
		return event_name;
	}

	public void setEvent_name(String event_name) {
		this.event_name = event_name;
	}

	public String getEvent_title() {
		return event_title;
	}

	public void setEvent_title(String event_title) {
		this.event_title = event_title;
	}

	public String getEvent_content() {
		return event_content;
	}

	public void setEvent_content(String event_content) {
		this.event_content = event_content;
	}

	public Date getEvent_date() {
		return event_date;
	}

	public void setEvent_date(Date event_date) {
		this.event_date = event_date;
	}

	public int getEvent_hit() {
		return event_hit;
	}

	public void setEvent_hit(int event_hit) {
		this.event_hit = event_hit;
	}
	
	
}
