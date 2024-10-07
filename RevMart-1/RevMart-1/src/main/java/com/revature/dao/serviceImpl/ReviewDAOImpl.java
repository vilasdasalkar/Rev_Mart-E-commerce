package com.revature.dao.serviceImpl;

import java.util.List;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.revature.dao.ReviewDAO;
import com.revature.model.ReviewModel;

@Repository
public class ReviewDAOImpl implements ReviewDAO {

    @Autowired
    private SessionFactory sessionFactory;

    @Override
    public void addReview(ReviewModel review) {
        Session session = sessionFactory.getCurrentSession();
        session.save(review);
    }

    @Override
    public List<ReviewModel> getReviewsByProductId(int productId) {
        Session session = sessionFactory.getCurrentSession();
        return session.createQuery("FROM ReviewModel WHERE product.id = :productId", ReviewModel.class)
                      .setParameter("productId", productId)
                      .list();
    }
}
