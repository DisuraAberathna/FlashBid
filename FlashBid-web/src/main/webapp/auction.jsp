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
    <script src="https://cdn.jsdelivr.net/npm/@tailwindcss/browser@4"></script>
    <link href="css/styles.css" rel="stylesheet"/>
</head>
<body onload="loadAuctionItem()">
<div class="flex min-h-screen flex-col items-center justify-center bg-slate-100 py-10">
    <div id="item"
         class="flex w-full max-w-md min-w-3xs flex-col gap-y-3 rounded-2xl bg-white px-7 py-6 drop-shadow-xl">
        <h4 id="itemTitle" class="text-2xl font-semibold">Auction Item</h4>
        <div class="flex justify-between">
            <label class="font-medium">Starting Bid : </label>
            <label id="startBid" class="font-medium text-gray-700">LKR 100</label>
        </div>
        <div class="flex justify-between">
            <label class="font-medium">Current Bid : </label>
            <label id="currentBid" class="font-medium text-gray-700">LKR 100</label>
        </div>
        <div class="flex justify-between">
            <label class="font-medium">Current User : </label>
            <label id="currentUser" class="font-medium text-gray-700">user</label>
        </div>
        <div class="flex justify-between">
            <label class="font-medium">Start At : </label>
            <label id="startedAt" class="font-medium text-gray-700">2025/05/29</label>
        </div>
        <div class="flex justify-between">
            <label class="font-medium">Status : </label>
            <div class="flex items-center gap-x-2">
                <div id="statusView" class="h-2 w-2 rounded-full"></div>
                <label id="status" class="font-medium text-gray-700"> On Going</label>
            </div>
        </div>
        <div class="my-3 flex flex-col gap-y-1">
            <label for="bid" class="font-medium">Add Your Bid </label>
            <div class="flex items-center">
                <label class="font-medium">LKR &nbsp;</label>
                <input type="number" id="bid" name="bid" min="1" step="0.1"
                       class="flex-1 rounded-md border-2 border-gray-300 px-3 py-1 outline-none hover:border-[#16A34A] active:border-[#16A34A]"/>
            </div>
        </div>
        <div>
            <button id="bidBtn"
                    class="cursor-pointer rounded-md bg-[#16A34A] px-10 py-1.5 font-medium text-white hover:bg-[#28914e]">
                Place Bid
            </button>
        </div>
        <div>
            <p id="messages" class="text-sm font-bold"></p>
        </div>
    </div>
</div>
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
                    document.getElementById("statusView").classList.add(data.completed ? "bg-[#e41515]" : "bg-[#16A34A]");
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
                    document.getElementById("currentUser").innerHTML = message.user;
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
                            messageElement.classList.add("text-[#16A34A]");
                            messageElement.innerHTML = "Your bid of LKR " + new Intl.NumberFormat("en-US", {
                                minimumFractionDigits: 2,
                            }).format(bidAmount) + " has been placed successfully!";
                        } else {
                            messageElement.classList.add("text-[#e41515]");
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
