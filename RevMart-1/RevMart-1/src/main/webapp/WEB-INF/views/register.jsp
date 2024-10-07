<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Register</title>
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.6.0/css/all.min.css">
<link
	href="//maxcdn.bootstrapcdn.com/bootstrap/4.1.1/css/bootstrap.min.css"
	rel="stylesheet" id="bootstrap-css">
<script
	src="//maxcdn.bootstrapcdn.com/bootstrap/4.1.1/js/bootstrap.min.js"></script>
<script
	src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<style>
html, body {
	margin: 0;
	padding: 0;
	width: 100%;
	height: 100%;
	overflow-x: hidden; /* Prevents horizontal scrolling */
}

body {
	background-image:
		url("https://assets.bacancytechnology.com/main-boot-5/images/ecommerce-development/banner.jpg?v-1");
	background-size: cover;
	background-repeat: no-repeat;
	background-position: center center;
}

.form-container {
	margin-right: 350px;
	align-items: center;
	margin-top: 50px;
	width: 1000px;
}

.card {
	border-radius: 15px;
	border: 1px solid #ddd;
	box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
	background: #042554;
}

.card-header {
	background: #273746;
	color: #17202a;
	border-bottom: 1px solid #ddd;
	border-top-left-radius: 15px;
	border-top-right-radius: 15px;
}

.card-body {
	padding: 30px;
}

.form-group label {
	color: white;
	font-weight: bold;
}

.input-form {
	border: 1px solid #ddd;
	color: white;
	border-radius: 10px;
	height: 40px;
	display: flex;
	align-items: center;
	padding-left: 10px;
	background-color: black;
	transition: border 0.3s ease;
}

.input-form input {
	border: none;
	width: 100%;
	height: 100%;
	border-radius: 10px;
}

.input-form:focus-within {
	border: 1px solid #007bff;
}

.button {
	background-color: #007bff;
	border: none;
	border-radius: 50px;
	padding: 10px 20px;
	color: #fff;
	font-weight: bold;
	font-size: 16px;
	cursor: pointer;
	transition: background-color 0.3s, transform 0.3s;
	text-align: center;
	display: block;
	width: 100%;
}

.button:hover {
	background-color: #0056b3;
	transform: scale(1.05);
}

.card-footer {
	background-color: #f8f9fa;
}

.card-footer a {
	color: #007bff;
	font-weight: bold;
	text-decoration: none;
}

.card-footer a:hover {
	text-decoration: underline;
}

.form-row {
	margin-bottom: 1rem;
}

