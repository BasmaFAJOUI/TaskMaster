<!DOCTYPE html>
<html>
<head>
  <title>Login Page</title>
  <style>
    body {
      font-family: Arial, sans-serif;
      text-align: center;
      background-color: #f2f2f2;
      margin: 0;
      padding: 0;
                 background-image: linear-gradient(90deg, rgba(250,252,253,1) 0%, rgba(4,181,249,1) 100%, rgba(0,221,252,1) 100%, rgba(0,224,255,1) 100%);

    }

    h1 {
      margin-top: 15%;
      font-size: 36px;
      color: white;
    }

    h2 {
      font-size: 24px;
      color: #666;
    }

    .button-container {
      display: flex;
      justify-content: center;
      margin-top: 20px;
    }

    .action-button {
      padding: 30px 40px;
      background-color: rgba(255, 255, 255, 0.8);
      color: #333;
      text-decoration: none;
      font-size: 30px;
      border: none;
      border-radius: 90px;
      cursor: pointer;
      margin: 130px;
    }

    .action-button:hover {
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
            <img src="https://i.imgur.com/d08ZjUz.png" class="logo" alt="task master"/>

  <h1>Welcome to Your Space!</h1>
  <h2>What's your plan?</h2>

  <div class="button-container">
    <button class="action-button" onclick="chooseList('personal')">Personal</button>
    <button class="action-button" onclick="chooseList('team')">Team</button>
  </div>

  <script>
    function chooseList(listType) {
      // Implement your logic here based on the user's choice
      // You can perform any required action, like submitting a form or redirecting to another page

      if (listType === 'personal') {
        // User selected Personal List, redirect to personal_list page
        window.location.href = '/myapp/todo_list';
      } else if (listType === 'team') {
        // User selected Team List, redirect to team_choice page
        window.location.href = '/myapp/choice';
      }
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
