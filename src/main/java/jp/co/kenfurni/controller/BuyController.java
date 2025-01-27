package jp.co.kenfurni.controller;

import java.util.ArrayList;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import jp.co.kenfurni.dao.BuyDAO;
import jp.co.kenfurni.dao.ItemDAO;
import jp.co.kenfurni.dao.UserDAO;
import jp.co.kenfurni.entity.Item;
import jp.co.kenfurni.entity.User;
import jp.co.kenfurni.model.CartModel;
import jp.co.kenfurni.model.OrderInfoModel;

/**
 * Handles requests for the application home page.
 */
@Controller
@RequestMapping("/buy")
public class BuyController {

	@Autowired
	private UserDAO userDAO;
	@Autowired
	private ItemDAO itemDAO;
	@Autowired
	private BuyDAO BuyDAO;

	//「変更」ボタン押下時
	@RequestMapping(value = "/change", method = RequestMethod.POST)
	public String changeItemCount(@ModelAttribute Item item, @RequestParam("count") int count, HttpSession session,
			Model model) {
		// ItemDAOを使ってitem_Idに対応する商品情報を取得
		Item addCartItem = itemDAO.getItemByItemId(item.getItem_id());

		//CartModelに値を設定
		CartModel cartModel = new CartModel();
		cartModel.setItem(addCartItem);
		cartModel.setCount(count);

		// セッションからカートを取得
		@SuppressWarnings("unchecked")
		ArrayList<CartModel> cartList = (ArrayList<CartModel>) session.getAttribute("cartList");

		//カートリストの要素番号を取得して更新
		int cartIndex = findCartItemIndex(cartList, item.getItem_id());
		cartList.set(cartIndex, cartModel); //更新

		session.setAttribute("cartList", cartList);
		model.addAttribute("item", new Item());
		return "cart";
	}

	//「削除」ボタン押下時
	@RequestMapping(value = "/delete", method = RequestMethod.POST)
	public String delete(@ModelAttribute Item item, Model model, HttpSession session) {
		// セッションからカートを取得
		@SuppressWarnings("unchecked")
		ArrayList<CartModel> cartList = (ArrayList<CartModel>) session.getAttribute("cartList");

		//カートリストの要素番号を取得して削除
		int cartIndex = findCartItemIndex(cartList, item.getItem_id());
		cartList.remove(cartIndex); //更新

		//セッションのカートを更新
		session.setAttribute("cartList", cartList);

		if (cartList.isEmpty()) {
			model.addAttribute("message", "カートに商品が入ってません");
		}
		model.addAttribute("item", new Item());
		return "cart";
	}

	//「購入手続きへ進む」
	@RequestMapping(value = "/procedure", method = RequestMethod.POST)
	public String toBuy(Model model, HttpSession session) {

		//セッションから値を取得
		@SuppressWarnings("unchecked")
		ArrayList<CartModel> cartList = (ArrayList<CartModel>) session.getAttribute("cartList");
		User loginUser = (User) session.getAttribute("loginUser");

		//ログインユーザー情報から、フォームの初期値をセット(住所、クレジット)
		OrderInfoModel orderInfoModel = new OrderInfoModel();
		orderInfoModel.setAddress(loginUser.getUser_address());
		orderInfoModel.setCardNo(loginUser.getUser_card());
		model.addAttribute("orderInfoModel", orderInfoModel);

		//購入金額をmodelにセット
		int price = 0;
		for (CartModel cart : cartList) {
			price += (cart.getItem().getItem_price() * cart.getCount());
		}
		model.addAttribute("price", price);

		return "buy";
	}

	//「注文確定」
	@RequestMapping(value = "/complete", method = RequestMethod.POST)
	public String buyComplete(@ModelAttribute OrderInfoModel orderInfoModel,
			Model model, HttpSession session) {

		//セッションから値を取得
		@SuppressWarnings("unchecked")
		ArrayList<CartModel> cartList = (ArrayList<CartModel>) session.getAttribute("cartList");
		User loginUser = (User) session.getAttribute("loginUser");

		//使用したポイントを減らす
		userDAO.updatePoint(loginUser, orderInfoModel.getUsedPoint());
		//在庫を減らす
		for (CartModel cart : cartList) {
			itemDAO.updateStock(cart.getItem(), cart.getCount());
		}

		//注文履歴をsend,orders.order_datailテーブルに更新
		BuyDAO.buy(orderInfoModel, loginUser, cartList);

		//セッションに空のカートリストを設定
		session.setAttribute("cartList", null);

		//ログイン情報を最新に更新
		User userInfo = userDAO.getUserInfoByEmail(loginUser.getUser_email());
		session.setAttribute("loginUser", userInfo);
		return "thankyou";
	}

	private Integer findCartItemIndex(ArrayList<CartModel> cartList, Integer itemId) {
		Integer cartIndex = null;
		for (CartModel inCartItem : cartList) {
			if (inCartItem.getItem().getItem_id() == itemId) {
				cartIndex = cartList.indexOf(inCartItem);
			}
		}
		return cartIndex;
	}
}
