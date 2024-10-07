package com.revature.config;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertNotNull;
import static org.junit.jupiter.api.Assertions.assertThrows;
import static org.mockito.Mockito.times;
import static org.mockito.Mockito.verify;
import static org.mockito.Mockito.when;

import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.MockitoAnnotations;
import org.springframework.security.core.userdetails.UsernameNotFoundException;

import com.revature.model.UserDtls;
import com.revature.repository.UserRepository;


class UserDetailsServiceImplTest {

    @Mock
    private UserRepository userRepository;

    @InjectMocks
    private UserDetailsServiceImpl userDetailsService;

    @BeforeEach
    void setUp() {
        MockitoAnnotations.openMocks(this);
    }

    // Success Test Case: User found
    @Test
    void testLoadUserByUsername_Success() {
        // Arrange
        String username = "test@example.com";
        UserDtls user = new UserDtls();
        user.setEmail(username);
        user.setPassword("password");
        user.setRole("ROLE_USER");

        // Mock userRepository to return a user when findByEmail is called
        when(userRepository.findByEmail(username)).thenReturn(user);

        // Act
        CustomUser customUser = (CustomUser) userDetailsService.loadUserByUsername(username);

        // Assert
        assertNotNull(customUser);
        assertEquals(username, customUser.getUsername());
        assertEquals("password", customUser.getPassword());
        assertEquals("ROLE_USER", customUser.getAuthorities().iterator().next().getAuthority());

        // Verify that the repository was called exactly once
        verify(userRepository, times(1)).findByEmail(username);
    }

    // Failure Test Case: User not found
    @Test
    void testLoadUserByUsername_Failure() {
        // Arrange
        String username = "nonexistent@example.com";

        // Mock userRepository to return null when findByEmail is called
        when(userRepository.findByEmail(username)).thenReturn(null);

        // Act & Assert
        UsernameNotFoundException exception = assertThrows(UsernameNotFoundException.class, () -> {
            userDetailsService.loadUserByUsername(username);
        });

        assertEquals("user not found", exception.getMessage());

        // Verify that the repository was called exactly once
        verify(userRepository, times(1)).findByEmail(username);
    }

    // Test when repository throws an exception
    @Test
    void testLoadUserByUsername_RepositoryThrowsException() {
        // Arrange
        String username = "error@example.com";

        // Mock the repository to throw an exception
        when(userRepository.findByEmail(username)).thenThrow(new RuntimeException("Database connection failed"));

        // Act & Assert
        RuntimeException exception = assertThrows(RuntimeException.class, () -> {
            userDetailsService.loadUserByUsername(username);
        });

        assertEquals("Database connection failed", exception.getMessage());

        // Verify that the repository was called exactly once
        verify(userRepository, times(1)).findByEmail(username);
    }
}

