package com.revature.controller;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertTrue;
import static org.mockito.ArgumentMatchers.any;
import static org.mockito.ArgumentMatchers.anyInt;
import static org.mockito.ArgumentMatchers.eq;
import static org.mockito.Mockito.mock;
import static org.mockito.Mockito.verify;
import static org.mockito.Mockito.when;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.List;

import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.MockitoAnnotations;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.ClassPathResource;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageImpl;
import org.springframework.mock.web.MockMultipartFile;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.ui.Model;
import org.springframework.web.multipart.MultipartFile;

import com.revature.model.Category;
import com.revature.model.Product;
import com.revature.model.ProductOrder;
import com.revature.service.CategoryService;
import com.revature.service.OrderService;
import com.revature.service.ProductService;
import com.revature.service.UserService;

import jakarta.servlet.http.HttpSession;

public class Controller_AdminTest {

	@Mock
	private CategoryService categoryService;

	@InjectMocks
	private Controller_Admin adminController;

    @Autowired
    private MockMvc mockMvc;
	
	@Mock
	private Model model;
	
	@Mock
	private HttpSession session;
	
    @Mock
    private ProductService productService;
    
    @Mock
    private UserService userService;
    
    @Mock
    private OrderService orderService;

	@BeforeEach
	public void setup() {
		MockitoAnnotations.openMocks(this);
	}

	@Test
	public void testLoadAddProduct_Success() {
		// Arrange
		List<Category> categories = new ArrayList<>();
		categories.add(new Category());
		categories.add(new Category());

		when(categoryService.getAllCategory()).thenReturn(categories);

		// Act
		String viewName = adminController.loadAddProduct(model);

		// Assert
		verify(model).addAttribute(eq("categories"), eq(categories));
		assertEquals("addProduct", viewName);
	}

	@Test
	public void testLoadAddProduct_NoCategories() {
		// Arrange
		List<Category> categories = new ArrayList<>();
		when(categoryService.getAllCategory()).thenReturn(categories);

		// Act
		String viewName = adminController.loadAddProduct(model);

		// Assert
		verify(model).addAttribute(eq("categories"), eq(categories));
		assertEquals("addProduct", viewName);
	}

	@Test
	public void testCategory_Success() {
		// Arrange
		List<Category> categories = new ArrayList<>();
		categories.add(new Category());
		categories.add(new Category());
		Page<Category> categoryPage = new PageImpl<>(categories);

		when(categoryService.getAllCategorPagination(anyInt(), anyInt())).thenReturn(categoryPage);

		// Act
		String viewName = adminController.category(model, 0, 10);

		// Assert
		verify(model).addAttribute(eq("categorys"), eq(categories));
		verify(model).addAttribute(eq("pageNo"), eq(0));
		verify(model).addAttribute(eq("pageSize"), eq(10));
		verify(model).addAttribute(eq("totalElements"), eq(2L));
		verify(model).addAttribute(eq("totalPages"), eq(1));
		verify(model).addAttribute(eq("isFirst"), eq(true));
		verify(model).addAttribute(eq("isLast"), eq(true));
		assertEquals("category", viewName);
	}

	@Test
	public void testCategory_NoCategories() {
		// Arrange
		List<Category> categories = new ArrayList<>();
		Page<Category> categoryPage = new PageImpl<>(categories);

		when(categoryService.getAllCategorPagination(anyInt(), anyInt())).thenReturn(categoryPage);

		// Act
		String viewName = adminController.category(model, 0, 10);

		// Assert
		verify(model).addAttribute(eq("categorys"), eq(categories));
		verify(model).addAttribute(eq("pageNo"), eq(0));
		verify(model).addAttribute(eq("pageSize"), eq(10));
		verify(model).addAttribute(eq("totalElements"), eq(0L));
		verify(model).addAttribute(eq("totalPages"), eq(1));
		verify(model).addAttribute(eq("isFirst"), eq(true));
		verify(model).addAttribute(eq("isLast"), eq(true));
		assertEquals("category", viewName);
	}
	
    @Test
    public void testSaveCategory_CategoryAlreadyExists() throws IOException {
        // Arrange
        String imageName = "category_image.jpg";
        Category category = new Category();
        category.setName("Electronics");
        category.setImageName(imageName);

        MockMultipartFile file = new MockMultipartFile("file", imageName, "image/jpeg", new byte[0]);
        when(categoryService.existCategory(category.getName())).thenReturn(true);

        // Act
        String viewName = adminController.saveCategory(category, file, session);

        // Assert
        verify(session).setAttribute("errorMsg", "Category Name already exists");
        assertEquals("redirect:/admin/category", viewName);
    }
    
