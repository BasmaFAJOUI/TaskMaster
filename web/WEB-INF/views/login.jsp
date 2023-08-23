<%-- Document : register Created on : 18 juil. 2023, 12:37:55 Author : hp --%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>


<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login Page</title>
    <link rel="stylesheet" href="styles.css">
    <link rel="icon" href="https://imgur.com/dCstdno.png" type="image/x-icon">
    <link rel="shortcut icon" href="https://imgur.com/dCstdno.png" type="image/x-icon">
    <style>
body {
    font-family: Arial, sans-serif;
    margin: 0;
    padding: 0;
    display: flex;
    justify-content: center;
    align-items: center;
    height: 100vh;
                background-image: linear-gradient(90deg, rgba(250,252,253,1) 0%, rgba(4,181,249,1) 100%, rgba(0,221,252,1) 100%, rgba(0,224,255,1) 100%);
}

.container {
    background-color: rgba(255, 255, 255, 0.8);
    margin-top: 10%;
    padding: 60px; /* Increased padding to make the form bigger */
    border-radius: 20px; /* Rounded corners to make it appear more 3D */
    box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2); /* Adding a shadow for the 3D effect */
}

.login-form {
    text-align: center;
}

.welcome-message {
    font-size: 36px; /* Larger font size for the welcome message */
    margin-bottom: 30px; /* Increased margin for spacing */
}

form {
    display: flex;
    flex-direction: column;
    align-items: center;
}

label {
    font-size: 18px; /* Larger font size for the labels */
    margin-bottom: 10px; /* Increased margin for spacing */
}

input {
    padding: 15px; /* Increased padding for larger input fields */
    width: 300px; /* Wider input fields */
    margin-bottom: 15px; /* Increased margin for spacing */
    border: 1px solid #ccc;
    border-radius: 30px;
}

.login-button {
    padding: 13px 25px; /* Increased padding for a larger button */
    background-color: #007BFF;
    color: #fff;
    border: none;
    cursor: pointer;
    font-size: 20px; /* Larger font size for the button text */
    border-radius: 30px; /* More rounded corners for a 3D effect */
    transition: background-color 0.3s ease;
}

.login-button:hover {
    background-color: #fff;
        color : #007BFF;

}

.register-link {
    margin-top: 15px; /* Increased margin for spacing */
    font-size: 16px; /* Larger font size for the register link */
}

.register-link a {
    color: blue;
   
}.logo {
            position: absolute;
            top: 10px; /* Adjust the top value to position the logo */
            left: 50%; /* Center the logo horizontally */
            transform: translateX(-50%); /* Center the logo using transform */
            width: 250px; /* Adjust the width as needed */
        }
 .message1 {
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
            var message1Element = document.querySelector('.message1');
            if (message1Element) {
                message1Element.remove();
            }
        }, 5000); // Adjust the duration (in milliseconds) as needed
        </script>
</head>

<body>
        <img src="https://i.imgur.com/d08ZjUz.png" class="logo" alt="task master"/>
        <!--<img src="https://imgur.com/871u5wM.png" class="logo" alt="task master"/>-->
            <div class="container1">

        <!-- Check for the query parameter and display the message accordingly -->
 <% String message = request.getParameter("message");
           if ("success".equals(message)) { %>
            <div class="message success">Profile updated successfully!</div>
        <% } else if ("error".equals(message)) { %>
            <div class="message error">Failed to update profile. Please try again.</div>
        <% } %>
                    </div>
    <div class="container">
        <div class="login-form">
            <h1 class="welcome-message">Welcome!!</h1>
	<form action="/myapp/login" method="POST">
                <label for="username">E-mail</label>
                <input type="email" id="username" name="email" required>
                
                <label for="password">Password</label>
                <input type="password" id="password" name="password" required>
                
                <button type="submit" class="login-button">Log In</button>
            </form>
 
            <p class="register-link">Don't have an account? <a href="/myapp/no-account">Register here</a></p>
        </div>
    </div>
</body>
</html>
