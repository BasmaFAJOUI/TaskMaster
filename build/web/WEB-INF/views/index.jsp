<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Welcome to TaskMaster</title>
    <link rel="icon" href="https://imgur.com/dCstdno.png" type="image/x-icon">
    <link rel="shortcut icon" href="https://imgur.com/dCstdno.png" type="image/x-icon">
</head>
<style>
    body {
        font-family: Arial, sans-serif;
        margin: 0;
        padding: 0;
    }

    header {
      
    padding: 10px;
        display: flex;
        justify-content: space-between;
        align-items: center;
                background-image: linear-gradient(90deg, rgba(250,252,253,1) 0%, rgba(4,181,249,1) 100%, rgba(0,221,252,1) 100%, rgba(0,224,255,1) 100%);
    }
    .header-button {
        margin-top: 50px;
        margin-left: 10px;
        padding: 8px 15px;
        background-color: #fff;
        color: #007BFF;
        border: none;
        border-radius: 30px;
        cursor: pointer;
        font-size: 20px;
        text-align: center;
        text-decoration: none;
        transition: background-color 0.3s ease;
    }

    .header-button:hover {
        background-color: #007BFF;
        color: #fff
    }

main {
    display: flex;
    justify-content: center;
    align-items: center;
    height: 100vh;
    background-image: linear-gradient(90deg, rgba(250,252,253,1) 0%, rgba(4,181,249,1) 100%, rgba(0,221,252,1) 100%, rgba(0,224,255,1) 100%);

}

.welcome-container {
    text-align: center;
}

.slogan {
    font-size: 40px;
    margin-bottom: 20px;
    color: white;
}

.get-started-button {
    padding: 10px 20px;
    background-color: #007BFF;
    color: #ffffff;
    border: none;
    cursor: pointer;
    font-size: 25px;
    border-radius: 30px;
    transition: background-color 0.3s ease;
}

.get-started-button:hover {
    background-color: #fff;
    color : #007BFF;
    border-radius: 30px;
}

    .logo {
        position: absolute;
        left: 50%;
        top: 5%;
        transform: translateX(-50%);
        width: 400px; /* Adjust the width as needed */
    }

    .organize {
        position: absolute;
        left: 21%;
        bottom: 50%;
        font-size: 30px;
        color: white;
        background-color: #05AFF2;
                padding: 10px 20px;
                        border-radius: 30px;


            

    }

    .prioritize {
        position: absolute;
        top: 16%;
        left: 50%;
        transform: translateX(-50%);
        font-size: 30px;
        color: white;
        background-color: #05AFF2;
                padding: 10px 20px;
                        border-radius: 30px;


    }

    .accomplish {
        position: absolute;
        right: 20%;
        bottom: 50%;
        font-size: 30px;
        color: white;
        background-color: #05AFF2;
                padding: 10px 20px;
                        border-radius: 30px;



    }
    .message2 {
            padding: 10px;
            margin-bottom: 10px;
            border-radius: 4px;
            font-weight: bold;
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
            var message2Element = document.querySelector('.message2');
            if (message2Element) {
                message2Element.remove();
            }
        }, 5000); 
    
     setTimeout(function() {
            var message3Element = document.querySelector('.message3');
            if (message3Element) {
                message3Element.remove();
            }
        }, 5000);    
    
    // Adjust the duration (in milliseconds) as needed
        </script>
<body>
    <header>
        <img src="https://i.imgur.com/d08ZjUz.png" class="logo" alt="task master"/>
       <!-- <img src="https://imgur.com/Gs5roQP.png" class="logo" alt="task master"/>-->


        <!-- Check for the query parameter and display the message accordingly -->
 <% String message2 = request.getParameter("message2");
           if ("success".equals(message2)) { %>
            <div class="message2 success">Registration successfully!</div>
        <% } else if ("error".equals(message2)) { %>
            <div class="message2 error">Failed to register. Please try again.</div>
        <% } %>
        <% String message3 = request.getParameter("message3");
           if ("success".equals(message3)) { %>
            <div class="message3 success">Registration successfully!</div>
        <% } else if ("error".equals(message3)) { %>
            <div class="message3 error">the second passowrd entred is incorrect please try again...</div>
        <% } %>
       
    </header>
    <main>
        <div class="welcome-container">
            <h1 class="slogan">Organize...Prioritize...Accomplish!</h1>
            <a href="/myapp/get-started"><button class="get-started-button">Get Started</button></a>
        </div>
    </main>
</body>
</html>


