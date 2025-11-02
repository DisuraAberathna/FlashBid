<%--
  Created by IntelliJ IDEA.
  User: User
  Date: 5/29/2025
  Time: 5:25 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>FlashBid | Admin Panel</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <script src="https://cdn.jsdelivr.net/npm/axios/dist/axios.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@tailwindcss/browser@4"></script>
</head>
<body class="flex flex-col w-full items-center bg-gradient-to-br from-slate-900 via-slate-800 to-slate-900 gap-y-5 min-h-screen">
<!-- Navigation Header -->
<nav class="bg-slate-800 border-b-2 border-purple-700/30 sticky top-0 z-50 w-full max-w-7xl px-8 py-4 shadow-md">
    <div class="mx-auto flex items-center justify-between">
        <div class="flex items-center gap-3">
            <a href="home.jsp"
               class="text-2xl font-black bg-gradient-to-r from-blue-500 to-purple-500 bg-clip-text text-transparent">FlashBid</a>
            <span class="px-3 py-1 bg-purple-900/30 border border-purple-700/50 rounded-full text-purple-400 text-xs font-semibold">
                🔐 Admin
            </span>
        </div>
        <div class="flex items-center gap-4">
            <div class="flex items-center gap-2 text-green-400">
                <div class="w-2 h-2 bg-green-500 rounded-full shadow-[0_0_8px_rgba(16,185,129,0.6)] animate-pulse"></div>
                <span class="text-sm font-medium hidden sm:inline">Live</span>
            </div>
            <a href="home.jsp"
               class="bg-gradient-to-r from-indigo-600 to-purple-600 text-white font-semibold py-2 px-4 text-sm rounded-lg cursor-pointer transition-all duration-300 hover:-translate-y-0.5 hover:shadow-[0_6px_20px_rgba(102,126,234,0.4)] shadow-[0_4px_15px_rgba(102,126,234,0.3)]">Back
                to Site</a>
        </div>
    </div>
</nav>

