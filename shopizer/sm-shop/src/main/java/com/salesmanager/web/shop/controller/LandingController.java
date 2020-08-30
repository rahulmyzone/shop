package com.salesmanager.web.shop.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.salesmanager.core.business.catalog.product.model.Product;
import com.salesmanager.core.business.catalog.product.model.relationship.ProductRelationship;
import com.salesmanager.core.business.catalog.product.model.relationship.ProductRelationshipType;
import com.salesmanager.core.business.catalog.product.service.PricingService;
import com.salesmanager.core.business.catalog.product.service.relationship.ProductRelationshipService;
import com.salesmanager.core.business.content.model.Content;
import com.salesmanager.core.business.content.model.ContentDescription;
import com.salesmanager.core.business.content.service.ContentService;
import com.salesmanager.core.business.generic.exception.ConversionException;
import com.salesmanager.core.business.generic.exception.ServiceException;
import com.salesmanager.core.business.merchant.model.MerchantStore;
import com.salesmanager.core.business.merchant.service.MerchantStoreService;
import com.salesmanager.core.business.reference.language.model.Language;
import com.salesmanager.core.utils.CacheUtils;
import com.salesmanager.web.constants.Constants;
import com.salesmanager.web.entity.catalog.product.ReadableProduct;
import com.salesmanager.web.entity.shop.Breadcrumb;
import com.salesmanager.web.entity.shop.BreadcrumbItem;
import com.salesmanager.web.entity.shop.BreadcrumbItemType;
import com.salesmanager.web.entity.shop.PageInformation;
import com.salesmanager.web.populator.catalog.ReadableProductPopulator;
import com.salesmanager.web.utils.LabelUtils;

@Controller
public class LandingController {
	
	
	private final static String LANDING_PAGE = "LANDING_PAGE";
	
	
	@Autowired
	private ContentService contentService;
	
	@Autowired
	private ProductRelationshipService productRelationshipService;

	
	@Autowired
	private LabelUtils messages;
	
	@Autowired
	private PricingService pricingService;
	
	@Autowired
	private MerchantStoreService merchantService;
	
	@Autowired
	private CacheUtils cache;
	
	private static final Logger LOGGER = LoggerFactory.getLogger(LandingController.class);
	private final static String HOME_LINK_CODE="HOME";
	
