package com.disuraaberathna.flashbid.ejb.bean;

import com.disuraaberathna.flashbid.ejb.remote.UserSessionManager;
import com.disuraaberathna.flashbid.ejb.store.UserDataStore;
import jakarta.ejb.Stateless;
import jakarta.inject.Inject;

@Stateless
public class UserSessionManagerBean implements UserSessionManager {

    @Inject
    private UserDataStore userDataStore;

    @Override
    public String login(String username, String password) {
        return "";
    }

    @Override
    public String register(String username, String password) {
        return "";
    }

    @Override
    public void logout(String userId) {

    }
}
