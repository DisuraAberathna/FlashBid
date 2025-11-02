<%--
  Created by IntelliJ IDEA.
  User: User
  Date: 5/29/2025
  Time: 5:24 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>FlashBid | Admin Login</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <script src="https://cdn.jsdelivr.net/npm/axios/dist/axios.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@tailwindcss/browser@4"></script>
</head>
<body>
<div class="min-h-screen bg-gradient-to-br from-slate-900 via-slate-800 to-slate-900 flex items-center justify-center px-4 py-8">
    <div class="flex flex-col w-full max-w-md gap-y-5">
        <!-- Logo/Branding -->
        <div class="text-center flex flex-col items-center gap-y-2">
            <a href="index.jsp" class="inline-block">
                <h1 class="text-4xl font-black bg-gradient-to-r from-blue-500 to-purple-500 bg-clip-text text-transparent">FlashBid</h1>
            </a>
            <div class="items-center gap-2 px-2 py-1 bg-purple-900/30 border border-purple-700/50 rounded-full w-fit">
                <span class="text-purple-400 text-sm font-semibold">🔐 Admin Portal</span>
            </div>
        </div>

        <!-- Admin Login Form -->
        <div class="bg-slate-800 rounded-3xl px-10 py-6 shadow-[0_20px_60px_rgba(0,0,0,0.4)] border border-purple-700/30 max-w-md w-full flex flex-col justify-center item-center gap-y-5">
            <div>
                <h2 class="text-3xl font-bold text-white mb-2">Admin Access</h2>
                <p class="text-gray-400 text-sm">Restricted access - Admin only</p>
            </div>

            <form onsubmit="handleSubmit(event)" class="flex flex-col gap-y-5">
                <div class="flex flex-col gap-y-2">
                    <label for="username" class="text-gray-300 font-semibold text-sm">Admin Username</label>
                    <input type="text" 
                           name="username" 
                           id="username" 
                           placeholder="Enter admin username"
                           class="bg-slate-700 border-2 border-transparent text-white py-3 px-4 rounded-lg transition-all duration-300 outline-none hover:border-purple-500/50 focus:border-blue-500 focus:shadow-[0_0_0_3px_rgba(59,130,246,0.1)] focus:bg-slate-600 placeholder:text-slate-400"
                           required
                           autocomplete="username"/>
                </div>

                <div class="flex flex-col gap-y-2">
                    <label for="password" class="text-gray-300 font-semibold text-sm">Admin Password</label>
                    <input type="password" 
                           name="password" 
                           id="password" 
                           placeholder="Enter admin password"
                           class="bg-slate-700 border-2 border-transparent text-white py-3 px-4 rounded-lg transition-all duration-300 outline-none hover:border-purple-500/50 focus:border-blue-500 focus:shadow-[0_0_0_3px_rgba(59,130,246,0.1)] focus:bg-slate-600 placeholder:text-slate-400"
                           required
                           autocomplete="current-password"/>
                </div>

                <div class="pt-2">
                    <button type="submit" class="bg-gradient-to-r from-indigo-600 to-purple-600 text-white font-semibold w-full py-3 text-base rounded-lg cursor-pointer transition-all duration-300 hover:-translate-y-0.5 hover:shadow-[0_6px_20px_rgba(102,126,234,0.4)] shadow-[0_4px_15px_rgba(102,126,234,0.3)] active:translate-y-0">
                        🔐 Sign In as Admin →
                    </button>
                </div>
            </form>
        </div>

        <!-- Back to home -->
        <div class="text-center mt-4">
            <a href="home.jsp" class="text-gray-400 hover:text-white text-sm transition-colors">
                ← Back to auctions
            </a>
        </div>
    </div>
</div>

<script>
    const handleSubmit = async (e) => {
        e.preventDefault();

        const username = document.getElementById("username").value;
        const password = document.getElementById("password").value;
        const submitButton = e.target.querySelector('button[type="submit"]');
        const originalText = submitButton.innerHTML;

        // Show loading state
        submitButton.disabled = true;
        submitButton.innerHTML = "Verifying...";

        try {
            const response = await axios.post("admin-login", {
                username: username,
                password: password
            }, {
                headers: {
                    'Content-Type': 'application/json'
                }
            });

            if (response.status === 200) {
                const data = response.data;

                if (data.success) {
                    submitButton.innerHTML = "✓ Access granted";
                    submitButton.classList.add("bg-green-500");
                    setTimeout(() => {
                        window.location.href = "admin-panel.jsp";
                    }, 500);
                } else {
                    submitButton.disabled = false;
                    submitButton.innerHTML = originalText;
                    alert(data.message || "Access denied. Invalid credentials.");
                }
            } else {
                submitButton.disabled = false;
                submitButton.innerHTML = originalText;
                alert("Something went wrong. Please try again.");
            }
        } catch (error) {
            console.error("Admin login error:", error);
            submitButton.disabled = false;
            submitButton.innerHTML = originalText;
            alert("An error occurred. Please try again.");
        }
    }
</script>
</body>
</html>
