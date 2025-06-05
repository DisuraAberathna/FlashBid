package com.disuraaberathna.flashbid.ejb.remote;

import com.disuraaberathna.flashbid.core.model.User;
import jakarta.ejb.Remote;

import java.util.Map;

@Remote
public interface UserSessionManager {
    String login(String username, String password);

    String register(String username, String password);

    Map<String, User> getAllUsers();
}
