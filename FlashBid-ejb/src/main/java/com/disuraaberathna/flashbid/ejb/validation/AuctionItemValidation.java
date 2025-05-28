package com.disuraaberathna.flashbid.ejb.validation;

import com.disuraaberathna.flashbid.core.dto.ResponseDto;
import com.disuraaberathna.flashbid.core.model.AuctionItem;
import jakarta.ejb.Stateless;

import java.util.Date;

@Stateless
public class AuctionItemValidation {
    public ResponseDto validateAuctionItem(String title, String startBid, Date startDate, Date endDate) {
        ResponseDto responseDto = new ResponseDto();

        if (title == null || title.isEmpty()) {
            responseDto.setMessage("Enter a title for the auction item.");
            return responseDto;
        }

        if (startBid == null || startBid.isEmpty()) {
            responseDto.setMessage("Specify the starting bid amount.");
            return responseDto;
        }

        try {
            double bidAmount = Double.parseDouble(startBid);
            if (bidAmount <= 0) {
                responseDto.setMessage("Starting bid must be a positive number.");
                return responseDto;
            }
        } catch (NumberFormatException e) {
            responseDto.setMessage("Starting bid must be a valid number.");
            return responseDto;
        }

        if (startDate == null || endDate == null) {
            responseDto.setMessage("Start date and end date must be provided.");
            return responseDto;
        }

        if (startDate.after(endDate)) {
            responseDto.setMessage("The start date must be before the end date.");
            return responseDto;
        }

        responseDto.setSuccess(true);
        return responseDto;
    }
}
