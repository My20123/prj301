<%-- 
    Document   : SearchResult
    Created on : Feb 12, 2025, 7:22:54 PM
    Author     : tra my
--%>

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
            <!-- Nav start -->
            <div class="container-fluid position-relative p-0">
                <nav class="navbar navbar-expand-lg navbar-light px-4 px-lg-5 py-3 py-lg-0">
                    <a href="" class="navbar-brand p-0">
                        <img src="logo/train_logo.png" alt="Logo">
                    </a>
                    <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarCollapse">
                        <span class="fa fa-bars"></span>
                    </button>
                    <div class="collapse navbar-collapse" id="navbarCollapse">
                        <div class="navbar-nav ms-auto py-0">
                            <a href="index_v1.html" class="nav-item nav-link ">Trang chủ</a>
                            <a href="about.html" class="nav-item nav-link ">Thông tin đặt chỗ</a>
                            <a href="service.html" class="nav-item nav-link">Giờ tàu-Giá vé</a>
                            <a href="package.html" class="nav-item nav-link">Quy định</a>
                            <!--                    <div class="nav-item dropdown">
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
                    <div class="container py-5">
                        <div class="train-search__data">
                            <div class="date-picker">
                                <div class="SingleDatePickerInput SingleDatePickerInput_1" >
                                    <div class="DateInput DateInput_1" style="display: flex;justify-content: normal;width: auto;margin: 0 auto;">
                                        <p>Thời gian đi <input type="date" id="datepicker"></p>
                                        <div class="search-stations__divider"></div>
                                        <p style="margin-left: 5px;">Thời gian về <input type="date" id="datepicker"></p>
                                    </div>
                                </div>
                            </div>
                            <div class="search-stations">
                                <div class="station-select">
                                    <div class=" css-aakg73-container">
                                        <span id="react-select-2-live-region" class="css-7pg0cj-a11yText"></span>
                                        <span aria-live="polite" aria-atomic="false" aria-relevant="additions text" class="css-7pg0cj-a11yText"></span>
                                        <div class="react-select__control css-cv0q10">
                                            <div class="react-select__value-container css-76smiy">
                                                <div class="react-select__placeholder css-1jqq78o-placeholder" id="react-select-2-placeholder" style="margin-left: 25px;">Ga đi</div>
                                                <div class="search-station-input-wrapper">
                                                    <div class="react-select__input-container css-19bb58m" data-value="">
                                                        <input class="react-select__input" list="stations" autocapitalize="none" autocomplete="off" autocorrect="off" id="from_station" spellcheck="false" tabindex="0" type="text" aria-autocomplete="list" aria-expanded="false" aria-haspopup="true" role="combobox" aria-describedby="react-select-2-placeholder" value="" style="color: inherit; background: 0px center; opacity: 1;  width: 250px; grid-area: 1 / 2; font: inherit; min-width: 2px; border: 0px; margin: 0px;margin-left:40px; outline: 0px; padding: 0px;">
                                                        <datalist id="stations">
                                                            <c:forEach items="${listS}" var="o">
                                                            <option value="${o}">
                                                        </c:forEach>                                                                                                     
                                                    </datalist>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="search-stations__divider">
                                <button class="search-stations__switcher" type="button" onclick="swapData()">
                                    <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" fill="none">
                                    <path fill="#989898" d="M21.925 11.62a.999.999 0 0 0-.21-.33l-4.002-3.996a1.004 1.004 0 0 0-1.42 1.418l2.3 2.288H5.407l2.3-2.288a1.003 1.003 0 1 0-1.42-1.418L2.285 11.29a1 1 0 0 0-.21.33c-.1.243-.1.516 0 .759a.998.998 0 0 0 .21.33l4.002 3.996a1 1 0 0 0 1.42 0 1 1 0 0 0 0-1.419l-2.3-2.288h13.186l-2.3 2.288a.999.999 0 0 0 .325 1.637 1.002 1.002 0 0 0 1.095-.218l4.002-3.996a.998.998 0 0 0 .21-.33c.1-.243.1-.516 0-.76Z"></path>
                                    </svg>
                                </button>
                            </div>
                            <div class="station-select">
                                <div class=" css-aakg73-container">
                                    <span id="react-select-3-live-region" class="css-7pg0cj-a11yText"></span>
                                    <span aria-live="polite" aria-atomic="false" aria-relevant="additions text" class="css-7pg0cj-a11yText"></span>
                                    <div class="react-select__control css-cv0q10">
                                        <div class="react-select__value-container css-76smiy">
                                            <div class="react-select__placeholder css-1jqq78o-placeholder" id="react-select-3-placeholder" style="margin-left: 25px;">Ga đến</div>
                                            <div class="search-station-input-wrapper">
                                                <div class="react-select__input-container css-19bb58m" data-value="">
                                                    <input class="react-select__input" list="stations" autocapitalize="none" autocomplete="off" autocorrect="off" id="to_station" spellcheck="false" tabindex="0" type="text" aria-autocomplete="list" aria-expanded="false" aria-haspopup="true" role="combobox" aria-describedby="react-select-3-placeholder" value="" style="color: inherit; background: 0px center; opacity: 1;   width: 250px; grid-area: 1 / 2; font: inherit; min-width: 2px; border: 0px; margin: 0px;margin-left:40px; outline: 0px; padding: 0px;">
                                                    <datalist id="stations">
                                                        <c:forEach items="${listS}" var="o">
                                                            <option value="${o}">
                                                        </c:forEach>                                                                                                     
                                                    </datalist>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <button class="train-search__submit-btn" type="submit" style="height:76px;">Tìm kiếm</button>
                    </div>
                </div>
            </div>
        </div>

        <!-- Nav end -->

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
