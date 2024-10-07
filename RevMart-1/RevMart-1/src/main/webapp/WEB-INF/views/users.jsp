<%@ page import="org.springframework.web.context.support.WebApplicationContextUtils" %>
<%@ page import="org.springframework.context.ApplicationContext" %>
<%@ page import="com.revature.service.CommnServiceImpl" %>
<%@ page import="java.util.List" %>
<%@ page import="com.revature.model.UserDtls" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@include file="./base.jsp" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="ISO-8859-1">
    <title>User Management</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
    <style>
        body {
            background-color: #f8f9fa;
            color: #495057;
            font-family: 'Arial', sans-serif;
        }

        .card-sh {
            border-radius: 15px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
        }

        .card-header {
            background-color: #343a40;
            color: #fff;
            border-radius: 15px 15px 15px 15px;
            padding: 1rem;
        }

        .card-body {
            background-color: #fff;
            border-radius: 0 0 15px 15px;
            padding: 1.5rem;
        }

        .table {
            border-collapse: separate;
            border-spacing: 0;
            border-radius: 10px;
            overflow: hidden;
            background-color: #fff;
        }

        .table thead th {
            background-color: #343a40;
            color: #fff;
            text-align: center;
        }

        .table tbody tr:nth-child(odd) {
            background-color: #f9f9f9;
        }

        .table tbody tr:hover {
            background-color: #e9ecef;
        }

        .table td, .table th {
            padding: 1rem;
            vertical-align: middle;
            text-align: center;
        }

        .btn-primary, .btn-danger {
            border-radius: 8px;
            font-weight: 600;
            transition: background-color 0.3s ease, box-shadow 0.3s ease;
        }

        .btn-primary:hover {
            background-color: #0056b3;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
        }

        .btn-danger:hover {
            background-color: #c82333;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
        }

        .text-success, .text-danger {
            margin-bottom: 1rem;
            font-weight: 600;
        }

        @media (max-width: 768px) {
            .card-header {
                font-size: 1.25rem;
            }

            .table td, .table th {
                font-size: 0.875rem;
                padding: 0.5rem;
            }
        }

        @media (max-width: 576px) {
            .card-header {
                font-size: 1rem;
            }

            .btn-primary, .btn-danger {
                width: 100%;
                font-size: 0.875rem;
            }

            .table td, .table th {
                font-size: 0.75rem;
            }
        }
    </style>
</head>
<body>
    <section>
        <div class="container-fluid mt-5 p-5">
            <div class="card card-sh">
                <div class="card-header text-center">
                    <p class="fs-4">
                        <c:choose>
                            <c:when test="${userType == 1}">Users</c:when>
                            <c:when test="${userType == 2}">Admin</c:when>
                        </c:choose>
                    </p>

                    <%
                        // Retrieve the Spring application context and get the service bean
                        ApplicationContext ctx = WebApplicationContextUtils.getWebApplicationContext(application);
                        CommnServiceImpl commnServiceImpl = (CommnServiceImpl) ctx.getBean("commnServiceImpl");
                    %>

                    <!-- Success Message -->
                    <c:if test="${not empty sessionScope.succMsg}">
                        <p class="text-success fw-bold">${sessionScope.succMsg}</p>
                        <%
                            // Remove the success message from the session
                            commnServiceImpl.removeSessionMessage();
                        %>
                    </c:if>

                    <!-- Error Message -->
                    <c:if test="${not empty sessionScope.errorMsg}">
                        <p class="text-danger fw-bold">${sessionScope.errorMsg}</p>
                        <%
                            // Remove the error message from the session
                            commnServiceImpl.removeSessionMessage();
                        %>
                    </c:if>
                </div>

                <div class="card-body">
                    <table class="table">
                        <thead>
                            <tr>
                                <th scope="col">Sl No</th>
                                <th scope="col">Profile</th>
                                <th scope="col">Name</th>
                                <th scope="col">Email</th>
                                <th scope="col">Mobile No</th>
                                <th scope="col">Address</th>
                                <th scope="col">Status</th>
                                <th scope="col">Action</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="u" items="${users}" varStatus="c">
                                <tr>
                                    <th scope="row">${c.count}</th>
                                    <td><img src="${pageContext.request.contextPath}/img/profile_img/${u.profileImage}" width="70" height="70" class="img-thumbnail"></td>
                                    <td>${u.name}</td>
                                    <td>${u.email}</td>
                                    <td>${u.mobileNumber}</td>
                                    <td>${u.address}, ${u.city}, ${u.state}, ${u.pincode}</td>
                                    <td>${u.isEnable}</td>
                                    <td>
                                        <a href="${pageContext.request.contextPath}/admin/updateSts?status=true&id=${u.id}&type=${userType}" class="btn btn-sm btn-primary">Active</a>
                                        <a href="${pageContext.request.contextPath}/admin/updateSts?status=false&id=${u.id}&type=${userType}" class="btn btn-sm btn-danger">Inactive</a>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </section>
</body>
</html>
