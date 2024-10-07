<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ page import="com.revature.service.CommnServiceImpl" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="ISO-8859-1">
    <title>Edit Category</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <style>
        body {
            background-color: #f4f4f4;
            color: #333;
            font-family: 'Arial', sans-serif;
        }

        .card {
            border: none;
            border-radius: 8px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            margin-bottom: 1.5rem;
        }

        .card-header {
            background-color: #343a40;
            color: #fff;
            text-align: center;
            padding: 1rem;
            border-bottom: 1px solid #444;
            border-radius: 8px 8px 0 0;
        }

        .card-body {
            padding: 2rem;
        }

        .form-control, .form-control-file {
            border-radius: 5px;
            border: 1px solid #ced4da;
            padding: 0.75rem;
            transition: border-color 0.3s ease;
        }

        .form-control:focus, .form-control-file:focus {
            border-color: #343a40;
            box-shadow: none;
        }

        .btn-primary {
            background-color: #343a40;
            border: none;
            color: #fff;
            border-radius: 5px;
            padding: 0.75rem 1.25rem;
            transition: background-color 0.3s ease;
        }

        .btn-primary:hover {
            background-color: #495057;
        }

        .alert {
            border-radius: 5px;
            margin-bottom: 1rem;
        }

        .alert-dismissible .close {
            padding: 0.8rem;
            margin: -0.8rem -0.8rem -0.8rem auto;
        }

        .img-thumbnail {
            border-radius: 5px;
            border: 1px solid #ddd;
        }

        @media (max-width: 768px) {
            .card-body {
                padding: 1.5rem;
            }

            .btn-primary {
                width: 100%;
            }
        }

        @media (max-width: 576px) {
            .form-control, .form-control-file, .btn-primary {
                font-size: 0.875rem;
            }

            .card-header h3 {
                font-size: 1.25rem;
            }
        }
    </style>
</head>
<body>
    <div class="container mt-5">
        <div class="row justify-content-center">
            <div class="col-md-8">
                <div class="card">
                    <div class="card-header">
                        <h3>Edit Category</h3>
                    </div>
                    <div class="card-body">
                        <!-- Display success message -->
                        <c:if test="${not empty sessionScope.succMsg}">
                            <div class="alert alert-success alert-dismissible fade show" role="alert">
                                <strong>Success!</strong> ${fn:escapeXml(sessionScope.succMsg)}
                                <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                                    <span aria-hidden="true">&times;</span>
                                </button>
                            </div>
                            <c:remove var="succMsg" scope="session"/>
                        </c:if>

                        <!-- Display error message -->
                        <c:if test="${not empty sessionScope.errorMsg}">
                            <div class="alert alert-danger alert-dismissible fade show" role="alert">
                                <strong>Error!</strong> ${fn:escapeXml(sessionScope.errorMsg)}
                                <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                                    <span aria-hidden="true">&times;</span>
                                </button>
                            </div>
                            <c:remove var="errorMsg" scope="session"/>
                        </c:if>

                        <!-- Edit Category Form -->
                        <form action="${pageContext.request.contextPath}/admin/updateCategory" method="post" enctype="multipart/form-data">
                            <input type="hidden" name="id" value="${category.id}">
                            <div class="form-group">
                                <label for="name">Category Name</label>
                                <input type="text" id="name" name="name" value="${category.name}" class="form-control" required>
                            </div>

                            <div class="form-group">
                                <label>Status</label>
                                <div class="form-check">
                                    <input class="form-check-input" type="radio" value="true" name="isActive" id="active" <c:if test="${category.isActive}">checked</c:if>>
                                    <label class="form-check-label" for="active">Active</label>
                                </div>
                                <div class="form-check">
                                    <input class="form-check-input" type="radio" value="false" name="isActive" id="inactive" <c:if test="${!category.isActive}">checked</c:if>>
                                    <label class="form-check-label" for="inactive">Inactive</label>
                                </div>
                            </div>

                            <div class="form-group">
                                <label for="file">Upload Image</label>
                                <input type="file" id="file" name="file" class="form-control-file">
                            </div>

                            <div class="form-group">
                                <img src="${pageContext.request.contextPath}/img/category_img/${category.imageName}" class="img-thumbnail" alt="Category Image" width="150">
                            </div>

                            <button type="submit" class="btn btn-primary">Update</button>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Bootstrap JS and dependencies -->
    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.3/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>
