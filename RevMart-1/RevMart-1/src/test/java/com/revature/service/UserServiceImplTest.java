package com.ecom.service;

import static org.junit.jupiter.api.Assertions.*;
import static org.mockito.Mockito.*;

import java.util.Date;
import java.util.Optional;

import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.MockitoAnnotations;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.web.multipart.MultipartFile;

import com.ecom.model.UserDtls;
import com.ecom.repository.UserRepository;
import com.ecom.service.impl.UserServiceImpl;

class UserServiceImplTest {

	@Mock
	private UserRepository userRepository;

	@Mock
	private PasswordEncoder passwordEncoder;

	@InjectMocks
	private UserServiceImpl userServiceImpl;

	@BeforeEach
	void setUp() {
		MockitoAnnotations.initMocks(this);
	}

	@Test
	void testGetUserByIdSuccess() {
		UserDtls user = new UserDtls();
		user.setId(1);
		when(userRepository.findById(1)).thenReturn(Optional.of(user));

		UserDtls result = userServiceImpl.getUserById(1);
		assertNotNull(result);
		assertEquals(1, result.getId());
	}

	@Test
	void testGetUserByIdFailure() {
		when(userRepository.findById(1)).thenReturn(Optional.empty());

		UserDtls result = userServiceImpl.getUserById(1);
		assertNull(result);
	}

	@Test
	void testSaveUserSuccess() {
		UserDtls user = new UserDtls();
		user.setPassword("password");
		when(passwordEncoder.encode(user.getPassword())).thenReturn("encodedPassword");
		when(userRepository.save(user)).thenReturn(user);

		UserDtls result = userServiceImpl.saveUser(user);
		assertNotNull(result);
		assertEquals("encodedPassword", result.getPassword());
	}

	@Test
	void testSaveUserFailure() {
		UserDtls user = new UserDtls();
		user.setPassword("password");
		when(passwordEncoder.encode(user.getPassword())).thenReturn("encodedPassword");
		when(userRepository.save(user)).thenThrow(RuntimeException.class);

		assertThrows(RuntimeException.class, () -> userServiceImpl.saveUser(user));
	}

	@Test
	void testGetUserByEmailSuccess() {
		String email = "test@example.com";
		UserDtls user = new UserDtls();
		user.setEmail(email);
		when(userRepository.findByEmail(email)).thenReturn(user);

		UserDtls result = userServiceImpl.getUserByEmail(email);
		assertNotNull(result);
		assertEquals(email, result.getEmail());
	}

	@Test
	void testGetUserByEmailFailure() {
		String email = "test@example.com";
		when(userRepository.findByEmail(email)).thenReturn(null);

		UserDtls result = userServiceImpl.getUserByEmail(email);
		assertNull(result);
	}

	@Test
	void testUpdateAccountStatusSuccess() {
		UserDtls user = new UserDtls();
		user.setId(1);
		user.setIsEnable(true);
		when(userRepository.findById(1)).thenReturn(Optional.of(user));

		Boolean result = userServiceImpl.updateAccountStatus(1, false);
		assertTrue(result);
		assertFalse(user.getIsEnable());
	}

	@Test
	void testUpdateAccountStatusFailure() {
		when(userRepository.findById(1)).thenReturn(Optional.empty());

		Boolean result = userServiceImpl.updateAccountStatus(1, false);
		assertFalse(result);
	}

	@Test
	void testIncreaseFailedAttemptSuccess() {
		UserDtls user = new UserDtls();
		user.setFailedAttempt(2);
		when(userRepository.save(user)).thenReturn(user);

		userServiceImpl.increaseFailedAttempt(user);
		assertEquals(3, user.getFailedAttempt());
	}

	@Test
	void testIncreaseFailedAttemptFailure() {
		UserDtls user = new UserDtls();
		user.setFailedAttempt(2);
		when(userRepository.save(user)).thenThrow(RuntimeException.class);

		assertThrows(RuntimeException.class, () -> userServiceImpl.increaseFailedAttempt(user));
	}

	@Test
	void testUserAccountLockSuccess() {
		UserDtls user = new UserDtls();
		user.setAccountNonLocked(true);

		userServiceImpl.userAccountLock(user);

		assertFalse(user.getAccountNonLocked());
		assertNotNull(user.getLockTime());
		verify(userRepository).save(user);
	}

	@Test
	void testUserAccountLockFailure() {
		UserDtls user = new UserDtls();
		when(userRepository.save(user)).thenThrow(RuntimeException.class);

		assertThrows(RuntimeException.class, () -> userServiceImpl.userAccountLock(user));
	}

	@Test
	void testUnlockAccountTimeExpiredSuccess() {
		UserDtls user = new UserDtls();
		user.setLockTime(new Date(System.currentTimeMillis() - 100000L));

		boolean result = userServiceImpl.unlockAccountTimeExpired(user);
		assertTrue(result);
		assertTrue(user.getAccountNonLocked());
		assertEquals(0, user.getFailedAttempt());
		verify(userRepository).save(user);
	}

	@Test
	void testUnlockAccountTimeExpiredFailure() {
		UserDtls user = new UserDtls();
		user.setLockTime(new Date(System.currentTimeMillis()));

		boolean result = userServiceImpl.unlockAccountTimeExpired(user);
		assertFalse(result);
	}

	@Test
	void testUpdateUserProfileSuccess() throws Exception {
		UserDtls user = new UserDtls();
		user.setId(1);
		when(userRepository.findById(1)).thenReturn(Optional.of(user));
		when(userRepository.save(user)).thenReturn(user);

		MultipartFile img = mock(MultipartFile.class);
		when(img.isEmpty()).thenReturn(false);
		when(img.getOriginalFilename()).thenReturn("profile.jpg");

		UserDtls result = userServiceImpl.updateUserProfile(user, img);
		assertNotNull(result);
		assertEquals("profile.jpg", result.getProfileImage());
	}

	@Test
	void testUpdateUserProfileFailure() {
		UserDtls user = new UserDtls();
		when(userRepository.findById(1)).thenReturn(Optional.empty());

		MultipartFile img = mock(MultipartFile.class);
		when(img.isEmpty()).thenReturn(true);

		assertThrows(RuntimeException.class, () -> userServiceImpl.updateUserProfile(user, img));
	}

	@Test
	void testSaveAdminSuccess() {
		UserDtls user = new UserDtls();
		user.setPassword("adminPass");
		when(passwordEncoder.encode(user.getPassword())).thenReturn("encodedAdminPass");
		when(userRepository.save(user)).thenReturn(user);

		UserDtls result = userServiceImpl.saveAdmin(user);
		assertNotNull(result);
		assertEquals("encodedAdminPass", result.getPassword());
		assertEquals("ROLE_ADMIN", result.getRole());
	}

	@Test
	void testSaveAdminFailure() {
		UserDtls user = new UserDtls();
		when(userRepository.save(user)).thenThrow(RuntimeException.class);

		assertThrows(RuntimeException.class, () -> userServiceImpl.saveAdmin(user));
	}

	@Test
	void testExistsEmailSuccess() {
		String email = "test@example.com";
		when(userRepository.existsByEmail(email)).thenReturn(true);

		Boolean result = userServiceImpl.existsEmail(email);
		assertTrue(result);
	}

	@Test
	void testExistsEmailFailure() {
		String email = "test@example.com";
		when(userRepository.existsByEmail(email)).thenReturn(false);

		Boolean result = userServiceImpl.existsEmail(email);
		assertFalse(result);
	}

}
