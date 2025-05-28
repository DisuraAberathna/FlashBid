package com.disuraaberathna.flashbid.ejb.store;

import com.disuraaberathna.flashbid.core.model.AuctionItem;
import jakarta.ejb.Lock;
import jakarta.ejb.LockType;
import jakarta.ejb.Singleton;
import jakarta.ejb.Startup;

import java.io.Serializable;
import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;

@Singleton
@Startup
public class AuctionDataStore implements Serializable {
    private final Map<String, AuctionItem> auctionItemMap = new ConcurrentHashMap<>();

    @Lock(LockType.READ)
    public AuctionItem getAuctionItem(String auctionId) {
        return auctionItemMap.get(auctionId);
    }

    @Lock(LockType.WRITE)
    public void updateAuctionItem(String auctionId, AuctionItem auctionItem) {
        auctionItemMap.putIfAbsent(auctionId, auctionItem);
    }

    @Lock(LockType.WRITE)
    public void addAuctionItem(AuctionItem item) {
        auctionItemMap.put(item.getId(), item);
    }

    @Lock(LockType.READ)
    public Map<String, AuctionItem> getAllAuctionItems() {
        return auctionItemMap;
    }
}
