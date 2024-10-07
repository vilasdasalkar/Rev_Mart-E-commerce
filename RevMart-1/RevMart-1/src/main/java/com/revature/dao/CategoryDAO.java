package com.revature.dao;


import java.util.List;

import com.revature.model.Category;

public interface CategoryDAO {
    void addCategory(Category category);
    List<Category> getAllCategories();
    Category getCategoryById(int id);
    void updateCategory(Category category);
    void deleteCategory(int id);
}
