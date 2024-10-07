package com.revature.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.revature.model.ReviewModel;
import com.revature.repository.ReviewRepository;

@Service
public class ReviewService {

    @Autowired
    private ReviewRepository reviewRepository;

    public List<ReviewModel> getReviewsByProductId(int productId) {
        return reviewRepository.findByProductId(productId);
    }

    public void saveReview(ReviewModel review) {
        reviewRepository.save(review);
    }
}
