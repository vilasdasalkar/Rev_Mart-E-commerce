<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ include file="./base.jsp" %>
<%@ page import="java.util.List" %>
<%@ page import="com.revature.model.Category" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="ISO-8859-1">
    <title>Edit Product</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <style>
        body {
            background-color: #f0f2f5;
            color: #333;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }

        .card {
            border: none;
            border-radius: 10px;
            box-shadow: 0 8px 16px rgba(0, 0, 0, 0.2);
            margin-bottom: 2rem;
        }

        .card-header {
            background-color: #007bff;
            color: #fff;
            text-align: center;
            padding: 1rem;
            border-radius: 10px 10px 0 0;
            font-size: 1.75rem;
            font-weight: 600;
        }

        .card-body {
            padding: 2rem;
            background-color: #fff;
            border-radius: 0 0 10px 10px;
        }

        .form-control, .form-control-file {
            border-radius: 8px;
            border: 1px solid #ced4da;
            padding: 0.75rem;
            transition: border-color 0.3s ease, box-shadow 0.3s ease;
        }

        .form-control:focus, .form-control-file:focus {
            border-color: #007bff;
            box-shadow: 0 0 0 0.2rem rgba(38, 143, 255, 0.25);
        }

        .btn-primary {
            background-color: #007bff;
            border: none;
            color: #fff;
            border-radius: 8px;
            padding: 0.75rem 1.25rem;
            font-size: 1rem;
            font-weight: 600;
            transition: background-color 0.3s ease, box-shadow 0.3s ease;
        }

        .btn-primary:hover {
            background-color: #0056b3;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
        }

        .alert {
            border-radius: 8px;
            margin-bottom: 1.5rem;
            padding: 1rem;
            font-size: 1rem;
        }

        .alert-dismissible .close {
            padding: 0.75rem;
            margin: -0.75rem -0.75rem -0.75rem auto;
        }

        .img-thumbnail {
            border-radius: 8px;
            border: 1px solid #ddd;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        }

        @media (max-width: 768px) {
            .card-body {
                padding: 1.5rem;
            }

            .btn-primary {
                width: 100%;
            }

            .form-control, .form-control-file {
                font-size: 0.875rem;
            }
        }

        @media (max-width: 576px) {
            .card-header {
                font-size: 1.5rem;
            }

            .form-control, .form-control-file {
                font-size: 0.75rem;
            }
        }
    </style>
</head>
<body>
    <section>
        <div class="container p-5 mt-3">
            <div class="row">
                <div class="col-md-8 offset-md-2">
                    <div class="card">
                        <div class="card-header">
                            <p>Edit Product</p>

                            <!-- Success message -->
                            <c:if test="${not empty sessionScope.succMsg}">
                                <div class="alert alert-success alert-dismissible fade show" role="alert">
                                    <strong>Success!</strong> ${fn:escapeXml(sessionScope.succMsg)}
                                    <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                                        <span aria-hidden="true">&times;</span>
                                    </button>
                                </div>
                                <c:remove var="succMsg" scope="session"/>
                            </c:if>

                            <!-- Error message -->
                            <c:if test="${not empty sessionScope.errorMsg}">
                                <div class="alert alert-danger alert-dismissible fade show" role="alert">
                                    <strong>Error!</strong> ${fn:escapeXml(sessionScope.errorMsg)}
                                    <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                                        <span aria-hidden="true">&times;</span>
                                    </button>
                                </div>
                                <c:remove var="errorMsg" scope="session"/>
                            </c:if>
                        </div>
                        <div class="card-body">
                            <form action="/admin/updateProduct" method="post" enctype="multipart/form-data">
                                <input type="hidden" name="id" value="${product.id}">
                                <div class="mb-4">
                                    <label for="title">Enter Title</label>
                                    <input type="text" id="title" name="title" value="${product.title}" class="form-control">
                                </div>

                                <div class="mb-4">
                                    <label for="description">Enter Description</label>
                                    <textarea id="description" rows="4" class="form-control" name="description">${product.description}</textarea>
                                </div>
                                
                                <div class="row">
                                    <div class="mb-4 col">
                                        <label for="category">Category</label> 
                                        <select id="category" class="form-control" name="category">
                                            <option>${product.category}</option>
                                            <c:forEach var="c" items="${categories}">
                                                <option>${c.name}</option>
                                            </c:forEach>
                                        </select>
                                    </div>
                                    <div class="mb-4 col">
                                        <label for="price">Enter Price</label> 
                                        <input type="number" id="price" name="price" value="${product.price}" class="form-control">
                                    </div>
                                </div>

                                <div class="row">
                                    <div class="mb-4 col">
                                        <label for="discount">Discount</label> 
                                        <input type="number" id="discount" name="discount" value="${product.discount}" class="form-control">
                                    </div>
                                    <div class="mb-4 col">
                                        <label for="discountPrice">Discount Price</label> 
                                        <input type="number" id="discountPrice" readonly value="${product.discountPrice}" class="form-control">
                                    </div>
                                </div>

                                <div class="mb-4">
                                    <label>Status</label>
                                    <div class="form-check">
                                        <input class="form-check-input" type="radio" value="true" name="isActive" id="active" <c:if test="${product.isActive}">checked</c:if>>
                                        <label class="form-check-label" for="active">Active</label>
                                    </div>
                                    <div class="form-check">
                                        <input class="form-check-input" type="radio" value="false" name="isActive" id="inactive" <c:if test="${not product.isActive}">checked</c:if>>
                                        <label class="form-check-label" for="inactive">Inactive</label>
                                    </div>
                                </div>

                                <div class="row">
                                    <div class="mb-4 col">
                                        <label for="stock">Enter Stock</label> 
                                        <input type="text" id="stock" name="stock" value="${product.stock}" class="form-control">
                                    </div>

                                    <div class="mb-4 col">
                                        <label for="file">Upload Image</label> 
                                        <input type="file" id="file" name="file" class="form-control">
                                    </div>

                                    <div class="mt-3 text-center">
                                        <img src="${pageContext.request.contextPath}/img/product_img/${product.image}" class="img-thumbnail" alt="Product Image" width="150">
                                    </div>
                                </div>

                                <button type="submit" class="btn btn-primary col-md-12">Update</button>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- Bootstrap JS and dependencies -->
    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.3/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>
