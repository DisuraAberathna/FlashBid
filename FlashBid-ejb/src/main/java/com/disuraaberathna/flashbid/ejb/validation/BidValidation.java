package com.disuraaberathna.flashbid.ejb.validation;

import com.disuraaberathna.flashbid.core.dto.ResponseDto;
import com.disuraaberathna.flashbid.core.model.AuctionItem;
import com.disuraaberathna.flashbid.ejb.store.AuctionDataStore;
import jakarta.ejb.Stateless;
import jakarta.inject.Inject;

import java.util.Date;

@Stateless
public class BidValidation {

    @Inject
    private AuctionDataStore dataStore;

    public ResponseDto validateForUpdateBid(String bid, String auctionItem) {
        AuctionItem item = dataStore.getAuctionItem(auctionItem);
        ResponseDto responseDto = new ResponseDto();

        if (item == null) {
            responseDto.setMessage("Auction item does not exist");
            return responseDto;
        }

        if (item.isCompleted() || item.getEndTime().before(new Date())) {
            responseDto.setMessage("Auction is already completed");
            return responseDto;
        }

        double newBid;
        try {
            newBid = Double.parseDouble(bid);
        } catch (NumberFormatException e) {
            responseDto.setMessage("Enter a valid numeric bid.");
            return responseDto;
        }

        double currentBid = Double.parseDouble(item.getCurrentBid());
        if (newBid <= currentBid) {
            responseDto.setMessage("Bid must be greater than current bid.");
            return responseDto;
        }

        responseDto.setSuccess(true);
        return responseDto;
    }
}