.form-group {
	margin-bottom: 1.5rem;
}
</style>
</head>
<body>
	<div class="container form-container">
		<div class="row justify-content-center">
			<div class="col-md-8">
				<!-- Adjusted width -->
				<div class="card shadow p-3 mb-5 rounded">
					<div class="card-header text-center">
						<!-- Display Success Message -->
						<c:if test="${not empty sessionScope.succMsg}">
							<div class="alert alert-success" role="alert">
								${sessionScope.succMsg}
								<c:remove var="sessionScope.succMsg" />
							</div>
						</c:if>
						<!-- Display Error Message -->
						<c:if test="${not empty sessionScope.errorMsg}">
							<div class="alert alert-danger" role="alert">
								${sessionScope.errorMsg}
								<c:remove var="sessionScope.errorMsg" />
							</div>
						</c:if>
					</div>
					<div class="card-body">
						<form class="form" action="/saveUser"
							enctype="multipart/form-data" method="post" onsubmit="return validateForm();">
							<!-- Row 1: Full Name and Mobile Number -->
							<div class="form-row">
								<div class="col-md-6">
									<div class="form-group">
										<label for="name">Full Name</label>
										<div class="input-form">
											<input id="name" placeholder="Enter your Full Name"
												type="text" name="name" required>
										</div>
									</div>
								</div>
								<div class="col-md-6">
									<div class="form-group">
										<label for="mobileNumber">Mobile Number</label>
										<div class="input-form">
											<input id="mobileNumber"
												placeholder="Enter your Mobile Number" type="number"
												name="mobileNumber" required>
										</div>
									</div>
								</div>
							</div>

							<!-- Row 2: Email and Address -->
							<div class="form-row">
								<div class="col-md-6">
									<div class="form-group">
										<label for="email">Email</label>
										<div class="input-form">
											<input id="email" placeholder="Enter your Email" type="email"
												name="email" required>
										</div>
									</div>
								</div>
								<div class="col-md-6">
									<div class="form-group">
										<label for="address">Address</label>
										<div class="input-form">
											<input id="address" placeholder="Enter your Address"
												type="text" name="address" required>
										</div>
									</div>
								</div>
							</div>

							<!-- Row 3: City and State -->
							<div class="form-row">
								<div class="col-md-6">
									<div class="form-group">
										<label for="city">City</label>
										<div class="input-form">
											<input id="city" placeholder="Enter your City" type="text"
												name="city" required>
										</div>
									</div>
								</div>
								<div class="col-md-6">
									<div class="form-group">
										<label for="state">State</label>
										<div class="input-form">
											<input id="state" placeholder="Enter your State" type="text"
												name="state" required>
										</div>
									</div>
								</div>
							</div>

							<!-- Row 4: Pincode and Password -->
							<div class="form-row">
								<div class="col-md-6">
									<div class="form-group">
										<label for="pincode">Pincode</label>
										<div class="input-form">
											<input id="pincode" placeholder="Enter your Pincode"
												type="number" name="pincode" required>
										</div>
									</div>
								</div>
								<div class="col-md-6">
									<div class="form-group">
										<label for="password">Password</label>
										<div class="input-form">
											<input id="password" placeholder="Enter your Password"
												type="password" name="password" required>
										</div>
									</div>
								</div>
							</div>

							<!-- Row 5: Confirm Password and Profile Image -->
							<div class="form-row">
								<div class="col-md-6">
									<div class="form-group">
										<label for="confirmpassword">Confirm Password</label>
										<div class="input-form">
											<input id="confirmpassword"
												placeholder="Confirm your Password" type="password"
												name="confirmpassword" required>
										</div>
									</div>
								</div>
								<div class="col-md-6">
									<div class="form-group">
										<label for="img">Profile Image</label>
										<div class="input-form">
											<input id="img" type="file" name="img">
										</div>
									</div>
								</div>
							</div>

							<div class="form-row">
								<div class="col-md-6">
									<div class="form-group">
										<label for="userRole">User Role</label>
										<div class="input-form">
											<select id="userRole" name="role" required>
												<option value="buyer" selected>Buyer</option>
												<option value="seller">Seller</option>
											</select>
										</div>
									</div>
								</div>
							</div>

							<button type="submit" class="button mt-4">Register</button>
							<div class="card-footer text-center mt-3">
								Have an account? <a href="/signin" class="text-decoration-none">Login</a>
							</div>
						</form>
					</div>
				</div>
			</div>
		</div>
	</div>
	<script>
function validateForm() {
    const name = document.getElementById("name").value;
    const mobile = document.getElementById("mobileNumber").value;
    const email = document.getElementById("email").value;
    const pincode = document.getElementById("pincode").value;
    const password = document.getElementById("password").value;
    const confirmPassword = document.getElementById("confirmpassword").value;

    // Regular expressions for validation
    const mobileRegex = /^[0-9]{10}$/;
    const emailRegex = /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/;
    const pincodeRegex = /^[0-9]{6}$/;

    // Validate name
    if (name.trim() === "") {
        alert("Full Name is required.");
        return false;
    }

    // Validate mobile number
    if (!mobileRegex.test(mobile)) {
        alert("Please enter a valid 10-digit mobile number.");
        return false;
    }

    // Validate email
    if (!emailRegex.test(email)) {
        alert("Please enter a valid email address.");
        return false;
    }

    // Validate pincode
    if (!pincodeRegex.test(pincode)) {
        alert("Please enter a valid 6-digit pincode.");
        return false;
    }
    
    // Validate password length
    if (password.length < 8) {
        alert("Password must be at least 8 characters long.");
        return false;
    }

    // Validate password and confirm password
    if (password !== confirmPassword) {
        alert("Passwords do not match.");
        return false;
    }

    return true; // If all validations pass
}
</script>

	<!-- Bootstrap JS Bundle with Popper -->
	<script
		src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.7/dist/umd/popper.min.js"></script>
	<script
		src="https://stackpath.bootstrapcdn.com/bootstrap/5.3.0/js/bootstrap.bundle.min.js"></script>
</body>
</html>