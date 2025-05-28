package com.disuraaberathna.flashbid.ejb.bean;

import com.disuraaberathna.flashbid.core.dto.ResponseDto;
import com.disuraaberathna.flashbid.core.model.AuctionItem;
import com.disuraaberathna.flashbid.ejb.remote.AuctionManager;
import com.disuraaberathna.flashbid.ejb.store.AuctionDataStore;
import com.disuraaberathna.flashbid.ejb.validation.AuctionItemValidation;
import com.google.gson.Gson;
import jakarta.ejb.Stateless;
import jakarta.inject.Inject;

import java.util.Date;
import java.util.Map;
import java.util.UUID;

@Stateless
public class AuctionManagerBean implements AuctionManager {

    @Inject
    private AuctionDataStore auctionDataStore;

    @Inject
    private AuctionItemValidation auctionItemValidation;

    @Override
    public Map<String, AuctionItem> getAllAuctions() {
        return auctionDataStore.getAllAuctionItems();
    }

    @Override
    public AuctionItem getActionItem(String auctionId) {
        return auctionDataStore.getAuctionItem(auctionId);
    }

    @Override
    public String addAuctionItem(String title, String startBid, Date startDate, Date endDate) {
        Gson gson = new Gson();

        ResponseDto responseDto = auctionItemValidation.validateAuctionItem(title, startBid, startDate, endDate);

        if (responseDto.isSuccess()) {
            String id = UUID.randomUUID().toString();

            AuctionItem item = new AuctionItem(id, title, startBid, startBid, null, startDate, endDate, false);
            auctionDataStore.addAuctionItem(item);
        }

        return gson.toJson(responseDto);
    }

    @Override
    public String endAuctionItem(String auctionId) {
        Gson gson = new Gson();
        ResponseDto responseDto = new ResponseDto();

        AuctionItem auctionItem = auctionDataStore.getAuctionItem(auctionId);
        auctionItem.setCompleted(true);

        auctionDataStore.updateAuctionItem(auctionId, auctionItem);

        responseDto.setSuccess(true);
        return gson.toJson(responseDto);
    }
}
