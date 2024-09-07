<%@page import="java.util.List"%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="app.classes.dao.BatchDAO" %>
<%@ page import="app.classes.model.Batch" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Manage Batch - Student Attendance Management System</title>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css">
    <link rel="stylesheet" href="css/style.css">
    <style>
        body {
            background-color: #f0f4f7;
            font-family: 'Arial', sans-serif;
            color: #333;
        }
        .container {
            max-width: 800px;
            margin-top: 50px;
            background-color: #fff;
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0px 4px 12px rgba(0, 0, 0, 0.1);
        }
        h2 {
            margin-bottom: 30px;
            font-weight: bold;
            color: #5c7cfa;
            text-align: center;
        }
        .form-inline .form-group {
            margin-bottom: 15px;
        }
        .form-control {
            border-radius: 25px;
            padding: 10px 15px;
            border: 1px solid #ced4da;
        }
        .btn-primary {
            border-radius: 25px;
            padding: 10px 20px;
            background-color: #5c7cfa;
            border: none;
            transition: background-color 0.3s ease;
        }
        .btn-primary:hover {
            background-color: #3b5bdb;
        }
        .btn-danger {
            border-radius: 25px;
            padding: 5px 15px;
            transition: background-color 0.3s ease;
        }
        .btn-danger:hover {
            background-color: #e74c3c;
        }
        table {
            margin-top: 30px;
        }
        th {
            background-color: #5c7cfa;
            color: #fff;
        }
        td {
            vertical-align: middle;
        }
        .text-center a {
            border-radius: 25px;
            padding: 10px 20px;
            background-color: #6c757d;
            color: #fff;
            text-decoration: none;
            transition: background-color 0.3s ease;
        }
        .text-center a:hover {
            background-color: #5a6268;
        }
    </style>
</head>
<body>
<div class="container">
    <div class="box">
        <h2>Manage Batches</h2>
        <%
            String action = request.getParameter("action");
            if ("addBatch".equals(action)) {
                String batchId = request.getParameter("batchId");
                String batchName = request.getParameter("batchName");
                String yearStr = request.getParameter("year");
                if (batchId != null && batchName != null && yearStr != null) {
                    int year = Integer.parseInt(yearStr);
                    Batch batch = new Batch();
                    batch.setBatchId(batchId);
                    batch.setBatchName(batchName);
                    batch.setYear(year);

                    BatchDAO batchDAO = new BatchDAO();
                    batchDAO.addBatch(batch);
                }
            } else if ("deleteBatch".equals(action)) {
                String batchId = request.getParameter("batchId");
                if (batchId != null) {
                    BatchDAO batchDAO = new BatchDAO();
                    batchDAO.deleteBatch(batchId);
                }
            }

            BatchDAO batchDAO = new BatchDAO();
            List<Batch> batches = batchDAO.getAllBatches();
        %>
        <form action="manage_batch.jsp" method="post" class="form-inline justify-content-center">
            <input type="hidden" name="action" value="addBatch">
            <div class="form-group mx-sm-2">
                <input type="text" class="form-control" id="batchId" name="batchId" placeholder="Batch ID" required>
            </div>
            <div class="form-group mx-sm-2">
                <input type="text" class="form-control" id="batchName" name="batchName" placeholder="Batch Name" required>
            </div>
            <div class="form-group mx-sm-2">
                <input type="number" class="form-control" id="year" name="year" placeholder="Year" required>
            </div>
            <button type="submit" class="btn btn-primary mx-sm-2">Add Batch</button>
        </form>
        <table class="table table-striped table-hover">
            <thead>
                <tr>
                    <th>Batch ID</th>
                    <th>Batch Name</th>
                    <th>Year</th>
                    <th>Action</th>
                </tr>
            </thead>
            <tbody>
                <%
                    for (Batch batch : batches) {
                %>
                <tr>
                    <td><%= batch.getBatchId() %></td>
                    <td><%= batch.getBatchName() %></td>
                    <td><%= batch.getYear() %></td>
                    <td>
                        <form action="manage_batch.jsp" method="post" style="display:inline;">
                            <input type="hidden" name="action" value="deleteBatch">
                            <input type="hidden" name="batchId" value="<%= batch.getBatchId() %>">
                            <button type="submit" class="btn btn-danger btn-sm">Delete</button>
                        </form>
                    </td>
                </tr>
                <%
                    }
                %>
            </tbody>
        </table>
        <div class="text-center">
            <a href="admin_home.jsp">Back to Dashboard</a>
        </div>
    </div>
</div>
<script src="https://code.jquery.com/jquery-3.2.1.slim.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js"></script>
</body>
</html>
