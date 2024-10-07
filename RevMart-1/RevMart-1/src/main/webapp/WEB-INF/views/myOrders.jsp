<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@include file="./base.jsp" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="ISO-8859-1">
    <title>My Orders</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css">
    <style>
        /* Global Styles */
        body {
            background-color: #531ba1;
        }
        
        .container {
            background-color: #8573a3;
            padding: 20px;
            border: 1px solid #87caa500;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }
        
        /* Table Styles */
        .table {
            margin-top: 20px;
        }
        
        .table th, .table td {
            padding: 10px;
            border-bottom: 1px solid #ddd;
        }
        
        .table th {
            background-color: #f0f0f0;
        }
        
        .table-striped tbody tr:nth-of-type(odd) {
            background-color: #f9f9f9;
        }
        
        .table-striped tbody tr:nth-of-type(even) {
            background-color: #fff;
        }
        
        /* Utility Classes */
        .text-center {
            text-align: center;
        }
        
        .fs-3 {
            font-size: 1.5rem;
        }
    </style>
</head>
<body>
    <section>
        <div class="container mt-5 p-5">
            <div class="row">
                <h2 class="text-center fs-3">My Orders</h2>
                
                <!-- Success and Error Messages -->
                <c:if test="${sessionScope.succMsg != null}">
                    <p class="text-success fw-bold text-center">${sessionScope.succMsg}</p>
                    <c:out value="${sessionScope.succMsg}"/>
                    <c:out value="${commnServiceImpl.removeSessionMessage()}"/>
                </c:if>
                
                <c:if test="${sessionScope.errorMsg != null}">
                    <p class="text-danger fw-bold text-center">${sessionScope.errorMsg}</p>
                    <c:out value="${sessionScope.errorMsg}"/>
                    <c:out value="${commnServiceImpl.removeSessionMessage()}"/>
                </c:if>

                <!-- Orders Table -->
                <div class="col-md-12">
                    <table class="table table-striped">
                        <thead>
                            <tr>
                                <th scope="col">Order Id</th>
                                <th scope="col">Date</th>
                                <th scope="col">Product Details</th>
                                <th scope="col">Price</th>
                                <th scope="col">Status</th>
                                <th scope="col">Action</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="o" items="${orders}">
                                <tr>
                                    <th scope="row">${o.orderId}</th>
                                    <td>${o.orderDate}</td>
                                    <td>${o.product.title}</td>
                                    <td>
                                        <p>Quantity: ${o.quantity}</p>
                                        <p>Price: ${o.price}</p>
                                        <p>Total Price: ${o.quantity * o.price}</p>
                                    </td>
                                    <td>${o.status}</td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${o.status != 'Cancelled'}">
                                                <a href="${pageContext.request.contextPath}/user/update-status?id=${o.id}&st=6" class="btn btn-sm btn-danger">Cancel</a>
                                            </c:when>
                                            <c:otherwise>
                                                <a href="#" class="btn btn-sm btn-danger disabled">Cancel</a>
                                            </c:otherwise>
                                        </c:choose>
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