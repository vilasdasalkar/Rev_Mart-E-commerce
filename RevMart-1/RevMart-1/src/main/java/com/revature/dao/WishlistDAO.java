package com.revature.dao;


import java.util.List;

import com.revature.model.Product;
import com.revature.model.Wishlist;

public interface WishlistDAO {
    void add(Wishlist wishlist);
    List<Product> findProductsByUserId(Integer userId);
}
