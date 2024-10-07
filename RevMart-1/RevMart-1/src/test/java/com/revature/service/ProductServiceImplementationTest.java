package ServiceImplementationTest;

import static org.junit.jupiter.api.Assertions.*;
import static org.mockito.Mockito.*;


import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.MockitoAnnotations;
import org.springframework.core.io.ClassPathResource;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageImpl;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.util.ObjectUtils;
import org.springframework.web.multipart.MultipartFile;

import com.revature.model.Product;
import com.revature.repository.ProductRepo;
import com.revature.service.implementation.ProductServiceImplementation;

public class ProductServiceImplementationTest {

    @Mock
    private ProductRepo productRepository;

    @InjectMocks
    private ProductServiceImplementation productService;

    @BeforeEach
    public void setUp() {
        MockitoAnnotations.openMocks(this);
    }

    @Test
    public void testSaveProduct() {
        Product product = new Product();
        when(productRepository.save(product)).thenReturn(product);
        
        Product savedProduct = productService.saveProduct(product);
        
        assertNotNull(savedProduct);
        verify(productRepository).save(product);
    }

    @Test
    public void testGetAllProducts() {
        List<Product> products = new ArrayList<>();
        when(productRepository.findAll()).thenReturn(products);
        
        List<Product> result = productService.getAllProducts();
        
        assertEquals(products, result);
        verify(productRepository).findAll();
    }

    @Test
    public void testGetAllProductsPagination() {
        Pageable pageable = PageRequest.of(0, 10);
        Page<Product> page = new PageImpl<>(new ArrayList<>());
        when(productRepository.findAll(pageable)).thenReturn(page);
        
        Page<Product> result = productService.getAllProductsPagination(0, 10);
        
        assertEquals(page, result);
        verify(productRepository).findAll(pageable);
    }

    @Test
    public void testDeleteProduct() {
        Product product = new Product();
        when(productRepository.findById(1)).thenReturn(Optional.of(product));
        
        Boolean result = productService.deleteProduct(1);
        
        assertTrue(result);
        verify(productRepository).delete(product);
    }

    @Test
    public void testGetProductById() {
        Product product = new Product();
        when(productRepository.findById(1)).thenReturn(Optional.of(product));
        
        Product result = productService.getProductById(1);
        
        assertEquals(product, result);
        verify(productRepository).findById(1);
    }

    
    @Test
    public void testGetAllActiveProducts() {
        List<Product> products = new ArrayList<>();
        when(productRepository.findByIsActiveTrue()).thenReturn(products);
        
        List<Product> result = productService.getAllActiveProducts(null);
        
        assertEquals(products, result);
        verify(productRepository).findByIsActiveTrue();
    }

    @Test
    public void testSearchProduct() {
        List<Product> products = new ArrayList<>();
        when(productRepository.findByTitleContainingIgnoreCaseOrCategoryContainingIgnoreCase("search", "search")).thenReturn(products);
        
        List<Product> result = productService.searchProduct("search");
        
        assertEquals(products, result);
        verify(productRepository).findByTitleContainingIgnoreCaseOrCategoryContainingIgnoreCase("search", "search");
    }

    @Test
    public void testSearchProductPagination() {
        Pageable pageable = PageRequest.of(0, 10);
        Page<Product> page = new PageImpl<>(new ArrayList<>());
        when(productRepository.findByTitleContainingIgnoreCaseOrCategoryContainingIgnoreCase("search", "search", pageable)).thenReturn(page);
        
        Page<Product> result = productService.searchProductPagination(0, 10, "search");
        
        assertEquals(page, result);
        verify(productRepository).findByTitleContainingIgnoreCaseOrCategoryContainingIgnoreCase("search", "search", pageable);
    }

    @Test
    public void testGetAllActiveProductPagination() {
        Pageable pageable = PageRequest.of(0, 10);
        Page<Product> page = new PageImpl<>(new ArrayList<>());
        when(productRepository.findByIsActiveTrue(pageable)).thenReturn(page);
        
        Page<Product> result = productService.getAllActiveProductPagination(0, 10, null);
        
        assertEquals(page, result);
        verify(productRepository).findByIsActiveTrue(pageable);
    }

    @Test
    public void testSearchActiveProductPagination() {
        Pageable pageable = PageRequest.of(0, 10);
        Page<Product> page = new PageImpl<>(new ArrayList<>());
        when(productRepository.findByIsActiveTrueAndTitleContainingIgnoreCaseOrCategoryContainingIgnoreCase("search", "search", pageable)).thenReturn(page);
        
        Page<Product> result = productService.searchActiveProductPagination(0, 10, null, "search");
        
        assertEquals(page, result);
        verify(productRepository).findByIsActiveTrueAndTitleContainingIgnoreCaseOrCategoryContainingIgnoreCase("search", "search", pageable);
    }
}
