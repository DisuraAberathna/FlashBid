package com.disuraaberathna.flashbid.web.servlet;

import com.disuraaberathna.flashbid.core.dto.ResponseDto;
import com.disuraaberathna.flashbid.ejb.remote.UserSessionManager;
import com.google.gson.Gson;
import com.google.gson.JsonObject;
import jakarta.ejb.EJB;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet("/register")
public class register extends HttpServlet {

    @EJB
    private UserSessionManager userSessionManager;

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        Gson gson = new Gson();
        JsonObject reqJson = gson.fromJson(req.getReader(), JsonObject.class);

        String response = userSessionManager.register(reqJson.get("username").getAsString(), reqJson.get("password").getAsString());

        ResponseDto responseDto = gson.fromJson(response, ResponseDto.class);
        if (responseDto.isSuccess()) {
            req.getSession().setAttribute("user", responseDto.getMessage());
        }

        resp.setContentType("application/json");
        resp.getWriter().write(response);
    }
}
