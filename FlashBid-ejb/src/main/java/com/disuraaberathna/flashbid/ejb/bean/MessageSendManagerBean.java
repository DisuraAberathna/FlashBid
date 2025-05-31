package com.disuraaberathna.flashbid.ejb.bean;

import com.disuraaberathna.flashbid.core.model.AuctionItem;
import com.disuraaberathna.flashbid.ejb.remote.MessageSendManager;
import com.disuraaberathna.flashbid.ejb.store.AuctionDataStore;
import com.google.gson.Gson;
import com.google.gson.JsonObject;
import jakarta.ejb.Stateless;
import jakarta.inject.Inject;
import jakarta.jms.*;
import org.apache.activemq.ActiveMQConnectionFactory;

@Stateless
public class MessageSendManagerBean implements MessageSendManager {

    @Inject
    private AuctionDataStore auctionDataStore;

    @Override
    public void sendMessage(String auctionItemId) {
        ActiveMQConnectionFactory connectionFactory = new ActiveMQConnectionFactory("tcp://localhost:61616");
        try {
            Connection connection = connectionFactory.createConnection();
            connection.setClientID("FlashBid");
            connection.start();

            Session session = connection.createSession(false, Session.AUTO_ACKNOWLEDGE);
            Topic topic = session.createTopic("activeMqTopic");

            MessageProducer producer = session.createProducer(topic);

            AuctionItem auctionItem = auctionDataStore.getAuctionItem(auctionItemId);

            JsonObject jsonObject = new JsonObject();
            jsonObject.addProperty("id", auctionItemId);
            jsonObject.addProperty("currentBid", auctionItem.getCurrentBid());
            jsonObject.addProperty("user", auctionItem.getCurrentUser().getUsername());

            Message message = session.createTextMessage(new Gson().toJson(jsonObject));
            producer.send(message);

            producer.close();
            session.close();
            connection.close();
        } catch (JMSException e) {
            throw new RuntimeException(e);
        }
    }
}
