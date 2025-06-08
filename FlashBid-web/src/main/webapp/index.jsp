<%--
  Created by IntelliJ IDEA.
  User: User
  Date: 5/25/2025
  Time: 10:44 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>FlashBid</title>
    <script src="https://cdn.jsdelivr.net/npm/@tailwindcss/browser@4"></script>
    <link href="css/styles.css" rel="stylesheet"/>
</head>
<body>
<div class="flex items-center justify-center bg-neutral-100">
    <div class="flex h-screen w-full lg:w-7xl flex-col items-center justify-center gap-y-14 px-28">
        <div class="text-center">
            <h1 class="text-3xl lg:text-5xl font-bold">Welcome to FlashBid</h1>
        </div>
        <div class="flex flex-col lg:flex-row gap-5 text-center">
            <a href="home.jsp"
               class="cursor-pointer rounded-md bg-[#16A34A] px-10 py-1.5 lg:py-2 text-lg font-medium text-white hover:bg-[#28914e]">View
                Live Auctions</a>
            <a href="login.jsp"
               class="cursor-pointer rounded-md bg-[#16A34A] px-20 py-1.5 lg:py-2 text-lg font-medium text-white hover:bg-[#28914e]">Login</a>
        </div>
    </div>
</div>
</body>
</html>
