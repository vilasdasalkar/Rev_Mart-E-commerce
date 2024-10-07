package com.revature.config;

import com.revature.model.UserDtls;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.mockito.Mock;
import org.mockito.MockitoAnnotations;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;

import java.util.Collection;

import static org.junit.jupiter.api.Assertions.*;
import static org.mockito.Mockito.*;

class CustomUserTest {

    @Mock
    private UserDtls userDtls;

    private CustomUser customUser;

    @BeforeEach
    void setUp() {
        MockitoAnnotations.openMocks(this);
    }

    // Success Test Case
    @Test
    void testGetAuthoritiesSuccess() {
        // Mocking UserDtls behavior
        when(userDtls.getRole()).thenReturn("ROLE_USER");

        // Creating CustomUser instance with mocked UserDtls
        customUser = new CustomUser(userDtls);

        // Fetching authorities
        Collection<? extends GrantedAuthority> authorities = customUser.getAuthorities();

        // Asserting the authority matches
        assertEquals(1, authorities.size());
        assertTrue(authorities.contains(new SimpleGrantedAuthority("ROLE_USER")));
    }

    @Test
    void testGetPasswordAndUsername() {
        // Mocking password and email
        when(userDtls.getPassword()).thenReturn("password123");
        when(userDtls.getEmail()).thenReturn("test@example.com");

        customUser = new CustomUser(userDtls);

        // Asserting password and username are returned correctly
        assertEquals("password123", customUser.getPassword());
        assertEquals("test@example.com", customUser.getUsername());
    }

    @Test
    void testAccountNonExpiredAndCredentialsNonExpired() {
        customUser = new CustomUser(userDtls);

        // These methods should always return true
        assertTrue(customUser.isAccountNonExpired());
        assertTrue(customUser.isCredentialsNonExpired());
    }

    // Failure Test Case - User Account Locked
    @Test
    void testIsAccountNonLockedFailure() {
        // Mocking a locked account
        when(userDtls.getAccountNonLocked()).thenReturn(false);

        customUser = new CustomUser(userDtls);

        // Asserting that account is locked (should return false)
        assertFalse(customUser.isAccountNonLocked());
    }

    @Test
    void testIsEnabledFailure() {
        // Mocking user disabled
        when(userDtls.getIsEnable()).thenReturn(false);

        customUser = new CustomUser(userDtls);

        // Asserting that the user is not enabled
        assertFalse(customUser.isEnabled());
    }
}

