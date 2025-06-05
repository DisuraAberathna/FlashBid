package com.disuraaberathna.flashbid.ejb.remote;

import jakarta.ejb.Remote;

@Remote
public interface BidManager {
    String placeBid(String auctionId, String bid, String userId);
}
