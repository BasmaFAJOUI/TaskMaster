

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
  <title>Todo List</title>
  <style>
    /* Apply a basic reset to ensure consistent styling */
/* Apply a basic reset to ensure consistent styling */

/* Set a background color for the page */
body {
    background-color: #f0f0f0;
    font-family: Arial, sans-serif;
    display: flex;
    height: 100vh;
     margin: 0;

    padding: 0;
    box-sizing: border-box;

}

        h1 {
            text-align: center;
            margin-top: 20px;
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
        }
.centered-form {
    flex: 1;
    display: flex;
    justify-content: center;
    align-items: center;
    padding: 20px;
}

form {
    background-color: white;
    border: 1px solid #ccc;
    padding: 20px;
    border-radius: 5px;
    box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.1);
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
    display: flex;
    justify-content: space-between;
}

.task input[type="checkbox"] {
    margin-right: 10px;
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
}

.modal-content {
    background-color: white;
    width: 300px;
    margin: auto;
    margin-top: 100px;
    padding: 20px;
    border-radius: 5px;
    box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.2);
}

.close {
    position: absolute;
    top: 10px;
    right: 10px;
    font-size: 18px;
    cursor: pointer;
}
        .task-card {
            border: 1px solid #ccc;
            border-radius: 5px;
            padding: 10px;
            display: flex;
                        margin: 10px 10px;

                       /* justify-content: space-between;*/

            align-items: center;
        }

        .task-card-details {
            flex: 1;
            margin-right: 10px;
            padding-right:10px;
        }

        .task-card button {
            background-color: #ff0000;
            color: white;
            border: none;
            border-radius: 5px;
            padding: 5px 10px;
            cursor: pointer;
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
        
/* Sidebar Styles */
.sidebar {
    width: 250px;
    /*background-color: #333;*/
background-color: #0093E9;
background-image: linear-gradient(160deg, #0093E9 0%, #80D0C7 100%);

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
background-color: #007bff;

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
 .addlink{
    display: block;
    margin-left: 600px;
    width: 200px;
    padding: 10px;
    background-color: #08AEEA;
background-image: linear-gradient(0deg, #08AEEA 0%, #2AF598 100%);

  /*  background-color: #007bff;*/
    color: white;
    text-align: center;
    text-decoration: none;
    border-radius: 30px;
    transition: background-color 0.3s, transform 0.2s;
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
        <li><a href="/myapp/choice"><i class="fas fa-home"></i> Home</a></li>
        <li><a href="/myapp/view-profile"><i class="fas fa-info-circle"></i> Information</a></li>
        <li><a href="/myapp/edit-profile"><i class="fas fa-edit"></i> Edit Profile</a></li>
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
        <!-- Rest of your content -->
         <h1>Todo List</h1>
 <div id="taskList">
<c:forEach var="task" items="${tasks}">
    <div class="task-card">
        <form action="/myapp/mark-completed" method="post">
            <input type="hidden" name="taskId" value="${task.taskId}">
            <input type="checkbox" name="completed" id="taskCheckbox${task.taskId}" onchange="this.form.submit()" ${task.isCompleted ? 'checked' : ''}>
            <div class="task-card-details">
                <p>${task.taskName}</p>
                <p>${task.description}</p>
                <p>${task.date}</p>
            </div>
        </form>
        <form action="/myapp/delete-tasktodo" method="post">
            <input type="hidden" name="taskId" value="${task.taskId}">
            <button type="submit">Delete</button>
        </form>
    </div>
</c:forEach>
    </div>
       <!-- <div class="centered-form">

  <form id="addTaskForm" action="/myapp/add-task_todo" method="post">
<input type="text" name="taskNametodo" placeholder="Task name">
    <input type="submit" value="Add Task">
  </form>-->
              <div class="container">

      <button id="addTaskButton" class="addlink">Add Task</button>
     <div id="addTaskModal" class="modal">
        <div class="modal-content">
            <span class="close">&times;</span>
            <h2>Add Task</h2>
            <form id="taskForm" action="/myapp/add-task_todo" method="post">
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
    </script>
</body>
</html>
