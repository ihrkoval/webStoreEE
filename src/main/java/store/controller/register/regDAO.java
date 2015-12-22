package store.controller.register;

import store.db.User;

/**
 * Created by Anton on 16.12.2015.
 */
public interface regDAO {
    User userAdd(User user);
}
