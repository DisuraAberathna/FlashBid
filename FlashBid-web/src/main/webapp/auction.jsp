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
    <title>FlashBid | Active Auction</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <script src="https://cdn.jsdelivr.net/npm/axios/dist/axios.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@tailwindcss/browser@4"></script>
</head>
<body onload="loadAuctionItem()"
      class="flex flex-col w-full items-center bg-gradient-to-br from-slate-900 via-slate-800 to-slate-900 gap-y-8 min-h-screen">
<!-- Navigation Header -->
<nav class="max-w-7xl w-full bg-slate-800 border-b border-white/5 sticky top-0 z-50 px-8 py-4 shadow-md">
    <div class="mx-auto flex items-center justify-between">
        <a href="home.jsp"
           class="text-2xl font-black bg-gradient-to-r from-blue-500 to-purple-500 bg-clip-text text-transparent">← Back
            to Auctions</a>
        <div class="flex items-center gap-4">
            <div class="flex items-center gap-2 text-green-400">
                <div class="w-2 h-2 bg-green-500 rounded-full shadow-[0_0_8px_rgba(16,185,129,0.6)] animate-pulse"></div>
                <span class="text-sm font-medium hidden sm:inline">Live</span>
            </div>
        </div>
    </div>
</nav>

<div class="w-full max-w-4xl">
    <div class="mx-auto flex flex-col gap-y-4">
        <!-- Auction Card -->
        <div id="item"
             class="bg-slate-800 rounded-2xl p-6 shadow-[0_10px_30px_rgba(0,0,0,0.3)] border border-white/5 mb-6 flex flex-col gap-y-4">
            <!-- Header with Status -->
            <div class="mb-6 flex items-start justify-between">
                <h4 id="itemTitle" class="mb-2 text-3xl font-bold text-white">Auction Item</h4>
                <div class="flex items-center gap-3">
                    <div id="statusBadge"
                         class="inline-flex items-center gap-2 px-3 py-1.5 rounded-full text-sm font-semibold bg-green-500/20 text-green-500 border border-green-500/30">
                        <div id="statusView"
                             class="w-2 h-2 bg-green-500 rounded-full shadow-[0_0_8px_rgba(16,185,129,0.6)] animate-pulse"></div>
                        <label id="status" class="font-semibold">On Going</label>
                    </div>
                </div>
            </div>

            <!-- Key Metrics Grid -->
            <div class="mb-6 grid grid-cols-1 gap-4 md:grid-cols-2">
                <div class="rounded-lg border border-slate-700 bg-gradient-to-br from-slate-800 to-slate-900 p-4 shadow-[0_0_20px_rgba(16,185,129,0.3)]">
                    <label class="mb-1 block text-sm font-medium text-gray-400">Starting Bid</label>
                    <label id="startBid"
                           class="font-bold block text-2xl bg-gradient-to-r from-green-500 to-blue-500 bg-clip-text text-transparent">LKR
                        100</label>
                </div>
                <div class="rounded-lg border border-green-700/30 bg-gradient-to-br from-green-900/30 to-green-800/20 p-4 shadow-[0_0_20px_rgba(16,185,129,0.3)]">
                    <label class="mb-1 block text-sm font-medium text-green-400">Current Bid</label>
                    <label id="currentBid"
                           class="font-bold block text-3xl text-green-400 bg-gradient-to-r from-green-500 to-blue-500 bg-clip-text text-transparent">LKR
                        100</label>
                </div>
            </div>

            <!-- Additional Info -->
            <div class="mb-3 flex flex-col gap-y-4">
                <div class="flex items-center justify-between">
                    <label class="font-medium text-gray-400">Current Bidder</label>
                    <label id="currentUser" class="font-semibold text-white">No bids yet</label>
                </div>
                <div class="flex items-center justify-between">
                    <label class="font-medium text-gray-400">Started At</label>
                    <label id="startedAt" class="font-semibold text-gray-300">2025/05/29</label>
                </div>
            </div>

            <!-- Bid Section -->
            <div class="border-t border-slate-700 pt-4">
                <div class="mb-4 flex flex-col gap-y-4">
                    <label for="bid" class="mb-2 block font-semibold text-gray-300"> Place Your Bid </label>
                    <div class="flex items-center justify-center gap-3">
                        <div class="flex w-4/6 items-center">
                            <span class="flex-1 pe-8 font-semibold text-gray-400 ps-4">LKR</span>
                            <input type="number" id="bid" name="bid" min="1" step="0.01" placeholder="Enter bid amount"
                                   class="bg-slate-700 border-2 border-transparent text-white w-full flex-2/3 py-3 pl-4 text-lg font-semibold rounded-lg transition-all duration-300 outline-none hover:border-purple-500/50 focus:border-blue-500 focus:shadow-[0_0_0_3px_rgba(59,130,246,0.1)] focus:bg-slate-600 placeholder:text-slate-400"/>
                        </div>
                        <button id="bidBtn"
                                class="bg-gradient-to-r from-green-600 to-emerald-500 text-white font-semibold w-2/6 px-8 py-3 text-lg rounded-lg cursor-pointer transition-all duration-300 hover:-translate-y-0.5 hover:shadow-[0_6px_20px_rgba(16,185,129,0.4)] shadow-[0_4px_15px_rgba(16,185,129,0.3)] active:translate-y-0 whitespace-nowrap">
                            🚀 Place Bid
                        </button>
                    </div>
                    <p class="mt-2 text-xs text-gray-500">Minimum bid: <span id="minBid"
                                                                             class="font-semibold text-gray-400">LKR 0.00</span>
                    </p>
                </div>

                <!-- Messages -->
                <div id="messageContainer" class="mt-4">
                    <p id="messages" class="text-sm font-semibold"></p>
                </div>
            </div>
        </div>

        <!-- Live Updates Banner -->
        <div class="bg-slate-800 rounded-2xl p-6 shadow-[0_10px_30px_rgba(0,0,0,0.3)] border border-blue-700/30 bg-gradient-to-r from-blue-900/30 to-purple-900/30">
            <div class="flex items-center gap-3">
                <div class="w-2 h-2 bg-green-500 rounded-full shadow-[0_0_8px_rgba(16,185,129,0.6)] animate-pulse"></div>
                <div>
                    <p class="text-sm font-semibold text-white">Live Updates Active</p>
                    <p class="text-xs text-gray-400">You'll receive real-time notifications when new bids are placed</p>
                </div>
            </div>
        </div>
    </div>
