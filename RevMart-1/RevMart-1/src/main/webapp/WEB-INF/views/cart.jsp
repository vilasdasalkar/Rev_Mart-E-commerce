<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@include file="./base.jsp" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="ISO-8859-1">
    <title>Cart Page</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <style>
        /* Advanced Styling for Cart Page */
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: linear-gradient(135deg, #0d92e4, #a70dc6);
            margin: 0;
            padding: 0;
        }

        .container-fluid {
            max-width: 1200px;
            margin: auto;
        }

        .card-sh {
            background-color: white;
            border-radius: 15px;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
            overflow: hidden;
        }

        .card-header {
            background: #343a40;
            color: #fff;
            padding: 1.5rem;
            border-radius: 15px 15px 0 0;
        }

        .card-header p {
            margin: 0;
            font-size: 1.8rem;
            font-weight: 600;
            letter-spacing: 1px;
        }

        .card-body {
            padding: 2rem;
        }

        .table {
            width: 100%;
            background-color: #fff;
            border-radius: 10px;
            overflow: hidden;
        }

        th, td {
            padding: 1.5rem;
            text-align: center;
            border-top: 1px solid #e9ecef;
        }

        .table th {
            background-color: #007bff;
            color: white;
            text-transform: uppercase;
            font-weight: bold;
        }

        .table td {
            vertical-align: middle;
            font-size: 1rem;
            color: #6c757d;
        }

        .table img {
            border-radius: 10px;
        }

        .text-center {
            text-align: center;
        }

        /* Button Styles */
        .btn {
            padding: 12px 24px;
            border: none;
            border-radius: 50px;
            text-decoration: none;
            color: white;
            font-size: 16px;
            cursor: pointer;
            background-image: linear-gradient(135deg, #0dc613, #0a8c47);
            transition: background 0.3s ease;
        }

        .btn:hover {
            background-image: linear-gradient(135deg, #09d238, #12824a);
        }

        .btn-warning {
            background-color: #ffc107;
            color: black;
        }

        .btn-warning:hover {
            background-color: #ffcd39;
            color: white;
        }

        .btn i {
            margin: 0 5px;
        }

        .fw-bold {
            font-weight: 700;
        }

        /* Message styles */
        .text-success {
            color: #28a745;
            font-weight: bold;
        }

        .text-danger {
            color: #dc3545;
            font-weight: bold;
        }

        /* Responsive table for smaller devices */
        @media (max-width: 768px) {
            .table thead {
                display: none;
            }

            .table tr {
                display: block;
                margin-bottom: 1rem;
                border: 1px solid #dee2e6;
            }

            .table td {
                display: block;
                text-align: right;
                padding: 0.75rem;
                position: relative;
            }

            .table td:before {
                content: attr(data-label);
                position: absolute;
                left: 0;
                top: 0;
                background-color: #007bff;
                color: white;
                padding: 0.75rem;
                font-weight: bold;
                border-right: 1px solid #dee2e6;
                width: 150px;
                text-align: left;
            }
        }
    </style>
</head>
<body>
    <section>
        <div class="container-fluid mt-5 p-5">
            <div class="card card-sh">
                <div class="card-header text-center">
                    <p class="fs-4">Cart Page</p>

                    <!-- Display success message -->
                    <c:if test="${not empty sessionScope.succMsg}">
                        <p class="text-success fw-bold">${sessionScope.succMsg}</p>
                        <c:remove var="sessionScope.succMsg" />
                    </c:if>

                    <!-- Display error message -->
                    <c:if test="${not empty sessionScope.errorMsg}">
                        <p class="text-danger fw-bold">${sessionScope.errorMsg}</p>
                        <c:remove var="sessionScope.errorMsg" />
                    </c:if>
                </div>

                <div class="card-body">
                    <table class="table">
                        <thead>
                            <tr>
                                <th scope="col">Sl No</th>
                                <th scope="col">Image</th>
                                <th scope="col">Product Name</th>
                                <th scope="col">Price</th>
                                <th scope="col" class="text-center">Quantity</th>
                                <th scope="col">Total Price</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="cart" items="${carts}" varStatus="status">
                                <tr>
                                    <th scope="row">${status.index + 1}</th>
                                    <td>
                                        <img src="${pageContext.request.contextPath}/img/product_img/${cart.product.image}" width="70px" height="70px">
                                    </td>
                                    <td>${cart.product.title}</td>
                                    <td>&#8377; ${cart.product.discountPrice}</td>
                                    <td class="text-center">
                                        <a href="${pageContext.request.contextPath}/user/cartQuantityUpdate?sy=de&cid=${cart.id}" class="btn btn-warning">
                                            <i class="fa-solid fa-minus"></i>
                                        </a> [ ${cart.quantity} ] 
                                        <a href="${pageContext.request.contextPath}/user/cartQuantityUpdate?sy=in&cid=${cart.id}" class="btn btn-warning">
                                            <i class="fa-solid fa-plus"></i>
                                        </a>
                                    </td>
                                    <td>&#8377; ${cart.totalPrice}</td>
                                </tr>
                            </c:forEach>
                            <tr>
                                <td colspan="4"></td>
                                <td class="fw-bold">Total Price</td>
                                <td class="fw-bold">&#8377; ${totalOrderPrice}</td>
                            </tr>
                        </tbody>
                    </table>
                    <div class="text-center">
                        <a href="${pageContext.request.contextPath}/user/orders" class="btn btn-warning">Proceed Payment</a>
                    </div>
                </div>
            </div>
        </div>
    </section>
</body> 
</html>