<div class="max-w-7xl py-5 px-4 w-full">
    <div class="mx-auto flex flex-col gap-y-5">
        <!-- Page Header -->
        <div class="mb-8">
            <h1 class="text-4xl lg:text-5xl font-black bg-gradient-to-r from-blue-500 to-purple-500 bg-clip-text text-transparent mb-2">
                Admin Control Panel</h1>
            <p class="text-gray-400">Manage auctions and monitor activity</p>
        </div>

        <!-- Add Auction Item Form -->
        <div class="bg-slate-800 rounded-2xl p-6 shadow-[0_10px_30px_rgba(0,0,0,0.3)] border border-purple-700/30 flex flex-col gap-y-5">
            <div>
                <h3 class="text-2xl font-bold text-white mb-1">Create New Auction</h3>
                <p class="text-gray-400 text-sm">Add a new item to the auction platform</p>
            </div>
            <form onsubmit="handleSubmit(event)" class="flex flex-col gap-y-5">
                <div class="grid grid-cols-1 md:grid-cols-2 gap-4">
                    <div class="flex flex-col gap-y-2">
                        <label for="title" class="text-gray-300 font-semibold text-sm">Auction Title</label>
                        <input type="text"
                               id="title"
                               placeholder="Enter auction item title"
                               class="bg-slate-700 border-2 border-transparent text-white py-3 px-4 rounded-lg transition-all duration-300 outline-none hover:border-purple-500/50 focus:border-blue-500 focus:shadow-[0_0_0_3px_rgba(59,130,246,0.1)] focus:bg-slate-600 placeholder:text-slate-400"
                               required/>
                    </div>
                    <div class="flex flex-col gap-y-2">
                        <label for="bid" class="text-gray-300 font-semibold text-sm">Starting Bid (LKR)</label>
                        <input type="number"
                               id="bid"
                               placeholder="Enter starting bid amount"
                               min="0.01"
                               step="0.01"
                               class="bg-slate-700 border-2 border-transparent text-white py-3 px-4 rounded-lg transition-all duration-300 outline-none hover:border-purple-500/50 focus:border-blue-500 focus:shadow-[0_0_0_3px_rgba(59,130,246,0.1)] focus:bg-slate-600 placeholder:text-slate-400"
                               required/>
                    </div>
                </div>
                <div class="pt-2">
                    <button type="submit"
                            class="bg-gradient-to-r from-green-600 to-emerald-500 text-white font-semibold py-2.5 px-8 rounded-lg cursor-pointer transition-all duration-300 hover:-translate-y-0.5 hover:shadow-[0_6px_20px_rgba(16,185,129,0.4)] shadow-[0_4px_15px_rgba(16,185,129,0.3)] active:translate-y-0">
                        ➕ Create Auction
                    </button>
                </div>
            </form>
        </div>

        <!-- Auctions List Section -->
        <div class=" flex flex-col gap-y-5">
            <div class="flex items-center justify-between py-3">
                <h3 class="text-3xl font-bold text-white">Active Auctions</h3>
                <button onclick="loadAuctionItems()"
                        class="bg-gradient-to-r from-indigo-600 to-purple-600 text-white font-semibold py-2 px-4 text-sm rounded-lg cursor-pointer transition-all duration-300 hover:-translate-y-0.5 hover:shadow-[0_6px_20px_rgba(102,126,234,0.4)] shadow-[0_4px_15px_rgba(102,126,234,0.3)]">
                    🔄 Refresh
                </button>
            </div>

            <!-- Loading State -->
            <div id="loadingState"
                 class="text-center py-12 bg-slate-800 rounded-2xl p-6 shadow-[0_10px_30px_rgba(0,0,0,0.3)] border border-white/5">
                <div class="inline-block animate-spin rounded-full h-12 w-12 border-b-2 border-blue-500"></div>
                <p class="mt-4 text-gray-300">Loading auctions...</p>
            </div>

            <!-- Empty State -->
            <div id="emptyState"
                 class="bg-slate-800 rounded-2xl p-6 shadow-[0_10px_30px_rgba(0,0,0,0.3)] border border-white/5 text-center py-12 hidden">
                <div class="text-5xl mb-4">📭</div>
                <h3 class="text-xl font-bold mb-2 text-white">No Auctions Found</h3>
                <p class="text-gray-300">Create your first auction to get started!</p>
            </div>

            <!-- Auctions Grid -->
            <div id="items" class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6 mb-10"></div>

            <!-- Template Item (hidden by default) -->
            <div id="item"
                 class="bg-slate-800 rounded-2xl p-6 shadow-[0_10px_30px_rgba(0,0,0,0.3)] border border-white/5 transition-all duration-300 hover:-translate-y-1 hover:shadow-[0_20px_40px_rgba(0,0,0,0.4)] hover:border-blue-500/30 hidden flex flex-col gap-y-4"
                 data-auction-id="">
                <div class="flex items-start justify-between mb-4">
                    <h4 id="itemTitle" class="text-xl font-bold text-white flex-1">Auction Item</h4>
                    <div id="statusBadge"
                         class="inline-flex items-center gap-2 px-3 py-1.5 rounded-full text-sm font-semibold bg-green-500/20 text-green-500 border border-green-500/30">
                        <div id="statusView"
                             class="w-2 h-2 bg-green-500 rounded-full shadow-[0_0_8px_rgba(16,185,129,0.6)] animate-pulse"></div>
                        <label id="status" class="font-semibold">On Going</label>
                    </div>
                </div>

                <div class="flex flex-col gap-y-4 mb-3">
                    <div class="flex justify-between items-center">
                        <label class="text-gray-400 font-medium text-sm">Starting Bid</label>
                        <label id="startBid"
                               class="font-bold bg-gradient-to-r from-green-500 to-blue-500 bg-clip-text text-transparent">LKR
                            100</label>
                    </div>
                    <div class="flex justify-between items-center">
                        <label class="text-gray-400 font-medium text-sm">Current Bid</label>
                        <label id="currentBid"
                               class="font-bold bg-gradient-to-r from-green-500 to-blue-500 bg-clip-text text-transparent text-green-400">LKR
                            100</label>
                    </div>
                    <div class="flex justify-between items-center text-sm">
                        <label class="text-gray-400 font-medium">Current Bidder</label>
                        <label id="currentUser" class="text-gray-300 font-semibold">No bids</label>
                    </div>
                    <div class="flex justify-between items-center text-sm">
                        <label class="text-gray-400 font-medium">Started At</label>
                        <label id="startedAt" class="text-gray-300 font-semibold">2025/05/29</label>
                    </div>
                    <div class="flex justify-between items-center text-sm">
                        <label class="text-gray-400 font-medium">Ended At</label>
                        <label id="endAt" class="text-gray-300 font-semibold">Not yet</label>
                    </div>
                </div>

                <div class="flex flex-col gap-y-4 pt-4 border-t border-slate-700">
                    <div class="text-xs text-gray-500 font-mono">
                        ID: <span id="itemId">#0000</span>
                    </div>
                    <button id="endAuctionBtn"
                            class="bg-gradient-to-r from-red-600 to-red-500 text-white font-semibold py-2 px-5 text-sm rounded-lg cursor-pointer transition-all duration-300 hover:-translate-y-0.5 hover:shadow-[0_6px_20px_rgba(235,51,73,0.4)] shadow-[0_4px_15px_rgba(235,51,73,0.3)] active:translate-y-0">
                        End Auction
                    </button>
                </div>
            </div>
        </div>
    </div>
