package jp.co.kenfurni.entity;

public class Send {
	private int send_id;
	private String send_type;
	private String send_date;
	private String final_address;

	public int getSend_id() {
		return send_id;
	}

	public void setSend_id(int send_id) {
		this.send_id = send_id;
	}

	public String getSend_type() {
		return send_type;
	}

	public void setSend_type(String send_type) {
		this.send_type = send_type;
	}

	public String getSend_date() {
		return send_date;
	}

	public void setSend_date(String send_date) {
		this.send_date = send_date;
	}

	public String getFinal_address() {
		return final_address;
	}

	public void setFinal_address(String final_address) {
		this.final_address = final_address;
	}
}
