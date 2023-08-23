
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


<!DOCTYPE html>
<html>
<head>
            <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">

  <title>Todo List</title>
  <style>
    /* Apply a basic reset to ensure consistent styling */
/* Apply a basic reset to ensure consistent styling */

/* Set a background color for the page */
body {
    font-family: Arial, sans-serif;
    margin: 0;
                             background-image: linear-gradient(90deg, rgba(250,252,253,1) 0%, rgba(4,181,249,1) 100%, rgba(0,221,252,1) 100%, rgba(0,224,255,1) 100%);

    padding: 0;
        /*background-color: #f0f0f0;

    display: flex;
    height: 100vh;
     
    box-sizing: border-box;*/

}

        h1 {
            text-align: center;
            margin-top: 15%;
            margin-left: 200px;
            color : white
        }

        p {
            text-align: center;
        }

        .container {
            display: flex;
            flex-direction: row;
            flex-wrap: wrap;
            justify-content: center;
            align-items: center;
            margin-left: 200px

        }
.centered-form {
    flex: 1;
    display: flex;
    justify-content: center;
    align-items: center;
    padding: 20px;
}

/*form {
    background-color: white;
    border: 1px solid #ccc;
    padding: 20px;
    border-radius: 5px;
    box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.1);
    max-width: 400px;
}*/
.task{
    background-color: white;
    border: 1px solid #ccc;
    padding: 40px;
    border-radius: 5px;
    box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.1);
    max-width: 400px;
}
.delete {
    border-radius: 5px;
    max-width: 400px;
}

.main-content {
    flex: 1;
    display: flex;
    flex-direction: column;
    justify-content: center;
    align-items: center;
    padding: 20px;
}


/* Additional Styles */
.task {
    margin: 5px;
    padding: 5px;
    border: 1px solid #ccc;
    border-radius: 5px;
   /* display: flex;*/
    justify-content: space-between;
}

.task-buttons input[type="checkbox"] {
    transform: scale(1.5); /* Adjust the scale value as needed */
    margin-left: 590px; /* Add some spacing between the checkbox and label */
    width: 15px; /* Adjust the width as needed */
    height: 15px; /* Adjust the height as needed */
    margin-right: 5px; /* Add some spacing between the checkbox and label */
}

#addTaskModal {
    display: none;
    position: fixed;
    top: 0;
    left: 0;
    width: 100%;
    height: 100%;
    flex-direction: column;
    background-color: rgba(0, 0, 0, 0.4);
    z-index: 999; /* Ensure the modal is on top of other elements */
}

.add-modal-content {
    background-color: white;
    width: 400px;
    margin: auto;
    margin-top: 100px;
    padding: 20px;
   /* border-radius: 5px;*/
    box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.2);
        border-radius: 30px;

}

.add-modal-header {
    text-align: center;
    font-size: 20px;
    font-weight: bold;
    margin-bottom: 20px;
    color: #22c1c3;
    padding: 8px 16px;
    border: none;
    border-radius: 30px;
    cursor: pointer;
    font-weight: bold;
    margin-bottom: 8px;
  
}

.add-modal-form label {
    display: block;
    margin-bottom: 5px;
    font-weight: bold;
    
}

.add-modal-form input[type="text"]{
      width: 95%;
    padding: 8px;
    border: 1px solid #ccc;
    border-radius: 15px;
  
}
.add-modal-form textarea{
      width: 95%;
    padding: 8px;
    border: 1px solid #ccc;
    border-radius: 15px;
  
}
.add-modal-form input[type="date"] {
    width: 95%;
    padding: 8px;
    border: 1px solid #ccc;
    border-radius: 15px;
    margin-bottom: 10px;
    font-size: 14px;
}

.add-modal-form input[type="submit"] {
background-color: #08AEEA;
background-image: linear-gradient(0deg, #08AEEA 0%, #2AF598 100%);    color: white;
    border: none;
    border-radius: 15px;
    padding: 10px 20px;
    cursor: pointer;
    font-size: 16px;
    font-weight: bold;
    transition: background-color 0.3s ease;
        text-align: center;

}

.add-modal-form input[type="submit"]:hover {
    background-color: #005F6B;
}

/* Modal Styles */
.modal {
    display: none;
    position: fixed;
    top: 0;
    left: 0;
    width: 100%;
    height: 100%;
    background-color: rgba(0, 0, 0, 0.4);
        flex: 1;

    
}
    .modal-overlay {
        display: none;
        position: fixed;
        top: 0;
        left: 0;
        width: 100%;
        height: 100%;
        background-color: rgba(0, 0, 0, 0.4);
        z-index: 1;
    }

.modal-content {
    background-color: white;
    width: 300px;
    margin: auto;
    margin-top: 100px;
    padding: 20px;
    border-radius: 5px;
    box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.2);
     max-height: 80vh; /* Set the maximum height of the modal */
    overflow-y: auto;
}
.modal-description-container {
    max-height: 50vh; /* Set the maximum height for the description container */
    overflow-y: auto; /* Enable scrolling for the description container */
}
    .modal-close {
        position: absolute;
        top: 10px;
        right: 10px;
        font-size: 18px;
        cursor: pointer;
    }
