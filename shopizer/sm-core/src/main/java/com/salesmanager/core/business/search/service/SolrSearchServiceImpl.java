package com.salesmanager.core.business.search.service;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.Iterator;
import java.util.List;
import java.util.Set;

import javax.annotation.PostConstruct;

import org.apache.commons.collections.CollectionUtils;
import org.apache.commons.lang3.StringUtils;
import org.apache.solr.client.solrj.SolrQuery;
import org.apache.solr.client.solrj.SolrServerException;
import org.apache.solr.client.solrj.impl.HttpSolrServer;
import org.apache.solr.client.solrj.response.QueryResponse;
import org.apache.solr.common.SolrDocument;
import org.apache.solr.common.SolrDocumentList;
import org.apache.solr.common.SolrInputDocument;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import com.itextpdf.text.xml.XMLUtil;
import com.salesmanager.core.business.catalog.category.model.Category;
import com.salesmanager.core.business.catalog.product.model.Product;
import com.salesmanager.core.business.catalog.product.model.description.ProductDescription;
import com.salesmanager.core.business.catalog.product.model.price.FinalPrice;
import com.salesmanager.core.business.catalog.product.service.PricingService;
import com.salesmanager.core.business.generic.exception.ServiceException;
import com.salesmanager.core.business.merchant.model.MerchantStore;
import com.salesmanager.core.business.search.model.IndexProduct;
import com.salesmanager.core.business.search.model.SearchKeywords;
import com.salesmanager.core.business.search.model.SearchResponse;
import com.salesmanager.core.constants.Constants;
import com.salesmanager.core.utils.CoreConfiguration;

@Service("productSolrSearchService")
public class SolrSearchServiceImpl implements SolrSearchService{
private static final Logger LOGGER = LoggerFactory.getLogger(SolrSearchServiceImpl.class);
	
	
	private final static String PRODUCT_INDEX_NAME = "product";
	private final static String KEYWORD_INDEX_NAME = "keyword";
	private final static String UNDERSCORE = "_";
	private final static String INDEX_PRODUCTS = "INDEX_PRODUCTS";
	
	private final static String INDEX_KEYWORDS = "keyword";
	
	@Autowired
	private PricingService pricingService;
	
	@Autowired
	private CoreConfiguration configuration;
	
	@Value("${solr.search.url}")
	String solrUrl;

	private HttpSolrServer solrServer = null;

	@PostConstruct
	public void init() {
		solrServer = new HttpSolrServer(solrUrl+"products_en_df100001");
		//searchService.initService();
	}
	