</div>

<script>
    const handleSubmit = async (e) => {
        e.preventDefault();

        const title = document.getElementById("title");
        const startBid = document.getElementById("bid");
        const submitButton = e.target.querySelector('button[type="submit"]');
        const originalText = submitButton.innerHTML;

        if (!title.value.trim() || !startBid.value || parseFloat(startBid.value) <= 0) {
            alert("Please fill in all fields with valid values.");
            return;
        }

        // Show loading state
        submitButton.disabled = true;
        submitButton.innerHTML = "Creating...";

        try {
            const response = await axios.post("add-auction-item", {
                title: title.value.trim(),
                startBid: parseFloat(startBid.value),
            }, {
                headers: {
                    "Content-Type": "application/json"
                }
            });

            if (response.status === 200) {
                const data = response.data;

                if (data.success) {
                    submitButton.innerHTML = "✓ Created!";
                    submitButton.classList.add("bg-green-500");
                    title.value = "";
                    startBid.value = "";

                    setTimeout(() => {
                        submitButton.disabled = false;
                        submitButton.innerHTML = originalText;
                        submitButton.classList.remove("bg-green-500");
                    }, 2000);

                    loadAuctionItems();
                } else {
                    submitButton.disabled = false;
                    submitButton.innerHTML = originalText;
                    alert(data.message || "Failed to create auction.");
                }
            } else {
                submitButton.disabled = false;
                submitButton.innerHTML = originalText;
                alert("Something went wrong. Please try again.");
            }
        } catch (error) {
            console.error("Error creating auction:", error);
            submitButton.disabled = false;
            submitButton.innerHTML = originalText;
            alert("An error occurred. Please try again.");
        }
    }

    const endAuction = async (id) => {
        if (!confirm("Are you sure you want to end this auction? This action cannot be undone.")) {
            return;
        }

        try {
            const response = await axios.post("end-auction", {
                id: id,
            }, {
                headers: {
                    "Content-Type": "application/json",
                }
            });

            if (response.status === 200) {
                const data = response.data;
                if (data.success) {
                    alert("✓ Auction ended successfully!");
                    loadAuctionItems();
                } else {
                    alert(data.message || "Failed to end auction.");
                }
            } else {
                alert("Something went wrong. Please try again.");
            }
        } catch (error) {
            console.error("Error ending auction:", error);
            alert("An error occurred. Please try again.");
        }
    }

    document.addEventListener("DOMContentLoaded", () => {
        loadAuctionItems();
        initializeWebSocket();
    });

    const loadAuctionItems = async () => {
        const loadingState = document.getElementById("loadingState");
        const emptyState = document.getElementById("emptyState");

        loadingState.style.display = "block";

        try {
            const response = await axios.post("get-auction-items");

            if (response.status === 200) {
                const data = response.data;
                const auctionItemView = document.getElementById("item");
                const items = document.getElementById("items");

                loadingState.style.display = "none";

                if (data.success && data.items && data.items.length > 0) {
                    emptyState.classList.add("hidden");
                    items.innerHTML = "";

                    data.items.forEach(auctionItem => {
                        let auctionItemClone = auctionItemView.cloneNode(true);
                        auctionItemClone.dataset.auctionId = auctionItem.id;
                        auctionItemClone.classList.remove("hidden");

                        // Title
                        auctionItemClone.querySelector("#itemTitle").innerHTML = auctionItem.title;

                        // Starting Bid
                        const formattedStartBid = new Intl.NumberFormat("en-US", {
                            minimumFractionDigits: 2,
                            maximumFractionDigits: 2
                        }).format(auctionItem.startBid);
                        auctionItemClone.querySelector("#startBid").innerHTML = "LKR " + formattedStartBid;

                        // Current Bid
                        const formattedCurrentBid = new Intl.NumberFormat("en-US", {
                            minimumFractionDigits: 2,
                            maximumFractionDigits: 2
                        }).format(auctionItem.currentBid);
                        auctionItemClone.querySelector("#currentBid").innerHTML = "LKR " + formattedCurrentBid;

                        // Current User
                        auctionItemClone.querySelector("#currentUser").innerHTML = auctionItem.user ? auctionItem.user.username : "No bids";

                        // Times
                        auctionItemClone.querySelector("#startedAt").innerHTML = auctionItem.startTime || "N/A";
                        auctionItemClone.querySelector("#endAt").innerHTML = auctionItem.endTime || "Not yet";

                        // Item ID
                        auctionItemClone.querySelector("#itemId").innerHTML = "#" + auctionItem.id;

                        // Status
                        const isCompleted = auctionItem.completed;
                        auctionItemClone.querySelector("#status").innerHTML = isCompleted ? "Auction Ended" : "On Going";

                        // Status Badge
                        const statusBadge = auctionItemClone.querySelector("#statusBadge");
                        const statusView = auctionItemClone.querySelector("#statusView");

                        if (isCompleted) {
                            statusBadge.className = "inline-flex items-center gap-2 px-3 py-1.5 rounded-full text-sm font-semibold bg-red-500/20 text-red-400 border border-red-500/30";
                            statusView.className = "w-2 h-2 bg-red-400 rounded-full";
                        } else {
                            statusBadge.className = "inline-flex items-center gap-2 px-3 py-1.5 rounded-full text-sm font-semibold bg-green-500/20 text-green-500 border border-green-500/30";
                            statusView.className = "w-2 h-2 bg-green-500 rounded-full shadow-[0_0_8px_rgba(16,185,129,0.6)] animate-pulse";
                        }

                        // End Button
                        const endBtn = auctionItemClone.querySelector("#endAuctionBtn");
                        if (isCompleted) {
                            endBtn.innerHTML = "Auction Complete";
                            endBtn.disabled = true;
                            endBtn.className = "bg-gray-600 text-gray-400 font-semibold py-2 px-5 text-sm rounded-lg cursor-not-allowed opacity-50";
                        } else {
                            endBtn.innerHTML = "End Auction";
                            endBtn.disabled = false;
                            endBtn.className = "bg-gradient-to-r from-red-600 to-red-500 text-white font-semibold py-2 px-5 text-sm rounded-lg cursor-pointer transition-all duration-300 hover:-translate-y-0.5 hover:shadow-[0_6px_20px_rgba(235,51,73,0.4)] shadow-[0_4px_15px_rgba(235,51,73,0.3)] active:translate-y-0";
                            endBtn.addEventListener("click", (e) => {
                                e.preventDefault();
                                endAuction(auctionItem.id);
                            });
                        }

                        items.appendChild(auctionItemClone);
                    });
                } else {
                    emptyState.classList.remove("hidden");
                }
            }
        } catch (error) {
            console.error("Error loading auctions:", error);
            loadingState.innerHTML = '<p class="text-red-400">Error loading auctions. Please refresh.</p>';
        }
    }

    const initializeWebSocket = () => {
        const webSocket = new WebSocket(`ws://localhost:8080/flash-bid/ws/auction`);

        webSocket.onopen = () => {
            console.log("Admin WebSocket opened");
        };

        webSocket.onmessage = (e) => {
            try {
                const message = JSON.parse(e.data);

                const auctionElement = document.querySelector('[data-auction-id="' + message.id + '"]');
                if (auctionElement) {
                    const formattedBid = new Intl.NumberFormat("en-US", {
                        minimumFractionDigits: 2,
                        maximumFractionDigits: 2
                    }).format(message.currentBid);

                    auctionElement.querySelector("#currentBid").innerHTML = "LKR " + formattedBid;
                    auctionElement.querySelector("#currentUser").innerHTML = message.user || "No bids";

                    // Highlight update
                    auctionElement.classList.add("bg-gradient-to-br", "from-blue-500/20", "to-purple-500/20", "border-blue-500/50", "shadow-[0_0_20px_rgba(59,130,246,0.3)]");
                    setTimeout(() => {
                        auctionElement.classList.remove("bg-gradient-to-br", "from-blue-500/20", "to-purple-500/20", "border-blue-500/50", "shadow-[0_0_20px_rgba(59,130,246,0.3)]");
                    }, 1500);
                }
            } catch (error) {
                console.error("Error parsing WebSocket message:", error);
            }
        };

        webSocket.onclose = () => {
            console.log("Admin WebSocket closed");
        };

        webSocket.onerror = (e) => {
            console.error("Admin WebSocket error", e);
        };
    };
</script>
</body>
</html>
