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
    <title>FlashBid | Live Auctions</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <script src="https://cdn.jsdelivr.net/npm/axios/dist/axios.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@tailwindcss/browser@4"></script>
</head>
<body onload="loadAuctionItems()" class="flex flex-col w-full items-center bg-gradient-to-br from-slate-900 via-slate-800 to-slate-900 gap-y-5">
<!-- Navigation Header -->
<nav class="bg-slate-800 border-b border-white/5 sticky top-0 z-50 w-full max-w-7xl px-8 py-4 shadow-md">
    <div class="mx-auto flex items-center justify-between">
        <a href="index.jsp" class="text-2xl font-black bg-gradient-to-r from-blue-500 to-purple-500 bg-clip-text text-transparent">FlashBid</a>
        <div class="flex items-center gap-4">
            <div class="flex items-center gap-2 text-green-400">
                <div class="w-2 h-2 bg-green-500 rounded-full shadow-[0_0_8px_rgba(16,185,129,0.6)] animate-pulse"></div>
                <span class="text-sm font-medium hidden sm:inline">Live</span>
            </div>
            <a href="login.jsp" class="bg-gradient-to-r from-indigo-600 to-purple-600 text-white font-semibold py-2 px-4 text-sm rounded-lg cursor-pointer transition-all duration-300 hover:-translate-y-0.5 hover:shadow-[0_6px_20px_rgba(102,126,234,0.4)] shadow-[0_4px_15px_rgba(102,126,234,0.3)]">Log Out</a>
        </div>
    </div>
</nav>

<div class="py-5 px-4 w-full max-w-7xl">
    <div class="mx-auto flex flex-col gap-y-5">
        <!-- Page Header -->
        <div class="mb-8">
            <h1 class="text-4xl lg:text-5xl font-black bg-gradient-to-r from-blue-500 to-purple-500 bg-clip-text text-transparent mb-2">Live Auctions</h1>
            <p class="text-gray-400">Real-time bidding opportunities • Join the action now</p>
        </div>

        <!-- Auction Items Grid -->
        <div id="items" class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6 justify-center">
            <!-- Template Item (hidden by default) -->
            <div id="item"
                 class="bg-slate-800 rounded-2xl p-6 shadow-[0_10px_30px_rgba(0,0,0,0.3)] border border-white/5 transition-all duration-300 hover:-translate-y-1 hover:shadow-[0_20px_40px_rgba(0,0,0,0.4)] hover:border-blue-500/30 hidden w-full max-w-sm flex flex-col gap-y-4">
                <div class="flex items-start justify-between mb-4">
                    <h4 id="itemTitle" class="text-xl font-bold text-white flex-1">Auction Item</h4>
                    <div id="statusBadge" class="inline-flex items-center gap-2 px-3 py-1.5 rounded-full text-sm font-semibold bg-green-500/20 text-green-500 border border-green-500/30">
                        <div id="statusView" class="w-2 h-2 bg-green-500 rounded-full shadow-[0_0_8px_rgba(16,185,129,0.6)] animate-pulse"></div>
                        <label id="status" class="font-semibold">On Going</label>
                    </div>
                </div>

                <div class="flex flex-col gap-y-4 mb-6">
                    <div class="flex justify-between items-center">
                        <label class="text-gray-400 font-medium text-sm">Current Bid</label>
                        <label id="currentBid" class="font-bold text-xl bg-gradient-to-r from-green-500 to-blue-500 bg-clip-text text-transparent">LKR 100</label>
                    </div>
                    <div class="flex justify-between items-center text-sm">
                        <label class="text-gray-400 font-medium">Started At</label>
                        <label id="startedAt" class="text-gray-300 font-semibold">2025/05/29</label>
                    </div>
                </div>

                <div class="flex flex-col gap-y-4 pt-4 border-t border-slate-700">
                    <div class="text-xs text-gray-500">
                        <span class="font-semibold">Auction ID:</span> <span id="itemId" class="font-mono">#0000</span>
                    </div>
                    <button id="joinAuctionBtn"
                            class="bg-gradient-to-r from-green-600 to-emerald-500 text-white font-semibold py-2 px-6 text-sm rounded-lg cursor-pointer transition-all duration-300 hover:-translate-y-0.5 hover:shadow-[0_6px_20px_rgba(16,185,129,0.4)] shadow-[0_4px_15px_rgba(16,185,129,0.3)] active:translate-y-0">
                        Join Auction →
                    </button>
                </div>
            </div>

            <!-- Loading State -->
            <div id="loadingState" class="col-span-full flex justify-center py-12">
                <div class="text-center">
                    <div class="inline-block animate-spin rounded-full h-12 w-12 border-b-2 border-blue-500"></div>
                    <p class="mt-4 text-gray-300">Loading auctions...</p>
                </div>
            </div>

            <!-- Empty State -->
            <div id="emptyState" class="col-span-full flex w-full justify-center hidden">
                <div class="bg-slate-800 rounded-2xl p-6 shadow-[0_10px_30px_rgba(0,0,0,0.3)] border border-white/5 text-center py-12 w-full">
                    <div class="text-5xl mb-4">📭</div>
                    <h3 class="text-xl font-bold mb-2 text-white">No Active Auctions</h3>
                    <p class="text-gray-300">Check back soon for new bidding opportunities!</p>
                </div>
            </div>
        </div>
    </div>
</div>

<script>
    const joinAuction = (id) => {
        window.location.href = "auction.jsp?id=" + id;
    }

    const loadAuctionItems = async () => {
        const loadingState = document.getElementById("loadingState");
        const emptyState = document.getElementById("emptyState");

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
                        auctionItemClone.classList.remove("hidden");

                        // Title
                        auctionItemClone.querySelector("#itemTitle").innerHTML = auctionItem.title;

                        // Current Bid
                        const formattedBid = new Intl.NumberFormat("en-US", {
                            minimumFractionDigits: 2,
                            maximumFractionDigits: 2
                        }).format(auctionItem.currentBid);
                        auctionItemClone.querySelector("#currentBid").innerHTML = "LKR " + formattedBid;

                        // Start Time
                        auctionItemClone.querySelector("#startedAt").innerHTML = auctionItem.startTime || "N/A";

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

                        // Join Button
                        const joinBtn = auctionItemClone.querySelector("#joinAuctionBtn");
                        if (!isCompleted) {
                            joinBtn.innerHTML = "Join Auction →";
                            joinBtn.classList.remove("opacity-50", "cursor-not-allowed");
                            joinBtn.addEventListener("click", (e) => {
                                e.preventDefault();
                                joinAuction(auctionItem.id);
                            });
                        } else {
                            joinBtn.innerHTML = "Auction Ended";
                            joinBtn.className = "bg-gray-600 text-gray-400 font-semibold py-2 px-6 text-sm rounded-lg cursor-not-allowed opacity-50";
                            joinBtn.disabled = true;
                        }

                        items.appendChild(auctionItemClone);
                    });
                } else {
                    emptyState.classList.remove("hidden");
                }
            } else {
                loadingState.innerHTML = '<p class="text-red-400">Failed to load auctions. Please try again.</p>';
            }
        } catch (error) {
            console.error("Error loading auctions:", error);
            loadingState.innerHTML = '<p class="text-red-400">Error loading auctions. Please refresh the page.</p>';
        }
    }

    // Refresh auctions every 30 seconds
    setInterval(loadAuctionItems, 30000);
</script>
</body>
</html>
