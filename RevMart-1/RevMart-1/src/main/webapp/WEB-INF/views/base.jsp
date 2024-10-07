<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="ISO-8859-1">
    <title>Insert title here</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
 <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    <!-- Internal CSS -->
    <style>
        body {
            padding-top: 56px; /* Adjust based on navbar height */
        }
        
        /* Navbar styles */
        .navbar {
            background: linear-gradient(0.25turn, #3f87a6, #ebf8e1, #f69d3c); /* Black background */
        }
        .navbar-nav .nav-link {
            color: #fff !important; /* White text color */
        }
        .navbar-nav .nav-link.active, 
        .navbar-nav .nav-link:hover {
            color: #ddd !important; /* Lighter gray for hover/active state */
        }
        .navbar-brand {
            color: #fff !important; /* White text color for brand */
        }
        .navbar-toggler-icon {
            background-image: url('data:image/svg+xml;charset=utf8,%3Csvg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke="currentColor"%3E%3Cpath stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M4 6h16M4 12h16M4 18h16" /%3E%3C/svg%3E');
        }
        .dropdown-menu {
            background-color: #333; /* Darker background for dropdown */
        }
        .dropdown-item {
            color: #fff; /* White text for dropdown items */
        }
        .dropdown-item:hover {
            background-color: #555; /* Lighter gray for hover effect */
        }
       
        .cart-count {
            position: relative;
            top: -35px;
            right: -10px;
            background-color: red;
            color: white;
            border-radius: 50%;
            padding: 2px 5px;
            font-size: 0.75rem;
            font-weight: bold;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 7px;
        }
        
    </style>
</head>
<body>
    <!-- Start Navbar -->
    <nav class="navbar navbar-expand-lg navbar-dark fixed-top">
        <div class="container-fluid">
            <a class="navbar-brand" href="#"> RevMart</a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent"
                    aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarSupportedContent">
                <ul class="navbar-nav me-auto mb-2 mb-lg-0">
                    <c:choose>
                        <c:when test="${empty user}">
                            <li class="nav-item"><a class="nav-link active" aria-current="page" href="/"></i> Home</a></li>
                        </c:when>
                        <c:otherwise>
                            <c:if test="${user.role == 'ROLE_ADMIN'}">
                                <li class="nav-item"><a class="nav-link active" aria-current="page" href="/admin/"> Home</a></li>
                            </c:if>
                            <c:if test="${user.role == 'ROLE_USER'}">
                                <li class="nav-item"><a class="nav-link active" aria-current="page" href="/"></i> Home</a></li>
                                                             <li class="nav-item"><a class="nav-link active" aria-current="page" href="/user/wishlist"><i class="fa-solid fa-heart"></i> Wishlist</a></li>
                                
                            </c:if>
                        </c:otherwise>
                    </c:choose>

                    <li class="nav-item"><a class="nav-link active" aria-current="page" href="/products">Product</a></li>
                  

              
                </ul>

                <ul class="navbar-nav ms-auto mb-2 mb-lg-0">
                    <c:choose>
                        <c:when test="${empty user}">
                            <li class="nav-item"><a class="nav-link active" aria-current="page" href="/signin"></i> LOGIN</a></li>
                            <li class="nav-item"><a class="nav-link active" aria-current="page" href="/register">REGISTER</a></li>
                        </c:when>
                        <c:otherwise>
                            <c:if test="${user.role == 'ROLE_USER'}">
                                <li class="nav-item pr-3"> <a class="nav-link active" href="/user/cart">
                                        <i class="fa-solid fa-cart-shopping"></i>
                                        <span class="cart-count">${countCart}</span>
                                    </a></li>
                            </c:if>
                            <li class="nav-item dropdown">
                                <a class="nav-link dropdown-toggle active" href="#" role="button" data-bs-toggle="dropdown" aria-expanded="false">
                                    <i class="fa-solid fa-user"></i> 
                                </a>
                                <ul class="dropdown-menu">
                                    <c:if test="${user.role == 'ROLE_USER'}">
                                        <li><a class="dropdown-item" href="/user/profile">Profile</a></li>
                                    </c:if>
                                    <c:if test="${user.role == 'ROLE_ADMIN'}">
                                        <li><a class="dropdown-item" href="/admin/profile">Profile</a></li>
                                    </c:if>
                                    <c:if test="${user.role == 'ROLE_USER'}">
                                        <li><a class="dropdown-item" href="/user/user-orders">My Orders</a></li>
                                    </c:if>
                                    <li><a class="dropdown-item" href="/logout">Logout</a></li>
                                </ul>
                            </li>
                        </c:otherwise>
                    </c:choose>
                </ul>
            </div>
        </div>
    </nav>
    <!-- End Navbar -->

    <div>
        <!-- Content to be included here -->
    </div>

    <!-- Start Footer -->
  
    <!-- End Footer -->

    <!-- JavaScript -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