    @Test
    public void testSaveCategory_InternalServerError() throws IOException {
        // Arrange
        String imageName = "category_image.jpg";
        Category category = new Category();
        category.setName("Electronics");
        category.setImageName(imageName);

        MockMultipartFile file = new MockMultipartFile("file", imageName, "image/jpeg", new byte[0]);
        when(categoryService.existCategory(category.getName())).thenReturn(false);
//        when(categoryService.saveCategory(any(Category.class))).thenReturn(null);

        // Act
        String viewName = adminController.saveCategory(category, file, session);

        // Assert
        verify(session).setAttribute("errorMsg", "Not saved ! internal server error");
        assertEquals("redirect:/admin/category", viewName);
    }

    @Test
    public void testDeleteCategory_Success() {
        // Arrange
        int categoryId = 1;
        when(categoryService.deleteCategory(categoryId)).thenReturn(true);

        // Act
        String viewName = adminController.deleteCategory(categoryId, session);

        // Assert
        verify(session).setAttribute("succMsg", "category delete success");
        assertEquals("redirect:/admin/category", viewName);
    }

    @Test
    public void testDeleteCategory_Failure() {
        // Arrange
        int categoryId = 1;
        when(categoryService.deleteCategory(categoryId)).thenReturn(false);

        // Act
        String viewName = adminController.deleteCategory(categoryId, session);

        // Assert
        verify(session).setAttribute("errorMsg", "something wrong on server");
        assertEquals("redirect:/admin/category", viewName);
    }
    
    @Test
    public void testSaveProduct_Success() throws IOException {
        // Arrange
        String imageName = "product_image.jpg";
        Product product = new Product();
        product.setPrice(100.0);
        product.setDiscount(0);
        product.setDiscountPrice(product.getPrice());

        // Mocking an image file upload
        MockMultipartFile image = new MockMultipartFile("file", imageName, "image/jpeg", "Test data".getBytes());

        // Mock product service behavior - explicitly return a valid Product object
        when(productService.saveProduct(any(Product.class))).thenReturn(product); // Correct usage of any() matcher

        // Prepare the path for file saving
        File saveFile = new ClassPathResource("static/img").getFile();
        Path path = Paths.get(saveFile.getAbsolutePath() + File.separator + "product_img" + File.separator + imageName);
        
        // Ensure that the test environment is clean (delete the file if it exists)
        if (Files.exists(path)) {
            Files.delete(path);
        }

        // Act
        String viewName = adminController.saveProduct(product, image, session);

        // Assert
        verify(session).setAttribute("succMsg", "Product Saved Success");
        assertEquals("redirect:/admin/loadAddProduct", viewName);
        assertTrue(Files.exists(path)); // Check if the image is saved to the correct location
    }
    
    @Test
    public void testSaveProduct_Failure() throws IOException {
        // Arrange
        String imageName = "product_image.jpg";
        Product product = new Product();
        product.setPrice(100.0);
        
        // Mocking an image file upload
        MockMultipartFile image = new MockMultipartFile("file", imageName, "image/jpeg", "Test data".getBytes());

        // Simulate failure by returning null from productService.saveProduct()
        when(productService.saveProduct(any(Product.class))).thenReturn(null);

        // Act
        String viewName = adminController.saveProduct(product, image, session);

        // Assert
        verify(session).setAttribute("errorMsg", "something wrong on server");
        assertEquals("redirect:/admin/loadAddProduct", viewName);
    }
    
    @Test
    public void testDeleteProduct_Success() {
        // Arrange
        int productId = 1;

        // Simulate successful deletion
        when(productService.deleteProduct(productId)).thenReturn(true);

        // Act
        String viewName = adminController.deleteProduct(productId, session);

        // Assert
        verify(session).setAttribute("succMsg", "Product delete success");
        assertEquals("redirect:/admin/products", viewName);
    }
    
    @Test
    public void testDeleteProduct_Failure() {
        // Arrange
        int productId = 1;

        // Simulate failure in deletion
        when(productService.deleteProduct(productId)).thenReturn(false);

        // Act
        String viewName = adminController.deleteProduct(productId, session);

        // Assert
        verify(session).setAttribute("errorMsg", "Something wrong on server");
        assertEquals("redirect:/admin/products", viewName);
    }

