<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ include file="./base.jsp" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="ISO-8859-1">
    <title>Order Page</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <script src="https://checkout.razorpay.com/v1/checkout.js"></script>
    <style>
        /* Include the enhanced CSS here */
        body {
            font-family: 'Arial', sans-serif;
            background-color: #f8f9fa;
            color: #333;
        }

        .container {
            background-color: white;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }

        p {
            font-weight: bold;
            color: #444;
        }

        label {
            font-weight: 500;
            color: #555;
        }

        input, select {
            border-radius: 5px;
            border: 1px solid #ddd;
            padding: 10px;
            font-size: 14px;
        }

        input:focus, select:focus {
            outline: none;
            border-color: #007bff;
            box-shadow: 0 0 5px rgba(0, 123, 255, 0.25);
        }

        .btn {
            padding: 12px 16px;
            border-radius: 5px;
            font-size: 16px;
            font-weight: bold;
        }

        .bg-primary {
            background-color: #007bff !important;
        }

        .bg-primary:hover {
            background-color: #0056b3 !important;
        }

        .col-md-6 {
            margin-bottom: 20px;
        }

        .fs-4 {
            font-size: 1.5rem;
            color: #007bff;
        }

        .table-borderless td {
            padding: 10px;
            font-size: 14px;
        }

        .table-borderless tr.border-top td {
            border-top: 2px solid #007bff;
            font-weight: bold;
            font-size: 16px;
        }

        .card {
            border: none;
            background-color: #f7f7f7;
        }

        .card-body {
            padding: 20px;
            background-color: white;
            border-radius: 8px;
        }

        .card-body:hover {
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }

        input.form-control, select.form-control {
            box-shadow: none;
            border: 1px solid #ccc;
            transition: border-color 0.3s;
        }

        input.form-control:focus, select.form-control:focus {
            border-color: #007bff;
        }

        @media (max-width: 768px) {
            .col-md-6 {
                flex: 100%;
                max-width: 100%;
            }

            .p-1 {
                padding: 5px !important;
            }
        }
    </style>
