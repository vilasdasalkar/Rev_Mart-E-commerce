package com.revature.dao.serviceImpl;

import java.util.List;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.query.Query;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.revature.dao.WishlistDAO;
import com.revature.model.Product;
import com.revature.model.Wishlist;

@Repository
public class WishlistDAOImpl implements WishlistDAO {

    @Autowired
    private SessionFactory sessionFactory;

    @SuppressWarnings("deprecation")
	@Override
    public void add(Wishlist wishlist) {
        Session session = sessionFactory.getCurrentSession();
        session.save(wishlist);
    }

    @Override
    public List<Product> findProductsByUserId(Integer userId) {
        Session session = sessionFactory.getCurrentSession();
        String hql = "SELECT p FROM Product p WHERE p.id IN (SELECT w.productId FROM Wishlist w WHERE w.userId = :userId)";
        Query<Product> query = session.createQuery(hql, Product.class);
        query.setParameter("userId", userId);
        return query.getResultList();
    }
}
