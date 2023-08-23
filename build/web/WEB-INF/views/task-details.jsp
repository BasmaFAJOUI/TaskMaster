<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!--<!DOCTYPE html>
<html>
<head>
    <title>Task Details</title>
</head>
<body>
    <h1>Task Details</h1>
   <p><strong>Description:</strong> ${task.desc}</p>
    <p><strong>Category:</strong> ${task.category}</p>
    <p><strong>Date:</strong> ${task.date}</p>

    <button class="show" onclick="showTaskDetails('${task.id}', '${task.name}', '${task.desc}', '${task.date}')">Show Task Details</button>

 

    <script>
function showTaskDetails(taskId, taskName, description, date) {
    const taskDetailsModal = document.getElementById("taskDetailsModal");
    const modalContent = document.getElementById("modalContent");

    // Generate the HTML content for task details
    const htmlContent = `
        <h3>${taskName}</h3>
        <p><strong>Description:</strong> ${description}</p>
        <p><strong>Date:</strong> ${date}</p>
    `;

    modalContent.innerHTML = htmlContent;
    taskDetailsModal.style.display = "block";
}

function closeTaskDetailsModal() {
    const taskDetailsModal = document.getElementById("taskDetailsModal");
    taskDetailsModal.style.display = "none";
}
    </script>
</body>
</html>
-->
<!--
<!DOCTYPE html>
<html>
<head>
    <title>Task Details</title>
</head>
<body>
<h1>Task Details</h1>
    <p><strong>Description:</strong> <%= task.getDesc() %></p>
    <p><strong>Category:</strong> <%= task.getCategory() %></p>
    <p><strong>Date:</strong> <%= task.getDate() %></p>

    <!-- Button to show the task details modal 
    <button class="show" onclick="showTaskDetails('${task.getId()}', '${task.getName()}', '${task.getDesc()}', '${task.getDate()}')">Show Task Details</button>

    <!-- Modal for displaying task details 
    <div id="taskDetailsModal" class="modal">
        <div class="modal-content">
            <span class="close" onclick="closeTaskDetailsModal()">&times;</span>
            <h2>Task Details</h2>
            <div id="modalContent"></div>
        </div>
    </div>

    <script>
        function showTaskDetails(taskId, taskName, description, date) {
            const taskDetailsModal = document.getElementById("taskDetailsModal");
            const modalContent = document.getElementById("modalContent");

            // Generate the HTML content for task details
            const htmlContent = `
       
                <h3>${taskName}</h3>
                <p><strong>Description:</strong> ${description}</p>
                <p><strong>Date:</strong> ${date}</p>
            `;

            modalContent.innerHTML = htmlContent;
            taskDetailsModal.style.display = "block";
        }

        function closeTaskDetailsModal() {
            const taskDetailsModal = document.getElementById("taskDetailsModal");
            taskDetailsModal.style.display = "none";
        }
    </script>
</body>
</html>
-->