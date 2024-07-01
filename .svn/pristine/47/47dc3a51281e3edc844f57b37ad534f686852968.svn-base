package jp.co.kenfurni.controller;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.SessionAttributes;

import jp.co.kenfurni.dao.ItemDAO;
import jp.co.kenfurni.dao.LineupDAO;
import jp.co.kenfurni.entity.Item;
import jp.co.kenfurni.entity.Lineup;
import jp.co.kenfurni.entity.User;
import jp.co.kenfurni.model.CartModel;

@Controller
@SessionAttributes("Item")
@RequestMapping("/item")
public class ItemController {
	@Autowired
	private ItemDAO itemDAO;
	@Autowired
	private LineupDAO lineupDAO;

	//「検索」ボタン押下時
	@RequestMapping(value = "/search", method = RequestMethod.POST)
	public String search(@ModelAttribute Item item, Model model) {
		List<Item> itemList = itemDAO.getItemSpace(item.getItem_name());
		if (itemList.isEmpty()) {
			model.addAttribute("message", "該当の商品はみつかりませんでした。");
		} else {
			List<Lineup> lineupList = lineupDAO.getTopLineupList();
			model.addAttribute("lineupList", lineupList);
			model.addAttribute("searchResult", itemList);
		}
		return "itemSearch";
	}

	// 商品検索画面から「カートに入れる」ボタン押下時
	@RequestMapping(value = "/addSearch", method = RequestMethod.POST)
	public String searchToCart(@ModelAttribute Item item, @RequestParam("count") int count, HttpSession session) {
		// ItemDAOを使ってitem_Idに対応する商品情報を取得
		Item addCartItem = itemDAO.getItemByItemId(item.getItem_id());

		User loginUser = (User) session.getAttribute("loginUser");
		    if (loginUser == null) {
		  // ログインしていない場合、ログインページにリダイレクト
		        return "redirect:/login";
		    }
		//CartModelに値を設定
		CartModel cartModel = new CartModel();
		cartModel.setItem(addCartItem);
		cartModel.setCount(count);

		// セッションからカートを取得(ない場合は作成)
		@SuppressWarnings("unchecked")
		ArrayList<CartModel> cartList = (ArrayList<CartModel>) session.getAttribute("cartList");
		if (cartList == null) {
			cartList = new ArrayList<CartModel>();
		}

		//カート内にすでに商品がある場合→更新
		//カート内に商品がある場合→新規登録
		Integer cartIndex = null; //カートリストの要素番号
		for (CartModel inCartItem : cartList) {
			if (cartModel.getItem().getItem_id() == inCartItem.getItem().getItem_id()) {
				cartIndex = cartList.indexOf(inCartItem); //リストに同じ商品が入っていた場合、要素番号を取得
			}
		}
		if (cartIndex != null) {
			//cartIntexがnullでないとき(カート内に同じ商品があるとき)
			cartList.set(cartIndex, cartModel); //更新
		} else {
			//cartIntexがnullのとき(カート内に同じ商品がないとき)
			cartList.add(cartModel); //追加
		}
		//セッションのカートを更新
		session.setAttribute("cartList", cartList);

		// 商品検索画面にリダイレクト
	        return "redirect:/item/search";
	}

	// 商品詳細画面から「カートに入れる」ボタン押下時
		@RequestMapping(value = "/addDetail", method = RequestMethod.POST)
		public String detailToCart(@ModelAttribute Item item,Model model, @RequestParam("count") int count, HttpSession session) {
			 User loginUser = (User) session.getAttribute("loginUser");
			    if (loginUser == null) {
			  // ログインしていない場合、ログインページにリダイレクト
			        return "redirect:/login";
			    }

			// ItemDAOを使ってitem_Idに対応する商品情報を取得
			Item addCartItem = itemDAO.getItemByItemId(item.getItem_id());

			//CartModelに値を設定
			CartModel cartModel = new CartModel();
			cartModel.setItem(addCartItem);
			cartModel.setCount(count);

			// セッションからカートを取得(ない場合は作成)
			@SuppressWarnings("unchecked")
			ArrayList<CartModel> cartList = (ArrayList<CartModel>) session.getAttribute("cartList");
			if (cartList == null) {
				cartList = new ArrayList<CartModel>();
			}

			//カート内にすでに商品がある場合→更新
			//カート内に商品がある場合→新規登録
			Integer cartIndex = null; //カートリストの要素番号
			for (CartModel inCartItem : cartList) {
				if (cartModel.getItem().getItem_id() == inCartItem.getItem().getItem_id()) {
					cartIndex = cartList.indexOf(inCartItem); //リストに同じ商品が入っていた場合、要素番号を取得
				}
			}
			if (cartIndex != null) {
				//cartIntexがnullでないとき(カート内に同じ商品があるとき)
				cartList.set(cartIndex, cartModel); //更新
			} else {
				//cartIntexがnullのとき(カート内に同じ商品がないとき)
				cartList.add(cartModel); //追加
			}

			session.setAttribute("cartList", cartList);

			 item = itemDAO.getItemByItemId(item.getItem_id());
		     model.addAttribute("item", item);
		  // 商品詳細画面にリダイレクト
			return "itemDetail";
		}


	//商品名押下時(商品詳細画面へ遷移)
	@RequestMapping(value = "/detail", method = RequestMethod.POST)
	public String toItemDetail(@ModelAttribute Item item, Model model) {
		item = itemDAO.getItemByItemId(item.getItem_id());

		if (item == null) {
			model.addAttribute("message", "該当データがありません");
		} else {
			List<Item> itemList = new ArrayList<Item>();
			model.addAttribute(item);
			model.addAttribute("itemList", itemList);
		}
		return "itemDetail";
	}

	//商品詳細画面のURLに直接アクセス時(商品検索画面へリダイレクト)
	@RequestMapping(value = "/detail", method = RequestMethod.GET)
	public String reItemSearch(Model model) {

		return "redirect:/item/search";
	}
}
