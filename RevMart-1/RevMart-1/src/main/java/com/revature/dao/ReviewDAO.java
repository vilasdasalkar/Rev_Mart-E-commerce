package com.revature.dao;


import java.util.List;

import com.revature.model.ReviewModel;

public interface ReviewDAO {
    void addReview(ReviewModel review);
    List<ReviewModel> getReviewsByProductId(int productId);
}
