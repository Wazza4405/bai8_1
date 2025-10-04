package controller;

import java.io.IOException;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;

public class SqlGatewayServlet extends HttpServlet {

    // Kết nối tới SQL Server
    private String dbURL = "jdbc:sqlserver://localhost:1433;"
            + "databaseName=SQLGatewayDB;"
            + "encrypt=false;"
            + "trustServerCertificate=true";
    private String dbUser = "sa";       // đổi nếu khác
    private String dbPass = "18781902"; // đổi nếu khác

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String sql = request.getParameter("sql");
        StringBuilder result = new StringBuilder();

        try {
            // Nạp driver JDBC
            Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");

            try (Connection conn = DriverManager.getConnection(dbURL, dbUser, dbPass);
                 Statement stmt = conn.createStatement()) {

                boolean hasResultSet = stmt.execute(sql);

                if (hasResultSet) {
                    // Nếu là SELECT → trả kết quả dạng bảng HTML
                    ResultSet rs = stmt.getResultSet();
                    ResultSetMetaData meta = rs.getMetaData();
                    int colCount = meta.getColumnCount();

                    result.append("<table border='1' cellpadding='5' cellspacing='0'>");

                    // Header
                    result.append("<tr>");
                    for (int i = 1; i <= colCount; i++) {
                        result.append("<th>").append(meta.getColumnName(i)).append("</th>");
                    }
                    result.append("</tr>");

                    // Rows
                    while (rs.next()) {
                        result.append("<tr>");
                        for (int i = 1; i <= colCount; i++) {
                            result.append("<td>").append(rs.getString(i)).append("</td>");
                        }
                        result.append("</tr>");
                    }

                    result.append("</table>");
                } else {
                    // Nếu là UPDATE/INSERT/DELETE → trả số hàng bị ảnh hưởng
                    int updateCount = stmt.getUpdateCount();
                    result.append("<p>Statement executed successfully. Rows affected: ")
                          .append(updateCount).append("</p>");
                }
            }

        } catch (Exception e) {
            result.append("<p style='color:red;'>Error executing the SQL statement:<br>")
                  .append(e.getMessage()).append("</p>");
        }

        request.setAttribute("result", result.toString());
        request.getRequestDispatcher("/index.jsp").forward(request, response);
    }
}
