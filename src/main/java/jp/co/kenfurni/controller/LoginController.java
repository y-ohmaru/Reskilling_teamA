package jp.co.kenfurni.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import jp.co.kenfurni.dao.ItemDAO;
import jp.co.kenfurni.dao.UserDAO;
import jp.co.kenfurni.entity.Item;
import jp.co.kenfurni.entity.User;
import jp.co.kenfurni.model.LoginModel;

/**
 * Handles requests for the application home page.
 */
@Controller
public class LoginController {
	@Autowired
	private UserDAO userdao;

	@Autowired
	private ItemDAO itemDAO;

	//ログインボタン押下時
	@RequestMapping(value = "/login", method = RequestMethod.POST)
	public String login(@Validated @ModelAttribute LoginModel loginModel,
			BindingResult result, Model model, HttpSession session) {
		if (result.hasErrors()) {
			return "login";

		}
		//取得したmailがDBに登録されているか検索(DAO)
		User userInfo = userdao.getUserInfoByEmail(loginModel.getUser_email());
		//メアドがあったら、パスワードが合っているか確認
		if (userInfo != null && !userInfo.getUser_email().isEmpty()) {
			//パスワードチェック
			boolean pwCheck = loginModel.getUser_password().equals(userInfo.getUser_password());
			if (pwCheck) {
				//パスワードある場合
				//退会チェック
				int userexit = userInfo.getUser_exit();
				if (userexit == 1) {
					model.addAttribute("message", "ユーザーは既に退会済みです。");
					return "login";
				}
				//セッションにユーザー情報を追加
				session.setAttribute("loginUser", userInfo);
				//検索画面に遷移
				List<Item> itemList = itemDAO.getAllItemList();
				//modelにsearchResultという名前で全件検索結果を設定する。
				model.addAttribute("searchResult", itemList);

				model.addAttribute("item", new Item());
				return "redirect:/item/search";
			} else {
				//パスワードが合っていない場合
				//エラーメッセージを追加してログイン画面に遷移
				model.addAttribute("message", "パスワードが正しくありません。");
				return "login";
			}

		} else {
			//メールアドレスがDBに無いとき
			//エラーメッセージを設定してログイン画面に遷移
			model.addAttribute("message", "未登録のアドレスです。会員登録がお済でない場合は新規登録をお願い致します。");
			return "login";
		}

	}

}