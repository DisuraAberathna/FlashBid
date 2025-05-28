package com.disuraaberathna.flashbid.core.model;

import java.io.Serializable;
import java.util.Date;

public class AuctionItem implements Serializable {
    private String id;
    private String title;
    private String startBid;
    private String currentBid;
    private User currentUser;
    private Date startTime;
    private Date endTime;
    private boolean completed = false;

    public AuctionItem() {
    }

    public AuctionItem(String id, String title, String startBid, String currentBid, User currentUser, Date startTime, Date endTime, boolean completed) {
        this.id = id;
        this.title = title;
        this.startBid = startBid;
        this.currentBid = currentBid;
        this.currentUser = currentUser;
        this.startTime = startTime;
        this.endTime = endTime;
        this.completed = completed;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getStartBid() {
        return startBid;
    }

    public void setStartBid(String startBid) {
        this.startBid = startBid;
    }

    public String getCurrentBid() {
        return currentBid;
    }

    public void setCurrentBid(String currentBid) {
        this.currentBid = currentBid;
    }

    public User getCurrentUser() {
        return currentUser;
    }

    public void setCurrentUser(User currentUser) {
        this.currentUser = currentUser;
    }

    public Date getStartTime() {
        return startTime;
    }

    public void setStartTime(Date startTime) {
        this.startTime = startTime;
    }

    public Date getEndTime() {
        return endTime;
    }

    public void setEndTime(Date endTime) {
        this.endTime = endTime;
    }

    public boolean isCompleted() {
        return completed;
    }

    public void setCompleted(boolean completed) {
        this.completed = completed;
    }
}
