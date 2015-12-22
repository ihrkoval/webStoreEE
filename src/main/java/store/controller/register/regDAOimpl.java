package store.controller.register;

import org.springframework.beans.factory.annotation.Autowired;
import store.db.User;

import javax.persistence.EntityManager;
import javax.persistence.Query;

/**
 * Created by Anton on 16.12.2015.
 */
public class regDAOimpl implements regDAO{

    @Autowired
    private EntityManager entityManager;



    @Override
    public User userAdd(User user) {
        User u = null;
        try {
            Query query = entityManager.createQuery("SELECT u FROM User u WHERE u.email = :mail", User.class);
            query.setParameter("mail", user.getEmail());
            u = (User) query.getSingleResult();
        } catch (Exception e) {
            e.printStackTrace();
        }

        if (u == null) {
            try {
                entityManager.getTransaction().begin();
                entityManager.persist(user);
                entityManager.getTransaction().commit();
            } catch (Exception ex) {
                entityManager.getTransaction().rollback();
                ex.printStackTrace();
            }

        }
        return u;
    }
}
