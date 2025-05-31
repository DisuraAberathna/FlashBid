package com.disuraaberathna.flashbid.web.servlet;

import com.disuraaberathna.flashbid.core.model.AuctionItem;
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
import java.util.List;
import java.util.Map;

@WebServlet("/get-auction-items")
public class GetAuctionItems extends HttpServlet {

    @EJB
    private AuctionManager auctionManager;

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        Gson gson = new Gson();
        JsonObject json = new JsonObject();

        Map<String, AuctionItem> auctionItemMap = auctionManager.getAllAuctions();

        List<AuctionItem> auctionItemList = auctionItemMap.values().stream().toList();

        if (auctionItemList.isEmpty()) {
            json.addProperty("success", false);
            json.addProperty("message", "No Auction Items Found");
        }else {
            json.addProperty("success", true);
            json.add("items", gson.toJsonTree(auctionItemList));
        }

        resp.setContentType("application/json");
        resp.getWriter().write(gson.toJson(json));
    }
}
