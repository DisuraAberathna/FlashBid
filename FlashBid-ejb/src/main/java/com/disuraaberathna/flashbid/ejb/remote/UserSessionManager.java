package com.disuraaberathna.flashbid.ejb.remote;

import jakarta.ejb.Remote;

@Remote
public interface UserSessionManager {
    String login(String username, String password);
    String register(String username, String password);
}
