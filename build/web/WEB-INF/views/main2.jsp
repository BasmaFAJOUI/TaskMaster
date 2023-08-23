<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql" %>
<%@page import="java.util.List" %>


<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Kanban Dashboard</title>

    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <style>
  /* Styles for the modal */
  .modal {
    display: none;
    position: fixed;
    z-index: 1;
    left: 0;
    top: 0;
    width: 100%;
    height: 100%;
    overflow: auto;
    background-color: rgba(0, 0, 0, 0.4);
  }
  .welcome{
      color:blue;
      margin-left:40%
          
  }
  .modal-content {
    background-color: #fefefe;
    margin: 15% auto;
    padding: 20px;
    border: 1px solid #888;
    max-width: 400px;
    box-shadow: 0 4px 8px 0 rgba(0, 0, 0, 0.2);
  }

  .close {
    color: #aaa;
    float: right;
    font-size: 28px;
    font-weight: bold;
  }

  .close:hover,
  .close:focus {
    color: black;
    text-decoration: none;
    cursor: pointer;
  }

  /* Styles for the form fields */
  #addTaskForm {
    display: flex;
    flex-direction: column;

  }

  #addTaskForm label {
    /*margin-bottom: 8px;*/
    /*font-weight: bold;*/
    font-size: 14px;
    margin-bottom: 8px;
  }
  #addTaskForm input[type="date"] {
    width: 300px;
    padding: 15px;
    border: 1px solid #ccc;
        border-radius: 15px;
        margin-bottom: 15px;
    font-size: 14px;
}

  #addTaskForm input[type="text"] {
    /*padding: 8px;
    border: 1px solid #ccc;
    border-radius: 4px;
    margin-bottom: 12px;*/
            padding: 15px;
        width: 300px;
        margin-bottom: 15px;
        border: 1px solid #ccc;
        border-radius: 15px;
  }

  #addTaskForm button[type="submit"] {
    /*background-color: #4CAF50;
    color: white;
    padding: 10px 20px;
    border: none;
    border-radius: 4px;
    cursor: pointer;*/
            padding: 13px 25px;
        background-color: #007BFF;
        color: #fff;
        border: none;
        cursor: pointer;
        font-size: 20px;
        border-radius: 30px;
        transition: background-color 0.3s ease;
    
  }

  #addTaskForm button[type="submit"]:hover {
        background-color: #fff;
        color : #007BFF;  }
     #addTaskForm textarea {
    width: 272px;
    padding: 30px;
    border: 1px solid #ccc;
    border-radius: 30px;
  }
  

          /* Styling for the button */
  #addListButton {
    background-color: blue;
    color: #ffffff;
    padding: 8px 16px;
    border: none;
    border-radius: 30px;
    cursor: pointer;
    font-size: 14px;
    font-weight: bold;
    margin-bottom: 8px;
  }

  /* Styling for the input field */
  #addListInput {
    display: none;
    margin-bottom: 8px;
  }

  #addListInput input[type="text"] {
    width: 200px;
    padding: 8px;
    border: 1px solid #ccc;
    border-radius: 3px;
  }
 


  #addListInput button {
    background-color: blue;
    color: #ffffff;
    padding: 6px 12px;
    border: none;
    border-radius: 30px;
    cursor: pointer;
    font-size: 12px;
    font-weight: bold;
  }
        body {
    font-family: Arial, sans-serif;
    margin: 0;
    padding: 0;
    background-color: #f0f0f0;
}

.kanban-container {
    display: flex;
    padding: 10px;
    gap: 10px;
    overflow-x: auto;
}

.column {
    flex: 1;
    max-width: 300px;
    background-color: #f9f9f9;
    border-radius: 5px;
    box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
    padding: 10px;
    display: flex;
    flex-direction: column;
    gap: 10px;
}

h2 {
    text-align: center;
    color: #007BFF;
    font-size: 20px;
    margin: 0;
}

.card {
    background-color: #ffffff;
    border-radius: 5px;
    padding: 15px;
    margin-top: 10px;
    cursor: pointer;
    transition: background-color 0.3s ease, transform 0.2s ease;
}

