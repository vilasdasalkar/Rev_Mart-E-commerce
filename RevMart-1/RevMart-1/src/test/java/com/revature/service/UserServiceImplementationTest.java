package ServiceImplementationTest;


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

    @BeforeEach
    void setUp() {
        MockitoAnnotations.openMocks(this);
    }

    

    @Test
    public void testGetUserByEmail() {
        String email = "test@example.com";
        UserDetails user = new UserDetails();
        user.setEmail(email);

        when(userRepository.findByEmail(email)).thenReturn(user);

        UserDetails foundUser = userService.getUserByEmail(email);

        assertNotNull(foundUser);
        assertEquals(email, foundUser.getEmail());
        verify(userRepository).findByEmail(email);
    }

    @Test
    public void testUpdateAccountStatus() {
        Integer userId = 1;
        Boolean status = true;
        UserDetails user = new UserDetails();
        user.setId(userId);

        when(userRepository.findById(userId)).thenReturn(Optional.of(user));
        when(userRepository.save(user)).thenReturn(user);

        Boolean result = userService.updateAccountStatus(userId, status);

        assertTrue(result);
        assertEquals(status, user.getIsEnable());
        verify(userRepository).findById(userId);
        verify(userRepository).save(user);
    }

    @Test
    public void testIncreaseFailedAttempt() {
        UserDetails user = new UserDetails();
        user.setFailedAttempt(1);

        when(userRepository.save(user)).thenReturn(user);

        userService.increaseFailedAttempt(user);

        assertEquals(2, user.getFailedAttempt());
        verify(userRepository).save(user);
    }

    @Test
    public void testUserAccountLock() {
        UserDetails user = new UserDetails();

        when(userRepository.save(user)).thenReturn(user);

        userService.userAccountLock(user);

        assertFalse(user.getAccountNonLocked());
        assertNotNull(user.getLockTime());
        verify(userRepository).save(user);
    }

    @Test
    public void testUnlockAccountTimeExpired() {
        UserDetails user = new UserDetails();
        user.setLockTime(new Date(System.currentTimeMillis() - SecurityConstants.UNLOCK_DURATION_TIME - 1));

        when(userRepository.save(user)).thenReturn(user);

        boolean result = userService.unlockAccountTimeExpired(user);

        assertTrue(result);
        assertTrue(user.getAccountNonLocked());
        assertNull(user.getLockTime());
        verify(userRepository).save(user);
    }

    @Test
    public void testUpdateUserResetToken() {
        String email = "test@example.com";
        String resetToken = "resetToken";
        UserDetails user = new UserDetails();
        user.setEmail(email);

        when(userRepository.findByEmail(email)).thenReturn(user);
        when(userRepository.save(user)).thenReturn(user);

        userService.updateUserResetToken(email, resetToken);

        assertEquals(resetToken, user.getResetToken());
        verify(userRepository).findByEmail(email);
        verify(userRepository).save(user);
    }

    @Test
    public void testUpdateUserProfile() throws Exception {
        UserDetails user = new UserDetails();
        user.setId(1);
        user.setName("New Name");

        MultipartFile img = mock(MultipartFile.class);
        when(img.getOriginalFilename()).thenReturn("profile.jpg");
        when(img.isEmpty()).thenReturn(false);

        UserDetails dbUser = new UserDetails();
        dbUser.setId(1);

        when(userRepository.findById(1)).thenReturn(Optional.of(dbUser));
        when(userRepository.save(dbUser)).thenReturn(dbUser);

        UserDetails updatedUser = userService.updateUserProfile(user, img);

        assertEquals("New Name", updatedUser.getName());
        assertEquals("profile.jpg", updatedUser.getProfileImage());
        verify(userRepository).findById(1);
        verify(userRepository).save(dbUser);
    }

    @Test
    public void testExistsEmail() {
        String email = "test@example.com";

        when(userRepository.existsByEmail(email)).thenReturn(true);

        Boolean exists = userService.existsEmail(email);

        assertTrue(exists);
        verify(userRepository).existsByEmail(email);
    }
}
