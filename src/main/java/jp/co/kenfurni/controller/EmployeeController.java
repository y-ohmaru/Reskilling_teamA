package jp.co.kenfurni.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import jp.co.kenfurni.dao.ItemDAO;
import jp.co.kenfurni.dao.LineupDAO;
import jp.co.kenfurni.entity.Item;
import jp.co.kenfurni.entity.Lineup;

@Controller
@RequestMapping("/emp")
public class EmployeeController {

	@Autowired
	private ItemDAO itemDAO;
	@Autowired
	private LineupDAO lineupDAO;

	//従業員ラインナップ登録画面表示
	@RequestMapping(value = "/toRegist", method = RequestMethod.GET)
	public String toEmpRegist(Model model) {
		//DBからitemの全リストをセットするgetAllItemList
		List<Item> itemList = itemDAO.getAllItemList();
		//modelにitemListという名前で情報をセットする。
		model.addAttribute("itemList", itemList);
		model.addAttribute("lineup", new Lineup());
		return "lineupRegist";

	}

	@RequestMapping(value = "/regist", method = RequestMethod.POST)
	public String EmpRegist(@ModelAttribute Lineup lineup,Model model) {

		//画像情報を設定
		Item item = itemDAO.getItemByItemId(lineup.getItem_id());
		lineup.setLineup_image(item.getItem_png());

		//DB登録のためのメソッド呼び出し
		int numberOfRow = lineupDAO.insertLineupInfo(lineup);
		//ユーザー登録失敗時
		if(numberOfRow==0) {
			//エラーの際の処理
			return "redirect:/emp/toRegist";
		}

		return "redirect:/emp/toRegist";
	}
}
