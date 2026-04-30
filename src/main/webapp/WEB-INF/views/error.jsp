<%@ page contentType="text/html;charset=UTF-8" isErrorPage="true" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8"/>
    <title>Error</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/css/style.css"/>
</head>
<body>
<header class="site-header">
    <div class="header-inner"><span class="logo">&#127891; Student Records</span></div>
</header>
<main class="container">
    <div class="card">
        <h2 class="card-title" style="color:#dc2626">&#9888; Something went wrong</h2>
        <p>Status code: <%= request.getAttribute("javax.servlet.error.status_code") %></p>
        <p><%= request.getAttribute("javax.servlet.error.message") %></p>
        <br/>
        <a href="<%= request.getContextPath() %>/" class="btn btn-primary">&#8592; Go Home</a>
    </div>
</main>
</body>
</html>
