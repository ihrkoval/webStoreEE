package store.controller.basket;

import store.db.Order;
import store.db.User;

import java.util.List;

/**
 * Created by Anton on 16.12.2015.
 */
public interface basketDAO{
    List<Order> allOrdersListByUser(User user);
    Order ordersByConfirmedValue(long userid, int value);
    void orderAdd(Order order);
    void deleteOrder(long id);
}
