<%--
  Created by IntelliJ IDEA.
  User: User
  Date: 5/29/2025
  Time: 5:18 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>FlashBid | Auction</title>
    <script src="https://cdn.jsdelivr.net/npm/axios/dist/axios.min.js"></script>
</head>
<body onload="loadAuctionItem()">
<main>
    <div id="item">
        <fieldset>
            <h4 id="itemTitle">Auction Item</h4>
            <div>
                <label>Starting Bid : </label>
                <label id="startBid">LKR 100</label>
            </div>
            <div>
                <label>Current Bid : </label>
                <label id="currentBid">LKR 100</label>
            </div>
            <div>
                <label>Current User : </label>
                <label id="currentUser">user</label>
            </div>
            <div>
                <label>Start At : </label>
                <label id="startedAt">2025/05/29</label>
            </div>
            <div>
                <label>Status : </label>
                <label id="status">Not Yet</label>
            </div>
            <br/>
            <div>
                <label for="bid">Add Your Bid : </label>
                <br/>
                <input type="number" id="bid" name="bid" min="1" step="0.1"/>
            </div>
            <br/>
            <div>
                <button id="bidBtn">Bid</button>
            </div>
            <br/>
            <div>
                <p id="messages"></p>
            </div>
        </fieldset>
    </div>
</main>

<script>
    const loadAuctionItem = async () => {
        const parameters = new URLSearchParams(window.location.search);

        if (parameters.has("id")) {
            const auctionItemId = parameters.get("id");
            let currentBid = 0;

            const response = await axios.post("get-auction-item", {
                id: auctionItemId,
            }, {
                headers: {
                    "Content-Type": "application/json"
                }
            });

            // console.log(response);

            if (response.status === 200) {
                const data = response.data;

                if (data) {
                    document.getElementById("itemTitle").innerText = data.title;
                    document.getElementById("startBid").innerText = "LKR " + new Intl.NumberFormat("en-US", {
                        minimumFractionDigits: 2,
                    }).format(data.startBid);
                    currentBid = parseFloat(data.currentBid);
                    document.getElementById("currentBid").innerHTML = "LKR " + new Intl.NumberFormat("en-US", {
                        minimumFractionDigits: 2,
                    }).format(currentBid);
                    document.getElementById("currentUser").innerHTML = data.user ? data.user.username : "";
                    document.getElementById("startedAt").innerHTML = data.startTime;
                    document.getElementById("status").innerHTML = data.completed ? "Auction Ended" : "On Going";
                    document.getElementById("bid").min = currentBid;
                } else {
                    window.location.href = "home.jsp";
                }
            } else {
                alert("Something went wrong");
            }

            const webSocket = new WebSocket(`ws://localhost:8080/flash-bid/ws/auction`);

            webSocket.onopen = () => {
                console.log("Auction opened");
            };

            webSocket.onmessage = (e) => {
                console.log("text" + e.data);

                const message = JSON.parse(e.data);

                if (auctionItemId === message.id) {
                    currentBid = parseFloat(message.currentBid);

                    document.getElementById("currentBid").innerHTML = "LKR " + new Intl.NumberFormat("en-US", {
                        minimumFractionDigits: 2,
                    }).format(currentBid);
                    document.getElementById("bid").min = currentBid;
                } else {
                    alert("error : " + message.id);
                }
            };

            webSocket.onclose = () => {
                console.log("Auction closed");
            };

            webSocket.onerror = (e) => {
                console.log("Auction error", e);
            };

            document.getElementById("bidBtn").addEventListener("click", async () => {
                const bidInput = document.getElementById("bid");
                const messageElement = document.getElementById("messages");
                const bidAmount = parseFloat(bidInput.value);

                if (bidAmount > currentBid) {
                    const response = await axios.post("place-bid", {
                        id: auctionItemId,
                        bid: bidAmount,
                    }, {
                        headers: {
                            "Content-Type": "application/json"
                        }
                    });

                    // console.log(response);

                    if (response.status === 200) {
                        const data = response.data;

                        if (data.success) {
                            messageElement.style.color = "green";
                            messageElement.innerHTML = "Your bid of LKR " + new Intl.NumberFormat("en-US", {
                                minimumFractionDigits: 2,
                            }).format(bidAmount) + " has been placed successfully!";
                        } else {
                            messageElement.style.color = "red";
                            messageElement.textContent = data.message || "Bid placing failed.";
                        }
                        bidInput.value = "";
                    } else {
                        alert("Something went wrong");
                    }
                } else {
                    alert("Your bid value need to be grater than current bit.");
                }
            });
        } else {
            window.location.href = "home.jsp";
        }
    }
</script>
</body>
</html>
