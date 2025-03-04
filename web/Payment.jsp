<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Payment - Train Ticket Booking</title>
        <meta content="width=device-width, initial-scale=1.0" name="viewport">
        <meta content="" name="keywords">
        <meta content="" name="description">

        <!-- Google Web Fonts -->
        <link rel="preconnect" href="https://fonts.googleapis.com">
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
        <link href="https://fonts.googleapis.com/css2?family=Heebo:wght@400;500;600&family=Nunito:wght@600;700;800&display=swap" rel="stylesheet">

        <!-- Icon Font Stylesheet -->
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.10.0/css/all.min.css" rel="stylesheet">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.4.1/font/bootstrap-icons.css" rel="stylesheet">

        <!-- Libraries Stylesheet -->
        <link href="lib/animate/animate.min.css" rel="stylesheet">
        <link href="lib/owlcarousel/assets/owl.carousel.min.css" rel="stylesheet">
        <link href="lib/tempusdominus/css/tempusdominus-bootstrap-4.min.css" rel="stylesheet" />

        <!-- Customized Bootstrap Stylesheet -->
        <link href="css/bootstrap.min.css" rel="stylesheet">

        <!-- Template Stylesheet -->
        <link href="css/style.css" rel="stylesheet">
        <style>
            .payment-container {
                max-width: 800px;
                margin: 30px auto;
                padding: 20px;
                background: #fff;
                border-radius: 8px;
                box-shadow: 0 0 10px rgba(0,0,0,0.1);
            }
            .payment-method {
                margin: 20px 0;
                padding: 15px;
                border: 1px solid #ddd;
                border-radius: 4px;
                cursor: pointer;
            }
            .payment-method:hover {
                background-color: #f8f9fa;
            }
            .payment-method.selected {
                border-color: #0d6efd;
                background-color: #e7f1ff;
            }
            .order-summary {
                background-color: #f8f9fa;
                padding: 20px;
                border-radius: 4px;
                margin-bottom: 20px;
            }
        </style>
    </head>
    <body>
        <jsp:include page="Header.jsp"></jsp:include>

        <div class="container payment-container">
            <h2 class="mb-4">Payment Information</h2>
            
            <!-- Order Summary -->
            <div class="order-summary">
                <h4>Order Summary</h4>
                <div class="row">
                    <div class="col-md-6">
                        <p><strong>Train:</strong> ${schedule.getTrid()}</p>
                        <p><strong>From:</strong> ${schedule.getFrom_station()}</p>
                        <p><strong>To:</strong> ${schedule.getTo_station()}</p>
                    </div>
                    <div class="col-md-6">
                        <p><strong>Date:</strong> ${schedule.getFrom_date()}</p>
                        <p><strong>Time:</strong> ${schedule.getFrom_time()}</p>
                        <p><strong>Cabin:</strong> ${cabin.getId()}</p>
                    </div>
                </div>
                <hr>
                <div class="row">
                    <div class="col-md-12">
                        <h5>Total Amount: $${totalAmount}</h5>
                    </div>
                </div>
            </div>

            <!-- Payment Form -->
            <form action="payment" method="POST">
                <input type="hidden" name="scheduleId" value="${schedule.getId()}">
                <input type="hidden" name="cabinId" value="${cabin.getId()}">
                <input type="hidden" name="totalAmount" value="${totalAmount}">

                <!-- Payment Methods -->
                <h4>Select Payment Method</h4>
                <div class="payment-method" onclick="selectPaymentMethod('credit')">
                    <input type="radio" name="paymentMethod" value="credit" id="credit">
                    <label for="credit">Credit Card</label>
                    <div class="payment-details" id="creditDetails" style="display: none;">
                        <div class="form-group mt-3">
                            <input type="text" class="form-control" placeholder="Card Number" name="cardNumber">
                        </div>
                        <div class="row mt-3">
                            <div class="col-md-6">
                                <input type="text" class="form-control" placeholder="MM/YY" name="expiry">
                            </div>
                            <div class="col-md-6">
                                <input type="text" class="form-control" placeholder="CVV" name="cvv">
                            </div>
                        </div>
                    </div>
                </div>

                <div class="payment-method" onclick="selectPaymentMethod('banking')">
                    <input type="radio" name="paymentMethod" value="banking" id="banking">
                    <label for="banking">Internet Banking</label>
                    <div class="payment-details" id="bankingDetails" style="display: none;">
                        <div class="form-group mt-3">
                            <select class="form-control" name="bankName">
                                <option value="">Select Bank</option>
                                <option value="vietcombank">Vietcombank</option>
                                <option value="techcombank">Techcombank</option>
                                <option value="tpbank">TPBank</option>
                            </select>
                        </div>
                    </div>
                </div>

                <div class="payment-method" onclick="selectPaymentMethod('momo')">
                    <input type="radio" name="paymentMethod" value="momo" id="momo">
                    <label for="momo">MoMo E-Wallet</label>
                </div>

                <!-- Contact Information -->
                <h4 class="mt-4">Contact Information</h4>
                <div class="form-group">
                    <input type="text" class="form-control" name="name" placeholder="Full Name" required>
                </div>
                <div class="form-group mt-3">
                    <input type="email" class="form-control" name="email" placeholder="Email" required>
                </div>
                <div class="form-group mt-3">
                    <input type="tel" class="form-control" name="phone" placeholder="Phone Number" required>
                </div>

                <button type="submit" class="btn btn-primary mt-4 w-100">Proceed to Pay</button>
            </form>
        </div>

        <jsp:include page="Footer.jsp"></jsp:include>

        <!-- JavaScript Libraries -->
        <script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0/dist/js/bootstrap.bundle.min.js"></script>
        <script src="lib/wow/wow.min.js"></script>
        <script src="lib/easing/easing.min.js"></script>
        <script src="lib/waypoints/waypoints.min.js"></script>
        <script src="lib/owlcarousel/owl.carousel.min.js"></script>
        <script src="lib/tempusdominus/js/moment.min.js"></script>
        <script src="lib/tempusdominus/js/moment-timezone.min.js"></script>
        <script src="lib/tempusdominus/js/tempusdominus-bootstrap-4.min.js"></script>

        <!-- Template Javascript -->
        <script src="js/main.js"></script>
        
        <script>
            function selectPaymentMethod(method) {
                // Hide all payment details
                document.querySelectorAll('.payment-details').forEach(detail => {
                    detail.style.display = 'none';
                });
                
                // Remove selected class from all payment methods
                document.querySelectorAll('.payment-method').forEach(pm => {
                    pm.classList.remove('selected');
                });
                
                // Show selected payment details
                const details = document.getElementById(method + 'Details');
                if (details) {
                    details.style.display = 'block';
                }
                
                // Add selected class to chosen payment method
                const methodDiv = document.getElementById(method).closest('.payment-method');
                methodDiv.classList.add('selected');
                
                // Check the radio button
                document.getElementById(method).checked = true;
            }
        </script>
    </body>
</html>
