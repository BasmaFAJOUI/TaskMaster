<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Add Board</title>
    <style>
        body {
    font-family: Arial, sans-serif;
    margin: 0;
    padding: 0;
    display: flex;
    justify-content: center;
    align-items: center;
    height: 100vh;
                background-image: linear-gradient(90deg, rgba(250,252,253,1) 0%, rgba(4,181,249,1) 100%, rgba(0,221,252,1) 100%, rgba(0,224,255,1) 100%);}


.container {
    background-color: rgba(255, 255, 255, 0.8);
    padding: 60px; /* Increased padding to make the form bigger */
    border-radius: 20px; /* Rounded corners to make it appear more 3D */
    box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2); /* Adding a shadow for the 3D effect */
    flex-direction: row;
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

        body {
            font-family: Arial, sans-serif;
            background-color: #f5f5f5;
            margin: 0;
            padding: 0;
        }
        
        .container {
            max-width: 600px;
            margin: 0 auto;
            padding: 20px;
            background-color: #fff;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
        }
        
        h1 {
            color: #333;
            margin-bottom: 20px;
        }
        
        form {
            display: flex;
            flex-direction: column;
        }
        
        label {
            font-weight: bold;
            margin-bottom: 5px;
        }
        
        input {
            padding: 10px;
            margin-bottom: 15px;
            border: 1px solid #ccc;
            border-radius: 4px;
        }
        
        button {
            background-color: #007bff;
            color: #fff;
            padding: 10px 15px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
        }
        
        button:hover {
            background-color: #0056b3;
        }
        .logo {
            position: absolute;
            top: 10px; /* Adjust the top value to position the logo */
            left: 50%; /* Center the logo horizontally */
            transform: translateX(-50%); /* Center the logo using transform */
            width: 250px; /* Adjust the width as needed */
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>Add a New Board</h1>
                <img src="https://i.imgur.com/d08ZjUz.png" class="logo" alt="task master"/>

        <form action="/myapp/create-board" method="POST">
            <label for="boardName">Board Name:</label>
            <input type="text" id="boardName" name="boardName" required>
            <label for="boardDescription">Board Description:</label>
            <input type="text" id="boardDescription" name="boardDescription" required>
            <button type="submit">Create Board</button>
        </form>
    </div>
</body>
</html>
