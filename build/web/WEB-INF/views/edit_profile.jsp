<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Edit Profile</title>
    <style>
body {
    font-family: Arial, sans-serif;
    margin: 0;
    padding: 0;
    display: flex;
    justify-content: center;
    align-items: center;
    height: 100vh;
    background-image: linear-gradient(90deg, rgba(255,255,255,1) 0%, rgba(4,181,249,1) 100%, rgba(46,193,214,1) 100%, rgba(174,204,214,1) 100%);/* Replace "background-image.jpg" with the URL or file path of your desired image */
}

.container {
    background-color: rgba(255, 255, 255, 0.8);
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
   
}
    </style>
</head>
<body>

    <div class="container">
        <h1 class="welcome-message">Edit Profile</h1>
    <form action="/myapp/update-profile" method="post">
        <label for="name">Name:</label>
        <input type="text" id="name" name="name" value="${sessionScope.userName}" required><br>
        <label for="email">Email:</label>
        <input type="email" id="email" name="email" value="${sessionScope.userEmail}" required><br>
        <label for="password">Password:</label>
        <input type="password" id="password" name="password" value="${sessionScope.password}" required><br>
        <button type="submit" class="login-button">Update Profile</button>

    </form>
    </div>
</body>
 
        </div>
    </div>
</body>
</html>

