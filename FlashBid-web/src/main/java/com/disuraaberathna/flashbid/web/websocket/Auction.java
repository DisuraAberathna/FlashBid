package com.disuraaberathna.flashbid.web.websocket;

import jakarta.websocket.OnClose;
import jakarta.websocket.OnMessage;
import jakarta.websocket.OnOpen;
import jakarta.websocket.Session;
import jakarta.websocket.server.ServerEndpoint;

import java.io.IOException;

@ServerEndpoint("/ws/auction")
public class Auction {

    @OnOpen
    public void onOpen(Session session) {
        System.out.println("onOpen");
    }

    @OnMessage
    public void onMessage(String message, Session session) throws IOException {
        System.out.println("Received: " + message);
        session.getBasicRemote().sendText("Server echo: " + message);
    }

    @OnClose
    public void onClose(Session session) {
        System.out.println("onClose");
    }
}
