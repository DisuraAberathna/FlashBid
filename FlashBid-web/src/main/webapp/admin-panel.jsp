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
</head>
<body onload="loadAuctionItems()">
<main>
    <div>
        <form onsubmit="handleSubmit(event)">
            <fieldset>
                <legend>
                    <h3>Add Auction Item</h3>
                </legend>
                <div>
                    <label for="title">Title</label>
                    <br/>
                    <input type="text" id="title" placeholder="Enter Title"/>
                </div>
                <br/>
                <div>
                    <label for="bid">Starting Bid</label>
                    <br/>
                    <label>LKR &nbsp;</label>
                    <input type="number" id="bid" placeholder="Enter Starting Bid" min="1" step="0.01"/>
                </div>
                <br/>
                <div>
                    <button type="submit">Submit</button>
                </div>
            </fieldset>
        </form>
    </div>

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
                            <label>End At : </label>
                            <label id="endAt">Not Yet</label>
                        </div>
                        <br/>
                        <div>
                            <button id="endAuctionBtn">End Auction</button>
                        </div>
                    </fieldset>
                </div>
            </div>
        </fieldset>
    </div>
</main>
<script>
    const handleSubmit = async (e) => {
        e.preventDefault();

        const response = await axios.post("add-auction-item", {
            title: document.getElementById("title").value,
            startBid: document.getElementById("bid").value,
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
                window.location.reload();
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
                window.location.reload();
            }else {
                alert(data.message);
            }
        } else {
            alert("Something went wrong");
        }
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
                    auctionItemClone.querySelector("#startBid").innerHTML = "LKR " + new Intl.NumberFormat("en-US", {
                        minimumFractionDigits: 2,
                    }).format(auctionItem.startBid);
                    auctionItemClone.querySelector("#currentBid").innerHTML = "LKR " + new Intl.NumberFormat("en-US", {
                        minimumFractionDigits: 2,
                    }).format(auctionItem.currentBid);
                    auctionItemClone.querySelector("#currentUser").innerHTML = auctionItem.user ? auctionItem.user.username : "";
                    auctionItemClone.querySelector("#startedAt").innerHTML = auctionItem.startTime;
                    auctionItemClone.querySelector("#endAt").innerHTML = auctionItem.endTime ? auctionItem.endTime : "";
                    auctionItemClone.querySelector("#endAuctionBtn").innerHTML = auctionItem.completed ? "Auction Complete" : "End Auction";
                    auctionItemClone.querySelector("#endAuctionBtn").disabled = auctionItem.completed;
                    auctionItemClone.querySelector("#endAuctionBtn").addEventListener("click", (e) => {
                        endAuction(auctionItem.id)
                        e.preventDefault();
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
</script>
</body>
</html>
