package store.db; /**
 * Created by Anton on 25.11.2015.
 */

import store.db.Order;

import javax.persistence.*;
import java.util.ArrayList;
import java.util.List;

@Entity
@Table(name="Users")
public class User {
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    private long id;
    private String name;
    private String surname;
    private String phone;
    private String email;
    private String password;

    @OneToMany(mappedBy="user", cascade = CascadeType.ALL, fetch = FetchType.LAZY)
    private List<Order> orders = new ArrayList<Order>();

    public void addOrder(Order order) {
        orders.add(order);
    }
    public void setOrders(List<Order> orders){
        this.orders = orders;
    }
    public List<Order> getOrders(){
        return orders;
    }

    public User(){}
    public User(String name, String surname, String phone, String email, String password) {
        this.name = name;
        this.surname = surname;
        this.phone = phone;
        this.email = email;
        this.password = password;
    }


    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getSurname() {
        return surname;
    }

    public void setSurname(String surname) {
        this.surname = surname;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public long getId() {
        return id;
    }

    public void setId(long id) {
        this.id = id;
    }
}
