package com.disuraaberathna.flashbid.web.websocket;

import jakarta.websocket.OnClose;
import jakarta.websocket.OnMessage;
import jakarta.websocket.OnOpen;
import jakarta.websocket.Session;
import jakarta.websocket.server.ServerEndpoint;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

@ServerEndpoint("/ws/auction")
public class Auction {
    protected static final List<Session> sessions = new ArrayList<>();

    @OnOpen
    public void onOpen(Session session) {
        System.out.println("Connection opened: " + session.getId());
        sessions.add(session);
    }

    @OnMessage
    public void onMessage(String message, Session session) throws IOException {
        System.out.println("Received: " + message);
    }

    @OnClose
    public void onClose(Session session) {
        System.out.println("Connection closed: " + session.getId());
        sessions.remove(session);
    }

    public static void broadcast(String message) {
        System.out.println("Broadcasting message: " + message);
        System.out.println("Size of sessions: " + sessions.size());
        for (Session session : sessions) {
            if (session != null && session.isOpen()) {
                try {
                    session.getBasicRemote().sendText(message);
                    System.out.println("Message sent to user : " + message);
                } catch (Exception e) {
                    System.out.println("Error sending message to user : " + e.getMessage());
                }
            } else {
                System.out.println("User not found or session closed");
            }
        }
    }
}
