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
        <link href="css/trainshow.css" rel="stylesheet">
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.4.0/css/font-awesome.min.css"> 
        <style>


            .cart-item {
                padding: 10px;
                margin: 5px 0;
                background-color: #f9f9f9;
                border-radius: 3px;
            }

            .selected-seat {
                background-color: #e3f2fd;
                border: 2px solid #2196f3;
            }

            .et-car-nm-64-sit {
                cursor: pointer;
            }

            .et-car-nm-64-sit:hover {
                background-color: #f5f5f5;
            }
        </style>
        <script>
            // Form validation
            function validateForm() {
            var fromStation = document.getElementById('from_station').value;
            var toStation = document.getElementById('to_station').value;
            var departDate = document.getElementById('datepicker').value;
            var returnDate = document.getElementById('return_datepicker').value;
            if (!fromStation || !toStation) {
            alert('Vui lòng chọn ga đi và ga đến');
            return false;
            }

            if (fromStation === toStation) {
            alert('Ga đi và ga đến không được trùng nhau');
            return false;
            }

            if (!departDate) {
            alert('Vui lòng chọn ngày đi');
            return false;
            }

            // Validate dates
            var today = new Date();
            today.setHours(0, 0, 0, 0);
            var depart = new Date(departDate);
            if (depart < today) {
            alert('Ngày đi không thể là ngày trong quá khứ');
            return false;
            }

            if (returnDate) {
            var returnD = new Date(returnDate);
            if (returnD < depart) {
            alert('Ngày về phải sau ngày đi');
            return false;
            }
            }

            return true;
            }

            // Function to swap stations
            function swapData() {
            var fromStation = document.getElementById('from_station');
            var toStation = document.getElementById('to_station');
            var temp = fromStation.value;
            fromStation.value = toStation.value;
            toStation.value = temp;
            }

            // Set min date for datepickers to today
            window.onload = function() {
            var today = new Date().toISOString().split('T')[0];
            document.getElementById('datepicker').min = today;
            document.getElementById('return_datepicker').min = today;
            // Add event listener to update return date min value when depart date changes
            document.getElementById('datepicker').addEventListener('change', function() {
            document.getElementById('return_datepicker').min = this.value;
            });
            }
        </script>

        <script>
            document.addEventListener('DOMContentLoaded', function() {
            // Train selection
            const trainBlocks = document.querySelectorAll('.et-train-block');
            const trainHeads = document.querySelectorAll('.et-train-head');
            const cabinContainer = document.querySelector('.cabin-container');
            // Cabin selection
            const carBlocks = document.querySelectorAll('.et-car-block');
            const carIcons = document.querySelectorAll('.et-car-icon');
            // Handle train selection
            trainBlocks.forEach(block => {
            block.addEventListener('click', function(e) {
            const trainHead = this.querySelector('.et-train-head');
            if (!trainHead || e.target.closest('.et-train-head')) return;
            const trainId = this.getAttribute('data-train-id');
            selectTrain(trainId, trainHead);
            loadCabins(trainId);
            });
            });
            trainHeads.forEach(head => {
            head.addEventListener('click', function(e) {
            e.stopPropagation();
            const trainBlock = this.closest('.et-train-block');
            selectTrain(trainBlock.getAttribute('data-train-id'), this);
            });
            });
            // Handle cabin selection
            carBlocks.forEach(block => {
            block.addEventListener('click', function(e) {
            const carIcon = this.querySelector('.et-car-icon');
            if (!carIcon || e.target.closest('.et-car-icon')) return;
            selectCabin(carIcon.getAttribute('data-cabin-id'), carIcon);
            });
            });
            carIcons.forEach(icon => {
            icon.addEventListener('click', function(e) {
            e.stopPropagation();
            selectCabin(this.getAttribute('data-cabin-id'), this);
            });
            });
            function selectTrain(trainId, trainHead) {
            if (!trainId || !trainHead) return;
            // Update visual selection
            trainHeads.forEach(h => h.classList.remove('et-train-head-selected'));
            trainHead.classList.add('et-train-head-selected');
            // Update URL and redirect
            const currentUrl = new URL(window.location.href);
            const currentCabinId = currentUrl.searchParams.get('cabinId');
            currentUrl.searchParams.set('trainId', trainId);
            if (currentCabinId) {
            currentUrl.searchParams.delete('cabinId');
            }

            window.location.href = currentUrl.toString();
            }

            function selectCabin(cabinId, carIcon) {
            if (!cabinId || !carIcon) return;
            // Update visual selection
            carIcons.forEach(icon => icon.classList.remove('et-car-icon-selected'));
            carIcon.classList.add('et-car-icon-selected');
            // Update URL and redirect
            const currentUrl = new URL(window.location.href);
            currentUrl.searchParams.set('cabinId', cabinId);
            window.location.href = currentUrl.toString();
            }

            // Initialize selections from URL
            const urlParams = new URLSearchParams(window.location.search);
            const trainId = urlParams.get('trainId');
            const cabinId = urlParams.get('cabinId');
            // Set initial train selection
            if (trainId) {
            const trainBlock = document.querySelector(`.et-train-block[data-train-id="${trainId}"]`);
            if (trainBlock) {
            const trainHead = trainBlock.querySelector('.et-train-head');
            if (trainHead) {
            trainHead.classList.add('et-train-head-selected');
            }
            }
            } else if (trainHeads.length > 0) {
            // Select first train by default
            const firstTrainBlock = trainHeads[0].closest('.et-train-block');
            const firstTrainId = firstTrainBlock.getAttribute('data-train-id');
            if (firstTrainId) {
            selectTrain(firstTrainId, trainHeads[0]);
            }
            }

            // Set initial cabin selection
            if (cabinId) {
            const carIcon = document.querySelector(`.et-car-icon[data-cabin-id="${cabinId}"]`);
            if (carIcon) {
            carIcon.classList.add('et-car-icon-selected');
            }
            }
            });
        </script>
    </head>
    <body >
        <!--                 Spinner Start -->
        <!-- <div id="spinner" class="show bg-white position-fixed translate-middle w-100 vh-100 top-50 start-50 d-flex align-items-center justify-content-center">
            <div class="spinner-border text-primary" style="width: 3rem; height: 3rem;" role="status">
                <span class="sr-only">Loading...</span>
            </div>
        </div> -->
        <!--                 Spinner End -->
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
                            <a href="contact.html" class="nav-item nav-link">Liên hệ</a>
                        </div>
                    </div>
                </nav>
                <div class=" container-fluid pt-5 pb-5" style="background-color: #005F7A; height: 70px;">
                </div>
                <div >
                    <div class="container py-5" style="width: 100%;margin-left: auto;box-sizing: border-box;margin-right: auto;display: block;padding-left: 16px;padding-right: 16px;height: 80px;margin: auto;background: #ffffff;border-radius: 10px;position: absolute; left: 0;right: 0;top: 90px;padding: 8px;box-shadow: 0px 5px 20px 0px #0000001A;display: -webkit-box;display: -webkit-flex;display: -ms-flexbox; display: flex; -webkit-align-items: center;-webkit-box-align: center;-ms-flex-align: center; align-items: center;">
                        <form action="searchtrain" method="post" id="ticket-form" onsubmit="return validateForm()">
                            <div class="train-search__data">
                                <div class="date-picker">
                                    <div class="SingleDatePickerInput SingleDatePickerInput_1" >
                                        <div class="DateInput DateInput_1" style="display: flex;justify-content: normal;width: auto;margin: 0 auto;">
                                            <p>Thời gian đi <input type="date" id="datepicker" name="depart_date" value="${from_date}"></p>
                                            <div class="search-stations__divider"></div>
                                            <p style="margin-left: 5px;">Thời gian về <input type="date" id="return_datepicker" name="return_date"></p>
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
                                                            <input class="react-select__input" list="stations" autocapitalize="none" autocomplete="off" autocorrect="off" id="from_station" spellcheck="false" tabindex="0" type="text" aria-autocomplete="list" aria-expanded="false" aria-haspopup="true" role="combobox" aria-describedby="react-select-2-placeholder" value="${depart}" style="color: inherit; background: 0px center; opacity: 1;  width: 250px; grid-area: 1 / 2; font: inherit; min-width: 2px; border: 0px; margin: 0px;margin-left:40px; outline: 0px; padding: 0px;">
                                                        <datalist id="stations">
                                                            <c:forEach items="${listS}" var="station">
                                                                <option value="${station}">${station}</option>
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
                                                        <input class="react-select__input" list="stations" autocapitalize="none" autocomplete="off" autocorrect="off" id="to_station" spellcheck="false" tabindex="0" type="text" aria-autocomplete="list" aria-expanded="false" aria-haspopup="true" role="combobox" aria-describedby="react-select-3-placeholder" value="${desti}" style="color: inherit; background: 0px center; opacity: 1; width: 250px; grid-area: 1 / 2; font: inherit; min-width: 2px; border: 0px; margin: 0px; margin-left:40px ;outline: 0px; padding: 0px;">
                                                        <datalist id="stations">
                                                            <c:forEach items="${listS}" var="station">
                                                                <option value="${station}">${station}</option>
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
                    </form>
                </div>
            </div>
        </div>

        <!-- Nav end -->

        <div  class="container-fluid py-lg-5" style="background-color: #fafafa;margin-top: 6rem;">
            <div class="container py-5">
                <div class="row" style="top:3rem;">
                    <div class="col-xs-12 col-sm-8 et-col-md-9" style="border: 1px solid black;background-color: white;border-radius: 5px;"">
                        <div class="row et-page-header">
                            <span class="et-main-label ng-binding"> 
                                <strong class="ng-binding">Chiều đi:</strong> ngày ${from_date} từ ${depart} đến ${desti}</span>
                        </div>
                        <div class="row et-train-list">
                            <div class="previous-train et-col-md-1 text-center">
                                <div class="et-pre-train ng-scope et-arrow-disabled" ng-class="{'et-arrow-disabled': !canShiftBack}" ng-click="chuyenTruoc(true)" tooltip="Tàu trước">
                                    <div class="et-arrow-left"></div>
                                </div>
                            </div>                            
                            <div class="train-group"> 
                                <c:forEach items="${departSchedules}" var="schedule">
                                    <div class="col-xs-4 col-sm-3 et-col-md-2 et-train-block ng-scope"  analytics-on="click" analytics-event="SelectTrain">
                                        <div class="et-train-head"  data-train-id="${schedule.getTrid()}">
                                            <div class="row center-block" style="width: 40%; margin-bottom: 3px">
                                                <div class="et-train-lamp text-center ng-binding" style="color:#bf8c01;">${schedule.getTrid()}</div> 
                                            </div> 
                                            <div class="et-train-head-info">
                                                <div class="row et-no-margin">
                                                    <span class="pull-left et-bold ng-binding">TG đi</span> 
                                                    <span class="pull-right"></span> 
                                                    <span class="pull-right ng-binding">${schedule.getFrom_time()}</span>
                                                </div>
                                                <div class="row et-no-margin">
                                                    <span class="pull-left et-bold ng-binding">TG đến</span> 
                                                    <span class="pull-right"></span> 
                                                    <span class="pull-right ng-binding">05/03 18:10</span></div>
                                                <div class="row et-no-margin">
                                                    <div class="et-col-50 text-center">
                                                        <div class="et-text-sm ng-binding">SL chỗ trống</div>
                                                        <div class="et-text-large et-bold pull-right ng-binding" style="margin-right: 5px">${dao.searchAvailSeatsOfTrainWithScheduleID(schedule.getId())}</div>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="row et-no-margin">
                                                <div class="et-col-50">
                                                    <span class="et-train-lamp-bellow-left"></span>
                                                </div>
                                                <div class="et-col-50">
                                                    <span class="et-train-lamp-bellow-right"></span>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="et-train-base"></div>
                                        <div class="et-train-base-2"></div>
                                        <div class="et-train-base-3"></div>
                                        <div class="et-train-base-4"></div>
                                        <div class="et-train-base-5"></div>
                                    </div>   
                                </c:forEach>     
                            </div>

                            <div class="next-train col-md-1 text-center pull-right">
                                <div class="et-next-train ng-scope" ng-class="{'et-arrow-disabled': !canShiftForward}" ng-click="chuyenSau(true)" tooltip="Tàu sau">
                                    <div class="et-arrow-right"></div>
                                </div>
                            </div>
                        </div>                    
                        <div class="row" style="margin-left:-10PX">
                            <div class="col-md-12 et-no-margin">

                                <c:forEach items="${dao.searchCabinsWithTrainID('SE1')}" var="cabin">
                                    <div class="et-car-block ng-scope" tooltip="Giường nằm khoang 4 điều hòa (An28LV)">
                                        <div data-cabin-id="${cabin.getId()}" class="et-car-icon
                                             <c:if test="${dao.searchAvailSeatsOfCabinWithCabinID(cabin.getId()) == 0}"> et-car-icon-sold-out</c:if>
                                             <c:if test="${cabin.getStatus() == 1 && !cabin.isSelected()}"> et-car-icon-available</c:if>
                                             <c:if test="${cabin.getStatus() == 0 && !cabin.isSelected()}"> et-car-icon-full</c:if>
                                             <c:if test="${cabin.getStatus() == 2 && !cabin.isSelected()}"> et-car-icon-sold-out</c:if>
                                             <c:if test="${cabin.isChonChoTuDong() && !cabin.isSelected()}"> et-car-icon-other</c:if>">

                                                 <img src="img/trainCar2.png" ng-show="!toa.IsChonChoTuDong" class="">
                                                 <img src="img/trainCarAuto.png" ng-show="toa.IsChonChoTuDong" class="ng-hide">
                                             </div>
                                             <div class="text-center text-info et-car-label ng-binding">${cabin.getId()}</div>
                                    </div>
                                </c:forEach>
