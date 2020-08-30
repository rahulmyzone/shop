package com.salesmanager.web.admin.controller.promotions;

import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;
import java.util.Set;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.hibernate.Hibernate;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.salesmanager.core.business.catalog.category.model.Category;
import com.salesmanager.core.business.catalog.category.service.CategoryService;
import com.salesmanager.core.business.catalog.product.model.Product;
import com.salesmanager.core.business.catalog.product.model.description.ProductDescription;
import com.salesmanager.core.business.catalog.product.service.ProductService;
import com.salesmanager.core.business.catalog.promotions.model.PromotionalVoucher;
import com.salesmanager.core.business.catalog.promotions.service.PromotionalVoucherService;
import com.salesmanager.core.business.generic.exception.ServiceException;
import com.salesmanager.core.business.merchant.model.MerchantStore;
import com.salesmanager.core.business.reference.language.model.Language;
import com.salesmanager.core.utils.ajax.AjaxPageableResponse;
import com.salesmanager.core.utils.ajax.AjaxResponse;
import com.salesmanager.web.admin.controller.ControllerConstants;
import com.salesmanager.web.admin.entity.web.Menu;
import com.salesmanager.web.constants.Constants;
import com.salesmanager.web.utils.LabelUtils;

@Controller
@RequestMapping("/admin/promotions/products")
public class PromotionalProductsController {

	private static final Logger LOGGER = LoggerFactory.getLogger(PromotionalProductsController.class);
	
	@Autowired
	private PromotionalVoucherService voucherService;
	
	@Autowired
	private ProductService productService;
	
	@Autowired
	CategoryService categoryService;
	
	@Autowired
	LabelUtils messages;
	
	@PreAuthorize("hasRole('PRODUCTS')")
	@RequestMapping(value="list.html", method=RequestMethod.GET)
	public String displayAssociatedProducts(@RequestParam("id") long id, Model model, HttpServletRequest request, HttpServletResponse response){
		try{
			setMenu(model,request);
		}catch (Exception e) {
			// TODO: handle exception
		}
		Language language = (Language)request.getAttribute("LANGUAGE");
		MerchantStore store = (MerchantStore)request.getAttribute(Constants.ADMIN_STORE);
		
		PromotionalVoucher voucher = null;
		if(store == null){
			return "redirect:/admin/promotions/list-promotions.html";
		}
		
		voucher = this.voucherService.getById(id, store);
		
		List<Category> categories = null;
		try {
			categories = categoryService.listByStore(store,language);
		} catch (ServiceException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		model.addAttribute("categories", categories);
		model.addAttribute("voucher", voucher);
		
		return  ControllerConstants.Tiles.PromotionalVoucher.promotionsProduct;
	}
	
	@SuppressWarnings({ "rawtypes", "unchecked" })
	@PreAuthorize("hasRole('PRODUCTS')")
	@RequestMapping(value="paging.html", method=RequestMethod.POST, produces="application/json")
	public @ResponseBody String pageRelatedItems(HttpServletRequest request, HttpServletResponse response) {
		MerchantStore store = (MerchantStore)request.getAttribute(Constants.ADMIN_STORE);
		String voucherId = request.getParameter("id");
		Long id = Long.parseLong(voucherId);
		PromotionalVoucher promotionalVoucher = voucherService.getById(id, store);
		Set<Product> products = promotionalVoucher.getProducts();// productService.getProductsByVoucherId(id);
		Language language = (Language)request.getAttribute("LANGUAGE");
		AjaxResponse resp = new AjaxResponse();
		try{
			if(products != null){
				for(Product p : products){
					Map entry = new HashMap();
					entry.put("productId", p.getId());
					
					ProductDescription description = p.getDescriptions().iterator().next();
					Set<ProductDescription> descriptions = p.getDescriptions();
					for(ProductDescription desc : descriptions) {
						if(desc.getLanguage().getId().intValue()==language.getId().intValue()) {
							description = desc;
						}
					}
					
					entry.put("name", description.getName());
					entry.put("sku", p.getSku());
					entry.put("available", p.isAvailable());
					resp.addDataEntry(entry);
				}
			}
			resp.setStatus(AjaxPageableResponse.RESPONSE_STATUS_SUCCESS);
		}catch (Exception e) {
			LOGGER.error("Error while paging products", e);
			resp.setStatus(AjaxPageableResponse.RESPONSE_STATUS_FAIURE);
			resp.setErrorMessage(e);
		}
		return resp.toJSONString();
	}
	
	@PreAuthorize("hasRole('PRODUCTS')")
	@RequestMapping(value="addItem.html", method=RequestMethod.POST, produces="application/json")
	public @ResponseBody String addItem(HttpServletRequest request, HttpServletResponse response) {
		Language language = (Language)request.getAttribute("LANGUAGE");
		MerchantStore store = (MerchantStore)request.getAttribute(Constants.ADMIN_STORE);
		AjaxResponse resp = new AjaxResponse();
		try{
			
			String voucherId = request.getParameter("id");
			Long id = Long.parseLong(voucherId);
			PromotionalVoucher voucher = voucherService.getById(id,store);
			
			String productId = request.getParameter("productId");
			id = Long.parseLong(productId);
			Product product = productService.getById(id);
			
			if(product==null) {
				resp.setStatus(AjaxPageableResponse.RESPONSE_STATUS_FAIURE);
				return resp.toJSONString();
			}
			
			if(product.getMerchantStore().getId().intValue()!=store.getId().intValue()) {
				resp.setStatus(AjaxPageableResponse.RESPONSE_STATUS_FAIURE);
				return resp.toJSONString();
			}
			
			
			voucher.addToProducts(product);
			
			voucherService.update(voucher);
			//product.setPromotionalVoucher(voucher);
			//productService.saveOrUpdate(product);
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
		String sProductId = request.getParameter("productId");
		String sVoucherId = request.getParameter("voucherId");
		
		MerchantStore store = (MerchantStore)request.getAttribute(Constants.ADMIN_STORE);
		
		AjaxResponse resp = new AjaxResponse();

		
		try {
			
			Long productId = Long.parseLong(sProductId);
			Long voucherId = Long.parseLong(sVoucherId);
			
			Product product = productService.getById(productId);
			
			PromotionalVoucher voucher = voucherService.getById(voucherId, store);
			if(product==null || product.getMerchantStore().getId()!=store.getId()) {

				resp.setStatusMessage(messages.getMessage("message.unauthorized", locale));
				resp.setStatus(AjaxResponse.RESPONSE_STATUS_FAIURE);			
				return resp.toJSONString();
			} 
			
			if(voucher==null || voucher.getMerchantStore().getId()!=store.getId()) {

				resp.setStatusMessage(messages.getMessage("message.unauthorized", locale));
				resp.setStatus(AjaxResponse.RESPONSE_STATUS_FAIURE);			
				return resp.toJSONString();
			} 
			voucher.getProducts().remove(product);
			voucherService.update(voucher);
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