.card:hover {
    background-color: #f0f0f0;
    transform: translateY(-3px);
}

.card:active {
    transform: translateY(0);
    box-shadow: 0 1px 2px rgba(0, 0, 0, 0.1);
}

.column-header {
    display: flex;
    justify-content: space-between;
    align-items: center;
}

.add-task, .add-column {
    background: none;
    border: none;
    cursor: pointer;
    font-size: 18px;
    color: #007BFF;
    transition: color 0.3s ease;
}

.add-task:hover, .add-column:hover {
    color: #0056b3;
}

.add-task:focus, .add-column:focus {
    outline: none;
}

.add-task i, .add-column i {
    margin-right: 5px;
}

.add-column {
    width: fit-content;
    margin: 0 auto;
    display: block;}
            .top-bar {
            color: white;
            display: flex;
            justify-content: space-between;
            align-items: center;
                background-color: #456ADD;

        }
        .top-bar2 {
    color: #333;
    padding: 10px;
    display: flex;
    justify-content: space-between;
    align-items: center;
    background-color: #E6ECF0;
    flex-direction: row; /* Set the flex direction to row */
    box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
    font-size: 14px;
}
        .user-profile {
            display: flex;
            align-items: center;
        }

        .user-avatar {
            width: 60px;
            height: 60px;
            border-radius: 50%;
background-color: #21D4FD;
background-image: linear-gradient(19deg, #21D4FD 0%, #B721FF 100%);
display: flex;
            align-items: center;
            justify-content: center;
            font-size: 22px;
            font-weight: bold;
            margin-right: 10px;
        }

        .user-details {
            font-size: 18px;
            
        }

        .top-bar-links {
            list-style: none;
            display: flex;

        }

        .top-bar-links li {
            margin-right: 20px;
        }

        .top-bar-links a {
            color: white;
            text-decoration: none;
        }
.logo-container {
   
}

.logo {
    width: 130px;
     align-items: center;
    margin-left: 12%;
    margin-top: 0px; /* Add margin-top to push the content down from the top */
}
/* Add Members Section Styles */
#add-members-button {
    background-color: #007BFF;
    color: white;
    padding: 8px 16px;
    border: none;
    border-radius: 30px;
    cursor: pointer;
    font-size: 14px;
    font-weight: bold;
    margin-right: 10px;
    transition: background-color 0.3s ease;
}

#add-members-button:hover {
    background-color: #0056b3;
}

#add-members-input {
    display: none;
    align-items: center;
}

#emailInput {
    padding: 8px;
    border: 1px solid #ccc;
    border-radius: 3px;
    margin-right: 10px;
}

#add-members-input button {
    background-color: #007BFF;
    color: white;
    padding: 6px 12px;
    border: none;
    border-radius: 30px;
    cursor: pointer;
    font-size: 12px;
    font-weight: bold;
    transition: background-color 0.3s ease;
}

#add-members-input button:hover {
    background-color: #0056b3;
}
.show{
    background-color: #007BFF;
    color: white;
    padding: 8px 16px;
    border: none;
    border-radius: 30px;
    cursor: pointer;
    font-size: 14px;
    font-weight: bold;
    margin-right: 10px;
    transition: background-color 0.3s ease;
}

