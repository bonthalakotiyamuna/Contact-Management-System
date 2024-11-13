package studentmanagement;

import java.sql.*;
import java.io.*;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet{
	private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        
        if (authenticateUser(username, password, request.getSession())) {
            // Authentication successful, set session attribute
            request.getSession().setAttribute("username", username);
            response.sendRedirect("index.jsp");
        } else {
            // Authentication failed
            response.sendRedirect("index.html?error=1");
        }
    }

    private boolean authenticateUser(String username, String password, HttpSession session) {
        String url = "jdbc:mysql://localhost:3306/user_management";
        String dbUsername = "root";
        String dbPassword = "9490";

        try (Connection conn = DriverManager.getConnection(url, dbUsername, dbPassword);
             PreparedStatement stmt = conn.prepareStatement("SELECT * FROM users WHERE username=? AND password=?")) {
            stmt.setString(1, username);
            stmt.setString(2, password);
            ResultSet rs = stmt.executeQuery();
            boolean userExists = rs.next(); // true if user exists with provided credentials
            
            // Store authentication status in session if user exists
            if (userExists) {
                session.setAttribute("authenticated", true);
            }
            
            return userExists;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

}
