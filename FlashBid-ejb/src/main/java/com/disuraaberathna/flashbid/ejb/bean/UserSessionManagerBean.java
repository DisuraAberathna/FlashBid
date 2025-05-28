package com.disuraaberathna.flashbid.ejb.bean;

import com.disuraaberathna.flashbid.core.dto.ResponseDto;
import com.disuraaberathna.flashbid.core.model.User;
import com.disuraaberathna.flashbid.ejb.remote.UserSessionManager;
import com.disuraaberathna.flashbid.ejb.store.UserDataStore;
import com.disuraaberathna.flashbid.ejb.validation.UserValidation;
import com.google.gson.Gson;
import jakarta.ejb.Stateless;
import jakarta.inject.Inject;

import java.util.UUID;

@Stateless
public class UserSessionManagerBean implements UserSessionManager {

    @Inject
    private UserDataStore userDataStore;

    @Inject
    private UserValidation userValidation;

    @Override
    public String login(String username, String password) {
        Gson gson = new Gson();

        ResponseDto responseDto = userValidation.validateForLogin(username, password);

        return gson.toJson(responseDto);
    }

    @Override
    public String register(String username, String password) {
        Gson gson = new Gson();
        ResponseDto responseDto = userValidation.validateForRegister(username, password);

        if (responseDto.isSuccess()) {
            String id = UUID.randomUUID().toString();

            userDataStore.addUser(new User(id, username, password));
            responseDto.setMessage(id);
        }

        return gson.toJson(responseDto);
    }
}
