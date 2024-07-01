package jp.co.kenfurni.dao;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Component;
import org.springframework.transaction.PlatformTransactionManager;
import org.springframework.transaction.TransactionException;
import org.springframework.transaction.TransactionStatus;
import org.springframework.transaction.support.DefaultTransactionDefinition;

import jp.co.kenfurni.entity.OrderDatail;
import jp.co.kenfurni.entity.Orders;
import jp.co.kenfurni.entity.Send;
import jp.co.kenfurni.entity.User;
import jp.co.kenfurni.model.CartModel;
import jp.co.kenfurni.model.OrderInfoModel;

@Component
public class BuyDAO {

	@Autowired
	private JdbcTemplate jdbcTemplate;
	@Autowired
	private PlatformTransactionManager transactionManager;

	//購入処理
	public void buy(OrderInfoModel orderInfoModel, User loginUser, List<CartModel> cartList) {
		SimpleDateFormat fm = new SimpleDateFormat("yyyy-MM-dd"); // 表示形式を指定
		Date now = new Date(); // 現在の日付情報を取得
		Calendar c = Calendar.getInstance();
		c.setTime(now); // Calendarにセット

		//Sendエンティティに値を設定
		Send send = new Send();
		send.setSend_type(orderInfoModel.getSendType());
		if (orderInfoModel.getSendType().equals("着日指定")) {
			String fmDate = orderInfoModel.getSendDate().replace("/", "-");
			send.setSend_date(fmDate);
		} else {
			c.add(Calendar.DATE, 5);//5日後の日付を取得
			send.setSend_date(fm.format(c.getTime()));
		}
		send.setFinal_address(orderInfoModel.getAddress());

		//sendテーブル更新(戻り値にsend_id)
		int send_id = insertSendInfo(send);

		//orderクラスに値を設定
		Orders orders = new Orders();

		c.setTime(now); // 現在の日時を取得
		orders.setOrders_date(fm.format(c.getTime()));
		orders.setUser_id(loginUser.getUser_id());
		orders.setSend_id(send_id);
		orders.setPay(orderInfoModel.getPay());
		orders.setPostage(13500);
		orders.setUsed_point(orderInfoModel.getUsedPoint());

		//orderテーブル更新
		int orders_id = insertOrdersInfo(orders);

		//注文詳細テーブルはカート内の商品の数、更新する
		for (CartModel cart : cartList) {
			//order_クラスに値を設定
			OrderDatail orderDatail = new OrderDatail();
			orderDatail.setOrders_id(orders_id);
			orderDatail.setItem_id(cart.getItem().getItem_id());
			orderDatail.setItem_count(cart.getCount());
			orderDatail.setFinal_price(cart.getItem().getItem_price() * cart.getCount());

			//order_datailテーブル更新
			insertOrderDatailInfo(orderDatail);
		}
	}

	//送り先情報新規登録
	private int insertSendInfo(final Send send) {
		String sql = "INSERT INTO send (send_type, send_date, final_address) VALUES (?, ?, ?);";
		Object[] parameters = { send.getSend_type(), send.getSend_date(), send.getFinal_address() };
		TransactionStatus transactionStatus = null;
		DefaultTransactionDefinition transactionDfinition = new DefaultTransactionDefinition();
		int send_id = 0;
		try {
			transactionStatus = transactionManager.getTransaction(transactionDfinition);
			jdbcTemplate.update(sql, parameters);
			send_id = jdbcTemplate.queryForObject("SELECT LAST_INSERT_ID()", Integer.class);
			transactionManager.commit(transactionStatus);
			return send_id;
		} catch (DataAccessException e) {
			e.printStackTrace();
			transactionManager.rollback(transactionStatus);
		} catch (TransactionException e) {
			e.printStackTrace();
			if (transactionStatus != null) {
				transactionManager.rollback(transactionStatus);
			}
		}
		return send_id;
	}

	//注文情報新規登録
	private int insertOrdersInfo(final Orders orders) {
		String sql = "INSERT INTO orders (orders_date, user_id, send_id, pay, postage, used_point) VALUES (?, ?, ?, ?, ?, ?);";
		Object[] parameters = { orders.getOrders_date(), orders.getUser_id(), orders.getSend_id(), orders.getPay(),
				orders.getPostage(), orders.getUsed_point() };
		TransactionStatus transactionStatus = null;
		DefaultTransactionDefinition transactionDfinition = new DefaultTransactionDefinition();
		int orders_id = 0;
		try {
			transactionStatus = transactionManager.getTransaction(transactionDfinition);
			jdbcTemplate.update(sql, parameters);
			orders_id = jdbcTemplate.queryForObject("SELECT LAST_INSERT_ID()", Integer.class);
			transactionManager.commit(transactionStatus);
			return orders_id;
		} catch (DataAccessException e) {
			e.printStackTrace();
			transactionManager.rollback(transactionStatus);
		} catch (TransactionException e) {
			e.printStackTrace();
			if (transactionStatus != null) {
				transactionManager.rollback(transactionStatus);
			}
		}
		return orders_id;
	}

	//注文詳細情報新規登録
	private int insertOrderDatailInfo(final OrderDatail orderDatail) {
		String sql = "INSERT INTO order_datail (orders_id, item_id, item_count, final_price) VALUES (?, ?, ?, ?);";
		Object[] parameters = { orderDatail.getOrders_id(), orderDatail.getItem_id(), orderDatail.getItem_count(),
				orderDatail.getFinal_price() };
		TransactionStatus transactionStatus = null;
		DefaultTransactionDefinition transactionDfinition = new DefaultTransactionDefinition();
		int succsess = 0;
		try {
			transactionStatus = transactionManager.getTransaction(transactionDfinition);
			jdbcTemplate.update(sql, parameters);
			succsess = jdbcTemplate.queryForObject("SELECT LAST_INSERT_ID()", Integer.class);
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