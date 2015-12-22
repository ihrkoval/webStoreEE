package store.db; /**
 * Created by Anton on 25.11.2015.
 */
import store.db.Order;

import javax.persistence.*;
import java.util.ArrayList;
import java.util.List;

@Entity
@Table(name = "Products")
public class Product {
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    private long id;

    private String name;
    private String cat_id;
    private double price;
    private String photo;
    private String description;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name="product")
    private Order orders;


    public Product(){}

    public Product(String name, String cat_id, double price, String photo, String description) {

        this.name = name;
        this.cat_id = cat_id;
        this.price = price;
        this.photo = photo;
        this.description = description;
    }



    public long getId() {
        return id;
    }

    public void setId(long id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getCat_id() {
        return cat_id;
    }

    public void setCat_id(String cat_id) {
        this.cat_id = cat_id;
    }

    public double getPrice() {
        return price;
    }

    public void setPrice(double price) {
        this.price = price;
    }

    public String getPhoto() {
        return photo;
    }

    public void setPhoto(String photo) {
        this.photo = photo;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

      public Order getOrders() {
        return orders;
    }

    public void setOrders(Order orders) {
        this.orders = orders;
    }
}
