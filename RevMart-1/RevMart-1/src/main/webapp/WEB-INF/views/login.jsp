<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Login Page</title>
    <!-- Add Bootstrap CSS -->
    <link href="https://stackpath.bootstrapcdn.com/bootstrap/5.3.0/css/bootstrap.min.css" rel="stylesheet">
    <style>
        /* Custom CSS */
        body {
            background-color: #fdfefe;
            background-image: url("https://assets.bacancytechnology.com/main-boot-5/images/ecommerce-development/banner.jpg?v-1");
            background-size: cover;
            background-repeat: no-repeat;
            background-position: center center;
        }

        .form {
            display: flex;
            flex-direction: column;
            gap: 20px;
            background: linear-gradient(45deg, skyblue, darkblue);
            padding: 30px;
            width: 600px; /* Increased width */
            border: 2px solid white;
            border-radius: 20px;
            font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, Oxygen, Ubuntu, Cantarell, "Open Sans", "Helvetica Neue", sans-serif;
            transition: background 0.3s ease;
            margin-right: 400px !important;
        }

        .form:hover {
            background: linear-gradient(45deg, darkblue, skyblue);
        }

        ::placeholder {
            font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, Oxygen, Ubuntu, Cantarell, "Open Sans", "Helvetica Neue", sans-serif;
        }

        .form button {
            align-self: flex-end;
        }

        .flex-column > label {
            color: white;
            font-weight: 600;
        }

        .inputForm {
            border: 1.5px solid #ecedec;
            border-radius: 10em;
            height: 50px;
            display: flex;
            align-items: center;
            padding-left: 10px;
            transition: 0.2s ease-in-out;
            background-color: white;
        }

        .input {
            margin-left: 10px;
            border-radius: 10rem;
            border: none;
            width: 100%;
            height: 100%;
        }

        .input:focus {
            outline: none;
        }

        .inputForm:focus-within {
            border: 1.5px solid orange;
        }

        .flex-row {
            display: flex;
            flex-direction: row;
            align-items: center;
            gap: 10px;
            justify-content: space-between;
        }

        .flex-row-2-fields {
            display: flex;
            gap: 20px;
        }

        .flex-row-2-fields .flex-column {
            width: 100%;
        }

        .span {
            font-size: 14px;
            margin-left: 5px;
            color: white;
            font-weight: 500;
            cursor: pointer;
        }

        .button-submit {
            position: relative;
            display: inline-block;
            padding: 15px 30px;
            text-align: center;
            letter-spacing: 1px;
            text-decoration: none;
            background: transparent;
            transition: ease-out 0.5s;
            border: 2px solid;
            border-radius: 10em;
            box-shadow: inset 0 0 0 0 blue;
            margin: 20px 0 10px 0;
            color: white;
            font-size: 15px;
            font-weight: 500;
            height: 50px;
            width: 100%;
            cursor: pointer;
        }

        .button-submit:hover {
            color: white;
            box-shadow: inset 0 -100px 0 0 royalblue;
        }

        .button-submit:active {
            transform: scale(0.9);
        }

        .p {
            text-align: center;
            color: white;
            font-size: 14px;
            margin: 5px 0;
        }

        .btn {
            margin-top: 10px;
            width: 100%;
            height: 50px;
            border-radius: 10em;
            display: flex;
            justify-content: center;
            align-items: center;
            font-weight: 500;
            gap: 10px;
            border: 1px solid #ededef;
            background-color: white;
            cursor: pointer;
            transition: 0.2s ease-in-out;
        }

        .btn:hover {
            border: 1px solid orange;
        }

        .center-container {
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
        }
    </style>
</head>
<body>
    <div class="container center-container">
        <div class="row justify-content-center">
            <div class="col-md-6">
                <div class="card shadow p-3 mb-5 bg-body-tertiary rounded">
                    <div class="card-header text-center">
                        <!-- Error Message -->
                        <c:if test="${param.error != null}">
                            <div class="alert alert-danger">
                              <h1 style="color:red;"> <c:out value="${sessionScope.SPRING_SECURITY_LAST_EXCEPTION.message}" /></h1> 
                            </div>
                        </c:if>
                        <!-- Success Message -->
                        <c:if test="${param.logout != null}">
                            <div class="alert alert-success"></div>
                        </c:if>
                    </div>
                    <div class="card-body">
                        <form class="form" action="${pageContext.request.contextPath}/login" method="post" onsubmit="return validateForm()">
                            <div class="flex-row-2-fields">
                                <div class="flex-column">
                                    <label for="email">Email</label>
                                    <div class="inputForm">
                                        <input id="email" placeholder="Enter your Email" class="input" type="email" name="username" required />
                                    </div>
                                </div>
                                <div class="flex-column">
                                    <label for="password">Password</label>
                                    <div class="inputForm">
                                        <input id="password" placeholder="Enter your Password" class="input" type="password" name="password" required />
                                    </div>
                                </div>
                            </div>

                            <div class="flex-row">
                                <div>
                                    <input type="checkbox" id="remember" name="remember" />
                                    <label for="remember">Remember me</label>
                                </div>
                                <span class="span"><a href="${pageContext.request.contextPath}/forgot-password">Forgot password?</a></span>
                            </div>
                            <button type="submit" class="button-submit">Sign In</button>
                            <p class="p">Don't have an account? <span class="span"><a href="${pageContext.request.contextPath}/register">Sign Up</a></span></p>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>
    
    <script>
        function validateForm() {
            const email = document.getElementById("email").value;
            const password = document.getElementById("password").value;

            // Check if password is at least 8 characters long
            if (password.length < 8) {
                alert("Password must be at least 8 characters long.");
                return false; // Prevent form submission
            }

            return true; // Allow form submission if everything is valid
        }
    </script>
    
    <!-- Add Bootstrap JavaScript -->
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/5.3.0/js/bootstrap.bundle.min.js"></script>
</body>
</html>
