<%-- 
    Document   : view_board
    Created on : 3 août 2023, 11:38:16
    Author     : hp
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>View Board</title>
</head>
<body>
    <h1>Welcome to Board: ${boardDetails.boardName}</h1>
    <h2>Columns:</h2>
    <ul>
        <c:forEach items="${boardDetails}" var="entry">
            <c:if test="${entry.key.startsWith('column_')}">
                <li>${entry.value}</li>
            </c:if>
        </c:forEach>
    </ul>

    <h2>Tasks:</h2>
    <ul>
        <c:forEach items="${boardDetails}" var="entry">
            <c:if test="${entry.key.startsWith('task_')}">
                <li>${entry.value}</li>
            </c:if>
        </c:forEach>
    </ul>

    <a href="/myapp/add-task?boardId=${boardDetails.boardId}">Add New Task</a>
</body>
</html>
