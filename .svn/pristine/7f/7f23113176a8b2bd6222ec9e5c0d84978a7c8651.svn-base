package jp.co.kenfurni.dao;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.dao.EmptyResultDataAccessException;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Component;
import org.springframework.transaction.PlatformTransactionManager;
import org.springframework.transaction.TransactionException;
import org.springframework.transaction.TransactionStatus;
import org.springframework.transaction.support.DefaultTransactionDefinition;

import jp.co.kenfurni.entity.Item;

@Component
public class ItemDAO {

	@Autowired
	private JdbcTemplate jdbcTemplate;
	@Autowired
	private PlatformTransactionManager transactionManager;

	private RowMapper<Item> itemMapper = new BeanPropertyRowMapper<Item>(Item.class);

	//全ての商品リストを取得
	public List<Item> getAllItemList() {
		// SQLを保持するPreparedStatementオブジェクトの生成
		String sql = "SELECT * FROM item ";
		try {
			List<Item> itemList = jdbcTemplate.query(sql, itemMapper);
			return itemList;
		} catch (EmptyResultDataAccessException e) {
			e.printStackTrace();
			return null;
		}
	}

	//商品名で検索
	public List<Item> getItemListByItemName(String keyword) {
		// SQLを保持するPreparedStatementオブジェクトの生成
		String sql = "SELECT * FROM item WHERE item_name LIKE ?";
		keyword = "%" + keyword + "%";
		Object[] parameters = { keyword };
		try {
			List<Item> itemList = jdbcTemplate.query(sql, parameters, itemMapper);
			return itemList;
		} catch (EmptyResultDataAccessException e) {
			e.printStackTrace();
			return null;
		}
	}

	//スペースで分割した単語で検索
	public List<Item> getItemSpace(String keyword) {
		// SQLを保持するPreparedStatementオブジェクトの生成
		String sql = "SELECT * FROM item WHERE ";
		//			keyword = "%" + keyword + "%";

		String[] keys = keyword.split("[\s　]+");

		for (int a = 0; a < keys.length; a++) {
			if (a == 0) {
				sql += "item_name LIKE ? ";
			} else {
				sql += "or item_name LIKE ? ";
			}
			keys[a] = "%" + keys[a] + "%";
		}
		Object[] parameters = new Object[keys.length];

		for (int a = 0; a < keys.length; a++) {
			parameters[a] = keys[a];
		}
		try {
			List<Item> itemList = jdbcTemplate.query(sql, parameters, itemMapper);
			return itemList;
		} catch (EmptyResultDataAccessException e) {
			e.printStackTrace();
			return null;
		}
	}

	//トップ画面で選んだ商品のIDを取得
	public Item getItemByItemId(Integer id) {
		String sql = "SELECT * FROM item WHERE item_id=?";
		Object[] parameters = { id };
		try {
			Item item = jdbcTemplate.queryForObject(sql, parameters, itemMapper);
			return item;
		} catch (EmptyResultDataAccessException e) {
			e.printStackTrace();
			return null;
		}
	}

	//購入分の在庫減
	public int updateStock(Item item, int buyCount) {
		item = getItemByItemId(item.getItem_id()); //念のためDBから最新の商品情報取得

		//在庫の計算(現在の在庫-購入した在庫)
		int newStock = item.getItem_stock() - buyCount;
		// SQLを保持するPreparedStatementオブジェクトの生成
		String sql = "update item set item_stock = ? where item_id=?";
		Object[] parameters = { newStock, item.getItem_id() };
		TransactionStatus transactionStatus = null;
		DefaultTransactionDefinition transactionDfinition = new DefaultTransactionDefinition();
		int succsess = 0;
		try {
			transactionStatus = transactionManager.getTransaction(transactionDfinition);
			succsess = jdbcTemplate.update(sql, parameters);
			transactionManager.commit(transactionStatus);
			return succsess;
		} catch (DataAccessException e) {
			e.printStackTrace();
			transactionManager.rollback(transactionStatus);
		} catch (TransactionException e) {
			e.printStackTrace();
			if (transactionStatus != null) {
				transactionManager.rollback(transactionStatus);
			}
		}

		return succsess;
	}
}