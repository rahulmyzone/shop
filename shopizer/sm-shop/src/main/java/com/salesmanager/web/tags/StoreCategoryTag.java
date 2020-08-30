package com.salesmanager.web.tags;

import java.util.LinkedList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.jsp.JspException;
import javax.servlet.jsp.tagext.TagSupport;

import org.apache.commons.lang3.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.config.AutowireCapableBeanFactory;
import org.springframework.web.context.WebApplicationContext;
import org.springframework.web.servlet.tags.RequestContextAwareTag;

import com.salesmanager.core.business.catalog.category.model.Category;
import com.salesmanager.core.business.catalog.category.service.CategoryService;
import com.salesmanager.core.business.merchant.model.MerchantStore;
import com.salesmanager.core.business.reference.language.model.Language;
import com.salesmanager.web.constants.Constants;
import com.salesmanager.web.entity.shop.Breadcrumb;

import edu.emory.mathcs.backport.java.util.Arrays;

public class StoreCategoryTag extends RequestContextAwareTag {
	
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	private static final Logger LOGGER = LoggerFactory.getLogger(StoreCategoryTag.class);

	private String categoryName;
	
	@Autowired
	private CategoryService categoryService;

	@SuppressWarnings("unchecked")
	@Override
	protected int doStartTagInternal() throws JspException {
		try {
			if (categoryService == null) {
				LOGGER.debug("Autowiring categoryService");
	            WebApplicationContext wac = getRequestContext().getWebApplicationContext();
	            AutowireCapableBeanFactory factory = wac.getAutowireCapableBeanFactory();
	            factory.autowireBean(this);
	        }


			HttpServletRequest request = (HttpServletRequest) pageContext
					.getRequest();
			
			MerchantStore store = (MerchantStore)request.getAttribute(Constants.MERCHANT_STORE);
			
			Language language = (Language)request.getAttribute(Constants.LANGUAGE);
			List<Category> category = categoryService.getByName(store, categoryName, language);
			if(category != null && !category.isEmpty()){
				request.setAttribute(categoryName, category.get(0));
			}

			/*Breadcrumb breadCrumb = (Breadcrumb)request.getAttribute(Constants.BREADCRUMB);
			
			StringBuilder ref = new StringBuilder();
			
			if(breadCrumb!=null && !StringUtils.isBlank(breadCrumb.getUrlRefContent())) {
				ref.append(Constants.SLASH).append(Constants.REF).append(Constants.EQUALS).append(breadCrumb.getUrlRefContent());
				if(categoryId!=null) {
					List<String> ids = this.parseBreadCrumb(breadCrumb.getUrlRefContent());
					if(!ids.contains(String.valueOf(this.getCategoryId()))) {
						ref.append(",").append(this.getCategoryId().longValue());
					}
				}
			} else {
				if(categoryId!=null) {
					ref.append(Constants.SLASH).append(Constants.REF).append(Constants.EQUALS).append(Constants.REF_C).append(this.getCategoryId());
				} else {
					ref.append("");
				}
			}


			pageContext.getOut().print(ref.toString());*/


			
		} catch (Exception ex) {
			LOGGER.error("Error while getting content url", ex);
		}
		return SKIP_BODY;
	}
	
	public int doEndTag() {
		return EVAL_PAGE;
	}

	public String getCategoryName() {
		return categoryName;
	}

	public void setCategoryName(String categoryName) {
		this.categoryName = categoryName;
	}

}
