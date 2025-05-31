package com.disuraaberathna.flashbid.ejb.remote;

import jakarta.ejb.Local;

@Local
public interface MessageSendManager {
    void sendMessage(String auctionItemId);
}
