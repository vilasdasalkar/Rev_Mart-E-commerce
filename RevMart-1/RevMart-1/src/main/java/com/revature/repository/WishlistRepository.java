package com.revature.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;

import com.revature.model.UserDtls;
import com.revature.model.Wishlist;


public interface WishlistRepository extends JpaRepository<Wishlist, Long> {
    List<Wishlist> findByUser(UserDtls user);

    // Changed Long to Integer for productId
    Wishlist findByUserAndProductId(UserDtls user, Integer productId);
}
