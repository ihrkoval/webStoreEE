package store.db;

import javax.persistence.*;
import java.util.ArrayList;
import java.util.List;

/**
 * Created by Anton on 25.11.2015.
 */
@Entity
@Table(name="Orders")
public class Order {
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    private long id;
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "client_id")
    private User user;

   /* */
   @OneToMany(mappedBy= "orders", cascade={CascadeType.PERSIST, CascadeType.MERGE, CascadeType.REFRESH}, fetch = FetchType.LAZY)
   private List<Product> products = new ArrayList<Product>();

    private String name;
    private double price;
    private int confirmed;

    public Order() {}
    public Order(User user, Product product) {
        this.user = user;
        products.add(product);
        this.name = product.getName();
        this.price = product.getPrice();
        this.confirmed = 0;
    }


    public long getId() {
        return id;
    }

    public void setId(long id) {
        this.id = id;
    }



    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }

    public int getConfirmed() {
        return confirmed;
    }

    public void setConfirmed(int confirmed) {
        this.confirmed = confirmed;
    }

    public List<Product> getProductList() {
        return products;
    }

    public void setProductList(List<Product> product) {

        products = product;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public double getPrice() {
        return price;
    }

    public void setPrice(double price) {
        this.price = price;
    }
}