.close {
    position: absolute;
    top: 10px;
    right: 10px;
    font-size: 18px;
    cursor: pointer;
}
 
        .task-card {
          /*  border: 1px solid #ccc;*/
            border-radius: 5px;
            padding: 10px;
                margin-left: 500px;
    margin-top: 10px;
    cursor: pointer;
    transition: background-color 0.3s ease, transform 0.2s ease;

           /* display: flex;
                        margin: 10px 10px;

                       /* justify-content: space-between;*/

           /* align-items: center;*/
        }

    .task-card-details {
    flex: 1;
    margin-right: 10px;
    padding-right:10px;
    background-color: #5476DE;
    border: 1px solid #ccc;
    padding: 20px;
    border-radius: 30px;
    box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.1);
    max-width: 600px;
    position: relative; /* Add this to create a reference point for absolute positioning */

    }

    .task-card button {
        background-color: #ff0000;
        color: white;
        border: none;
        border-radius: 5px;
        padding: 5px 10px;
        cursor: pointer;
        }
        .task-meta {
    display: flex;
    align-items: center;
    margin-top: 10px;
    padding-top: 10px;
    position: relative;
}

.date-line {
    position: absolute;
    top: 0;
    left: 0;
    width: 100%;
    height: 1px;
    background-color: #ccc;
    margin-top: 40px
}


      .message {
            padding: 10px;
            margin-bottom: 10px;
            border-radius: 4px;
            font-weight: bold;
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
        h2 {
    /*text-align: center;**/
    color: white;/*#007BFF;*/
    font-size: 25px;
    margin: 10px;
    font-family: lexend;
    /*border: 1px solid #ccc;
    padding: 20px;
    border-radius: 5px;
    box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.1);
    max-width: 400px;*/
    font-weight: bold

}
.description{
    font-size: 15px;
    color : #EBE7E7;
        max-width: 80%; /* Adjust the max-width as needed */
         overflow: hidden;
    white-space: nowrap;
    text-overflow: ellipsis;
        margin-left: 50px;

    

}
.date {
    margin-left: 10px;
    margin-top: 40px;
    font-size: 12px;
    font-weight: bold;
    color: white;

}
.task-checkbox{
                margin-left: 580px;

}
/* Sidebar Styles */
.sidebar {
    width: 250px;
    /*background-color: #333;*/
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
#taskDetailsModal {
    display: none;
    position: fixed;
    top: 0;
    left: 0;
    width: 100%;
    height: 100%;
    background-color: rgba(0, 0, 0, 0.4);
    z-index: 999; /* Ensure the modal is on top of other elements */
}
 .addlink{
    display: block;
    margin-left: 0px;
    width: 200px;
    padding: 10px;
    background-color: #08AEEA;
background-image: linear-gradient(0deg, #08AEEA 0%, #2AF598 100%);
            magin-left: 0px;
            margin-top: 5%;


  /*  background-color: #007bff;*/
    color: white;
    text-align: center;
    text-decoration: none;
    border-radius: 30px;
    transition: background-color 0.3s, transform 0.2s;
   
}
/* styles.css 

.calendar-date {
  display: inline-block;
  background-color: #f5f5f5;
  border: 1px solid #ccc;
  padding: 10px;
  border-radius: 5px;
  font-family: Arial, sans-serif;
  font-size: 14px;
  margin-bottom: 20px;
  box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
}

.calendar-date span {
  display: block;
  font-size: 24px;
  font-weight: bold;
  margin-top: 5px;
  color: #333;
}*/

/* Modal Styles */
.modal {
    display: none;
    position: fixed;
    top: 0;
    left: 0;
    width: 100%;
    height: 100%;
    background-color: rgba(0, 0, 0, 0.4);
    z-index: 999; /* Ensure the modal is on top of other elements */
}

.modal-content {
    background-color: white;
    width: 400px;
    margin: auto;
    margin-top: 100px;
    padding: 20px;
    border-radius: 10px;
    box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.2);
}

.close {
    position: absolute;
    top: 10px;
    right: 10px;
    font-size: 20px;
    cursor: pointer;
}

#modalTaskName {
    font-size: 24px;
    font-weight: bold;
    margin-bottom: 10px;
    color: #22c1c3;
}

#modalDescription {
    font-size: 16px;
    margin-bottom: 10px;
}

