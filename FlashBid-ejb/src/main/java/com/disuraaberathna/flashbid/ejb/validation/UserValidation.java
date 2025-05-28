package com.disuraaberathna.flashbid.ejb.validation;

import com.disuraaberathna.flashbid.core.dto.ResponseDto;
import com.disuraaberathna.flashbid.core.model.User;
import com.disuraaberathna.flashbid.ejb.store.UserDataStore;
import jakarta.ejb.Stateless;
import jakarta.inject.Inject;

import java.util.Map;

@Stateless
public class UserValidation {

    @Inject
    private UserDataStore userDataStore;

    public ResponseDto validateForRegister(String username, String password) {
        ResponseDto responseDto = new ResponseDto();

        if (username == null || username.isEmpty()) {
            responseDto.setMessage("Enter your username");
            return responseDto;
        }

        for (Map.Entry<String, User> entry : userDataStore.getAllUsers().entrySet()) {
            User user = entry.getValue();
            if (user.getUsername().equals(username)) {
                responseDto.setMessage("User is already registered");
                return responseDto;
            }
        }

        if (password == null || password.isEmpty()) {
            responseDto.setMessage("Enter your password");
            return responseDto;
        }

        responseDto.setSuccess(true);
        return responseDto;
    }

    public ResponseDto validateForLogin(String username, String password) {
        ResponseDto responseDto = new ResponseDto();

        if (username == null || username.isEmpty()) {
            responseDto.setMessage("Enter your username");
            return responseDto;
        }

        if (password == null || password.isEmpty()) {
            responseDto.setMessage("Enter your password");
            return responseDto;
        }

        for (Map.Entry<String, User> entry : userDataStore.getAllUsers().entrySet()) {
            User user = entry.getValue();
            if (user.getUsername().equals(username) && user.getPassword().equals(password)) {
                responseDto.setSuccess(true);
                responseDto.setMessage(user.getId());
            } else {
                responseDto.setMessage("Cannot find user, please register first");
            }
            return responseDto;
        }

        responseDto.setMessage("Please try again later.");
        return responseDto;
    }
}
