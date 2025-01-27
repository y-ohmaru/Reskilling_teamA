package jp.co.kenfurni.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import jp.co.kenfurni.dao.ItemDAO;
import jp.co.kenfurni.dao.LineupDAO;
import jp.co.kenfurni.dao.UserDAO;
import jp.co.kenfurni.entity.Item;
import jp.co.kenfurni.entity.Lineup;
import jp.co.kenfurni.entity.User;
import jp.co.kenfurni.model.LoginModel;
import jp.co.kenfurni.model.UserInfoModel;

/**
 * Handles requests for the application home page.
 */
@Controller
public class HeaderController {

	@Autowired
	private ItemDAO itemDAO;

	@Autowired
	private UserDAO userdao;
	@Autowired
	private LineupDAO lineupDAO;

	//商品検索画面表示
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String home(Model model) {
		return "redirect:/item/search";
	}

	//商品検索画面表示
	@RequestMapping(value = "/item/search", method = RequestMethod.GET)
	public String toItemSearch(Model model) {
		return initItemSearch(itemDAO, lineupDAO, model);
	}

	//ログイン画面表示
	@RequestMapping(value = "/login", method = RequestMethod.GET)
	public String toLogin(Model model,HttpSession session) {
		User loginUser = (User) session.getAttribute("loginUser");
		model.addAttribute("loginModel", new LoginModel());
	    if (loginUser != null) {
	    	//ログイン済みの場合
	    	model.addAttribute("already_login",true);
	        return "login";
	    }
		// ログインしていない場合、ログインページを表示する
		return "login";
	}

	//ユーザ確認画面表示
	@RequestMapping(value = "/user/confirm", method = RequestMethod.GET)
	public String toUserConfirm(Model model,HttpServletRequest request) {
		HttpSession session=request.getSession(true);
		User userConfirmModel=(User) session.getAttribute("loginUser");
		if(userConfirmModel==null) {
			model.addAttribute("UserConfirmModel",new UserInfoModel());
			return "userConfirm";
		}
		String loginUserinfo = userConfirmModel.getUser_email();
		userConfirmModel = userdao.getUserInfoByEmail(loginUserinfo);

		//パスワードとクレジットカードのマスク処理
		userConfirmModel.setUser_password(userConfirmModel.getUser_password().replaceAll(".", "*"));

		if (userConfirmModel.getUser_card() != null && !userConfirmModel.getUser_card().equals("")) {
			String card = userConfirmModel.getUser_card();
			card = "****-****-****-" + card.substring(card.length() - 4);
			userConfirmModel.setUser_card(card);
		}

		session.setAttribute("UserConfirmModel", userConfirmModel);
		return "userConfirm";
	}

	//カート画面表示
	@RequestMapping(value = "/item/cart", method = RequestMethod.GET)
	public String toCart(Model model) {
		model.addAttribute("item", new Item());
		return "cart";
	}

	//ログアウト処理して商品検索画面へ
	@RequestMapping(value = "/logout", method = RequestMethod.GET)
	public String logout(Model model, HttpSession session) {
		session.invalidate();

		return "redirect:/item/search";
	}

	//商品検索画面表示時の初期設定を行う。(他のコントローラーでも共通して使用できるようにメソッド作成)
	public static String initItemSearch(ItemDAO itemDAO, LineupDAO lineupDAO, Model model) {
		//DBから全件検索(DAOのメソッドを使う)getAllItemList
		List<Item> itemList = itemDAO.getAllItemList();
		List<Lineup> lineupList = lineupDAO.getTopLineupList();

		//modelにsearchResultという名前で全件検索結果を設定する。
		model.addAttribute("searchResult", itemList);
		model.addAttribute("item", new Item());
		model.addAttribute("lineupList", lineupList);

		return "itemSearch";
	}
}