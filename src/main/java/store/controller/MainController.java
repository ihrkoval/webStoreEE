package store.controller;
import java.io.File;
import org.apache.commons.io.FileUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.context.ServletContextAware;
import store.controller.basket.basketDAO;
import store.db.Order;
import store.db.Product;
import store.StoreDAO;
import store.db.User;

import java.security.Principal;
import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

/**
 * Created by Anton on 25.11.2015.
 */
@Controller
@RequestMapping("/")
public class MainController implements ServletContextAware{
    @Autowired
    private StoreDAO strDAO;
    @Autowired
    private basketDAO bDAO;
    private ServletContext servletContext;

    @RequestMapping("/")
    public String index(Model model, Principal pr, HttpServletResponse resp) {
        model.addAttribute("products", strDAO.products());
        String username;
        int ordersInBasket=0;
        Order orders;
        User user;
        try {
            username = pr.getName();
            if (username.length()>1) {
                user = strDAO.getUser(username);
                orders = bDAO.ordersByConfirmedValue(user.getId(), 1);
                ordersInBasket = bDAO.ordersByConfirmedValue(user.getId(), 0).getProductList().size();

            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        model.addAttribute("inbasket", " (" + ordersInBasket + ")");
        return "index";
    }



    @RequestMapping(value = "/images/{prod_id}")
    public ModelAndView redact( HttpServletResponse response, @PathVariable("prod_id") long fileId) {
        try {
            String p = strDAO.product(fileId);
            Path path = Paths.get(p);
           byte[] data = Files.readAllBytes(path);
            response.setContentType("image/png");
            response.getOutputStream().write(data);
        } catch (IOException ex) {
            ex.printStackTrace();
        }
        return null;
    }
    @RequestMapping(value = "/confirmorder/{u_id}")
    public ModelAndView confirmorder( HttpServletResponse response,
                                      HttpServletRequest request,@PathVariable("u_id") long uId) {
        try {
            Order unconfirmed = bDAO.ordersByConfirmedValue(uId, 1);
            unconfirmed.setConfirmed(2);
                bDAO.orderAdd(unconfirmed);
            response.sendRedirect(request.getHeader("Referer"));
        } catch (IOException ex) {
            ex.printStackTrace();
        }
        return null;
    }

    @RequestMapping(value = "/confirm/{u_id}")
    public ModelAndView confirm( HttpServletResponse response, @PathVariable("u_id") long fileId) {
        try {
           Order unconfirmed = bDAO.ordersByConfirmedValue(fileId, 1);
            String[] names =new String[unconfirmed.getProductList().size()-1];
            for (int i = 0; i < unconfirmed.getProductList().size()-1 ; i++) {
                names[i] = unconfirmed.getProductList().get(i).getName();
            }
            String s = Arrays.toString(names);
            byte[] b = s.getBytes();
            response.setContentType("text/plain");
            response.getOutputStream().write(b);
        } catch (IOException ex) {
            ex.printStackTrace();
        }
        return null;
    }

    @RequestMapping(value = "/redact/{prod_id}")
    public ModelAndView redactProduct(@PathVariable("prod_id") long fileId) {
        Product p = strDAO.prod(fileId);

        return new ModelAndView("redact", "p", p);
    }

    @RequestMapping(value = "/{cat_name}")
        public String catlist(Model model, @PathVariable("cat_name")String cat,
                              HttpServletRequest request) {
        List<Product> p = strDAO.byCat(cat);
        System.out.println(cat);
        for (Product product : p) {
            System.out.println(product.getName());
        }

        String s = request.getHeader("Referer");
        if (s.contains("product")) {
            model.addAttribute("product", p);
            return "products";
        }
        model.addAttribute("products", p);
        return "index";
    }

    @RequestMapping("/admin")
    public String admin(Model model) {
        List<User> users = strDAO.uncofirmedUsers();
        for (User u : users) {
            List<Order> orders = new ArrayList<>();
            orders.add(bDAO.ordersByConfirmedValue(u.getId(), 1));
            u.setOrders(orders);
        }
        model.addAttribute("product", strDAO.products());
        model.addAttribute("users", users);
        return "admin";
    }

    @RequestMapping(value = "/delete")
    public ModelAndView update(@RequestParam(value = "id")long id){
        strDAO.deleteProduct(id);
         return new ModelAndView("admin", "product", strDAO.products());
    }


    @RequestMapping(value = "/update", method = RequestMethod.POST)       //admin update Product
    public ModelAndView update(@RequestParam(value = "name") String n,
                               @RequestParam(value = "cat") String c,
                               @RequestParam(value = "desc") String d,
                               @RequestParam(value = "photo") MultipartFile p,
                               @RequestParam(value = "price") String pr,
                               @RequestParam(value = "id")long i){
      Product product = strDAO.prod(i);
      if (n.length()!=0)
          product.setName(n);
        if (c.length() != 0)
            product.setCat_id(c);
        if (d.length() != 0)
            product.setDescription(d);
        if (!p.isEmpty() )
            try {
                String filename = p.getOriginalFilename();
                File file = new File(servletContext.getRealPath("/") + "/WEB-INF/pages/images/"
                        + filename);

                FileUtils.writeByteArrayToFile(file, p.getBytes());
                String path = file.getAbsolutePath();
               product.setPhoto(path);
            } catch (IOException e) {
                e.printStackTrace();
            }
        if (pr.length() != 0)
            product.setPrice(Double.parseDouble(pr));

        strDAO.productAdd(product);
              return new ModelAndView("admin", "product", strDAO.products());
    }


    @RequestMapping(value = "/addProduct", method = RequestMethod.POST)  //admin add Product
    public ModelAndView addProduct(@RequestParam(value = "name") String name,
                              @RequestParam(value = "category") String cat,
                              @RequestParam(value = "price") double price,
                              @RequestParam(value = "desc") String desc,
                              @RequestParam(value = "photo") MultipartFile photo) {
        String filename = photo.getOriginalFilename();
        Product pr = new Product();
        try {
            File file = new File(servletContext.getRealPath("/") + "/WEB-INF/pages/images/"
                    + filename);

            FileUtils.writeByteArrayToFile(file, photo.getBytes());
            String path = file.getAbsolutePath();
            if (photo == null){
                path="https://pp.vk.me/c631228/v631228187/56ae/_Vjy_l1PyMM.jpg";
            }
            pr = new Product(name, cat, price, path, desc);
        } catch (IOException e) {
            e.printStackTrace();
        }
        strDAO.productAdd(pr);
        return new ModelAndView("admin", "product", strDAO.products()); //, "product", strDAO.products()
    }




    @Override
    public void setServletContext(ServletContext servletContext) {
        this.servletContext = servletContext;
    }
}

