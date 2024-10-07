package com.revature.controller;



import org.junit.jupiter.api.Test;

import com.revature.controller.Controller_User;

import static org.junit.jupiter.api.Assertions.assertEquals;

public class Controller_UserTest {

    private Controller_User userController = new Controller_User();

    @Test
    void testHome() {
        String viewName = userController.home();
        assertEquals("userHome", viewName);
    }
    
}
