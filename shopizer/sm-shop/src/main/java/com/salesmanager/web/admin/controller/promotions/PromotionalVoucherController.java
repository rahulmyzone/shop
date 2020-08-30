package com.salesmanager.web.admin.controller.promotions;

import java.math.BigDecimal;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.validation.Valid;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.ObjectError;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.salesmanager.core.business.catalog.promotions.model.PromotionalVoucher;
import com.salesmanager.core.business.catalog.promotions.service.PromotionalVoucherService;
import com.salesmanager.core.business.merchant.model.MerchantStore;
import com.salesmanager.core.business.reference.language.model.Language;
import com.salesmanager.core.utils.ProductPriceUtils;
import com.salesmanager.core.utils.ajax.AjaxResponse;
import com.salesmanager.web.admin.controller.ControllerConstants;
import com.salesmanager.web.admin.entity.web.Menu;
import com.salesmanager.web.constants.Constants;
import com.salesmanager.web.utils.DateUtil;
import com.salesmanager.web.utils.LabelUtils;


@Controller
@RequestMapping("/admin/promotions/")
public class PromotionalVoucherController {

	private static final Logger LOGGER = LoggerFactory.getLogger(PromotionalVoucherController.class);
	
	@Autowired
	private PromotionalVoucherService voucherService;
	
	@Autowired
	private ProductPriceUtils priceUtil;
	
	@Autowired
	LabelUtils messages;
	
	@PreAuthorize("hasRole('PRODUCTS')")
	@RequestMapping(value="list-promotions.html", method=RequestMethod.GET)
	public String displayPromotions(Model model, HttpServletRequest request, HttpServletResponse response){
		try{
			setMenu(model,request);
		}catch(Exception e){
			e.printStackTrace();
		}
		Language language = (Language)request.getAttribute("LANGUAGE");
		MerchantStore store = (MerchantStore)request.getAttribute(Constants.ADMIN_STORE);
		if(store == null){
			
		}
		List<PromotionalVoucher> vouchers = voucherService.listByStore(store, language);
		model.addAttribute("vouchers", vouchers);
		return ControllerConstants.Tiles.PromotionalVoucher.promotions;
	}
	
	@PreAuthorize("hasRole('PRODUCTS')")
	@RequestMapping(value="createPromotionalVoucher.html", method=RequestMethod.GET)
	public String displayProductCreate(@RequestParam("id") Long id, Model model, HttpServletRequest request, HttpServletResponse response) throws Exception {
		return displayDetails(id,model,request,response);
	}
	
	private String displayDetails(Long id, Model model, HttpServletRequest request, HttpServletResponse response){
		try{
			setMenu(model,request);
			Language language = (Language)request.getAttribute("LANGUAGE");
			MerchantStore store = (MerchantStore)request.getAttribute(Constants.ADMIN_STORE);
			PromotionalVoucher voucher = null;
			if(store == null){
				return "redirect:/admin/promotions/list-promotions.html";
			}
			
			if(id != null){
				voucher = this.voucherService.getById(id, store);
			}else{
				voucher = new PromotionalVoucher();
			}
			model.addAttribute("promotionTypes",com.salesmanager.core.business.catalog.promotions.model.PromotionalVoucher.PromotionType.values());
			model.addAttribute("promotionApplied",com.salesmanager.core.business.catalog.promotions.model.PromotionalVoucher.PromotionApplied.values());
			model.addAttribute("voucher", voucher);
		}catch(Exception e){
			e.printStackTrace();
		}
		
		return ControllerConstants.Tiles.PromotionalVoucher.createPromotions;
	}
	
	@InitBinder
	public void initBinder(WebDataBinder dataBinder){
		SimpleDateFormat dateFormat = new SimpleDateFormat("MM-dd-yyyy");
		dateFormat.setLenient(true);
		dataBinder.registerCustomEditor(Date.class, new CustomDateEditor(dateFormat, true));
	}
	
	@PreAuthorize("hasRole('PRODUCTS')")
	@RequestMapping(value="savePromotionalVoucher.html", method=RequestMethod.POST)
	public String save(@Valid @ModelAttribute("voucher") PromotionalVoucher  voucher, BindingResult result, Model model, HttpServletRequest request, Locale locale) throws Exception {
		
		Language language = (Language)request.getAttribute("LANGUAGE");
		
		//display menu
		setMenu(model,request);
		
		MerchantStore store = (MerchantStore)request.getAttribute(Constants.ADMIN_STORE);
		voucher.setMerchantStore(store);
		BigDecimal priceValue = null;
		try{
			priceValue = priceUtil.getAmount(voucher.getValue().toString());
		}catch (Exception e) {
			ObjectError error = new ObjectError("voucherValue",messages.getMessage("NotEmpty.promotionalVoucher.value", locale));
			result.addError(error);
		}
		
		Date promoValidTill = null;
		
		///try{
			//DateUtil.getDate(voucher.getPromoValidTill().toString());
		//}catch (Exception e) {
		////	ObjectError error = new ObjectError("voucherValidTill",messages.getMessage("NotEmpty.promotionalVoucher.validTill", locale));
		//	result.addError(error);
		//}
		try{
			voucherService.saveOrUpdate(voucher);
		}catch (Exception e) {
			ObjectError error = new ObjectError("Voucher",messages.getMessage("error.promotionalVoucher", locale));
			result.addError(error);
		}
		
		return ControllerConstants.Tiles.PromotionalVoucher.createPromotions;
	}
	
	@SuppressWarnings({ "unchecked"})
	@PreAuthorize("hasRole('PRODUCTS')")
	@RequestMapping(value="page.html", method=RequestMethod.POST, produces="application/json")
	public @ResponseBody String pageStaticContent(HttpServletRequest request, HttpServletResponse response) {
		AjaxResponse resp = new AjaxResponse();
		try {
			//setMenu(model, request);
			Language language = (Language) request.getAttribute("LANGUAGE");
			MerchantStore store = (MerchantStore) request.getAttribute(Constants.ADMIN_STORE);
			if (store == null) {

			}
			List<PromotionalVoucher> vouchers = voucherService.listByStore(store, language);
			for (PromotionalVoucher promotionalVoucher : vouchers) {
				@SuppressWarnings("rawtypes")
				Map entry = new HashMap();
				entry.put("id", promotionalVoucher.getId());
				entry.put("code", promotionalVoucher.getPromoCode());
				entry.put("name", promotionalVoucher.getDescription());
				resp.addDataEntry(entry);
			}
			resp.setStatus(AjaxResponse.RESPONSE_STATUS_SUCCESS);
		} catch (Exception e) {
			LOGGER.error("Error while paging content", e);
			resp.setStatus(AjaxResponse.RESPONSE_STATUS_FAIURE);
		}
		return resp.toJSONString();
	}
	
private void setMenu(Model model, HttpServletRequest request) throws Exception {
		
		//display menu
		Map<String,String> activeMenus = new HashMap<String,String>();
		activeMenus.put("promotions", "promotions");
		activeMenus.put("promotional-code-list", "promotional-code-list");
		
		@SuppressWarnings("unchecked")
		Map<String, Menu> menus = (Map<String, Menu>)request.getAttribute("MENUMAP");
		
		Menu currentMenu = (Menu)menus.get("promotions");
		model.addAttribute("currentMenu",currentMenu);
		model.addAttribute("activeMenus",activeMenus);
		//
		
	}
}
