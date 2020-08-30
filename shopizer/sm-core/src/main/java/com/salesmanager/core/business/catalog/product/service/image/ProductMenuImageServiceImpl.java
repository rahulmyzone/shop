package com.salesmanager.core.business.catalog.product.service.image;

import java.io.InputStream;
import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.util.Assert;

import com.salesmanager.core.business.catalog.product.dao.image.ProductImageDao;
import com.salesmanager.core.business.catalog.product.model.Product;
import com.salesmanager.core.business.catalog.product.model.file.ProductImageSize;
import com.salesmanager.core.business.catalog.product.model.image.ProductImage;
import com.salesmanager.core.business.catalog.product.model.image.ProductImageDescription;
import com.salesmanager.core.business.content.model.FileContentType;
import com.salesmanager.core.business.content.model.ImageContentFile;
import com.salesmanager.core.business.content.model.OutputContentFile;
import com.salesmanager.core.business.generic.exception.ServiceException;
import com.salesmanager.core.business.generic.service.SalesManagerEntityServiceImpl;
import com.salesmanager.core.modules.cms.product.ProductFileManager;

@Service("productMenuImageService")
public class ProductMenuImageServiceImpl extends SalesManagerEntityServiceImpl<Long, ProductImage> 
	implements ProductMenuImageService {
	
	private ProductImageDao productImageDao;

	@Autowired
	public ProductMenuImageServiceImpl(ProductImageDao productImageDao) {
		super(productImageDao);
		this.productImageDao = productImageDao;
	}
	
	@Autowired
	private ProductFileManager productFileManager;
	

	
	
	public ProductImage getById(Long id) {
		
		
		return productImageDao.getProductImageById(id);
	}
	
	
	
	public void addProductImageDescription(ProductImage productImage, ProductImageDescription description)
	throws ServiceException {

		
			if(productImage.getDescriptions()==null) {
				productImage.setDescriptions(new ArrayList<ProductImageDescription>());
			}
			
			productImage.getDescriptions().add(description);
			description.setProductImage(productImage);
			update(productImage);


	}



	@Override
	public void addProductMenuImage(Product product, ProductImage productImage, ImageContentFile inputImage)
			throws ServiceException {
		
		
		
		
		productImage.setProduct(product);

		try {
			
			Assert.notNull(inputImage.getFile(),"ImageContentFile.file cannot be null");


			
			productFileManager.addProductImage(productImage, inputImage);
	
			//insert ProductImage
			this.saveOrUpdate(productImage);
			

		
		} catch (Exception e) {
			throw new ServiceException(e);
		} finally {
			try {
				
				//if(inputImage.getBufferedImage()!=null){
				//	inputImage.getBufferedImage().flush();
				//}
				
				if(inputImage.getFile()!=null) {
					inputImage.getFile().close();
				}

			} catch(Exception ignore) {
				
			}
		}
		
		
	}



	@Override
	public OutputContentFile getProductMenuImage(ProductImage productImage, ProductImageSize size)
			throws ServiceException {

		
		ProductImage pi = new ProductImage();
		String imageName = productImage.getProductImage();
		if(size == ProductImageSize.LARGE) {
			imageName = "L-" + imageName;
		}
		
		if(size == ProductImageSize.SMALL) {
			imageName = "S-" + imageName;
		}
		
		pi.setProductImage(imageName);
		pi.setProduct(productImage.getProduct());
		
		OutputContentFile outputImage = productFileManager.getProductImage(pi);
		
		return outputImage;
		
	
	}



	@Override
	public List<OutputContentFile> getProductMenuImages(Product product) throws ServiceException {
		return productFileManager.getImages(product);
	}



	@Override
	public void removeProductMenuImage(ProductImage productImage) throws ServiceException {
		// TODO Auto-generated method stub
		
	}



	@Override
	public void saveOrUpdate(ProductImage productImage) throws ServiceException {
		// TODO Auto-generated method stub
		
	}



	@Override
	public OutputContentFile getProductMenuImage(String storeCode, String productCode, String fileName,
			ProductImageSize size) throws ServiceException {
		OutputContentFile outputImage = productFileManager.getProductImage(storeCode, productCode, fileName, size);
		return outputImage;
		
	}



	@Override
	public void addProductMenuImages(Product product, List<ProductImage> productImages) throws ServiceException {
		// TODO Auto-generated method stub
		
	}
}
