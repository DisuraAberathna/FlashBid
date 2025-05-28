package com.disuraaberathna.flashbid.ejb.store;

import com.disuraaberathna.flashbid.core.model.User;
import jakarta.ejb.Lock;
import jakarta.ejb.LockType;
import jakarta.ejb.Singleton;

import java.io.Serializable;
import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;

@Singleton
public class UserDataStore implements Serializable {
    private final Map<String, User> userMap = new ConcurrentHashMap<>();

    @Lock(LockType.READ)
    public User getUser(String id) {
        return userMap.get(id);
    }

    @Lock(LockType.WRITE)
    public void addUser(User user) {
        userMap.put(user.getId(), user);
    }

    @Lock(LockType.READ)
    public Map<String, User> getAllUsers() {
        return userMap;
    }
}
