package com.salesmanager.core.Util;

import java.math.BigDecimal;
import java.math.RoundingMode;

public class CoreUtils {

	public static BigDecimal subtractPercent(BigDecimal amount, BigDecimal percent){
		BigDecimal calc = new BigDecimal(0);
		calc.setScale(2, RoundingMode.HALF_UP);
		calc = amount.multiply(percent).divide(new BigDecimal(100));
		calc = amount.subtract(calc);
		return calc;
	}
	
	public static BigDecimal subtract(BigDecimal amount, BigDecimal subtrahend){
		BigDecimal calc = new BigDecimal(0);
		calc.setScale(2, RoundingMode.HALF_UP);
		calc = amount.subtract(subtrahend);
		return calc;
	}
}