.show:hover {
    background-color: #0056b3;
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
               .message1 {
            padding: 10px;
            margin-bottom: 10px;
            border-radius: 4px;
            font-weight: bold;
        }
           .message4 {
            padding: 10px;
            margin-bottom: 10px;
            border-radius: 4px;
            font-weight: bold;
        }
    </style>
    <script>
  // JavaScript function to show the modal and set the column name in the form
  
  
document.addEventListener("DOMContentLoaded", function() {
    const columns = document.querySelectorAll(".column");
    const cards = document.querySelectorAll(".card");
    cards.forEach(card => {
        card.addEventListener("dragstart", handleDragStart);
    });
    columns.forEach(column => {
        column.addEventListener("dragover", allowDrop);
        column.addEventListener("drop", handleDrop);
    });

    let draggedCard = null;});

    function updateColumnWidth() {
        columns.forEach(column => {
            const cardsCount = column.querySelectorAll(".card").length;
            const width = Math.max(300, cardsCount * 150);
            column.style.maxWidth = width + "px";
        });
    }


    function showAddTaskModal(columnName, columnId) {
    var modal = document.getElementById('addTaskModal');
    var columnNameInput = document.getElementById('columnName');
    var columnIdInput = document.getElementById('columnId');
    columnNameInput.value = columnName;
    columnIdInput.value = columnId;
    modal.style.display = "block";
}


// JavaScript function to close the modal
function closeAddTaskModal() {
    var modal = document.getElementById('addTaskModal');
    modal.style.display = "none";
}
function handleDragStart(e) {
    draggedCard = e.target;
    e.dataTransfer.effectAllowed = "move";
    e.dataTransfer.setData("text/plain", null);
        const taskId = e.target.dataset.taskId;
    draggedCard.dataset.taskId = taskId;

}

    function handleDragOver(e) {
        e.preventDefault();
    }
        function drag(ev) {
        ev.dataTransfer.setData("text/plain", ev.target.id);
        
    }

    function allowDrop(ev) {
        ev.preventDefault();
        var data = ev.dataTransfer.getData("text");
        //const taskId = draggedCard.dataset.task.id;
    var targetColumn = ev.target.closest(".column");
        const taskId = draggedCard.dataset.taskId;
// Define and initialize targetColumn here


    
    }




    function drop(ev) {
        ev.preventDefault();
        var data = ev.dataTransfer.getData("text");
        var targetColumn = ev.target.closest(".column");
        targetColumn.querySelector(".cards").appendChild(document.getElementById(data));
        // Update the task's column information in the database
        // You can use AJAX to send the updated information to the servlet
    }

function addNewTask(button) {
    const column = button.parentElement.parentElement;
    const columnId = column.querySelector('input[name="column"]').value;
    const form = column.querySelector("form");
    const columnIdInput = form.querySelector('input[name="columnId"]');
    columnIdInput.value = columnId;
    form.style.display = "block";
}


  function validateTask(form) {
    var taskName = form.task_name.value.trim();
    var description = form.description.value.trim();
    var collaboratorEmails = form.collaboratorEmails.value.trim(); // Trim the whole string
    var category = form.category.value.trim();
    var date = form.date.value.trim();

    if (taskName === "") {
        alert("Task name cannot be empty.");
        return false;
    }

    if (description === "") {
        alert("Description cannot be empty.");
        return false;
    }

    // Validate collaborator emails
    var emailRegex = /^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,4}$/;
    var emails = collaboratorEmails.split(',').map(email => email.trim());
    for (var i = 0; i < emails.length; i++) {
        var trimmedEmail = emails[i];
        if (!emailRegex.test(trimmedEmail)) {
            alert("Invalid collaborator email: " + trimmedEmail);
            return false;
        }
    }

    // Update the value of the hidden input field with the validated emails
    form.collaboratorEmailsHidden.value = emails.join(',');

    return true;
}


function deleteColumn(columnID) {
    // Set the column name to be deleted in the hidden input field
    document.getElementById('column_id').value = columnID;
    // Submit the form
    document.getElementById('deleteColumnForm').submit();
}

function handleDrop(ev) {
    ev.preventDefault();

    const data = ev.dataTransfer.getData("text");
    const targetColumn = ev.target.closest(".column");

    if (targetColumn !== null && draggedCard instanceof Node) {
        const cardsContainer = targetColumn.querySelector(".cards");

        if (cardsContainer instanceof Node) {
            cardsContainer.appendChild(draggedCard);

            const taskId = draggedCard.dataset.taskId;
            const newColumnId = targetColumn.dataset.columnId;

            // Set the form values
            const updateForm = targetColumn.querySelector(".update-form");
            const taskIdInput = updateForm.querySelector('input[name="taskId"]');
            const newColumnIdInput = updateForm.querySelector('input[name="newColumnId"]');
            
            taskIdInput.value = taskId;
            newColumnIdInput.value = newColumnId;

            // Submit the form
            const hiddenSubmit = updateForm.querySelector('.hidden-submit');
            hiddenSubmit.click();
        }
    }
}

