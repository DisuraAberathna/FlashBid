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
    <title>FlashBid - Professional Betting Platform</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <script src="https://cdn.jsdelivr.net/npm/@tailwindcss/browser@4"></script>
</head>
<body>
<div class="min-h-screen bg-gradient-to-br from-slate-900 via-slate-800 to-slate-900 flex items-center justify-center px-4">
    <div class="w-full max-w-6xl flex flex-col items-center justify-center gap-y-12 py-12">
        <!-- Header with logo/branding -->
        <div class="text-center flex flex-col gap-y-4">
            <div class="inline-block">
                <h1 class="text-5xl lg:text-7xl font-black bg-gradient-to-r from-blue-500 to-purple-500 bg-clip-text text-transparent mb-2">FlashBid</h1>
                <div class="h-1 w-full bg-gradient-to-r from-blue-500 via-purple-500 to-green-500 rounded-full"></div>
            </div>
            <p class="text-xl lg:text-2xl text-gray-300 font-light">Professional Betting & Auction Platform</p>
            <p class="text-gray-400 max-w-md mx-auto">Experience real-time bidding with cutting-edge technology. Place your bets and win big!</p>
        </div>

        <!-- Feature highlights -->
        <div class="grid grid-cols-1 md:grid-cols-3 gap-6 w-full max-w-4xl mb-4">
            <div class="bg-slate-800 rounded-2xl p-6 shadow-[0_10px_30px_rgba(0,0,0,0.3)] border border-white/5 transition-all duration-300 hover:border-blue-500/30 hover:shadow-[0_15px_40px_rgba(0,0,0,0.4)] text-center">
                <div class="text-3xl mb-2">⚡</div>
                <h3 class="font-bold text-lg mb-1 text-white">Real-Time Bidding</h3>
                <p class="text-sm text-gray-300">Instant updates as bids are placed</p>
            </div>
            <div class="bg-slate-800 rounded-2xl p-6 shadow-[0_10px_30px_rgba(0,0,0,0.3)] border border-white/5 transition-all duration-300 hover:border-blue-500/30 hover:shadow-[0_15px_40px_rgba(0,0,0,0.4)] text-center">
                <div class="text-3xl mb-2">🎯</div>
                <h3 class="font-bold text-lg mb-1 text-white">Secure Platform</h3>
                <p class="text-sm text-gray-300">Safe and encrypted transactions</p>
            </div>
            <div class="bg-slate-800 rounded-2xl p-6 shadow-[0_10px_30px_rgba(0,0,0,0.3)] border border-white/5 transition-all duration-300 hover:border-blue-500/30 hover:shadow-[0_15px_40px_rgba(0,0,0,0.4)] text-center">
                <div class="text-3xl mb-2">🏆</div>
                <h3 class="font-bold text-lg mb-1 text-white">Win Big</h3>
                <p class="text-sm text-gray-300">Competitive auctions with great prizes</p>
            </div>
        </div>

        <!-- Action buttons -->
        <div class="flex flex-col sm:flex-row gap-5 w-full max-w-xl items-center justify-center">
            <a href="home.jsp"
               class="bg-gradient-to-r from-green-600 to-emerald-500 text-white font-semibold text-center py-3 px-8 text-lg rounded-lg cursor-pointer transition-all duration-300 hover:-translate-y-0.5 hover:shadow-[0_6px_20px_rgba(16,185,129,0.4)] shadow-[0_4px_15px_rgba(16,185,129,0.3)] active:translate-y-0 transform hover:scale-105">
                <span class="flex items-center justify-center gap-2">
                    <span>🔥</span>
                    <span>View Live Auctions</span>
                </span>
            </a>
            <a href="login.jsp"
               class="bg-gradient-to-r from-indigo-600 to-purple-600 text-white font-semibold text-center py-3 px-8 text-lg rounded-lg cursor-pointer transition-all duration-300 hover:-translate-y-0.5 hover:shadow-[0_6px_20px_rgba(102,126,234,0.4)] shadow-[0_4px_15px_rgba(102,126,234,0.3)] active:translate-y-0 transform hover:scale-105">
                <span class="flex items-center justify-center gap-2">
                    <span>🚀</span>
                    <span>Get Started</span>
                </span>
            </a>
        </div>

        <!-- Live indicator -->
        <div class="flex items-center gap-2 text-green-400">
            <div class="w-2 h-2 bg-green-500 rounded-full shadow-[0_0_8px_rgba(16,185,129,0.6)] animate-pulse"></div>
            <span class="text-sm font-medium">Platform Active</span>
        </div>
    </div>
</div>
</body>
</html>
