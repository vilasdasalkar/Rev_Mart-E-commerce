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

import com.revature.model.Cart;
import com.revature.model.Product;
import com.revature.model.UserDetails;
import com.revature.repository.CartRepo;
import com.revature.repository.ProductRepo;
import com.revature.repository.UserRepo;
import com.revature.service.implementation.CartServiceImplementation;

public class CartServiceImplementationTest {

    @Mock
    private CartRepo cartRepository;

    @Mock
    private UserRepo userRepository;

    @Mock
    private ProductRepo productRepository;

    @InjectMocks
    private CartServiceImplementation cartService;

    @BeforeEach
    public void setUp() {
        MockitoAnnotations.openMocks(this);
    }

    @Test
    public void testSaveCartNewCart() {
        Integer productId = 1;
        Integer userId = 1;

        UserDetails user = new UserDetails();
        Product product = new Product();
        product.setDiscountPrice(100.0);

        when(userRepository.findById(userId)).thenReturn(Optional.of(user));
        when(productRepository.findById(productId)).thenReturn(Optional.of(product));
        when(cartRepository.findByProductIdAndUserId(productId, userId)).thenReturn(null);
        when(cartRepository.save(any(Cart.class))).thenAnswer(invocation -> invocation.getArgument(0));

        Cart result = cartService.saveCart(productId, userId);

        assertNotNull(result);
        assertEquals(1, result.getQuantity());
        assertEquals(100.0, result.getTotalPrice());
        verify(cartRepository).save(result);
    }

    @Test
    public void testSaveCartExistingCart() {
        Integer productId = 1;
        Integer userId = 1;

        UserDetails user = new UserDetails();
        Product product = new Product();
        product.setDiscountPrice(100.0);

        Cart existingCart = new Cart();
        existingCart.setQuantity(1);
        existingCart.setProduct(product);

        when(userRepository.findById(userId)).thenReturn(Optional.of(user));
        when(productRepository.findById(productId)).thenReturn(Optional.of(product));
        when(cartRepository.findByProductIdAndUserId(productId, userId)).thenReturn(existingCart);
        when(cartRepository.save(any(Cart.class))).thenAnswer(invocation -> invocation.getArgument(0));

        Cart result = cartService.saveCart(productId, userId);

        assertNotNull(result);
        assertEquals(2, result.getQuantity());
        assertEquals(200.0, result.getTotalPrice());
        verify(cartRepository).save(result);
    }

    @Test
    public void testGetCartsByUser() {
        Integer userId = 1;
        List<Cart> carts = new ArrayList<>();
        Cart cart = new Cart();
        cart.setQuantity(2);
        Product product = new Product();
        product.setDiscountPrice(100.0);
        cart.setProduct(product);
        carts.add(cart);

        when(cartRepository.findByUserId(userId)).thenReturn(carts);

        List<Cart> result = cartService.getCartsByUser(userId);

        assertNotNull(result);
        assertEquals(1, result.size());
        assertEquals(200.0, result.get(0).getTotalPrice());
        assertEquals(200.0, result.get(0).getTotalOrderPrice());
        verify(cartRepository).findByUserId(userId);
    }

    @Test
    public void testGetCountCart() {
        Integer userId = 1;
        when(cartRepository.countByUserId(userId)).thenReturn(5);

        Integer result = cartService.getCountCart(userId);

        assertEquals(5, result);
        verify(cartRepository).countByUserId(userId);
    }

    
    @Test
    public void testUpdateQuantityDecreaseToZero() {
        Integer cid = 1;
        Cart cart = new Cart();
        cart.setQuantity(1);
        Product product = new Product();
        product.setDiscountPrice(100.0);
        cart.setProduct(product);

        when(cartRepository.findById(cid)).thenReturn(Optional.of(cart));
        doNothing().when(cartRepository).delete(cart);

        cartService.updateQuantity("de", cid);

        verify(cartRepository).delete(cart);
        verify(cartRepository, never()).save(cart);
    }
}
