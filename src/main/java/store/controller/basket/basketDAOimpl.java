package store.controller.basket;

import org.springframework.beans.factory.annotation.Autowired;
import store.db.Order;
import store.db.Product;
import store.db.User;

import javax.persistence.EntityManager;
import javax.persistence.Query;
import java.util.ArrayList;
import java.util.List;

/**
 * Created by Anton on 16.12.2015.
 */
public class basketDAOimpl implements basketDAO {
    @Autowired
    private EntityManager entityManager;

    @Override
    public List<Order> allOrdersListByUser(User user){
        Query query = entityManager.createQuery("SELECT o FROM Order o where o.user = :id", Order.class);
        query.setParameter("id", user);
        return (List<Order>) query.getResultList();
    }

    @Override
    public Order ordersByConfirmedValue(long userid, int value) {
        User u = entityManager.find(User.class, userid);
        Query query = entityManager.createQuery("SELECT o FROM Order o where o.user = :user AND o.confirmed = :val", Order.class);
        query.setParameter("user", u);
        query.setParameter("val", value);
        try {
            Order result = (Order) query.getSingleResult();
            return result;
        } catch (Exception e) {
            System.out.println("FAILLLLLLLL");
        }
        return null;
    }

    @Override
    public void orderAdd(Order order) {
        try {
            entityManager.getTransaction().begin();
            entityManager.persist(order);
            entityManager.getTransaction().commit();
        } catch (Exception ex) {
            entityManager.getTransaction().rollback();
            ex.printStackTrace();
        }
    }

    @Override
    public void deleteOrder(long id) {
entityManager.getTransaction().begin();
        Query query = entityManager.createQuery("SELECT o from Order o where o.id = :id ");
        query.setParameter("id", id);
        Order order = (Order) query.getSingleResult();
        order.setProductList(new ArrayList<Product>());
        entityManager.remove(order);
        System.out.println("RRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRR");
        System.out.println(order.getName());
        entityManager.getTransaction().commit();
        /*try {
            System.out.println("START TO TRY");


            System.out.println("NAAAAAAAAAAAAAAAAAAAMEEEEEEEEEEE"+o.getName());
            o.setProductList(new ArrayList<Product>());
            entityManager.getTransaction().begin();
            entityManager.persist(o);
            entityManager.remove(o);
            entityManager.getTransaction().commit();
            System.out.println(entityManager.find(Order.class, id).getName());
        } catch (Exception e) {
            entityManager.getTransaction().rollback();
            e.printStackTrace();
        }*/

    }
}
