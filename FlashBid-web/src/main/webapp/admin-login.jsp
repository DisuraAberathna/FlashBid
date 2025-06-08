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
    <script src="https://cdn.jsdelivr.net/npm/axios/dist/axios.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@tailwindcss/browser@4"></script>
    <link href="css/styles.css" rel="stylesheet"/>
</head>
<body>
<div class="w-full h-screen flex justify-center items-center bg-neutral-100">
    <form onsubmit="handleSubmit(event)" class="min-w-sm lg:min-w-md bg-white drop-shadow-xl rounded-xl px-6 py-8 space-y-3">
        <div>
            <h2 class="font-semibold text-2xl mb-1">FlashBid Admin Login</h2>
            <h6>Welcome back!</h6>
        </div>
        <div class="flex flex-col gap-y-1">
            <label for="username" class="font-medium">Username</label>
            <input type="text" name="username" id="username" placeholder="Enter Your Username"
                   class="rounded-md px-3 py-1 border-2 border-gray-300 hover:border-[#16A34A] active:border-[#16A34A] outline-none"/>
        </div>
        <div class="flex flex-col gap-y-1">
            <label for="password" class="font-medium">Password</label>
            <input type="password" name="password" id="password" placeholder="Enter Your Password"
                   class="rounded-md px-3 py-1 border-2 border-gray-300 hover:border-[#16A34A] active:border-[#16A34A] outline-none"/>
        </div>
        <div class="text-center mt-6">
            <button type="submit"
                    class="bg-[#16A34A] text-white font-medium py-1.5 px-20 rounded-md hover:bg-[#28914e] cursor-pointer">
                Login
            </button>
        </div>
    </form>
</div>
<script>
    const handleSubmit = async (e) => {
        e.preventDefault();

        const response = await axios.post("admin-login", {
            username: document.getElementById("username").value,
            password: document.getElementById("password").value
        }, {
            headers: {
                'Content-Type': 'application/json'
            }
        });

        // console.log(response);
        if (response.status === 200) {
            const data = response.data;

            if (data.success) {
                window.location.href = "admin-panel.jsp";
            } else {
                alert(data.message);
            }
        } else {
            alert("Something went wrong");
        }
    }
</script>
</body>
</html>
