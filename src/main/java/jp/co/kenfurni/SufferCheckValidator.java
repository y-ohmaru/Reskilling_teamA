package jp.co.kenfurni;

import javax.validation.ConstraintValidator;
import javax.validation.ConstraintValidatorContext;

import org.springframework.beans.factory.annotation.Autowired;

import jp.co.kenfurni.dao.UserDAO;

public class SufferCheckValidator implements ConstraintValidator<SufferCheck, String>{

	@Override
	public void initialize(SufferCheck constraintAnnotation) {}

	@Autowired
	private UserDAO userdao;

	@Override
	public boolean isValid(String value, ConstraintValidatorContext context) {
		if(userdao.CheckUserInfoByEmail(value)==0) {
			return true;
		}else {
			return false;
		}
	}
}
