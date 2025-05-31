package com.disuraaberathna.flashbid.ejb.remote;

import com.disuraaberathna.flashbid.core.model.AuctionItem;
import jakarta.ejb.Remote;

import java.util.Map;

@Remote
public interface AuctionManager {
    Map<String, AuctionItem> getAllAuctions();

    AuctionItem getActionItem(String auctionId);

    String addAuctionItem(String title, String startBid);

    String endAuctionItem(String auctionId);
}
