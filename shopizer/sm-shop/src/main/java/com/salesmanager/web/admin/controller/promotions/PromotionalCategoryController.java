package com.salesmanager.web.admin.controller.promotions;

import java.util.ArrayList;
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
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.salesmanager.core.business.catalog.category.model.Category;
import com.salesmanager.core.business.catalog.category.service.CategoryService;
import com.salesmanager.core.business.catalog.product.model.Product;
import com.salesmanager.core.business.catalog.promotions.model.PromotionalVoucher;
import com.salesmanager.core.business.catalog.promotions.service.PromotionalVoucherService;
import com.salesmanager.core.business.merchant.model.MerchantStore;
import com.salesmanager.core.business.reference.language.model.Language;
import com.salesmanager.core.utils.ajax.AjaxPageableResponse;
import com.salesmanager.core.utils.ajax.AjaxResponse;
import com.salesmanager.web.admin.controller.ControllerConstants;
import com.salesmanager.web.admin.entity.catalog.Keyword;
import com.salesmanager.web.admin.entity.web.Menu;
import com.salesmanager.web.constants.Constants;
import com.salesmanager.web.utils.LabelUtils;

@Controller
@RequestMapping("/admin/promotions/categories")
public class PromotionalCategoryController {

	private static final Logger LOGGER = LoggerFactory.getLogger(PromotionalCategoryController.class);
	
	@Autowired
	private PromotionalVoucherService promotionalVoucherService;
	
	@Autowired
	private CategoryService categoryService;
	
	@Autowired
	LabelUtils messages;
	
	@PreAuthorize("hasRole('PRODUCTS')")
	@RequestMapping(value={"list.html"}, method=RequestMethod.GET)
	public String displayKeywords(@RequestParam("id") long id, Model model, HttpServletRequest request, HttpServletResponse response) throws Exception {
		try{
			setMenu(model,request);
			MerchantStore store = (MerchantStore)request.getAttribute(Constants.ADMIN_STORE);
			Language language = (Language)request.getAttribute("LANGUAGE");
			PromotionalVoucher promotionalVoucher = promotionalVoucherService.getById(id,store);
			List<Category> categories = categoryService.listByStore(store,language);
			model.addAttribute("voucher", promotionalVoucher);
			model.addAttribute("categories", categories);
		}catch (Exception e) {
			// TODO: handle exception
		}
		return ControllerConstants.Tiles.PromotionalVoucher.promotionsCategory;
	}
	
	@PreAuthorize("hasRole('PRODUCTS')")
	@RequestMapping(value="addCategory.html", method=RequestMethod.POST)
	public String addCategory(@RequestParam("voucherId") long voucherId, @RequestParam("id") long id, @Valid @ModelAttribute("voucher") PromotionalVoucher voucher,final BindingResult bindingResult,final Model model, final HttpServletRequest request, Locale locale) throws Exception{
		
		try{
			setMenu(model,request);
			MerchantStore store = (MerchantStore)request.getAttribute(Constants.ADMIN_STORE);
			Language language = (Language)request.getAttribute("LANGUAGE");
			voucher = promotionalVoucherService.getById(voucherId,store);
			Category category = categoryService.getByLanguage(id, language);
			List<Category> categories = categoryService.listByStore(store,language);
			model.addAttribute("voucher", voucher);
			model.addAttribute("categories", categories);
			
			voucher.addToCategories(category);
			promotionalVoucherService.saveOrUpdate(voucher);
		}catch (Exception e) {
			// TODO: handle exception
		}
		return ControllerConstants.Tiles.PromotionalVoucher.promotionsCategory;
	}
	
	@SuppressWarnings({ "rawtypes", "unchecked" })
	@PreAuthorize("hasRole('PRODUCTS')")
	@RequestMapping(value="paging.html", method=RequestMethod.POST, produces="application/json")
	@ResponseBody
	public String paging(final HttpServletRequest request, Locale locale) throws Exception{
		String id = request.getParameter("id");
		MerchantStore store = (MerchantStore)request.getAttribute(Constants.ADMIN_STORE);
		AjaxResponse resp = new AjaxResponse();
		try{
			Long vId = Long.parseLong(id);
			PromotionalVoucher voucher = promotionalVoucherService.getById(vId,store);
			for(Category category : voucher.getCategories()){
				Map entry = new HashMap();
				entry.put("categoryId", category.getId());
				entry.put("name", category.getDescriptions().get(0).getName());
				resp.addDataEntry(entry);
			}
			resp.setStatus(AjaxPageableResponse.RESPONSE_STATUS_SUCCESS);
		}catch (Exception e) {
			LOGGER.error("Error while paging products", e);
			resp.setStatus(AjaxPageableResponse.RESPONSE_STATUS_FAIURE);
			resp.setErrorMessage(e);
		}
		
		return resp.toJSONString();
	}
	
	@SuppressWarnings({ "rawtypes", "unchecked" })
	@PreAuthorize("hasRole('PRODUCTS')")
	@RequestMapping(value="remove.html", method=RequestMethod.POST, produces="application/json")
	@ResponseBody
	public String remove(final HttpServletRequest request, Locale locale) throws Exception{
		String sCategoryid = request.getParameter("categoryId");
		String sVoucherId = request.getParameter("voucherId");
		
		MerchantStore store = (MerchantStore)request.getAttribute(Constants.ADMIN_STORE);
		
		AjaxResponse resp = new AjaxResponse();

		
		try {
			
			Long categoryId = Long.parseLong(sCategoryid);
			Long voucherId = Long.parseLong(sVoucherId);
			
			Category category = categoryService.getById(categoryId);
			//Product product = productService.getById(productId);
			PromotionalVoucher voucher = promotionalVoucherService.getById(voucherId, store);
			if(category==null || category.getMerchantStore().getId()!=store.getId()) {

				resp.setStatusMessage(messages.getMessage("message.unauthorized", locale));
				resp.setStatus(AjaxResponse.RESPONSE_STATUS_FAIURE);			
				return resp.toJSONString();
			} 
			
			if(voucher==null || voucher.getMerchantStore().getId()!=store.getId()) {

				resp.setStatusMessage(messages.getMessage("message.unauthorized", locale));
				resp.setStatus(AjaxResponse.RESPONSE_STATUS_FAIURE);			
				return resp.toJSONString();
			} 
			voucher.getCategories().remove(category);
			promotionalVoucherService.update(voucher);
			resp.setStatus(AjaxResponse.RESPONSE_OPERATION_COMPLETED);
		} catch (Exception e) {
			LOGGER.error("Error while deleting category", e);
			resp.setStatus(AjaxResponse.RESPONSE_STATUS_FAIURE);
			resp.setErrorMessage(e);
		}
		
		String returnString = resp.toJSONString();
		
		return returnString;
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
