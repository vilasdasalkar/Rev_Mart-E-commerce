package com.revature.controller;
import static org.mockito.Mockito.*;
import static org.junit.jupiter.api.Assertions.*;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.get;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.*;

import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.security.Principal;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.MockitoAnnotations;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageImpl;
import org.springframework.data.domain.PageRequest;
import org.springframework.mock.web.MockMultipartFile;
import org.springframework.ui.Model;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.revature.controller.Controller_Home;
import com.revature.model.Category;
import com.revature.model.Product;
import com.revature.model.UserDetails;
import com.revature.service.CartService;
import com.revature.service.CategoryService;
import com.revature.service.UserService;

import jakarta.mail.MessagingException;
import jakarta.servlet.http.HttpServletRequest;

import com.revature.service.ProductService;

public class Controller_HomeTest {

    @Mock
    private CategoryService categoryService;

    @Mock
    private ProductService productService;

    @Mock
    private UserService userService;
    
   

    @Mock
    private RedirectAttributes redirectAttributes;

    @Mock
    private CartService cartService;

    
    @Mock
    private Model model;
    
    @Mock
    private HttpServletRequest request;

    @InjectMocks
    private Controller_Home homeController;

    @BeforeEach
    public void setup() {
        MockitoAnnotations.openMocks(this);
    }

    @Test
    public void testIndex_Success() {

    	String viewName = homeController.userHome(model);
    	assertEquals("userHome",viewName);

    	} 
    
    @Test
    void testRegister() {
        String viewName = homeController.register();
        assertEquals("register", viewName);
    }

  

    @Test
    public void testIndex_Failure_EmptyCategoriesAndProducts() {
        // Mocking empty lists for categories and products
        when(categoryService.getAllActiveCategory()).thenReturn(new ArrayList<>());
        when(productService.getAllActiveProducts("")).thenReturn(new ArrayList<>());

        // Call the method
        String viewName = homeController.userHome(model);

        // Verify the services were called
        verify(categoryService, times(1)).getAllActiveCategory();
        verify(productService, times(1)).getAllActiveProducts("");

        // Verify that empty lists were added to the model
        verify(model, times(1)).addAttribute("category", new ArrayList<>());
        verify(model, times(1)).addAttribute("products", new ArrayList<>());

        // Assert that the view name is still "index"
        assertEquals("userHome", viewName);
    }
    
    @Test
    public void testProducts_Success() {
        // Mock Category List
        List<Category> mockCategories = new ArrayList<>();
        Category category1 = new Category();
        category1.setId(1);
        mockCategories.add(category1);

        when(categoryService.getAllActiveCategory()).thenReturn(mockCategories);

        // Mock Product List and Page
        List<Product> mockProducts = new ArrayList<>();
        Product product1 = new Product();
        product1.setId(1);
        mockProducts.add(product1);

        Page<Product> mockPage = new PageImpl<>(mockProducts, PageRequest.of(0, 12), mockProducts.size());
        when(productService.getAllActiveProductPagination(0, 12, "")).thenReturn(mockPage);

        // Call the controller method
        String viewName = homeController.products(model, "", 0, 12, "");

        // Assertions
        assertEquals("product", viewName); // Ensure it returns "product" view

        // Verify Model Attributes
        verify(model).addAttribute("paramValue", "");
        verify(model).addAttribute("categories", mockCategories);
        verify(model).addAttribute("products", mockProducts);
        verify(model).addAttribute("productsSize", mockProducts.size());
        verify(model).addAttribute("pageNo", mockPage.getNumber());
        verify(model).addAttribute("pageSize", 12);
        verify(model).addAttribute("totalElements", mockPage.getTotalElements());
        verify(model).addAttribute("totalPages", mockPage.getTotalPages());
        verify(model).addAttribute("isFirst", mockPage.isFirst());
        verify(model).addAttribute("isLast", mockPage.isLast());
    }

    @Test
    public void testProducts_SearchSuccess() {
        // Mock Category List
        List<Category> mockCategories = new ArrayList<>();
        Category category1 = new Category();
        category1.setId(1);
        mockCategories.add(category1);

        when(categoryService.getAllActiveCategory()).thenReturn(mockCategories);

        // Mock Product List and Page
        List<Product> mockProducts = new ArrayList<>();
        Product product1 = new Product();
        product1.setId(1);
        mockProducts.add(product1);

        Page<Product> mockPage = new PageImpl<>(mockProducts, PageRequest.of(0, 12), mockProducts.size());
        when(productService.searchActiveProductPagination(0, 12, "", "searchQuery")).thenReturn(mockPage);

        // Call the controller method with search query
        String viewName = homeController.products(model, "", 0, 12, "searchQuery");

        // Assertions
        assertEquals("product", viewName); // Ensure it returns "product" view

        // Verify Model Attributes
        verify(model).addAttribute("paramValue", "");
        verify(model).addAttribute("categories", mockCategories);
        verify(model).addAttribute("products", mockProducts);
        verify(model).addAttribute("productsSize", mockProducts.size());
        verify(model).addAttribute("pageNo", mockPage.getNumber());
        verify(model).addAttribute("pageSize", 12);
        verify(model).addAttribute("totalElements", mockPage.getTotalElements());
        verify(model).addAttribute("totalPages", mockPage.getTotalPages());
        verify(model).addAttribute("isFirst", mockPage.isFirst());
        verify(model).addAttribute("isLast", mockPage.isLast());
    }

    @Test
    public void testProducts_Failure() {
        // Mock empty Category List
        List<Category> mockCategories = new ArrayList<>();
        when(categoryService.getAllActiveCategory()).thenReturn(mockCategories);

        // Mock empty Product List and Page
        Page<Product> mockPage = new PageImpl<>(new ArrayList<>(), PageRequest.of(0, 12), 0);
        when(productService.getAllActiveProductPagination(0, 12, "")).thenReturn(mockPage);

        // Call the controller method
        String viewName = homeController.products(model, "", 0, 12, "");

        // Assertions
        assertEquals("product", viewName); // Ensure it returns "product" view

        // Verify Model Attributes with empty lists
        verify(model).addAttribute("paramValue", "");
        verify(model).addAttribute("categories", mockCategories);
        verify(model).addAttribute("products", mockPage.getContent());
        verify(model).addAttribute("productsSize", 0);
        verify(model).addAttribute("pageNo", mockPage.getNumber());
        verify(model).addAttribute("pageSize", 12);
        verify(model).addAttribute("totalElements", mockPage.getTotalElements());
        verify(model).addAttribute("totalPages", mockPage.getTotalPages());
        verify(model).addAttribute("isFirst", mockPage.isFirst());
        verify(model).addAttribute("isLast", mockPage.isLast());
    }  
}
