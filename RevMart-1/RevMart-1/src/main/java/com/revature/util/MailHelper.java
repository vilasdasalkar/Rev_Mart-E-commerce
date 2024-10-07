package com.revature.util;

import java.io.UnsupportedEncodingException;
import java.security.Principal;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Component;

import com.revature.model.ProductOrder;
import com.revature.model.UserDtls;
import com.revature.service.UserService;

import jakarta.mail.MessagingException;
import jakarta.mail.internet.MimeMessage;
import jakarta.servlet.http.HttpServletRequest;

@Component
public class MailHelper {

	@Autowired
	private JavaMailSender mailSender;
	
	@Autowired
	private UserService userService;

	public Boolean sendMail(String url, String reciepentEmail) throws UnsupportedEncodingException, MessagingException {

		MimeMessage message = mailSender.createMimeMessage();
		MimeMessageHelper helper = new MimeMessageHelper(message);

		helper.setFrom("shubhamtingare0661@gmail.com", "RevMart");
		helper.setTo(reciepentEmail);

		String content = "<div style='font-family: Arial, sans-serif; color: #333;'>"
                + "<p>Dear User,</p>"
                + "<p>We received a request to reset your password. If you did not request this, please ignore this email.</p>"
                + "<p>To reset your password, please click the button below:</p>"
                + "<p><a href=\"" + url
                + "\" style='background-color: #4CAF50; color: white; padding: 10px 20px; text-decoration: none; border-radius: 5px;'>Reset Password</a></p>"
                + "<p>If the button above doesn't work, copy and paste the following URL into your browser:</p>"
                + "<p><a href=\"" + url + "\">" + url + "</a></p>"
                + "<p>Best regards,<br>Your Company Team</p>"
                + "</div>";
helper.setSubject("Password Reset Request");

		helper.setText(content, true);
		mailSender.send(message);
		return true;
	}

	public static String generateUrl(HttpServletRequest request) {

		// http://localhost:8080/forgot-password
		String siteUrl = request.getRequestURL().toString();

		return siteUrl.replace(request.getServletPath(), "");
	}
	
	String msg=null;;
	
	public Boolean sendMailForProductOrder(ProductOrder order,String status) throws Exception
	{
		
		msg="""
                <div style='font-family: Arial, sans-serif; color: #333;'>
        <p>Dear [[name]],</p>
        <p>Thank you for your order. Your order status is <b>[[orderStatus]]</b>.</p>
        <p><b>Product Details:</b></p>
        <table style='border-collapse: collapse; width: 100%;'>
            <tr>
                <td style='border: 1px solid #ddd; padding: 8px;'><b>Product Name:</b></td>
                <td style='border: 1px solid #ddd; padding: 8px;'>[[productName]]</td>
            </tr>
            <tr>
                <td style='border: 1px solid #ddd; padding: 8px;'><b>Category:</b></td>
                <td style='border: 1px solid #ddd; padding: 8px;'>[[category]]</td>
            </tr>
            <tr>
                <td style='border: 1px solid #ddd; padding: 8px;'><b>Quantity:</b></td>
                <td style='border: 1px solid #ddd; padding: 8px;'>[[quantity]]</td>
            </tr>
            <tr>
                <td style='border: 1px solid #ddd; padding: 8px;'><b>Price:</b></td>
                <td style='border: 1px solid #ddd; padding: 8px;'>[[price]]</td>
            </tr>
            <tr>
                <td style='border: 1px solid #ddd; padding: 8px;'><b>Payment Type:</b></td>
                <td style='border: 1px solid #ddd; padding: 8px;'>[[paymentType]]</td>
            </tr>
        </table>
        <p>If you have any questions or need further assistance, feel free to contact our support team.</p>
        <p>Best regards,<br>Your Company Team</p>
    </div>
                """;
		
		MimeMessage message = mailSender.createMimeMessage();
		MimeMessageHelper helper = new MimeMessageHelper(message);

		helper.setFrom("daspabitra55@gmail.com", "Shooping Cart");
		helper.setTo(order.getOrderAddress().getEmail());

		msg=msg.replace("[[name]]",order.getOrderAddress().getFirstName());
		msg=msg.replace("[[orderStatus]]",status);
		msg=msg.replace("[[productName]]", order.getProduct().getTitle());
		msg=msg.replace("[[category]]", order.getProduct().getCategory());
		msg=msg.replace("[[quantity]]", order.getQuantity().toString());
		msg=msg.replace("[[price]]", order.getPrice().toString());
		msg=msg.replace("[[paymentType]]", order.getPaymentType());
		
		helper.setSubject("Product Order Status");
		helper.setText(msg, true);
		mailSender.send(message);
		return true;
	}
	
	public UserDtls getLoggedInUserDetails(Principal p) {
		String email = p.getName();
		UserDtls userDtls = userService.getUserByEmail(email);
		return userDtls;
	}
	

}
