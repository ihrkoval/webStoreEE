package store.config;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;
import store.db.User;
import store.UserRole;

import javax.persistence.EntityManager;
import javax.persistence.Query;
import java.util.HashSet;
import java.util.Set;

/**
 * Created by Anton on 07.12.2015.
 */
@Service
public class UserDetailsServiceImpl implements UserDetailsService  {
    @Autowired
    private EntityManager entityManager;

    @Override
    public UserDetails loadUserByUsername(String email) throws UsernameNotFoundException {
       Query query = entityManager.createQuery("SELECT p FROM User p WHERE p.email = :email", User.class);
        query.setParameter("email", email);
        User user = (User) query.getSingleResult();
        Set<GrantedAuthority> roles = new HashSet<>();
       if (user.getEmail().equals("admin")){
            roles.add(new SimpleGrantedAuthority(UserRole.ADMIN.name()));
        }
        roles.add(new SimpleGrantedAuthority(UserRole.USER.name()));
        UserDetails userDetails = new org.springframework.security.core.userdetails.User(user.getEmail(),
                user.getPassword(),
                roles);

        return userDetails;
    }


    }

