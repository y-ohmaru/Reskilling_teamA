package jp.co.kenfurni;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

import javax.validation.ConstraintValidator;
import javax.validation.ConstraintValidatorContext;

public class DatePastFormatValidator implements ConstraintValidator<DatePastFormat, String>{
	private static final SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy/MM/dd");

	@Override
	public void initialize(DatePastFormat constraintAnnotation) {}

	@Override
	public boolean isValid(String value, ConstraintValidatorContext context) {
		try {
			if(value!="") {
			String Date_String = value.replace('-', '/');
			Date date = dateFormat.parse(Date_String);
			return date.before(new Date());
			}else {
				return true;//未入力の場合でもエラーにしない
			}
		}catch(ParseException e) {
			return false;
		}
	}
}