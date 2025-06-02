package com.disuraaberathna.flashbid.web.mdb;

import com.disuraaberathna.flashbid.web.websocket.Auction;
import jakarta.ejb.ActivationConfigProperty;
import jakarta.ejb.MessageDriven;
import jakarta.jms.JMSException;
import jakarta.jms.Message;
import jakarta.jms.MessageListener;

@MessageDriven(activationConfig = {
        @ActivationConfigProperty(propertyName = "destinationType", propertyValue = "jakarta.jms.Topic"),
        @ActivationConfigProperty(propertyName = "destinationLookup", propertyValue = "flashBidTopic"),
        @ActivationConfigProperty(propertyName = "destination", propertyValue = "flashBidTopic"),
        @ActivationConfigProperty(propertyName = "resourceAdapter", propertyValue = "activemq-rar-6.1.6"),
})
public class MessageReceiver implements MessageListener {
    @Override
    public void onMessage(Message message) {
        try {
            Auction.broadcast(message.getBody(String.class));
        } catch (JMSException e) {
            throw new RuntimeException(e);
        }
    }
}
