package store;


import store.db.Order;
import store.db.Product;
import store.db.User;

import java.util.List;

/**
 * Created by Anton on 25.11.2015.
 */
public interface StoreDAO {
    List<Product> products();
    List<Product> byCat(String product_cat);
    List<Order> list();
    List<User> users();
    List<User> uncofirmedUsers();
    void productAdd(Product product);
    void deleteProduct(long id);
    Order order(long id);
    User getUser(String login);
    String product(long id);
    Product prod(long id);


}
