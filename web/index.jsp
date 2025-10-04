<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>SQL Gateway</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background: #f4f6f9;
            margin: 0;
            padding: 0;
            text-align: center;
        }
        h1 {
            background: #007BFF;
            color: white;
            padding: 20px;
            margin: 0;
        }
        form {
            margin: 20px auto;
            padding: 20px;
            background: white;
            border-radius: 8px;
            width: 70%;
            box-shadow: 0 0 10px rgba(0,0,0,0.1);
        }
        textarea {
            width: 90%;
            border: 1px solid #ccc;
            border-radius: 4px;
            padding: 10px;
            font-size: 14px;
        }
        input[type="submit"] {
            background: #28a745;
            color: white;
            border: none;
            padding: 10px 20px;
            margin-top: 10px;
            border-radius: 4px;
            cursor: pointer;
            font-size: 14px;
        }
        input[type="submit"]:hover {
            background: #218838;
        }
        .result-container {
            margin: 20px auto;
            width: 70%;
            padding: 20px;
            background: white;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0,0,0,0.1);
            text-align: center;
        }
        table {
            margin: 0 auto;
            border-collapse: collapse;
            width: 80%;
        }
        th, td {
            border: 1px solid #ddd;
            padding: 12px;
        }
        th {
            background: #007BFF;
            color: white;
            text-transform: uppercase;
        }
        tr:nth-child(even) {
            background: #f2f2f2;
        }
        tr:hover {
            background: #d9edf7;
        }
    </style>
</head>
<body>
    <h1>🚀 SQL Gateway</h1>
    <form action="sqlGateway" method="post">
        <p><b>SQL statement:</b></p>
        <textarea name="sql" rows="5"></textarea><br>
        <input type="submit" value="Execute">
    </form>

    <div class="result-container">
        <h3>Result:</h3>
        <%
            String result = (String) request.getAttribute("result");
            if (result != null) {
                out.println(result);
            }
        %>
    </div>
</body>
</html>
