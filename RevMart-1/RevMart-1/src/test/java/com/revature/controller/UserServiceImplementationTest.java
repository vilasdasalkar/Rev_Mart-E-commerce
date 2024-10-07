package com.revature.usertest;

import static org.junit.jupiter.api.Assertions.*;
import static org.mockito.Mockito.*;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.Date;
import java.util.List;
import java.util.Optional;

import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.MockitoAnnotations;
import org.springframework.core.io.ClassPathResource;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.util.ObjectUtils;
import org.springframework.web.multipart.MultipartFile;

import com.revature.model.UserDetails;
import com.revature.repository.UserRepo;
import com.revature.service.implementation.UserServiceImplementation;
import com.revature.utils.SecurityConstants;

public class UserServiceImplementationTest {

    @Mock
    private UserRepo userRepository;

    @Mock
    private PasswordEncoder passwordEncoder;

    @InjectMocks
    private UserServiceImplementation userService;

    private UserDetails user;
    private MultipartFile img;

    @BeforeEach
    public void setUp() {
        MockitoAnnotations.openMocks(this);

        // Initialize UserDetails object
        user = new UserDetails();
        user.setId(1);
        user.setName("John Doe");
        user.setEmail("john@example.com");
        user.setRole("ROLE_USER");
        user.setIsEnable(true);
        user.setAccountNonLocked(true);
        user.setFailedAttempt(0);

        // Mock MultipartFile
        img = mock(MultipartFile.class);
        when(img.getOriginalFilename()).thenReturn("profile_image.png");
    }

    @Test
    public void testSaveUser() {
        when(passwordEncoder.encode(anyString())).thenReturn("encodedPassword");
        when(userRepository.save(any(UserDetails.class))).thenReturn(user);

        UserDetails savedUser = userService.saveUser(user);

        assertNotNull(savedUser);
        assertEquals("ROLE_USER", savedUser.getRole());
        assertTrue(savedUser.getIsEnable());
        verify(passwordEncoder).encode(user.getPassword());
        verify(userRepository).save(user);
    }

    @Test
    public void testGetUserByEmail() {
        when(userRepository.findByEmail(anyString())).thenReturn(user);

        UserDetails foundUser = userService.getUserByEmail("john@example.com");

        assertNotNull(foundUser);
        assertEquals("John Doe", foundUser.getName());
        verify(userRepository).findByEmail("john@example.com");
    }

    @Test
    public void testGetUsers() {
        List<UserDetails> users = List.of(user);
        when(userRepository.findByRole(anyString())).thenReturn(users);

        List<UserDetails> foundUsers = userService.getUsers("ROLE_USER");

        assertNotNull(foundUsers);
        assertEquals(1, foundUsers.size());
        verify(userRepository).findByRole("ROLE_USER");
    }

    @Test
    public void testUpdateAccountStatus() {
        when(userRepository.findById(anyInt())).thenReturn(Optional.of(user));
        when(userRepository.save(any(UserDetails.class))).thenReturn(user);

        Boolean statusUpdated = userService.updateAccountStatus(1, false);

        assertTrue(statusUpdated);
        assertFalse(user.getIsEnable());
        verify(userRepository).findById(1);
        verify(userRepository).save(user);
    }

    @Test
    public void testIncreaseFailedAttempt() {
        when(userRepository.save(any(UserDetails.class))).thenReturn(user);
        userService.increaseFailedAttempt(user);

        assertEquals(1, user.getFailedAttempt());
        verify(userRepository).save(user);
    }

    @Test
    public void testUserAccountLock() {
        when(userRepository.save(any(UserDetails.class))).thenReturn(user);
        userService.userAccountLock(user);

        assertFalse(user.getAccountNonLocked());
        assertNotNull(user.getLockTime());
        verify(userRepository).save(user);
    }

    @Test
    public void testUnlockAccountTimeExpired() {
        user.setLockTime(new Date(System.currentTimeMillis() - SecurityConstants.UNLOCK_DURATION_TIME - 1));
        when(userRepository.save(any(UserDetails.class))).thenReturn(user);

        boolean unlocked = userService.unlockAccountTimeExpired(user);

        assertTrue(unlocked);
        assertTrue(user.getAccountNonLocked());
        assertNull(user.getLockTime());
        verify(userRepository).save(user);
    }

    @Test
    public void testUpdateUserResetToken() {
        when(userRepository.findByEmail(anyString())).thenReturn(user);
        when(userRepository.save(any(UserDetails.class))).thenReturn(user);

        userService.updateUserResetToken("john@example.com", "resetToken");

        assertEquals("resetToken", user.getResetToken());
        verify(userRepository).findByEmail("john@example.com");
        verify(userRepository).save(user);
    }

    @Test
    public void testGetUserByToken() {
        when(userRepository.findByResetToken(anyString())).thenReturn(user);

        UserDetails userByToken = userService.getUserByToken("resetToken");

        assertNotNull(userByToken);
        assertEquals("John Doe", userByToken.getName());
        verify(userRepository).findByResetToken("resetToken");
    }

    @Test
    public void testUpdateUser() {
        when(userRepository.save(any(UserDetails.class))).thenReturn(user);

        UserDetails updatedUser = userService.updateUser(user);

        assertNotNull(updatedUser);
        assertEquals("John Doe", updatedUser.getName());
        verify(userRepository).save(user);
    }

   

    @Test
    public void testSaveAdmin() {
        when(passwordEncoder.encode(anyString())).thenReturn("encodedPassword");
        when(userRepository.save(any(UserDetails.class))).thenReturn(user);

        UserDetails savedAdmin = userService.saveAdmin(user);

        assertNotNull(savedAdmin);
        assertEquals("ROLE_ADMIN", savedAdmin.getRole());
        assertTrue(savedAdmin.getIsEnable());
        verify(passwordEncoder).encode(user.getPassword());
        verify(userRepository).save(user);
    }

    @Test
    public void testExistsEmail() {
        when(userRepository.existsByEmail(anyString())).thenReturn(true);

        Boolean exists = userService.existsEmail("john@example.com");

        assertTrue(exists);
        verify(userRepository).existsByEmail("john@example.com");
    }
}
