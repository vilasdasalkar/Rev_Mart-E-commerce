package ServiceImplementationTest;

import static org.mockito.Mockito.*;
import static org.junit.jupiter.api.Assertions.*;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.MockitoAnnotations;
import org.springframework.test.context.junit.jupiter.SpringExtension;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import com.revature.service.implementation.SessionServiceImplementation;

@ExtendWith(SpringExtension.class)
public class SessionServiceImplementationTest {

    @Mock
    private HttpServletRequest request;

    @Mock
    private HttpSession session;

    @InjectMocks
    private SessionServiceImplementation sessionService;

    @BeforeEach
    public void setUp() {
        MockitoAnnotations.openMocks(this);

        // Set up the RequestContextHolder to use our mocked request and session
        RequestContextHolder.setRequestAttributes(new ServletRequestAttributes(request));
        when(request.getSession()).thenReturn(session);
    }

    @Test
    public void testRemoveSessionMessage() {
        // Set up the session attributes
        when(session.getAttribute("succMsg")).thenReturn("Success message");
        when(session.getAttribute("errorMsg")).thenReturn("Error message");

        // Call the method
        sessionService.removeSessionMessage();

        // Verify that the session attributes were removed
        verify(session).removeAttribute("succMsg");
        verify(session).removeAttribute("errorMsg");
    }
}
