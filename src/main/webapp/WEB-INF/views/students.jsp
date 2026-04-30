<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List, com.student.Student" %>
<%
    List<Student> students = (List<Student>) request.getAttribute("students");
    String message = (String) session.getAttribute("message");
    String error   = (String) session.getAttribute("error");
    session.removeAttribute("message");
    session.removeAttribute("error");
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <title>Student Records — All Students</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/css/style.css"/>
</head>
<body>

<header class="site-header">
    <div class="header-inner">
        <span class="logo">&#127891; Student Records</span>
        <nav>
            <a href="<%= request.getContextPath() %>/"         class="nav-link">Add Student</a>
            <a href="<%= request.getContextPath() %>/students" class="nav-link active">View All</a>
        </nav>
    </div>
</header>

<main class="container">
    <div class="card">
        <div class="card-header-row">
            <h2 class="card-title">All Students</h2>
            <a href="<%= request.getContextPath() %>/" class="btn btn-primary btn-sm">&#43; Add New</a>
        </div>

        <% if (message != null) { %>
            <div class="alert alert-success"><%= message %></div>
        <% } %>
        <% if (error != null) { %>
            <div class="alert alert-error"><%= error %></div>
        <% } %>

        <!-- Search bar (client-side filter) -->
        <div class="search-bar">
            <input type="text" id="searchInput"
                   placeholder="&#128269; Search by name, roll no., class or city..."
                   oninput="filterTable(this.value)"/>
        </div>

        <% if (students == null || students.isEmpty()) { %>
            <div class="empty-state">
                <p>&#128194; No student records found.</p>
                <a href="<%= request.getContextPath() %>/" class="btn btn-primary">Add First Student</a>
            </div>
        <% } else { %>
            <div class="table-wrapper">
                <table class="data-table" id="studentTable">
                    <thead>
                        <tr>
                            <th>#</th>
                            <th>Name</th>
                            <th>Roll No.</th>
                            <th>Class</th>
                            <th>City</th>
                            <th>Action</th>
                        </tr>
                    </thead>
                    <tbody>
                        <% int serial = 1; %>
                        <% for (Student s : students) { %>
                        <tr>
                            <td><%= serial++ %></td>
                            <td><strong><%= s.getName() %></strong></td>
                            <td><span class="badge"><%= s.getRollNo() %></span></td>
                            <td><%= s.getClassName() %></td>
                            <td>&#128205; <%= s.getCity() %></td>
                            <td>
                                <a href="<%= request.getContextPath() %>/students/delete?id=<%= s.getId() %>"
                                   class="btn btn-danger btn-sm"
                                   onclick="return confirm('Delete <%= s.getName() %>?')">
                                   &#128465; Delete
                                </a>
                            </td>
                        </tr>
                        <% } %>
                    </tbody>
                </table>
            </div>
            <p class="record-count">Total Records: <strong><%= students.size() %></strong></p>
        <% } %>
    </div>
</main>

<footer class="site-footer">
    <p>Student Records System &mdash; Powered by Java JSP &amp; MySQL on Azure</p>
</footer>

<script>
    function filterTable(query) {
        const rows  = document.querySelectorAll('#studentTable tbody tr');
        const lower = query.toLowerCase();
        rows.forEach(row => {
            row.style.display = row.innerText.toLowerCase().includes(lower) ? '' : 'none';
        });
    }
</script>
</body>
</html>
