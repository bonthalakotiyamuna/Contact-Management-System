<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, javax.servlet.http.HttpSession" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Show Student Data</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            background-color: #f4f4f4;
        }

        .container {
            width: 80%;
            margin: 20px auto;
            padding: 20px;
            background-color: #fff;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
        }

        h1 {
            text-align: center;
            margin-bottom: 20px;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }

        th, td {
            padding: 10px;
            text-align: left;
            border-bottom: 1px solid #ddd;
        }

        th {
            background-color: #f2f2f2;
        }

        .error {
            color: red;
            font-weight: bold;
        }
    </style>
</head>
<body>
    <div class="container">
        <jsp:include page="navigation.jsp" />
        <h1>Show Student Data</h1>
        <% 
            // Retrieve username from session
            HttpSession session1 = request.getSession();
            String username = (String) session1.getAttribute("username");

            // Database connection and query
            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                String url = "jdbc:mysql://localhost:3306/user_management";
                String dbUsername = "root";
                String dbPassword = "9490";

                Connection conn = DriverManager.getConnection(url, dbUsername, dbPassword);
                PreparedStatement ps = conn.prepareStatement("SELECT * FROM users WHERE username = ?");
                ps.setString(1, username);

                ResultSet rs = ps.executeQuery();

                // Display student data in a table
                if (rs.next()) {
        %>
        <table>
            <tr>
                <th>user ID</th>
                <th>User Name</th>
                
                <th>email</th>
                <th>full Name</th>
            </tr>
            <tr>
                <td><%= rs.getInt("id") %></td>
                <td><%= rs.getString("username") %></td>
                
                <td><%= rs.getString("email") %></td>
                <td><%= rs.getString("full_name") %></td>
                
            </tr>
        </table>
        <%
            } else {
        %>
        <p class="error">No student data found for username: <%= username %></p>
        <%
            }

                // Close resources
                rs.close();
                ps.close();
                conn.close();
            } catch (ClassNotFoundException | SQLException e) {
        %>
        <p class="error">Error: <%= e.getMessage() %></p>
        <%
            }
        %>
    </div>
</body>
</html>