/*function addMembers() {
    const emailInput = document.getElementById('emailInput');
    const emails = emailInput.value.split(',').map(email => email.trim());
    const boardId = "${boardId}"; // Get the current board's ID from your JSP variable

    // Populate the form inputs
    const boardIdInput = document.getElementById('boardIdInput');
    const emailsInput = document.getElementById('emailsInput');
    boardIdInput.value = boardId;
    emailsInput.value = emails.join(',');

    // Submit the form
    const addMembersForm = document.getElementById('addMembersForm');
    addMembersForm.submit();
}
       function clearInputField() {
    document.getElementById("addListInput").style.display = "none";
        document.getElementById("add-members-input").style.display = "none";

  }*/
  function toggleAddListInput() {
    var addListInput = document.getElementById('addListInput');
    if (addListInput.style.display === 'none') {
      addListInput.style.display = 'block';
    } else {
      addListInput.style.display = 'none';
    }
  }
  function toggleAddMembersInput() {
    const addMembersInput = document.getElementById('add-members-input');
if (addMembersInput.style.display === 'none') {
      addMembersInput.style.display = 'block';
        document.getElementById('error-message').style.display = 'none';
  document.getElementById('success-message').style.display = 'none';
    } else {
      addMembersInput.style.display = 'none';
    }}
  function clearInputField() {
    document.getElementById("addListInput").style.display = "none";
        document.getElementById("add-members-input").style.display = "none";

  }
  function showTaskDetails(taskID) {
    // You can use AJAX to fetch the task details from the server without a page reload
    // For simplicity, I'll assume you already have the details in the variable "taskDetails"
    var taskDetails = "Sample task details for " + taskID;

    // Display the task details in the modal
    var modalContent = document.getElementById("modalContent");
    modalContent.innerHTML = "<h1>Task Details</h1><p>" + taskDetails + "</p>";

    // Show the modal
    var modal = document.getElementById("taskDetailsModal");
    modal.style.display = "block";
  }

  function closeTaskDetailsModal() {
    // Hide the modal
    var modal = document.getElementById("taskDetailsModal");
    modal.style.display = "none";
  }
  
function deleteTask(taskId) {
    // Set the task ID to be deleted in the hidden input field
    document.getElementById('taskId').value = taskId;
    // Submit the form
    document.getElementById('deleteTaskForm').submit();
}

function addMembers() {
    // Get email input and extract emails
    const emailInput = document.getElementById('emailInput');
    const emails = emailInput.value.split(',').map(email => email.trim());

    // Get the current board's ID (replace with actual value)
    const boardId = "${boardId}"; // Get the value from your JSP or provide it here

    // Populate form inputs
    const boardIdInput = document.getElementById('boardIdInput');
    const emailsInput = document.getElementById('emailsInput');
    boardIdInput.value = boardId;
    emailsInput.value = emails.join(',');

    // Submit the form
    const addMembersForm = document.getElementById('addMembersForm');
    addMembersForm.submit();
}

