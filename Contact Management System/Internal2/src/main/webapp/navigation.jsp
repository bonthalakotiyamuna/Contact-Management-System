<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="javax.servlet.http.HttpSession" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Navigation Bar</title>

    <style>
        nav {
            background-color: green; /* light blue */
            padding: 10px;
            text-align: center;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        nav a {
            display: inline-block;
            padding: 10px 20px;
            margin: 0 10px;
            color: white;
            text-decoration: none;
            border-radius: 5px;
            background-color: black; /* light blue */
            transition: background-color 0.3s;
        }

        nav a:hover {
            background-color: #87ceeb; /* lighter blue on hover */
        }

        nav button {
            background-color: red;
            color: white;
            border: none;
            cursor: pointer;
            padding: 10px 20px;
            border-radius: 5px;
        }

        nav button:hover {
            background-color: darkred;
        }

        .rollNumber {
            margin-right: 20px; /* Add margin for spacing */
            font-weight: bold;
        }
    </style>
</head>
<body>

<%
    HttpSession session1 = request.getSession();
    String rollNumber = (String) session1.getAttribute("username");
%>

<nav>
    <div>
        <a href="CreateorUpdate.jsp">Update contact</a>
        <a href="deleteStudent.jsp">Delete contact</a>
        <a href="ShowData.jsp">My Details</a>
        <a href="viewStudents.jsp">Show All Details</a>
    </div>
    <form action="Logout" method="post">
        <button type="submit">Logout</button>
    </form>
    <div class="rollNumber">
        <% if (rollNumber != null && !rollNumber.isEmpty()) { %>
            Welcome: <%= rollNumber %>
        <% } %>
    </div>

  
</nav>

</body>
</html>
