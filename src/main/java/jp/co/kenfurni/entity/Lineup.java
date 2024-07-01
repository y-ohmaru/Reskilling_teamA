package jp.co.kenfurni.entity;

public class Lineup {
	private int lineup_id;
	private int item_id;
	private String sales_text;
	private String lineup_image;
	private String created_at;

	public int getLineup_id() {
		return lineup_id;
	}

	public void setLineup_id(int lineup_id) {
		this.lineup_id = lineup_id;
	}

	public int getItem_id() {
		return item_id;
	}

	public void setItem_id(int item_id) {
		this.item_id = item_id;
	}

	public String getSales_text() {
		return sales_text;
	}

	public void setSales_text(String sales_text) {
		this.sales_text = sales_text;
	}

	public String getLineup_image() {
		return lineup_image;
	}

	public void setLineup_image(String lineup_image) {
		this.lineup_image = lineup_image;
	}

	public String getCreated_at() {
		return created_at;
	}

	public void setCreated_at(String created_at) {
		this.created_at = created_at;
	}

}