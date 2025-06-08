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
    <script src="https://cdn.jsdelivr.net/npm/axios/dist/axios.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@tailwindcss/browser@4"></script>
    <link href="css/styles.css" rel="stylesheet"/>
</head>
<body>
<div class="flex min-h-screen flex-col items-center bg-slate-100 py-10">
    <div class="w-7xl space-y-5">
        <form onsubmit="handleSubmit(event)" class="space-y-3 rounded-xl bg-white px-6 py-8 drop-shadow-xl lg:max-w-md">
            <div>
                <h3 class="mb-1 text-2xl font-semibold">Add Auction Item</h3>
            </div>
            <div class="flex flex-col gap-y-1">
                <label for="title" class="font-medium">Title</label>
                <input type="text" id="title" placeholder="Enter Title"
                       class="rounded-md px-3 py-1 border-2 border-gray-300 hover:border-[#16A34A] active:border-[#16A34A] outline-none"/>
            </div>
            <div class="flex flex-col gap-y-1">
                <label for="bid" class="font-medium">Starting Bid</label>
                <div class="flex items-center">
                    <label class="font-medium">LKR &nbsp;</label>
                    <input type="number" id="bid" placeholder="Enter Starting Bid" min="1" step="0.01"
                           class="flex-1 rounded-md px-3 py-1 border-2 border-gray-300 hover:border-[#16A34A] active:border-[#16A34A] outline-none"/>
                </div>
            </div>
            <div class="text-center">
                <button type="submit"
                        class="cursor-pointer rounded-md bg-[#16A34A] px-20 py-1.5 font-medium text-white hover:bg-[#28914e]">
                    Submit
                </button>
            </div>
        </form>
        <div class="py-5">
            <h3 class="text-3xl font-bold">Auction Items</h3>
        </div>
        <div id="items" class="grid grid-cols-1 gap-3 md:grid-cols-2 lg:grid-cols-3"></div>
        <div id="item"
             class="flex w-full max-w-sm min-w-3xs flex-col gap-y-3 rounded-2xl bg-white px-7 py-6 drop-shadow-xl"
             data-auction-id="" hidden>
            <h4 id="itemTitle" class="text-xl font-semibold">Auction Item</h4>
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
                <label class="font-medium">End At : </label>
                <label id="endAt" class="font-medium text-gray-700">Not Yet</label>
            </div>
            <div class="mt-3 grid grid-cols-2 place-items-center">
                <div class="flex items-center gap-x-2">
                    <div id="statusView" class="h-2 w-2 rounded-full"></div>
                    <label id="status" class="font-medium"> On Going</label>
                </div>
                <div>
                    <button id="endAuctionBtn"
                            class="cursor-pointer rounded-md bg-[#e41515] px-5 py-1.5 font-medium text-white hover:bg-[#b63535]">
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

        const response = await axios.post("add-auction-item", {
            title: title.value,
            startBid: startBid.value,
        }, {
            headers: {
                "Content-Type": "application/json"
            }
        });

        // console.log(response);
        if (response.status === 200) {
            const data = response.data;

            if (data.success) {
                alert("Auction Item Added Successfully!");
                title.value = "";
                startBid.value = "";
                loadAuctionItems();
            } else {
                alert(data.message);
            }
        } else {
            alert("Something went wrong");
        }
    }

    const endAuction = async (id) => {
        const response = await axios.post("end-auction", {
            id: id,
        }, {
            headers: {
                "Content-Type": "application/json",
            }
        });

        // console.log(response);

        if (response.status === 200) {
            const data = response.data;
            if (data.success) {
                alert("Auction Ended Successfully!");
                loadAuctionItems();
            } else {
                alert(data.message);
            }
        } else {
            alert("Something went wrong");
        }
    }

    document.addEventListener("DOMContentLoaded", () => {
        loadAuctionItems();
        loadAuctionData();
    });

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
                    auctionItemClone.dataset.auctionId = auctionItem.id;
                    auctionItemClone.hidden = false;

                    auctionItemClone.querySelector("#itemTitle").innerHTML = auctionItem.title;
                    auctionItemClone.querySelector("#startBid").innerHTML = "LKR " + new Intl.NumberFormat("en-US", {
                        minimumFractionDigits: 2,
                    }).format(auctionItem.startBid);
                    auctionItemClone.querySelector("#currentBid").innerHTML = "LKR " + new Intl.NumberFormat("en-US", {
                        minimumFractionDigits: 2,
                    }).format(auctionItem.currentBid);
                    auctionItemClone.querySelector("#currentUser").innerHTML = auctionItem.user ? auctionItem.user.username : "";
                    auctionItemClone.querySelector("#startedAt").innerHTML = auctionItem.startTime;
                    auctionItemClone.querySelector("#endAt").innerHTML = auctionItem.endTime ? auctionItem.endTime : "";
                    auctionItemClone.querySelector("#statusView").classList.add(auctionItem.completed ? "bg-[#e41515]" : "bg-[#16A34A]");
                    auctionItemClone.querySelector("#endAuctionBtn").innerHTML = auctionItem.completed ? "Auction Complete" : "End Auction";
                    auctionItemClone.querySelector("#endAuctionBtn").disabled = auctionItem.completed;
                    auctionItemClone.querySelector("#endAuctionBtn").addEventListener("click", (e) => {
                        e.preventDefault();
                        endAuction(auctionItem.id);
                    });

                    items.appendChild(auctionItemClone);
                });
            } else {
                items.innerHTML = data.message;
            }
        } else {
            alert("Something went wrong");
        }
    }

    const loadAuctionData = () => {
        const webSocket = new WebSocket(`ws://localhost:8080/flash-bid/ws/auction`);

        webSocket.onopen = () => {
            console.log("Auction opened");
        };

        webSocket.onmessage = (e) => {
            console.log("text" + e.data);

            const message = JSON.parse(e.data);

            const auctionElement = document.querySelector('[data-auction-id="' + message.id + '"]');
            if (auctionElement) {
                auctionElement.querySelector("#currentBid").innerHTML = "LKR " + new Intl.NumberFormat("en-US", {
                    minimumFractionDigits: 2,
                }).format(message.currentBid);
                auctionElement.querySelector("#currentUser").innerHTML = message.user;

                auctionElement.classList.add("highlight");
                setTimeout(() => auctionElement.classList.remove("highlight"), 1000);
            }
        };

        webSocket.onclose = () => {
            console.log("Auction closed");
        };

        webSocket.onerror = (e) => {
            console.log("Auction error", e);
        };
    };
</script>
</body>
</html>
