
 import com.javamaster.model.UsersModel;
 import jakarta.servlet.RequestDispatcher;
 import java.io.IOException;
 import java.io.PrintWriter;
 import jakarta.servlet.ServletException;
 import jakarta.servlet.http.HttpServlet;
 import jakarta.servlet.http.HttpServletRequest;
 import jakarta.servlet.http.HttpServletResponse;
 import jakarta.servlet.annotation.WebServlet;
 import jakarta.servlet.http.HttpSession;
 import java.beans.Statement;
 import java.sql.Connection;
 import java.sql.DriverManager;
 import java.sql.PreparedStatement;
 import java.sql.SQLException;
 //import java.sql.SQLException;
 import java.util.ArrayList;
 import java.util.List;
 import java.util.logging.Level;
 import java.util.logging.Logger;
 import java.sql.ResultSet;
import java.util.Collections;
import java.util.Date;
 import java.util.HashMap;
 import java.util.Map;
 
 
 
 
 /**
  *
  * @author hp
  */
 @WebServlet("/myservlet")
 
 public class myservlet extends HttpServlet {
 
 
     protected void processRequest(HttpServletRequest request, HttpServletResponse response)
             throws ServletException, IOException, ClassNotFoundException, SQLException {
 
        String uri = request.getRequestURI();
         switch (uri) {         
 
             case "/myapp/get-started" ->request.getRequestDispatcher("/WEB-INF/views/login.jsp").forward(request, response);
 
             case "/myapp/no-account"-> request.getRequestDispatcher("/WEB-INF/views/register.jsp").forward(request, response);
             
             case "/myapp/login" ->{ // String method= request.getMethod();
               String email = request.getParameter("email");
         String password = request.getParameter("password");
 
         // Verify if the user exists in the database
         try {
             Class.forName("com.mysql.cj.jdbc.Driver");
             Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/mysql", "root", "");
             System.out.println("connected");
             String sql = "SELECT * FROM users WHERE email = ? AND password = ?";
             PreparedStatement ps = con.prepareStatement(sql);
             ps.setString(1, email);
             ps.setString(2, password);
             ResultSet rs = ps.executeQuery();
 
             if (rs.next()) {

                 String name = rs.getString("name");
                 request.getSession().setAttribute("userName", name);
                 request.getSession().setAttribute("email", email);

                 response.sendRedirect("/myapp/main");
             } else {
                 // User does not exist in the database, show an error message
                 response.setContentType("text/html;charset=UTF-8");
                 response.sendRedirect("/myapp/login?message1=error");// Pass a query parameter to indicate success

             }
 
             // Close the result set, prepared statement, and database connection
             rs.close();
             ps.close();
             con.close();
 
         } catch (Exception ex) {
             Logger.getLogger(myservlet.class.getName()).log(Level.SEVERE, null, ex);
                   response.sendRedirect("/myapp/login?message1=error");// Pass a query parameter to indicate success

}
         
 
         
                 request.getRequestDispatcher("/WEB-INF/views/login.jsp").forward(request, response);}
                    
             
                 case  "/myapp/logout"->{
            // Handle log-out logic here
                         
            HttpSession session = request.getSession(false);
            if (session != null) {
                session.removeAttribute("userId");
                session.invalidate();}
              response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
response.setHeader("Pragma", "no-cache");
response.setHeader("Expires", "0");
                response.setDateHeader("Expires", 0);
                response.setHeader("Location", "/myapp/index");
    response.setStatus(HttpServletResponse.SC_MOVED_TEMPORARILY);
 
                

break  ;          
        }
         case "/myapp/main" ->  {
     // Assuming you have the boardId in a session attribute named "boardId"
     Integer boardIdAttribute = (Integer) request.getSession().getAttribute("boardId");
     if (boardIdAttribute != null) {
         int boardId = boardIdAttribute.intValue();
         List<Column> columns = new ArrayList<>();
         
         try {
             columns = fetchColumnsFromDatabase(boardId); // Pass the boardId to fetchColumnsFromDatabase
         } catch (ClassNotFoundException ex) {
             Logger.getLogger(myservlet.class.getName()).log(Level.SEVERE, null, ex);
         } catch (SQLException ex) {
             Logger.getLogger(myservlet.class.getName()).log(Level.SEVERE, null, ex);
         }
         
         request.setAttribute("columns", columns);
         request.getRequestDispatcher("/WEB-INF/views/main.jsp").forward(request, response);
     }
 }
         case "/myapp/main2" ->  {
     // Assuming you have the boardId in a session attribute named "boardId"
     Integer boardIdAttribute = (Integer) request.getSession().getAttribute("boardId");
     if (boardIdAttribute != null) {
         int boardId = boardIdAttribute.intValue();
         List<Column> columns = new ArrayList<>();
         
         try {
             columns = fetchColumnsFromDatabase(boardId); // Pass the boardId to fetchColumnsFromDatabase
         } catch (ClassNotFoundException ex) {
             Logger.getLogger(myservlet.class.getName()).log(Level.SEVERE, null, ex);
         } catch (SQLException ex) {
             Logger.getLogger(myservlet.class.getName()).log(Level.SEVERE, null, ex);
         }
         
         request.setAttribute("columns", columns);
         request.getRequestDispatcher("/WEB-INF/views/main2.jsp").forward(request, response);
     }
 }
             case "/myapp/register" -> {
                 
                 // Registration functionality
         String email = request.getParameter("email");
         String name = request.getParameter("name");
         String password = request.getParameter("password");
 
         // Insert the user's data into the database
         try {
             Class.forName("com.mysql.cj.jdbc.Driver");
             Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/mysql", "root", "");
             System.out.println("connected");
             String sql = "INSERT INTO users (email, password, name) VALUES (?,?,?)";
             PreparedStatement ps = con.prepareStatement(sql);
             ps.setString(1, email);
             ps.setString(2, password);
             ps.setString(3, name);
             ps.executeUpdate();
 
             // Close the database connection and prepared statement
             ps.close();
             con.close();
 
             // Show a success message or redirect to a different page after successful registration
             response.setContentType("text/html;charset=UTF-8");
try (PrintWriter out = response.getWriter()) {
    out.println("<!DOCTYPE html>");
    out.println("<html>");
    out.println("<head>");
    out.println("<title>Registration Successful</title>");
    
    // Include your CSS styles here
    out.println("<style>");
    out.println("body { font-family: Arial, sans-serif; background-color: #f4f4f4; }");
    out.println(".container { max-width: 400px; margin: 0 auto; padding: 20px; background-color: #fff; border: 1px solid #ccc; border-radius: 5px; box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1); }");
    out.println("h1 { color: #5cb85c; }");
    out.println("p { margin-top: 10px; }");
    out.println("a { color: #337ab7; }");
    out.println("</style>");
    
    out.println("</head>");
    out.println("<body>");
    out.println("<div class=\"container\">");
    out.println("<h1>Registration Successful</h1>");
    out.println("<p>Email: " + email + "</p>");
    out.println("<p>Name: " + name + "</p>");
    out.println("<p><a href=\"/myapp/login\">Go to Login</a></p>");
    out.println("</div>");
    out.println("</body>");
    out.println("</html>");
}
 
         } catch (Exception ex) {
             Logger.getLogger(myservlet.class.getName()).log(Level.SEVERE, null, ex);
             // Handle any exceptions that occur during database operations
             // You can return an error response to the client in case of an error
             // For example, you can display an error page or redirect to the registration form with an error message.
             response.setContentType("text/html;charset=UTF-8");
                           response.sendRedirect("/myapp/register?message2=error");}}// Pass a query parameter to indicate success

         
     
                 
             
             default -> {
               
             }
                 }
 
         }
                    
 protected void doDelete(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String emailToDelete = request.getParameter("email");
        if (emailToDelete != null) {
            // Perform the deletion operation, e.g., using a database query
            try (Connection connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/mysql", "root", "")) {
                String query = "DELETE FROM board_emails WHERE email_address = ?";
                try (PreparedStatement preparedStatement = connection.prepareStatement(query)) {
                    preparedStatement.setString(1, emailToDelete);
                    preparedStatement.executeUpdate();
                    response.setStatus(HttpServletResponse.SC_OK); // Indicate successful deletion
                }
            } catch (SQLException e) {
                e.printStackTrace();
                response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR); // Handle database error
            }
        } else {
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST); // Invalid request
        }
    }






     @Override
    
 protected void doGet(HttpServletRequest request, HttpServletResponse response)
         throws ServletException, IOException {
     
 String uri = request.getRequestURI();
     switch (uri) {
         case  "/myapp/logout"->{
            // Handle log-out logic here
                         
            HttpSession session = request.getSession(false);
            if (session != null) {
                session.removeAttribute("userId");
                session.invalidate();}
              response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
response.setHeader("Pragma", "no-cache");
response.setHeader("Expires", "0");
                response.setDateHeader("Expires", 0);
                response.setHeader("Location", "/myapp/index");
    response.setStatus(HttpServletResponse.SC_MOVED_TEMPORARILY);
 
                

break  ;          
        }
         case "/myapp/show-task-details"->{
            try {
                String taskID = request.getParameter("taskID");

                // Retrieve the task details from your database (you need to implement this method)
                String taskDetails = getTaskDetailsFromDatabase(taskID); // Handle any exceptions that occur during database operations

                // Generate the HTML response with the modal content embedded
                response.setContentType("text/html");
                response.setCharacterEncoding("UTF-8");
                PrintWriter out = response.getWriter();


        out.println("<!DOCTYPE html>");
        out.println("<html>");
        out.println("<head>");
        out.println("<title>Task Details</title>");
        out.println("<style>");
        out.println("body {\n" +
"    font-family: Arial, sans-serif;\n" +
"    margin: 0;\n" +
"    padding: 0;\n" +
"    display: flex;\n" +
"    justify-content: center;\n" +
"    align-items: center;\n" +
"    height: 100vh;\n" +
"    background-image: linear-gradient(90deg, rgba(255,255,255,1) 0%, rgba(4,181,249,1) 100%, rgba(46,193,214,1) 100%, rgba(174,204,214,1) 100%);/* Replace \"background-image.jpg\" with the URL or file path of your desired image */\n" +
"}");
        out.println(".container {\n" +
"    background-color: rgba(255, 255, 255, 0.8);\n" +
"    padding: 60px; /* Increased padding to make the form bigger */\n" +
"    border-radius: 20px; /* Rounded corners to make it appear more 3D */\n" +
"    box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2); /* Adding a shadow for the 3D effect */\n" +
"}");
        out.println(".welcome-message {\n" +
"    font-size: 36px; /* Larger font size for the welcome message */\n" +
"    margin-bottom: 30px; margin-top:20% /* Increased margin for spacing */");
        out.println(".logo {\n" +
"            position: absolute;\n" +
"            top: 10px; /* Adjust the top value to position the logo */\n" +
"            left: 50%; /* Center the logo horizontally */\n" +
"            transform: translateX(-50%); /* Center the logo using transform */\n" +
"            width: 250px; /* Adjust the width as needed */\n" +
"        }");
       
        out.println("</style>");
        out.println("</head>");
        out.println("<body>");
        
        // Modal-triggering button
out.println("<img src=\"https://i.imgur.com/d08ZjUz.png\" class=\"logo\" alt=\"task master\"/>");

        // Modal overlay and JavaScript for modal display
        out.println("<div class=\"container\" id=\"modalOverlay\">");
                out.println("<h1 class=\"welcome-message\">Task Details</h1>");

        out.println("<div class=\"modal-content\">" + taskDetails + "</div>");
        out.println("</div>");

        out.println("<script>");
        out.println("const showModalButton = document.getElementById(\"showModalButton\");");
        out.println("const modalOverlay = document.getElementById(\"modalOverlay\");");
        out.println("showModalButton.addEventListener(\"click\", function() {");
        out.println("modalOverlay.style.display = \"flex\";");
        out.println("});");
        out.println("modalOverlay.addEventListener(\"click\", function(event) {");
        out.println("if (event.target === modalOverlay) {");
        out.println("modalOverlay.style.display = \"none\";");
        out.println("}");
        out.println("});");
        out.println("</script>");
        
        out.println("</body>");
        out.println("</html>");


            } catch (SQLException ex) {
                Logger.getLogger(myservlet.class.getName()).log(Level.SEVERE, null, ex);
                response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Database Error");
            } catch (ClassNotFoundException ex) {
                Logger.getLogger(myservlet.class.getName()).log(Level.SEVERE, null, ex);
                response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Server Configuration Error");
            }
        }
    

case"/myapp/view-profile"-> {
    // Forward the request to the JSP page for viewing profile
    request.getRequestDispatcher("/WEB-INF/views/profile.jsp").forward(request, response);
}

         case "/myapp/todo_list"->{
                  int userId = (int) request.getSession().getAttribute("userId");
              
            List<Tasktodo> tasks = null;
         try {
             tasks = retrieveTasksFromDatabase(userId);
                     Collections.sort(tasks, (task1, task2) -> task2.getDate().compareTo(task1.getDate()));

         } catch (SQLException ex) {
             Logger.getLogger(myservlet.class.getName()).log(Level.SEVERE, null, ex);
         }

        request.setAttribute("tasks", tasks);

        // Forward the request to the JSP page
        request.getRequestDispatcher("/WEB-INF/views/todo_list.jsp").forward(request, response);
    }

         case"/myapp/show-members"->{
             Integer boardId;
         boardId = (Integer) request.getSession().getAttribute("boardId");
                List<String> members = new ArrayList<>();

        try (Connection connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/mysql", "root", "")) {
           /* String query = "SELECT email_address FROM board_emails where board_id=? ";*/
    String query = "SELECT u.email, be.email_address " +
                   "FROM user_board_mapping ubm " +
                   "JOIN users u ON ubm.user_id = u.user_id " +
                   "JOIN board_emails be ON ubm.board_id = be.board_id " +
                   "WHERE ubm.board_id = ?";

           try (PreparedStatement preparedStatement = connection.prepareStatement(query)) {
                                                                 preparedStatement.setInt(1, boardId); // Set the boardId as the second parameter

                try (ResultSet resultSet = preparedStatement.executeQuery()) {
                    while (resultSet.next()) {
                        String email = resultSet.getString("be.email_address");
                        String email2=resultSet.getString("u.email");
                        members.add(email);
                        members.add(email2);

                    }
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
            // Handle database error
        }

        request.setAttribute("members", members);
        request.getRequestDispatcher("/WEB-INF/views/showMembers.jsp").forward(request, response);
    }
                  case"/myapp/show-members2"->{
             Integer boardId;
         boardId = (Integer) request.getSession().getAttribute("boardId");
                List<String> members = new ArrayList<>();

        try (Connection connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/mysql", "root", "")) {
           /* String query = "SELECT email_address FROM board_emails where board_id=? ";*/
    String query = "SELECT u.email, be.email_address " +
                   "FROM user_board_mapping ubm " +
                   "JOIN users u ON ubm.user_id = u.user_id " +
                   "JOIN board_emails be ON ubm.board_id = be.board_id " +
                   "WHERE ubm.board_id = ?";

           try (PreparedStatement preparedStatement = connection.prepareStatement(query)) {
                                                                 preparedStatement.setInt(1, boardId); // Set the boardId as the second parameter

                try (ResultSet resultSet = preparedStatement.executeQuery()) {
                    while (resultSet.next()) {
                        String email = resultSet.getString("be.email_address");
                        String email2=resultSet.getString("u.email");
                        members.add(email);
                        members.add(email2);

                    }
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
            // Handle database error
        }

        request.setAttribute("members", members);
        request.getRequestDispatcher("/WEB-INF/views/showMembers2.jsp").forward(request, response);
    }

case "/myapp/delete-member" -> {
    String emailToDelete = request.getParameter("email");
        if (emailToDelete != null) {
            // Perform the deletion operation, e.g., using a database query
            try (Connection connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/mysql", "root", "")) {
                String query = "DELETE FROM board_emails WHERE email_address = ?";
                try (PreparedStatement preparedStatement = connection.prepareStatement(query)) {
                    preparedStatement.setString(1, emailToDelete);
                    preparedStatement.executeUpdate();
                    response.setStatus(HttpServletResponse.SC_OK); // Indicate successful deletion
                    response.sendRedirect("/myapp/main?message1=success"); // Pass a query parameter to indicate success

                }
            } catch (SQLException e) {
                e.printStackTrace();
                response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR); // Handle database error
                                    response.sendRedirect("/myapp/main?message1=error"); // Pass a query parameter to indicate success

            }
        } else {
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST); // Invalid request
                                response.sendRedirect("/myapp/main?message1=error"); // Pass a query parameter to indicate success

        }
    }

         
         case "/myapp/main" -> {
     Integer boardIdAttribute = (Integer) request.getSession().getAttribute("boardId");
     if (boardIdAttribute != null) {
         int boardId = boardIdAttribute.intValue();
         List<Column> columns = new ArrayList<>();
 
         try {
             columns = fetchColumnsFromDatabase(boardId); // Pass the boardId to fetchColumnsFromDatabase
         } catch (ClassNotFoundException ex) {
             Logger.getLogger(myservlet.class.getName()).log(Level.SEVERE, null, ex);
         } catch (SQLException ex) {
             Logger.getLogger(myservlet.class.getName()).log(Level.SEVERE, null, ex);
         }
 
         request.setAttribute("columns", columns);
         request.getRequestDispatcher("/WEB-INF/views/main.jsp").forward(request, response);
           } else {
         // Handle the case when the boardId attribute is not set in the session
         // For example, redirect the user to the board selection page or display an error message
         response.sendRedirect("/myapp/index"); // Replace with the actual URL of the board selection page
     }}
                  case "/myapp/main2" -> {
     Integer boardIdAttribute = (Integer) request.getSession().getAttribute("boardId");
     if (boardIdAttribute != null) {
         int boardId = boardIdAttribute.intValue();
         List<Column> columns = new ArrayList<>();
 
         try {
             columns = fetchColumnsFromDatabase(boardId); // Pass the boardId to fetchColumnsFromDatabase
         } catch (ClassNotFoundException ex) {
             Logger.getLogger(myservlet.class.getName()).log(Level.SEVERE, null, ex);
         } catch (SQLException ex) {
             Logger.getLogger(myservlet.class.getName()).log(Level.SEVERE, null, ex);
         }
 
         request.setAttribute("columns", columns);
         request.getRequestDispatcher("/WEB-INF/views/main2.jsp").forward(request, response);
           } else {
         // Handle the case when the boardId attribute is not set in the session
         // For example, redirect the user to the board selection page or display an error message
         response.sendRedirect("/myapp/index"); // Replace with the actual URL of the board selection page
     }}
      
 case "/myapp/choice" -> {
      HttpSession session = request.getSession(true);

     int userId = (int) request.getSession().getAttribute("userId");
 
                                     // Store user-specific data in the session
                                     session.setAttribute("userId", userId);
     // Fetch the list of boards associated with the user from your data storage
     try {
        List<Board> boardNames = fetchUserBoardsFromDatabase(userId);
         request.setAttribute("boardNames", boardNames); // Set the attribute here
             List<Board> linkedBoardNames = fetchLinkedBoardsFromDatabase(userId);
        request.setAttribute("linkedBoardNames", linkedBoardNames);
    } catch (ClassNotFoundException ex) {
        Logger.getLogger(myservlet.class.getName()).log(Level.SEVERE, null, ex);
        String errorMessage = "Error: Database driver not found.";
        request.setAttribute("errorMessage", errorMessage);
    } catch (SQLException ex) {
        Logger.getLogger(myservlet.class.getName()).log(Level.SEVERE, null, ex);
        String errorMessage = "Error: Database access error.";
        request.setAttribute("errorMessage", errorMessage);
    }
 
     request.getRequestDispatcher("/WEB-INF/views/choice.jsp").forward(request, response);
 }
/*case "/myapp/choice_todo" -> {
      HttpSession session = request.getSession(true);

     int userId = (int) request.getSession().getAttribute("userId");
 
                                     // Store user-specific data in the session
                                     session.setAttribute("userId", userId);
     // Fetch the list of boards associated with the user from your data storage
     try {
        List<Tasktodo> todos = fetchUsertodoFromDatabase(userId);
         request.setAttribute("todos", todos); // Set the attribute here
    } catch (ClassNotFoundException ex) {
        Logger.getLogger(myservlet.class.getName()).log(Level.SEVERE, null, ex);
        String errorMessage = "Error: Database driver not found.";
        request.setAttribute("errorMessage", errorMessage);
    } catch (SQLException ex) {
        Logger.getLogger(myservlet.class.getName()).log(Level.SEVERE, null, ex);
        String errorMessage = "Error: Database access error.";
        request.setAttribute("errorMessage", errorMessage);
    }
 
     request.getRequestDispatcher("/WEB-INF/views/todo_list.jsp").forward(request, response);
 }*/
 
 case "/myapp/edit-profile" -> request.getRequestDispatcher("/WEB-INF/views/edit_profile.jsp").forward(request, response);
  case "/myapp/edit-profile2" -> request.getRequestDispatcher("/WEB-INF/views/edit_profile2.jsp").forward(request, response);

         case "/myapp/add-board" -> request.getRequestDispatcher("/WEB-INF/views/add_board.jsp").forward(request, response);
 
         case "/myapp/get-started" -> request.getRequestDispatcher("/WEB-INF/views/login.jsp").forward(request, response);

 case "/myapp/view-board" -> {
     String boardIdParam = request.getParameter("boardId");
     String boardNameParam = request.getParameter("boardName");

     if (boardIdParam != null) {
         int boardId = Integer.parseInt(boardIdParam);
                 String boardName = boardNameParam;

         // Store the boardId in the session
         request.getSession().setAttribute("boardId", boardId);
          request.getSession().setAttribute("boardName", boardName);

         // Redirect to the main page
         response.sendRedirect("/myapp/main");
     } else {
         // Handle the case when boardIdParam is missing or invalid
         // For example, redirect the user to an error page or display an error message
         response.sendRedirect("/myapp/error"); // Replace with the actual URL of the error page
     }
 }
  case "/myapp/view-board2" -> {
     String boardIdParam = request.getParameter("boardId");
     String boardNameParam = request.getParameter("boardName");

     if (boardIdParam != null) {
         int boardId = Integer.parseInt(boardIdParam);
                 String boardName = boardNameParam;

         // Store the boardId in the session
         request.getSession().setAttribute("boardId", boardId);
          request.getSession().setAttribute("boardName", boardName);

         // Redirect to the main page
         response.sendRedirect("/myapp/main2");
     } else {
         // Handle the case when boardIdParam is missing or invalid
         // For example, redirect the user to an error page or display an error message
         response.sendRedirect("/myapp/error"); // Replace with the actual URL of the error page
     }
 }
 
         case "/myapp/no-account" -> request.getRequestDispatcher("/WEB-INF/views/register.jsp").forward(request, response);
         case "/myapp/personal_or_team" -> {
                               int userId = (int) request.getSession().getAttribute("userId");

         
             request.getRequestDispatcher("/WEB-INF/views/personal_or_team.jsp").forward(request, response);

     }
 
         default -> // If no specific URL matches, redirect to the main page
                 request.getRequestDispatcher("/WEB-INF/views/index.jsp").forward(request, response);
     }
         // Handle the "View Profile" button click in your servlet
                          // Add other cases for different URLs if needed
         }
 
 
 
 @Override
 protected void doPost(HttpServletRequest request, HttpServletResponse response)
         throws ServletException, IOException {
         String uri = request.getRequestURI();
         if (uri.equals("/myapp/get-emails") && request.getMethod().equals("POST")) {
    try {
        String boardId = request.getParameter("boardId");
        List<String> emails = getEmailsByBoardId(boardId);
        
        // Prepare the response
        StringBuilder responseContent = new StringBuilder();
        for (String email : emails) {
            responseContent.append(email).append(",");
        }
        if (responseContent.length() > 0) {
            responseContent.deleteCharAt(responseContent.length() - 1); // Remove the trailing comma
        }
        
        response.setContentType("text/plain");
        response.setCharacterEncoding("UTF-8");
        response.getWriter().write(responseContent.toString());
    } catch (Exception ex) {
        response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
        ex.printStackTrace();
    }
}
        if (uri.equals("/myapp/add-members") && request.getMethod().equals("POST")) {
    try {
        String boardId = request.getParameter("boardId");
        String emailsParam = request.getParameter("emails");
        String[] emails = emailsParam.split(",");
        
        // Insert email addresses and board ID into the email_boards table
        for (String email : emails) {

            int userId = getUserIdByEmail(email);
                            if (!isEmailAlreadyInBoard(email, boardId) && isUserValid(email)) {
            insertEmailBoardMapping(email, boardId, userId);
            
            // Redirect back to the main page or wherever needed
                    response.setStatus(HttpServletResponse.SC_OK);

response.sendRedirect("/myapp/main?message=success"); // Pass a query parameter to indicate success
        } else {
            // Email is not a valid user, show an error message
response.sendRedirect("/myapp/main?message=error"); // Pass a query parameter to indicate success
            response.sendRedirect("/myapp/main");
        } }}   
             catch (Exception ex) {
        // Handle any exceptions that occur during the addition process
        response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
        ex.printStackTrace();
    }
}
  if (uri.equals("/myapp/delete-task")) {
    try {
        int taskId = Integer.parseInt(request.getParameter("taskID"));
        //int columnId = Integer.parseInt(request.getParameter("column_id"));
        deleteTaskFromDatabase(taskId);
        response.sendRedirect("/myapp/main");
        // Return a success response to the front-end
        response.setStatus(HttpServletResponse.SC_OK);
    } catch (NumberFormatException | ClassNotFoundException ex) {
        // Handle any exceptions that occur during the deletion process
        response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
        ex.printStackTrace();
    }        catch (SQLException ex) {
                 Logger.getLogger(myservlet.class.getName()).log(Level.SEVERE, null, ex);
             }
}




         if ( uri.equals("/myapp/deleteColumn")) {
String columnID = request.getParameter("column_id");
             // Call a method to delete the column from your database (you need to implement this method)
             try {
                 deleteColumnFromDatabase(columnID);
                 // Return a success response to the front-end
                 response.sendRedirect("/myapp/main");
 
                 response.setStatus(HttpServletResponse.SC_OK);
             } catch (SQLException | ClassNotFoundException ex) {
                 // Handle any exceptions that occur during the deletion process
                 response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
             }
 
         } 
         else {
 
             if (uri.equals("/myapp/choice")) {
     int userId = (int) request.getSession().getAttribute("userId");
 
     // Fetch the list of boards associated with the user from your data storage
     try {
         List<Board> boardNames = fetchUserBoardsFromDatabase(userId);
 request.setAttribute("boardNames", boardNames);
 
     } catch (ClassNotFoundException ex) {
         Logger.getLogger(myservlet.class.getName()).log(Level.SEVERE, null, ex);
         String errorMessage = "Error: Database driver not found.";
         request.setAttribute("errorMessage", errorMessage);
         request.getRequestDispatcher("/WEB-INF/views/choice.jsp").forward(request, response);
     } catch (SQLException ex) {
         Logger.getLogger(myservlet.class.getName()).log(Level.SEVERE, null, ex);
         String errorMessage = "Error: Database access error.";
         request.setAttribute("errorMessage", errorMessage);
         request.getRequestDispatcher("/WEB-INF/views/choice.jsp").forward(request, response);
     }
 
     request.getRequestDispatcher("/WEB-INF/views/choice.jsp").forward(request, response);
 }
 
 
             else {
 
                 switch (uri) {
                     case "/myapp/view_board"->{
                         {
                          String boardIdParam = request.getParameter("boardId");
     if (boardIdParam == null || boardIdParam.isEmpty()) {
         // boardId parameter is missing or empty, handle the error here
         response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Board ID is missing or invalid");
         return;
     }
 
     try {
         int boardId = Integer.parseInt(boardIdParam);
         int userId = (int) request.getSession().getAttribute("userId");
 
         // Fetch the selected board details (columns and tasks) from your data storage
         Map<String, Object> boardDetails = fetchBoardDetailsFromDatabase(boardId, userId);
                request.setAttribute("boardDetails", boardDetails);
         request.getRequestDispatcher("/WEB-INF/views/view-board.jsp").forward(request, response);
 
         
         if (boardDetails == null) {
             // Board not found or user doesn't have access to this board
             response.sendRedirect("/myapp/choice"); // Redirect back to the choice page
             return;
         }
 
         // Set the boardDetails as an attribute in the request
 
         // Forward the request to the view-board.jsp page
     } catch (NumberFormatException e) {
         // Handle the case where boardIdParam cannot be parsed as an integer
         response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid Board ID format");
     }
                         }}
 
                     
                     case "/myapp/login" ->                     {
                             // Login functionality
                             String email = request.getParameter("email");
                             String password = request.getParameter("password");
                             // Verify if the user exists in the database
                             try {
                                 Class.forName("com.mysql.cj.jdbc.Driver");
                                 Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/mysql", "root", "");
                                 System.out.println("connected");
                                 String sql = "SELECT * FROM users WHERE email = ? AND password = ?";
                                 PreparedStatement ps = con.prepareStatement(sql);
                                 ps.setString(1, email);
                                 ps.setString(2, password);
                                 ResultSet rs = ps.executeQuery();
                                 if (rs.next()) {
                                     // User exists in the database, create a session for the user
                                     int userId = rs.getInt("user_id");
                                     String name = rs.getString("name");
 
                                     // Get the existing session or create a new one if it doesn't exist
                                     HttpSession session = request.getSession(true);
 
                                     // Store user-specific data in the session
                                     session.setAttribute("userId", userId);
                                     session.setAttribute("userName", name);
session.setAttribute("userEmail", email); // Use "userEmail" attribute name
                                     session.setAttribute("password", password);


 
                                     // Redirect the user to the main page
                                     //response.sendRedirect("/myapp/choice");
                                      response.sendRedirect("/myapp/personal_or_team");

                                 } else {
                                     // User does not exist in the database, show an error message
                                     response.setContentType("text/html;charset=UTF-8");
                                                        response.sendRedirect("/myapp/login?message1=error");// Pass a query parameter to indicate success


                                 }
 
                                 // Close the result set, prepared statement, and database connection
                                 rs.close();
                                 ps.close();
                                 con.close();
 
                             } catch (Exception ex) {
                                 Logger.getLogger(myservlet.class.getName()).log(Level.SEVERE, null, ex);
                                 // Handle any exceptions that occur during database operations
                                 // You can return an error response to the client in case of an error
                                 // For example, you can display an error page or redirect to the login form with an error message.
                                 response.setContentType("text/html;charset=UTF-8");
                                                        response.sendRedirect("/myapp/login?message1=error");// Pass a query parameter to indicate success

                             }                                  }
                     
                     case "/myapp/personal_or_team" -> request.getRequestDispatcher("/WEB-INF/views/personal_or_team.jsp").forward(request, response);

                     case "/myapp/create-board" -> {
                         Integer userIdAttribute = (Integer) request.getSession().getAttribute("userId");
                         if (userIdAttribute != null) {
                             int userId = userIdAttribute.intValue();
 
                             // Get the board name and description from the form
                             String boardName =request.getParameter("boardName");
                             String boardDescription = request.getParameter("boardDescription");
 
 
 
                             // Insert the new board into the kanban_boards table
                             try {
                                 Class.forName("com.mysql.cj.jdbc.Driver");
                                 Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/mysql", "root", "");
                                 String insertBoardSQL = "INSERT INTO kanban_boards (board_name, description) VALUES (?, ?)";
                                 PreparedStatement ps = con.prepareStatement(insertBoardSQL, PreparedStatement.RETURN_GENERATED_KEYS);
                                 ps.setString(1, boardName);
                                 ps.setString(2, boardDescription);
                                 ps.executeUpdate();
 
                                 // Get the generated boardId
                                 int boardId = -1;
                                 ResultSet generatedKeys = ps.getGeneratedKeys();
                                 if (generatedKeys.next()) {
                                     boardId = generatedKeys.getInt(1);
                                     System.out.println("Generated boardId: " + boardId);
                                 } else {
                                     System.out.println("Failed to retrieve generated boardId.");
                                 }
 
                                 // Close the database connection and prepared statement
                                 ps.close();
                                 con.close();
 
                                 // Insert a record into the user_board_mapping table to associate the user with the new board
                                 con = DriverManager.getConnection("jdbc:mysql://localhost:3306/mysql", "root", "");
                                 String insertMappingSQL = "INSERT INTO user_board_mapping (user_id, board_id) VALUES (?, ?)";
                                 PreparedStatement insertMappingStatement = con.prepareStatement(insertMappingSQL);
                                 insertMappingStatement.setInt(1, userId);
                                 insertMappingStatement.setInt(2, boardId);
                                 int rowsAffected = insertMappingStatement.executeUpdate();
 
                                 // Close the database connection and prepared statement
                                 insertMappingStatement.close();
                                 con.close();
 
                                 // Check the number of affected rows
                                                             System.out.println("Rows affected in user_board_mapping: " + rowsAffected);
                                 // Assuming you have the boardId value available after the user selects a board
 
                                 // Set the boardId attribute in the session
                                 request.getSession().setAttribute("boardId", boardId);
 
                                 // Redirect the user to the dashboard page to show their new board
                                 response.sendRedirect("/myapp/main"); // Replace "/myapp/dashboard" with the actual URL of the dashboard page
                                                         } catch (IOException | ClassNotFoundException | SQLException ex) {
 
                                                             // Write the error message in an HTML format to the response
                                                             response.setContentType("text/html");
                                                             response.getWriter().write("<h1>Error Encountered</h1>");
                                                             response.getWriter().write("<p>An error occurred while creating the board:</p>");
                                                             response.getWriter().write("<p>" + ex.getMessage() + "</p>");
                                                             response.getWriter().write("<p>Please contact the administrator for assistance.</p>");
                                                         } }
                     }
                     case "/myapp/add-task_todo" -> {
                         HttpSession session = request.getSession(true);

     int userId = (int) request.getSession().getAttribute("userId");
 
                                     // Store user-specific data in the session
                                     session.setAttribute("userId", userId);
         String taskNametodo = request.getParameter("taskNametodo");
        String descriptiontodo = request.getParameter("descriptiontodo");
     String datetodo = request.getParameter("datetodo");
        // Other form parameters like due date can be similarly retrieved
        
        // Database connection details
        String jdbcUrl = "jdbc:mysql://localhost:3306/mysql";
        String dbUser = "root";
        String dbPassword = "";

        try {
    Connection connection = DriverManager.getConnection(jdbcUrl, dbUser, dbPassword);
    String sql = "INSERT INTO list_tasks (task_name, user_id, description, due_date) VALUES (?, ?, ?, ?)";
    PreparedStatement preparedStatement = connection.prepareStatement(sql);
    preparedStatement.setString(1, taskNametodo);
    preparedStatement.setInt(2, userId);
    preparedStatement.setString(3, descriptiontodo);
    preparedStatement.setString(4, datetodo);

    int rowsAffected = preparedStatement.executeUpdate();
    if (rowsAffected > 0) {
        response.sendRedirect("/myapp/todo_list"); // Replace "/myapp/dashboard" with the actual URL of the dashboard page

        response.getWriter().println("Task added successfully!");
    } else {
        response.getWriter().println("Failed to add task.");
    }

    preparedStatement.close();
    connection.close();
} catch (SQLException e) {
    e.printStackTrace();
    response.getWriter().println("Error: " + e.getMessage());
}}

                     case "/myapp/register" ->                     {
                             // Registration functionality
                             String email = request.getParameter("email");
                             String name = request.getParameter("name");
                             String password = request.getParameter("password");
                             String password2 = request.getParameter("password2");
                             // Password validation (check if password and confirmation match)
                             if (!password.equals(password2)) {
                                 // Handle password mismatch error and redirect to the registration form with an error message
                                       response.sendRedirect("/myapp/index?message3=error");// Pass a query parameter to indicate success

                                 return;
                             }                       try {
                                 Class.forName("com.mysql.cj.jdbc.Driver");
                                 Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/mysql", "root", "");
                                 System.out.println("connected");
 
                                 String checkEmailSQL = "SELECT COUNT(*) FROM users WHERE email=?";
                                 try (PreparedStatement checkEmailStatement = con.prepareStatement(checkEmailSQL)) {
                                     checkEmailStatement.setString(1, email);
                                     ResultSet resultSet = checkEmailStatement.executeQuery();
                                     resultSet.next();
                                     int emailCount = resultSet.getInt(1);
                                     if (emailCount > 0) {
                                         // If the email already exists, forward to the error page
                                                     response.sendRedirect("/myapp/index?message2=error");// Pass a query parameter to indicate success
                                         return;
                                     }
                                 } catch (SQLException ex) {
                                     Logger.getLogger(myservlet.class.getName()).log(Level.SEVERE, null, ex);
                                 }
 
 
                                 // Insert the new user's data into the database
                                 String sql = "INSERT INTO users (email, password, name) VALUES (?,?,?)";
                                 int userId = 0;
                                 ResultSet generatedKeys;
                                 try (PreparedStatement ps = con.prepareStatement(sql, PreparedStatement.RETURN_GENERATED_KEYS)) {
                                     ps.setString(1, email);
                                     ps.setString(2, password);
                                     ps.setString(3, name);
                                     ps.executeUpdate();
                                     // Get the generated userId from the PreparedStatement
                                     userId = -1;
                                     generatedKeys = ps.getGeneratedKeys();
                                     if (generatedKeys.next()) {
                                         userId = generatedKeys.getInt(1);
                                         System.out.println("Generated userId: " + userId);
                                     } else {
                                         System.out.println("Failed to retrieve generated userId.");
                                     }
                                     // Close the database connection and prepared statement
                                 } catch (SQLException ex) {
                                     Logger.getLogger(myservlet.class.getName()).log(Level.SEVERE, null, ex);
                                 }
                                 con.close();
 
                                 // Show a success message or redirect to a different page after successful registration
                                 response.setContentType("text/html;charset=UTF-8");
                                 response.sendRedirect("/myapp/index?message2=success"); // Pass a query parameter to indicate success

 
                             } catch (Exception ex) {
                                                     response.sendRedirect("/myapp/index?message2=error");}}// Pass a query parameter to indicate success

                     default -> {
                     


if (uri.equals("/myapp/mark-completed")){
       int taskId = Integer.parseInt(request.getParameter("taskId"));

        // Database connection details
        String jdbcUrl = "jdbc:mysql://localhost:3306/mysql";
        String dbUser = "root";
        String dbPassword = "";

        try (Connection connection = DriverManager.getConnection(jdbcUrl, dbUser, dbPassword)) {
            String sql = "UPDATE list_tasks SET is_completed = ? WHERE task_id = ?";
            try (PreparedStatement preparedStatement = connection.prepareStatement(sql)) {
                // Set the new completion status and taskId in the prepared statement
                preparedStatement.setBoolean(1, true); // Set to true to mark as completed
                preparedStatement.setInt(2, taskId);

                int rowsAffected = preparedStatement.executeUpdate();
                if (rowsAffected > 0) {
                    // Update successful
                            response.sendRedirect("/myapp/todo_list"); // Replace "/myapp/dashboard" with the actual URL of the dashboard page

                } else {
                    // Update failed
                    response.getWriter().println("Failed to mark task as completed.");
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
            response.getWriter().println("Error: " + e.getMessage());
        }
    }
// Handle the "Edit Profile" button click in your servlet
if (uri.equals("/myapp/update-profile")) {
     int userId = (int) request.getSession().getAttribute("userId");
 HttpSession session = request.getSession();
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String password = request.getParameter("password");

        boolean updated = updateUserProfile(userId, name, email, password);

        if (updated) {
            // Update session attributes
            session.setAttribute("userName", name);
            session.setAttribute("userEmail", email);
            session.setAttribute("password", password);

            // Redirect to profile page
response.sendRedirect("/myapp/choice?message=success"); // Pass a query parameter to indicate success
        } else {
            // Handle update failure
    response.sendRedirect("/myapp/choice?message=error"); // Pass a query parameter to indicate error
    }}

if (uri.equals("/myapp/update-profile2")) {
     int userId = (int) request.getSession().getAttribute("userId");
 HttpSession session = request.getSession();
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String password = request.getParameter("password");

        boolean updated = updateUserProfile(userId, name, email, password);

        if (updated) {
            // Update session attributes
            session.setAttribute("userName", name);
            session.setAttribute("userEmail", email);
            session.setAttribute("password", password);

            // Redirect to profile page
response.sendRedirect("/myapp/todo_list?message=success"); // Pass a query parameter to indicate success
        } else {
            // Handle update failure
    response.sendRedirect("/myapp/todo_list?message=error"); // Pass a query parameter to indicate error
    }}





if (uri.equals("/myapp/add-task")) {
    int boardId = Integer.parseInt(request.getParameter("boardId"));
    List<String> mappedEmails = null; // Initialize the list

    try {
        // Retrieve mapped emails directly within the main servlet
        mappedEmails = getMappedUserEmailsForBoard(boardId);
    } catch (SQLException ex) {
        Logger.getLogger(myservlet.class.getName()).log(Level.SEVERE, null, ex);
    } catch (ClassNotFoundException ex) {
        Logger.getLogger(myservlet.class.getName()).log(Level.SEVERE, null, ex);
    }
    
    String columnName = request.getParameter("column");
    String taskName = request.getParameter("task_name");
    String description = request.getParameter("description");
    String collaboratorEmails = request.getParameter("collaboratorEmails");
    String category = request.getParameter("category");
    String date = request.getParameter("date");
    int columnId = Integer.parseInt(request.getParameter("columnId"));

    String[] emailArray = collaboratorEmails.split(",");
    List<String> addedCollaborators = new ArrayList<>();
    List<String> nonMemberEmails = new ArrayList<>();

    for (String email : emailArray) {
        String trimmedEmail = email.trim();

        if (mappedEmails.contains(trimmedEmail)) {
            addedCollaborators.add(trimmedEmail);
        } else {
            nonMemberEmails.add(trimmedEmail);
        }
    }

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        try (Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/mysql", "root", "")) {
                if (!nonMemberEmails.isEmpty()) {
                    
     
        // Construct an error message for non-member emails
        String errorMessage = "The following emails are not members of this board: " + String.join(", ", nonMemberEmails);
        request.setAttribute("errorMessage", errorMessage);
                    response.sendRedirect("/myapp/main?message4=error"); // Pass a query parameter to indicate error
}
                else{
            String sql = "INSERT INTO tasks (board_id, column_id, column_name, task_name, description, mails, category, date) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
            try (PreparedStatement ps = con.prepareStatement(sql, PreparedStatement.RETURN_GENERATED_KEYS)) {
                ps.setInt(1, boardId);
                ps.setInt(2, columnId);
                ps.setString(3, columnName);
                ps.setString(4, taskName);
                ps.setString(5, description);
                ps.setString(6, String.join(",", addedCollaborators)); // Store only added collaborators
                ps.setString(7, category);
                ps.setString(8, date);
                ps.executeUpdate();

                try (ResultSet generatedKeys = ps.getGeneratedKeys()) {
                    if (generatedKeys.next()) {
                        int taskId = generatedKeys.getInt(1);
                        // Now you can use the taskId as the unique identifier for the task
                    }
                }
            }
        

       String successMessage = "Added the task with the following collaborators: " + String.join(", ", addedCollaborators);
        request.setAttribute("successMessage", successMessage);
    
        response.sendRedirect("/myapp/main");}}
    } catch (ClassNotFoundException | SQLException ex) {
        ex.printStackTrace();
        response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
    }
}

 if (uri.equals("/myapp/add-task2")) {
    int boardId = Integer.parseInt(request.getParameter("boardId"));
    List<String> mappedEmails = null; // Initialize the list

    try {
        // Retrieve mapped emails directly within the main servlet
        mappedEmails = getMappedUserEmailsForBoard(boardId);
    } catch (SQLException ex) {
        Logger.getLogger(myservlet.class.getName()).log(Level.SEVERE, null, ex);
    } catch (ClassNotFoundException ex) {
        Logger.getLogger(myservlet.class.getName()).log(Level.SEVERE, null, ex);
    }
    
    String columnName = request.getParameter("column");
    String taskName = request.getParameter("task_name");
    String description = request.getParameter("description");
    String collaboratorEmails = request.getParameter("collaboratorEmails");
    String category = request.getParameter("category");
    String date = request.getParameter("date");
    int columnId = Integer.parseInt(request.getParameter("columnId"));

    String[] emailArray = collaboratorEmails.split(",");
    List<String> addedCollaborators = new ArrayList<>();
    List<String> nonMemberEmails = new ArrayList<>();

    for (String email : emailArray) {
        String trimmedEmail = email.trim();

        if (mappedEmails.contains(trimmedEmail)) {
            addedCollaborators.add(trimmedEmail);
        } else {
            nonMemberEmails.add(trimmedEmail);
        }
    }

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        try (Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/mysql", "root", "")) {
                if (!nonMemberEmails.isEmpty()) {
                    
     
        // Construct an error message for non-member emails
        String errorMessage = "The following emails are not members of this board: " + String.join(", ", nonMemberEmails);
        request.setAttribute("errorMessage", errorMessage);
                    response.sendRedirect("/myapp/main2?message4=error"); // Pass a query parameter to indicate error
}
                else{
            String sql = "INSERT INTO tasks (board_id, column_id, column_name, task_name, description, mails, category, date) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
            try (PreparedStatement ps = con.prepareStatement(sql, PreparedStatement.RETURN_GENERATED_KEYS)) {
                ps.setInt(1, boardId);
                ps.setInt(2, columnId);
                ps.setString(3, columnName);
                ps.setString(4, taskName);
                ps.setString(5, description);
                ps.setString(6, String.join(",", addedCollaborators)); // Store only added collaborators
                ps.setString(7, category);
                ps.setString(8, date);
                ps.executeUpdate();

                try (ResultSet generatedKeys = ps.getGeneratedKeys()) {
                    if (generatedKeys.next()) {
                        int taskId = generatedKeys.getInt(1);
                        // Now you can use the taskId as the unique identifier for the task
                    }
                }
            }
        

       String successMessage = "Added the task with the following collaborators: " + String.join(", ", addedCollaborators);
        request.setAttribute("successMessage", successMessage);
    
        response.sendRedirect("/myapp/main");}}
    } catch (ClassNotFoundException | SQLException ex) {
        ex.printStackTrace();
        response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
    }
}

 
 else{
       if (uri.equals("/myapp/delete-tasktodo")) {
           String taskIdParam = request.getParameter("taskId");

        if (taskIdParam != null && !taskIdParam.isEmpty()) {
            int taskId = Integer.parseInt(taskIdParam);

            String jdbcUrl = "jdbc:mysql://localhost:3306/mysql";
            String dbUser = "root";
            String dbPassword = "";

            try (Connection connection = DriverManager.getConnection(jdbcUrl, dbUser, dbPassword)) {
                String sql = "DELETE FROM list_tasks WHERE task_id = ?";
                try (PreparedStatement preparedStatement = connection.prepareStatement(sql)) {
                    preparedStatement.setInt(1, taskId);

                    int rowsAffected = preparedStatement.executeUpdate();
                    if (rowsAffected > 0) {
                        // Deletion successful
                        response.sendRedirect("/myapp/todo_list?message1=deleted");
                    } else {
                        // Deletion failed
                        response.sendRedirect("/myapp/todo_list?message1=error");
                    }
                }
            } catch (SQLException e) {
                e.printStackTrace();
                response.sendRedirect("/myapp/todo_list?message1=error");
            }
        } else {
            // Handle the case when taskIdParam is empty or null
            response.sendRedirect("/myapp/todo_list?message1=error");
        }
    }
                             if (uri.equals("/myapp/update-column-name")){
                                   try {
            int taskId = Integer.parseInt(request.getParameter("taskId"));
            int newColumnId = Integer.parseInt(request.getParameter("newColumnId"));

            // Update the column_id in the tasks table based on the taskId
            updateColumnIdInDatabase(taskId, newColumnId);

            // Redirect back to the main page or wherever needed
            response.sendRedirect("/myapp/main");
        } catch (Exception e) {
            // Handle errors and return an appropriate response
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
        }
    }

if (uri.equals("/myapp/show-task-details")) {
    try {
        String taskID = request.getParameter("taskID");

        // Retrieve the task details from your database (you need to implement this method)
        String taskDetails = getTaskDetailsFromDatabase(taskID); // Handle any exceptions that occur during database operations

        // Generate the HTML response with the modal content embedded
        response.setContentType("text/html");
        response.setCharacterEncoding("UTF-8");
        PrintWriter out = response.getWriter();

        out.println("<!DOCTYPE html>");
        out.println("<html>");
        out.println("<head>");
        out.println("<title>Task Details</title>");
        out.println("<style>");
        out.println("body {\n" +
"    font-family: Arial, sans-serif;\n" +
"    margin: 0;\n" +
"    padding: 0;\n" +
"    display: flex;\n" +
"    justify-content: center;\n" +
"    align-items: center;\n" +
"    height: 100vh;\n" +
"    background-image: linear-gradient(90deg, rgba(255,255,255,1) 0%, rgba(4,181,249,1) 100%, rgba(46,193,214,1) 100%, rgba(174,204,214,1) 100%);/* Replace \"background-image.jpg\" with the URL or file path of your desired image */\n" +
"}");
        out.println(".container {\n" +
"    background-color: rgba(255, 255, 255, 0.8);\n" +
"    padding: 60px; /* Increased padding to make the form bigger */\n" +
"    border-radius: 20px; /* Rounded corners to make it appear more 3D */\n" +
"    box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2); /* Adding a shadow for the 3D effect */\n" +
"}");
        out.println(".welcome-message {\n" +
"    font-size: 36px; /* Larger font size for the welcome message */\n" +
"    margin-bottom: 30px; /* Increased margin for spacing */");
        out.println(".modal-content { background-color: #fff; border: 1px solid #ccc; padding: 20px; width: 80%; max-width: 600px; text-align: center; }");
        out.println("</style>");
        out.println("</head>");
        out.println("<body>");
        out.println("<h1>Task Details</h1>");
        
        // Modal-triggering button

        // Modal overlay and JavaScript for modal display
        out.println("<div class=\"container\" id=\"modalOverlay\">");
        out.println("<div class=\"modal-content\">" + taskDetails + "</div>");
        out.println("</div>");

        out.println("<script>");
        out.println("const showModalButton = document.getElementById(\"showModalButton\");");
        out.println("const modalOverlay = document.getElementById(\"modalOverlay\");");
        out.println("showModalButton.addEventListener(\"click\", function() {");
        out.println("modalOverlay.style.display = \"flex\";");
        out.println("});");
        out.println("modalOverlay.addEventListener(\"click\", function(event) {");
        out.println("if (event.target === modalOverlay) {");
        out.println("modalOverlay.style.display = \"none\";");
        out.println("}");
        out.println("});");
        out.println("</script>");
        
        out.println("</body>");
        out.println("</html>");

    } catch (SQLException ex) {
        Logger.getLogger(myservlet.class.getName()).log(Level.SEVERE, null, ex);
    } catch (ClassNotFoundException ex) {
        Logger.getLogger(myservlet.class.getName()).log(Level.SEVERE, null, ex);
    }
}
/*if (uri.equals("/myapp/show-task-details")) {
    try {
        String taskID = request.getParameter("taskID");

        // Retrieve the task details from your database
        Task task = getTaskDetailsFromDatabase(taskID);

        if (task != null) {
            request.setAttribute("task", task); // Set the task as an attribute
         request.getRequestDispatcher("/WEB-INF/views/main.jsp").forward(request, response);
        } else {
            response.sendError(HttpServletResponse.SC_NOT_FOUND, "Task not found");
        }
    } catch (SQLException ex) {
        Logger.getLogger(myservlet.class.getName()).log(Level.SEVERE, null, ex);
    } catch (ClassNotFoundException ex) {
        Logger.getLogger(myservlet.class.getName()).log(Level.SEVERE, null, ex);
    }
}*/
                             if (uri.equals("/myapp/add-column")) {
                                 // Adding a new column functionality
                                 String columnName = request.getParameter("column_name");
 
                                 // Perform the logic to add the new column to your data storage (e.g., database, list, etc.)
                                 try {
                                     // Your database connection and insertion logic here
                                     // For example, using JDBC to insert the new column into the database
 
                                     Class.forName("com.mysql.cj.jdbc.Driver");
                                     try (Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/mysql", "root", "")) {
                                         System.out.println("connected");
                                         // Assuming you have the boardId value available (e.g., stored in a session attribute as "boardId")
                                         Integer boardIdAttribute = (Integer) request.getSession().getAttribute("boardId");
                                         if (boardIdAttribute != null) {
                                             int boardId = boardIdAttribute.intValue();
                                             String sql = "INSERT INTO columns (name, board_id) VALUES (?, ?)";
                                             try (PreparedStatement ps = con.prepareStatement(sql)) {
                                                 ps.setString(1, columnName);
                                                 ps.setInt(2, boardId); // Set the boardId as the second parameter
                                                 ps.executeUpdate();
                                                 // Close the database connection and prepared statement
                                             }
                                             con.close();
                                             response.sendRedirect("/myapp/main");
 
                                             // Send a success response back to the frontend
                                             response.setStatus(HttpServletResponse.SC_OK);
                                         } else {
                                             // Handle the case when the boardId attribute is not set in the session
                                             // For example, redirect the user to the board selection page or display an error message
                                             response.sendRedirect("/myapp/select-board"); // Replace with the actual URL of the board selection page
 
                                             // Optionally, you can set an error status to notify the frontend about the missing boardId
                                             // response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                                         }
                                     }
                                 } catch (Exception ex) {
                                     Logger.getLogger(myservlet.class.getName()).log(Level.SEVERE, null, ex);
                                     // Handle any exceptions that occur during database operations
                                     // You can return an error response to the client in case of an error
                                     // For example, you can display an error page or return a JSON error message to the frontend.
                                     response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
                                 }
                             }}
                     }
                 }
                 // ...
                 // ... (existing code)
                      }}}
 
     
         
     
 private List<Board> fetchLinkedBoardsFromDatabase(int userId) throws ClassNotFoundException, SQLException {
    List<Board> linkedBoards = new ArrayList<>();

    // Load the MySQL JDBC driver
    Class.forName("com.mysql.cj.jdbc.Driver");

    try (Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/mysql", "root", "")) {
        // Query to fetch linked board names from email_boards table based on user ID

        String sql = "SELECT b.board_id, b.board_name FROM kanban_boards b INNER JOIN board_emails eb ON eb.board_id = b.board_id WHERE eb.user_id = ?";
        try (PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, userId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    int boardId = rs.getInt("b.board_id");
         String boardName = rs.getString("b.board_name");
 
                    linkedBoards.add(new Board(boardId, boardName)); // Create a Board object or adjust as needed
                }
            }
        }
    } catch (SQLException e) {
    e.printStackTrace(); }// Print the exception details to the console

    return linkedBoards;
 }
 public List<Task> getTasksForColumn(String columnName) throws SQLException, ClassNotFoundException {
     List<Task> tasks = new ArrayList<>();
 
     // Load the MySQL JDBC driver
     Class.forName("com.mysql.cj.jdbc.Driver");
 
     // Replace "your_database_name", "your_username", and "your_password" with your actual database credentials
     try (Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/mysql", "root", "")) {
         // Query to fetch tasks for the given column from the "tasks" table (replace "tasks_table" with your actual table name)
         String sql = "SELECT id, task_name FROM tasks WHERE column_name = ?";
         try (PreparedStatement ps = con.prepareStatement(sql)) {
             ps.setString(1, columnName);
             try (ResultSet rs = ps.executeQuery()) {
                 while (rs.next()) {
                     int taskId = rs.getInt("id"); // Retrieve the task ID
                     String taskName = rs.getString("task_name");
                     tasks.add(new Task(taskId, taskName)); // Create Task object with ID and task name
                 }
             }
         }
     }
 
     return tasks;
 }
 
 
   // Method to fetch board details (columns and tasks) from the database
     private Map<String, Object> fetchBoardDetailsFromDatabase(int boardId, int userId) {
         Map<String, Object> boardDetails = new HashMap<>();
 
         try {
             Class.forName("com.mysql.cj.jdbc.Driver");
             try (Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/mysql", "root", "")) {
                 String sql = "SELECT kb.board_id, kb.board_name, kc.column_id, kc.column_name, "
                            + "kt.task_id, kt.task_name FROM kanban_boards kb "
                            + "INNER JOIN user_board_mapping ubm ON kb.board_id = ubm.board_id "
                            + "LEFT JOIN kanban_columns kc ON kb.board_id = kc.board_id "
                            + "LEFT JOIN kanban_tasks kt ON kc.column_id = kt.column_id "
                            + "WHERE ubm.user_id = ? AND kb.board_id = ?";
                 try (PreparedStatement ps = con.prepareStatement(sql)) {
                     ps.setInt(1, userId);
                     ps.setInt(2, boardId);
                     try (ResultSet rs = ps.executeQuery()) {
                         while (rs.next()) {
                             if (boardDetails.isEmpty()) {
                                 // Set the board details (boardId and boardName) only once
                                 boardDetails.put("boardId", rs.getInt("kb.board_id"));
                                 boardDetails.put("boardName", rs.getString("kb.board_name"));
                             }
 
                             int columnId = rs.getInt("kc.column_id");
                             String columnName = rs.getString("kc.column_name");
 
                             if (columnName != null) {
                                 // Add the column name to the board details
                                 boardDetails.put("column_" + columnId, columnName);
                             }
 
                             int taskId = rs.getInt("kt.task_id");
                             String taskName = rs.getString("kt.task_name");
 
                             if (taskName != null) {
                                 // Add the task name to the board details
                                 boardDetails.put("task_" + taskId, taskName);
                             }
                         }
                     }
                 }
             }
         } catch (ClassNotFoundException | SQLException ex) {
             Logger.getLogger(myservlet.class.getName()).log(Level.SEVERE, null, ex);
         }
 
         return boardDetails;
     }
 
 public List<Column> fetchColumnsFromDatabase(int boardId) throws ClassNotFoundException, SQLException {
     List<Column> columns = new ArrayList<>();
 
     // Load the MySQL JDBC driver (You can replace this with your database driver)
     Class.forName("com.mysql.cj.jdbc.Driver");
 
     // Replace "your_database_name", "your_username", and "your_password" with your actual database credentials
     try (Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/mysql", "root", "")) {
         // Query to fetch column names from the "columns" table associated with the user's board (replace "columns_table" with your actual table name)
         String sql = "SELECT id,name FROM columns WHERE board_id = ?";
 
         try (PreparedStatement ps = con.prepareStatement(sql)) {
             ps.setInt(1, boardId); // Set the boardId as a parameter in the prepared statement
             try (ResultSet rs = ps.executeQuery()) {
                 while (rs.next()) {
                     int columnId = rs.getInt("id");
 
                     String columnName = rs.getString("name");
                     columns.add(new Column(columnId, columnName));
                 }
             }
         }
     }
 
     return columns;
 }
 
     
 
        private List<Tasktodo> retrieveTasksFromDatabase(int userId) throws SQLException {
        List<Tasktodo> tasks = new ArrayList<>();

        String jdbcUrl = "jdbc:mysql://localhost:3306/mysql";
        String dbUser = "root";
        String dbPassword = "";

        try (Connection connection = DriverManager.getConnection(jdbcUrl, dbUser, dbPassword)) {
            String sql = "SELECT * FROM list_tasks WHERE user_id=?";
            try (PreparedStatement preparedStatement = connection.prepareStatement(sql)){
                                     preparedStatement.setInt(1, userId);

                try( ResultSet resultSet = preparedStatement.executeQuery()) {
                while (resultSet.next()) {
                    int taskId = resultSet.getInt("task_id");
                    String taskName = resultSet.getString("task_name");
                    String description = resultSet.getString("description");
                    String date = resultSet.getString("due_date");
                boolean isCompleted = resultSet.getBoolean("is_completed"); // Retrieve is_completed

                    Tasktodo task = new Tasktodo(taskId, taskName, description, date);
                                    task.setCompleted(isCompleted); // Set isCompleted value

                    tasks.add(task);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return tasks;
    }}
       /* public static List<Tasktodo> fetchUsertodoFromDatabase(int userId) throws ClassNotFoundException, SQLException {
     List<Tasktodo> todos = new ArrayList<>();
 
         Class.forName("com.mysql.cj.jdbc.Driver");
 
         try (Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/mysql", "root", "")) {
             String sql = "SELECT task_id,task_name,description,due_date FROM list_tasks WHERE user_id = ?";
             try (PreparedStatement ps = con.prepareStatement(sql)) {
                 ps.setInt(1, userId);
                 try (ResultSet rs = ps.executeQuery()) {
     while (rs.next()) {
         int taskid = rs.getInt("task_id");
         String taskName = rs.getString("task_name");
         String description = rs.getString("description");
         String date = rs.getString("due_date");

 
         // Create a new Board object with id and name and add it to the list
         Tasktodo todo = new Tasktodo(taskid, taskName, description,date);
         todos.add(todo);
     }
                 }
             }
         }
 
     return todos;
     }*/
 




 private void deleteColumnFromDatabase(String columnID) throws SQLException, ClassNotFoundException {
     // Load the MySQL JDBC driver
     Class.forName("com.mysql.cj.jdbc.Driver");
 
     // Replace "your_database_name", "your_username", and "your_password" with your actual database credentials
     try (Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/mysql", "root", "")) {
         // Delete the tasks associated with the given column from the "tasks" table
         String deleteTasksSql = "DELETE FROM tasks WHERE column_ID = ?";
         try (PreparedStatement deleteTasksPs = con.prepareStatement(deleteTasksSql)) {
             deleteTasksPs.setString(1, columnID);
             deleteTasksPs.executeUpdate();
         }
 
         // Delete the column from the "columns" table
         String deleteColumnSql = "DELETE FROM columns WHERE id = ?";
         try (PreparedStatement deleteColumnPs = con.prepareStatement(deleteColumnSql)) {
             deleteColumnPs.setString(1, columnID);
             deleteColumnPs.executeUpdate();
         }
     }
 }
 private String getTaskDetailsFromDatabase(String taskID) throws SQLException, ClassNotFoundException {
     // Load the MySQL JDBC driver
     Class.forName("com.mysql.cj.jdbc.Driver");
 
     // Replace "your_database_name", "username", and "password" with your actual database credentials
     String jdbcUrl = "jdbc:mysql://localhost:3306/mysql";
     String dbUsername = "root";
     String dbPassword = "";
 
     try (Connection connection = DriverManager.getConnection(jdbcUrl, dbUsername, dbPassword)) {
         // Prepare the SQL query to retrieve task details based on the task name
         String sql = "SELECT task_name, description, mails, category, date FROM tasks WHERE id = ?";
         try (PreparedStatement preparedStatement = connection.prepareStatement(sql)) {
             preparedStatement.setString(1, taskID);
 
             // Execute the query and retrieve the result set
             try (ResultSet resultSet = preparedStatement.executeQuery()) {
                 if (resultSet.next()) {
                     // Extract the task details from the result set
                     String taskNameFromDB = resultSet.getString("task_name");
                     String description = resultSet.getString("description");
                     String mails = resultSet.getString("mails");
                     String category = resultSet.getString("category");
                     String date = resultSet.getString("date");
 

                     String taskDetails = "<p>Task Name: " + taskNameFromDB + "</p>";
      taskDetails += "<p>Description: " + description + "</p>";
      taskDetails += "<p>Collaborator's mails: " + mails + "</p>";
      taskDetails += "<p>Category: " + category + "</p>";
      taskDetails += "<p>Date: " + date + "</p>";
 
                     return taskDetails.toString();
                 }
             }
         }
     }
 
     // If the task is not found in the database, return an appropriate message
     return "Task not found";
 } 

 public static List<Board> fetchUserBoardsFromDatabase(int userId) throws ClassNotFoundException, SQLException {
     List<Board> userBoards = new ArrayList<>();
 
         Class.forName("com.mysql.cj.jdbc.Driver");
 
         try (Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/mysql", "root", "")) {
             String sql = "SELECT kb.board_id, kb.board_name FROM kanban_boards kb INNER JOIN user_board_mapping ubm ON kb.board_id = ubm.board_id WHERE ubm.user_id = ?";
             try (PreparedStatement ps = con.prepareStatement(sql)) {
                 ps.setInt(1, userId);
                 try (ResultSet rs = ps.executeQuery()) {
     while (rs.next()) {
         int boardId = rs.getInt("kb.board_id");
         String boardName = rs.getString("kb.board_name");
 
         // Create a new Board object with id and name and add it to the list
         Board board = new Board(boardId, boardName);
         userBoards.add(board);
     }
                 }
             }
         }
 
     return userBoards;
     }
 
 

private void deleteTaskFromDatabase(int taskId) throws SQLException, ClassNotFoundException {
    // Load the MySQL JDBC driver
    Class.forName("com.mysql.cj.jdbc.Driver");

    // Replace "your_database_name", "your_username", and "your_password" with your actual database credentials
    try (Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/mysql", "root", "")) {
        // Query to delete the task from the database (replace "tasks_table" with your actual table name)
        String sql = "DELETE FROM tasks WHERE id = ?";
        try (PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, taskId);
            ps.executeUpdate();
        }
    }
}

   public List<String> getAllColumnNames() throws SQLException, ClassNotFoundException {
         List<String> columnNames = new ArrayList<>();
 
         // Database connection
         PreparedStatement ps = null;
         ResultSet rs = null;
 
         try {
             // Load the MySQL JDBC driver (or your database driver)
             Class.forName("com.mysql.cj.jdbc.Driver");
 
             // Establish the database connection
     Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/mysql", "root", "");
 
             // SQL query to fetch column names from the 'columns' table (replace 'columns_table' with your actual table name)
             String sql = "SELECT name FROM columns";
 
             // Prepare the statement and execute the query
             ps = con.prepareStatement(sql);
             rs = ps.executeQuery();
 
             // Process the result set and populate the 'columnNames' list
             while (rs.next()) {
                 String columnName = rs.getString("name");
                 columnNames.add(columnName);
             }
 
         } finally {
             // Close the result set, prepared statement, and database connection
             if (rs != null) {
                 rs.close();
             }
             if (ps != null) {
                 ps.close();
             }
 
         }
         System.out.println("Column names: " + columnNames);
         return columnNames;
     }
 
     private List<String> fetchBoardNamesFromDatabase(int userId) {
         throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
     }
    private void insertEmailBoardMapping(String email, String boardId, int userId) throws ClassNotFoundException, SQLException {
    // Load the MySQL JDBC driver
    Class.forName("com.mysql.cj.jdbc.Driver");

    try (Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/mysql", "root", "")) {
        // Query to insert the email-board mapping into the board_emails table
        String sql = "INSERT INTO board_emails (email_address, board_id, user_id) VALUES (?, ?, ?)";
        try (PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, email);
            ps.setString(2, boardId);
            ps.setInt(3, userId);

            ps.executeUpdate();
        }
    }
}


private boolean isUserValid(String email) throws ClassNotFoundException, SQLException {
    Class.forName("com.mysql.cj.jdbc.Driver");
    
    try (Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/mysql", "root", "")) {
        String sql = "SELECT COUNT(*) FROM users WHERE email = ?";
        try (PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, email);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    int count = rs.getInt(1);
                    return count > 0;
                }
            }
        }
    }
    
    return false;
}





      private int getUserIdByEmail(String email) {
        // Implement this method to retrieve the user ID based on the email
        // Return -1 if the email does not correspond to a valid user
        // You should perform database queries here
        int userId = -1;

        // Connect to your database and retrieve the user ID based on the email
        try (Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/mysql", "root", "")) {
            String sql = "SELECT user_id FROM users WHERE email = ?";
            try (PreparedStatement ps = con.prepareStatement(sql)) {
                ps.setString(1, email);
                try (ResultSet rs = ps.executeQuery()) {
                    if (rs.next()) {
                        userId = rs.getInt("user_id");
                    }
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return userId;
    }
    private void addTaskToDatabase(String taskName) {
        String url = "jdbc:mysql://localhost:3306/mysql";
        String user = "root";
        String password = "";

        try (Connection connection = DriverManager.getConnection(url, user, password)) {
            String sql = "INSERT INTO list_tasks (task_name) VALUES (?)";
            PreparedStatement statement = connection.prepareStatement(sql);
            statement.setString(1, taskName);
            statement.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
private List<String> getMappedUserEmailsForBoard(int boardId) throws SQLException, ClassNotFoundException {
    List<String> mappedEmails = new ArrayList<>();
    // Load the MySQL JDBC driver
    Class.forName("com.mysql.cj.jdbc.Driver");

    try (Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/mysql", "root", "")) {
         String sql = "SELECT u.email, be.email_address FROM user_board_mapping ubm JOIN users u ON ubm.user_id = u.user_id JOIN board_emails be ON ubm.board_id = be.board_id WHERE ubm.board_id = ?";
        try (PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, boardId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                                        mappedEmails.add(rs.getString("be.email_address"));

                    mappedEmails.add(rs.getString("u.email"));
                }
            }
        }
    }
    
    return mappedEmails;
}
private void updateColumnIdInDatabase(int taskId, int newColumnId) throws SQLException, ClassNotFoundException {
    // Load the MySQL JDBC driver (you can replace this with your database driver)
    Class.forName("com.mysql.cj.jdbc.Driver");

    // Replace "your_database_name", "username", and "password" with your actual database credentials
    String jdbcUrl = "jdbc:mysql://localhost:3306/mysql";
    String dbUsername = "root";
    String dbPassword = "";

    try (Connection connection = DriverManager.getConnection(jdbcUrl, dbUsername, dbPassword)) {
        // Prepare the SQL query to update the column_id in the tasks table
        String sql = "UPDATE tasks SET column_id = ? WHERE id = ?";
        try (PreparedStatement preparedStatement = connection.prepareStatement(sql)) {
            preparedStatement.setInt(1, newColumnId);
            preparedStatement.setInt(2, taskId);

            // Execute the update query
            preparedStatement.executeUpdate();
        }
    }
}
public List<String> getEmailsByBoardId(String boardId) {
        List<String> emails = new ArrayList<>();

        PreparedStatement preparedStatement = null;
        ResultSet resultSet = null;

       
    try (Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/mysql", "root", "")) {

            String query = "SELECT email_address FROM board_emails WHERE board_id = ?";
            preparedStatement = con.prepareStatement(query);
            preparedStatement.setString(1, boardId);

            resultSet = preparedStatement.executeQuery();

            while (resultSet.next()) {
                String email = resultSet.getString("email_address");
                emails.add(email);
            }
        } catch (SQLException e) {
            e.printStackTrace();
            // Handle the exception appropriately
        } finally {
            // Close resources
            try { if (resultSet != null) resultSet.close(); } catch (SQLException e) { /* ignored */ }
            try { if (preparedStatement != null) preparedStatement.close(); } catch (SQLException e) { /* ignored */ }
        }

        return emails;
    }

    public boolean isEmailAlreadyInBoard(String email, String boardId) {
        List<String> existingEmails = getEmailsByBoardId(boardId);
        return existingEmails.contains(email);
    }
public User getUserById(int userId) {
    User user = null;

    // Database connection details
    String jdbcUrl = "jdbc:mysql://localhost:3306/mysql";
    String dbUser = "root";
    String dbPassword = "";

    try (Connection connection = DriverManager.getConnection(jdbcUrl, dbUser, dbPassword)) {
        String sql = "SELECT * FROM users WHERE user_id = ?";
        try (PreparedStatement preparedStatement = connection.prepareStatement(sql)) {
            preparedStatement.setInt(1, userId);

            try (ResultSet resultSet = preparedStatement.executeQuery()) {
                if (resultSet.next()) {
                    int retrievedUserId = resultSet.getInt("user_id");
                    String name = resultSet.getString("name");
                    String email = resultSet.getString("email");
                    String password = resultSet.getString("password");

                    user = new User(retrievedUserId, name, email, password);
                }
            }
        }
    } catch (SQLException e) {
        e.printStackTrace();
    }

    return user;
}
public boolean updateUserProfile(int userId, String name, String email,String password) {
    boolean updated = false;

    // Database connection details
    String jdbcUrl = "jdbc:mysql://localhost:3306/mysql";
    String dbUser = "root";
    String dbPassword = "";

    try (Connection connection = DriverManager.getConnection(jdbcUrl, dbUser, dbPassword)) {
        String sql = "UPDATE users SET name = ?, email = ?, password= ? WHERE user_id = ?";
        try (PreparedStatement preparedStatement = connection.prepareStatement(sql)) {
            preparedStatement.setString(1, name);
            preparedStatement.setString(2, email);
            preparedStatement.setString(3,password);
            preparedStatement.setInt(4, userId);

            int rowsAffected = preparedStatement.executeUpdate();
            updated = rowsAffected > 0;
        }
    } catch (SQLException e) {
        e.printStackTrace();
    }

    return updated;
}



 
 
 
 }
