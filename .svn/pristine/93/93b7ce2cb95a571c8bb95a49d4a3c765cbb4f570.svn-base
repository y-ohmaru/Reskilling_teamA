package jp.co.kenfurni.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import jp.co.kenfurni.dao.UserDAO;
import jp.co.kenfurni.entity.User;
import jp.co.kenfurni.model.UserInfoModel;
/**
 * Handles requests for the application home page.
 */
@Controller
@RequestMapping("/user")
public class UserController {

	@Autowired
	private UserDAO userdao;
	//ユーザー新規登録画面表示
	@RequestMapping(value = "/regist", method = RequestMethod.GET)
	public String toUserRegist(Model model,HttpSession session) {
		User loginUser = (User) session.getAttribute("loginUser");
		model.addAttribute("userInfoModel", new UserInfoModel());
		if (loginUser != null) {
			// ログイン済みの場合
			model.addAttribute("already_login",true);
			return "userRegist";
	    }
		return "userRegist";
	}

	//「登録」ボタン押下時
	@RequestMapping(value = "/registComplete", method = RequestMethod.POST)
	public String regist(@Validated @ModelAttribute UserInfoModel userInfoModel,BindingResult result,Model model, HttpServletRequest request) {
		//入力内容が不正な場合
		if(result.hasErrors()) {
			return "userRegist";//元の画面に戻るリダイレクトに再設定
		}
		//ユーザークラスに登録情報をセット
		User user =new User();
		user.setUser_email(userInfoModel.getUser_email());
		user.setUser_name(userInfoModel.getUser_name());
		user.setUser_password(userInfoModel.getUser_password());
		if(userInfoModel.getUser_birth()=="") {
			user.setUser_birth(null);
		}else {
			user.setUser_birth(userInfoModel.getUser_birth());
		}
		user.setUser_gender(userInfoModel.getUser_gender());
		user.setUser_address(userInfoModel.getUser_address());
		user.setUser_card(userInfoModel.getUser_card());
		user.setUser_phone(userInfoModel.getUser_phone());
		//ユーザー情報登録
		int numberOfRow=userdao.insertUserInfo(user);
		//ユーザー登録失敗時
		if(numberOfRow==0) {
			return "userRegist";
		}
		//ユーザー新規登録成功時
		HttpSession session=request.getSession(true);
		session.setAttribute("sucsess",true);
		//セッションにユーザー情報を追加
		User userInfo=userdao.getUserInfoByEmail(userInfoModel.getUser_email());
		session.setAttribute("loginUser", userInfo);
		return "userRegist";
	}

	//※後で消す。GETでユーザー情報編集画面表示
	@RequestMapping(value = "/edit", method = RequestMethod.GET)
	public String toUserEditGet(@ModelAttribute UserInfoModel userInfoModel,Model model,HttpServletRequest request) {
	      if (!model.containsAttribute("UserConfirmModel")) {
	          model.addAttribute("UserConfirmModel", new UserInfoModel());
	        }
		return "userEdit";
	}

	//編集画面の「編集」ボタン押下
	@RequestMapping(value = "/editComplete", method = RequestMethod.POST)
	public String edit(@Validated @ModelAttribute UserInfoModel userInfoModel,BindingResult result,Model model,
			HttpServletRequest request,RedirectAttributes ra) {

		//入力内容が不正な場合
		if(result.hasErrors()) {
			//エラーの内容を渡す
			ra.addFlashAttribute("org.springframework.validation.BindingResult.userInfoModel", result);
			ra.addFlashAttribute("UserConfirmModel", userInfoModel);
			//元の画面に戻るリダイレクトに再設定
			return "redirect:/user/edit";
		}
		//ユーザーidを取得
		HttpSession session=request.getSession(true);
		User login_user=(User) session.getAttribute("loginUser");
		int userid=login_user.getUser_id();
		//ユーザークラスに登録情報をセット
		User user =new User();
		user.setUser_id(userid);
		user.setUser_email(userInfoModel.getUser_email());
		user.setUser_name(userInfoModel.getUser_name());
		user.setUser_password(userInfoModel.getUser_password());
		if(userInfoModel.getUser_birth()=="") {
			user.setUser_birth(null);
		}else {
			user.setUser_birth(userInfoModel.getUser_birth());
		}
		user.setUser_gender(userInfoModel.getUser_gender());
		user.setUser_address(userInfoModel.getUser_address());
		user.setUser_card(userInfoModel.getUser_card());
		user.setUser_phone(userInfoModel.getUser_phone());
		//ユーザー情報登録
		int numberOfRow=userdao.updateUserInfo_edit(user);
		//ユーザー登録失敗時
		if(numberOfRow==0) {
			return "userEdit";
		}
		//ユーザー編集成功時
		ra.addFlashAttribute("UserConfirmModel",user);
		ra.addFlashAttribute("sucsess_edit",true);
		session.setAttribute("sucsess_edit", true);
		//セッションのユーザー情報を更新
		session.setAttribute("loginUser", user);
		return "redirect:/user/edit";
	}

	//確認画面の「編集」ボタン押下
	@RequestMapping(value = "/edit", method = RequestMethod.POST)
	public String toUserEdit(Model model,HttpServletRequest request) {
		HttpSession session=request.getSession(true);
			User userConfirmModel=(User) session.getAttribute("loginUser");
			String loginUserinfo = userConfirmModel.getUser_email();
			model.addAttribute("UserConfirmModel",userdao.getUserInfoByEmail(loginUserinfo));
			String gender=userConfirmModel.getUser_gender();
			model.addAttribute("gender", gender);
			session.removeAttribute("sucsess_edit");
			return "userEdit";
	}

	//「退会」ボタン押下
	@RequestMapping(value = "/exit",method = RequestMethod.POST)
	public String exit(Model model,HttpServletRequest request) {
		//ユーザー退会時
		HttpSession session=request.getSession(true);
		User userConfirmModel=(User) session.getAttribute("loginUser");
		//退会フラグに１を代入する
		int numberOfRow=userdao.insertUserInfo_exit(userConfirmModel);
		//ユーザー退会失敗時
		if(numberOfRow==0) {
			return "/confirm";
		}
		//セッションオブジェクトを破棄
		session.invalidate();
		model.addAttribute("logout",true);
		return "userConfirm";
	}
}