<%-- 
    Document   : TicketVerifi
    Created on : Feb 15, 2025, 6:26:24 PM
    Author     : tra my
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8">
        <title>VietTrains</title>
        <meta content="width=device-width, initial-scale=1.0" name="viewport">
        <meta content="" name="keywords">
        <meta content="" name="description">

        <!-- Favicon -->
        <link href="img/favicon.ico" rel="icon">

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
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.7.2/css/all.min.css">
        <!-- Template Stylesheet -->
        <link href="css/style.css" rel="stylesheet">
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.4.0/css/font-awesome.min.css"> 
    </head>
    <body>
        <!-- Spinner Start -->
        <div id="spinner" class="show bg-white position-fixed translate-middle w-100 vh-100 top-50 start-50 d-flex align-items-center justify-content-center">
            <div class="spinner-border text-primary" style="width: 3rem; height: 3rem;" role="status">
                <span class="sr-only">Loading...</span>
            </div>
        </div>
        <!-- Spinner End -->
        <jsp:include page="Header.jsp"></jsp:include>
            <!-- Navbar & Hero Start -->
            <div class="container-fluid position-relative p-0">
                <nav class="navbar navbar-expand-lg navbar-light px-4 px-lg-5 py-3 py-lg-0">
                    <a href="Home.jsp" class="navbar-brand p-0">
                        <img src="logo/train_logo.png" alt="Logo">
                    </a>
                    <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarCollapse">
                        <span class="fa fa-bars"></span>
                    </button>
                    <div class="collapse navbar-collapse" id="navbarCollapse">
                        <div class="navbar-nav ms-auto py-0">
                            <a href="home" class="nav-item nav-link ">Trang chủ</a>
                            <a href="about.html" class="nav-item nav-link ">Thông tin đặt chỗ</a>
                            <a href="ScheduleDetailSearch.jsp" class="nav-item nav-link">Giờ tàu-Giá vé</a>                            
                            <a href="routeview" class="nav-item nav-link">Các tuyến đường</a>
                            <a href="TicketVerifi.jsp" class="nav-item nav-link active">Kiểm tra vé</a>
                            <a href="package.html" class="nav-item nav-link">Quy định</a>
                            <!--                                                <div class="nav-item dropdown">
                                                                                <a href="#" class="nav-link dropdown-toggle" data-bs-toggle="dropdown">Pages</a>
                                                                                <div class="dropdown-menu m-0">
                                                                                    <a href="destination.html" class="dropdown-item">Destination</a>
                                                                                    <a href="booking.html" class="dropdown-item">Booking</a>
                                                                                    <a href="team.html" class="dropdown-item">Travel Guides</a>
                                                                                    <a href="testimonial.html" class="dropdown-item">Testimonial</a>
                                                                                    <a href="404.html" class="dropdown-item">404 Page</a>
                                                                                </div>
                                                                            </div>-->
                            <a href="contact.html" class="nav-item nav-link">Liên hệ</a>
                        </div>
                    </div>
                </nav>
                <div class=" container-fluid py-5 mb-5 " style="background-color: #353e4a;">
                </div>
            </div>
             <div class="container">
                <div class="table-wrapper">
                    <div class="table-title">
                        <div class="row">
                            <div class="col-sm-6">
                                <h2>Kiểm tra vé</h2>
                            </div>
                            <!--                        <div class="col-sm-6">
                                                        <a href="#addEmployeeModal" class="btn btn-success" data-toggle="modal"><i class="material-icons">&#xE147;</i> <span>Add New Product</span></a>
                                                    </div>-->
                        </div>
                    </div>
                    <div>
                        Để đảm bảo quyền lợi cho hành khách, tránh mua phải vé giả, hoặc vé không đúng với quy định, quý khách có thể kiểm tra lại vé điện tử của mình bằng cách điền đầy đủ các thông tin dưới đây.
                    </div>
<!--                <div class="clearfix">
                    <div class="hint-text">Showing <b>${listP.size()}</b> out of <b>${totalProducts}</b> entries</div>
                    <ul class="pagination">
                        <li class="page-item ${currentPage == 1 ? 'disabled' : ''}"><a href="managerproduct?page=${currentPage - 1}" class="page-link">Previous</a></li>
                            <c:forEach begin="1" end="${totalPages}" var="i">
                            <li class="page-item ${currentPage == i ? 'active' : ''}"><a href="managerproduct?page=${i}" class="page-link">${i}</a></li>
                            </c:forEach>
                        <li class="page-item ${currentPage == totalPages ? 'disabled' : ''}"><a href="managerproduct?page=${currentPage + 1}" class="page-link">Next</a></li>
                    </ul>
                </div>-->
            </div>
            <a href="home"><button type="button" class="btn btn-primary">Back to home</button>
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
    </body>
</html>
