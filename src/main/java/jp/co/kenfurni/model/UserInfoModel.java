package jp.co.kenfurni.model;

import java.io.Serializable;

import javax.validation.constraints.Pattern;

import org.hibernate.validator.constraints.Email;
import org.hibernate.validator.constraints.NotEmpty;

import jp.co.kenfurni.DateFormat;
import jp.co.kenfurni.DatePastFormat;
import jp.co.kenfurni.SufferCheck;

public class UserInfoModel implements Serializable {
	private int user_id;			//ユーザーID
	@NotEmpty(message="必須入力です。")
	@Email(message="ローカル部@ドメイン名の形式で入力してください。")
	@SufferCheck(message="このメールアドレスは既に使用されています。")
	private String user_email;		//メールアドレス
	private String user_name;		//氏名
	@NotEmpty(message="必須入力です。")
	@Pattern(regexp = "([0-9]|[a-z]){6,10}",message="数字とアルファベットの小文字を組み合わせたパスワードを入力してください。")//0～9,a～zで構成された6～10文字
	private String user_password;	//パスワード
	@DateFormat(message="YYYY/MM/DDの形式で入力してください。")
	@DatePastFormat(message="過去の日付を入力してください。")
	private String user_birth;		//生年月日
	private String user_gender;		//性別
	private String user_address;	//住所
	@Pattern(regexp = "(^[0-9]*$)|([0-9]{14,16})",message="14桁～16桁の数字を入力してください。")//0から始まる10or11桁の数字
	private String user_card;		//クレジットカード番号
	@Pattern(regexp = "(^[0-9]*$)|0[0-9]{9,10}",message="0から始まる10もしくは11桁の電話番号を入力してください。")//0から始まる10or11桁の数字
	private String user_phone;		//電話番号
	private int user_exit;			//退会フラグ
	private int user_point;			//所持ポイント

	public int getUser_id() {
		return user_id;
	}
	public void setUser_id(int user_id) {
		this.user_id = user_id;
	}
	public String getUser_email() {
		return user_email;
	}
	public void setUser_email(String user_email) {
		this.user_email = user_email;
	}
	public String getUser_name() {
		return user_name;
	}
	public void setUser_name(String user_name) {
		this.user_name = user_name;
	}
	public String getUser_password() {
		return user_password;
	}
	public void setUser_password(String user_password) {
		this.user_password = user_password;
	}
	public String getUser_birth() {
		return user_birth;
	}
	public void setUser_birth(String user_birth) {
		this.user_birth = user_birth;
	}
	public String getUser_gender() {
		return user_gender;
	}
	public void setUser_gender(String user_gender) {
		this.user_gender = user_gender;
	}
	public String getUser_address() {
		return user_address;
	}
	public void setUser_address(String user_address) {
		this.user_address = user_address;
	}
	public String getUser_card() {
		return user_card;
	}
	public void setUser_card(String user_card) {
		this.user_card = user_card;
	}
	public String getUser_phone() {
		return user_phone;
	}
	public void setUser_phone(String user_phone) {
		this.user_phone = user_phone;
	}
	public int isUser_exit() {
		return user_exit;
	}
	public void setUser_exit(int user_exit) {
		this.user_exit = user_exit;
	}
	public int getUser_point() {
		return user_point;
	}
	public void setUser_point(int user_point) {
		this.user_point = user_point;
	}
}
