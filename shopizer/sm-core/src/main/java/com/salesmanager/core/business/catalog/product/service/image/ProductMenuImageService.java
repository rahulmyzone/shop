package com.salesmanager.core.business.catalog.product.service.image;

import java.util.List;

import com.salesmanager.core.business.catalog.product.model.Product;
import com.salesmanager.core.business.catalog.product.model.file.ProductImageSize;
import com.salesmanager.core.business.catalog.product.model.image.ProductImage;
import com.salesmanager.core.business.content.model.ImageContentFile;
import com.salesmanager.core.business.content.model.OutputContentFile;
import com.salesmanager.core.business.generic.exception.ServiceException;
import com.salesmanager.core.business.generic.service.SalesManagerEntityService;


public interface ProductMenuImageService extends SalesManagerEntityService<Long, ProductImage> {
	
	
	
	/**
	 * Add a ProductImage to the persistence and an entry to the CMS
	 * @param product
	 * @param productImage
	 * @param file
	 * @throws ServiceException
	 */
	void addProductMenuImage(Product product, ProductImage productImage, ImageContentFile inputImage)
			throws ServiceException;

	/**
	 * Get the image ByteArrayOutputStream and content description from CMS
	 * @param productImage
	 * @return
	 * @throws ServiceException
	 */
	OutputContentFile getProductMenuImage(ProductImage productImage, ProductImageSize size)
			throws ServiceException;

	/**
	 * Returns all Images for a given product
	 * @param product
	 * @return
	 * @throws ServiceException
	 */
	List<OutputContentFile> getProductMenuImages(Product product)
			throws ServiceException;

	void removeProductMenuImage(ProductImage productImage) throws ServiceException;

	void saveOrUpdate(ProductImage productImage) throws ServiceException;

	/**
	 * Returns an image file from required identifier. This method is
	 * used by the image servlet
	 * @param store
	 * @param product
	 * @param fileName
	 * @param size
	 * @return
	 * @throws ServiceException
	 */
	OutputContentFile getProductMenuImage(String storeCode, String productCode,
			String fileName, final ProductImageSize size) throws ServiceException;

	void addProductMenuImages(Product product, List<ProductImage> productImages)
			throws ServiceException;
	
}
