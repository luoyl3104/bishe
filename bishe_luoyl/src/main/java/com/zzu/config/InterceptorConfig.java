package com.zzu.config;

import com.zzu.interceptor.MyInterceptor;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurerAdapter;

@Configuration
public class InterceptorConfig extends WebMvcConfigurerAdapter {

    @Autowired
    private MyInterceptor myInterceptor;

    public void addInterceptor(InterceptorRegistry registry){
        registry.addInterceptor(myInterceptor)
                .addPathPatterns("/user/**","/view/**","/comment/**")
                .excludePathPatterns("/user/login","/admin/login");
    }


}
