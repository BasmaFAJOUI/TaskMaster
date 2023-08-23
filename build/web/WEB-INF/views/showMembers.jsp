<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@page import="java.util.List" %>

<!DOCTYPE html>
<html>
<head>
    <title>Show Members Example</title>
    <style>
        /* Style for the modal */
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
        
        /* Style for modal content */
        .modal-content {
            background-color: #fefefe;
            margin: 15% auto;
            padding: 20px;
            border: 1px solid #888;
            width: 80%;
        }
    </style>
</head>
<body>
    
    <!-- The modal -->
 
 <div class="container">
    <!--<h2>Members List</h2>-->
    <ul id="membersList">
        <li>${sessionScope.userEmail} (you)</li>
        <% List<String> members = (List<String>) request.getAttribute("members");
           for (String email : members) {
               if (!email.equals(session.getAttribute("userEmail"))) { %>
                   <li>
                       <%= email %>
                       <form action="/myapp/delete-member" method="GET" class="deleteForm">
                           <input type="hidden" name="email" value="<%= email %>" />
                           <button type="submit" class="deleteButton">Delete</button>
                       </form>
                   </li>
               <% }
           } %>
    </ul>
</div>


       <script>
document.addEventListener("DOMContentLoaded", function() {
    const showMembersButton = document.getElementById('showMembersButton');
    const membersModal = document.getElementById('membersModal');
    const closeModal = document.getElementById('closeModal');
    const membersList = document.getElementById('membersList');

    const deleteButtons = document.querySelectorAll('.deleteButton');

    showMembersButton.addEventListener('click', async () => {
        try {
            const response = await fetch('/myapp/show-members');
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

    </script>
</body>
</html>