document.addEventListener("DOMContentLoaded", function() {
    const showMembersButton = document.getElementById('showMembersButton');
    const membersModal = document.getElementById('membersModal');
    const closeModal = document.getElementById('closeModal');
    const membersList = document.getElementById('membersList');
    const deleteButtons = document.querySelectorAll('.deleteButton');

    const deleteForms = document.querySelectorAll('.deleteForm'); // Define deleteForms here

    showMembersButton.addEventListener('click', async () => {
        try {
            const response = await fetch('/myapp/show-members2');
            const html = await response.text();

            // Set the content of the modal
            membersList.innerHTML = html;

            // Display the modal
            membersModal.style.display = 'block';
        } catch (error) {
            console.error(error);
        }
    });

    closeModal.addEventListener('click', () => {
        // Close the modal
        membersModal.style.display = 'none';
    });

    window.addEventListener('click', event => {
        if (event.target === membersModal) {
            // Close the modal when clicking outside the content
            membersModal.style.display = 'none';
        }
    });

     deleteButtons.forEach(button => {
        button.addEventListener('click', event => {
            event.preventDefault(); // Prevent the default button behavior
            
            const form = button.closest('.deleteForm'); // Find the closest form element
            if (confirm("Are you sure you want to delete this member?")) {
                form.submit(); // Submit the form
            }
        });
    });
});

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
        }, 5000);
        setTimeout(function() {
            var message4Element = document.querySelector('.message4');
            
            if (message4Element) {
                message4Element.remove();
            }
        }, 5000);
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
    <!-- Top bar -->
    <div class="top-bar">
        <div class="user-profile">
            <div class="user-avatar">${sessionScope.userName.charAt(0)}</div>
            <div class="user-details">
                <p>Welcome, ${sessionScope.userName}</p>

            </div>
        </div>
        <img src="https://i.imgur.com/d08ZjUz.png" class="logo" alt="task master"/>


        <ul class="top-bar-links">

            <li><a href="/myapp/choice"><i class="fas fa-home"></i> Home</a></li>
        <li><a href="/myapp/view-profile"><i class="fas fa-info-circle"></i> Information</a></li>
        <li><a href="/myapp/logout"><i class="fas fa-sign-out-alt"></i> Log Out</a></li>
            <!-- Add more links as needed -->
        </ul>
    </div>
                        <!-- Top bar for the "Add Members" section -->
<div class="top-bar2">

  <!-- <button id="add-members-button" onclick="toggleAddMembersInput()"><i class="fas fa-plus"></i> Add Members</button>
    <div id="add-members-input" style="display: none;">
        <input type="text" id="emailInput" placeholder="Enter email addresses (comma-separated)">
                          <button> <span class="close-icon" onclick="clearInputField()">&#10006;</span></button>

        <button type="button" onclick="addMembers()">Add</button>
    </div>

<form id="addMembersForm" action="/myapp/add-members" method="post" style="display: none;">
    <input type="hidden" id="boardIdInput" name="boardId">
    <input type="hidden" id="emailsInput" name="emails">
</form>-->
    
       <h1 class="welcome">Welcome to: ${boardName}</h1>

<button id="showMembersButton" class ="show">Show Members</button>
<div id="membersModal" class="modal">
    <div class="modal-content">
        <span id="closeModal" style="float: right; cursor: pointer;">&times;</span>
        <h2>Members List</h2>
        <ul id="membersList">
   
        </ul>
    </div>
</div>


</div>
                                <% String message = request.getParameter("message");
           if ("success".equals(message)) { %>
            <div class="message success">member added!</div>
        <% } else if ("error".equals(message)) { %>
            <div class="message error">Failed to insert this memeber. Please try again.</div>
        <% } %>

        <% String message1 = request.getParameter("message1");
           if ("success".equals(message1)) { %>
            <div class="message1 success">member deleted!</div>
        <% } else if ("error".equals(message1)) { %>
            <div class="message1 error">Failed to delete this memeber. Please try again.</div>
        <% } %>

        <% String message4 = request.getParameter("message4");
           if ("success".equals(message4)) { %>
        <% } else if ("error".equals(message4)) { %>
            <div class="message4 error">impossible to add task, email inserted not a member!</div>
        <% } %>

                
   <div class="kanban-container">
      <!-- <p>Members of this board:</p>
<ul>
    <c:forEach items="${mappedEmails}" var="email">
        <li>${email}</li>
    </c:forEach>
</ul>-->

            <c:forEach var="column" items="${columns}">
                <div class="column" data-column-id="${column.id}">
                    <div class="column-header">
                        <h2>${column.name}</h2>
