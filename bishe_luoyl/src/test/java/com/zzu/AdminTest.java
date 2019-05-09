package com.zzu;

import com.zzu.entity.Admin;
import com.zzu.service.AdminService;
import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;

import java.util.Map;

public class AdminTest extends BaseTest {

    @Autowired
    private AdminService adminService;

    @Test
    public void testLogin(){
        Admin admin = new Admin();
        admin.setName("admin");
        admin.setPassword("111111");
        Map<String, Object> map = adminService.login(admin);
        System.out.println(map);
    }

}
