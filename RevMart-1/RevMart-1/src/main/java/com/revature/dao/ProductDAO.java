package com.revature.dao;


import java.util.List;

import com.revature.model.Product;

public interface ProductDAO {
    void addProduct(Product product);
    Product getProductById(Integer id);
    List<Product> getAllProducts();
    void updateProduct(Product product);
    void deleteProduct(Integer id);
    List<Product> getActiveProducts(String category);
}
