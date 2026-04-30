<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    // Retrieve and clear flash messages
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
    <title>Student Records — Add Student</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/css/style.css"/>
</head>
<body>

<header class="site-header">
    <div class="header-inner">
        <span class="logo">&#127891; Student Records</span>
        <nav>
            <a href="<%= request.getContextPath() %>/"         class="nav-link active">Add Student</a>
            <a href="<%= request.getContextPath() %>/students" class="nav-link">View All</a>
        </nav>
    </div>
</header>

<main class="container">
    <div class="card">
        <h2 class="card-title">Add New Student</h2>

        <% if (message != null) { %>
            <div class="alert alert-success"><%= message %></div>
        <% } %>
        <% if (error != null) { %>
            <div class="alert alert-error"><%= error %></div>
        <% } %>

        <form action="<%= request.getContextPath() %>/students/add"
              method="post" class="student-form" novalidate>

            <div class="form-row">
                <div class="form-group">
                    <label for="name">Student Name <span class="required">*</span></label>
                    <input type="text" id="name" name="name"
                           placeholder="e.g. Alice Johnson"
                           maxlength="100" required/>
                </div>

                <div class="form-group">
                    <label for="rollNo">Roll No. <span class="required">*</span></label>
                    <input type="text" id="rollNo" name="rollNo"
                           placeholder="e.g. R2024001"
                           maxlength="20" required/>
                </div>
            </div>

            <div class="form-row">
                <div class="form-group">
                    <label for="className">Class <span class="required">*</span></label>
                    <input type="text" id="className" name="className"
                           placeholder="e.g. 10th Grade"
                           maxlength="50" required/>
                </div>

                <div class="form-group">
                    <label for="city">City <span class="required">*</span></label>
                    <input type="text" id="city" name="city"
                           placeholder="e.g. New York"
                           maxlength="100" required/>
                </div>
            </div>

            <div class="form-actions">
                <button type="submit" class="btn btn-primary">&#43; Add Student</button>
                <button type="reset"  class="btn btn-secondary">&#8635; Reset</button>
            </div>
        </form>
    </div>
</main>

<footer class="site-footer">
    <p>Student Records System &mdash; Powered by Java JSP &amp; MySQL on Azure</p>
</footer>

<script>
    // Client-side validation before submit
    document.querySelector('.student-form').addEventListener('submit', function(e) {
        const fields = ['name','rollNo','className','city'];
        for (const id of fields) {
            const el = document.getElementById(id);
            if (!el.value.trim()) {
                el.classList.add('input-error');
                el.focus();
                e.preventDefault();
                return;
            } else {
                el.classList.remove('input-error');
            }
        }
    });
</script>
</body>
</html>
