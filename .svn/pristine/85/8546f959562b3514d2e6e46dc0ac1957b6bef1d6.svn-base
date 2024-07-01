package jp.co.kenfurni.model;

import java.io.Serializable;

import org.hibernate.validator.constraints.Email;
import org.hibernate.validator.constraints.NotEmpty;

public class LoginModel implements Serializable {
	@NotEmpty(message = "必須入力です。")
	@Email(message = "ローカル部@ドメイン名の形式で入力してください。")
	private String user_email; //メールアドレス
	@NotEmpty(message = "必須入力です。")
	private String user_password; //パスワード

	public String getUser_email() {
		return user_email;
	}

	public void setUser_email(String user_email) {
		this.user_email = user_email;
	}

	public String getUser_password() {
		return user_password;
	}

	public void setUser_password(String user_password) {
		this.user_password = user_password;
	}

}