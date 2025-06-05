package com.disuraaberathna.flashbid.web.servlet;

import com.disuraaberathna.flashbid.ejb.remote.UserSessionManager;
import com.google.gson.Gson;
import jakarta.ejb.EJB;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet("/get-users")
public class GetUsers extends HttpServlet {

    @EJB
    private UserSessionManager userSessionManager;

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        Gson gson = new Gson();
        resp.setContentType("application/json");
        resp.getWriter().write(gson.toJson(userSessionManager.getAllUsers()));
    }
}