<!--<div id="car-icon-${cabin.id}" class="et-car-icon" onclick="selectCabin('${cabin.id}')" 
                                             data-cabin-id="${cabin.id}"-->
                                <!-- This will show the selected schedule ID at the bottom of the cabins list -->
                                <div class="et-car-block">
                                    <div class="et-car-icon">
                                        <img src="img/train2.png">
                                    </div>
                                    <div class="text-center text-info et-car-label ng-binding">SE1</div>
                                </div>
                            </div>
                        </div>
                        <div class="col-xs-12 col-sm-12 col-md-12 text-center">
                            <h4 class="ng-binding">Toa số 1: Ngồi mềm điều hòa</h4>
                        </div>
                        <div class="et-col-5"><div class="et-car-previous-floor text-center" ng-click="previousCar()">&lt;</div></div>
                        <div class="et-col-90">
                            <div class="et-full-width et-car-loading ng-hide" ng-show="!seatMap[0].Status">
                                <div class="row text-capitalize text-center">
                                    <!--                                    <img src="/img/loading51.gif" style="width: 20px; height: 20px">-->
                                </div>
                                <div class="row text-center">
                                    <!--                                    <span class="ng-binding">?ang t?i th?ng tin toa</span>-->
                                </div>
                            </div>
                            <div class="row et-car-floor">
                                <!--                                <div class="et-car-door">
                                                                </div>-->
                                <div class="et-car-nm-64-half-block">
                                    <div class="et-full-width" style="margin-left: 30px;">
                                        <div class="et-car-nm-64-sit ng-isolate-scope" onclick="selectSeat(this, '1', '1037000', 'SE1', '1')">
                                            <div class="et-car-seat-left et-seat-h-35">
                                                <div class="et-col-16 et-sit-side"></div>
                                                <div class="et-col-84 et-sit-sur-outer">
                                                    <div class="et-sit-sur text-center">
                                                        <div class="et-sit-no ng-scope">
                                                            <span class="ng-binding">1</span>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="et-car-nm-64-sit ng-isolate-scope" et-seat-left="" seat="seatMap[7]" direct="direct"><div class="et-car-seat-left et-seat-h-35" analytics-on="click" analytics-event="SelectTicket" ng-click="buyTicket(seat, direct)" ng-show="seat.Status"><div class="et-col-16 et-sit-side"></div><div class="et-col-84 et-sit-sur-outer"><div class="et-sit-sur text-center et-sit-bought" ng-class="{'et-sit-booked': seat.Status.Status == 2,'et-sit-bought': seat.Status.Status == 1, 'et-sit-longer': seat.Status.Status == 5, 'can-buy': seat.Status.Status == 5 & amp; & amp; seat.detail.fee > 0, 'et-sit-blocked': seat.Status.Status == 4 & amp; & amp; (!seat.Status.LyDo || seat.Status.LyDo.toLowerCase().indexOf('chỗ giãn cách') == - 1), 'et-sit-avaiable': seat.Status.Status == 3, 'et-sit-buying': seat.Status.Status == 6, 'et-sit-distancing': seat.Status.Status == 4 & amp; & amp; seat.Status.LyDo & amp; & amp; seat.Status.LyDo.toLowerCase().indexOf('chỗ giãn cách') != - 1}"><div data-popover="Chỗ đã bán" data-popover-title="Chỗ đã bán" data-popover-trigger="mouseenter" data-popover-placement="top" class="et-sit-no ng-scope"><span ng-show="!seat.waiting" class="ng-binding">8</span> <img src="img/loading51.gif" ng-show="seat.waiting" class="ng-hide"></div></div></div></div></div>
                                        <div class="et-car-nm-64-sit ng-isolate-scope" et-seat-left="" seat="seatMap[8]" direct="direct"><div class="et-car-seat-left et-seat-h-35" analytics-on="click" analytics-event="SelectTicket" ng-click="buyTicket(seat, direct)" ng-show="seat.Status"><div class="et-col-16 et-sit-side"></div><div class="et-col-84 et-sit-sur-outer"><div class="et-sit-sur text-center et-sit-bought" ng-class="{'et-sit-booked': seat.Status.Status == 2,'et-sit-bought': seat.Status.Status == 1, 'et-sit-longer': seat.Status.Status == 5, 'can-buy': seat.Status.Status == 5 & amp; & amp; seat.detail.fee > 0, 'et-sit-blocked': seat.Status.Status == 4 & amp; & amp; (!seat.Status.LyDo || seat.Status.LyDo.toLowerCase().indexOf('chỗ giãn cách') == - 1), 'et-sit-avaiable': seat.Status.Status == 3, 'et-sit-buying': seat.Status.Status == 6, 'et-sit-distancing': seat.Status.Status == 4 & amp; & amp; seat.Status.LyDo & amp; & amp; seat.Status.LyDo.toLowerCase().indexOf('chỗ giãn cách') != - 1}"><div data-popover="Chỗ đã bán" data-popover-title="Chỗ đã bán" data-popover-trigger="mouseenter" data-popover-placement="top" class="et-sit-no ng-scope"><span ng-show="!seat.waiting" class="ng-binding">9</span> <img src="img/loading51.gif" ng-show="seat.waiting" class="ng-hide"></div></div></div></div></div>
                                        <div class="et-car-nm-64-sit ng-isolate-scope" et-seat-left="" seat="seatMap[15]" direct="direct"><div class="et-car-seat-left et-seat-h-35" analytics-on="click" analytics-event="SelectTicket" ng-click="buyTicket(seat, direct)" ng-show="seat.Status"><div class="et-col-16 et-sit-side"></div><div class="et-col-84 et-sit-sur-outer"><div class="et-sit-sur text-center et-sit-bought" ng-class="{'et-sit-booked': seat.Status.Status == 2,'et-sit-bought': seat.Status.Status == 1, 'et-sit-longer': seat.Status.Status == 5, 'can-buy': seat.Status.Status == 5 & amp; & amp; seat.detail.fee > 0, 'et-sit-blocked': seat.Status.Status == 4 & amp; & amp; (!seat.Status.LyDo || seat.Status.LyDo.toLowerCase().indexOf('chỗ giãn cách') == - 1), 'et-sit-avaiable': seat.Status.Status == 3, 'et-sit-buying': seat.Status.Status == 6, 'et-sit-distancing': seat.Status.Status == 4 & amp; & amp; seat.Status.LyDo & amp; & amp; seat.Status.LyDo.toLowerCase().indexOf('chỗ giãn cách') != - 1}"><div data-popover="Chỗ đã bán" data-popover-title="Chỗ đã bán" data-popover-trigger="mouseenter" data-popover-placement="top" class="et-sit-no ng-scope"><span ng-show="!seat.waiting" class="ng-binding">16</span> <img src="img/loading51.gif" ng-show="seat.waiting" class="ng-hide"></div></div></div></div></div>
                                        <div class="et-car-nm-64-sit ng-isolate-scope" et-seat-left="" seat="seatMap[16]" direct="direct"><div class="et-car-seat-left et-seat-h-35" analytics-on="click" analytics-event="SelectTicket" ng-click="buyTicket(seat, direct)" ng-show="seat.Status"><div class="et-col-16 et-sit-side"></div><div class="et-col-84 et-sit-sur-outer"><div class="et-sit-sur text-center et-sit-bought" ng-class="{'et-sit-booked': seat.Status.Status == 2,'et-sit-bought': seat.Status.Status == 1, 'et-sit-longer': seat.Status.Status == 5, 'can-buy': seat.Status.Status == 5 & amp; & amp; seat.detail.fee > 0, 'et-sit-blocked': seat.Status.Status == 4 & amp; & amp; (!seat.Status.LyDo || seat.Status.LyDo.toLowerCase().indexOf('chỗ giãn cách') == - 1), 'et-sit-avaiable': seat.Status.Status == 3, 'et-sit-buying': seat.Status.Status == 6, 'et-sit-distancing': seat.Status.Status == 4 & amp; & amp; seat.Status.LyDo & amp; & amp; seat.Status.LyDo.toLowerCase().indexOf('chỗ giãn cách') != - 1}"><div data-popover="Chỗ đã bán" data-popover-title="Chỗ đã bán" data-popover-trigger="mouseenter" data-popover-placement="top" class="et-sit-no ng-scope"><span ng-show="!seat.waiting" class="ng-binding">17</span> <img src="img/loading51.gif" ng-show="seat.waiting" class="ng-hide"></div></div></div></div></div>
                                        <div class="et-car-nm-64-sit ng-isolate-scope" et-seat-left="" seat="seatMap[23]" direct="direct"><div class="et-car-seat-left et-seat-h-35" analytics-on="click" analytics-event="SelectTicket" ng-click="buyTicket(seat, direct)" ng-show="seat.Status"><div class="et-col-16 et-sit-side"></div><div class="et-col-84 et-sit-sur-outer"><div class="et-sit-sur text-center et-sit-bought" ng-class="{'et-sit-booked': seat.Status.Status == 2,'et-sit-bought': seat.Status.Status == 1, 'et-sit-longer': seat.Status.Status == 5, 'can-buy': seat.Status.Status == 5 & amp; & amp; seat.detail.fee > 0, 'et-sit-blocked': seat.Status.Status == 4 & amp; & amp; (!seat.Status.LyDo || seat.Status.LyDo.toLowerCase().indexOf('chỗ giãn cách') == - 1), 'et-sit-avaiable': seat.Status.Status == 3, 'et-sit-buying': seat.Status.Status == 6, 'et-sit-distancing': seat.Status.Status == 4 & amp; & amp; seat.Status.LyDo & amp; & amp; seat.Status.LyDo.toLowerCase().indexOf('chỗ giãn cách') != - 1}"><div data-popover="Chỗ đã bán" data-popover-title="Chỗ đã bán" data-popover-trigger="mouseenter" data-popover-placement="top" class="et-sit-no ng-scope"><span ng-show="!seat.waiting" class="ng-binding">24</span> <img src="img/loading51.gif" ng-show="seat.waiting" class="ng-hide"></div></div></div></div></div>
                                        <div class="et-car-nm-64-sit ng-isolate-scope" et-seat-left="" seat="seatMap[24]" direct="direct"><div class="et-car-seat-left et-seat-h-35" analytics-on="click" analytics-event="SelectTicket" ng-click="buyTicket(seat, direct)" ng-show="seat.Status"><div class="et-col-16 et-sit-side"></div><div class="et-col-84 et-sit-sur-outer"><div class="et-sit-sur text-center et-sit-bought" ng-class="{'et-sit-booked': seat.Status.Status == 2,'et-sit-bought': seat.Status.Status == 1, 'et-sit-longer': seat.Status.Status == 5, 'can-buy': seat.Status.Status == 5 & amp; & amp; seat.detail.fee > 0, 'et-sit-blocked': seat.Status.Status == 4 & amp; & amp; (!seat.Status.LyDo || seat.Status.LyDo.toLowerCase().indexOf('chỗ giãn cách') == - 1), 'et-sit-avaiable': seat.Status.Status == 3, 'et-sit-buying': seat.Status.Status == 6, 'et-sit-distancing': seat.Status.Status == 4 & amp; & amp; seat.Status.LyDo & amp; & amp; seat.Status.LyDo.toLowerCase().indexOf('chỗ giãn cách') != - 1}"><div data-popover="Chỗ đã bán" data-popover-title="Chỗ đã bán" data-popover-trigger="mouseenter" data-popover-placement="top" class="et-sit-no ng-scope"><span ng-show="!seat.waiting" class="ng-binding">25</span> <img src="img/loading51.gif" ng-show="seat.waiting" class="ng-hide"></div></div></div></div></div>
                                        <div class="et-car-nm-64-sit ng-isolate-scope" et-seat-left="" seat="seatMap[1]" direct="direct" style="clear: left;"><div class="et-car-seat-left et-seat-h-35" analytics-on="click" analytics-event="SelectTicket" ng-click="buyTicket(seat, direct)" ng-show="seat.Status"><div class="et-col-16 et-sit-side"></div><div class="et-col-84 et-sit-sur-outer"><div class="et-sit-sur text-center et-sit-bought" ng-class="{'et-sit-booked': seat.Status.Status == 2,'et-sit-bought': seat.Status.Status == 1, 'et-sit-longer': seat.Status.Status == 5, 'can-buy': seat.Status.Status == 5 & amp; & amp; seat.detail.fee > 0, 'et-sit-blocked': seat.Status.Status == 4 & amp; & amp; (!seat.Status.LyDo || seat.Status.LyDo.toLowerCase().indexOf('chỗ giãn cách') == - 1), 'et-sit-avaiable': seat.Status.Status == 3, 'et-sit-buying': seat.Status.Status == 6, 'et-sit-distancing': seat.Status.Status == 4 & amp; & amp; seat.Status.LyDo & amp; & amp; seat.Status.LyDo.toLowerCase().indexOf('chỗ giãn cách') != - 1}"><div data-popover="Chỗ đã bán" data-popover-title="Chỗ đã bán" data-popover-trigger="mouseenter" data-popover-placement="top" class="et-sit-no ng-scope"><span ng-show="!seat.waiting" class="ng-binding">2</span> <img src="img/loading51.gif" ng-show="seat.waiting" class="ng-hide"></div></div></div></div></div>
                                        <div class="et-car-nm-64-sit ng-isolate-scope" et-seat-left="" seat="seatMap[6]" direct="direct"><div class="et-car-seat-left et-seat-h-35" analytics-on="click" analytics-event="SelectTicket" ng-click="buyTicket(seat, direct)" ng-show="seat.Status"><div class="et-col-16 et-sit-side"></div><div class="et-col-84 et-sit-sur-outer"><div class="et-sit-sur text-center et-sit-bought" ng-class="{'et-sit-booked': seat.Status.Status == 2,'et-sit-bought': seat.Status.Status == 1, 'et-sit-longer': seat.Status.Status == 5, 'can-buy': seat.Status.Status == 5 & amp; & amp; seat.detail.fee > 0, 'et-sit-blocked': seat.Status.Status == 4 & amp; & amp; (!seat.Status.LyDo || seat.Status.LyDo.toLowerCase().indexOf('chỗ giãn cách') == - 1), 'et-sit-avaiable': seat.Status.Status == 3, 'et-sit-buying': seat.Status.Status == 6, 'et-sit-distancing': seat.Status.Status == 4 & amp; & amp; seat.Status.LyDo & amp; & amp; seat.Status.LyDo.toLowerCase().indexOf('chỗ giãn cách') != - 1}"><div data-popover="Chỗ đã bán" data-popover-title="Chỗ đã bán" data-popover-trigger="mouseenter" data-popover-placement="top" class="et-sit-no ng-scope"><span ng-show="!seat.waiting" class="ng-binding">7</span> <img src="img/loading51.gif" ng-show="seat.waiting" class="ng-hide"></div></div></div></div></div>
                                        <div class="et-car-nm-64-sit ng-isolate-scope" et-seat-left="" seat="seatMap[9]" direct="direct"><div class="et-car-seat-left et-seat-h-35" analytics-on="click" analytics-event="SelectTicket" ng-click="buyTicket(seat, direct)" ng-show="seat.Status"><div class="et-col-16 et-sit-side"></div><div class="et-col-84 et-sit-sur-outer"><div class="et-sit-sur text-center et-sit-avaiable" ng-class="{'et-sit-booked': seat.Status.Status == 2,'et-sit-bought': seat.Status.Status == 1, 'et-sit-longer': seat.Status.Status == 5, 'can-buy': seat.Status.Status == 5 & amp; & amp; seat.detail.fee > 0, 'et-sit-blocked': seat.Status.Status == 4 & amp; & amp; (!seat.Status.LyDo || seat.Status.LyDo.toLowerCase().indexOf('chỗ giãn cách') == - 1), 'et-sit-avaiable': seat.Status.Status == 3, 'et-sit-buying': seat.Status.Status == 6, 'et-sit-distancing': seat.Status.Status == 4 & amp; & amp; seat.Status.LyDo & amp; & amp; seat.Status.LyDo.toLowerCase().indexOf('chỗ giãn cách') != - 1}"><div data-popover="Giá: 1,037,000 VNĐ" data-popover-title="Chỗ trống" data-popover-trigger="mouseenter" data-popover-placement="top" class="et-sit-no ng-scope"><span ng-show="!seat.waiting" class="ng-binding">10</span> <img src="img/loading51.gif" ng-show="seat.waiting" class="ng-hide"></div></div></div></div></div>
                                        <div class="et-car-nm-64-sit ng-isolate-scope" et-seat-left="" seat="seatMap[14]" direct="direct"><div class="et-car-seat-left et-seat-h-35" analytics-on="click" analytics-event="SelectTicket" ng-click="buyTicket(seat, direct)" ng-show="seat.Status"><div class="et-col-16 et-sit-side"></div><div class="et-col-84 et-sit-sur-outer"><div class="et-sit-sur text-center et-sit-avaiable" ng-class="{'et-sit-booked': seat.Status.Status == 2,'et-sit-bought': seat.Status.Status == 1, 'et-sit-longer': seat.Status.Status == 5, 'can-buy': seat.Status.Status == 5 & amp; & amp; seat.detail.fee > 0, 'et-sit-blocked': seat.Status.Status == 4 & amp; & amp; (!seat.Status.LyDo || seat.Status.LyDo.toLowerCase().indexOf('chỗ giãn cách') == - 1), 'et-sit-avaiable': seat.Status.Status == 3, 'et-sit-buying': seat.Status.Status == 6, 'et-sit-distancing': seat.Status.Status == 4 & amp; & amp; seat.Status.LyDo & amp; & amp; seat.Status.LyDo.toLowerCase().indexOf('chỗ giãn cách') != - 1}"><div data-popover="Giá: 1,037,000 VNĐ" data-popover-title="Chỗ trống" data-popover-trigger="mouseenter" data-popover-placement="top" class="et-sit-no ng-scope"><span ng-show="!seat.waiting" class="ng-binding">15</span> <img src="img/loading51.gif" ng-show="seat.waiting" class="ng-hide"></div></div></div></div></div>
                                        <div class="et-car-nm-64-sit ng-isolate-scope" et-seat-left="" seat="seatMap[17]" direct="direct"><div class="et-car-seat-left et-seat-h-35" analytics-on="click" analytics-event="SelectTicket" ng-click="buyTicket(seat, direct)" ng-show="seat.Status"><div class="et-col-16 et-sit-side"></div><div class="et-col-84 et-sit-sur-outer"><div class="et-sit-sur text-center et-sit-avaiable" ng-class="{'et-sit-booked': seat.Status.Status == 2,'et-sit-bought': seat.Status.Status == 1, 'et-sit-longer': seat.Status.Status == 5, 'can-buy': seat.Status.Status == 5 & amp; & amp; seat.detail.fee > 0, 'et-sit-blocked': seat.Status.Status == 4 & amp; & amp; (!seat.Status.LyDo || seat.Status.LyDo.toLowerCase().indexOf('chỗ giãn cách') == - 1), 'et-sit-avaiable': seat.Status.Status == 3, 'et-sit-buying': seat.Status.Status == 6, 'et-sit-distancing': seat.Status.Status == 4 & amp; & amp; seat.Status.LyDo & amp; & amp; seat.Status.LyDo.toLowerCase().indexOf('chỗ giãn cách') != - 1}"><div data-popover="Giá: 1,037,000 VNĐ" data-popover-title="Chỗ trống" data-popover-trigger="mouseenter" data-popover-placement="top" class="et-sit-no ng-scope"><span ng-show="!seat.waiting" class="ng-binding">18</span> <img src="img/loading51.gif" ng-show="seat.waiting" class="ng-hide"></div></div></div></div></div>
                                        <div class="et-car-nm-64-sit ng-isolate-scope" et-seat-left="" seat="seatMap[22]" direct="direct"><div class="et-car-seat-left et-seat-h-35" analytics-on="click" analytics-event="SelectTicket" ng-click="buyTicket(seat, direct)" ng-show="seat.Status"><div class="et-col-16 et-sit-side"></div><div class="et-col-84 et-sit-sur-outer"><div class="et-sit-sur text-center et-sit-bought" ng-class="{'et-sit-booked': seat.Status.Status == 2,'et-sit-bought': seat.Status.Status == 1, 'et-sit-longer': seat.Status.Status == 5, 'can-buy': seat.Status.Status == 5 & amp; & amp; seat.detail.fee > 0, 'et-sit-blocked': seat.Status.Status == 4 & amp; & amp; (!seat.Status.LyDo || seat.Status.LyDo.toLowerCase().indexOf('chỗ giãn cách') == - 1), 'et-sit-avaiable': seat.Status.Status == 3, 'et-sit-buying': seat.Status.Status == 6, 'et-sit-distancing': seat.Status.Status == 4 & amp; & amp; seat.Status.LyDo & amp; & amp; seat.Status.LyDo.toLowerCase().indexOf('chỗ giãn cách') != - 1}"><div data-popover="Chỗ đã bán" data-popover-title="Chỗ đã bán" data-popover-trigger="mouseenter" data-popover-placement="top" class="et-sit-no ng-scope"><span ng-show="!seat.waiting" class="ng-binding">23</span> <img src="img/loading51.gif" ng-show="seat.waiting" class="ng-hide"></div></div></div></div></div>
                                        <div class="et-car-nm-64-sit ng-isolate-scope" et-seat-left="" seat="seatMap[25]" direct="direct"><div class="et-car-seat-left et-seat-h-35" analytics-on="click" analytics-event="SelectTicket" ng-click="buyTicket(seat, direct)" ng-show="seat.Status"><div class="et-col-16 et-sit-side"></div><div class="et-col-84 et-sit-sur-outer"><div class="et-sit-sur text-center et-sit-bought" ng-class="{'et-sit-booked': seat.Status.Status == 2,'et-sit-bought': seat.Status.Status == 1, 'et-sit-longer': seat.Status.Status == 5, 'can-buy': seat.Status.Status == 5 & amp; & amp; seat.detail.fee > 0, 'et-sit-blocked': seat.Status.Status == 4 & amp; & amp; (!seat.Status.LyDo || seat.Status.LyDo.toLowerCase().indexOf('chỗ giãn cách') == - 1), 'et-sit-avaiable': seat.Status.Status == 3, 'et-sit-buying': seat.Status.Status == 6, 'et-sit-distancing': seat.Status.Status == 4 & amp; & amp; seat.Status.LyDo & amp; & amp; seat.Status.LyDo.toLowerCase().indexOf('chỗ giãn cách') != - 1}"><div data-popover="Chỗ đã bán" data-popover-title="Chỗ đã bán" data-popover-trigger="mouseenter" data-popover-placement="top" class="et-sit-no ng-scope"><span ng-show="!seat.waiting" class="ng-binding">26</span> <img src="img/loading51.gif" ng-show="seat.waiting" class="ng-hide"></div></div></div></div></div>
                                        <div class="et-car-way et-full-width"></div>
                                        <div class="et-car-nm-64-sit ng-isolate-scope" et-seat-left="" seat="seatMap[2]" direct="direct"><div class="et-car-seat-left et-seat-h-35" analytics-on="click" analytics-event="SelectTicket" ng-click="buyTicket(seat, direct)" ng-show="seat.Status"><div class="et-col-16 et-sit-side"></div><div class="et-col-84 et-sit-sur-outer"><div class="et-sit-sur text-center et-sit-avaiable" ng-class="{'et-sit-booked': seat.Status.Status == 2,'et-sit-bought': seat.Status.Status == 1, 'et-sit-longer': seat.Status.Status == 5, 'can-buy': seat.Status.Status == 5 & amp; & amp; seat.detail.fee > 0, 'et-sit-blocked': seat.Status.Status == 4 & amp; & amp; (!seat.Status.LyDo || seat.Status.LyDo.toLowerCase().indexOf('chỗ giãn cách') == - 1), 'et-sit-avaiable': seat.Status.Status == 3, 'et-sit-buying': seat.Status.Status == 6, 'et-sit-distancing': seat.Status.Status == 4 & amp; & amp; seat.Status.LyDo & amp; & amp; seat.Status.LyDo.toLowerCase().indexOf('chỗ giãn cách') != - 1}"><div data-popover="Giá: 1,037,000 VNĐ" data-popover-title="Chỗ trống" data-popover-trigger="mouseenter" data-popover-placement="top" class="et-sit-no ng-scope"><span ng-show="!seat.waiting" class="ng-binding">3</span> <img src="img/loading51.gif" ng-show="seat.waiting" class="ng-hide"></div></div></div></div></div>
                                        <div class="et-car-nm-64-sit ng-isolate-scope" et-seat-left="" seat="seatMap[5]" direct="direct"><div class="et-car-seat-left et-seat-h-35" analytics-on="click" analytics-event="SelectTicket" ng-click="buyTicket(seat, direct)" ng-show="seat.Status"><div class="et-col-16 et-sit-side"></div><div class="et-col-84 et-sit-sur-outer"><div class="et-sit-sur text-center et-sit-bought" ng-class="{'et-sit-booked': seat.Status.Status == 2,'et-sit-bought': seat.Status.Status == 1, 'et-sit-longer': seat.Status.Status == 5, 'can-buy': seat.Status.Status == 5 & amp; & amp; seat.detail.fee > 0, 'et-sit-blocked': seat.Status.Status == 4 & amp; & amp; (!seat.Status.LyDo || seat.Status.LyDo.toLowerCase().indexOf('chỗ giãn cách') == - 1), 'et-sit-avaiable': seat.Status.Status == 3, 'et-sit-buying': seat.Status.Status == 6, 'et-sit-distancing': seat.Status.Status == 4 & amp; & amp; seat.Status.LyDo & amp; & amp; seat.Status.LyDo.toLowerCase().indexOf('chỗ giãn cách') != - 1}"><div data-popover="Chỗ đã bán" data-popover-title="Chỗ đã bán" data-popover-trigger="mouseenter" data-popover-placement="top" class="et-sit-no ng-scope"><span ng-show="!seat.waiting" class="ng-binding">6</span> <img src="img/loading51.gif" ng-show="seat.waiting" class="ng-hide"></div></div></div></div></div>
                                        <div class="et-car-nm-64-sit ng-isolate-scope" et-seat-left="" seat="seatMap[10]" direct="direct"><div class="et-car-seat-left et-seat-h-35" analytics-on="click" analytics-event="SelectTicket" ng-click="buyTicket(seat, direct)" ng-show="seat.Status"><div class="et-col-16 et-sit-side"></div><div class="et-col-84 et-sit-sur-outer"><div class="et-sit-sur text-center et-sit-bought" ng-class="{'et-sit-booked': seat.Status.Status == 2,'et-sit-bought': seat.Status.Status == 1, 'et-sit-longer': seat.Status.Status == 5, 'can-buy': seat.Status.Status == 5 & amp; & amp; seat.detail.fee > 0, 'et-sit-blocked': seat.Status.Status == 4 & amp; & amp; (!seat.Status.LyDo || seat.Status.LyDo.toLowerCase().indexOf('chỗ giãn cách') == - 1), 'et-sit-avaiable': seat.Status.Status == 3, 'et-sit-buying': seat.Status.Status == 6, 'et-sit-distancing': seat.Status.Status == 4 & amp; & amp; seat.Status.LyDo & amp; & amp; seat.Status.LyDo.toLowerCase().indexOf('chỗ giãn cách') != - 1}"><div data-popover="Chỗ đã bán" data-popover-title="Chỗ đã bán" data-popover-trigger="mouseenter" data-popover-placement="top" class="et-sit-no ng-scope"><span ng-show="!seat.waiting" class="ng-binding">11</span> <img src="img/loading51.gif" ng-show="seat.waiting" class="ng-hide"></div></div></div></div></div>
                                        <div class="et-car-nm-64-sit ng-isolate-scope" et-seat-left="" seat="seatMap[13]" direct="direct"><div class="et-car-seat-left et-seat-h-35" analytics-on="click" analytics-event="SelectTicket" ng-click="buyTicket(seat, direct)" ng-show="seat.Status"><div class="et-col-16 et-sit-side"></div><div class="et-col-84 et-sit-sur-outer"><div class="et-sit-sur text-center et-sit-bought" ng-class="{'et-sit-booked': seat.Status.Status == 2,'et-sit-bought': seat.Status.Status == 1, 'et-sit-longer': seat.Status.Status == 5, 'can-buy': seat.Status.Status == 5 & amp; & amp; seat.detail.fee > 0, 'et-sit-blocked': seat.Status.Status == 4 & amp; & amp; (!seat.Status.LyDo || seat.Status.LyDo.toLowerCase().indexOf('chỗ giãn cách') == - 1), 'et-sit-avaiable': seat.Status.Status == 3, 'et-sit-buying': seat.Status.Status == 6, 'et-sit-distancing': seat.Status.Status == 4 & amp; & amp; seat.Status.LyDo & amp; & amp; seat.Status.LyDo.toLowerCase().indexOf('chỗ giãn cách') != - 1}"><div data-popover="Chỗ đã bán" data-popover-title="Chỗ đã bán" data-popover-trigger="mouseenter" data-popover-placement="top" class="et-sit-no ng-scope"><span ng-show="!seat.waiting" class="ng-binding">14</span> <img src="img/loading51.gif" ng-show="seat.waiting" class="ng-hide"></div></div></div></div></div>
                                        <div class="et-car-nm-64-sit ng-isolate-scope" et-seat-left="" seat="seatMap[18]" direct="direct"><div class="et-car-seat-left et-seat-h-35" analytics-on="click" analytics-event="SelectTicket" ng-click="buyTicket(seat, direct)" ng-show="seat.Status"><div class="et-col-16 et-sit-side"></div><div class="et-col-84 et-sit-sur-outer"><div class="et-sit-sur text-center et-sit-bought" ng-class="{'et-sit-booked': seat.Status.Status == 2,'et-sit-bought': seat.Status.Status == 1, 'et-sit-longer': seat.Status.Status == 5, 'can-buy': seat.Status.Status == 5 & amp; & amp; seat.detail.fee > 0, 'et-sit-blocked': seat.Status.Status == 4 & amp; & amp; (!seat.Status.LyDo || seat.Status.LyDo.toLowerCase().indexOf('chỗ giãn cách') == - 1), 'et-sit-avaiable': seat.Status.Status == 3, 'et-sit-buying': seat.Status.Status == 6, 'et-sit-distancing': seat.Status.Status == 4 & amp; & amp; seat.Status.LyDo & amp; & amp; seat.Status.LyDo.toLowerCase().indexOf('chỗ giãn cách') != - 1}"><div data-popover="Chỗ đã bán" data-popover-title="Chỗ đã bán" data-popover-trigger="mouseenter" data-popover-placement="top" class="et-sit-no ng-scope"><span ng-show="!seat.waiting" class="ng-binding">19</span> <img src="img/loading51.gif" ng-show="seat.waiting" class="ng-hide"></div></div></div></div></div>
                                        <div class="et-car-nm-64-sit ng-isolate-scope" et-seat-left="" seat="seatMap[21]" direct="direct"><div class="et-car-seat-left et-seat-h-35" analytics-on="click" analytics-event="SelectTicket" ng-click="buyTicket(seat, direct)" ng-show="seat.Status"><div class="et-col-16 et-sit-side"></div><div class="et-col-84 et-sit-sur-outer"><div class="et-sit-sur text-center et-sit-bought" ng-class="{'et-sit-booked': seat.Status.Status == 2,'et-sit-bought': seat.Status.Status == 1, 'et-sit-longer': seat.Status.Status == 5, 'can-buy': seat.Status.Status == 5 & amp; & amp; seat.detail.fee > 0, 'et-sit-blocked': seat.Status.Status == 4 & amp; & amp; (!seat.Status.LyDo || seat.Status.LyDo.toLowerCase().indexOf('chỗ giãn cách') == - 1), 'et-sit-avaiable': seat.Status.Status == 3, 'et-sit-buying': seat.Status.Status == 6, 'et-sit-distancing': seat.Status.Status == 4 & amp; & amp; seat.Status.LyDo & amp; & amp; seat.Status.LyDo.toLowerCase().indexOf('chỗ giãn cách') != - 1}"><div data-popover="Chỗ đã bán" data-popover-title="Chỗ đã bán" data-popover-trigger="mouseenter" data-popover-placement="top" class="et-sit-no ng-scope"><span ng-show="!seat.waiting" class="ng-binding">22</span> <img src="img/loading51.gif" ng-show="seat.waiting" class="ng-hide"></div></div></div></div></div>
                                        <div class="et-car-nm-64-sit ng-isolate-scope" et-seat-left="" seat="seatMap[26]" direct="direct"><div class="et-car-seat-left et-seat-h-35" analytics-on="click" analytics-event="SelectTicket" ng-click="buyTicket(seat, direct)" ng-show="seat.Status"><div class="et-col-16 et-sit-side"></div><div class="et-col-84 et-sit-sur-outer"><div class="et-sit-sur text-center et-sit-bought" ng-class="{'et-sit-booked': seat.Status.Status == 2,'et-sit-bought': seat.Status.Status == 1, 'et-sit-longer': seat.Status.Status == 5, 'can-buy': seat.Status.Status == 5 & amp; & amp; seat.detail.fee > 0, 'et-sit-blocked': seat.Status.Status == 4 & amp; & amp; (!seat.Status.LyDo || seat.Status.LyDo.toLowerCase().indexOf('chỗ giãn cách') == - 1), 'et-sit-avaiable': seat.Status.Status == 3, 'et-sit-buying': seat.Status.Status == 6, 'et-sit-distancing': seat.Status.Status == 4 & amp; & amp; seat.Status.LyDo & amp; & amp; seat.Status.LyDo.toLowerCase().indexOf('chỗ giãn cách') != - 1}"><div data-popover="Chỗ đã bán" data-popover-title="Chỗ đã bán" data-popover-trigger="mouseenter" data-popover-placement="top" class="et-sit-no ng-scope"><span ng-show="!seat.waiting" class="ng-binding">27</span> <img src="img/loading51.gif" ng-show="seat.waiting" class="ng-hide"></div></div></div></div></div>
                                        <div class="et-car-nm-64-sit ng-isolate-scope" et-seat-left="" seat="seatMap[3]" direct="direct" style="clear: left;"><div class="et-car-seat-left et-seat-h-35" analytics-on="click" analytics-event="SelectTicket" ng-click="buyTicket(seat, direct)" ng-show="seat.Status"><div class="et-col-16 et-sit-side"></div><div class="et-col-84 et-sit-sur-outer"><div class="et-sit-sur text-center et-sit-bought" ng-class="{'et-sit-booked': seat.Status.Status == 2,'et-sit-bought': seat.Status.Status == 1, 'et-sit-longer': seat.Status.Status == 5, 'can-buy': seat.Status.Status == 5 & amp; & amp; seat.detail.fee > 0, 'et-sit-blocked': seat.Status.Status == 4 & amp; & amp; (!seat.Status.LyDo || seat.Status.LyDo.toLowerCase().indexOf('chỗ giãn cách') == - 1), 'et-sit-avaiable': seat.Status.Status == 3, 'et-sit-buying': seat.Status.Status == 6, 'et-sit-distancing': seat.Status.Status == 4 & amp; & amp; seat.Status.LyDo & amp; & amp; seat.Status.LyDo.toLowerCase().indexOf('chỗ giãn cách') != - 1}"><div data-popover="Chỗ đã bán" data-popover-title="Chỗ đã bán" data-popover-trigger="mouseenter" data-popover-placement="top" class="et-sit-no ng-scope"><span ng-show="!seat.waiting" class="ng-binding">4</span> <img src="img/loading51.gif" ng-show="seat.waiting" class="ng-hide"></div></div></div></div></div>
                                        <div class="et-car-nm-64-sit ng-isolate-scope" et-seat-left="" seat="seatMap[4]" direct="direct"><div class="et-car-seat-left et-seat-h-35" analytics-on="click" analytics-event="SelectTicket" ng-click="buyTicket(seat, direct)" ng-show="seat.Status"><div class="et-col-16 et-sit-side"></div><div class="et-col-84 et-sit-sur-outer"><div class="et-sit-sur text-center et-sit-bought" ng-class="{'et-sit-booked': seat.Status.Status == 2,'et-sit-bought': seat.Status.Status == 1, 'et-sit-longer': seat.Status.Status == 5, 'can-buy': seat.Status.Status == 5 & amp; & amp; seat.detail.fee > 0, 'et-sit-blocked': seat.Status.Status == 4 & amp; & amp; (!seat.Status.LyDo || seat.Status.LyDo.toLowerCase().indexOf('chỗ giãn cách') == - 1), 'et-sit-avaiable': seat.Status.Status == 3, 'et-sit-buying': seat.Status.Status == 6, 'et-sit-distancing': seat.Status.Status == 4 & amp; & amp; seat.Status.LyDo & amp; & amp; seat.Status.LyDo.toLowerCase().indexOf('chỗ giãn cách') != - 1}"><div data-popover="Chỗ đã bán" data-popover-title="Chỗ đã bán" data-popover-trigger="mouseenter" data-popover-placement="top" class="et-sit-no ng-scope"><span ng-show="!seat.waiting" class="ng-binding">5</span> <img src="img/loading51.gif" ng-show="seat.waiting" class="ng-hide"></div></div></div></div></div>
                                        <div class="et-car-nm-64-sit ng-isolate-scope" et-seat-left="" seat="seatMap[11]" direct="direct"><div class="et-car-seat-left et-seat-h-35" analytics-on="click" analytics-event="SelectTicket" ng-click="buyTicket(seat, direct)" ng-show="seat.Status"><div class="et-col-16 et-sit-side"></div><div class="et-col-84 et-sit-sur-outer"><div class="et-sit-sur text-center et-sit-bought" ng-class="{'et-sit-booked': seat.Status.Status == 2,'et-sit-bought': seat.Status.Status == 1, 'et-sit-longer': seat.Status.Status == 5, 'can-buy': seat.Status.Status == 5 & amp; & amp; seat.detail.fee > 0, 'et-sit-blocked': seat.Status.Status == 4 & amp; & amp; (!seat.Status.LyDo || seat.Status.LyDo.toLowerCase().indexOf('chỗ giãn cách') == - 1), 'et-sit-avaiable': seat.Status.Status == 3, 'et-sit-buying': seat.Status.Status == 6, 'et-sit-distancing': seat.Status.Status == 4 & amp; & amp; seat.Status.LyDo & amp; & amp; seat.Status.LyDo.toLowerCase().indexOf('chỗ giãn cách') != - 1}"><div data-popover="Chỗ đã bán" data-popover-title="Chỗ đã bán" data-popover-trigger="mouseenter" data-popover-placement="top" class="et-sit-no ng-scope"><span ng-show="!seat.waiting" class="ng-binding">12</span> <img src="img/loading51.gif" ng-show="seat.waiting" class="ng-hide"></div></div></div></div></div>
                                        <div class="et-car-nm-64-sit ng-isolate-scope" et-seat-left="" seat="seatMap[12]" direct="direct"><div class="et-car-seat-left et-seat-h-35" analytics-on="click" analytics-event="SelectTicket" ng-click="buyTicket(seat, direct)" ng-show="seat.Status"><div class="et-col-16 et-sit-side"></div><div class="et-col-84 et-sit-sur-outer"><div class="et-sit-sur text-center et-sit-bought" ng-class="{'et-sit-booked': seat.Status.Status == 2,'et-sit-bought': seat.Status.Status == 1, 'et-sit-longer': seat.Status.Status == 5, 'can-buy': seat.Status.Status == 5 & amp; & amp; seat.detail.fee > 0, 'et-sit-blocked': seat.Status.Status == 4 & amp; & amp; (!seat.Status.LyDo || seat.Status.LyDo.toLowerCase().indexOf('chỗ giãn cách') == - 1), 'et-sit-avaiable': seat.Status.Status == 3, 'et-sit-buying': seat.Status.Status == 6, 'et-sit-distancing': seat.Status.Status == 4 & amp; & amp; seat.Status.LyDo & amp; & amp; seat.Status.LyDo.toLowerCase().indexOf('chỗ giãn cách') != - 1}"><div data-popover="Chỗ đã bán" data-popover-title="Chỗ đã bán" data-popover-trigger="mouseenter" data-popover-placement="top" class="et-sit-no ng-scope"><span ng-show="!seat.waiting" class="ng-binding">13</span> <img src="img/loading51.gif" ng-show="seat.waiting" class="ng-hide"></div></div></div></div></div>
                                        <div class="et-car-nm-64-sit ng-isolate-scope" et-seat-left="" seat="seatMap[19]" direct="direct"><div class="et-car-seat-left et-seat-h-35" analytics-on="click" analytics-event="SelectTicket" ng-click="buyTicket(seat, direct)" ng-show="seat.Status"><div class="et-col-16 et-sit-side"></div><div class="et-col-84 et-sit-sur-outer"><div class="et-sit-sur text-center et-sit-bought" ng-class="{'et-sit-booked': seat.Status.Status == 2,'et-sit-bought': seat.Status.Status == 1, 'et-sit-longer': seat.Status.Status == 5, 'can-buy': seat.Status.Status == 5 & amp; & amp; seat.detail.fee > 0, 'et-sit-blocked': seat.Status.Status == 4 & amp; & amp; (!seat.Status.LyDo || seat.Status.LyDo.toLowerCase().indexOf('chỗ giãn cách') == - 1), 'et-sit-avaiable': seat.Status.Status == 3, 'et-sit-buying': seat.Status.Status == 6, 'et-sit-distancing': seat.Status.Status == 4 & amp; & amp; seat.Status.LyDo & amp; & amp; seat.Status.LyDo.toLowerCase().indexOf('chỗ giãn cách') != - 1}"><div data-popover="Chỗ đã bán" data-popover-title="Chỗ đã bán" data-popover-trigger="mouseenter" data-popover-placement="top" class="et-sit-no ng-scope"><span ng-show="!seat.waiting" class="ng-binding">20</span> <img src="img/loading51.gif" ng-show="seat.waiting" class="ng-hide"></div></div></div></div></div>
                                        <div class="et-car-nm-64-sit ng-isolate-scope" et-seat-left="" seat="seatMap[20]" direct="direct"><div class="et-car-seat-left et-seat-h-35" analytics-on="click" analytics-event="SelectTicket" ng-click="buyTicket(seat, direct)" ng-show="seat.Status"><div class="et-col-16 et-sit-side"></div><div class="et-col-84 et-sit-sur-outer"><div class="et-sit-sur text-center et-sit-bought" ng-class="{'et-sit-booked': seat.Status.Status == 2,'et-sit-bought': seat.Status.Status == 1, 'et-sit-longer': seat.Status.Status == 5, 'can-buy': seat.Status.Status == 5 & amp; & amp; seat.detail.fee > 0, 'et-sit-blocked': seat.Status.Status == 4 & amp; & amp; (!seat.Status.LyDo || seat.Status.LyDo.toLowerCase().indexOf('chỗ giãn cách') == - 1), 'et-sit-avaiable': seat.Status.Status == 3, 'et-sit-buying': seat.Status.Status == 6, 'et-sit-distancing': seat.Status.Status == 4 & amp; & amp; seat.Status.LyDo & amp; & amp; seat.Status.LyDo.toLowerCase().indexOf('chỗ giãn cách') != - 1}"><div data-popover="Chỗ đã bán" data-popover-title="Chỗ đã bán" data-popover-trigger="mouseenter" data-popover-placement="top" class="et-sit-no ng-scope"><span ng-show="!seat.waiting" class="ng-binding">21</span> <img src="img/loading51.gif" ng-show="seat.waiting" class="ng-hide"></div></div></div></div></div>
                                        <div class="et-car-nm-64-sit ng-isolate-scope" et-seat-left="" seat="seatMap[27]" direct="direct"><div class="et-car-seat-left et-seat-h-35" analytics-on="click" analytics-event="SelectTicket" ng-click="buyTicket(seat, direct)" ng-show="seat.Status"><div class="et-col-16 et-sit-side"></div><div class="et-col-84 et-sit-sur-outer"><div class="et-sit-sur text-center et-sit-bought" ng-class="{'et-sit-booked': seat.Status.Status == 2,'et-sit-bought': seat.Status.Status == 1, 'et-sit-longer': seat.Status.Status == 5, 'can-buy': seat.Status.Status == 5 & amp; & amp; seat.detail.fee > 0, 'et-sit-blocked': seat.Status.Status == 4 & amp; & amp; (!seat.Status.LyDo || seat.Status.LyDo.toLowerCase().indexOf('chỗ giãn cách') == - 1), 'et-sit-avaiable': seat.Status.Status == 3, 'et-sit-buying': seat.Status.Status == 6, 'et-sit-distancing': seat.Status.Status == 4 & amp; & amp; seat.Status.LyDo & amp; & amp; seat.Status.LyDo.toLowerCase().indexOf('chỗ giãn cách') != - 1}"><div data-popover="Chỗ đã bán" data-popover-title="Chỗ đã bán" data-popover-trigger="mouseenter" data-popover-placement="top" class="et-sit-no ng-scope"><span ng-show="!seat.waiting" class="ng-binding">28</span> <img src="img/loading51.gif" ng-show="seat.waiting" class="ng-hide"></div></div></div></div></div>
                                    </div>
                                </div>
                                <div class="et-car-seperator" ng-class="{'et-hidden': !seatMap[0].Status}">
                                    <div>

                                    </div>
                                    <div>

                                    </div>
                                </div>
                                <div class="et-car-nm-64-half-block">
                                    <div class="et-full-width" style="margin-left: 8px;">
                                        <div class="et-car-nm-64-sit ng-isolate-scope" et-seat-right="" seat="seatMap[31]" direct="direct"><div class="et-car-seat-right et-seat-h-35" analytics-on="click" analytics-event="SelectTicket" ng-click="buyTicket(seat, direct)" ng-show="seat.Status"><div class="et-col-84 et-sit-sur-outer-invert"><div class="et-sit-sur-invert text-center et-sit-bought" ng-class="{'et-sit-booked': seat.Status.Status == 2,'et-sit-bought': seat.Status.Status == 1, 'et-sit-longer': seat.Status.Status == 5, 'can-buy': seat.Status.Status == 5 & amp; & amp; seat.detail.fee > 0, 'et-sit-blocked': seat.Status.Status == 4 & amp; & amp; (!seat.Status.LyDo || seat.Status.LyDo.toLowerCase().indexOf('chỗ giãn cách') == - 1), 'et-sit-avaiable': seat.Status.Status == 3, 'et-sit-buying': seat.Status.Status == 6, 'et-sit-distancing': seat.Status.Status == 4 & amp; & amp; seat.Status.LyDo & amp; & amp; seat.Status.LyDo.toLowerCase().indexOf('chỗ giãn cách') != - 1}"><div data-popover="Chỗ đã bán" data-popover-title="Chỗ đã bán" data-popover-trigger="mouseenter" data-popover-placement="top" class="et-sit-no ng-scope"><span ng-show="!seat.waiting" class="ng-binding">32</span> <img src="img/loading51.gif" ng-show="seat.waiting" class="ng-hide"></div></div></div><div class="et-col-16 et-sit-side"></div></div></div>
                                        <div class="et-car-nm-64-sit ng-isolate-scope" et-seat-right="" seat="seatMap[32]" direct="direct"><div class="et-car-seat-right et-seat-h-35" analytics-on="click" analytics-event="SelectTicket" ng-click="buyTicket(seat, direct)" ng-show="seat.Status"><div class="et-col-84 et-sit-sur-outer-invert"><div class="et-sit-sur-invert text-center et-sit-bought" ng-class="{'et-sit-booked': seat.Status.Status == 2,'et-sit-bought': seat.Status.Status == 1, 'et-sit-longer': seat.Status.Status == 5, 'can-buy': seat.Status.Status == 5 & amp; & amp; seat.detail.fee > 0, 'et-sit-blocked': seat.Status.Status == 4 & amp; & amp; (!seat.Status.LyDo || seat.Status.LyDo.toLowerCase().indexOf('chỗ giãn cách') == - 1), 'et-sit-avaiable': seat.Status.Status == 3, 'et-sit-buying': seat.Status.Status == 6, 'et-sit-distancing': seat.Status.Status == 4 & amp; & amp; seat.Status.LyDo & amp; & amp; seat.Status.LyDo.toLowerCase().indexOf('chỗ giãn cách') != - 1}"><div data-popover="Chỗ đã bán" data-popover-title="Chỗ đã bán" data-popover-trigger="mouseenter" data-popover-placement="top" class="et-sit-no ng-scope"><span ng-show="!seat.waiting" class="ng-binding">33</span> <img src="img/loading51.gif" ng-show="seat.waiting" class="ng-hide"></div></div></div><div class="et-col-16 et-sit-side"></div></div></div>
                                        <div class="et-car-nm-64-sit ng-isolate-scope" et-seat-right="" seat="seatMap[39]" direct="direct"><div class="et-car-seat-right et-seat-h-35" analytics-on="click" analytics-event="SelectTicket" ng-click="buyTicket(seat, direct)" ng-show="seat.Status"><div class="et-col-84 et-sit-sur-outer-invert"><div class="et-sit-sur-invert text-center et-sit-bought" ng-class="{'et-sit-booked': seat.Status.Status == 2,'et-sit-bought': seat.Status.Status == 1, 'et-sit-longer': seat.Status.Status == 5, 'can-buy': seat.Status.Status == 5 & amp; & amp; seat.detail.fee > 0, 'et-sit-blocked': seat.Status.Status == 4 & amp; & amp; (!seat.Status.LyDo || seat.Status.LyDo.toLowerCase().indexOf('chỗ giãn cách') == - 1), 'et-sit-avaiable': seat.Status.Status == 3, 'et-sit-buying': seat.Status.Status == 6, 'et-sit-distancing': seat.Status.Status == 4 & amp; & amp; seat.Status.LyDo & amp; & amp; seat.Status.LyDo.toLowerCase().indexOf('chỗ giãn cách') != - 1}"><div data-popover="Chỗ đã bán" data-popover-title="Chỗ đã bán" data-popover-trigger="mouseenter" data-popover-placement="top" class="et-sit-no ng-scope"><span ng-show="!seat.waiting" class="ng-binding">40</span> <img src="img/loading51.gif" ng-show="seat.waiting" class="ng-hide"></div></div></div><div class="et-col-16 et-sit-side"></div></div></div>
                                        <div class="et-car-nm-64-sit ng-isolate-scope" et-seat-right="" seat="seatMap[40]" direct="direct"><div class="et-car-seat-right et-seat-h-35" analytics-on="click" analytics-event="SelectTicket" ng-click="buyTicket(seat, direct)" ng-show="seat.Status"><div class="et-col-84 et-sit-sur-outer-invert"><div class="et-sit-sur-invert text-center et-sit-bought" ng-class="{'et-sit-booked': seat.Status.Status == 2,'et-sit-bought': seat.Status.Status == 1, 'et-sit-longer': seat.Status.Status == 5, 'can-buy': seat.Status.Status == 5 & amp; & amp; seat.detail.fee > 0, 'et-sit-blocked': seat.Status.Status == 4 & amp; & amp; (!seat.Status.LyDo || seat.Status.LyDo.toLowerCase().indexOf('chỗ giãn cách') == - 1), 'et-sit-avaiable': seat.Status.Status == 3, 'et-sit-buying': seat.Status.Status == 6, 'et-sit-distancing': seat.Status.Status == 4 & amp; & amp; seat.Status.LyDo & amp; & amp; seat.Status.LyDo.toLowerCase().indexOf('chỗ giãn cách') != - 1}"><div data-popover="Chỗ đã bán" data-popover-title="Chỗ đã bán" data-popover-trigger="mouseenter" data-popover-placement="top" class="et-sit-no ng-scope"><span ng-show="!seat.waiting" class="ng-binding">41</span> <img src="img/loading51.gif" ng-show="seat.waiting" class="ng-hide"></div></div></div><div class="et-col-16 et-sit-side"></div></div></div>
                                        <div class="et-car-nm-64-sit ng-isolate-scope" et-seat-right="" seat="seatMap[47]" direct="direct"><div class="et-car-seat-right et-seat-h-35" analytics-on="click" analytics-event="SelectTicket" ng-click="buyTicket(seat, direct)" ng-show="seat.Status"><div class="et-col-84 et-sit-sur-outer-invert"><div class="et-sit-sur-invert text-center et-sit-bought" ng-class="{'et-sit-booked': seat.Status.Status == 2,'et-sit-bought': seat.Status.Status == 1, 'et-sit-longer': seat.Status.Status == 5, 'can-buy': seat.Status.Status == 5 & amp; & amp; seat.detail.fee > 0, 'et-sit-blocked': seat.Status.Status == 4 & amp; & amp; (!seat.Status.LyDo || seat.Status.LyDo.toLowerCase().indexOf('chỗ giãn cách') == - 1), 'et-sit-avaiable': seat.Status.Status == 3, 'et-sit-buying': seat.Status.Status == 6, 'et-sit-distancing': seat.Status.Status == 4 & amp; & amp; seat.Status.LyDo & amp; & amp; seat.Status.LyDo.toLowerCase().indexOf('chỗ giãn cách') != - 1}"><div data-popover="Chỗ đã bán" data-popover-title="Chỗ đã bán" data-popover-trigger="mouseenter" data-popover-placement="top" class="et-sit-no ng-scope"><span ng-show="!seat.waiting" class="ng-binding">48</span> <img src="img/loading51.gif" ng-show="seat.waiting" class="ng-hide"></div></div></div><div class="et-col-16 et-sit-side"></div></div></div>
                                        <div class="et-car-nm-64-sit ng-isolate-scope" et-seat-right="" seat="seatMap[48]" direct="direct"><div class="et-car-seat-right et-seat-h-35" analytics-on="click" analytics-event="SelectTicket" ng-click="buyTicket(seat, direct)" ng-show="seat.Status"><div class="et-col-84 et-sit-sur-outer-invert"><div class="et-sit-sur-invert text-center et-sit-avaiable" ng-class="{'et-sit-booked': seat.Status.Status == 2,'et-sit-bought': seat.Status.Status == 1, 'et-sit-longer': seat.Status.Status == 5, 'can-buy': seat.Status.Status == 5 & amp; & amp; seat.detail.fee > 0, 'et-sit-blocked': seat.Status.Status == 4 & amp; & amp; (!seat.Status.LyDo || seat.Status.LyDo.toLowerCase().indexOf('chỗ giãn cách') == - 1), 'et-sit-avaiable': seat.Status.Status == 3, 'et-sit-buying': seat.Status.Status == 6, 'et-sit-distancing': seat.Status.Status == 4 & amp; & amp; seat.Status.LyDo & amp; & amp; seat.Status.LyDo.toLowerCase().indexOf('chỗ giãn cách') != - 1}"><div data-popover="Giá: 1,037,000 VNĐ" data-popover-title="Chỗ trống" data-popover-trigger="mouseenter" data-popover-placement="top" class="et-sit-no ng-scope"><span ng-show="!seat.waiting" class="ng-binding">49</span> <img src="img/loading51.gif" ng-show="seat.waiting" class="ng-hide"></div></div></div><div class="et-col-16 et-sit-side"></div></div></div>
                                        <div class="et-car-nm-64-sit ng-isolate-scope" et-seat-right="" seat="seatMap[55]" direct="direct"><div class="et-car-seat-right et-seat-h-35" analytics-on="click" analytics-event="SelectTicket" ng-click="buyTicket(seat, direct)" ng-show="seat.Status"><div class="et-col-84 et-sit-sur-outer-invert"><div class="et-sit-sur-invert text-center et-sit-avaiable" ng-class="{'et-sit-booked': seat.Status.Status == 2,'et-sit-bought': seat.Status.Status == 1, 'et-sit-longer': seat.Status.Status == 5, 'can-buy': seat.Status.Status == 5 & amp; & amp; seat.detail.fee > 0, 'et-sit-blocked': seat.Status.Status == 4 & amp; & amp; (!seat.Status.LyDo || seat.Status.LyDo.toLowerCase().indexOf('chỗ giãn cách') == - 1), 'et-sit-avaiable': seat.Status.Status == 3, 'et-sit-buying': seat.Status.Status == 6, 'et-sit-distancing': seat.Status.Status == 4 & amp; & amp; seat.Status.LyDo & amp; & amp; seat.Status.LyDo.toLowerCase().indexOf('chỗ giãn cách') != - 1}"><div data-popover="Giá: 1,037,000 VNĐ" data-popover-title="Chỗ trống" data-popover-trigger="mouseenter" data-popover-placement="top" class="et-sit-no ng-scope"><span ng-show="!seat.waiting" class="ng-binding">56</span> <img src="img/loading51.gif" ng-show="seat.waiting" class="ng-hide"></div></div></div><div class="et-col-16 et-sit-side"></div></div></div>
                                        <div class="et-car-nm-64-sit ng-isolate-scope" et-seat-right="" seat="seatMap[30]" direct="direct" style="clear: left;"><div class="et-car-seat-right et-seat-h-35" analytics-on="click" analytics-event="SelectTicket" ng-click="buyTicket(seat, direct)" ng-show="seat.Status"><div class="et-col-84 et-sit-sur-outer-invert"><div class="et-sit-sur-invert text-center et-sit-bought" ng-class="{'et-sit-booked': seat.Status.Status == 2,'et-sit-bought': seat.Status.Status == 1, 'et-sit-longer': seat.Status.Status == 5, 'can-buy': seat.Status.Status == 5 & amp; & amp; seat.detail.fee > 0, 'et-sit-blocked': seat.Status.Status == 4 & amp; & amp; (!seat.Status.LyDo || seat.Status.LyDo.toLowerCase().indexOf('chỗ giãn cách') == - 1), 'et-sit-avaiable': seat.Status.Status == 3, 'et-sit-buying': seat.Status.Status == 6, 'et-sit-distancing': seat.Status.Status == 4 & amp; & amp; seat.Status.LyDo & amp; & amp; seat.Status.LyDo.toLowerCase().indexOf('chỗ giãn cách') != - 1}"><div data-popover="Chỗ đã bán" data-popover-title="Chỗ đã bán" data-popover-trigger="mouseenter" data-popover-placement="top" class="et-sit-no ng-scope"><span ng-show="!seat.waiting" class="ng-binding">31</span> <img src="img/loading51.gif" ng-show="seat.waiting" class="ng-hide"></div></div></div><div class="et-col-16 et-sit-side"></div></div></div>
                                        <div class="et-car-nm-64-sit ng-isolate-scope" et-seat-right="" seat="seatMap[33]" direct="direct"><div class="et-car-seat-right et-seat-h-35" analytics-on="click" analytics-event="SelectTicket" ng-click="buyTicket(seat, direct)" ng-show="seat.Status"><div class="et-col-84 et-sit-sur-outer-invert"><div class="et-sit-sur-invert text-center et-sit-bought" ng-class="{'et-sit-booked': seat.Status.Status == 2,'et-sit-bought': seat.Status.Status == 1, 'et-sit-longer': seat.Status.Status == 5, 'can-buy': seat.Status.Status == 5 & amp; & amp; seat.detail.fee > 0, 'et-sit-blocked': seat.Status.Status == 4 & amp; & amp; (!seat.Status.LyDo || seat.Status.LyDo.toLowerCase().indexOf('chỗ giãn cách') == - 1), 'et-sit-avaiable': seat.Status.Status == 3, 'et-sit-buying': seat.Status.Status == 6, 'et-sit-distancing': seat.Status.Status == 4 & amp; & amp; seat.Status.LyDo & amp; & amp; seat.Status.LyDo.toLowerCase().indexOf('chỗ giãn cách') != - 1}"><div data-popover="Chỗ đã bán" data-popover-title="Chỗ đã bán" data-popover-trigger="mouseenter" data-popover-placement="top" class="et-sit-no ng-scope"><span ng-show="!seat.waiting" class="ng-binding">34</span> <img src="img/loading51.gif" ng-show="seat.waiting" class="ng-hide"></div></div></div><div class="et-col-16 et-sit-side"></div></div></div>
                                        <div class="et-car-nm-64-sit ng-isolate-scope" et-seat-right="" seat="seatMap[38]" direct="direct"><div class="et-car-seat-right et-seat-h-35" analytics-on="click" analytics-event="SelectTicket" ng-click="buyTicket(seat, direct)" ng-show="seat.Status"><div class="et-col-84 et-sit-sur-outer-invert"><div class="et-sit-sur-invert text-center et-sit-bought" ng-class="{'et-sit-booked': seat.Status.Status == 2,'et-sit-bought': seat.Status.Status == 1, 'et-sit-longer': seat.Status.Status == 5, 'can-buy': seat.Status.Status == 5 & amp; & amp; seat.detail.fee > 0, 'et-sit-blocked': seat.Status.Status == 4 & amp; & amp; (!seat.Status.LyDo || seat.Status.LyDo.toLowerCase().indexOf('chỗ giãn cách') == - 1), 'et-sit-avaiable': seat.Status.Status == 3, 'et-sit-buying': seat.Status.Status == 6, 'et-sit-distancing': seat.Status.Status == 4 & amp; & amp; seat.Status.LyDo & amp; & amp; seat.Status.LyDo.toLowerCase().indexOf('chỗ giãn cách') != - 1}"><div data-popover="Chỗ đã bán" data-popover-title="Chỗ đã bán" data-popover-trigger="mouseenter" data-popover-placement="top" class="et-sit-no ng-scope"><span ng-show="!seat.waiting" class="ng-binding">39</span> <img src="img/loading51.gif" ng-show="seat.waiting" class="ng-hide"></div></div></div><div class="et-col-16 et-sit-side"></div></div></div>
                                        <div class="et-car-nm-64-sit ng-isolate-scope" et-seat-right="" seat="seatMap[41]" direct="direct"><div class="et-car-seat-right et-seat-h-35" analytics-on="click" analytics-event="SelectTicket" ng-click="buyTicket(seat, direct)" ng-show="seat.Status"><div class="et-col-84 et-sit-sur-outer-invert"><div class="et-sit-sur-invert text-center et-sit-avaiable" ng-class="{'et-sit-booked': seat.Status.Status == 2,'et-sit-bought': seat.Status.Status == 1, 'et-sit-longer': seat.Status.Status == 5, 'can-buy': seat.Status.Status == 5 & amp; & amp; seat.detail.fee > 0, 'et-sit-blocked': seat.Status.Status == 4 & amp; & amp; (!seat.Status.LyDo || seat.Status.LyDo.toLowerCase().indexOf('chỗ giãn cách') == - 1), 'et-sit-avaiable': seat.Status.Status == 3, 'et-sit-buying': seat.Status.Status == 6, 'et-sit-distancing': seat.Status.Status == 4 & amp; & amp; seat.Status.LyDo & amp; & amp; seat.Status.LyDo.toLowerCase().indexOf('chỗ giãn cách') != - 1}"><div data-popover="Giá: 1,037,000 VNĐ" data-popover-title="Chỗ trống" data-popover-trigger="mouseenter" data-popover-placement="top" class="et-sit-no ng-scope"><span ng-show="!seat.waiting" class="ng-binding">42</span> <img src="img/loading51.gif" ng-show="seat.waiting" class="ng-hide"></div></div></div><div class="et-col-16 et-sit-side"></div></div></div>
                                        <div class="et-car-nm-64-sit ng-isolate-scope" et-seat-right="" seat="seatMap[46]" direct="direct"><div class="et-car-seat-right et-seat-h-35" analytics-on="click" analytics-event="SelectTicket" ng-click="buyTicket(seat, direct)" ng-show="seat.Status"><div class="et-col-84 et-sit-sur-outer-invert"><div class="et-sit-sur-invert text-center et-sit-bought" ng-class="{'et-sit-booked': seat.Status.Status == 2,'et-sit-bought': seat.Status.Status == 1, 'et-sit-longer': seat.Status.Status == 5, 'can-buy': seat.Status.Status == 5 & amp; & amp; seat.detail.fee > 0, 'et-sit-blocked': seat.Status.Status == 4 & amp; & amp; (!seat.Status.LyDo || seat.Status.LyDo.toLowerCase().indexOf('chỗ giãn cách') == - 1), 'et-sit-avaiable': seat.Status.Status == 3, 'et-sit-buying': seat.Status.Status == 6, 'et-sit-distancing': seat.Status.Status == 4 & amp; & amp; seat.Status.LyDo & amp; & amp; seat.Status.LyDo.toLowerCase().indexOf('chỗ giãn cách') != - 1}"><div data-popover="Chỗ đã bán" data-popover-title="Chỗ đã bán" data-popover-trigger="mouseenter" data-popover-placement="top" class="et-sit-no ng-scope"><span ng-show="!seat.waiting" class="ng-binding">47</span> <img src="img/loading51.gif" ng-show="seat.waiting" class="ng-hide"></div></div></div><div class="et-col-16 et-sit-side"></div></div></div>
                                        <div class="et-car-nm-64-sit ng-isolate-scope" et-seat-right="" seat="seatMap[49]" direct="direct"><div class="et-car-seat-right et-seat-h-35" analytics-on="click" analytics-event="SelectTicket" ng-click="buyTicket(seat, direct)" ng-show="seat.Status"><div class="et-col-84 et-sit-sur-outer-invert"><div class="et-sit-sur-invert text-center et-sit-avaiable" ng-class="{'et-sit-booked': seat.Status.Status == 2,'et-sit-bought': seat.Status.Status == 1, 'et-sit-longer': seat.Status.Status == 5, 'can-buy': seat.Status.Status == 5 & amp; & amp; seat.detail.fee > 0, 'et-sit-blocked': seat.Status.Status == 4 & amp; & amp; (!seat.Status.LyDo || seat.Status.LyDo.toLowerCase().indexOf('chỗ giãn cách') == - 1), 'et-sit-avaiable': seat.Status.Status == 3, 'et-sit-buying': seat.Status.Status == 6, 'et-sit-distancing': seat.Status.Status == 4 & amp; & amp; seat.Status.LyDo & amp; & amp; seat.Status.LyDo.toLowerCase().indexOf('chỗ giãn cách') != - 1}"><div data-popover="Giá: 1,037,000 VNĐ" data-popover-title="Chỗ trống" data-popover-trigger="mouseenter" data-popover-placement="top" class="et-sit-no ng-scope"><span ng-show="!seat.waiting" class="ng-binding">50</span> <img src="img/loading51.gif" ng-show="seat.waiting" class="ng-hide"></div></div></div><div class="et-col-16 et-sit-side"></div></div></div>
                                        <div class="et-car-nm-64-sit ng-isolate-scope" et-seat-right="" seat="seatMap[54]" direct="direct"><div class="et-car-seat-right et-seat-h-35" analytics-on="click" analytics-event="SelectTicket" ng-click="buyTicket(seat, direct)" ng-show="seat.Status"><div class="et-col-84 et-sit-sur-outer-invert"><div class="et-sit-sur-invert text-center et-sit-avaiable" ng-class="{'et-sit-booked': seat.Status.Status == 2,'et-sit-bought': seat.Status.Status == 1, 'et-sit-longer': seat.Status.Status == 5, 'can-buy': seat.Status.Status == 5 & amp; & amp; seat.detail.fee > 0, 'et-sit-blocked': seat.Status.Status == 4 & amp; & amp; (!seat.Status.LyDo || seat.Status.LyDo.toLowerCase().indexOf('chỗ giãn cách') == - 1), 'et-sit-avaiable': seat.Status.Status == 3, 'et-sit-buying': seat.Status.Status == 6, 'et-sit-distancing': seat.Status.Status == 4 & amp; & amp; seat.Status.LyDo & amp; & amp; seat.Status.LyDo.toLowerCase().indexOf('chỗ giãn cách') != - 1}"><div data-popover="Giá: 1,037,000 VNĐ" data-popover-title="Chỗ trống" data-popover-trigger="mouseenter" data-popover-placement="top" class="et-sit-no ng-scope"><span ng-show="!seat.waiting" class="ng-binding">55</span> <img src="img/loading51.gif" ng-show="seat.waiting" class="ng-hide"></div></div></div><div class="et-col-16 et-sit-side"></div></div></div>
                                        <div class="et-car-way et-full-width"></div>
                                        <div class="et-car-nm-64-sit ng-isolate-scope" et-seat-right="" seat="seatMap[29]" direct="direct"><div class="et-car-seat-right et-seat-h-35" analytics-on="click" analytics-event="SelectTicket" ng-click="buyTicket(seat, direct)" ng-show="seat.Status"><div class="et-col-84 et-sit-sur-outer-invert"><div class="et-sit-sur-invert text-center et-sit-bought" ng-class="{'et-sit-booked': seat.Status.Status == 2,'et-sit-bought': seat.Status.Status == 1, 'et-sit-longer': seat.Status.Status == 5, 'can-buy': seat.Status.Status == 5 & amp; & amp; seat.detail.fee > 0, 'et-sit-blocked': seat.Status.Status == 4 & amp; & amp; (!seat.Status.LyDo || seat.Status.LyDo.toLowerCase().indexOf('chỗ giãn cách') == - 1), 'et-sit-avaiable': seat.Status.Status == 3, 'et-sit-buying': seat.Status.Status == 6, 'et-sit-distancing': seat.Status.Status == 4 & amp; & amp; seat.Status.LyDo & amp; & amp; seat.Status.LyDo.toLowerCase().indexOf('chỗ giãn cách') != - 1}"><div data-popover="Chỗ đã bán" data-popover-title="Chỗ đã bán" data-popover-trigger="mouseenter" data-popover-placement="top" class="et-sit-no ng-scope"><span ng-show="!seat.waiting" class="ng-binding">30</span> <img src="img/loading51.gif" ng-show="seat.waiting" class="ng-hide"></div></div></div><div class="et-col-16 et-sit-side"></div></div></div>
                                        <div class="et-car-nm-64-sit ng-isolate-scope" et-seat-right="" seat="seatMap[34]" direct="direct"><div class="et-car-seat-right et-seat-h-35" analytics-on="click" analytics-event="SelectTicket" ng-click="buyTicket(seat, direct)" ng-show="seat.Status"><div class="et-col-84 et-sit-sur-outer-invert"><div class="et-sit-sur-invert text-center et-sit-avaiable" ng-class="{'et-sit-booked': seat.Status.Status == 2,'et-sit-bought': seat.Status.Status == 1, 'et-sit-longer': seat.Status.Status == 5, 'can-buy': seat.Status.Status == 5 & amp; & amp; seat.detail.fee > 0, 'et-sit-blocked': seat.Status.Status == 4 & amp; & amp; (!seat.Status.LyDo || seat.Status.LyDo.toLowerCase().indexOf('chỗ giãn cách') == - 1), 'et-sit-avaiable': seat.Status.Status == 3, 'et-sit-buying': seat.Status.Status == 6, 'et-sit-distancing': seat.Status.Status == 4 & amp; & amp; seat.Status.LyDo & amp; & amp; seat.Status.LyDo.toLowerCase().indexOf('chỗ giãn cách') != - 1}"><div data-popover="Giá: 1,037,000 VNĐ" data-popover-title="Chỗ trống" data-popover-trigger="mouseenter" data-popover-placement="top" class="et-sit-no ng-scope"><span ng-show="!seat.waiting" class="ng-binding">35</span> <img src="img/loading51.gif" ng-show="seat.waiting" class="ng-hide"></div></div></div><div class="et-col-16 et-sit-side"></div></div></div>
                                        <div class="et-car-nm-64-sit ng-isolate-scope" et-seat-right="" seat="seatMap[37]" direct="direct"><div class="et-car-seat-right et-seat-h-35" analytics-on="click" analytics-event="SelectTicket" ng-click="buyTicket(seat, direct)" ng-show="seat.Status"><div class="et-col-84 et-sit-sur-outer-invert"><div class="et-sit-sur-invert text-center et-sit-bought" ng-class="{'et-sit-booked': seat.Status.Status == 2,'et-sit-bought': seat.Status.Status == 1, 'et-sit-longer': seat.Status.Status == 5, 'can-buy': seat.Status.Status == 5 & amp; & amp; seat.detail.fee > 0, 'et-sit-blocked': seat.Status.Status == 4 & amp; & amp; (!seat.Status.LyDo || seat.Status.LyDo.toLowerCase().indexOf('chỗ giãn cách') == - 1), 'et-sit-avaiable': seat.Status.Status == 3, 'et-sit-buying': seat.Status.Status == 6, 'et-sit-distancing': seat.Status.Status == 4 & amp; & amp; seat.Status.LyDo & amp; & amp; seat.Status.LyDo.toLowerCase().indexOf('chỗ giãn cách') != - 1}"><div data-popover="Chỗ đã bán" data-popover-title="Chỗ đã bán" data-popover-trigger="mouseenter" data-popover-placement="top" class="et-sit-no ng-scope"><span ng-show="!seat.waiting" class="ng-binding">38</span> <img src="img/loading51.gif" ng-show="seat.waiting" class="ng-hide"></div></div></div><div class="et-col-16 et-sit-side"></div></div></div>
                                        <div class="et-car-nm-64-sit ng-isolate-scope" et-seat-right="" seat="seatMap[42]" direct="direct"><div class="et-car-seat-right et-seat-h-35" analytics-on="click" analytics-event="SelectTicket" ng-click="buyTicket(seat, direct)" ng-show="seat.Status"><div class="et-col-84 et-sit-sur-outer-invert"><div class="et-sit-sur-invert text-center et-sit-bought" ng-class="{'et-sit-booked': seat.Status.Status == 2,'et-sit-bought': seat.Status.Status == 1, 'et-sit-longer': seat.Status.Status == 5, 'can-buy': seat.Status.Status == 5 & amp; & amp; seat.detail.fee > 0, 'et-sit-blocked': seat.Status.Status == 4 & amp; & amp; (!seat.Status.LyDo || seat.Status.LyDo.toLowerCase().indexOf('chỗ giãn cách') == - 1), 'et-sit-avaiable': seat.Status.Status == 3, 'et-sit-buying': seat.Status.Status == 6, 'et-sit-distancing': seat.Status.Status == 4 & amp; & amp; seat.Status.LyDo & amp; & amp; seat.Status.LyDo.toLowerCase().indexOf('chỗ giãn cách') != - 1}"><div data-popover="Chỗ đã bán" data-popover-title="Chỗ đã bán" data-popover-trigger="mouseenter" data-popover-placement="top" class="et-sit-no ng-scope"><span ng-show="!seat.waiting" class="ng-binding">43</span> <img src="img/loading51.gif" ng-show="seat.waiting" class="ng-hide"></div></div></div><div class="et-col-16 et-sit-side"></div></div></div>
                                        <div class="et-car-nm-64-sit ng-isolate-scope" et-seat-right="" seat="seatMap[45]" direct="direct"><div class="et-car-seat-right et-seat-h-35" analytics-on="click" analytics-event="SelectTicket" ng-click="buyTicket(seat, direct)" ng-show="seat.Status"><div class="et-col-84 et-sit-sur-outer-invert"><div class="et-sit-sur-invert text-center et-sit-avaiable" ng-class="{'et-sit-booked': seat.Status.Status == 2,'et-sit-bought': seat.Status.Status == 1, 'et-sit-longer': seat.Status.Status == 5, 'can-buy': seat.Status.Status == 5 & amp; & amp; seat.detail.fee > 0, 'et-sit-blocked': seat.Status.Status == 4 & amp; & amp; (!seat.Status.LyDo || seat.Status.LyDo.toLowerCase().indexOf('chỗ giãn cách') == - 1), 'et-sit-avaiable': seat.Status.Status == 3, 'et-sit-buying': seat.Status.Status == 6, 'et-sit-distancing': seat.Status.Status == 4 & amp; & amp; seat.Status.LyDo & amp; & amp; seat.Status.LyDo.toLowerCase().indexOf('chỗ giãn cách') != - 1}"><div data-popover="Giá: 1,037,000 VNĐ" data-popover-title="Chỗ trống" data-popover-trigger="mouseenter" data-popover-placement="top" class="et-sit-no ng-scope"><span ng-show="!seat.waiting" class="ng-binding">46</span> <img src="img/loading51.gif" ng-show="seat.waiting" class="ng-hide"></div></div></div><div class="et-col-16 et-sit-side"></div></div></div>
                                        <div class="et-car-nm-64-sit ng-isolate-scope" et-seat-right="" seat="seatMap[50]" direct="direct"><div class="et-car-seat-right et-seat-h-35" analytics-on="click" analytics-event="SelectTicket" ng-click="buyTicket(seat, direct)" ng-show="seat.Status"><div class="et-col-84 et-sit-sur-outer-invert"><div class="et-sit-sur-invert text-center et-sit-avaiable" ng-class="{'et-sit-booked': seat.Status.Status == 2,'et-sit-bought': seat.Status.Status == 1, 'et-sit-longer': seat.Status.Status == 5, 'can-buy': seat.Status.Status == 5 & amp; & amp; seat.detail.fee > 0, 'et-sit-blocked': seat.Status.Status == 4 & amp; & amp; (!seat.Status.LyDo || seat.Status.LyDo.toLowerCase().indexOf('chỗ giãn cách') == - 1), 'et-sit-avaiable': seat.Status.Status == 3, 'et-sit-buying': seat.Status.Status == 6, 'et-sit-distancing': seat.Status.Status == 4 & amp; & amp; seat.Status.LyDo & amp; & amp; seat.Status.LyDo.toLowerCase().indexOf('chỗ giãn cách') != - 1}"><div data-popover="Giá: 1,037,000 VNĐ" data-popover-title="Chỗ trống" data-popover-trigger="mouseenter" data-popover-placement="top" class="et-sit-no ng-scope"><span ng-show="!seat.waiting" class="ng-binding">51</span> <img src="img/loading51.gif" ng-show="seat.waiting" class="ng-hide"></div></div></div><div class="et-col-16 et-sit-side"></div></div></div>
                                        <div class="et-car-nm-64-sit ng-isolate-scope" et-seat-right="" seat="seatMap[53]" direct="direct"><div class="et-car-seat-right et-seat-h-35" analytics-on="click" analytics-event="SelectTicket" ng-click="buyTicket(seat, direct)" ng-show="seat.Status"><div class="et-col-84 et-sit-sur-outer-invert"><div class="et-sit-sur-invert text-center et-sit-bought" ng-class="{'et-sit-booked': seat.Status.Status == 2,'et-sit-bought': seat.Status.Status == 1, 'et-sit-longer': seat.Status.Status == 5, 'can-buy': seat.Status.Status == 5 & amp; & amp; seat.detail.fee > 0, 'et-sit-blocked': seat.Status.Status == 4 & amp; & amp; (!seat.Status.LyDo || seat.Status.LyDo.toLowerCase().indexOf('chỗ giãn cách') == - 1), 'et-sit-avaiable': seat.Status.Status == 3, 'et-sit-buying': seat.Status.Status == 6, 'et-sit-distancing': seat.Status.Status == 4 & amp; & amp; seat.Status.LyDo & amp; & amp; seat.Status.LyDo.toLowerCase().indexOf('chỗ giãn cách') != - 1}"><div data-popover="Chỗ đã bán" data-popover-title="Chỗ đã bán" data-popover-trigger="mouseenter" data-popover-placement="top" class="et-sit-no ng-scope"><span ng-show="!seat.waiting" class="ng-binding">54</span> <img src="img/loading51.gif" ng-show="seat.waiting" class="ng-hide"></div></div></div><div class="et-col-16 et-sit-side"></div></div></div>
                                        <div class="et-car-nm-64-sit ng-isolate-scope" et-seat-right="" seat="seatMap[28]" direct="direct" style="clear: left;"><div class="et-car-seat-right et-seat-h-35" analytics-on="click" analytics-event="SelectTicket" ng-click="buyTicket(seat, direct)" ng-show="seat.Status"><div class="et-col-84 et-sit-sur-outer-invert"><div class="et-sit-sur-invert text-center et-sit-bought" ng-class="{'et-sit-booked': seat.Status.Status == 2,'et-sit-bought': seat.Status.Status == 1, 'et-sit-longer': seat.Status.Status == 5, 'can-buy': seat.Status.Status == 5 & amp; & amp; seat.detail.fee > 0, 'et-sit-blocked': seat.Status.Status == 4 & amp; & amp; (!seat.Status.LyDo || seat.Status.LyDo.toLowerCase().indexOf('chỗ giãn cách') == - 1), 'et-sit-avaiable': seat.Status.Status == 3, 'et-sit-buying': seat.Status.Status == 6, 'et-sit-distancing': seat.Status.Status == 4 & amp; & amp; seat.Status.LyDo & amp; & amp; seat.Status.LyDo.toLowerCase().indexOf('chỗ giãn cách') != - 1}"><div data-popover="Chỗ đã bán" data-popover-title="Chỗ đã bán" data-popover-trigger="mouseenter" data-popover-placement="top" class="et-sit-no ng-scope"><span ng-show="!seat.waiting" class="ng-binding">29</span> <img src="img/loading51.gif" ng-show="seat.waiting" class="ng-hide"></div></div></div><div class="et-col-16 et-sit-side"></div></div></div>
                                        <div class="et-car-nm-64-sit ng-isolate-scope" et-seat-right="" seat="seatMap[35]" direct="direct"><div class="et-car-seat-right et-seat-h-35" analytics-on="click" analytics-event="SelectTicket" ng-click="buyTicket(seat, direct)" ng-show="seat.Status"><div class="et-col-84 et-sit-sur-outer-invert"><div class="et-sit-sur-invert text-center et-sit-bought" ng-class="{'et-sit-booked': seat.Status.Status == 2,'et-sit-bought': seat.Status.Status == 1, 'et-sit-longer': seat.Status.Status == 5, 'can-buy': seat.Status.Status == 5 & amp; & amp; seat.detail.fee > 0, 'et-sit-blocked': seat.Status.Status == 4 & amp; & amp; (!seat.Status.LyDo || seat.Status.LyDo.toLowerCase().indexOf('chỗ giãn cách') == - 1), 'et-sit-avaiable': seat.Status.Status == 3, 'et-sit-buying': seat.Status.Status == 6, 'et-sit-distancing': seat.Status.Status == 4 & amp; & amp; seat.Status.LyDo & amp; & amp; seat.Status.LyDo.toLowerCase().indexOf('chỗ giãn cách') != - 1}"><div data-popover="Chỗ đã bán" data-popover-title="Chỗ đã bán" data-popover-trigger="mouseenter" data-popover-placement="top" class="et-sit-no ng-scope"><span ng-show="!seat.waiting" class="ng-binding">36</span> <img src="img/loading51.gif" ng-show="seat.waiting" class="ng-hide"></div></div></div><div class="et-col-16 et-sit-side"></div></div></div>
                                        <div class="et-car-nm-64-sit ng-isolate-scope" et-seat-right="" seat="seatMap[36]" direct="direct"><div class="et-car-seat-right et-seat-h-35" analytics-on="click" analytics-event="SelectTicket" ng-click="buyTicket(seat, direct)" ng-show="seat.Status"><div class="et-col-84 et-sit-sur-outer-invert"><div class="et-sit-sur-invert text-center et-sit-bought" ng-class="{'et-sit-booked': seat.Status.Status == 2,'et-sit-bought': seat.Status.Status == 1, 'et-sit-longer': seat.Status.Status == 5, 'can-buy': seat.Status.Status == 5 & amp; & amp; seat.detail.fee > 0, 'et-sit-blocked': seat.Status.Status == 4 & amp; & amp; (!seat.Status.LyDo || seat.Status.LyDo.toLowerCase().indexOf('chỗ giãn cách') == - 1), 'et-sit-avaiable': seat.Status.Status == 3, 'et-sit-buying': seat.Status.Status == 6, 'et-sit-distancing': seat.Status.Status == 4 & amp; & amp; seat.Status.LyDo & amp; & amp; seat.Status.LyDo.toLowerCase().indexOf('chỗ giãn cách') != - 1}"><div data-popover="Chỗ đã bán" data-popover-title="Chỗ đã bán" data-popover-trigger="mouseenter" data-popover-placement="top" class="et-sit-no ng-scope"><span ng-show="!seat.waiting" class="ng-binding">37</span> <img src="img/loading51.gif" ng-show="seat.waiting" class="ng-hide"></div></div></div><div class="et-col-16 et-sit-side"></div></div></div>
                                        <div class="et-car-nm-64-sit ng-isolate-scope" et-seat-right="" seat="seatMap[43]" direct="direct"><div class="et-car-seat-right et-seat-h-35" analytics-on="click" analytics-event="SelectTicket" ng-click="buyTicket(seat, direct)" ng-show="seat.Status"><div class="et-col-84 et-sit-sur-outer-invert"><div class="et-sit-sur-invert text-center et-sit-bought" ng-class="{'et-sit-booked': seat.Status.Status == 2,'et-sit-bought': seat.Status.Status == 1, 'et-sit-longer': seat.Status.Status == 5, 'can-buy': seat.Status.Status == 5 & amp; & amp; seat.detail.fee > 0, 'et-sit-blocked': seat.Status.Status == 4 & amp; & amp; (!seat.Status.LyDo || seat.Status.LyDo.toLowerCase().indexOf('chỗ giãn cách') == - 1), 'et-sit-avaiable': seat.Status.Status == 3, 'et-sit-buying': seat.Status.Status == 6, 'et-sit-distancing': seat.Status.Status == 4 & amp; & amp; seat.Status.LyDo & amp; & amp; seat.Status.LyDo.toLowerCase().indexOf('chỗ giãn cách') != - 1}"><div data-popover="Chỗ đã bán" data-popover-title="Chỗ đã bán" data-popover-trigger="mouseenter" data-popover-placement="top" class="et-sit-no ng-scope"><span ng-show="!seat.waiting" class="ng-binding">44</span> <img src="img/loading51.gif" ng-show="seat.waiting" class="ng-hide"></div></div></div><div class="et-col-16 et-sit-side"></div></div></div>
                                        <div class="et-car-nm-64-sit ng-isolate-scope" et-seat-right="" seat="seatMap[44]" direct="direct"><div class="et-car-seat-right et-seat-h-35" analytics-on="click" analytics-event="SelectTicket" ng-click="buyTicket(seat, direct)" ng-show="seat.Status"><div class="et-col-84 et-sit-sur-outer-invert"><div class="et-sit-sur-invert text-center et-sit-bought" ng-class="{'et-sit-booked': seat.Status.Status == 2,'et-sit-bought': seat.Status.Status == 1, 'et-sit-longer': seat.Status.Status == 5, 'can-buy': seat.Status.Status == 5 & amp; & amp; seat.detail.fee > 0, 'et-sit-blocked': seat.Status.Status == 4 & amp; & amp; (!seat.Status.LyDo || seat.Status.LyDo.toLowerCase().indexOf('chỗ giãn cách') == - 1), 'et-sit-avaiable': seat.Status.Status == 3, 'et-sit-buying': seat.Status.Status == 6, 'et-sit-distancing': seat.Status.Status == 4 & amp; & amp; seat.Status.LyDo & amp; & amp; seat.Status.LyDo.toLowerCase().indexOf('chỗ giãn cách') != - 1}"><div data-popover="Chỗ đã bán" data-popover-title="Chỗ đã bán" data-popover-trigger="mouseenter" data-popover-placement="top" class="et-sit-no ng-scope"><span ng-show="!seat.waiting" class="ng-binding">45</span> <img src="img/loading51.gif" ng-show="seat.waiting" class="ng-hide"></div></div></div><div class="et-col-16 et-sit-side"></div></div></div>
                                        <div class="et-car-nm-64-sit ng-isolate-scope" et-seat-right="" seat="seatMap[51]" direct="direct"><div class="et-car-seat-right et-seat-h-35" analytics-on="click" analytics-event="SelectTicket" ng-click="buyTicket(seat, direct)" ng-show="seat.Status"><div class="et-col-84 et-sit-sur-outer-invert"><div class="et-sit-sur-invert text-center et-sit-bought" ng-class="{'et-sit-booked': seat.Status.Status == 2,'et-sit-bought': seat.Status.Status == 1, 'et-sit-longer': seat.Status.Status == 5, 'can-buy': seat.Status.Status == 5 & amp; & amp; seat.detail.fee > 0, 'et-sit-blocked': seat.Status.Status == 4 & amp; & amp; (!seat.Status.LyDo || seat.Status.LyDo.toLowerCase().indexOf('chỗ giãn cách') == - 1), 'et-sit-avaiable': seat.Status.Status == 3, 'et-sit-buying': seat.Status.Status == 6, 'et-sit-distancing': seat.Status.Status == 4 & amp; & amp; seat.Status.LyDo & amp; & amp; seat.Status.LyDo.toLowerCase().indexOf('chỗ giãn cách') != - 1}"><div data-popover="Chỗ đã bán" data-popover-title="Chỗ đã bán" data-popover-trigger="mouseenter" data-popover-placement="top" class="et-sit-no ng-scope"><span ng-show="!seat.waiting" class="ng-binding">52</span> <img src="img/loading51.gif" ng-show="seat.waiting" class="ng-hide"></div></div></div><div class="et-col-16 et-sit-side"></div></div></div>
                                        <div class="et-car-nm-64-sit ng-isolate-scope" et-seat-right="" seat="seatMap[52]" direct="direct"><div class="et-car-seat-right et-seat-h-35" analytics-on="click" analytics-event="SelectTicket" ng-click="buyTicket(seat, direct)" ng-show="seat.Status"><div class="et-col-84 et-sit-sur-outer-invert"><div class="et-sit-sur-invert text-center et-sit-bought" ng-class="{'et-sit-booked': seat.Status.Status == 2,'et-sit-bought': seat.Status.Status == 1, 'et-sit-longer': seat.Status.Status == 5, 'can-buy': seat.Status.Status == 5 & amp; & amp; seat.detail.fee > 0, 'et-sit-blocked': seat.Status.Status == 4 & amp; & amp; (!seat.Status.LyDo || seat.Status.LyDo.toLowerCase().indexOf('chỗ giãn cách') == - 1), 'et-sit-avaiable': seat.Status.Status == 3, 'et-sit-buying': seat.Status.Status == 6, 'et-sit-distancing': seat.Status.Status == 4 & amp; & amp; seat.Status.LyDo & amp; & amp; seat.Status.LyDo.toLowerCase().indexOf('chỗ giãn cách') != - 1}"><div data-popover="Chỗ đã bán" data-popover-title="Chỗ đã bán" data-popover-trigger="mouseenter" data-popover-placement="top" class="et-sit-no ng-scope"><span ng-show="!seat.waiting" class="ng-binding">53</span> <img src="img/loading51.gif" ng-show="seat.waiting" class="ng-hide"></div></div></div><div class="et-col-16 et-sit-side"></div></div></div>
                                    </div>
                                </div>
                                <div class="et-car-door">

                                </div>
                            </div>
                        </div>

                        <div class="et-col-5"><div class="et-car-next-floor text-center" ng-click="nextCar()">&gt;</div></div>
                    <div class="et-col-md-12 table-bordered list-ticket-deskhop" ng-show="(searchData.toaDi&amp;&amp;!searchData.toaDi.IsChonChoTuDong)||(searchData.toaVe&amp;&amp;!searchData.toaVe.IsChonChoTuDong)" style="margin-top: 20px; padding: 5px"><div class="et-col-md-12"><div class="et-col-md-4 et-no-padding"><div class="et-col-md-12"><div class="et-col-md-12" style="padding:0px"><div class="et-col-md-12" style="padding:6px 0px 0px 0px"><div class="et-car-block" style="height:36px"><div class="et-car-icon et-car-icon-avaiable"><img src="img/trainCar2.png"></div></div><span style="padding-left:6px" class="ng-binding">Toa còn vé</span></div></div><div class="et-col-md-12 text-center et-no-padding ng-binding" style="margin-top: -20px;display:none">Toa còn vé</div></div></div><div class="et-col-md-3 et-no-padding" style="display:none"><div class="et-col-md-12"><div class="et-col-md-12" style="padding:0px"><div class="et-col-md-12" style="padding:6px 0px 0px 0px;"><div class="et-car-block" style="height:36px"><div class="et-car-icon et-car-icon-full"><img src="img/trainCar2.png"></div></div><span style="padding-left:6px" class="ng-binding">Toa chưa bán</span></div></div><div class="et-col-md-12 et-no-padding text-center ng-binding" style="margin-top: -20px;display:none">Toa chưa bán</div></div></div><div class="et-col-md-4 et-no-padding"><div class="et-col-md-12"><div class="et-col-md-12" style="padding:0px"><div class="et-col-md-12" style="padding:6px 0px 0px 0px;"><div class="et-car-block" style="height:36px"><div class="et-car-icon et-car-icon-selected"><img src="img/trainCar2.png"></div></div><span style="padding-left:6px" class="ng-binding">Toa đang chọn</span></div></div><div class="et-col-md-12 et-no-padding text-center ng-binding" style="margin-top: -20px;display:none">Toa đang chọn</div></div></div><div class="et-col-md-4 et-no-padding"><div class="et-col-md-12"><div class="et-col-md-12" style="padding:0px"><div class="et-col-md-12" style="padding:6px 0px 0px 0px;"><div class="et-car-block" style="height:36px"><div class="et-car-icon et-car-icon-sold-out"><img src="img/trainCar2.png"></div></div><span style="padding-left:6px" class="ng-binding">Toa hết vé</span></div></div><div class="et-col-md-12 text-center et-no-padding ng-binding" style="margin-top: -20px;display:none">Toa hết vé</div></div></div></div><div class="et-col-md-12 table-bordered"></div><div class="et-col-md-12 et-legend" style="padding:0px"><div class="et-col-md-4" style="padding: 0px"><div class="et-col-md-4" style="padding: 0px"><div class="row"><div class="et-car-nm-64-sit et-col-md-6" style="padding-right:0px"><div class="et-col-16 et-sit-side"></div><div class="et-col-64 et-sit-sur-outer"><div class="et-sit-sur text-center"></div></div></div><div class="et-bed-left et-col-md-3 et-no-padding" style="width:30%"><div class="et-bed-outer"><div class="et-bed text-center"></div><div class="et-bed-illu"></div></div></div></div></div><div class="et-col-md-8" style="padding: 0px"><div class="et-legend-label ng-binding" style="margin-left:-6px">Chỗ trống</div></div></div><div class="et-col-md-4" style="padding: 0px"><div class="et-col-md-4" style="padding: 0px"><div class="row"><div class="et-car-nm-64-sit et-col-md-6" style="padding-right:0px"><div class="et-col-16 et-sit-side"></div><div class="et-col-64 et-sit-sur-outer"><div class="et-sit-sur text-center et-sit-longer"></div></div></div><div class="et-bed-left et-col-md-3 et-no-padding" style="width:30%"><div class="et-bed-outer"><div class="et-bed text-center et-sit-longer"></div><div class="et-bed-illu"></div></div></div></div></div><div class="et-col-md-8" style="padding: 0px"><div class="et-legend-label ng-binding" style="margin-left:-6px">Chỗ chưa cắt chặng</div></div></div><div class="et-col-md-4" style="padding: 0px"><div class="et-col-md-4" style="padding: 0px"><div class="row"><div class="et-car-nm-64-sit et-col-md-6" style="padding-right:0px"><div class="et-col-16 et-sit-side"></div><div class="et-col-64 et-sit-sur-outer"><div class="et-sit-sur text-center et-sit-blocked"></div></div></div><div class="et-bed-left et-col-md-3 et-no-padding" style="width:30%"><div class="et-bed-outer"><div class="et-bed text-center et-sit-blocked"></div><div class="et-bed-illu"></div></div></div></div></div><div class="et-col-md-8" style="padding: 0px"><div class="et-legend-label ng-binding" style="margin-left:-6px">Chỗ đã bán, không bán</div></div></div></div></div>
                    </div>
                    <!--<div class="track"></div>
                      <div class="train"></div>-->
                    <div class="col-3 cart-section" style="border: 1px solid black;background-color: white;border-radius: 5px;" >
                        <h4 class="mb-3">Giỏ vé</h4>
                        <div id="selectedSeats">
                            <!-- Selected seats will be displayed here -->
                        </div>
                        <form id="orderForm" action="processOrder" method="POST" style="display: none;">
                            <input type="hidden" id="seatInfo" name="seatInfo">
                            <input type="hidden" id="from_station" name="from_station" value="${depart}">
                            <input type="hidden" id="to_station" name="to_station" value="${desti}">
                            <input type="hidden" id="from_date" name="from_date" value="${from_date}">
                            <button type="submit" class="btn btn-primary w-100" style="margin-top: 15px;">
                                Đặt vé
                            </button>
                        </form>
                    </div>


                </div>
            </div>
        </div>
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

        <!-- Swap data Javascript -->
        <script>
                            function swapData() {
                            const isRoundTrip = document.getElementById('roundTrip').checked;
                            // Get the appropriate input elements based on trip type
                            const fromStation = isRoundTrip ?
                                    document.querySelector('#roundTrip-content #from_station') :
                                    document.querySelector('#oneWay-content #from_station');
                            const toStation = isRoundTrip ?
                                    document.querySelector('#roundTrip-content #to_station') :
                                    document.querySelector('#oneWay-content #to_station');
                            // Swap the values
                            if (fromStation && toStation) {
                            const temp = fromStation.value;
                            fromStation.value = toStation.value;
                            toStation.value = temp;
                            }
                            }
        </script>
        <script>
            document.addEventListener('DOMContentLoaded', function() {
            // Get all train blocks and train heads
            const trainBlocks = document.querySelectorAll('.et-train-block');
            const trainHeads = document.querySelectorAll('.et-train-head');
            // Add click event listener to each train block
            trainBlocks.forEach(block => {
            block.addEventListener('click', function(e) {
            // Remove selected class from all train heads
            trainHeads.forEach(head => {
            head.classList.remove('et-train-head-selected');
            });
            // Add selected class to the clicked train head
            const trainHead = this.querySelector('.et-train-head');
            if (trainHead) {
            trainHead.classList.add('et-train-head-selected');
            // Get schedule ID from the clicked train block
            const trainId = this.getAttribute('data-train-id');
            if (trainId) {
            window.location.href = `SearchResult.jsp?trainId=${trainId}`;
            }
            }
            });
            });
            // Add click event listener to each train head for direct selection
            trainHeads.forEach(head => {
            head.addEventListener('click', function(e) {
            e.stopPropagation(); // Prevent event bubbling to train block

            // Remove selected class from all train heads
            trainHeads.forEach(h => {
            h.classList.remove('et-train-head-selected');
            });
            // Add selected class to the clicked train head
            this.classList.add('et-train-head-selected');
            // Get schedule ID from parent container
            const trainId = this.closest('.et-train-block').getAttribute('data-train-id');
            if (trainId) {
            window.location.href = `SearchResult.jsp?trainId=${trainId}`;
            }
            });
            });
            // Select the first train head by default and show cabins for it
            const firstTrainHead = trainHeads[0];
            if (firstTrainHead) {
            firstTrainHead.classList.add('et-train-head-selected');
            const trainId = firstTrainHead.closest('.et-train-block').getAttribute('data-train-id');
            if (trainId) {
            window.location.href = `SearchResult.jsp?trainId=${trainId}`;
            }
            }
            });</script>
    <script>
        function selectSeat(element, seatNumber, price, trainType, carNumber) {
        // Get the seat number from the clicked element
        const seatSpan = element.querySelector('.ng-binding');
        const actualSeatNumber = seatSpan ? seatSpan.textContent : seatNumber;
        // Format price with commas
        const formattedPrice = Number(price).toLocaleString('vi-VN');
        // Create cart item HTML with dynamic values
        const cartItem = `
    <div class="cart-item">
        <p><strong>Số ghế:</strong> 1</p>
        <p><strong>Loại tàu:</strong> SE1</p>
        <p><strong>Toa số:</strong>1</p>
        <p><strong>Giá:</strong> 1,037,000 VNĐ</p>
    </div>
`;
        // Update cart display
        const cart = document.getElementById('selectedSeats');
        if (cart) {
        cart.innerHTML = cartItem;
        }

        // Show the order form
        const orderForm = document.getElementById('orderForm');
        if (orderForm) {
        orderForm.style.display = 'block';
        // Update hidden input with seat information
        const seatInfo = {
        seatNumber: actualSeatNumber,
                trainType: trainType,
                carNumber: carNumber,
                price: price
        };
        document.getElementById('seatInfo').value = JSON.stringify(seatInfo);
        }

        // Highlight selected seat
        const allSeats = document.querySelectorAll('.et-car-seat-left');
        allSeats.forEach(seat => {
        seat.classList.remove('selected-seat');
        });
        element.classList.add('selected-seat');
        // Store selection in session
        fetch('UpdateSeatSession', {
        method: 'POST',
                headers: {
                'Content-Type': 'application/json'
                },
                body: JSON.stringify(seatInfo)
        })
                .then(response => response.json())
                .then(data => {
                if (!data.success) {
                console.error('Failed to update seat session');
                }
                })
                .catch(error => console.error('Error:', error));
        }
    </script>
    <input type="hidden" id="selectedTrainId" name="trainId" value="">

    ```
    ```
