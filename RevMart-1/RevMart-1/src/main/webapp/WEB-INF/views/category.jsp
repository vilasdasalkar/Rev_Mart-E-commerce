<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page import="java.util.List" %>
<%@ include file="./base.jsp" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="ISO-8859-1">
    <title>Manage Categories</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            background-color: #f8f9fa;
            color: #343a40;
            font-family: 'Arial', sans-serif;
        }

/* Additional Styles for Table Header */
table thead {
    background-color: #333; /* Dark grey background for header */
    color: #fff; /* White text color */
}

table thead th {
    padding: 1rem;
    text-align: center;
    border-bottom: 2px solid #444; /* Slightly lighter border for separation */
}

        .card {
            border: 1px solid #ddd;
            border-radius: 8px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            transition: box-shadow 0.3s ease, transform 0.3s ease;
        }

        .card:hover {
            box-shadow: 0 8px 16px rgba(0, 0, 0, 0.2);
            transform: translateY(-5px);
        }

        .card-header {
            background-color: #343a40;
            color: #fff;
            text-align: center;
            padding: 1rem;
            border-bottom: 1px solid #444;
        }

        .card-body {
            padding: 2rem;
        }

        .btn-primary {
            background-color: #343a40;
            border: none;
            color: #fff;
            transition: background-color 0.3s ease;
        }

        .btn-primary:hover {
            background-color: #495057;
        }

        .form-control {
            border: 1px solid #ccc;
            border-radius: 5px;
            padding: 0.75rem;
            transition: border-color 0.3s ease;
        }

        .form-control:focus {
            border-color: #343a40;
            box-shadow: none;
        }

        .form-label {
            font-weight: 500;
        }

        table {
            width: 100%;
            margin: 1rem 0;
            border-collapse: separate;
            border-spacing: 0;
        }

        table th, table td {
            text-align: center;
            padding: 1rem;
        }

        table img {
            object-fit: cover;
            border-radius: 4px;
        }

        thead th {
            background-color: #e9ecef;
            color: #343a40;
        }

        tbody tr:nth-child(odd) {
            background-color: #f9f9f9;
        }
          
    

        tbody tr:nth-child(even) {
            background-color: #ffffff;
        }

        tbody tr:hover {
            background-color: #f1f1f1;
        }

        .pagination {
            margin-top: 1rem;
        }

        .pagination .page-item.disabled .page-link {
            background-color: #e9ecef;
            border-color: #ddd;
            color: #6c757d;
        }

        .pagination .page-item.active .page-link {
            background-color: #343a40;
            border-color: #343a40;
            color: #fff;
        }

        @media (max-width: 768px) {
            .container {
                padding: 1rem;
            }

            .card {
                margin-bottom: 1rem;
            }
        }

        @media (max-width: 576px) {
            .form-control {
                font-size: 0.875rem;
            }

            .btn-primary {
                font-size: 0.875rem;
            }
        }
    </style>
</head>
<body>
    <div class="container my-5">
        <div class="row">
            <!-- Add Category Form -->
            <div class="col-lg-6 col-md-8 mx-auto mb-4">
                <div class="card">
                    <div class="card-header">
                        <h4 class="mb-0">Add Category</h4>
                        <c:if test="${not empty sessionScope.succMsg}">
                            <p class="text-success fw-bold">${sessionScope.succMsg}</p>
                            <c:set var="sessionScope.succMsg" value="" />
                        </c:if>
                        <c:if test="${not empty sessionScope.errorMsg}">
                            <p class="text-danger fw-bold">${sessionScope.errorMsg}</p>
                            <c:set var="sessionScope.errorMsg" value="" />
                        </c:if>
                    </div>
                    <div class="card-body">
                        <form action="/admin/saveCategory" method="post" enctype="multipart/form-data">
                            <div class="mb-3">
                                <label for="categoryName" class="form-label">Enter Category</label>
                                <input type="text" id="categoryName" name="name" class="form-control" required>
                            </div>
                            <div class="mb-3">
                                <label class="form-label">Status</label>
                                <div class="form-check">
                                    <input class="form-check-input" type="radio" checked value="true" name="isActive" id="active">
                                    <label class="form-check-label" for="active">Active</label>
                                </div>
                                <div class="form-check">
                                    <input class="form-check-input" type="radio" name="isActive" value="false" id="inactive">
                                    <label class="form-check-label" for="inactive">Inactive</label>
                                </div>
                            </div>
                            <div class="mb-3">
                                <label for="categoryImage" class="form-label">Upload Image</label>
                                <input type="file" id="categoryImage" name="file" class="form-control" required>
                            </div>
                            <button type="submit" class="btn btn-primary col-12">Save</button>
                        </form>
                    </div>
                </div>
            </div>

            <!-- Category Details Table -->
            <div class="col-lg-12">
                <div class="card">
                    <div class="card-header">
                        <h4 class="mb-0">Category Details</h4>
                    </div>
                    <div class="card-body">
                        <table class="table table-bordered table-striped">
                            <thead>
                                <tr>
                                    <th scope="col">SR No</th>
                                    <th scope="col">Category</th>
                                    <th scope="col">Status</th>
                                    <th scope="col">Image</th>
                                    <th scope="col">Action</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="cat" varStatus="status" items="${categorys}">
                                    <tr>
                                        <th scope="row">${status.count}</th>
                                        <td>${cat.name}</td>
                                        <td>${cat.isActive ? 'Active' : 'Inactive'}</td>
                                        <td><img src="/img/category_img/${cat.imageName}" width="50" height="50" alt="category image"></td>
                                        <td>
                                            <a href="/admin/loadEditCategory/${cat.id}" class="btn btn-primary btn-sm">
                                                <i class="fa-solid fa-pen-to-square"></i> Edit
                                            </a>
                                            <a href="/admin/deleteCategory/${cat.id}" class="btn btn-danger btn-sm">
                                                <i class="fa-solid fa-trash"></i> Delete
                                            </a>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>

                        <!-- Pagination -->
                        <nav aria-label="Page navigation">
                            <ul class="pagination">
                                <li class="page-item ${isFirst ? 'disabled' : ''}">
                                    <a class="page-link" href="/admin/category?pageNo=${pageNo - 1}" aria-label="Previous">
                                        <span aria-hidden="true">&laquo;</span>
                                    </a>
                                </li>
                                <c:forEach begin="1" end="${totalPages}" var="i">
                                    <li class="page-item ${pageNo + 1 == i ? 'active' : ''}">
                                        <a class="page-link" href="/admin/category?pageNo=${i - 1}">${i}</a>
                                    </li>
                                </c:forEach>
                                <li class="page-item ${isLast ? 'disabled' : ''}">
                                    <a class="page-link" href="/admin/category?pageNo=${pageNo + 1}" aria-label="Next">
                                        <span aria-hidden="true">&raquo;</span>
                                    </a>
                                </li>
                            </ul>
                        </nav>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script src="https://kit.fontawesome.com/a076d05399.js" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
