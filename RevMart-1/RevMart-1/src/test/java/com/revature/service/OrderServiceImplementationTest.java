package ServiceImplementationTest;

import static org.junit.jupiter.api.Assertions.*;
import static org.mockito.Mockito.*;

import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;
import java.util.UUID;

import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.MockitoAnnotations;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageImpl;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;

import com.revature.model.Cart;
import com.revature.model.OrderAddress;
import com.revature.model.OrderRequest;
import com.revature.model.Product;
import com.revature.model.ProductOrder;
import com.revature.repository.CartRepo;
import com.revature.repository.ProductOrderRepo;
import com.revature.service.implementation.OrderServiceImplementation;
import com.revature.utils.MailServiceHelper;
import com.revature.utils.OrderStatus;

public class OrderServiceImplementationTest {

    @Mock
    private ProductOrderRepo orderRepository;

    @Mock
    private CartRepo cartRepository;

    @Mock
    private MailServiceHelper commonUtil;

    @InjectMocks
    private OrderServiceImplementation orderService;

    @BeforeEach
    public void setUp() {
        MockitoAnnotations.openMocks(this);
    }

    @Test
    public void testSaveOrder() throws Exception {
        Integer userId = 1;
        OrderRequest orderRequest = new OrderRequest();
        List<Cart> carts = new ArrayList<>();
        Cart cart = new Cart();
        Product product = new Product();
        product.setDiscountPrice(100.0);
        cart.setProduct(product);
        cart.setQuantity(2);
        carts.add(cart);
        when(cartRepository.findByUserId(userId)).thenReturn(carts);

        ProductOrder savedOrder = new ProductOrder();
        savedOrder.setOrderId(UUID.randomUUID().toString());
        savedOrder.setOrderDate(LocalDate.now());
        savedOrder.setProduct(cart.getProduct());
        savedOrder.setPrice(cart.getProduct().getDiscountPrice());
        savedOrder.setQuantity(cart.getQuantity());
        savedOrder.setUser(cart.getUser());
        savedOrder.setStatus(OrderStatus.IN_PROGRESS.getName());
        savedOrder.setPaymentType(orderRequest.getPaymentType());
        savedOrder.setOrderAddress(new OrderAddress());

        when(orderRepository.save(any(ProductOrder.class))).thenReturn(savedOrder);

        orderService.saveOrder(userId, orderRequest);

        verify(cartRepository).findByUserId(userId);
        verify(orderRepository).save(any(ProductOrder.class));
        verify(commonUtil).sendMailForProductOrder(any(ProductOrder.class), eq("success"));
    }

    @Test
    public void testGetOrdersByUser() {
        Integer userId = 1;
        List<ProductOrder> orders = new ArrayList<>();
        when(orderRepository.findByUserId(userId)).thenReturn(orders);

        List<ProductOrder> result = orderService.getOrdersByUser(userId);

        assertEquals(orders, result);
        verify(orderRepository).findByUserId(userId);
    }

    @Test
    public void testUpdateOrderStatus() {
        Integer orderId = 1;
        String status = "Shipped";
        ProductOrder order = new ProductOrder();
        order.setOrderId(UUID.randomUUID().toString());
        order.setOrderDate(LocalDate.now());
        when(orderRepository.findById(orderId)).thenReturn(Optional.of(order));
        when(orderRepository.save(order)).thenReturn(order);

        ProductOrder updatedOrder = orderService.updateOrderStatus(orderId, status);

        assertNotNull(updatedOrder);
        assertEquals(status, updatedOrder.getStatus());
        verify(orderRepository).findById(orderId);
        verify(orderRepository).save(order);
    }

    @Test
    public void testGetAllOrders() {
        List<ProductOrder> orders = new ArrayList<>();
        when(orderRepository.findAll()).thenReturn(orders);

        List<ProductOrder> result = orderService.getAllOrders();

        assertEquals(orders, result);
        verify(orderRepository).findAll();
    }

    @Test
    public void testGetAllOrdersPagination() {
        Pageable pageable = PageRequest.of(0, 10);
        Page<ProductOrder> page = new PageImpl<>(new ArrayList<>());
        when(orderRepository.findAll(pageable)).thenReturn(page);

        Page<ProductOrder> result = orderService.getAllOrdersPagination(0, 10);

        assertEquals(page, result);
        verify(orderRepository).findAll(pageable);
    }

    @Test
    public void testGetOrdersByOrderId() {
        String orderId = UUID.randomUUID().toString();
        ProductOrder order = new ProductOrder();
        when(orderRepository.findByOrderId(orderId)).thenReturn(order);

        ProductOrder result = orderService.getOrdersByOrderId(orderId);

        assertEquals(order, result);
        verify(orderRepository).findByOrderId(orderId);
    }
}
