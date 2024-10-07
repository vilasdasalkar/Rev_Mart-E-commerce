<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ include file="./base.jsp" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="ISO-8859-1">
    <title>Wishlist</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css"> <!-- Font Awesome for icons -->
    <link rel="stylesheet" href="path/to/your/css/styles.css"> <!-- Link to your CSS file -->
    <style>
        body {
            background-color: #f0f8f4; /* Soft background color */
            font-family: 'Arial', sans-serif;
        }
        .container {
            max-width: 1200px;
            margin: auto;
        }
        .alert {
            padding: 15px;
            border-radius: 5px;
            margin-bottom: 20px;
        }
        .alert-success {
            background-color: #d4edda;
            color: #155724;
        }
        .alert-danger {
            background-color: #f8d7da;
            color: #0f0c0d;
        }
        h3 {
            color: #333;
            text-align: center;
            margin-top: 40px;
            margin-bottom: 20px;
        }
        .card {
            border: 1px solid #e0e0e0;
            border-radius: 10px;
            transition: transform 0.3s;
        }
        .card:hover {
            transform: scale(1.05);
        }
        .btn {
            padding: 10px 15px;
            border-radius: 5px;
            color: white;
            text-decoration: none;
        }
        .btn-primary {
            background-color: #12b5a5;
        }
        .btn-danger {
            background-color: #121010;
        }
        .text-center {
            text-align: center;
        }
        .mt-5 {
            margin-top: 3rem !important;
        }
    </style>
</head>
<body>
    <!-- Display messages if any -->
    <c:if test="${not empty succMsg}">
        <div class="alert alert-success">
            <i class="fas fa-check-circle"></i> ${succMsg}
        </div>
        <c:remove var="succMsg" />
    </c:if>

    <c:if test="${not empty errorMsg}">
        <div class="alert alert-danger">
            <i class="fas fa-exclamation-circle"></i> ${errorMsg}
        </div>
        <c:remove var="errorMsg" />
    </c:if>

    <section>
        <div class="container mt-5">
            <h3>Your Wishlist</h3>
            <c:if test="${not empty wishlist}">
                <div class="row">
                    <c:forEach var="item" items="${wishlist}">
                        <div class="col-md-3 mt-2">
                            <div class="card">
                                <div class="card-body text-center">
                                    <img alt="${item.product.title}" src="/img/product_img/${item.product.image}" width="150" height="150">
                                    <p class="fs-5 text-center">${item.product.title}</p>
                                    <a href="/product/${item.product.id}" class="btn btn-primary">
                                        <i class="fas fa-eye"></i> View Details
                                    </a>
                                    <a href="/user/removeWishlist?productId=${item.product.id}" class="btn btn-danger mt-2">
                                        <i class="fas fa-trash"></i> Remove from Wishlist
                                    </a>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </div>
            </c:if>
            <c:if test="${empty wishlist}">
                <p class="text-center text-muted">Your wishlist is empty</p>
            </c:if>
        </div>
    </section>
</body>
</html>
