package com.disuraaberathna.flashbid.ejb.remote;

import com.disuraaberathna.flashbid.core.model.User;
import jakarta.ejb.Remote;

@Remote
public interface BidManager {
    String placeBid(String auctionId, String bid, String userId);
}
