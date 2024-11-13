<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, javax.servlet.http.HttpSession" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Search and Update Student</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f5f5f5;
            padding: 20px;
            text-align: center;
        }
        h2 {
            color: #333;
        }
        form {
            margin-top: 20px;
            background-color: #fff;
            padding: 20px;
            border-radius: 5px;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
            width: 300px;
            margin: 0 auto;
        }
        label {
            display: block;
            margin-bottom: 10px;
            font-weight: bold;
        }
        input[type="text"] {
            width: 100%;
            padding: 10px;
            margin-bottom: 20px;
            box-sizing: border-box;
            border: 1px solid #ccc;
            border-radius: 5px;
        }
        input[type="submit"] {
            background-color: #4CAF50;
            color: white;
            padding: 12px 20px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            width: 100%;
            font-size: 16px;
        }
        input[type="submit"]:hover {
            background-color: #45a049;
        }
        p {
            margin-top: 20px;
            font-weight: bold;
        }
        p.error {
            color: red;
        }
        p.success {
            color: green;
        }
    </style>
</head>
<body>

<jsp:include page="navigation.jsp" />

<h2>Search and Update Contact Details</h2>

<%-- Display success or error messages --%>
<% String message = (String) request.getAttribute("message"); %>
<% String error = (String) request.getAttribute("error"); %>

<% if (message != null && !message.isEmpty()) { %>
    <p class="success"><%= message %></p>
<% } else if (error != null && !error.isEmpty()) { %>
    <p class="error"><%= error %></p>
<% } %>

<form  method="post">
    <label for="studentId">Enter contact ID to update:</label>
    <input type="text" id="studentId" name="studentId">
    <input type="submit" value="Search">
</form>


<%
    // Retrieve the entered student ID from the form
    String studentId = request.getParameter("studentId");

    if (studentId != null && !studentId.isEmpty()) {
        // Create or retrieve HttpSession
        HttpSession session1 = request.getSession(true);

        // Store studentId in session
        session1.setAttribute("studentId", studentId);
        
        // Retrieve student details from database based on studentId
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/student_management", "root", "9490");
            ps = conn.prepareStatement("SELECT * FROM student WHERE student_id = ?");
            ps.setString(1, studentId);
            rs = ps.executeQuery();

            if (rs.next()) {
                // Student exists, display update form with pre-filled data
%>
                <div>
                    <form action="UpdateServlet" method="post">
                        <input type="hidden" name="studentId" value="<%= studentId %>" />
                        <label for="name">Name:</label>
                        <input type="text" id="name" name="name" value="<%= rs.getString("name") %>" required><br>
                        <label for="dateOfBirth">Date of Birth:</label>
                        <input type="date" id="dateOfBirth" name="dateOfBirth" value="<%= rs.getString("date_of_birth") %>" required><br>
                        <label for="gender">Gender:</label>
                        <select id="gender" name="gender" required>
                            <option value="Male" <%= rs.getString("gender").equals("Male") ? "selected" : "" %>>Male</option>
                            <option value="Female" <%= rs.getString("gender").equals("Female") ? "selected" : "" %>>Female</option>
                            <option value="Other" <%= rs.getString("gender").equals("Other") ? "selected" : "" %>>Other</option>
                        </select><br>
                        <label for="email">Email:</label>
                        <input type="email" id="email" name="email" value="<%= rs.getString("email") %>" required><br>
                        <label for="phoneNumber">Phone Number:</label>
                        <input type="text" id="phoneNumber" name="phoneNumber" value="<%= rs.getString("phone_number") %>" required><br>
                        <label for="address">Address:</label>
                        <input type="text" id="address" name="address" value="<%= rs.getString("address") %>" required><br>
                        <input type="submit" value="Update">
                    </form>
                </div>
<%
            } else {
                // Student not found
%>
                <p class="error">Student with ID <%= studentId %> not found.</p>
<%
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            // Close resources
            try {
                if (rs != null) rs.close();
                if (ps != null) ps.close();
                if (conn != null) conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
%>

</body>
</html>
