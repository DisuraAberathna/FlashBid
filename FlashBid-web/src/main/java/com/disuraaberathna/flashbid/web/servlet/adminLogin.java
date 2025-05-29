package com.disuraaberathna.flashbid.web.servlet;

import com.disuraaberathna.flashbid.core.dto.ResponseDto;
import com.google.gson.Gson;
import com.google.gson.JsonObject;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet("/admin-login")
public class adminLogin extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        Gson gson = new Gson();
        JsonObject json = gson.fromJson(req.getReader(), JsonObject.class);

        String username = json.get("username").getAsString();
        String password = json.get("password").getAsString();

        ResponseDto responseDto = new ResponseDto();

        if (username.equals("admin") && password.equals("admin")) {
            req.getSession().setAttribute("admin", username);
            responseDto.setSuccess(true);
        }else {
            responseDto.setMessage("Username or password incorrect");
        }

        resp.setContentType("application/json");
        resp.getWriter().write(gson.toJson(responseDto));
    }
}