<form id="deleteColumnForm{task.task_id}" action="/myapp/deleteColumn" method="post" onsubmit="return deleteColumn(${column.id})">
                            <button type="submit"><i class="fas fa-trash"></i></button>
                            <input type="hidden" name="task_id" value="${task.task_id}">
<input type="hidden" name="column_id" value="${column.id}">
                        </form>

                    </div> 
                        <form class="update-form" action="/myapp/update-column-name" method="POST">
        <input type="hidden" name="taskId">
        <input type="hidden" name="newColumnId">
        <button type="submit" class="hidden-submit"></button>
    </form>

                    <div class="cards" ondrop="drop(event)" ondragover="allowDrop(event)" >
                        <sql:setDataSource var="db" driver="com.mysql.cj.jdbc.Driver"
                            url="jdbc:mysql://localhost:3306/mysql" user="root" password="" />

                        <sql:query dataSource="${db}" var="columnTasks">
                            SELECT id, task_name FROM tasks WHERE column_id = ?
                            <sql:param value="${column.id}" />
                        </sql:query>

                        <c:forEach var="task" items="${columnTasks.rows}">
                                <div class="card" draggable="true" ondragstart="handleDragStart(event)"data-task-id="${task.id}">
${task.task_name}
                                <!--<form action="/myapp/show-task-details" method="post" target="_blank" > 
                                    <input type="hidden" name="taskID" value="${task.id}">
                                    <button type="submit"><div class="ContainerButtonP" style="text-align: center; color: black; font-size: 13px; font-family: Roboto; font-weight: 700; word-wrap: break-word">···</div></button>
                             </form-->
                                   <form action="/myapp/show-task-details" method="GET">
                                    <input type="hidden" name="taskID" value="${task.id}">
        <input type="submit" value="...">
    </form>
    

                                
                                    <div>
                                        
                                    </div>

 <form id="deleteTaskForm" action="/myapp/delete-task" method="post" onsubmit="deleteTask('${task.id}')">
    <button type="submit"><i class="fas fa-trash"></i></button>
    <input type="hidden" name="taskID" value="${task.id}">
</form>
                            </div>
                        </c:forEach>
                    </div>
 
<button type="button" id="addListButton" onclick="showAddTaskModal('${column.name}', '${column.id}')">Add Task <i class="fas fa-plus"></i></button>
            <div id="addTaskModal" class="modal">
              <!-- Modal content -->
              <div class="modal-content">
                <span class="close" onclick="closeAddTaskModal()">&times;</span>
                <form id="addTaskForm" action="/myapp/add-task2" method="post" onsubmit="return validateTask(this)">
                  <h1 class="welcome-message">New Task</h1>
                  <input type="hidden" id="columnName" name="column" value="">
    <input type="hidden" name="boardId" value="${boardId}">
<input type="hidden" id="columnId" name="columnId" value="">

                  <label for="taskName">Task Name:</label>
                  <input type="text" id="taskName" name="task_name" required>
                  <label for="description">Description: </label>
            <textarea id="description" name="description" rows="4" ></textarea>

                  <label for="collaboratorEmails">Collaborator's email:</label>
    <input type="text" id="collaboratorEmails" name="collaboratorEmails">
    <input type="hidden" id="mappedEmails" name="mappedEmails" value="">
                  <label for="category">Category </label>
                  <input type="text" id="category" name="category">
                  <label for="date">Date </label>
                  <input type="date" id="date" name="date">      
                  <button type="submit">Add Task </button>
                </form>
              </div>
            </div>

            </div>
            </c:forEach>


            <div id="addListContainer">
              <button type="button" id="addListButton" onclick="toggleAddListInput()"><i class="fas fa-plus"></i> Add new list </button>
              <div id="addListInput" style="display: none;">
                <form action="/myapp/add-column" method="post">
                  <input type="text" name="column_name" placeholder="Enter title for this list" required>
                  <button> <span class="close-icon" onclick="clearInputField()">&#10006;</span></button>

                  <button type="submit">Add</button>
                </form>
              </div>
            </div>
    </div>
</body>
</html>