	@RequestMapping(value={Constants.SHOP_URI + "/home.html",Constants.SHOP_URI +"/", Constants.SHOP_URI}, method=RequestMethod.GET)
	public String displayLanding(Model model, HttpServletRequest request, HttpServletResponse response, Locale locale) throws Exception {
		
		Language language = (Language)request.getAttribute(Constants.LANGUAGE);
		
		MerchantStore store = (MerchantStore)request.getAttribute(Constants.MERCHANT_STORE);

		request.setAttribute(Constants.LINK_CODE, HOME_LINK_CODE);
		
		Content content = contentService.getByCode(LANDING_PAGE, store, language);
		
		/** Rebuild breadcrumb **/
		BreadcrumbItem item = new BreadcrumbItem();
		item.setItemType(BreadcrumbItemType.HOME);
		item.setLabel(messages.getMessage(Constants.HOME_MENU_KEY, locale));
		item.setUrl(Constants.HOME_URL);

		
		Breadcrumb breadCrumb = new Breadcrumb();
		breadCrumb.setLanguage(language);
		
		List<BreadcrumbItem> items = new ArrayList<BreadcrumbItem>();
		items.add(item);
		
		breadCrumb.setBreadCrumbs(items);
		request.getSession().setAttribute(Constants.BREADCRUMB, breadCrumb);
		request.setAttribute(Constants.BREADCRUMB, breadCrumb);
		/** **/
		
		if(content!=null) {
			ContentDescription description = content.getDescription();
			model.addAttribute("page",description);
			PageInformation pageInformation = new PageInformation();
			pageInformation.setPageTitle(description.getName());
			pageInformation.setPageDescription(description.getMetatagDescription());
			pageInformation.setPageKeywords(description.getMetatagKeywords());
			request.setAttribute(Constants.REQUEST_PAGE_INFORMATION, pageInformation);
		}
		/*ReadableProductPopulator populator = new ReadableProductPopulator();
		populator.setPricingService(pricingService);*/

		
		//featured items
		/*List<ProductRelationship> relationships = productRelationshipService.getByType(store, ProductRelationshipType.FEATURED_ITEM, language);
		List<ReadableProduct> featuredItems = new ArrayList<ReadableProduct>();
		for(ProductRelationship relationship : relationships) {
			
			Product product = relationship.getRelatedProduct();
			ReadableProduct proxyProduct = populator.populate(product, new ReadableProduct(), store, language);

			featuredItems.add(proxyProduct);
		}*/
		
		/*StringBuilder relatedItemsCacheKey = new StringBuilder();
		relatedItemsCacheKey
		.append(store.getId())
		.append("_")
		.append(Constants.RECOMMENDED_DEALS_CACHE_KEY)
		.append("-")
		.append(language.getCode());
		
		StringBuilder relatedItemsMissed = new StringBuilder();
		relatedItemsMissed
		.append(relatedItemsCacheKey.toString())
		.append(Constants.MISSED_CACHE_KEY);
		
		Map<Long,List<ReadableProduct>> relatedItemsMap = null;
		List<ReadableProduct> recomDeals = null;
		
		if(store.isUseCache()) {

			//get from the cache
			relatedItemsMap = (Map<Long,List<ReadableProduct>>) cache.getFromCache(relatedItemsCacheKey.toString());
			if(relatedItemsMap==null) {
				//get from missed cache
				//Boolean missedContent = (Boolean)cache.getFromCache(relatedItemsMissed.toString());

				//if(missedContent==null) {
					//relatedItems = relatedItems(store, product, language);
					recomDeals = getRecommendedDeals(store, language);
					if(recomDeals!=null) {
						relatedItemsMap = new HashMap<Long,List<ReadableProduct>>();
						relatedItemsMap.put(new Long(store.getId()), recomDeals);
						cache.putInCache(relatedItemsMap, relatedItemsCacheKey.toString());
					} else {
						//cache.putInCache(new Boolean(true), relatedItemsMissed.toString());
					}
				//}
			} else {
				recomDeals = relatedItemsMap.get(new Long(store.getId()));
			}
		} else {
			recomDeals = getRecommendedDeals(store, language);
		}*/
		
		//model.addAttribute("featuredItems", featuredItems);
		//model.addAttribute(ProductRelationshipType.RECOMMENDED_DEALS.name(), recomDeals);
		
		/** template **/
		StringBuilder template = new StringBuilder().append("landing.").append(store.getStoreTemplate());
		return template.toString();
	}
	
	@RequestMapping(value={Constants.SHOP_URI + "/stub.html"}, method=RequestMethod.GET)
	public String displayHomeStub(Model model, HttpServletRequest request, HttpServletResponse response, Locale locale) throws Exception {
		return "index";
	}
	
	@RequestMapping( value=Constants.SHOP_URI + "/{store}", method=RequestMethod.GET)
	public String displayStoreLanding(@PathVariable final String store, HttpServletRequest request, HttpServletResponse response) {
		
		try {
			
			request.getSession().invalidate();
			request.getSession().removeAttribute(Constants.MERCHANT_STORE);
			
			MerchantStore merchantStore = merchantService.getByCode(store);
			if(merchantStore!=null) {
				request.getSession().setAttribute(Constants.MERCHANT_STORE, merchantStore);
			} else {
				LOGGER.error("MerchantStore does not exist for store code " + store);
			}
			
		} catch(Exception e) {
			LOGGER.error("Error occured while getting store code " + store, e);
		}
		

		
		return "redirect:" + Constants.SHOP_URI;
	}
		
	private List<ReadableProduct> getRecommendedDeals(MerchantStore store, Language language) throws ServiceException, ConversionException{
		//Recommended items
				ReadableProductPopulator populator = new ReadableProductPopulator();
				List<ProductRelationship> recomRelationships = productRelationshipService.getByType(store, ProductRelationshipType.RECOMMENDED_DEALS, language);
				List<ReadableProduct> recomDeals = new ArrayList<ReadableProduct>();
				for(ProductRelationship relationship : recomRelationships) {
							
					Product product = relationship.getRelatedProduct();
					populator.setPricingService(pricingService);
					ReadableProduct proxyProduct = populator.populate(product, new ReadableProduct(), store, language);

					recomDeals.add(proxyProduct);
				}
				return recomDeals;
	}

}
