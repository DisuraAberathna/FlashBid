<%--
  Created by IntelliJ IDEA.
  User: User
  Date: 5/28/2025
  Time: 8:38 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>FlashBid | Login</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <script src="https://cdn.jsdelivr.net/npm/axios/dist/axios.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@tailwindcss/browser@4"></script>
</head>
<body>
<div class="min-h-screen bg-gradient-to-br from-slate-900 via-slate-800 to-slate-900 flex items-center justify-center px-4 py-8">
    <div class="flex flex-col w-full max-w-md gap-y-5">
        <!-- Logo/Branding -->
        <div class="text-center">
            <a href="index.jsp" class="inline-block mb-2">
                <h1 class="text-4xl font-black bg-gradient-to-r from-blue-500 to-purple-500 bg-clip-text text-transparent">FlashBid</h1>
            </a>
            <p class="text-gray-400">Professional Betting Platform</p>
        </div>

        <!-- Login Form -->
        <div class="bg-slate-800 rounded-3xl px-10 py-6 shadow-[0_20px_60px_rgba(0,0,0,0.4)] border border-white/5 max-w-md w-full flex flex-col gap-y-5">
            <div class="mb-2">
                <h2 class="text-3xl font-bold text-white mb-2">Welcome Back</h2>
                <p class="text-gray-400 text-sm">Sign in to continue bidding</p>
            </div>

            <form onsubmit="handleSubmit(event)" class="flex flex-col gap-y-5">
                <div class="flex flex-col gap-y-2">
                    <label for="username" class="text-gray-300 font-semibold text-sm">Username</label>
                    <input type="text" 
                           name="username" 
                           id="username" 
                           placeholder="Enter your username"
                           class="bg-slate-700 border-2 border-transparent text-white py-3 px-4 rounded-lg transition-all duration-300 outline-none hover:border-purple-500/50 focus:border-blue-500 focus:shadow-[0_0_0_3px_rgba(59,130,246,0.1)] focus:bg-slate-600 placeholder:text-slate-400"
                           required
                           autocomplete="username"/>
                </div>

                <div class="flex flex-col gap-y-2">
                    <label for="password" class="text-gray-300 font-semibold text-sm">Password</label>
                    <input type="password" 
                           name="password" 
                           id="password" 
                           placeholder="Enter your password"
                           class="bg-slate-700 border-2 border-transparent text-white py-3 px-4 rounded-lg transition-all duration-300 outline-none hover:border-purple-500/50 focus:border-blue-500 focus:shadow-[0_0_0_3px_rgba(59,130,246,0.1)] focus:bg-slate-600 placeholder:text-slate-400"
                           required
                           autocomplete="current-password"/>
                </div>

                <div class="pt-2">
                    <button type="submit" class="bg-gradient-to-r from-green-600 to-emerald-500 text-white font-semibold w-full py-3 text-base rounded-lg cursor-pointer transition-all duration-300 hover:-translate-y-0.5 hover:shadow-[0_6px_20px_rgba(16,185,129,0.4)] shadow-[0_4px_15px_rgba(16,185,129,0.3)] active:translate-y-0">
                        Sign In →
                    </button>
                </div>

                <div class="relative my-1">
                    <div class="absolute inset-0 flex items-center">
                        <div class="w-full border-t border-slate-700"></div>
                    </div>
                    <div class="relative flex justify-center text-sm">
                        <span class="px-4 bg-slate-800 text-gray-400">or</span>
                    </div>
                </div>

                <div class="text-center">
                    <p class="text-gray-400 text-sm mb-2">Don't have an account?</p>
                    <a href="register.jsp" class="bg-gradient-to-r from-indigo-600 to-purple-600 text-white font-semibold py-2 px-6 text-sm rounded-lg cursor-pointer transition-all duration-300 hover:-translate-y-0.5 hover:shadow-[0_6px_20px_rgba(102,126,234,0.4)] shadow-[0_4px_15px_rgba(102,126,234,0.3)] inline-block">
                        Create Account
                    </a>
                </div>
            </form>
        </div>

        <!-- Back to home -->
        <div class="text-center mt-4">
            <a href="index.jsp" class="text-gray-400 hover:text-white text-sm transition-colors">
                ← Back to Home
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
        submitButton.innerHTML = "Signing in...";

        try {
            const response = await axios.post("login", {
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
                    submitButton.innerHTML = "✓ Success!";
                    submitButton.classList.add("bg-green-500");
                    setTimeout(() => {
                        window.location.href = "home.jsp";
                    }, 500);
                } else {
                    submitButton.disabled = false;
                    submitButton.innerHTML = originalText;
                    alert(data.message || "Login failed. Please check your credentials.");
                }
            } else {
                submitButton.disabled = false;
                submitButton.innerHTML = originalText;
                alert("Something went wrong. Please try again.");
            }
        } catch (error) {
            console.error("Login error:", error);
            submitButton.disabled = false;
            submitButton.innerHTML = originalText;
            alert("An error occurred. Please try again.");
        }
    }
</script>
</body>
</html>
