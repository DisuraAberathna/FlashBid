package com.disuraaberathna.flashbid.ejb.validation;

import com.disuraaberathna.flashbid.core.model.AuctionItem;
import com.disuraaberathna.flashbid.ejb.store.AuctionDataStore;
import jakarta.ejb.Stateless;
import jakarta.inject.Inject;

import java.util.Date;

@Stateless
public class BidValidation {

    @Inject
    private AuctionDataStore dataStore;

    public String validateForUpdateBid(String bid, String auctionItem) {
        AuctionItem item = dataStore.getAuctionItem(auctionItem);

        if (item == null) {
            return "Auction item not found.";
        }

        if (item.isCompleted() || item.getEndTime().before(new Date())) {
            return "Auction is already completed";
        }

        double newBid;
        try {
            newBid = Double.parseDouble(bid);
        } catch (NumberFormatException e) {
            return "Please enter a valid numeric bid.";
        }

        double currentBid = Double.parseDouble(item.getCurrentBid());
        if (newBid <= currentBid) {
            return "Bid must be greater than current bid.";
        }

        return "Success";
    }
}
