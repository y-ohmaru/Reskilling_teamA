package jp.co.kenfurni;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

import javax.validation.ConstraintValidator;
import javax.validation.ConstraintValidatorContext;

public class DateFormatValidator implements ConstraintValidator<DateFormat, String>{
	private static final SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy/MM/dd");

	@Override
	public void initialize(DateFormat constraintAnnotation) {}

	@Override
	public boolean isValid(String value, ConstraintValidatorContext context) {
		try {
			if(value!="") {
			String Date_String = value.replace('-', '/');
			Date date = dateFormat.parse(Date_String);
			String dateString_now = dateFormat.format(date);
			return dateString_now.equals(Date_String);
			}else {
				return true;//未入力の場合でもエラーにしない
			}
		}catch(ParseException e) {
			return false;
		}
	}
}