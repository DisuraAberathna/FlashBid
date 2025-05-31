<%--
  Created by IntelliJ IDEA.
  User: User
  Date: 5/29/2025
  Time: 5:31 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>FlashBid | Home</title>
    <script src="https://cdn.jsdelivr.net/npm/axios/dist/axios.min.js"></script>
</head>
<body onload="loadAuctionItems()">
<main>
    <div>
        <fieldset>
            <legend>
                <h3>Auction Items</h3>
            </legend>
            <div id="items">
                <div id="item">
                    <fieldset>
                        <h4 id="itemTitle">Auction Item</h4>
                        <div>
                            <label>Current Bid : </label>
                            <label id="currentBid">LKR 100</label>
                        </div>
                        <div>
                            <label>Start At : </label>
                            <label id="startedAt">2025/05/29</label>
                        </div>
                        <div>
                            <label id="status">On Going</label>
                        </div>
                        <br/>
                        <div>
                            <button id="joinAuctionBtn">Join Auction</button>
                        </div>
                    </fieldset>
                </div>
            </div>
        </fieldset>
    </div>
</main>
<script>
    const joinAuction = (id) => {
        window.location.href = "auction.jsp?id=" + id;
    }

    const loadAuctionItems = async () => {
        const response = await axios.post("get-auction-items");

        // console.log(response);

        if (response.status === 200) {
            const data = response.data;

            const auctionItemView = document.getElementById("item");
            const items = document.getElementById("items");

            if (data.success) {
                items.innerHTML = "";

                data.items.forEach(auctionItem => {
                    let auctionItemClone = auctionItemView.cloneNode(true);

                    auctionItemClone.querySelector("#itemTitle").innerHTML = auctionItem.title;
                    auctionItemClone.querySelector("#currentBid").innerHTML = "LKR " + new Intl.NumberFormat("en-US", {
                        minimumFractionDigits: 2,
                    }).format(auctionItem.currentBid);
                    auctionItemClone.querySelector("#startedAt").innerHTML = auctionItem.startTime;
                    auctionItemClone.querySelector("#status").innerHTML = auctionItem.completed ? "Auction Ended" : "On Going";
                    if (!auctionItem.completed) {
                        auctionItemClone.querySelector("#joinAuctionBtn").innerHTML = "Join Auction";
                        auctionItemClone.querySelector("#joinAuctionBtn").addEventListener("click", (e) => {
                            e.preventDefault();
                            joinAuction(auctionItem.id);
                        });
                    }

                    items.appendChild(auctionItemClone);
                });
            } else {
                items.innerHTML = data.message;
            }
        } else {
            alert("Something went wrong");
        }
    }
</script>
</body>
</html>
