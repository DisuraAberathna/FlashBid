package com.disuraaberathna.flashbid.web.servlet;

import com.disuraaberathna.flashbid.ejb.remote.BidManager;
import com.google.gson.Gson;
import com.google.gson.JsonObject;
import jakarta.ejb.EJB;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet("/place-bid")
public class PlaceBid extends HttpServlet {

    @EJB
    private BidManager bidManager;

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        Gson gson = new Gson();
        JsonObject json = gson.fromJson(req.getReader(), JsonObject.class);

        String response = bidManager.placeBid(json.get("id").getAsString(), json.get("bid").getAsString(), req.getSession().getAttribute("user").toString());

        resp.setContentType("application/json");
        resp.getWriter().write(response);
    }
}
