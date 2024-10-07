<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@include file="./base.jsp" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="ISO-8859-1">
    <title>My Profile</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <style>
        body {
            background-color: #f7f7f7;
        }

        .profile-card {
            background-color: #fff;
            border-radius: 15px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            padding: 2rem;
        }

        .profile-card img {
            width: 110px;
            height: 110px;
            border-radius: 50%;
            object-fit: cover;
        }

        .profile-card input.form-control {
            border-radius: 10px;
        }

        .profile-card .btn {
            border-radius: 10px;
        }

        .profile-card .table th, .profile-card .table td {
            padding: 0.75rem;
        }

        .btn-primary {
            background-color: #343a40;
            border-color: #007bff;
            transition: background-color 0.3s ease;
        }

        .btn-primary:hover {
            background-color: #0056b3;
            border-color: #0056b3;
        }

        @media (max-width: 768px) {
            .profile-card {
                padding: 1.5rem;
            }

            .profile-card .table th, .profile-card .table td {
                font-size: 0.875rem;
            }

            .profile-card img {
                width: 90px;
                height: 90px;
            }

            .profile-card .btn {
                font-size: 0.875rem;
            }
        }

        @media (max-width: 576px) {
            .profile-card {
                padding: 1rem;
            }

            .profile-card .table th, .profile-card .table td {
                font-size: 0.75rem;
            }

            .profile-card img {
                width: 75px;
                height: 75px;
            }

            .profile-card .btn {
                font-size: 0.75rem;
            }
        }
    </style>
</head>
<body>
    <section>
        <div class="container mt-5">
            <div class="row">
                <div class="col-md-10 offset-md-1">
                    <div class="profile-card">
                        <p class="fs-3 text-center">My Profile</p>

                        <c:if test="${not empty sessionScope.succMsg}">
                            <p class="text-success fw-bold text-center">${sessionScope.succMsg}</p>
                            <c:remove var="succMsg" scope="session"/>
                        </c:if>

                        <c:if test="${not empty sessionScope.errorMsg}">
                            <p class="text-danger fw-bold text-center">${sessionScope.errorMsg}</p>
                            <c:remove var="errorMsg" scope="session"/>
                        </c:if>

                        <hr>

                        <div class="text-center mb-4">
                            <img alt="Profile Image" src="<c:url value='/img/profile_img/${user.profileImage}'/>" class="border p-2">
                        </div>

                        <form action="/admin/update-profile" method="post" enctype="multipart/form-data">
                            <table class="table table-borderless">
                                <tbody>
                                    <tr>
                                        <th scope="row">Name</th>
                                        <td>:</td>
                                        <td><input type="text" name="name" class="form-control" value="${user.name}"></td>
                                    </tr>
                                    <tr>
                                        <th scope="row">Mobile Number</th>
                                        <td>:</td>
                                        <td><input type="text" name="mobileNumber" class="form-control" value="${user.mobileNumber}"></td>
                                    </tr>
                                    <tr>
                                        <th scope="row">Email</th>
                                        <td>:</td>
                                        <td><input type="text" name="email" class="form-control" readonly value="${user.email}"></td>
                                    </tr>
                                    <tr>
                                        <th scope="row">Address</th>
                                        <td>:</td>
                                        <td><input type="text" name="address" class="form-control" value="${user.address}"></td>
                                    </tr>
                                    <tr>
                                        <th scope="row">City</th>
                                        <td>:</td>
                                        <td><input type="text" name="city" class="form-control" value="${user.city}"></td>
                                    </tr>
                                    <tr>
                                        <th scope="row">State</th>
                                        <td>:</td>
                                        <td><input type="text" name="state" class="form-control" value="${user.state}"></td>
                                    </tr>
                                    <tr>
                                        <th scope="row">Pincode</th>
                                        <td>:</td>
                                        <td><input type="text" name="pincode" class="form-control" value="${user.pincode}"></td>
                                    </tr>
                                    <tr>
                                        <th scope="row">Image</th>
                                        <td>:</td>
                                        <td><input type="file" name="img" class="form-control"></td>
                                    </tr>
                                    <tr>
                                        <th scope="row">Role</th>
                                        <td>:</td>
                                        <td><input type="text" name="role" class="form-control" readonly value="${user.role}"></td>
                                    </tr>
                                    <tr>
                                        <th scope="row">Account Status</th>
                                        <td>:</td>
                                        <td><input type="text" name="isEnable" class="form-control" readonly value="${user.isEnable}">
                                            <input type="hidden" name="id" value="${user.id}">
                                        </td>
                                    </tr>
                                    <tr>
                                        <td></td>
                                        <td colspan="2" class="text-center">
                                            <button class="btn btn-primary col-md-6">Update</button>
                                        </td>
                                    </tr>
                                </tbody>
                            </table>
                        </form>
                    </div>

                    <hr>

                    <div class="profile-card mt-4">
                        <p class="text-center fs-3">Change Password</p>
                        <form action="/admin/change-password" method="post">
                            <table class="table table-borderless">
                                <tbody>
                                    <tr>
                                        <th scope="row">Current Password</th>
                                        <td><input type="password" name="currentPassword" class="form-control"></td>
                                    </tr>
                                    <tr>
                                        <th scope="row">New Password</th>
                                        <td><input type="password" name="newPassword" class="form-control"></td>
                                    </tr>
                                    <tr>
                                        <th scope="row">Confirm Password</th>
                                        <td><input type="password" name="confirmPassword" class="form-control"></td>
                                    </tr>
                                    <tr>
                                        <td></td>
                                        <td class="text-center">
                                            <button class="btn btn-primary col-md-6">Update</button>
                                        </td>
                                    </tr>
                                </tbody>
                            </table>
                        </form>
                    </div>

                </div>
            </div>
        </div>
    </section>
</body>
</html>