</head>
<body>
    <section>
        <div class="container mt-5 p-5">
            <form action="${pageContext.request.contextPath}/user/save-order" method="post" id="orders" onsubmit="return validateForm();" novalidate>
                <div class="row">
                    <div class="col-md-6">
                        <div class="mb-3">
                            <p class="text-center fs-4">Billing Address</p>
                            <hr>
                            <div class="row">
                                <div class="col p-1">
                                    <label for="firstName">First Name</label>
                                    <input type="text" id="firstName" name="firstName" required class="form-control mt-1">
                                </div>
                                <div class="col p-1">
                                    <label for="lastName">Last Name</label>
                                    <input type="text" id="lastName" name="lastName" required class="form-control mt-1">
                                </div>
                            </div>
                            <div class="row">
                                <div class="col p-1">
                                    <label for="email">Email</label>
                                    <input type="email" id="email" name="email" required class="form-control">
                                </div>
                                <div class="col p-1">
                                    <label for="mobileNo">Mobile Number</label>
                                    <input type="text" id="mobileNo" name="mobileNo" required class="form-control ms-2">
                                </div>
                            </div>
                            <div class="row">
                                <div class="col p-1">
                                    <label for="address">Address</label>
                                    <input type="text" id="address" name="address" required class="form-control">
                                </div>
                                <div class="col p-1">
                                    <label for="city">City</label>
                                    <input type="text" id="city" name="city" required class="form-control ms-2">
                                </div>
                            </div>
                            <div class="row">
                                <div class="col p-1">
                                    <label for="state">State</label>
                                    <input type="text" id="state" name="state" required class="form-control">
                                </div>
                                <div class="col p-1">
                                    <label for="pincode">Pincode</label>
                                    <input type="number" id="pincode" name="pincode" required class="form-control ms-2">
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="col-md-6">
                        <p class="text-center fs-4">Payment Type</p>
                        <hr>
                        <div class="card">
                            <div class="card-body">
                                <table class="table table-borderless">
                                    <tbody>
                                        <tr>
                                            <td>Price</td>
                                            <td>:</td>
                                            <td>&#8377; ${orderPrice}</td>
                                        </tr>
                                        <tr>
                                            <td>Delivery Fee</td>
                                            <td>:</td>
                                            <td>&#8377; 39</td>
                                        </tr>
                                        <tr>
                                            <td>Tax</td>
                                            <td>:</td>
                                            <td>&#8377; 20</td>
                                        </tr>
                                        <tr class="border-top">
                                            <td>Total Price</td>
                                            <td>:</td>
                                            <td>&#8377; ${totalOrderPrice}</td>
                                        </tr>
                                    </tbody>
                                </table>
                            </div>
                        </div>

                        <div class="card shadow p-3 mb-5 mt-2 bg-body-tertiary rounded">
                            <div class="card-body">
                                <div class="mb-3">
                                    <label for="paymentType" class="form-label">Select Payment Type</label>
                                    <select required id="paymentType" name="paymentType" class="form-control">
                                        <option value="">--select--</option>
                                        <option value="COD">Cash On Delivery</option>
                                        <option value="ONLINE">Online Payment</option>
                                    </select>
                                </div>
                                <button type="button" id="razorpay-button" class="btn bg-primary text-white col-md-12" style="display:none;">Pay with Razorpay</button>
                                <button type="submit" id="place-order" class="btn bg-primary text-white col-md-12">Place Order</button>
                            </div>
                        </div>
                    </div>
                </div>
            </form>
        </div>
    </section>

    <script type="text/javascript">
    // Show or hide Razorpay button based on payment type selection
    document.getElementById('paymentType').addEventListener('change', function () {
        const paymentType = this.value;
        const razorpayButton = document.getElementById('razorpay-button');
        const placeOrderButton = document.getElementById('place-order');

        if (paymentType === 'ONLINE') {
            razorpayButton.style.display = 'block';
            placeOrderButton.style.display = 'none';
        } else {
            razorpayButton.style.display = 'none';
            placeOrderButton.style.display = 'block';
        }
    });

    // Trigger Razorpay Checkout
    document.getElementById('razorpay-button').addEventListener('click', function (e) {
        e.preventDefault();

        const totalOrderPrice = ${totalOrderPrice};  // Ensure this is a valid number
        const options = {
            "key": "rzp_test_zT6nDcxOnaNc2W",  // Replace with your Razorpay Key ID
            "amount": totalOrderPrice * 100,  // Razorpay accepts amount in paise (multiply by 100)
            "currency": "INR",
            "name": "E-Commerce Website",
            "description": "Order Payment",
            "handler": function (response) {
                // After payment is successful, submit form with Razorpay response ID
                const form = document.getElementById('orders');
                const input = document.createElement('input');
                input.type = 'hidden';
                input.name = 'razorpayPaymentId';
                input.value = response.razorpay_payment_id;
                form.appendChild(input);
                form.submit();
            },
            "prefill": {
                "name": document.getElementsByName('firstName')[0].value + ' ' + document.getElementsByName('lastName')[0].value,
                "email": document.getElementsByName('email')[0].value,
                "contact": document.getElementsByName('mobileNo')[0].value
            },
            "theme": {
                "color": "#3399cc"
            }
        };

        const rzp1 = new Razorpay(options);
        rzp1.open();
    });
    </script>
    <script>
function validateForm() {
    const mobile = document.getElementById("mobileNo").value;
    const email = document.getElementById("email").value;
    const pincode = document.getElementById("pincode").value;

    // Regular expressions for validation
    const mobileRegex = /^[0-9]{10}$/;
    const emailRegex = /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/;
    const pincodeRegex = /^[0-9]{6}$/;
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
    
    

    return true; // If all validations pass
}
</script>
</body>
</html>
