<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ include file="base.jsp" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="ISO-8859-1">
    <title>Product Details</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">

    <!-- Internal CSS -->
    <style>
        body {
            background-color: #f8f9fa; /* Light background for the page */
            font-family: Arial, sans-serif;
        }

        .card-sh {
            border-radius: 15px; /* More rounded corners for the card */
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1); /* Subtle shadow effect */
            overflow: hidden; /* Ensure no content spills out */
        }

        .text-success {
            color: #28a745 !important; /* Consistent green for success messages */
        }

        .text-danger {
            color: #dc3545 !important; /* Consistent red for error messages */
        }

       

        .btn-danger {
            background-color: #dc3545;
            border-color: #dc3545;
        }

        .btn-danger:hover {
            background-color: #c82333;
            border-color: #bd2130;
        }

        .btn-warning {
            background-color: #ffc107;
            border-color: #ffc107;
        }

        .btn-warning:hover {
            background-color: #e0a800;
            border-color: #d39e00;
        }

        .btn-primary {
            background-color: #007bff;
            border-color: #007bff;
        }

        .btn-primary:hover {
            background-color: #0056b3;
            border-color: #004085;
        }

        .fs-3 {
            font-size: 2rem; /* Larger font size for titles */
            font-weight: 700; /* Bolder text */
        }

        .fs-5 {
            font-size: 1.5rem; /* Slightly larger font size for prices */
        }

        .fs-6 {
            font-size: 1.2rem; /* Adjusted font size for discount and original price */
        }

        .p-5 {
            padding: 4rem; /* Increased padding */
        }

        .mt-5 {
            margin-top: 4rem; /* Increased margin-top */
        }

        .mt-3 {
            margin-top: 2rem; /* Increased margin-top */
        }

        .text-center {
            text-align: center;
        }

        .border {
            border: 1px solid #ddd;
            border-radius: 10px; /* Rounded corners for borders */
        }

        .p-3 {
            padding: 1.5rem; /* Increased padding for better spacing */
        }

        .mb-3 {
            margin-bottom: 1.5rem; /* Increased margin-bottom */
        }

        .badge-success {
            background-color: #28a745;
            color: white;
        }

        .badge-warning {
            background-color: #ffc107;
            color: black;
        }

        .img-fluid {
            border-radius: 10px; /* Rounded corners for images */
        }

        .review-form, .review-list {
            background-color: #fff;
            border-radius: 10px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1); /* Shadow for better visibility */
            padding: 2rem; /* Padding for the form and review list */
        }
        
        .buy-now-container {
            display: flex;
            gap: 1rem;
        }

        @media (max-width: 767.98px) {
            .buy-now-container {
                flex-direction: column;
                align-items: stretch;
            }
        }
    </style>
</head>
<body>
    <section>
        <div class="container card-sh" style="margin-top: 70px; margin-bottom: 100px">
            <div class="row">
                <div class="col-md-12 p-5">
                    <c:if test="${sessionScope.succMsg != null}">
                        <p class="text-success alert alert-success text-center" role="alert">${sessionScope.succMsg}</p>
                        <c:out value="${commnServiceImpl.removeSessionMessage()}"/>
                    </c:if>

                    <c:if test="${sessionScope.errorMsg != null}">
                        <p class="text-danger text-center alert alert-danger">${sessionScope.errorMsg}</p>
                        <c:out value="${commnServiceImpl.removeSessionMessage()}"/>
                    </c:if>

                    <div class="row">
                        <div class="col-md-6 text-center text-md-end">
                            <img alt="${product.title}" src="${pageContext.request.contextPath}/img/product_img/${product.image}" class="img-fluid rounded" style="max-width: 100%; height: auto;">
                        </div>

                        <div class="col-md-6">
                            <p class="fs-3">${product.title}</p>
                            <p>
                                <span class="fw-bold">Description:</span><br>${product.description}
                            </p>
                            <p>
                                <span class="fw-bold">Product Details:</span><br>
                                Status:
                                <c:choose>
                                    <c:when test="${product.stock > 0}">
                                        <span class="badge badge-success">Available</span>
                                    </c:when>
                                    <c:otherwise>
                                        <span class="badge badge-warning">Out of Stock</span>
                                    </c:otherwise>
                                </c:choose>
                                <br>Category: ${product.category}<br>
                                Policy: 7 Days Replacement & Return
                            </p>
                            <p class="fs-5 fw-bold">
                                Price: &nbsp; &nbsp; &nbsp; &nbsp;
                                <i class="fas fa-rupee-sign"></i> ${product.discountPrice} 
                                <span class="fs-6 text-decoration-line-through text-secondary">${product.price}</span>
                                <span class="fs-6 text-success">${product.discount}% off</span>
                            </p>

                            <div class="buy-now-container">
                                <c:choose>
                                    <c:when test="${product.stock > 0}">
                                        <c:choose>
                                            <c:when test="${user == null}">
                                                <a href="${pageContext.request.contextPath}/signin" class="btn btn-danger">Add To Cart</a>
                                            </c:when>
                                            <c:otherwise>
                                                <a href="${pageContext.request.contextPath}/user/addCart?pid=${product.id}&uid=${user.id}" class="btn btn-danger">Add To Cart</a>
                                            </c:otherwise>
                                        </c:choose>
                                    </c:when>
                                    <c:otherwise>
                                        <a href="#" class="btn btn-warning">Out of Stock</a>
                                    </c:otherwise>
                                </c:choose>

                                <c:if test="${product.stock > 0}">
                                    <div>
                                        <!-- Buy Now Button -->
                                        <form action="${pageContext.request.contextPath}/user/cart" method="get">
                                        <input type="hidden" name="pid" value="${product.id}">
                                            <button type="submit" class="btn btn-primary">Buy Now</button>
                                        </form>
                                    </div>
                                </c:if>
                            </div>

                            <!-- Review Form -->
                            <div class="review-form mt-5">
                                <h3>Leave a Review:</h3>
                                <c:if test="${user != null}">
                                    <form action="${pageContext.request.contextPath}/saveReview" method="post">
                                        <input type="hidden" name="productId" value="${product.id}">
                                        <input type="hidden" name="userId" value="${user.id}">
                                        <div class="form-group">
                                            <label for="rating">Rating:</label>
                                            <input type="number" name="rating" id="rating" class="form-control" min="1" max="5" required>
                                        </div>
                                        <div class="form-group mt-2">
                                            <label for="comment">Comment:</label>
                                            <textarea name="comment" id="comment" class="form-control" rows="4" required></textarea>
                                        </div>
                                        <button type="submit" class="btn btn-primary mt-3">Submit Review</button>
                                    </form>
                                </c:if>
                                <c:if test="${user == null}">
                                    <p>Please <a href="${pageContext.request.contextPath}/signin">sign in</a> to leave a review.</p>
                                </c:if>
                            </div>

                            <!-- Display Reviews -->
                            <div class="review-list mt-5">
                                <h3>Reviews:</h3>
                                <c:forEach var="review" items="${reviews}">
                                    <div class="border p-3 mb-3">
                                        <p><strong>${review.user.name}</strong> - <span>${review.rating} Stars</span></p>
                                        <p>${review.comment}</p>
                                        <p><small>Date: ${fn:substring(review.date, 0, 19)}</small></p>
                                    </div>
                                </c:forEach>
                                <c:if test="${empty reviews}">
                                    <p>No reviews yet. Be the first to leave a review!</p>
                                </c:if>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
   
    
</body>
</html>
