package com.disuraaberathna.flashbid.web.servlet;

import com.disuraaberathna.flashbid.core.dto.ResponseDto;
import com.disuraaberathna.flashbid.ejb.remote.AuctionManager;
import com.google.gson.Gson;
import com.google.gson.JsonObject;
import jakarta.ejb.EJB;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet("/end-auction")
public class EndAuction extends HttpServlet {

    @EJB
    private AuctionManager auctionManager;

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        Gson gson = new Gson();
        JsonObject json = gson.fromJson(req.getReader(), JsonObject.class);

        String response = auctionManager.endAuctionItem(json.get("id").getAsString());

        resp.setContentType("application/json");
        resp.getWriter().write(response);
    }
}
