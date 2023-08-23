<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="icon" href="https://imgur.com/dCstdno.png" type="image/x-icon">
    <link rel="shortcut icon" href="https://imgur.com/dCstdno.png" type="image/x-icon">
    <title>Login Page</title>
    <link rel="stylesheet" href="styles.css">
    <style>
        body {
            font-family: Arial, sans-serif;
            margin-top: 15%;
            padding: 0;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 70vh;
                           background-image: linear-gradient(90deg, rgba(250,252,253,1) 0%, rgba(4,181,249,1) 100%, rgba(0,221,252,1) 100%, rgba(0,224,255,1) 100%);
        }

        .container {
            background-color: rgba(255, 255, 255, 0.8);
            padding: 60px; /* Decreased padding to make the form smaller */
            border-radius: 20px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
        }

        .login-form {
            text-align: center;
        }

        .welcome-message {
            font-size: 30px;
            margin-bottom: 20px;
        }

        .logo {
            position: absolute;
            top: 10px;
            left: 50%;
            transform: translateX(-50%);
            width: 250px;
        }

        form {
            display: flex;
            flex-direction: column;
            align-items: center;
        }

        label {
            font-size: 18px;
            margin-bottom: 10px;
        }

        input {
            padding: 10px; /* Decreased padding for smaller input fields */
            width: 250px; /* Adjusted width for smaller input fields */
            margin-bottom: 10px; /* Decreased margin for spacing */
            border: 1px solid #ccc;
            border-radius: 30px;
        }

        .login-button {
            padding: 10px 20px; /* Decreased padding for a smaller button */
            background-color: #044BD9;
            color: #fff;
            border: none;
            cursor: pointer;
            font-size: 18px;
            border-radius: 30px;
            transition: background-color 0.3s ease;
        }

        .login-button:hover {
            background-color: #fff;
            color: #044BD9;
        }

        .register-link {
            margin-top: 10px; /* Decreased margin for spacing */
            font-size: 16px;
        }

        .register-link a {
            color: blue;
        }
         .message3 {
            padding: 10px;
            margin-bottom: 10px;
            border-radius: 4px;
            font-weight: bold;
        }
        
        .success {
            background-color: #dff0d8;
            color: #3c763d;
            border: 1px solid #d6e9c6;
        }
        
        .error {
            background-color: #f2dede;
            color: #a94442;
            border: 1px solid #ebccd1;
        }
    </style>
    <script>
     setTimeout(function() {
            var message3Element = document.querySelector('.message3');
            if (message3Element) {
                message3Element.remove();
            }
        }, 5000); // Adjust the duration (in milliseconds) as needed
        </script>
</head>
<body>
    <img src="https://i.imgur.com/d08ZjUz.png" class="logo" alt="task master"/>
 <% String message3 = request.getParameter("message3");
           if ("success".equals(message3)) { %>
            <div class="message3 success">Registration successfully!</div>
        <% } else if ("error".equals(message3)) { %>
            <div class="message3 error">password incorrect.</div>
        <% } %>
    <div class="container">
        <div class="login-form">
            <h1 class="welcome-message">Let's make an account</h1>
            <form action="/myapp/register" method="POST">
                <label for="username">E-mail</label>
                <input type="email" id="username" name="email" required>
                <label for="username">Username</label>
                <input type="text" id="username" name="name" required>
                <label for="password">Password</label>
                <input type="password" id="password" name="password" required>
                <label for="password">Confirm your password</label>
                <input type="password" id="username" name="password2" required>
                <button type="submit" class="login-button">Register</button>
            </form>
            <p class="register-link">Don't have an account? <a href="/myapp/get-started">Already a member</a></p>
        </div>
    </div>
</body>
</html>
