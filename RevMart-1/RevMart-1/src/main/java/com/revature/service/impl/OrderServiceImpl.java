package com.revature.service.impl;

import java.time.LocalDate;
import java.util.List;
import java.util.Optional;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;

import com.revature.model.Cart;
import com.revature.model.OrderAddress;
import com.revature.model.OrderRequest;
import com.revature.model.ProductOrder;
import com.revature.repository.CartRepository;
import com.revature.repository.ProductOrderRepository;
import com.revature.service.OrderService;
import com.revature.util.MailHelper;
import com.revature.util.OrderStatus;


@Service
public class OrderServiceImpl implements OrderService {

	@Autowired
	private ProductOrderRepository orderRepository;

	@Autowired
	private CartRepository cartRepository;

	@Autowired
	private MailHelper commonUtil;


	@Override
	public void saveOrder(Integer userid, OrderRequest orderRequest) throws Exception {

	    List<Cart> carts = cartRepository.findByUserId(userid);

	    for (Cart cart : carts) {

	        ProductOrder order = new ProductOrder();

	        order.setOrderId(UUID.randomUUID().toString());
	        order.setOrderDate(LocalDate.now());

	        order.setProduct(cart.getProduct());
	        order.setPrice(cart.getProduct().getDiscountPrice()+ 50 + 10);
	        order.setQuantity(cart.getQuantity());
	        order.setUser(cart.getUser());

	        order.setStatus(OrderStatus.IN_PROGRESS.getName());
	        order.setPaymentType(orderRequest.getPaymentType());

	        OrderAddress address = new OrderAddress();
	        address.setFirstName(orderRequest.getFirstName());
	        address.setLastName(orderRequest.getLastName());
	        address.setEmail(orderRequest.getEmail());
	        address.setMobileNo(orderRequest.getMobileNo());
	        address.setAddress(orderRequest.getAddress());
	        address.setCity(orderRequest.getCity());
	        address.setState(orderRequest.getState());
	        address.setPincode(orderRequest.getPincode());

	        order.setOrderAddress(address);

	        ProductOrder savedOrder = orderRepository.save(order);

	        // Handle order based on payment type
	        if ("ONLINE".equals(orderRequest.getPaymentType())) {
	            // Additional logic if needed for online payments
	            commonUtil.sendMailForProductOrder(savedOrder, "Online");
	        } else {
	            // For COD, you might want to notify the user or take additional steps
	            commonUtil.sendMailForProductOrder(savedOrder, "COD");
	        }
	    }
	}


	@Override
	public List<ProductOrder> getOrdersByUser(Integer userId) {
		List<ProductOrder> orders = orderRepository.findByUserId(userId);
		return orders;
	}

	@Override
	public ProductOrder updateOrderStatus(Integer id, String status) {
		Optional<ProductOrder> findById = orderRepository.findById(id);
		if (findById.isPresent()) {
			ProductOrder productOrder = findById.get();
			productOrder.setStatus(status);
			ProductOrder updateOrder = orderRepository.save(productOrder);
			return updateOrder;
		}
		return null;
	}

	@Override
	public List<ProductOrder> getAllOrders() {
		return orderRepository.findAll();
	}

	@Override
	public Page<ProductOrder> getAllOrdersPagination(Integer pageNo, Integer pageSize) {
		Pageable pageable = PageRequest.of(pageNo, pageSize);
		return orderRepository.findAll(pageable);

	}

	@Override
	public ProductOrder getOrdersByOrderId(String orderId) {
		return orderRepository.findByOrderId(orderId);
	}

}
