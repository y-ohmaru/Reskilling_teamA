package jp.co.kenfurni.model;

import java.io.Serializable;

import jp.co.kenfurni.entity.Item;

public class CartModel implements Serializable {
	private Item item;
	private int count;

	public Item getItem() {
		return item;
	}

	public void setItem(Item item) {
		this.item = item;
	}

	public int getCount() {
		return count;
	}

	public void setCount(int count) {
		this.count = count;
	}
}