	@Override
	public void index(MerchantStore store, Product product) throws ServiceException {
		
		/**
		 * When a product is saved or updated the indexing process occurs
		 * 
		 * A product entity will have to be transformed to a bean ProductIndex
		 * which contains the indices as described in product.json
		 * 
		 * {"product": {
						"properties" :  {
							"name" : {"type":"string","index":"analyzed"},
							"price" : {"type":"string","index":"not_analyzed"},
							"category" : {"type":"string","index":"not_analyzed"},
							"lang" : {"type":"string","index":"not_analyzed"},
							"available" : {"type":"string","index":"not_analyzed"},
							"description" : {"type":"string","index":"analyzed","index_analyzer":"english"}, 
							"tags" : {"type":"string","index":"not_analyzed"} 
						 } 
			            }
			}
		 *
		 * productService saveOrUpdate as well as create and update will invoke
		 * productSearchService.index	
		 * 
		 * A copy of properies between Product to IndexProduct
		 * Then IndexProduct will be transformed to a json representation by the invocation
		 * of .toJSONString on IndexProduct
		 * 
		 * Then index product
		 * searchService.index(json, "product_<LANGUAGE_CODE>_<MERCHANT_CODE>", "product");
		 * 
		 * example ...index(json,"product_en_default",product)
		 * 
		 */
		try{
			if(configuration.getProperty(INDEX_PRODUCTS)==null || configuration.getProperty(INDEX_PRODUCTS).equals(Constants.FALSE)) {
				return;
			}
			
			FinalPrice price = pricingService.calculateProductPrice(product);
	
			
			Set<ProductDescription> descriptions = product.getDescriptions();
			for(ProductDescription description : descriptions) {
				
				StringBuilder collectionName = new StringBuilder();
				collectionName.append(PRODUCT_INDEX_NAME).append(UNDERSCORE).append(description.getLanguage().getCode()).append(UNDERSCORE).append(store.getCode().toLowerCase());
				
				StringBuilder keyWorkCollectionName = new StringBuilder();
				keyWorkCollectionName.append(KEYWORD_INDEX_NAME).append(UNDERSCORE).append(description.getLanguage().getCode()).append(UNDERSCORE).append(store.getCode().toLowerCase());
				
				IndexProduct index = new IndexProduct();
				index.setId(String.valueOf(product.getId()));
				index.setStore(store.getCode().toLowerCase());
				index.setLang(description.getLanguage().getCode());
				index.setAvailable(product.isAvailable());
				index.setDescription(description.getDescription());
				index.setName(description.getName());
				if(product.getManufacturer()!=null) {
					index.setManufacturerId(String.valueOf(product.getManufacturer().getId()));
					index.setManufacturer(String.valueOf(product.getManufacturer().getManufacturerName()));
				}
				if(product.getProductImage() != null){
					index.setProductImage(product.getProductImage().getProductImage());
				}
				if(price!=null) {
					index.setPrice(price.getFinalPrice().doubleValue());
				}
				index.setHighlight(description.getProductHighlight());
				if(!StringUtils.isBlank(description.getMetatagKeywords())){
					String[] tags = description.getMetatagKeywords().split(",");
					@SuppressWarnings("unchecked")
					List<String> tagsList = new ArrayList(Arrays.asList(tags));
					index.setTags(tagsList);
				}
	
				
				Set<Category> categories = product.getCategories();
				if(!CollectionUtils.isEmpty(categories)) {
					List<String> categoryList = new ArrayList<String>();
					for(Category category : categories) {
						categoryList.add(category.getCode());
					}
					index.setCategories(categoryList);
				}
				index.setSku(product.getSku());
				index.setUrl(description.getSeUrl());
				
				//SolrInputDocument document = toSolrDocument(index);
					solrServer.addBean(index);
					solrServer.commit();
			}
		}catch(Exception e){
			
		}
	}

	@Override
	public void deleteIndex(MerchantStore store, Product product) throws ServiceException {
		// TODO Auto-generated method stub
		
	}

	@Override
	public SearchKeywords searchForKeywords(String collectionName, String str, int entriesCount)
			throws ServiceException {
		return null;
		}

	@Override
	public List<IndexProduct> searchForProducts(String collectionName,
			String str, int entriesCount) throws ServiceException{
		List<IndexProduct> products = null;
		SolrQuery query = new SolrQuery();
		query.setStart(0);
		query.setRows(entriesCount);
		//query.setQuery("kw_suggest_ngram:"+str);
		IndexProduct keywords = new IndexProduct();
		try {
			//QueryResponse response = solrServer.query(query);
			query = new SolrQuery();
			query.setStart(0);
			query.setRows(5);
			query.setQuery("*:*");
			query.setFilterQueries("kw_suggest_ngram:"+str);
			QueryResponse response = solrServer.query(query);
			products = response.getBeans(IndexProduct.class);
		} catch (SolrServerException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return products;
	}
	@Override
	public SearchResponse search(MerchantStore store, String languageCode, String jsonString, int entriesCount,
			int startIndex) throws ServiceException {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public void initService() {
		// TODO Auto-generated method stub
		
	}

	public SolrInputDocument toSolrDocument(IndexProduct indexProduct){
		SolrInputDocument doc = new SolrInputDocument();
		doc.addField("id", indexProduct.getId());
		doc.addField("name",indexProduct.getName());
		doc.addField("price", indexProduct.getPrice());
		doc.addField("description", indexProduct.getDescription());
		doc.addField("highlight", indexProduct.getHighlight());
		doc.addField("store",indexProduct.getStore());
		doc.addField("manu", indexProduct.getManufacturer());
		doc.addField("lang", indexProduct.getLang());
		doc.addField("cat", indexProduct.getCategories());
		doc.addField("tag", indexProduct.getTags());
		doc.addField("manuId", indexProduct.getManufacturerId());
		doc.addField("image", indexProduct.getProductImage());
		return doc;
	}
	
}
