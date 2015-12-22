package store.controller.basket;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import store.StoreDAO;
import store.db.Order;
import store.db.Product;
import store.db.User;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.security.Principal;
import java.util.Iterator;
import java.util.List;

/**
 * Created by Anton on 16.12.2015.
 */
@Controller
@RequestMapping("/")
public class basket {

    @Autowired
    private StoreDAO strDAO;
    @Autowired
    private basketDAO bDAO;

    @RequestMapping("/basket")
    public String basket(Model model, Principal principal) {
        String userName = principal.getName();
        User user = strDAO.getUser(userName);
        List<Order> basketTmp = bDAO.allOrdersListByUser(user);
        Order basket = bDAO.ordersByConfirmedValue(user.getId(), 0);
        try {
            List<Product> products = basket.getProductList();
            model.addAttribute("products", products);
            System.out.println(products.size() + " :PRODUCT LENGHt@@!!!!!!!!");
        } catch (NullPointerException n) {
        }
        model.addAttribute("orders", basket);
        model.addAttribute("history", basketTmp);
        return "basket";
    }

    @RequestMapping("/basket/{id}") //add product to basket
    public String putToBasket(Model model, Principal principal,
                              HttpServletResponse response,
                              HttpServletRequest request,
                              @PathVariable("id") long id) throws IOException {
        try {
            User user = strDAO.getUser(principal.getName());
            Product product = strDAO.prod(id);
            Order o = new Order(user, product);
            Order order = bDAO.ordersByConfirmedValue(user.getId(), 0);
            if (order != null) {
                order.setName(order.getName() + ", " + o.getName());
                order.setPrice(order.getPrice() + o.getPrice());
                Product p = o.getProductList().get(0);
                List<Product> prods = order.getProductList();
                prods.add(p);
                order.setProductList(prods);
                bDAO.orderAdd(order);
            } else
                bDAO.orderAdd(o);
            response.sendRedirect(request.getHeader("Referer"));

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("/reg");
            try {
                response.getWriter().println("Error" + e);
            } catch (Exception e1) {
                e1.printStackTrace();
            }
        }

        return null;
    }

    @RequestMapping("/basket/confirm/") //user push confirm button to confirm orders from basket
    public String confirmOrder(Model model, Principal principal,
                               HttpServletResponse response) {
        try {
            User user = strDAO.getUser(principal.getName());
            Order unconfirmed = bDAO.ordersByConfirmedValue(user.getId(), 0);
            Order ifexist = bDAO.ordersByConfirmedValue(user.getId(), 1);
            if (ifexist != null) {
                ifexist.setName(ifexist.getName() + ", " + unconfirmed.getName());
                ifexist.setPrice(ifexist.getPrice() + unconfirmed.getPrice());
                bDAO.deleteOrder(unconfirmed.getId());
                if (unconfirmed.getPrice() != 0)
                bDAO.orderAdd(ifexist);

            } else {
                unconfirmed.setConfirmed(1);
                if (unconfirmed.getPrice() != 0)
                bDAO.orderAdd(unconfirmed);
            }

            response.sendRedirect("/basket");

        } catch (Exception e) {
            e.printStackTrace();
            try {
                response.getWriter().println("Error " + e);
            } catch (IOException e1) {
                e1.printStackTrace();
            }
        }
        return "basket";
    }

    @RequestMapping("/basket/delete/{id}") //user push delete button to delete orders from basket
    public void deleteOrder(@PathVariable("id") long id,
                              HttpServletResponse response,
                              HttpServletRequest request) throws IOException {
        bDAO.deleteOrder(id);
        response.sendRedirect(request.getHeader("Referer"));

    }

    @RequestMapping("/basket/delete/p/{id}") //user push delete button to delete product from order
    public String deleteprod(@PathVariable("id") long id,
                             Principal principal,
                             HttpServletResponse res) throws IOException {
        User user = strDAO.getUser(principal.getName());
        Order o = bDAO.ordersByConfirmedValue(user.getId(), 0);
        List<Product> products = o.getProductList();

        for (Iterator<Product> prod = products.iterator(); prod.hasNext(); ) {
            Product currentProd = prod.next();
            if (currentProd.getId() == id) {
                o.setPrice(o.getPrice() - currentProd.getPrice());
                prod.remove();
                break;
            }
        }

            o.setProductList(products);
            bDAO.orderAdd(o);
            res.sendRedirect("/basket");
            return null;

    }
}

