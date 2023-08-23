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
 
            <!--<h2>Members List</h2>-->
            <ul id="membersList">
                <li>${sessionScope.userEmail} (you)</li>
                <% for (String email : (List<String>) request.getAttribute("members")) { %>
           
                    <li><%= email %></li>
                <% } %>
            </ul>
        </div>
    

    <script>
        const showMembersButton = document.getElementById('showMembersButton');
        const membersModal = document.getElementById('membersModal');
        const closeModal = document.getElementById('closeModal');
        const membersList = document.getElementById('membersList');

        showMembersButton.addEventListener('click', async () => {
            try {
                const response = await fetch('/myapp/show-members');
                const data = await response.json();

                // Clear previous list
                membersList.innerHTML = '';

                // Populate members list
                data.members.forEach(member => {
                    const listItem = document.createElement('li');
                    listItem.textContent = member.email;
                    membersList.appendChild(listItem);
                });

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
    </script>
</body>
</html>
