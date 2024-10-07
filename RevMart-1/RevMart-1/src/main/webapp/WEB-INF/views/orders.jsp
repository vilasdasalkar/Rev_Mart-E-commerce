<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@include file="./base.jsp" %>
<%@ page import="java.util.List" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="ISO-8859-1">
    <title>All Orders</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/5.3.0/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <style>
        body {
            background: linear-gradient(135deg, #3f8da7, #3a8181);
            color: #316ca2;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }

        .page-header {
            text-align: center;
            margin-top: 2rem;
            font-size: 2.5rem;
            font-weight: 700;
            color: #0b0c0e;
            animation: fadeIn 1s ease;
        }

        @keyframes fadeIn {
            from {
                opacity: 0;
            }
            to {
                opacity: 1;
            }
        }

        .table {
            width: 100%;
            margin-bottom: 2rem;
            background-color: rgb(6, 5, 10);
            border-radius: 0.5rem;
            overflow: hidden;
            box-shadow: 0 0 20px rgba(9, 147, 55, 0.05);
            animation: slideIn 0.8s ease;
        }

        @keyframes slideIn {
            from {
                transform: translateY(20px);
                opacity: 0;
            }
            to {
                transform: translateY(0);
                opacity: 1;
            }
        }

        .table thead th {
            background-color: #08090a;
            color: #fff;
            text-align: center;
            padding: 1rem;
            border-bottom: 2px solid #dee2e6;
        }

        .table tbody tr {
            border-bottom: 1px solid #2f1a85;
        }

        .table tbody tr:nth-child(odd) {
            background-color: #3169a0;
        }

        .table tbody tr:hover {
            background-color: #3d6e9f;
            transition: background-color 0.3s ease;
        }

        .table td {
            padding: 1rem;
            vertical-align: middle;
            color: #31638e;
        }

        .btn-primary, .btn-dark {
            background-color: #677a8e;
            border: none;
            border-radius: 0.5rem;
            font-weight: 600;
            transition: background-color 0.3s ease, transform 0.3s ease;
        }

        .btn-primary:hover, .btn-dark:hover {
            background-color: #0b1cd7;
            transform: scale(1.05);
        }

        .alert {
            border-radius: 0.5rem;
            margin-bottom: 1.5rem;
            padding: 1rem;
            box-shadow: 0 0 15px rgba(0, 0, 0, 0.1);
        }

        .pagination {
            justify-content: center;
            margin-top: 1.5rem;
        }

        .pagination .page-item.active .page-link {
            background-color: #0dfd7d;
            border-color: #0d6efd;
            color: #fff;
        }

        .pagination .page-link {
            border-radius: 0.5rem;
            margin: 0 0.2rem;
            padding: 0.5rem 1rem;
            transition: background-color 0.3s ease;
        }

        .pagination .page-link:hover {
            background-color: #f1f1f1;
        }

        .form-control {
            border-radius: 0.5rem;
            border: 1px solid #ced4da;
            transition: border-color 0.3s ease, box-shadow 0.3s ease;
        }

        .form-control:focus {
            border-color: #0d6efd;
            box-shadow: 0 0 0 0.2rem rgba(13, 110, 253, 0.25);
        }

        .input-group .form-control {
            border-radius: 0.5rem 0 0 0.5rem;
        }

        .input-group .btn {
            border-radius: 0 0.5rem 0.5rem 0;
        }

        .btn-close {
            background-color: transparent;
            border: none;
            font-size: 1rem;
        }

        @media (max-width: 768px) {
            .table thead th, .table td {
                font-size: 0.875rem;
                padding: 0.75rem;
            }
        }

        @media (max-width: 576px) {
            .page-header {
                font-size: 1.75rem;
            }

            .form-control, .btn-primary {
                font-size: 0.875rem;
            }
        }
    </style>
</head>
<body>
    <section>
        <div class="container-fluid mt-5 p-4">
            <div class="row">
                <div class="col-12">
                    <p class="page-header">All Orders</p>
                    <hr>
                    <a href="/admin/" class="text-decoration-none mb-3 d-inline-block"><i class="fa-solid fa-arrow-left"></i> Back</a>

                    <!-- Success message -->
                    <c:if test="${not empty sessionScope.succMsg}">
                        <div class="alert alert-success alert-dismissible fade show" role="alert">
                            <strong>Success!</strong> ${sessionScope.succMsg}
                            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                        </div>
                        <c:set var="null" value="${sessionScope.succMsg}" scope="session" />
                    </c:if>

                    <!-- Error message -->
                    <c:if test="${not empty sessionScope.errorMsg}">
                        <div class="alert alert-danger alert-dismissible fade show" role="alert">
                            <strong>Error!</strong> ${sessionScope.errorMsg}
                            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                        </div>
                        <c:set var="null" value="${sessionScope.errorMsg}" scope="session" />
                    </c:if>

                    <div class="col-md-4 mb-4">
                        <form action="/admin/search-order" method="get">
                            <div class="input-group">
                                <input type="text" class="form-control" name="orderId" placeholder="Enter order ID">
                                <button class="btn btn-primary" type="submit">Search</button>
                            </div>
                        </form>
                    </div>

                    <div class="col-md-12">
                        <table class="table">
                            <thead>
                                <tr>
                                    <th scope="col">Order ID</th>
                                    <th scope="col">Deliver Details</th>
                                    <th scope="col">Date</th>
                                    <th scope="col">Product Details</th>
                                    <th scope="col">Price</th>
                                    <th scope="col">Status</th>
                                    <th scope="col">Action</th>
                                </tr>
                            </thead>
                            <tbody>

                                <!-- If search result exists -->
                                <c:if test="${srch}">
                                    <c:choose>
                                        <c:when test="${not empty orderDtls}">
                                            <tr>
                                                <th scope="row">${orderDtls.orderId}</th>
                                                <td>
                                                    <p><strong>Name:</strong> ${orderDtls.orderAddress.firstName} ${orderDtls.orderAddress.lastName}</p>
                                                    <p><strong>Email:</strong> ${orderDtls.orderAddress.email}</p>
                                                    <p><strong>Mobno:</strong> ${orderDtls.orderAddress.mobileNo}</p>
                                                    <p><strong>Address:</strong> ${orderDtls.orderAddress.address}</p>
                                                    <p><strong>City:</strong> ${orderDtls.orderAddress.city}</p>
                                                    <p><strong>State:</strong> ${orderDtls.orderAddress.state}, ${orderDtls.orderAddress.pincode}</p>
                                                </td>
                                                <td>${orderDtls.orderDate}</td>
                                                <td>${orderDtls.product.title}</td>
                                                <td>
                                                    <p><strong>Quantity:</strong> ${orderDtls.quantity}</p>
                                                    <p><strong>Price:</strong> ${orderDtls.price}</p>
                                                    <p><strong>Total Price:</strong> ${orderDtls.quantity * orderDtls.price}</p>
                                                </td>
                                                <td>${orderDtls.status}</td>
                                                <td>
                                                    <form action="/admin/update-order-status" method="post">
                                                        <div class="input-group">
                                                            <select class="form-control" name="st">
                                                                <option>--select--</option>
                                                                <option value="1">In Progress</option>
                                                                <option value="2">Order Received</option>
                                                                <option value="3">Product Packed</option>
                                                                <option value="4">Out for Delivery</option>
                                                                <option value="5">Delivered</option>
                                                                <option value="6">Cancelled</option>
                                                            </select>
                                                            <input type="hidden" name="id" value="${orderDtls.id}">
                                                            <button class="btn btn-primary btn-sm" type="${orderDtls.status == 'Cancelled' || orderDtls.status == 'Delivered' ? 'button' : 'submit'}" ${orderDtls.status == 'Cancelled' || orderDtls.status == 'Delivered' ? 'disabled' : ''}>Update</button>
                                                        </div>
                                                    </form>
                                                </td>
                                            </tr>
                                        </c:when>
                                        <c:otherwise>
                                            <tr>
                                                <td colspan="7" class="text-center">No order found with ID ${param.orderId}</td>
                                            </tr>
                                        </c:otherwise>
                                    </c:choose>
                                </c:if>

                                <!-- Display all orders if no search -->
                                <c:if test="${not srch}">
                                    <c:forEach var="o" items="${orders}">
                                        <tr>
                                            <th scope="row">${o.orderId}</th>
                                            <td>
                                                <p><strong>Name:</strong> ${o.orderAddress.firstName} ${o.orderAddress.lastName}</p>
                                                <p><strong>Email:</strong> ${o.orderAddress.email}</p>
                                                <p><strong>Mobno:</strong> ${o.orderAddress.mobileNo}</p>
                                                <p><strong>Address:</strong> ${o.orderAddress.address}</p>
                                                <p><strong>City:</strong> ${o.orderAddress.city}</p>
                                                <p><strong>State:</strong> ${o.orderAddress.state}, ${o.orderAddress.pincode}</p>
                                            </td>
                                            <td>${o.orderDate}</td>
                                            <td>${o.product.title}</td>
                                            <td>
                                                <p><strong>Quantity:</strong> ${o.quantity}</p>
                                                <p><strong>Price:</strong> ${o.price}</p>
                                                <p><strong>Total Price:</strong> ${o.quantity * o.price}</p>
                                            </td>
                                            <td>${o.status}</td>
                                            <td>
                                                <form action="/admin/update-order-status" method="post">
                                                    <div class="input-group">
                                                        <select class="form-control" name="st">
                                                            <option>--select--</option>
                                                            <option value="1">In Progress</option>
                                                            <option value="2">Order Received</option>
                                                            <option value="3">Product Packed</option>
                                                            <option value="4">Out for Delivery</option>
                                                            <option value="5">Delivered</option>
                                                            <option value="6">Cancelled</option>
                                                        </select>
                                                        <input type="hidden" name="id" value="${o.id}">
                                                        <button class="btn btn-dark btn-sm" type="${o.status == 'Cancelled' || o.status == 'Delivered' ? 'button' : 'submit'}" ${o.status == 'Cancelled' || o.status == 'Delivered' ? 'disabled' : ''}>Update</button>
                                                    </div>
                                                </form>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </c:if>
                            </tbody>
                        </table>

                        <!-- Pagination section -->
                        <c:if test="${not srch}">
                            <div class="row">
                                <div class="col-md-4 mb-3">Total Orders: ${totalElements}</div>
                                <div class="col-md-8">
                                    <nav aria-label="Page navigation">
                                        <ul class="pagination">
                                            <li class="page-item ${isFirst ? 'disabled' : ''}">
                                                <a class="page-link" href="/admin/orders?pageNo=${pageNo-1}" aria-label="Previous">
                                                    <span aria-hidden="true">&laquo;</span>
                                                </a>
                                            </li>

                                            <c:forEach var="i" begin="1" end="${totalPages}">
                                                <li class="page-item ${pageNo+1 == i ? 'active' : ''}">
                                                    <a class="page-link" href="/admin/orders?pageNo=${i-1}">${i}</a>
                                                </li>
                                            </c:forEach>

                                            <li class="page-item ${isLast ? 'disabled' : ''}">
                                                <a class="page-link" href="/admin/orders?pageNo=${pageNo+1}" aria-label="Next">
                                                    <span aria-hidden="true">&raquo;</span>
                                                </a>
                                            </li>
                                        </ul>
                                    </nav>
                                </div>
                            </div>
                        </c:if>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/5.3.0/js/bootstrap.min.js"></script>
</body>
</html>
