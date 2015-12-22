package store;

import org.springframework.beans.factory.annotation.Autowired;
import store.db.Order;
import store.db.Product;
import store.db.User;

import javax.persistence.EntityManager;
import javax.persistence.Query;
import java.util.ArrayList;
import java.util.List;

/**
 * Created by Anton on 25.11.2015.
 */
public class StoreDAOlmpl implements StoreDAO {
    @Autowired
    private EntityManager entityManager;

    @Override
    public List<User> uncofirmedUsers() {
        Query q = entityManager.createQuery("SELECT o FROM Order o where o.confirmed = 1");
        List<Order> orders = q.getResultList();
        System.out.println(orders.size()+" LIST SIZE WORK");
        List<User> unk = new ArrayList<>();
        for (Order o : orders){
            unk.add(o.getUser());

        }

        return unk;
    }

    @Override
    public List<Order> list(){
        Query query = entityManager.createQuery("SELECT o FROM Order o", Order.class);
        return (List<Order>) query.getResultList();
    }

    @Override
    public List<User> users() {
        Query query = entityManager.createQuery("SELECT u FROM User u", User.class);
        return (List<User>)query.getResultList();
    }

    @Override
public List<Product> products(){
    Query query = entityManager.createQuery("SELECT o FROM Product o", Product.class);
    return (List<Product>)query.getResultList();
}

    @Override
    public List<Product> byCat(String product_cat) {

        Query query = entityManager.createQuery("SELECT p FROM Product p WHERE p.cat_id = :id", Product.class);
        query.setParameter("id", product_cat);
        List<Product> p = (List<Product>) query.getResultList();
        System.out.println(p.size());
        return  p;
    }



    @Override
    public void productAdd(Product product) {
        try {
            entityManager.getTransaction().begin();
            entityManager.persist(product);
            entityManager.getTransaction().commit();
        } catch (Exception ex) {
            entityManager.getTransaction().rollback();
            ex.printStackTrace();
        }
    }

    @Override
    public void deleteProduct(long id) {
        try {
            entityManager.getTransaction().begin();
            Product w = entityManager.find(Product.class, id);
            entityManager.remove(w);
            entityManager.getTransaction().commit();
        } catch (Exception ex) {
            ex.printStackTrace();
        }
    }

    @Override
    public Order order(long id) {
        Order o = entityManager.find(Order.class, id);
        return o;
    }

    @Override
    public User getUser(String login) {
        Query query = entityManager.createQuery("SELECT p FROM User p WHERE p.email = :email", User.class);
        query.setParameter("email", login);
        User lUser = null;
        try {
            lUser = (User) query.getSingleResult();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return lUser;
    }

    @Override
    public String product(long id) {
        Query query = entityManager.createQuery("SELECT p FROM Product p WHERE p.id = :id", Product.class);
        query.setParameter("id", id);
        Product p = (Product) query.getSingleResult();

        return new String(p.getPhoto());
    }

    @Override
    public Product prod(long id) {
        if (id != 0){
        Query query = entityManager.createQuery("SELECT p FROM Product p WHERE p.id = :id", Product.class);
        query.setParameter("id", id);

            Product p = (Product) query.getSingleResult();
            return p;
        }
        return null;

    }

}
