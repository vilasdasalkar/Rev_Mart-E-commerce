<%@include file="./base.jsp" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="ISO-8859-1">
    <title>Admin Dashboard</title>
    <style>
        body {
            background-color: #f4f7f8;
        }
        .container {
            background-color: #ffffff;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }
        .card {
            border: none;
            border-radius: 8px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        }
        .card img {
            width: 60px;
            height: 60px;
            object-fit: contain;
        }
        .card-title {
            font-size: 1.25rem;
            margin-top: 1rem;
            color: #333;
        }
        .card-body {
            padding: 2rem;
            text-align: center;
        }
        .icon {
            font-size: 3rem;
            color: #007bff;
        }

    </style>
</head>
<body>
    <section>
        <div class="container p-5">
            <p class="text-center fs-3 mt-4 ">Admin Dashboard</p>
            <div class="row p-5">
                <div class="col-md-4 mt-2">
                    <a href="/admin/loadAddProduct" class="text-decoration-none">
                        <div class="card card-sh">
                            <div class="card-body">
                                <img src="/img/Images/Productsi.png" class="img-fluid" alt="Product">
                                <h4 class="card-title">Add Product</h4>
                            </div>
                        </div>
                    </a>
                </div>

                <div class="col-md-4 mt-2">
                    <a href="/admin/category" class="text-decoration-none">
                        <div class="card card-sh">
                            <div class="card-body">
                                <img src="/img/Images/cat.png" class="img-fluid" alt="Add Category">
                                <h4 class="card-title">Add Category</h4>
                            </div>
                        </div>
                    </a>
                </div>

                <div class="col-md-4 mt-2">
                    <a href="/admin/products" class="text-decoration-none">
                        <div class="card card-sh">
                            <div class="card-body">
                                <img src="/img/Images/prod.png" class="img-fluid" alt="View Product">
                                <h4 class="card-title">View Product</h4>
                            </div>
                        </div>
                    </a>
                </div>

                <div class="col-md-4 mt-4">
                    <a href="/admin/orders" class="text-decoration-none">
                        <div class="card card-sh">
                            <div class="card-body">
                                <img src="/img/Images/orderi.png" class="img-fluid" alt="Orders">
                                <h4 class="card-title">Orders</h4>
                            </div>
                        </div>
                    </a>
                </div>

                <div class="col-md-4 mt-4">
                    <a href="/admin/users?type=1" class="text-decoration-none">
                        <div class="card card-sh">
                            <div class="card-body">
                                <img src="/img/Images/useri.png" class="img-fluid" alt="Users">
                                <h4 class="card-title">Users</h4>
                            </div>
                        </div>
                    </a>
                </div>

                <div class="col-md-4 mt-4">
                    <a href="/admin/add-admin" class="text-decoration-none">
                        <div class="card card-sh">
                            <div class="card-body">
                                <img src="/img/Images/admini.png" class="img-fluid" alt="Add Admin">
                                <h4 class="card-title">Add Admin</h4>
                            </div>
                        </div>
                    </a>
                </div>

                <div class="col-md-4 mt-4">
                    <a href="/admin/users?type=2" class="text-decoration-none">
                        <div class="card card-sh">
                            <div class="card-body">
                                <img src="/img/Images/admin.png" class="img-fluid" alt="Admin">
                                <h4 class="card-title">Admin</h4>
                            </div>
                        </div>
                    </a>
                </div>
            </div>
        </div>
    </section>
</body>
</html>
