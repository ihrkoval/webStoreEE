package store.controller.register;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;
import store.db.User;

import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;

/**
 * Created by Anton on 16.12.2015.
 */
@Controller
@RequestMapping("/")
public class registerController {

    @Autowired
    private regDAO regDAO;

    @RequestMapping(value = "/reg")
    public String addPage(Model model) {
        return "reg";
    }

    @RequestMapping(value = "/useradd", method = RequestMethod.POST)             //register add user
    public ModelAndView addAdv(@RequestParam(value = "name") String name,
                               @RequestParam(value = "surname") String surname,
                               @RequestParam(value = "phone", required = false) String phone,
                               @RequestParam(value = "email") String email,
                               @RequestParam(value = "password") String password) {
        // try {

        try {
            MessageDigest md = MessageDigest.getInstance("SHA1"); //password to sha1
            byte[] result = md.digest(password.getBytes());
            StringBuffer sb = new StringBuffer();
            for (int i = 0; i < result.length; i++) {
                sb.append(Integer.toString((result[i] & 0xff) + 0x100, 16).substring(1));
            }
            password = sb.toString();
        } catch (NoSuchAlgorithmException e) {
            e.printStackTrace();
        }

        User usr = new User(
                name, surname, phone, email, password
        );
        User u = regDAO.userAdd(usr); //add new user
        if (u == null)
            return new ModelAndView("index");
        return new ModelAndView("reg");

    }

}
