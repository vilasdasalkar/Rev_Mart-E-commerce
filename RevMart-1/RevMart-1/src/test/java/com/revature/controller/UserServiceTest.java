package com.revature.usertest;

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
import org.springframework.web.multipart.MultipartFile;

import com.revature.model.UserDetails;
import com.revature.repository.UserRepo;
import com.revature.service.UserService;
import com.revature.service.implementation.UserServiceImplementation;

public class UserServiceTest {

    @Mock
    private UserRepo userRepository;

    @InjectMocks
    private UserServiceImplementation userService;  // Assuming UserServiceImpl is the implementation of UserService

    private UserDetails user;

    @BeforeEach
    public void setUp() {
        MockitoAnnotations.initMocks(this);
        
        // Initialize UserDetails object
        user = new UserDetails();
        user.setId(1);
        user.setName("John Doe");
        user.setEmail("john@example.com");
        user.setRole("User");
        user.setIsEnable(true);
    }

   

    @Test
    public void testGetUserByEmail() {
        when(userRepository.findByEmail(anyString())).thenReturn(user, null);
        
        UserDetails foundUser = userService.getUserByEmail("john@example.com");
        
        assertNotNull(foundUser);
        assertEquals("John Doe", foundUser.getName());
    }

    @Test
    public void testGetUsers() {
        List<UserDetails> users = new ArrayList<>();
        users.add(user);
        
        when(userRepository.findByRole(anyString())).thenReturn(users);
        
        List<UserDetails> foundUsers = userService.getUsers("User");
        
        assertNotNull(foundUsers);
        assertEquals(1, foundUsers.size());
    }

    

    @Test
    public void testIncreaseFailedAttempt() {
        user.setFailedAttempt(1);
        userService.increaseFailedAttempt(user);
        assertEquals(2, user.getFailedAttempt());
    }

  

    

    @Test
    public void testUpdateUser() {
        when(userRepository.save(any(UserDetails.class))).thenReturn(user);
        
        UserDetails updatedUser = userService.updateUser(user);
        
        assertNotNull(updatedUser);
        assertEquals("John Doe", updatedUser.getName());
    }

   

   
    @Test
    public void testExistsEmail() {
        when(userRepository.existsByEmail(anyString())).thenReturn(true);
        
        Boolean exists = userService.existsEmail("john@example.com");
        
        assertTrue(exists);
    }
}

