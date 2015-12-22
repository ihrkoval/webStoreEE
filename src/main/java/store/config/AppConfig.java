package store.config;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.web.multipart.commons.CommonsMultipartResolver;
import org.springframework.web.servlet.config.annotation.EnableWebMvc;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurerAdapter;
import org.springframework.web.servlet.view.JstlView;
import org.springframework.web.servlet.view.UrlBasedViewResolver;
import store.StoreDAO;
import store.StoreDAOlmpl;
import store.controller.basket.basketDAO;
import store.controller.basket.basketDAOimpl;
import store.controller.register.regDAO;
import store.controller.register.regDAOimpl;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;

/**
 * Created by Anton on 25.11.2015.
 */
@Configuration
@ComponentScan("store")
@EnableWebMvc
public class AppConfig extends WebMvcConfigurerAdapter {
    @Bean
    public EntityManager entityManager() {
        EntityManagerFactory emf = Persistence.createEntityManagerFactory("storeJPA");
        return emf.createEntityManager();
    }

    @Bean
    public StoreDAO strDAO() {
        return new StoreDAOlmpl();
    }


    @Bean
    public regDAO regDAO() {
        return new regDAOimpl();
    }


    @Bean
    public basketDAO basketDAO() {
        return new basketDAOimpl();
    }

    @Bean
    public UrlBasedViewResolver setupViewResolver() {
        UrlBasedViewResolver resolver = new UrlBasedViewResolver();
        resolver.setPrefix("/WEB-INF/pages/");
        resolver.setSuffix(".jsp");
        resolver.setViewClass(JstlView.class);
        resolver.setOrder(1);
        return resolver;
    }
    @Bean
    public UserDetailsService getUserDetailsService(){
        return new UserDetailsServiceImpl();
    }

    @Bean
    public CommonsMultipartResolver multipartResolver() {
        CommonsMultipartResolver mr = new CommonsMultipartResolver();
        mr.setDefaultEncoding("utf-8");
        return mr;
    }


}
