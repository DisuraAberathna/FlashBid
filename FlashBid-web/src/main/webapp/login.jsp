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
    <script src="https://cdn.jsdelivr.net/npm/axios/dist/axios.min.js"></script>
</head>
<body>
<header>
    <h1>FlashBid Login</h1>
</header>
<main>
    <div>
        <form onsubmit="handleSubmit(event)">
            <div>
                <label for="username">Username</label>
                <br/>
                <input type="text" name="username" id="username" placeholder="Enter Your Username"/>
            </div>
            <br/>
            <div>
                <label for="password">Password</label>
                <br/>
                <input type="password" name="password" id="password" placeholder="Enter Your Password"/>
            </div>
            <br/>
            <div>
                <button type="submit">Login</button>
            </div>
            <br/>
            <div>
                <span>or</span>
            </div>
            <br/>
            <div>
                <a href="register.jsp">Create New Account</a>
            </div>
        </form>
    </div>
</main>
<script>
    const handleSubmit = async (e) => {
        e.preventDefault();

        const response = await axios.post("login", {
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
                window.location.href = "home.jsp";
            } else {
                alert(data.message);
            }
        }
    }
</script>
</body>
</html>
