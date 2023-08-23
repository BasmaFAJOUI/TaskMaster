<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">

    <title>Choose Board</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
                             background-image: linear-gradient(90deg, rgba(250,252,253,1) 0%, rgba(4,181,249,1) 100%, rgba(0,221,252,1) 100%, rgba(0,224,255,1) 100%);
           
        }

        h1 {
            text-align: center;
            margin-top: 15%;
            color : white;
                margin-left :15%
        }

        p {
            text-align: center;
                            margin-left :15%;

            color : white
        }

        .container {
            display: flex;
            flex-direction: row;
            flex-wrap: wrap;
            justify-content: center;
                            margin-left :15%;

            align-items: center;
        }

        .board-link {
            display: flex;
            justify-content: center;
            align-items: center;
            margin: 10px;
            width: 100px;
            height: 100px;
            background-color: #456ADD;

          /*  background-color: #FFDEE9;
background-image: linear-gradient(0deg, #FFDEE9 0%, #B5FFFC 100%);*/

             /*  background-color: rgba(255, 255, 255, 0.8);*/


          /*  background-color: #007bff;*/
            color: white;
            text-align: center;
            text-decoration: none;
            border-radius: 10px;
            transition: background-color 0.3s, transform 0.2s;
        }

        .board-link:hover {
            background-color: #0056b3;
            transform: scale(1.15);
        }

        .error-message {
            color: red;
            text-align: center;
            margin-top: 10px;
        }
                .container {
            display: flex;
            flex-direction: row;
            flex-wrap: wrap;
            justify-content: center;
            align-items: center;
        }
       .addlink{
    display: block;
    width: 200px;
    padding: 10px;
background-image: linear-gradient(0deg, #08AEEA 0%, #2AF598 100%);
                margin-left :50%
;


  /*  background-color: #007bff;*/
    color: white;
    text-align: center;
    text-decoration: none;
    border-radius: 30px;
    transition: background-color 0.3s, transform 0.2s;
}

/* Sidebar Styles */
.sidebar {
    width: 250px;
    /*background-color: #333;*/
/*background-color: #0093E9;
background-image: linear-gradient(160deg, #0093E9 0%, #80D0C7 100%);
background-color: #03045e;*/
background: rgb(2,62,138);
background: linear-gradient(90deg, rgba(2,62,138,1) 100%, rgba(3,4,94,1) 100%);
    color: white;
    padding: 20px;
    position: fixed;
    top: 0;
    left: 0;
    bottom: 0;
    display: flex;
    flex-direction: column;
    justify-content: space-between;
}

.user-profile {
    display: flex;
    align-items: center;
    justify-content: center;
    margin-bottom: 20px;
}

.avatar {
    width: 50px;
    height: 50px;
    border-radius: 50%;
/*background-color: #0093E9;
background-image: linear-gradient(160deg, #0093E9 0%, #80D0C7 100%);*/
/*background-color: #21D4FD;
background-image: linear-gradient(19deg, #21D4FD 0%, #B721FF 100%);*/
          background-color: #21D4FD;
background-image: linear-gradient(19deg, #21D4FD 0%, #B721FF 100%);
    display: flex;
    align-items: center;
    justify-content: center;
    font-size: 24px;
    font-weight: bold;
}

.user-details {
    margin-left: 10px;
}

.sidebar-menu {
    list-style: none;
    padding-bottom:300px;
}

.sidebar-menu li {
    margin-bottom: 50px;
}

.sidebar-menu a {
    color: white;
    text-decoration: none;
}

        .message {
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
            .logo {
            position: absolute;
            top: 10px; /* Adjust the top value to position the logo */
            left: 42%; /* Center the logo horizontally */
                            margin-left :15%;

            transform: translateX(-50%); /* Center the logo using transform */
            width: 250px; /* Adjust the width as needed */
        }
  </style>
      <script>
          setTimeout(function() {
            var messageElement = document.querySelector('.message');
            if (messageElement) {
                messageElement.remove();
            }
        }, 5000); // Adjust the duration (in milliseconds) as needed
    history.pushState(null, null, location.href);
    window.onpopstate = function () {
        history.go(1);
    };
     window.onload = function () {
        history.pushState(null, null, location.href);
        window.addEventListener('popstate', function () {
            history.pushState(null, null, location.href);
        });
    };
     // Force a page refresh to clear cache after logout
    if (performance.navigation.type === 2) {
        // Perform a full reload when navigating from a history.back() action
        location.reload(true);
    }
     history.pushState(null, null, location.href);
    window.addEventListener('popstate', function (event) {
        history.pushState(null, null, location.href);
    });

        </script>
</head>
<body>
   <div class="sidebar">
    <div class="user-profile">
        <div class="avatar">
            <div class="avatar-letter">${sessionScope.userName.charAt(0)}</div>
        </div>
        <div class="user-details">
            <h3>${sessionScope.userName}</h3> 
        </div>
    </div>
   <ul class="sidebar-menu">
        <li><a href="/myapp/personal_or_team"><i class="fas fa-home"></i> Home</a></li>
        <li><a href="/myapp/view-profile"><i class="fas fa-info-circle"></i> Information</a></li>
        <li><a href="/myapp/edit-profile"><i class="fas fa-edit"></i> Edit Profile</a></li>
        <li><a href="/myapp/logout"><i class="fas fa-sign-out-alt"></i> Log Out</a></li>
    </ul>
</div>
            <div class="container">
        <!-- Check for the query parameter and display the message accordingly -->
        <% String message = request.getParameter("message");
           if ("success".equals(message)) { %>
            <div class="message success">Profile updated successfully!</div>
        <% } else if ("error".equals(message)) { %>
            <div class="message error">Failed to update profile. Please try again.</div>
        <% } %>
        
    </div>
                    <img src="https://i.imgur.com/d08ZjUz.png" class="logo" alt="task master"/>

        
    <h1>Welcome to Your Dashboard</h1>
    <p>Please choose a board from yours:</p>
    <div class="container">
        <c:forEach items="${boardNames}" var="boardName">
            <a class="board-link" href="/myapp/view-board?boardId=${boardName.id}&boardName=${boardName.name}">${boardName.name}</a>
        </c:forEach>
    </div>
    
    <p>Boards Linked to You:</p>
    <div class="container">
        <c:forEach items="${linkedBoardNames}" var="linkedBoardName">
            <a class="board-link" href="/myapp/view-board2?boardId=${linkedBoardName.id}&boardName=${linkedBoardName.name}">${linkedBoardName.name}</a>
        </c:forEach>
    </div>

    <a href="/myapp/add-board" class="addlink" style="background-color: #4caf50;">Add New Board</a>

    <!-- Display error message if it exists -->
    <c:if test="${not empty errorMessage}">
        <p class="error-message">${errorMessage}</p>
    </c:if>
</body>
</html>
