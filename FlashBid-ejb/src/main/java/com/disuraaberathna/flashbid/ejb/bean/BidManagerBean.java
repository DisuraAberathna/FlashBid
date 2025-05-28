package com.disuraaberathna.flashbid.ejb.bean;

import com.disuraaberathna.flashbid.core.dto.ResponseDto;
import com.disuraaberathna.flashbid.core.model.AuctionItem;
import com.disuraaberathna.flashbid.core.model.User;
import com.disuraaberathna.flashbid.ejb.remote.BidManager;
import com.disuraaberathna.flashbid.ejb.store.AuctionDataStore;
import com.disuraaberathna.flashbid.ejb.store.UserDataStore;
import com.disuraaberathna.flashbid.ejb.validation.BidValidation;
import com.google.gson.Gson;
import jakarta.ejb.Stateless;
import jakarta.inject.Inject;

@Stateless
public class BidManagerBean implements BidManager {

    @Inject
    private AuctionDataStore auctionDataStore;

    @Inject
    private UserDataStore userDataStore;

    @Inject
    private BidValidation bidValidation;

    @Override
    public String placeBid(String auctionId, String bid, String userid) {
        Gson gson = new Gson();
        ResponseDto responseDto = bidValidation.validateForUpdateBid(bid, auctionId);

        if (responseDto.isSuccess()) {
            AuctionItem auctionItem = auctionDataStore.getAuctionItem(auctionId);
            auctionItem.setCurrentBid(bid);
            auctionItem.setCurrentUser(userDataStore.getUser(userid));
            auctionDataStore.updateAuctionItem(auctionItem.getId(), auctionItem);
        }

        return gson.toJson(responseDto);
    }
}
