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
    <script src="https://cdn.jsdelivr.net/npm/@tailwindcss/browser@4"></script>
    <link href="css/styles.css" rel="stylesheet"/>
</head>
<body onload="loadAuctionItems()">
<div class="min-h-screen bg-slate-100 flex justify-center">
    <div class="w-7xl">
        <div class="px-3 py-5">
            <h3 class="font-bold text-3xl">Auction Items</h3>
        </div>
        <div id="items" class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-3 p-8">
            <div id="item"
                 class="flex w-full min-w-3xs max-w-sm flex-col gap-y-3 rounded-2xl bg-white px-7 py-6 drop-shadow-xl">
                <h4 id="itemTitle" class="text-xl font-semibold">Auction Item</h4>
                <div class="flex justify-between">
                    <label class="font-medium">Current Bid : </label>
                    <label id="currentBid" class="font-medium text-gray-700">LKR 100</label>
                </div>
                <div class="flex justify-between">
                    <label class="font-medium">Start At : </label>
                    <label id="startedAt" class="font-medium text-gray-700">2025/05/29</label>
                </div>
                <div class="mt-3 grid grid-cols-2 place-items-center">
                    <div class="flex items-center gap-x-2">
                        <div id="statusView" class="h-2 w-2 rounded-full"></div>
                        <label id="status" class="font-medium"> On Going</label>
                    </div>
                    <div>
                        <button id="joinAuctionBtn"
                                class="cursor-pointer rounded-md bg-[#16A34A] px-5 py-1.5 font-medium text-white hover:bg-[#28914e]">
                            Join Auction
                        </button>
                    </div>
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
                    auctionItemClone.querySelector("#statusView").classList.add(auctionItem.completed ? "bg-[#e41515]" : "bg-[#16A34A]");
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