    @Test
    public void testEditProduct() {
        // Arrange
        int productId = 1;
        Product product = new Product();
        List<Category> categories = new ArrayList<>();
        
        when(productService.getProductById(productId)).thenReturn(product);
        when(categoryService.getAllCategory()).thenReturn(categories);

        Model model = mock(Model.class);

        // Act
        String viewName = adminController.editProduct(productId, model);

        // Assert
        assertEquals("updateProduct", viewName);
        verify(model).addAttribute("product", product);
        verify(model).addAttribute("categories", categories);
    }
    
    @Test
    public void testUpdateProduct_Success() throws IOException {
        // Arrange
        Product product = new Product();
        product.setId(1);
        product.setDiscount(10);
        product.setPrice((double) 1000);
        
        MockMultipartFile file = new MockMultipartFile("file", "product_image.jpg", "image/jpeg", new byte[0]);
        
        Product updatedProduct = new Product();
        when(productService.updateProduct(any(Product.class), (MultipartFile) any(MultipartFile.class))).thenReturn(updatedProduct);

        HttpSession session = mock(HttpSession.class);
        Model model = mock(Model.class);

        // Act
        String viewName = adminController.updateProduct(product, file, session, model);

        // Assert
        verify(session).setAttribute("succMsg", "Product update success");
        assertEquals("redirect:/admin/editProduct/" + product.getId(), viewName);
    }
    
    @Test
    public void testUpdateProduct_InvalidDiscount() throws IOException {
        // Arrange
        Product product = new Product();
        product.setId(1);
        product.setDiscount(120); // Invalid discount > 100

        MockMultipartFile file = new MockMultipartFile("file", "product_image.jpg", "image/jpeg", new byte[0]);

        HttpSession session = mock(HttpSession.class);
        Model model = mock(Model.class);

        // Act
        String viewName = adminController.updateProduct(product, file, session, model);

        // Assert
        verify(session).setAttribute("errorMsg", "invalid Discount");
        assertEquals("redirect:/admin/editProduct/" + product.getId(), viewName);
    }

    @Test
    public void testGetAllUsers_RoleUser() {
        // Arrange
        int type = 1;
        List<UserDetails> users = new ArrayList<>();
        when(userService.getUsers("ROLE_USER")).thenReturn(users);

        Model model = mock(Model.class);

        // Act
        String viewName = adminController.getAllUsers(model, type);

        // Assert
        assertEquals("users", viewName);
        verify(model).addAttribute("userType", type);
        verify(model).addAttribute("users", users);
    }

    @Test
    public void testGetAllUsers_RoleAdmin() {
        // Arrange
        int type = 2;
        List<UserDetails> users = new ArrayList<>();
        when(userService.getUsers("ROLE_ADMIN")).thenReturn(users);

        Model model = mock(Model.class);

        // Act
        String viewName = adminController.getAllUsers(model, type);

        // Assert
        assertEquals("users", viewName);
        verify(model).addAttribute("userType", type);
        verify(model).addAttribute("users", users);
    }

    @Test
    public void testUpdateUserAccountStatus_Success() {
        // Arrange
        int userId = 1;
        int type = 1;
        boolean status = true;

        when(userService.updateAccountStatus(userId, status)).thenReturn(true);

        HttpSession session = mock(HttpSession.class);

        // Act
        String viewName = adminController.updateUserAccountStatus(status, userId, type, session);

        // Assert
        verify(session).setAttribute("succMsg", "Account Status Updated");
        assertEquals("redirect:/admin/users?type=" + type, viewName);
    }
    
    @Test
    public void testUpdateUserAccountStatus_Failure() {
        // Arrange
        int userId = 1;
        int type = 1;
        boolean status = true;

        when(userService.updateAccountStatus(userId, status)).thenReturn(false);

        HttpSession session = mock(HttpSession.class);

        // Act
        String viewName = adminController.updateUserAccountStatus(status, userId, type, session);

        // Assert
        verify(session).setAttribute("errorMsg", "Something wrong on server");
        assertEquals("redirect:/admin/users?type=" + type, viewName);
    }

    @Test
    public void testGetAllOrders() {
        // Arrange
        int pageNo = 0;
        int pageSize = 10;
        Page<ProductOrder> page = mock(Page.class);

        when(orderService.getAllOrdersPagination(pageNo, pageSize)).thenReturn(page);
        when(page.getContent()).thenReturn(new ArrayList<>());

        Model model = mock(Model.class);

        // Act
        String viewName = adminController.getAllOrders(model, pageNo, pageSize);

        // Assert
        assertEquals("orders", viewName);
        verify(model).addAttribute("orders", page.getContent());
        verify(model).addAttribute("srch", false);
    }



}