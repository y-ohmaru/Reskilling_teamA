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

import jp.co.kenfurni.entity.User;

@Component
public class UserDAO {

	@Autowired
	private JdbcTemplate jdbcTemplate;
	@Autowired
	private PlatformTransactionManager transactionManager;

	private RowMapper<User> userMapper = new BeanPropertyRowMapper<User>(User.class);

	//全てのユーザー情報を取得
	public List<User> getAllUserList() {
		// SQLを保持するPreparedStatementオブジェクトの生成
		String sql = "SELECT * FROM user ";
		try {
			List<User> userList = jdbcTemplate.query(sql, userMapper);
			return userList;
		} catch (EmptyResultDataAccessException e) {
			e.printStackTrace();
			return null;
		}
	}

	//全てのユーザー情報を取得
	public User getUserInfoByEmail(String email) {
		// SQLを保持するPreparedStatementオブジェクトの生成
		String sql = "SELECT * FROM user WHERE user_email = ?";
		Object[] parameters = { email };
		try {
			User userInfo = jdbcTemplate.queryForObject(sql, parameters, userMapper);
			return userInfo;
		} catch (EmptyResultDataAccessException e) {
			e.printStackTrace();
			return null;
		}
	}

	//全てのユーザー情報を取得
	public int CheckUserInfoByEmail(String email) {
		// SQLを保持するPreparedStatementオブジェクトの生成
		String sql = "SELECT COUNT(*) FROM user WHERE user_email = ?";
		Object[] parameters = { email };
		try {
			int count = jdbcTemplate.queryForObject(sql, Integer.class, parameters);
			return count;
		} catch (EmptyResultDataAccessException e) {
			e.printStackTrace();
			return 0;
		}
	}
	//ユーザー情報新規登録
	public int insertUserInfo(User user) {
		// SQLを保持するPreparedStatementオブジェクトの生成
		String sql = "insert into user(user_id,user_email,user_name,user_password,user_birth,user_gender,user_address,user_card,user_phone,user_exit,user_point)VALUES(?,?,?,?,?,?,?,?,?,?,?);";
		Object[] parameters = { null, user.getUser_email(), user.getUser_name(), user.getUser_password(),
				user.getUser_birth(), user.getUser_gender(), user.getUser_address(), user.getUser_card(),
				user.getUser_phone(), 0, 0 };
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

	//ユーザー情報更新
	public int updateUserInfo_edit(User user) {
		// SQLを保持するPreparedStatementオブジェクトの生成
		String sql = "update user set user_email= ?, user_name= ?, user_password = ?,"
				+ " user_birth = ?, user_gender = ?, user_address = ?, user_card = ?, user_phone = ? where user_id= ?";
		Object[] parameters = {user.getUser_email(), user.getUser_name(),user.getUser_password(),
				user.getUser_birth(),user.getUser_gender(),user.getUser_address(),user.getUser_card(),
				user.getUser_phone(),user.getUser_id()};
		TransactionStatus transactionStatus = null;
		DefaultTransactionDefinition transactionDfinition = new DefaultTransactionDefinition();
		int succsess=0;
		try {
			transactionStatus = transactionManager.getTransaction(transactionDfinition);
			succsess = jdbcTemplate.update(sql, parameters);
			transactionManager.commit(transactionStatus);
			return succsess;
		} catch (DataAccessException e) {
			e.printStackTrace();
			transactionManager.rollback(transactionStatus);
		}catch (TransactionException e) {
			e.printStackTrace();
			if(transactionStatus != null) {
				transactionManager.rollback(transactionStatus);
			}
		}
		return succsess;
	}

	//ユーザー退会
	public int insertUserInfo_exit(User user) {
		// SQLを保持するPreparedStatementオブジェクトの生成
		String sql = "update user set user_exit=1 where user_id=?";
		Object[] parameters = { user.getUser_id() };
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

	//ポイント更新
	public int updatePoint(User user, int usedPoint) {
		user = getUserInfoByEmail(user.getUser_email()); //念のためDBから最新のユーザー情報取得

		//ポイントの計算(現在のポイント-使用したポイント)
		int newPoint = user.getUser_point() - usedPoint;
		// SQLを保持するPreparedStatementオブジェクトの生成
		String sql = "update user set user_point = ? where user_id=?";
		Object[] parameters = { newPoint, user.getUser_id() };
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