#modalDate {
    font-size: 14px;
    color: #666;
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
        <li><a href="/myapp/edit-profile2"><i class="fas fa-edit"></i> Edit Profile</a></li>
        <li><a href="/myapp/index"><i class="fas fa-sign-out-alt"></i> Log Out</a></li>
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
                                <div class="container">

                    <% String message1 = request.getParameter("message1");
   if ("deleted".equals(message1)) { %>
    <div class="message1 success">Task deleted successfully!</div>
<% } else if ("error".equals(message1)) { %>
    <div class="message1 error">Failed to delete task. Please try again.</div>
<% } %>
                    </div>

        <!-- Rest of your content -->
                            <img src="https://i.imgur.com/d08ZjUz.png" class="logo" alt="task master"/>

         <h1></h1>

<c:forEach var="task" items="${tasks}">
<div class="task-card" onclick="showTaskDetails('${task.taskName}', '${task.description}', '${task.date}')">
                   <div class="task-card-details">
    <h2>${task.taskName}</h2>
    <p class="description">${task.description}</p>
        <div class="task-meta">
        <div class="date-line"></div>
        <p class="date">${task.date}</p>
    </div>
            <div class="task-buttons">
                    <form action="/myapp/mark-completed" method="post">
                <input type="hidden" name="taskId" value="${task.taskId}">
                <input type="checkbox" name="completed" id="taskCheckbox${task.taskId}" onchange="this.form.submit()" ${task.isCompleted ? 'checked' : ''}>
                <label class="checkbox-label" for="taskCheckbox${task.taskId}"></label>
            </form>
    </div>
<form class="delete" action="/myapp/delete-tasktodo" method="post" onsubmit="return confirmDelete()">
        <input type="hidden" name="taskId" value="${task.taskId}">
        <button type="submit"><i class="fas fa-trash"></i></button>
    </form>
</div>

    </div>
</c:forEach>
       <!-- <div class="centered-form">

  <form id="addTaskForm" action="/myapp/add-task_todo" method="post">
<input type="text" name="taskNametodo" placeholder="Task name">
    <input type="submit" value="Add Task">
  </form>-->
              <div id="taskDetailsModal" class="modal">
    <div class="modal-content">
        <span class="close">&times;</span>
        <h3 id="modalTaskName"></h3>
        <p id="modalDescription"></p>
        <p id="modalDate"></p>
    </div>
</div>
       
              <div class="container">

      <button id="addTaskButton" class="addlink">Add Task</button>
 <div id="addTaskModal" class="modal">
    <div class="add-modal-content">
        <span class="close">&times;</span>
        <h3 class="add-modal-header">Add Task</h3>
        <form class="add-modal-form" action="/myapp/add-task_todo" method="post">
            <label for="taskNametodo">Task Name:</label>
            <input type="text" id="taskNametodo" name="taskNametodo" required>
            
            <label for="descriptiontodo">Description:</label>
            <textarea id="descriptiontodo" name="descriptiontodo" rows="4" required></textarea>
            
            <label for="datetodo">Date:</label>
            <input type="date" id="datetodo" name="datetodo" required>
            
            <!--<label for="important">Important:</label>
            <input type="checkbox" id="important" name="important">-->
            
            <input type="submit" value="Add Task">
        </form>
    </div>
</div>
    </div>


 <script>
  document.addEventListener("DOMContentLoaded", function () {
        // Get modal and button elements
        const modal = document.getElementById("addTaskModal");
        const addTaskButton = document.getElementById("addTaskButton");
        const closeButton = modal.querySelector(".close");

        // Open modal when button is clicked
        addTaskButton.addEventListener("click", function () {
          modal.style.display = "block";
        });

        // Close modal when close button is clicked
        closeButton.addEventListener("click", function () {
          modal.style.display = "none";
        });

        // Close modal when clicking outside modal content
        window.addEventListener("click", function (event) {
          if (event.target === modal) {
            modal.style.display = "none";
          }
        });
      });
        // Remove the message element after a specified duration
        setTimeout(function() {
            var messageElement = document.querySelector('.message');
            if (messageElement) {
                messageElement.remove();
            }
        }, 5000); // Adjust the duration (in milliseconds) as needed
         setTimeout(function() {
            var message1Element = document.querySelector('.message1');
            if (message1Element) {
                message1Element.remove();
            }
        }, 5000); // Adjust the duration (in milliseconds) as needed
        
      

            function showTaskDetails(taskName, description, date) {
        const modal = document.getElementById("taskDetailsModal");
        const modalTaskName = document.getElementById("modalTaskName");
        const modalDescription = document.getElementById("modalDescription");
        const modalDate = document.getElementById("modalDate");

        modalTaskName.textContent = taskName;
        modalDescription.textContent = description;
        modalDate.textContent = date;

        modal.style.display = "block";
    }

    document.addEventListener("DOMContentLoaded", function () {
        const modal = document.getElementById("taskDetailsModal");
        const closeButton = modal.querySelector(".close");

        closeButton.addEventListener("click", function () {
            modal.style.display = "none";
        });

        window.addEventListener("click", function (event) {
            if (event.target === modal) {
                modal.style.display = "none";
            }
        });
    });
    function confirmDelete() {
        return confirm("Are you sure you want to delete this task?");
    }
    
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
</body>
</html>