<%-- 
    Document   : Home
    Created on : Jan 19, 2025, 10:48:04 PM
    Author     : tra my
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">

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
                            <a href="home" class="nav-item nav-link active">Trang chủ</a>
                            <a href="about.html" class="nav-item nav-link ">Thông tin đặt chỗ</a>
                            <a href="ScheduleDetailSearch.jsp" class="nav-item nav-link">Giờ tàu-Giá vé</a>                            
                            <a href="routesview" class="nav-item nav-link">Các tuyến đường</a>
                            <a href="TicketVerifi.jsp" class="nav-item nav-link">Kiểm tra vé</a>
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

                <div class="hero-header container-fluid bg-primary py-5 mb-5 ">
                    <div class="container py-5">
                        <div class="row justify-content-center py-5">
                            <div class="block_inner">
                                <h1 class="block__title" id="block-searchrouteblock-title" style="color:#dcdcdc;">
                                    <span>Thông tin vé tàu</span>
                                </h1>
                                <div class="block__content">
                                    <div class="element-container-wrapper">
                                        <div id="search-react-block-app">
                                            <div class="sticky-outer-wrapper train-search__sticky-wrapper">
                                                <div class="sticky-inner-wrapper inner-wrapper" style="position: relative; top: 0px;">
                                                    <div class="train-search">
                                                        <div>
                                                            <form action="search_train" method="post">
                                                                <div class="trip-switch">
                                                                    <label class="radio-button">
                                                                        <input type="radio" class="radio-input" name="options" readonly="" tabindex="0" value="oneWay" id="oneWay" checked="">
                                                                        <div class="radio-button__text">Một chiều</div>
                                                                    </label>
                                                                    <label class="radio-button">
                                                                        <input type="radio" class="radio-input" name="options" readonly="" tabindex="0" value="roundTrip" id="roundTrip">
                                                                        <div class="radio-button__text">Khứ hồi</div>
                                                                    </label>
                                                                </div>
                                                                <div id="oneWay-content" class="content">
                                                                    <div class="train-search__data">
                                                                        <div class="date-picker">
                                                                            <div class="SingleDatePickerInput SingleDatePickerInput_1">
                                                                                <div class="DateInput DateInput_1">
                                                                                    <p>Thời gian đi <input type="date" id="datepicker"></p>

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
                                                                                                    <input class="react-select__input" list="stations" autocapitalize="none" autocomplete="off" autocorrect="off" id="from_station" spellcheck="false" list="stations" tabindex="0" type="text" aria-autocomplete="list" aria-expanded="false" aria-haspopup="true" role="combobox" aria-describedby="react-select-2-placeholder" value="" style="color: inherit; background: 0px center; opacity: 1; width: 250px; grid-area: 1 / 2; font: inherit; min-width: 2px; border: 0px; margin: 0px;margin-left:40px; outline: 0px; padding: 0px;">
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
                                                                                                <input class="react-select__input" list="stations" autocapitalize="none" autocomplete="off" autocorrect="off" id="to_station" spellcheck="false" tabindex="0" type="text" aria-autocomplete="list" aria-expanded="false" aria-haspopup="true" role="combobox" aria-describedby="react-select-3-placeholder" value="" style="color: inherit; background: 0px center;  width: 250px; grid-area: 1 / 2; font: inherit; min-width: 2px; opacity: 1;border: 0px; margin: 0px;margin-left:40px; outline: 0px; padding: 0px;">
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
                                                                    <button class="train-search__submit-btn" type="submit">Tìm kiếm</button>
                                                                </div>
                                                            </div>
                                                            <div id="roundTrip-content" class="content" style="display:none;">
                                                                <div class="train-search__data">
                                                                    <div class="date-picker">
                                                                        <div class="SingleDatePickerInput SingleDatePickerInput_1">
                                                                            <div class="DateInput DateInput_1">
                                                                                <p>Thời gian đi <input type="date" id="input_from"></p>
                                                                                <p>Thời gian về <input type="date" id="input_to"></p>
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
                                                                                                <input class="react-select__input" list="stations" autocapitalize="none" autocomplete="off" autocorrect="off" id="to_station" spellcheck="false" tabindex="0" type="text" aria-autocomplete="list" aria-expanded="false" aria-haspopup="true" role="combobox" aria-describedby="react-select-3-placeholder" value="" style="color: inherit; background: 0px center; opacity: 1; width: 250px; grid-area: 1 / 2; font: inherit; min-width: 2px; border: 0px; margin: 0px; margin-left:40px ;outline: 0px; padding: 0px;">
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
                                                        </form>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!-- Navbar & Hero End -->



        <!-- Back to Top -->
        <a href="#" class="btn btn-lg btn-primary btn-lg-square back-to-top"><i class="bi bi-arrow-up"></i></a>

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

        <!-- Swap data Javascript -->
        <script>
                                                                                function swapData() {
                                                                                    // Lấy giá trị từ các input
                                                                                    var gaDi = document.getElementById("from_station").value;
                                                                                    var gaDen = document.getElementById("to_station").value;

                                                                                    // Đổi giá trị giữa hai input
                                                                                    document.getElementById("from_station").value = gaDen;
                                                                                    document.getElementById("to_station").value = gaDi;
                                                                                }


        </script>
    </script>
</body>

</html>