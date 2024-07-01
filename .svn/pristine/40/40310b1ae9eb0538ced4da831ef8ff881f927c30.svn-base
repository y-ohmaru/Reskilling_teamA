package jp.co.kenfurni.dao;

import java.util.Collections;
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

import jp.co.kenfurni.entity.Lineup;

@Component
public class LineupDAO {

	@Autowired
	private JdbcTemplate jdbcTemplate;
	@Autowired
	private PlatformTransactionManager transactionManager;

	private RowMapper<Lineup> lineupMapper = new BeanPropertyRowMapper<Lineup>(Lineup.class);

	//全てのラインナップ情報を取得
	public List<Lineup> getAllLineupList() {
		// SQLを保持するPreparedStatementオブジェクトの生成
		String sql = "SELECT * FROM lineup ";
		try {
			List<Lineup> lineupList = jdbcTemplate.query(sql, lineupMapper);
			return lineupList;
		} catch (EmptyResultDataAccessException e) {
			e.printStackTrace();
			return null;
		}
	}

	//最新3件のラインナップ情報を取得
	public List<Lineup> getTopLineupList() {
		// SQLを保持するPreparedStatementオブジェクトの生成
		String sql = "SELECT * FROM lineup ORDER BY lineup.lineup_id DESC LIMIT 3";
		try {
			List<Lineup> lineupList = jdbcTemplate.query(sql, lineupMapper);
			return lineupList;
		} catch (EmptyResultDataAccessException e) {
			e.printStackTrace();
			return Collections.emptyList();//空のリストを返す
		}
	}

	//ラインナップ情報新規登録
	public int insertLineupInfo(Lineup lineup) {
		// SQLを保持するPreparedStatementオブジェクトの生成
		String sql = "INSERT INTO lineup (item_id, lineup_image, sales_text, created_At) VALUES (?, ?, ?, CURRENT_TIMESTAMP);";
		Object[] parameters = { lineup.getItem_id(), lineup.getLineup_image(), lineup.getSales_text() };
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