</div>

<script>
    let currentBid = 0;
    let auctionItemId = null;
    let webSocket = null;

    const loadAuctionItem = async () => {
        const parameters = new URLSearchParams(window.location.search);

        if (!parameters.has("id")) {
            window.location.href = "home.jsp";
            return;
        }

        auctionItemId = parameters.get("id");

        try {
            const response = await axios.post("get-auction-item", {
                id: auctionItemId,
            }, {
                headers: {
                    "Content-Type": "application/json"
                }
            });

            if (response.status === 200) {
                const data = response.data;

                if (data) {
                    document.getElementById("itemTitle").innerText = data.title;

                    const formattedStartBid = new Intl.NumberFormat("en-US", {
                        minimumFractionDigits: 2,
                        maximumFractionDigits: 2
                    }).format(data.startBid);
                    document.getElementById("startBid").innerText = "LKR " + formattedStartBid;

                    currentBid = parseFloat(data.currentBid);
                    const formattedCurrentBid = new Intl.NumberFormat("en-US", {
                        minimumFractionDigits: 2,
                        maximumFractionDigits: 2
                    }).format(currentBid);
                    document.getElementById("currentBid").innerHTML = "LKR " + formattedCurrentBid;
                    document.getElementById("minBid").innerText = "LKR " + formattedCurrentBid;

                    document.getElementById("currentUser").innerHTML = data.user ? data.user.username : "No bids yet";
                    document.getElementById("startedAt").innerHTML = data.startTime || "N/A";

                    const isCompleted = data.completed;
                    document.getElementById("status").innerHTML = isCompleted ? "Auction Ended" : "On Going";

                    const statusBadge = document.getElementById("statusBadge");
                    const statusView = document.getElementById("statusView");
                    const bidBtn = document.getElementById("bidBtn");
                    const bidInput = document.getElementById("bid");

                    if (isCompleted) {
                        statusBadge.className = "inline-flex items-center gap-2 px-3 py-1.5 rounded-full text-sm font-semibold bg-red-500/20 text-red-400 border border-red-500/30";
                        statusView.className = "w-2 h-2 bg-red-400 rounded-full";
                        bidBtn.disabled = true;
                        bidBtn.innerHTML = "Auction Ended";
                        bidBtn.className = "bg-gray-600 text-gray-400 font-semibold w-2/6 px-8 py-3 text-lg rounded-lg cursor-not-allowed opacity-50 whitespace-nowrap";
                        bidInput.disabled = true;
                    } else {
                        statusBadge.className = "inline-flex items-center gap-2 px-3 py-1.5 rounded-full text-sm font-semibold bg-green-500/20 text-green-500 border border-green-500/30";
                        statusView.className = "w-2 h-2 bg-green-500 rounded-full shadow-[0_0_8px_rgba(16,185,129,0.6)] animate-pulse";
                        document.getElementById("bid").min = currentBid;
                        initializeWebSocket();
                    }
                } else {
                    window.location.href = "home.jsp";
                }
            } else {
                alert("Something went wrong");
            }
        } catch (error) {
            console.error("Error loading auction:", error);
            alert("Failed to load auction. Please try again.");
        }
    };

    const initializeWebSocket = () => {
        webSocket = new WebSocket(`ws://localhost:8080/flash-bid/ws/auction`);

        webSocket.onopen = () => {
            console.log("Auction WebSocket opened");
        };

        webSocket.onmessage = (e) => {
            try {
                const message = JSON.parse(e.data);

                if (auctionItemId === message.id) {
                    currentBid = parseFloat(message.currentBid);
                    const formattedBid = new Intl.NumberFormat("en-US", {
                        minimumFractionDigits: 2,
                        maximumFractionDigits: 2
                    }).format(currentBid);

                    document.getElementById("currentBid").innerHTML = "LKR " + formattedBid;
                    document.getElementById("minBid").innerText = "LKR " + formattedBid;
                    document.getElementById("bid").min = currentBid;
                    document.getElementById("currentUser").innerHTML = message.user || "No bids yet";

                    // Highlight the current bid display
                    const currentBidElement = document.getElementById("currentBid").parentElement;
                    currentBidElement.classList.add("bg-gradient-to-br", "from-blue-500/20", "to-purple-500/20", "border-blue-500/50", "shadow-[0_0_20px_rgba(59,130,246,0.3)]");
                    setTimeout(() => {
                        currentBidElement.classList.remove("bg-gradient-to-br", "from-blue-500/20", "to-purple-500/20", "border-blue-500/50", "shadow-[0_0_20px_rgba(59,130,246,0.3)]");
                    }, 1500);
                }
            } catch (error) {
                console.error("Error parsing WebSocket message:", error);
            }
        };

        webSocket.onclose = () => {
            console.log("Auction WebSocket closed");
        };

        webSocket.onerror = (e) => {
            console.error("Auction WebSocket error", e);
        };
    };

    document.getElementById("bidBtn").addEventListener("click", async () => {
        const bidInput = document.getElementById("bid");
        const messageElement = document.getElementById("messages");
        const messageContainer = document.getElementById("messageContainer");
        const bidAmount = parseFloat(bidInput.value);

        if (!bidAmount || isNaN(bidAmount)) {
            messageElement.classList.remove("text-green-400");
            messageElement.classList.add("text-red-400");
            messageElement.innerHTML = "⚠️ Please enter a valid bid amount";
            return;
        }

        if (bidAmount <= currentBid) {
            messageElement.classList.remove("text-green-400");
            messageElement.classList.add("text-red-400");
            messageElement.innerHTML = "⚠️ Your bid must be greater than the current bid of LKR " +
                new Intl.NumberFormat("en-US", {minimumFractionDigits: 2}).format(currentBid);
            return;
        }

        try {
            const response = await axios.post("place-bid", {
                id: auctionItemId,
                bid: bidAmount,
            }, {
                headers: {
                    "Content-Type": "application/json"
                }
            });

            if (response.status === 200) {
                const data = response.data;

                if (data.success) {
                    messageElement.classList.remove("text-red-400");
                    messageElement.classList.add("text-green-400");
                    messageElement.innerHTML = "✅ Your bid of LKR " +
                        new Intl.NumberFormat("en-US", {
                            minimumFractionDigits: 2,
                            maximumFractionDigits: 2
                        }).format(bidAmount) +
                        " has been placed successfully!";
                    bidInput.value = "";

                    // Update current bid immediately
                    currentBid = bidAmount;
                    document.getElementById("bid").min = currentBid;
                } else {
                    messageElement.classList.remove("text-green-400");
                    messageElement.classList.add("text-red-400");
                    messageElement.textContent = data.message || "❌ Bid placing failed. Please try again.";
                }
            } else {
                messageElement.classList.remove("text-green-400");
                messageElement.classList.add("text-red-400");
                messageElement.textContent = "❌ Something went wrong. Please try again.";
            }
        } catch (error) {
            console.error("Error placing bid:", error);
            messageElement.classList.remove("text-green-400");
            messageElement.classList.add("text-red-400");
            messageElement.textContent = "❌ Error placing bid. Please try again.";
        }
    });

    // Allow Enter key to place bid
    document.getElementById("bid").addEventListener("keypress", (e) => {
        if (e.key === "Enter") {
            document.getElementById("bidBtn").click();
        }
    });
</script>
</body>
</html>
