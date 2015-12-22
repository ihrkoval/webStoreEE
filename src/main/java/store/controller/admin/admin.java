package store.controller.admin;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import store.StoreDAO;
import store.controller.basket.basketDAO;
import store.db.Order;
import store.db.User;

import java.util.ArrayList;
import java.util.List;

/**
 * Created by Anton on 20.12.2015.
 */
@Controller
@RequestMapping("/")
public class admin {
    @Autowired
    private StoreDAO strDAO;
    @Autowired
    private basketDAO bDAO;

    @RequestMapping("/orders") //
    public String Orders(Model model) {

        List<User> users = strDAO.uncofirmedUsers();
        for (User u : users) {
            List<Order> orders = new ArrayList<>();
            orders.add(bDAO.ordersByConfirmedValue(u.getId(), 1));
            u.setOrders(orders);
        }
        model.addAttribute("product", strDAO.products());
        model.addAttribute("users", users);
return "orders";
    }

    @RequestMapping("/product") //
    public String products(Model model) {

        List<User> users = strDAO.uncofirmedUsers();
        for (User u : users) {
            List<Order> orders = new ArrayList<>();
            orders.add(bDAO.ordersByConfirmedValue(u.getId(), 1));
            u.setOrders(orders);
        }
        model.addAttribute("product", strDAO.products());
        model.addAttribute("users", users);
        return "products";
    }

    @RequestMapping("/users")
    public String users(Model model) {
        model.addAttribute("users", strDAO.users());
        return "users";
    }

    @RequestMapping("/orders/delete/{id}") //
    public String deleteOrder(@PathVariable(value = "id") long orderId, Model model) {
        System.out.println("ID !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!! : "+orderId);
        bDAO.deleteOrder(orderId);

        List<User> users = strDAO.uncofirmedUsers();
        for (User u : users) {
            List<Order> orders = new ArrayList<>();
            orders.add(bDAO.ordersByConfirmedValue(u.getId(), 1));
            u.setOrders(orders);
        }
        model.addAttribute("product", strDAO.products());
        model.addAttribute("users", users);
        return "orders";
    }
}
