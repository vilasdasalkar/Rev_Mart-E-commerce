<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@include file="./base.jsp" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="ISO-8859-1">
    <title>My Profile</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css">
    <style>
        /* Global Styles */
        body {
            background-color: #f0f0f0;
        }
        
        .container-fluid {
            background-color: #fff;
            padding: 20px;
            border: 1px solid #ddd;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }

        .profile-header {
            background-color: #333;
            color: #fff;
            padding: 10px;
            border-radius: 10px 10px 0 0;
        }
        
        .profile-image {
            width: 110px;
            height: 110px;
            border-radius: 50%;
            margin: 20px auto;
        }

        .profile-form {
            margin-top: 20px;
        }

        .profile-form table {
            border-collapse: separate;
            border-spacing: 0 10px;
        }

        .profile-form th, .profile-form td {
            border: none;
            padding: 10px;
        }

        .profile-form th {
            background-color: #f0f0f0;
        }

        .profile-form td {
            background-color: #fff;
        }

        .profile-form input[type="text"], .profile-form input[type="file"] {
            width: 100%;
            padding: 10px;
            margin-bottom: 10px;
            border: 1px solid #ccc;
        }

        .profile-form button[type="submit"] {
            background-color: #333;
            color: #fff;
            padding: 10px 20px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
        }

        .profile-form button[type="submit"]:hover {
            background-color: #444;
        }
    </style>
</head>
<body>
    <section>
        <div class="container-fluid mt-5 p-5">
            <div class="row">
                <div class="col-md-6">
                    <div class="profile-header">
                        <p class="fs-3 text-center">My Profile</p>
                    </div>
                    
                    <c:if test="${not empty sessionScope.succMsg}">
                        <div class="alert alert-success">
                            ${sessionScope.succMsg}
                        </div>
                        <c:out value="${commnServiceImpl.removeSessionMessage()}" />
                    </c:if>

                    <c:if test="${not empty sessionScope.errorMsg}">
                        <div class="alert alert-danger">
                            ${sessionScope.errorMsg}
                        </div>
                        <c:out value="${commnServiceImpl.removeSessionMessage()}" />
                    </c:if>
                    
                    <hr>
                    
                    <div class="text-center">
                        <img alt="" src="${pageContext.request.contextPath}/img/profile_img/${user.profileImage}" class="profile-image">
                    </div>
                    
                    <div class="profile-form">
                        <form action="${pageContext.request.contextPath}/user/update-profile" method="post" enctype="multipart/form-data">
                            <table>
                                <tbody>
                                    <tr>
                                        <th scope="row">Name</th>
                                        <td><input type="text" name="name" class="form-control" value="${user.name}"></td>
                                    </tr>
                                    <tr>
                                        <th scope="row">Mobile Number</th>
                                        <td><input type="text" name="mobileNumber" class="form-control" value="${user.mobileNumber}"></td>
                                    </tr>
                                    <tr>
                                        <th scope="row">Email</th>
                                        <td><input type="text" name="email" class="form-control" readonly value="${user.email}"></td>
                                    </tr>
                                    <tr>
                                        <th scope="row">Address</th>
                                        <td><input type="text" name="address" class="form-control" value="${user.address}"></td>
                                    </tr>
                                    <tr>
                                        <th scope="row">City</th>
                                        <td><input type="text" name="city" class="form-control" value="${user.city}"></td>
                                    </tr>
                                    <tr>
                                        <th scope="row">State</th>
                                        <td><input type="text" name="state" class="form-control" value="${user.state}"></td>
                                    </tr>
                                    <tr>
                                        <th scope="row">Pincode</th>
                                        <td><input type="text" name="pincode" class="form-control" value="${user.pincode}"></td>
                                    </tr>
                                    <tr>
                                        <th scope="row">Image</th>
                                        <td><input type="file" name="img" class="form-control"></td>
                                    </tr>
                                    <tr>
                                        <th scope="row">Role</th>
                                        <td><input type="text" name="role" class="form-control" readonly value="${user.role}"></td>
                                    </tr>
                                    <tr>
                                        <th scope="row">Account Status</th>
                                        <td><input type="text" name="isEnable" class="form-control" readonly value="${user.isEnable}">
                                            <input type="hidden" name="id" value="${user.id}"></td>
                                    </tr>
                                    <tr>
                                        <td></td>
                                        <td class="text-center">
    <button class="btn btn-sm bg-primary text-light">Update</button>
    <a href="${pageContext.request.contextPath}/user/change-pass" class="btn btn-sm btn-secondary ms-2">Change Password</a>
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
