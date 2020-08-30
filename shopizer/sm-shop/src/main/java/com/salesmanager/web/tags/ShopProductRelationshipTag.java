package com.salesmanager.web.tags;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.config.AutowireCapableBeanFactory;
import org.springframework.web.context.WebApplicationContext;
import org.springframework.web.servlet.tags.RequestContextAwareTag;

import com.salesmanager.core.business.catalog.product.model.Product;
import com.salesmanager.core.business.catalog.product.model.relationship.ProductRelationship;
import com.salesmanager.core.business.catalog.product.model.relationship.ProductRelationshipType;
import com.salesmanager.core.business.catalog.product.service.PricingService;
import com.salesmanager.core.business.catalog.product.service.ProductService;
import com.salesmanager.core.business.catalog.product.service.relationship.ProductRelationshipService;
import com.salesmanager.core.business.merchant.model.MerchantStore;
import com.salesmanager.core.business.reference.language.model.Language;
import com.salesmanager.core.utils.CacheUtils;
import com.salesmanager.web.constants.Constants;
import com.salesmanager.web.entity.catalog.product.ReadableProduct;
import com.salesmanager.web.populator.catalog.ReadableProductPopulator;
import com.salesmanager.web.util.Utility;

public class ShopProductRelationshipTag extends RequestContextAwareTag  {
	
	

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	private static final Logger LOGGER = LoggerFactory.getLogger(ShopProductRelationshipTag.class);

	@Autowired
	private ProductRelationshipService productRelationshipService;
	
	@Autowired
	private ProductService productService;
	
	@Autowired
	private PricingService pricingService;
	
	@Autowired
	private CacheUtils cache;
	
	private Long productId;
	
	
	private String groupName;
	
	private boolean split = false;

	private Integer splitLength;

	public String getGroupName() {
		return groupName;
	}


	public void setGroupName(String groupName) {
		this.groupName = groupName;
	}


	@SuppressWarnings("unchecked")
	@Override
	protected int doStartTagInternal() throws Exception {
		if (productRelationshipService == null || pricingService==null) {
			LOGGER.debug("Autowiring ProductRelationshipService");
            WebApplicationContext wac = getRequestContext().getWebApplicationContext();
            AutowireCapableBeanFactory factory = wac.getAutowireCapableBeanFactory();
            factory.autowireBean(this);
        }
		
		HttpServletRequest request = (HttpServletRequest) pageContext
		.getRequest();

		MerchantStore store = (MerchantStore)request.getAttribute(Constants.MERCHANT_STORE);
		
		Language language = (Language)request.getAttribute(Constants.LANGUAGE);
		if(productId == null){
			StringBuilder groupKey = new StringBuilder();
			groupKey
			.append(store.getId())
			.append("_")
			.append(Constants.PRODUCTS_GROUP_CACHE_KEY)
			.append("-")
			.append(this.getGroupName())
			.append("_")
			.append(language.getCode());
			
			StringBuilder groupKeyMissed = new StringBuilder();
			groupKeyMissed
			.append(groupKey.toString())
			.append(Constants.MISSED_CACHE_KEY);
			
			List<ReadableProduct> objects = null;
			
			if(store.isUseCache()) {
			
				//get from the cache
				objects = (List<ReadableProduct>) cache.getFromCache(groupKey.toString());
				Boolean missedContent = null;
				//if(objects==null) {
					//get from missed cache
				//	missedContent = (Boolean)cache.getFromCache(groupKeyMissed.toString());
				//}
				
				if(objects==null && missedContent==null) {
					objects = getProducts(request);
	
					//put in cache
					cache.putInCache(objects, groupKey.toString());
						
				} else {
					//put in missed cache
					//cache.putInCache(new Boolean(true), groupKeyMissed.toString());
				}
			
			} else {
				objects = getProducts(request);
			}
			if(objects!=null && objects.size()>0) {
				request.setAttribute(this.getGroupName(), objects);
				if(split){
					int size = Utility.getNumPages(objects.size(),splitLength);
					List<List<ReadableProduct>> splitList = Utility.chopped(objects, size);
					request.setAttribute(this.getGroupName()+"_SPLITTED", splitList);
				}
			}
		}else{
			List<ReadableProduct> objects = null;
			objects = getProducts(request);
			if(objects!=null && objects.size()>0) {
				request.setAttribute(this.getGroupName(), objects);
				if(split){
					int size = Utility.getNumPages(objects.size(),splitLength);
					List<List<ReadableProduct>> splitList = Utility.chopped(objects, size);
					request.setAttribute(this.getGroupName()+"_SPLITTED", splitList);
				}
			}
		}
		return SKIP_BODY;

	}


	public int doEndTag() {
		return EVAL_PAGE;
	}
	
private List<ReadableProduct> getProducts(HttpServletRequest request) throws Exception {
		
		MerchantStore store = (MerchantStore)request.getAttribute(Constants.MERCHANT_STORE);
		Language language = (Language)request.getAttribute(Constants.LANGUAGE);

		List<ProductRelationship> relationships = null;
		if(productId != null){
			Product productNew = productService.getById(productId);
			relationships = productRelationshipService.getByType(store, productNew, ProductRelationshipType.RELATED_ITEM);
		}else{
			relationships = productRelationshipService.getByGroup(store, this.getGroupName(), language);
		}
		
		ReadableProductPopulator populator = new ReadableProductPopulator();
		populator.setPricingService(pricingService);
		
		List<ReadableProduct> products = new ArrayList<ReadableProduct>();
		for(ProductRelationship relationship : relationships) {
			
			Product product = relationship.getRelatedProduct();
			
			ReadableProduct proxyProduct = populator.populate(product, new ReadableProduct(), store, language);
			//com.salesmanager.web.entity.catalog.Product proxyProduct = catalogUtils.buildProxyProduct(product, store, locale);
			products.add(proxyProduct);

		}
		
		return products;
		
	}


	public Long getProductId() {
		return productId;
	}


	public void setProductId(Long productId) {
		this.productId = productId;
	}


	public ProductService getProductService() {
		return productService;
	}


	public void setProductService(ProductService productService) {
		this.productService = productService;
	}


	public boolean isSplit() {
		return split;
	}


	public void setSplit(boolean split) {
		this.split = split;
	}


	public Integer getSplitLength() {
		return splitLength;
	}


	public void setSplitLength(Integer splitLength) {
		this.splitLength = splitLength;
	}

	

}
