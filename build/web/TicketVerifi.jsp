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
                    <div style="background-color: aliceblue;padding: 20px;color: black;">
                        Để đảm bảo quyền lợi cho hành khách, tránh mua phải vé giả, hoặc vé không đúng với quy định, quý khách có thể kiểm tra lại vé điện tử của mình bằng cách điền đầy đủ các thông tin dưới đây.
                    </div>
             <div class="col-md-12">
        <div class="row">
            <div class="col-xs-4 col-sm-2 col-md-2">
                <label class="kt-form-label ng-binding" ng-class="{'has-error': maVeError}">Mã vé<!--Mã vé--></label>
            </div>
            <div class="col-xs-8 col-sm-4 col-md-4">
                <div class="form-group" ng-class="{'has-error': maVeError}">
                    <span class="control-label ng-binding ng-hide" ng-show="maVeError">Vui lòng nhập mã vé chính xác 8 hoặc 9 ký tự số<!--Vui lòng nhập mã vé chính xác 8 hoặc 9 ký tự số--></span>
                    <input type="text" class="form-control ng-pristine ng-valid" ng-model="searchData.maVe" ng-disabled="isRequesting" ng-change="maVeError = false" placeholder="Nhập mã vé gồm 8 hoặc 9 ký tự số" id="maVe">
                </div>
            </div>
            <div class="col-xs-4 col-sm-2 col-md-2">
                <label class="kt-form-label ng-binding" ng-class="{'has-error': macTauError}">Mác tàu<!--Mác tàu--></label>
            </div>
            <div class="col-xs-8 col-sm-4 col-md-4">
                <div class="form-group" ng-class="{'has-error': macTauError}">
                    <span class="control-label ng-binding ng-hide" ng-show="macTauError">Vui lòng nhập mác tàu chính xác<!--Vui lòng nhập mác tàu chính xác--></span>
                    <input type="text" class="form-control ng-pristine ng-valid" ng-model="searchData.macTau" ng-change="macTauError = false" placeholder="Ví dụ SE1, TN1, SE2, SE6 ..." id="gaDen">
                </div>
            </div>
        </div>
        <div class="row">
            <div class="col-xs-4 col-sm-2 col-md-2">
                <label class="kt-form-label ng-binding" ng-class="{'has-error': gaDiError}">Ga đi<!--Ga đi--></label>
            </div>
            <div class="col-xs-8 col-sm-4 col-md-4">
                <div class="form-group" ng-class="{'has-error': gaDiError}">
                    <span class="control-label ng-binding ng-hide" ng-show="gaDiError">Vui lòng nhập ga đi ghi trên vé<!--Vui lòng nhập ga đi ghi trên vé--></span>
                    <input type="text" class="form-control ng-pristine ng-valid" ng-model="searchData.tenGaDi" ng-change="verifyGa(searchData.tenGaDi, true)" typeahead-on-select="setMaGaDi($item)" typeahead="ga.TenGa for ga in gas | filter:$viewValue | limitTo:10" placeholder="Nhập mã ga đi tại đây" id="gaDi" aria-autocomplete="list" aria-expanded="false" aria-owns="typeahead-04T-503">
<!--                    <ul class="dropdown-menu ng-isolate-scope ng-hide" ng-show="isOpen()" ng-style="{top: position.top+'px', left: position.left+'px'}" style="display: block;;display: block;" role="listbox" aria-hidden="true" typeahead-popup="" id="typeahead-04T-503" matches="matches" active="activeIdx" select="select(activeIdx)" query="query" position="position">-->
    <!-- ngRepeat: match in matches track by $index -->
</ul>
                </div>
            </div>
            <div class="col-xs-4 col-sm-2 col-md-2">
                <label class="kt-form-label ng-binding" ng-class="{'has-error': gaDenError}">Ga đến<!--Ga đến--></label>
            </div>
            <div class="col-xs-8 col-sm-4 col-md-4">
                <div class="form-group" ng-class="{'has-error': gaDenError}">
                    <span class="control-label ng-binding ng-hide" ng-show="gaDenError">Vui lòng nhập ga đến ghi trên vé<!--Vui lòng nhập ga đến ghi trên vé--></span>
                    <input type="text" class="form-control ng-pristine ng-valid" ng-model="searchData.tenGaDen" ng-change="verifyGa(searchData.tenGaDen, false)" typeahead-on-select="setMaGaDen($item)" typeahead="ga.TenGa for ga in gas | filter:$viewValue | limitTo:10" placeholder="Nhập mã ga đến tại đây" id="gaDen" aria-autocomplete="list" aria-expanded="false" aria-owns="typeahead-04U-5945">
<!--                    <ul class="dropdown-menu ng-isolate-scope ng-hide" ng-show="isOpen()" ng-style="{top: position.top+'px', left: position.left+'px'}" style="display: block;;display: block;" role="listbox" aria-hidden="true" typeahead-popup="" id="typeahead-04U-5945" matches="matches" active="activeIdx" select="select(activeIdx)" query="query" position="position">-->
    <!-- ngRepeat: match in matches track by $index -->
</ul>
                </div>
            </div>
        </div>
        <div class="row">
            <div class="col-xs-4 col-sm-2 col-md-2">
                <label class="kt-form-label ng-binding" ng-class="{'has-error': ngayDiError}">Ngày đi<!--Ngày đi--></label>
            </div>
            <div class="col-xs-8 col-sm-4 col-md-4">
                <div class="form-group" ng-class="{'has-error': ngayDiError}">
                    <span class="control-label ng-binding ng-hide" ng-show="ngayDiError">Vui lòng chọn ngày đi<!--Vui lòng chọn ngày đi--></span>
                    <div class="input-group input-cal-picker">
                        <input type="text" class="form-control ng-isolate-scope ng-pristine ng-invalid ng-invalid-required ng-valid-date" show-weeks="false" show-button-bar="false" datepicker-popup="dd/MM/yyyy" ng-model="searchData.ngayDi" is-open="ngayDi_opened" min-date="minDate" datepicker-options="dateOptions" ng-required="true" ng-click="open_ngayDi($event)" placeholder="dd/MM/yyyy" id="ngayDi" ng-readonly="true" ng-class="{'et-error-block': ngayDiError}" ng-change="ngayDiError = false" readonly="readonly" required="required">
<!--                        <ul class="dropdown-menu ng-pristine ng-valid ng-valid-date-disabled" style="padding-left: 2px; display: none;" ng-style="{display: (isOpen &amp;&amp; 'block') || 'none', top: position.top+'px', left: position.left+'px'}" ng-keydown="keydown($event)" datepicker-popup-wrap="" ng-model="date" ng-change="dateSelection()">-->
<!--	<li ng-transclude=""><div ng-switch="datepickerMode" role="application" ng-keydown="keydown($event)" datepicker="" format-year="yy" starting-day="1" min-date="watchData.minDate" class="ng-isolate-scope">
   ngSwitchWhen: day <table role="grid" aria-labelledby="datepicker-04Z-2794-title" aria-activedescendant="datepicker-04Z-2794-21" ng-switch-when="day" tabindex="0">
  <thead>
    <tr>
      <th><button type="button" class="btn btn-default btn-sm pull-left" ng-click="move(-1)" tabindex="-1"><i class="glyphicon glyphicon-chevron-left"></i></button></th>
      <th colspan="6"><button id="datepicker-04Z-2794-title" role="heading" aria-live="assertive" aria-atomic="true" type="button" class="btn btn-default btn-sm" ng-click="toggleMode()" tabindex="-1" style="width:100%;"><strong class="ng-binding">Tháng 2 năm 2025</strong></button></th>
      <th><button type="button" class="btn btn-default btn-sm pull-right" ng-click="move(1)" tabindex="-1"><i class="glyphicon glyphicon-chevron-right"></i></button></th>
    </tr>
    <tr>
      <th ng-show="showWeeks" class="text-center"></th>
       ngRepeat: label in labels track by $index <th ng-repeat="label in labels track by $index" class="text-center ng-scope"><small aria-label="Thứ hai" class="ng-binding">T2</small></th> end ngRepeat: label in labels track by $index <th ng-repeat="label in labels track by $index" class="text-center ng-scope"><small aria-label="Thứ ba" class="ng-binding">T3</small></th> end ngRepeat: label in labels track by $index <th ng-repeat="label in labels track by $index" class="text-center ng-scope"><small aria-label="Thứ tư" class="ng-binding">T4</small></th> end ngRepeat: label in labels track by $index <th ng-repeat="label in labels track by $index" class="text-center ng-scope"><small aria-label="Thứ năm" class="ng-binding">T5</small></th> end ngRepeat: label in labels track by $index <th ng-repeat="label in labels track by $index" class="text-center ng-scope"><small aria-label="Thứ sáu" class="ng-binding">T6</small></th> end ngRepeat: label in labels track by $index <th ng-repeat="label in labels track by $index" class="text-center ng-scope"><small aria-label="Thứ bảy" class="ng-binding">T7</small></th> end ngRepeat: label in labels track by $index <th ng-repeat="label in labels track by $index" class="text-center ng-scope"><small aria-label="Chủ nhật" class="ng-binding">CN</small></th> end ngRepeat: label in labels track by $index 
    </tr>
  </thead>
  <tbody>
     ngRepeat: row in rows track by $index <tr ng-repeat="row in rows track by $index" class="ng-scope">
      <td ng-show="showWeeks" class="text-center h6"><em class="ng-binding">5</em></td>
       ngRepeat: dt in row track by dt.date <td ng-repeat="dt in row track by dt.date" class="text-center ng-scope" role="gridcell" id="datepicker-04Z-2794-0" aria-disabled="false">
        <button type="button" style="font-size:13px;width:38px;height:30px;padding:0px 10px 10px 0px;position:relative;" ng-style="{'border-color':dt.isTet?'red':((dt.isLeAL||dt.isLeDL)?'#f8a383':undefined)}" class="btn btn-default btn-sm" ng-class="{'btn-info': dt.selected, active: isActive(dt)}" ng-click="select(dt.date)" ng-disabled="dt.disabled" tabindex="-1">
          <span ng-class="{'text-muted': dt.secondary, 'text-info': dt.current}" class="ng-binding text-muted">27</span>
          <span ng-show="(dt.isTet||dt.isLeAL||dt.lunar.day==1||($parent.$index==0&amp;&amp;$index==0))&amp;&amp;dt.lunar.leap" style="position:absolute;bottom:0px;right:0px;font-size:9px;color:#70a0f5;" class="ng-binding ng-hide">28/12*</span>
          <span ng-show="(dt.isTet||dt.isLeAL||dt.lunar.day==1||($parent.$index==0&amp;&amp;$index==0))&amp;&amp;!dt.lunar.leap" style="position:absolute;bottom:0px;right:0px;font-size:9px;color:#70a0f5;" class="ng-binding">28/12</span>
          <span ng-show="!dt.isTet&amp;&amp;!dt.isLeAL&amp;&amp;dt.lunar.day!=1&amp;&amp;($parent.$index!=0||$index!=0)" style="position:absolute;bottom:0px;right:0px;font-size:9px;color:#70a0f5;" class="ng-binding ng-hide">28</span>
        </button>
      </td> end ngRepeat: dt in row track by dt.date <td ng-repeat="dt in row track by dt.date" class="text-center ng-scope" role="gridcell" id="datepicker-04Z-2794-1" aria-disabled="false">
        <button type="button" style="font-size: 13px; width: 38px; padding: 0px 10px 10px 0px; position: relative; border-color: rgb(248, 163, 131);" ng-style="{'border-color':dt.isTet?'red':((dt.isLeAL||dt.isLeDL)?'#f8a383':undefined)}" class="btn btn-default btn-sm" ng-class="{'btn-info': dt.selected, active: isActive(dt)}" ng-click="select(dt.date)" ng-disabled="dt.disabled" tabindex="-1">
          <span ng-class="{'text-muted': dt.secondary, 'text-info': dt.current}" class="ng-binding text-muted">28</span>
          <span ng-show="(dt.isTet||dt.isLeAL||dt.lunar.day==1||($parent.$index==0&amp;&amp;$index==0))&amp;&amp;dt.lunar.leap" style="position:absolute;bottom:0px;right:0px;font-size:9px;color:#70a0f5;" class="ng-binding ng-hide">29/12*</span>
          <span ng-show="(dt.isTet||dt.isLeAL||dt.lunar.day==1||($parent.$index==0&amp;&amp;$index==0))&amp;&amp;!dt.lunar.leap" style="position:absolute;bottom:0px;right:0px;font-size:9px;color:#70a0f5;" class="ng-binding">29/12</span>
          <span ng-show="!dt.isTet&amp;&amp;!dt.isLeAL&amp;&amp;dt.lunar.day!=1&amp;&amp;($parent.$index!=0||$index!=0)" style="position:absolute;bottom:0px;right:0px;font-size:9px;color:#70a0f5;" class="ng-binding ng-hide">29</span>
        </button>
      </td> end ngRepeat: dt in row track by dt.date <td ng-repeat="dt in row track by dt.date" class="text-center ng-scope" role="gridcell" id="datepicker-04Z-2794-2" aria-disabled="false">
        <button type="button" style="font-size: 13px; width: 38px; padding: 0px 10px 10px 0px; position: relative; border-color: red;" ng-style="{'border-color':dt.isTet?'red':((dt.isLeAL||dt.isLeDL)?'#f8a383':undefined)}" class="btn btn-default btn-sm" ng-class="{'btn-info': dt.selected, active: isActive(dt)}" ng-click="select(dt.date)" ng-disabled="dt.disabled" tabindex="-1">
          <span ng-class="{'text-muted': dt.secondary, 'text-info': dt.current}" class="ng-binding text-muted">29</span>
          <span ng-show="(dt.isTet||dt.isLeAL||dt.lunar.day==1||($parent.$index==0&amp;&amp;$index==0))&amp;&amp;dt.lunar.leap" style="position:absolute;bottom:0px;right:0px;font-size:9px;color:#70a0f5;" class="ng-binding ng-hide">1/1*</span>
          <span ng-show="(dt.isTet||dt.isLeAL||dt.lunar.day==1||($parent.$index==0&amp;&amp;$index==0))&amp;&amp;!dt.lunar.leap" style="position:absolute;bottom:0px;right:0px;font-size:9px;color:#70a0f5;" class="ng-binding">1/1</span>
          <span ng-show="!dt.isTet&amp;&amp;!dt.isLeAL&amp;&amp;dt.lunar.day!=1&amp;&amp;($parent.$index!=0||$index!=0)" style="position:absolute;bottom:0px;right:0px;font-size:9px;color:#70a0f5;" class="ng-binding ng-hide">1</span>
        </button>
      </td> end ngRepeat: dt in row track by dt.date <td ng-repeat="dt in row track by dt.date" class="text-center ng-scope" role="gridcell" id="datepicker-04Z-2794-3" aria-disabled="false">
        <button type="button" style="font-size: 13px; width: 38px; padding: 0px 10px 10px 0px; position: relative; border-color: red;" ng-style="{'border-color':dt.isTet?'red':((dt.isLeAL||dt.isLeDL)?'#f8a383':undefined)}" class="btn btn-default btn-sm" ng-class="{'btn-info': dt.selected, active: isActive(dt)}" ng-click="select(dt.date)" ng-disabled="dt.disabled" tabindex="-1">
          <span ng-class="{'text-muted': dt.secondary, 'text-info': dt.current}" class="ng-binding text-muted">30</span>
          <span ng-show="(dt.isTet||dt.isLeAL||dt.lunar.day==1||($parent.$index==0&amp;&amp;$index==0))&amp;&amp;dt.lunar.leap" style="position:absolute;bottom:0px;right:0px;font-size:9px;color:#70a0f5;" class="ng-binding ng-hide">2/1*</span>
          <span ng-show="(dt.isTet||dt.isLeAL||dt.lunar.day==1||($parent.$index==0&amp;&amp;$index==0))&amp;&amp;!dt.lunar.leap" style="position:absolute;bottom:0px;right:0px;font-size:9px;color:#70a0f5;" class="ng-binding">2/1</span>
          <span ng-show="!dt.isTet&amp;&amp;!dt.isLeAL&amp;&amp;dt.lunar.day!=1&amp;&amp;($parent.$index!=0||$index!=0)" style="position:absolute;bottom:0px;right:0px;font-size:9px;color:#70a0f5;" class="ng-binding ng-hide">2</span>
        </button>
      </td> end ngRepeat: dt in row track by dt.date <td ng-repeat="dt in row track by dt.date" class="text-center ng-scope" role="gridcell" id="datepicker-04Z-2794-4" aria-disabled="false">
        <button type="button" style="font-size: 13px; width: 38px; padding: 0px 10px 10px 0px; position: relative; border-color: red;" ng-style="{'border-color':dt.isTet?'red':((dt.isLeAL||dt.isLeDL)?'#f8a383':undefined)}" class="btn btn-default btn-sm" ng-class="{'btn-info': dt.selected, active: isActive(dt)}" ng-click="select(dt.date)" ng-disabled="dt.disabled" tabindex="-1">
          <span ng-class="{'text-muted': dt.secondary, 'text-info': dt.current}" class="ng-binding text-muted">31</span>
          <span ng-show="(dt.isTet||dt.isLeAL||dt.lunar.day==1||($parent.$index==0&amp;&amp;$index==0))&amp;&amp;dt.lunar.leap" style="position:absolute;bottom:0px;right:0px;font-size:9px;color:#70a0f5;" class="ng-binding ng-hide">3/1*</span>
          <span ng-show="(dt.isTet||dt.isLeAL||dt.lunar.day==1||($parent.$index==0&amp;&amp;$index==0))&amp;&amp;!dt.lunar.leap" style="position:absolute;bottom:0px;right:0px;font-size:9px;color:#70a0f5;" class="ng-binding">3/1</span>
          <span ng-show="!dt.isTet&amp;&amp;!dt.isLeAL&amp;&amp;dt.lunar.day!=1&amp;&amp;($parent.$index!=0||$index!=0)" style="position:absolute;bottom:0px;right:0px;font-size:9px;color:#70a0f5;" class="ng-binding ng-hide">3</span>
        </button>
      </td> end ngRepeat: dt in row track by dt.date <td ng-repeat="dt in row track by dt.date" class="text-center ng-scope" role="gridcell" id="datepicker-04Z-2794-5" aria-disabled="false">
        <button type="button" style="font-size: 13px; width: 38px; padding: 0px 10px 10px 0px; position: relative; border-color: rgb(248, 163, 131);" ng-style="{'border-color':dt.isTet?'red':((dt.isLeAL||dt.isLeDL)?'#f8a383':undefined)}" class="btn btn-default btn-sm" ng-class="{'btn-info': dt.selected, active: isActive(dt)}" ng-click="select(dt.date)" ng-disabled="dt.disabled" tabindex="-1">
          <span ng-class="{'text-muted': dt.secondary, 'text-info': dt.current}" class="ng-binding">01</span>
          <span ng-show="(dt.isTet||dt.isLeAL||dt.lunar.day==1||($parent.$index==0&amp;&amp;$index==0))&amp;&amp;dt.lunar.leap" style="position:absolute;bottom:0px;right:0px;font-size:9px;color:#70a0f5;" class="ng-binding ng-hide">4/1*</span>
          <span ng-show="(dt.isTet||dt.isLeAL||dt.lunar.day==1||($parent.$index==0&amp;&amp;$index==0))&amp;&amp;!dt.lunar.leap" style="position:absolute;bottom:0px;right:0px;font-size:9px;color:#70a0f5;" class="ng-binding">4/1</span>
          <span ng-show="!dt.isTet&amp;&amp;!dt.isLeAL&amp;&amp;dt.lunar.day!=1&amp;&amp;($parent.$index!=0||$index!=0)" style="position:absolute;bottom:0px;right:0px;font-size:9px;color:#70a0f5;" class="ng-binding ng-hide">4</span>
        </button>
      </td> end ngRepeat: dt in row track by dt.date <td ng-repeat="dt in row track by dt.date" class="text-center ng-scope" role="gridcell" id="datepicker-04Z-2794-6" aria-disabled="false">
        <button type="button" style="font-size:13px;width:38px;height:30px;padding:0px 10px 10px 0px;position:relative;" ng-style="{'border-color':dt.isTet?'red':((dt.isLeAL||dt.isLeDL)?'#f8a383':undefined)}" class="btn btn-default btn-sm" ng-class="{'btn-info': dt.selected, active: isActive(dt)}" ng-click="select(dt.date)" ng-disabled="dt.disabled" tabindex="-1">
          <span ng-class="{'text-muted': dt.secondary, 'text-info': dt.current}" class="ng-binding">02</span>
          <span ng-show="(dt.isTet||dt.isLeAL||dt.lunar.day==1||($parent.$index==0&amp;&amp;$index==0))&amp;&amp;dt.lunar.leap" style="position:absolute;bottom:0px;right:0px;font-size:9px;color:#70a0f5;" class="ng-binding ng-hide">5/1*</span>
          <span ng-show="(dt.isTet||dt.isLeAL||dt.lunar.day==1||($parent.$index==0&amp;&amp;$index==0))&amp;&amp;!dt.lunar.leap" style="position:absolute;bottom:0px;right:0px;font-size:9px;color:#70a0f5;" class="ng-binding ng-hide">5/1</span>
          <span ng-show="!dt.isTet&amp;&amp;!dt.isLeAL&amp;&amp;dt.lunar.day!=1&amp;&amp;($parent.$index!=0||$index!=0)" style="position:absolute;bottom:0px;right:0px;font-size:9px;color:#70a0f5;" class="ng-binding">5</span>
        </button>
      </td> end ngRepeat: dt in row track by dt.date 
    </tr> end ngRepeat: row in rows track by $index <tr ng-repeat="row in rows track by $index" class="ng-scope">
      <td ng-show="showWeeks" class="text-center h6"><em class="ng-binding">6</em></td>
       ngRepeat: dt in row track by dt.date <td ng-repeat="dt in row track by dt.date" class="text-center ng-scope" role="gridcell" id="datepicker-04Z-2794-7" aria-disabled="false">
        <button type="button" style="font-size:13px;width:38px;height:30px;padding:0px 10px 10px 0px;position:relative;" ng-style="{'border-color':dt.isTet?'red':((dt.isLeAL||dt.isLeDL)?'#f8a383':undefined)}" class="btn btn-default btn-sm" ng-class="{'btn-info': dt.selected, active: isActive(dt)}" ng-click="select(dt.date)" ng-disabled="dt.disabled" tabindex="-1">
          <span ng-class="{'text-muted': dt.secondary, 'text-info': dt.current}" class="ng-binding">03</span>
          <span ng-show="(dt.isTet||dt.isLeAL||dt.lunar.day==1||($parent.$index==0&amp;&amp;$index==0))&amp;&amp;dt.lunar.leap" style="position:absolute;bottom:0px;right:0px;font-size:9px;color:#70a0f5;" class="ng-binding ng-hide">6/1*</span>
          <span ng-show="(dt.isTet||dt.isLeAL||dt.lunar.day==1||($parent.$index==0&amp;&amp;$index==0))&amp;&amp;!dt.lunar.leap" style="position:absolute;bottom:0px;right:0px;font-size:9px;color:#70a0f5;" class="ng-binding ng-hide">6/1</span>
          <span ng-show="!dt.isTet&amp;&amp;!dt.isLeAL&amp;&amp;dt.lunar.day!=1&amp;&amp;($parent.$index!=0||$index!=0)" style="position:absolute;bottom:0px;right:0px;font-size:9px;color:#70a0f5;" class="ng-binding">6</span>
        </button>
      </td> end ngRepeat: dt in row track by dt.date <td ng-repeat="dt in row track by dt.date" class="text-center ng-scope" role="gridcell" id="datepicker-04Z-2794-8" aria-disabled="false">
        <button type="button" style="font-size:13px;width:38px;height:30px;padding:0px 10px 10px 0px;position:relative;" ng-style="{'border-color':dt.isTet?'red':((dt.isLeAL||dt.isLeDL)?'#f8a383':undefined)}" class="btn btn-default btn-sm" ng-class="{'btn-info': dt.selected, active: isActive(dt)}" ng-click="select(dt.date)" ng-disabled="dt.disabled" tabindex="-1">
          <span ng-class="{'text-muted': dt.secondary, 'text-info': dt.current}" class="ng-binding">04</span>
          <span ng-show="(dt.isTet||dt.isLeAL||dt.lunar.day==1||($parent.$index==0&amp;&amp;$index==0))&amp;&amp;dt.lunar.leap" style="position:absolute;bottom:0px;right:0px;font-size:9px;color:#70a0f5;" class="ng-binding ng-hide">7/1*</span>
          <span ng-show="(dt.isTet||dt.isLeAL||dt.lunar.day==1||($parent.$index==0&amp;&amp;$index==0))&amp;&amp;!dt.lunar.leap" style="position:absolute;bottom:0px;right:0px;font-size:9px;color:#70a0f5;" class="ng-binding ng-hide">7/1</span>
          <span ng-show="!dt.isTet&amp;&amp;!dt.isLeAL&amp;&amp;dt.lunar.day!=1&amp;&amp;($parent.$index!=0||$index!=0)" style="position:absolute;bottom:0px;right:0px;font-size:9px;color:#70a0f5;" class="ng-binding">7</span>
        </button>
      </td> end ngRepeat: dt in row track by dt.date <td ng-repeat="dt in row track by dt.date" class="text-center ng-scope" role="gridcell" id="datepicker-04Z-2794-9" aria-disabled="false">
        <button type="button" style="font-size:13px;width:38px;height:30px;padding:0px 10px 10px 0px;position:relative;" ng-style="{'border-color':dt.isTet?'red':((dt.isLeAL||dt.isLeDL)?'#f8a383':undefined)}" class="btn btn-default btn-sm" ng-class="{'btn-info': dt.selected, active: isActive(dt)}" ng-click="select(dt.date)" ng-disabled="dt.disabled" tabindex="-1">
          <span ng-class="{'text-muted': dt.secondary, 'text-info': dt.current}" class="ng-binding">05</span>
          <span ng-show="(dt.isTet||dt.isLeAL||dt.lunar.day==1||($parent.$index==0&amp;&amp;$index==0))&amp;&amp;dt.lunar.leap" style="position:absolute;bottom:0px;right:0px;font-size:9px;color:#70a0f5;" class="ng-binding ng-hide">8/1*</span>
          <span ng-show="(dt.isTet||dt.isLeAL||dt.lunar.day==1||($parent.$index==0&amp;&amp;$index==0))&amp;&amp;!dt.lunar.leap" style="position:absolute;bottom:0px;right:0px;font-size:9px;color:#70a0f5;" class="ng-binding ng-hide">8/1</span>
          <span ng-show="!dt.isTet&amp;&amp;!dt.isLeAL&amp;&amp;dt.lunar.day!=1&amp;&amp;($parent.$index!=0||$index!=0)" style="position:absolute;bottom:0px;right:0px;font-size:9px;color:#70a0f5;" class="ng-binding">8</span>
        </button>
      </td> end ngRepeat: dt in row track by dt.date <td ng-repeat="dt in row track by dt.date" class="text-center ng-scope" role="gridcell" id="datepicker-04Z-2794-10" aria-disabled="false">
        <button type="button" style="font-size:13px;width:38px;height:30px;padding:0px 10px 10px 0px;position:relative;" ng-style="{'border-color':dt.isTet?'red':((dt.isLeAL||dt.isLeDL)?'#f8a383':undefined)}" class="btn btn-default btn-sm" ng-class="{'btn-info': dt.selected, active: isActive(dt)}" ng-click="select(dt.date)" ng-disabled="dt.disabled" tabindex="-1">
          <span ng-class="{'text-muted': dt.secondary, 'text-info': dt.current}" class="ng-binding">06</span>
          <span ng-show="(dt.isTet||dt.isLeAL||dt.lunar.day==1||($parent.$index==0&amp;&amp;$index==0))&amp;&amp;dt.lunar.leap" style="position:absolute;bottom:0px;right:0px;font-size:9px;color:#70a0f5;" class="ng-binding ng-hide">9/1*</span>
          <span ng-show="(dt.isTet||dt.isLeAL||dt.lunar.day==1||($parent.$index==0&amp;&amp;$index==0))&amp;&amp;!dt.lunar.leap" style="position:absolute;bottom:0px;right:0px;font-size:9px;color:#70a0f5;" class="ng-binding ng-hide">9/1</span>
          <span ng-show="!dt.isTet&amp;&amp;!dt.isLeAL&amp;&amp;dt.lunar.day!=1&amp;&amp;($parent.$index!=0||$index!=0)" style="position:absolute;bottom:0px;right:0px;font-size:9px;color:#70a0f5;" class="ng-binding">9</span>
        </button>
      </td> end ngRepeat: dt in row track by dt.date <td ng-repeat="dt in row track by dt.date" class="text-center ng-scope" role="gridcell" id="datepicker-04Z-2794-11" aria-disabled="false">
        <button type="button" style="font-size:13px;width:38px;height:30px;padding:0px 10px 10px 0px;position:relative;" ng-style="{'border-color':dt.isTet?'red':((dt.isLeAL||dt.isLeDL)?'#f8a383':undefined)}" class="btn btn-default btn-sm" ng-class="{'btn-info': dt.selected, active: isActive(dt)}" ng-click="select(dt.date)" ng-disabled="dt.disabled" tabindex="-1">
          <span ng-class="{'text-muted': dt.secondary, 'text-info': dt.current}" class="ng-binding">07</span>
          <span ng-show="(dt.isTet||dt.isLeAL||dt.lunar.day==1||($parent.$index==0&amp;&amp;$index==0))&amp;&amp;dt.lunar.leap" style="position:absolute;bottom:0px;right:0px;font-size:9px;color:#70a0f5;" class="ng-binding ng-hide">10/1*</span>
          <span ng-show="(dt.isTet||dt.isLeAL||dt.lunar.day==1||($parent.$index==0&amp;&amp;$index==0))&amp;&amp;!dt.lunar.leap" style="position:absolute;bottom:0px;right:0px;font-size:9px;color:#70a0f5;" class="ng-binding ng-hide">10/1</span>
          <span ng-show="!dt.isTet&amp;&amp;!dt.isLeAL&amp;&amp;dt.lunar.day!=1&amp;&amp;($parent.$index!=0||$index!=0)" style="position:absolute;bottom:0px;right:0px;font-size:9px;color:#70a0f5;" class="ng-binding">10</span>
        </button>
      </td> end ngRepeat: dt in row track by dt.date <td ng-repeat="dt in row track by dt.date" class="text-center ng-scope" role="gridcell" id="datepicker-04Z-2794-12" aria-disabled="false">
        <button type="button" style="font-size:13px;width:38px;height:30px;padding:0px 10px 10px 0px;position:relative;" ng-style="{'border-color':dt.isTet?'red':((dt.isLeAL||dt.isLeDL)?'#f8a383':undefined)}" class="btn btn-default btn-sm" ng-class="{'btn-info': dt.selected, active: isActive(dt)}" ng-click="select(dt.date)" ng-disabled="dt.disabled" tabindex="-1">
          <span ng-class="{'text-muted': dt.secondary, 'text-info': dt.current}" class="ng-binding">08</span>
          <span ng-show="(dt.isTet||dt.isLeAL||dt.lunar.day==1||($parent.$index==0&amp;&amp;$index==0))&amp;&amp;dt.lunar.leap" style="position:absolute;bottom:0px;right:0px;font-size:9px;color:#70a0f5;" class="ng-binding ng-hide">11/1*</span>
          <span ng-show="(dt.isTet||dt.isLeAL||dt.lunar.day==1||($parent.$index==0&amp;&amp;$index==0))&amp;&amp;!dt.lunar.leap" style="position:absolute;bottom:0px;right:0px;font-size:9px;color:#70a0f5;" class="ng-binding ng-hide">11/1</span>
          <span ng-show="!dt.isTet&amp;&amp;!dt.isLeAL&amp;&amp;dt.lunar.day!=1&amp;&amp;($parent.$index!=0||$index!=0)" style="position:absolute;bottom:0px;right:0px;font-size:9px;color:#70a0f5;" class="ng-binding">11</span>
        </button>
      </td> end ngRepeat: dt in row track by dt.date <td ng-repeat="dt in row track by dt.date" class="text-center ng-scope" role="gridcell" id="datepicker-04Z-2794-13" aria-disabled="false">
        <button type="button" style="font-size:13px;width:38px;height:30px;padding:0px 10px 10px 0px;position:relative;" ng-style="{'border-color':dt.isTet?'red':((dt.isLeAL||dt.isLeDL)?'#f8a383':undefined)}" class="btn btn-default btn-sm" ng-class="{'btn-info': dt.selected, active: isActive(dt)}" ng-click="select(dt.date)" ng-disabled="dt.disabled" tabindex="-1">
          <span ng-class="{'text-muted': dt.secondary, 'text-info': dt.current}" class="ng-binding">09</span>
          <span ng-show="(dt.isTet||dt.isLeAL||dt.lunar.day==1||($parent.$index==0&amp;&amp;$index==0))&amp;&amp;dt.lunar.leap" style="position:absolute;bottom:0px;right:0px;font-size:9px;color:#70a0f5;" class="ng-binding ng-hide">12/1*</span>
          <span ng-show="(dt.isTet||dt.isLeAL||dt.lunar.day==1||($parent.$index==0&amp;&amp;$index==0))&amp;&amp;!dt.lunar.leap" style="position:absolute;bottom:0px;right:0px;font-size:9px;color:#70a0f5;" class="ng-binding ng-hide">12/1</span>
          <span ng-show="!dt.isTet&amp;&amp;!dt.isLeAL&amp;&amp;dt.lunar.day!=1&amp;&amp;($parent.$index!=0||$index!=0)" style="position:absolute;bottom:0px;right:0px;font-size:9px;color:#70a0f5;" class="ng-binding">12</span>
        </button>
      </td> end ngRepeat: dt in row track by dt.date 
    </tr> end ngRepeat: row in rows track by $index <tr ng-repeat="row in rows track by $index" class="ng-scope">
      <td ng-show="showWeeks" class="text-center h6"><em class="ng-binding">7</em></td>
       ngRepeat: dt in row track by dt.date <td ng-repeat="dt in row track by dt.date" class="text-center ng-scope" role="gridcell" id="datepicker-04Z-2794-14" aria-disabled="false">
        <button type="button" style="font-size:13px;width:38px;height:30px;padding:0px 10px 10px 0px;position:relative;" ng-style="{'border-color':dt.isTet?'red':((dt.isLeAL||dt.isLeDL)?'#f8a383':undefined)}" class="btn btn-default btn-sm" ng-class="{'btn-info': dt.selected, active: isActive(dt)}" ng-click="select(dt.date)" ng-disabled="dt.disabled" tabindex="-1">
          <span ng-class="{'text-muted': dt.secondary, 'text-info': dt.current}" class="ng-binding">10</span>
          <span ng-show="(dt.isTet||dt.isLeAL||dt.lunar.day==1||($parent.$index==0&amp;&amp;$index==0))&amp;&amp;dt.lunar.leap" style="position:absolute;bottom:0px;right:0px;font-size:9px;color:#70a0f5;" class="ng-binding ng-hide">13/1*</span>
          <span ng-show="(dt.isTet||dt.isLeAL||dt.lunar.day==1||($parent.$index==0&amp;&amp;$index==0))&amp;&amp;!dt.lunar.leap" style="position:absolute;bottom:0px;right:0px;font-size:9px;color:#70a0f5;" class="ng-binding ng-hide">13/1</span>
          <span ng-show="!dt.isTet&amp;&amp;!dt.isLeAL&amp;&amp;dt.lunar.day!=1&amp;&amp;($parent.$index!=0||$index!=0)" style="position:absolute;bottom:0px;right:0px;font-size:9px;color:#70a0f5;" class="ng-binding">13</span>
        </button>
      </td> end ngRepeat: dt in row track by dt.date <td ng-repeat="dt in row track by dt.date" class="text-center ng-scope" role="gridcell" id="datepicker-04Z-2794-15" aria-disabled="false">
        <button type="button" style="font-size:13px;width:38px;height:30px;padding:0px 10px 10px 0px;position:relative;" ng-style="{'border-color':dt.isTet?'red':((dt.isLeAL||dt.isLeDL)?'#f8a383':undefined)}" class="btn btn-default btn-sm" ng-class="{'btn-info': dt.selected, active: isActive(dt)}" ng-click="select(dt.date)" ng-disabled="dt.disabled" tabindex="-1">
          <span ng-class="{'text-muted': dt.secondary, 'text-info': dt.current}" class="ng-binding">11</span>
          <span ng-show="(dt.isTet||dt.isLeAL||dt.lunar.day==1||($parent.$index==0&amp;&amp;$index==0))&amp;&amp;dt.lunar.leap" style="position:absolute;bottom:0px;right:0px;font-size:9px;color:#70a0f5;" class="ng-binding ng-hide">14/1*</span>
          <span ng-show="(dt.isTet||dt.isLeAL||dt.lunar.day==1||($parent.$index==0&amp;&amp;$index==0))&amp;&amp;!dt.lunar.leap" style="position:absolute;bottom:0px;right:0px;font-size:9px;color:#70a0f5;" class="ng-binding ng-hide">14/1</span>
          <span ng-show="!dt.isTet&amp;&amp;!dt.isLeAL&amp;&amp;dt.lunar.day!=1&amp;&amp;($parent.$index!=0||$index!=0)" style="position:absolute;bottom:0px;right:0px;font-size:9px;color:#70a0f5;" class="ng-binding">14</span>
        </button>
      </td> end ngRepeat: dt in row track by dt.date <td ng-repeat="dt in row track by dt.date" class="text-center ng-scope" role="gridcell" id="datepicker-04Z-2794-16" aria-disabled="false">
        <button type="button" style="font-size:13px;width:38px;height:30px;padding:0px 10px 10px 0px;position:relative;" ng-style="{'border-color':dt.isTet?'red':((dt.isLeAL||dt.isLeDL)?'#f8a383':undefined)}" class="btn btn-default btn-sm" ng-class="{'btn-info': dt.selected, active: isActive(dt)}" ng-click="select(dt.date)" ng-disabled="dt.disabled" tabindex="-1">
          <span ng-class="{'text-muted': dt.secondary, 'text-info': dt.current}" class="ng-binding">12</span>
          <span ng-show="(dt.isTet||dt.isLeAL||dt.lunar.day==1||($parent.$index==0&amp;&amp;$index==0))&amp;&amp;dt.lunar.leap" style="position:absolute;bottom:0px;right:0px;font-size:9px;color:#70a0f5;" class="ng-binding ng-hide">15/1*</span>
          <span ng-show="(dt.isTet||dt.isLeAL||dt.lunar.day==1||($parent.$index==0&amp;&amp;$index==0))&amp;&amp;!dt.lunar.leap" style="position:absolute;bottom:0px;right:0px;font-size:9px;color:#70a0f5;" class="ng-binding ng-hide">15/1</span>
          <span ng-show="!dt.isTet&amp;&amp;!dt.isLeAL&amp;&amp;dt.lunar.day!=1&amp;&amp;($parent.$index!=0||$index!=0)" style="position:absolute;bottom:0px;right:0px;font-size:9px;color:#70a0f5;" class="ng-binding">15</span>
        </button>
      </td> end ngRepeat: dt in row track by dt.date <td ng-repeat="dt in row track by dt.date" class="text-center ng-scope" role="gridcell" id="datepicker-04Z-2794-17" aria-disabled="false">
        <button type="button" style="font-size:13px;width:38px;height:30px;padding:0px 10px 10px 0px;position:relative;" ng-style="{'border-color':dt.isTet?'red':((dt.isLeAL||dt.isLeDL)?'#f8a383':undefined)}" class="btn btn-default btn-sm" ng-class="{'btn-info': dt.selected, active: isActive(dt)}" ng-click="select(dt.date)" ng-disabled="dt.disabled" tabindex="-1">
          <span ng-class="{'text-muted': dt.secondary, 'text-info': dt.current}" class="ng-binding">13</span>
          <span ng-show="(dt.isTet||dt.isLeAL||dt.lunar.day==1||($parent.$index==0&amp;&amp;$index==0))&amp;&amp;dt.lunar.leap" style="position:absolute;bottom:0px;right:0px;font-size:9px;color:#70a0f5;" class="ng-binding ng-hide">16/1*</span>
          <span ng-show="(dt.isTet||dt.isLeAL||dt.lunar.day==1||($parent.$index==0&amp;&amp;$index==0))&amp;&amp;!dt.lunar.leap" style="position:absolute;bottom:0px;right:0px;font-size:9px;color:#70a0f5;" class="ng-binding ng-hide">16/1</span>
          <span ng-show="!dt.isTet&amp;&amp;!dt.isLeAL&amp;&amp;dt.lunar.day!=1&amp;&amp;($parent.$index!=0||$index!=0)" style="position:absolute;bottom:0px;right:0px;font-size:9px;color:#70a0f5;" class="ng-binding">16</span>
        </button>
      </td> end ngRepeat: dt in row track by dt.date <td ng-repeat="dt in row track by dt.date" class="text-center ng-scope" role="gridcell" id="datepicker-04Z-2794-18" aria-disabled="false">
        <button type="button" style="font-size:13px;width:38px;height:30px;padding:0px 10px 10px 0px;position:relative;" ng-style="{'border-color':dt.isTet?'red':((dt.isLeAL||dt.isLeDL)?'#f8a383':undefined)}" class="btn btn-default btn-sm" ng-class="{'btn-info': dt.selected, active: isActive(dt)}" ng-click="select(dt.date)" ng-disabled="dt.disabled" tabindex="-1">
          <span ng-class="{'text-muted': dt.secondary, 'text-info': dt.current}" class="ng-binding">14</span>
          <span ng-show="(dt.isTet||dt.isLeAL||dt.lunar.day==1||($parent.$index==0&amp;&amp;$index==0))&amp;&amp;dt.lunar.leap" style="position:absolute;bottom:0px;right:0px;font-size:9px;color:#70a0f5;" class="ng-binding ng-hide">17/1*</span>
          <span ng-show="(dt.isTet||dt.isLeAL||dt.lunar.day==1||($parent.$index==0&amp;&amp;$index==0))&amp;&amp;!dt.lunar.leap" style="position:absolute;bottom:0px;right:0px;font-size:9px;color:#70a0f5;" class="ng-binding ng-hide">17/1</span>
          <span ng-show="!dt.isTet&amp;&amp;!dt.isLeAL&amp;&amp;dt.lunar.day!=1&amp;&amp;($parent.$index!=0||$index!=0)" style="position:absolute;bottom:0px;right:0px;font-size:9px;color:#70a0f5;" class="ng-binding">17</span>
        </button>
      </td> end ngRepeat: dt in row track by dt.date <td ng-repeat="dt in row track by dt.date" class="text-center ng-scope" role="gridcell" id="datepicker-04Z-2794-19" aria-disabled="false">
        <button type="button" style="font-size:13px;width:38px;height:30px;padding:0px 10px 10px 0px;position:relative;" ng-style="{'border-color':dt.isTet?'red':((dt.isLeAL||dt.isLeDL)?'#f8a383':undefined)}" class="btn btn-default btn-sm" ng-class="{'btn-info': dt.selected, active: isActive(dt)}" ng-click="select(dt.date)" ng-disabled="dt.disabled" tabindex="-1">
          <span ng-class="{'text-muted': dt.secondary, 'text-info': dt.current}" class="ng-binding">15</span>
          <span ng-show="(dt.isTet||dt.isLeAL||dt.lunar.day==1||($parent.$index==0&amp;&amp;$index==0))&amp;&amp;dt.lunar.leap" style="position:absolute;bottom:0px;right:0px;font-size:9px;color:#70a0f5;" class="ng-binding ng-hide">18/1*</span>
          <span ng-show="(dt.isTet||dt.isLeAL||dt.lunar.day==1||($parent.$index==0&amp;&amp;$index==0))&amp;&amp;!dt.lunar.leap" style="position:absolute;bottom:0px;right:0px;font-size:9px;color:#70a0f5;" class="ng-binding ng-hide">18/1</span>
          <span ng-show="!dt.isTet&amp;&amp;!dt.isLeAL&amp;&amp;dt.lunar.day!=1&amp;&amp;($parent.$index!=0||$index!=0)" style="position:absolute;bottom:0px;right:0px;font-size:9px;color:#70a0f5;" class="ng-binding">18</span>
        </button>
      </td> end ngRepeat: dt in row track by dt.date <td ng-repeat="dt in row track by dt.date" class="text-center ng-scope" role="gridcell" id="datepicker-04Z-2794-20" aria-disabled="false">
        <button type="button" style="font-size:13px;width:38px;height:30px;padding:0px 10px 10px 0px;position:relative;" ng-style="{'border-color':dt.isTet?'red':((dt.isLeAL||dt.isLeDL)?'#f8a383':undefined)}" class="btn btn-default btn-sm" ng-class="{'btn-info': dt.selected, active: isActive(dt)}" ng-click="select(dt.date)" ng-disabled="dt.disabled" tabindex="-1">
          <span ng-class="{'text-muted': dt.secondary, 'text-info': dt.current}" class="ng-binding">16</span>
          <span ng-show="(dt.isTet||dt.isLeAL||dt.lunar.day==1||($parent.$index==0&amp;&amp;$index==0))&amp;&amp;dt.lunar.leap" style="position:absolute;bottom:0px;right:0px;font-size:9px;color:#70a0f5;" class="ng-binding ng-hide">19/1*</span>
          <span ng-show="(dt.isTet||dt.isLeAL||dt.lunar.day==1||($parent.$index==0&amp;&amp;$index==0))&amp;&amp;!dt.lunar.leap" style="position:absolute;bottom:0px;right:0px;font-size:9px;color:#70a0f5;" class="ng-binding ng-hide">19/1</span>
          <span ng-show="!dt.isTet&amp;&amp;!dt.isLeAL&amp;&amp;dt.lunar.day!=1&amp;&amp;($parent.$index!=0||$index!=0)" style="position:absolute;bottom:0px;right:0px;font-size:9px;color:#70a0f5;" class="ng-binding">19</span>
        </button>
      </td> end ngRepeat: dt in row track by dt.date 
    </tr> end ngRepeat: row in rows track by $index <tr ng-repeat="row in rows track by $index" class="ng-scope">
      <td ng-show="showWeeks" class="text-center h6"><em class="ng-binding">8</em></td>
       ngRepeat: dt in row track by dt.date <td ng-repeat="dt in row track by dt.date" class="text-center ng-scope" role="gridcell" id="datepicker-04Z-2794-21" aria-disabled="false">
        <button type="button" style="font-size:13px;width:38px;height:30px;padding:0px 10px 10px 0px;position:relative;" ng-style="{'border-color':dt.isTet?'red':((dt.isLeAL||dt.isLeDL)?'#f8a383':undefined)}" class="btn btn-default btn-sm active" ng-class="{'btn-info': dt.selected, active: isActive(dt)}" ng-click="select(dt.date)" ng-disabled="dt.disabled" tabindex="-1">
          <span ng-class="{'text-muted': dt.secondary, 'text-info': dt.current}" class="ng-binding text-info">17</span>
          <span ng-show="(dt.isTet||dt.isLeAL||dt.lunar.day==1||($parent.$index==0&amp;&amp;$index==0))&amp;&amp;dt.lunar.leap" style="position:absolute;bottom:0px;right:0px;font-size:9px;color:#70a0f5;" class="ng-binding ng-hide">20/1*</span>
          <span ng-show="(dt.isTet||dt.isLeAL||dt.lunar.day==1||($parent.$index==0&amp;&amp;$index==0))&amp;&amp;!dt.lunar.leap" style="position:absolute;bottom:0px;right:0px;font-size:9px;color:#70a0f5;" class="ng-binding ng-hide">20/1</span>
          <span ng-show="!dt.isTet&amp;&amp;!dt.isLeAL&amp;&amp;dt.lunar.day!=1&amp;&amp;($parent.$index!=0||$index!=0)" style="position:absolute;bottom:0px;right:0px;font-size:9px;color:#70a0f5;" class="ng-binding">20</span>
        </button>
      </td> end ngRepeat: dt in row track by dt.date <td ng-repeat="dt in row track by dt.date" class="text-center ng-scope" role="gridcell" id="datepicker-04Z-2794-22" aria-disabled="false">
        <button type="button" style="font-size:13px;width:38px;height:30px;padding:0px 10px 10px 0px;position:relative;" ng-style="{'border-color':dt.isTet?'red':((dt.isLeAL||dt.isLeDL)?'#f8a383':undefined)}" class="btn btn-default btn-sm" ng-class="{'btn-info': dt.selected, active: isActive(dt)}" ng-click="select(dt.date)" ng-disabled="dt.disabled" tabindex="-1">
          <span ng-class="{'text-muted': dt.secondary, 'text-info': dt.current}" class="ng-binding">18</span>
          <span ng-show="(dt.isTet||dt.isLeAL||dt.lunar.day==1||($parent.$index==0&amp;&amp;$index==0))&amp;&amp;dt.lunar.leap" style="position:absolute;bottom:0px;right:0px;font-size:9px;color:#70a0f5;" class="ng-binding ng-hide">21/1*</span>
          <span ng-show="(dt.isTet||dt.isLeAL||dt.lunar.day==1||($parent.$index==0&amp;&amp;$index==0))&amp;&amp;!dt.lunar.leap" style="position:absolute;bottom:0px;right:0px;font-size:9px;color:#70a0f5;" class="ng-binding ng-hide">21/1</span>
          <span ng-show="!dt.isTet&amp;&amp;!dt.isLeAL&amp;&amp;dt.lunar.day!=1&amp;&amp;($parent.$index!=0||$index!=0)" style="position:absolute;bottom:0px;right:0px;font-size:9px;color:#70a0f5;" class="ng-binding">21</span>
        </button>
      </td> end ngRepeat: dt in row track by dt.date <td ng-repeat="dt in row track by dt.date" class="text-center ng-scope" role="gridcell" id="datepicker-04Z-2794-23" aria-disabled="false">
        <button type="button" style="font-size:13px;width:38px;height:30px;padding:0px 10px 10px 0px;position:relative;" ng-style="{'border-color':dt.isTet?'red':((dt.isLeAL||dt.isLeDL)?'#f8a383':undefined)}" class="btn btn-default btn-sm" ng-class="{'btn-info': dt.selected, active: isActive(dt)}" ng-click="select(dt.date)" ng-disabled="dt.disabled" tabindex="-1">
          <span ng-class="{'text-muted': dt.secondary, 'text-info': dt.current}" class="ng-binding">19</span>
          <span ng-show="(dt.isTet||dt.isLeAL||dt.lunar.day==1||($parent.$index==0&amp;&amp;$index==0))&amp;&amp;dt.lunar.leap" style="position:absolute;bottom:0px;right:0px;font-size:9px;color:#70a0f5;" class="ng-binding ng-hide">22/1*</span>
          <span ng-show="(dt.isTet||dt.isLeAL||dt.lunar.day==1||($parent.$index==0&amp;&amp;$index==0))&amp;&amp;!dt.lunar.leap" style="position:absolute;bottom:0px;right:0px;font-size:9px;color:#70a0f5;" class="ng-binding ng-hide">22/1</span>
          <span ng-show="!dt.isTet&amp;&amp;!dt.isLeAL&amp;&amp;dt.lunar.day!=1&amp;&amp;($parent.$index!=0||$index!=0)" style="position:absolute;bottom:0px;right:0px;font-size:9px;color:#70a0f5;" class="ng-binding">22</span>
        </button>
      </td> end ngRepeat: dt in row track by dt.date <td ng-repeat="dt in row track by dt.date" class="text-center ng-scope" role="gridcell" id="datepicker-04Z-2794-24" aria-disabled="false">
        <button type="button" style="font-size:13px;width:38px;height:30px;padding:0px 10px 10px 0px;position:relative;" ng-style="{'border-color':dt.isTet?'red':((dt.isLeAL||dt.isLeDL)?'#f8a383':undefined)}" class="btn btn-default btn-sm" ng-class="{'btn-info': dt.selected, active: isActive(dt)}" ng-click="select(dt.date)" ng-disabled="dt.disabled" tabindex="-1">
          <span ng-class="{'text-muted': dt.secondary, 'text-info': dt.current}" class="ng-binding">20</span>
          <span ng-show="(dt.isTet||dt.isLeAL||dt.lunar.day==1||($parent.$index==0&amp;&amp;$index==0))&amp;&amp;dt.lunar.leap" style="position:absolute;bottom:0px;right:0px;font-size:9px;color:#70a0f5;" class="ng-binding ng-hide">23/1*</span>
          <span ng-show="(dt.isTet||dt.isLeAL||dt.lunar.day==1||($parent.$index==0&amp;&amp;$index==0))&amp;&amp;!dt.lunar.leap" style="position:absolute;bottom:0px;right:0px;font-size:9px;color:#70a0f5;" class="ng-binding ng-hide">23/1</span>
          <span ng-show="!dt.isTet&amp;&amp;!dt.isLeAL&amp;&amp;dt.lunar.day!=1&amp;&amp;($parent.$index!=0||$index!=0)" style="position:absolute;bottom:0px;right:0px;font-size:9px;color:#70a0f5;" class="ng-binding">23</span>
        </button>
      </td> end ngRepeat: dt in row track by dt.date <td ng-repeat="dt in row track by dt.date" class="text-center ng-scope" role="gridcell" id="datepicker-04Z-2794-25" aria-disabled="false">
        <button type="button" style="font-size:13px;width:38px;height:30px;padding:0px 10px 10px 0px;position:relative;" ng-style="{'border-color':dt.isTet?'red':((dt.isLeAL||dt.isLeDL)?'#f8a383':undefined)}" class="btn btn-default btn-sm" ng-class="{'btn-info': dt.selected, active: isActive(dt)}" ng-click="select(dt.date)" ng-disabled="dt.disabled" tabindex="-1">
          <span ng-class="{'text-muted': dt.secondary, 'text-info': dt.current}" class="ng-binding">21</span>
          <span ng-show="(dt.isTet||dt.isLeAL||dt.lunar.day==1||($parent.$index==0&amp;&amp;$index==0))&amp;&amp;dt.lunar.leap" style="position:absolute;bottom:0px;right:0px;font-size:9px;color:#70a0f5;" class="ng-binding ng-hide">24/1*</span>
          <span ng-show="(dt.isTet||dt.isLeAL||dt.lunar.day==1||($parent.$index==0&amp;&amp;$index==0))&amp;&amp;!dt.lunar.leap" style="position:absolute;bottom:0px;right:0px;font-size:9px;color:#70a0f5;" class="ng-binding ng-hide">24/1</span>
          <span ng-show="!dt.isTet&amp;&amp;!dt.isLeAL&amp;&amp;dt.lunar.day!=1&amp;&amp;($parent.$index!=0||$index!=0)" style="position:absolute;bottom:0px;right:0px;font-size:9px;color:#70a0f5;" class="ng-binding">24</span>
        </button>
      </td> end ngRepeat: dt in row track by dt.date <td ng-repeat="dt in row track by dt.date" class="text-center ng-scope" role="gridcell" id="datepicker-04Z-2794-26" aria-disabled="false">
        <button type="button" style="font-size:13px;width:38px;height:30px;padding:0px 10px 10px 0px;position:relative;" ng-style="{'border-color':dt.isTet?'red':((dt.isLeAL||dt.isLeDL)?'#f8a383':undefined)}" class="btn btn-default btn-sm" ng-class="{'btn-info': dt.selected, active: isActive(dt)}" ng-click="select(dt.date)" ng-disabled="dt.disabled" tabindex="-1">
          <span ng-class="{'text-muted': dt.secondary, 'text-info': dt.current}" class="ng-binding">22</span>
          <span ng-show="(dt.isTet||dt.isLeAL||dt.lunar.day==1||($parent.$index==0&amp;&amp;$index==0))&amp;&amp;dt.lunar.leap" style="position:absolute;bottom:0px;right:0px;font-size:9px;color:#70a0f5;" class="ng-binding ng-hide">25/1*</span>
          <span ng-show="(dt.isTet||dt.isLeAL||dt.lunar.day==1||($parent.$index==0&amp;&amp;$index==0))&amp;&amp;!dt.lunar.leap" style="position:absolute;bottom:0px;right:0px;font-size:9px;color:#70a0f5;" class="ng-binding ng-hide">25/1</span>
          <span ng-show="!dt.isTet&amp;&amp;!dt.isLeAL&amp;&amp;dt.lunar.day!=1&amp;&amp;($parent.$index!=0||$index!=0)" style="position:absolute;bottom:0px;right:0px;font-size:9px;color:#70a0f5;" class="ng-binding">25</span>
        </button>
      </td> end ngRepeat: dt in row track by dt.date <td ng-repeat="dt in row track by dt.date" class="text-center ng-scope" role="gridcell" id="datepicker-04Z-2794-27" aria-disabled="false">
        <button type="button" style="font-size:13px;width:38px;height:30px;padding:0px 10px 10px 0px;position:relative;" ng-style="{'border-color':dt.isTet?'red':((dt.isLeAL||dt.isLeDL)?'#f8a383':undefined)}" class="btn btn-default btn-sm" ng-class="{'btn-info': dt.selected, active: isActive(dt)}" ng-click="select(dt.date)" ng-disabled="dt.disabled" tabindex="-1">
          <span ng-class="{'text-muted': dt.secondary, 'text-info': dt.current}" class="ng-binding">23</span>
          <span ng-show="(dt.isTet||dt.isLeAL||dt.lunar.day==1||($parent.$index==0&amp;&amp;$index==0))&amp;&amp;dt.lunar.leap" style="position:absolute;bottom:0px;right:0px;font-size:9px;color:#70a0f5;" class="ng-binding ng-hide">26/1*</span>
          <span ng-show="(dt.isTet||dt.isLeAL||dt.lunar.day==1||($parent.$index==0&amp;&amp;$index==0))&amp;&amp;!dt.lunar.leap" style="position:absolute;bottom:0px;right:0px;font-size:9px;color:#70a0f5;" class="ng-binding ng-hide">26/1</span>
          <span ng-show="!dt.isTet&amp;&amp;!dt.isLeAL&amp;&amp;dt.lunar.day!=1&amp;&amp;($parent.$index!=0||$index!=0)" style="position:absolute;bottom:0px;right:0px;font-size:9px;color:#70a0f5;" class="ng-binding">26</span>
        </button>
      </td> end ngRepeat: dt in row track by dt.date 
    </tr> end ngRepeat: row in rows track by $index <tr ng-repeat="row in rows track by $index" class="ng-scope">
      <td ng-show="showWeeks" class="text-center h6"><em class="ng-binding">9</em></td>
       ngRepeat: dt in row track by dt.date <td ng-repeat="dt in row track by dt.date" class="text-center ng-scope" role="gridcell" id="datepicker-04Z-2794-28" aria-disabled="false">
        <button type="button" style="font-size:13px;width:38px;height:30px;padding:0px 10px 10px 0px;position:relative;" ng-style="{'border-color':dt.isTet?'red':((dt.isLeAL||dt.isLeDL)?'#f8a383':undefined)}" class="btn btn-default btn-sm" ng-class="{'btn-info': dt.selected, active: isActive(dt)}" ng-click="select(dt.date)" ng-disabled="dt.disabled" tabindex="-1">
          <span ng-class="{'text-muted': dt.secondary, 'text-info': dt.current}" class="ng-binding">24</span>
          <span ng-show="(dt.isTet||dt.isLeAL||dt.lunar.day==1||($parent.$index==0&amp;&amp;$index==0))&amp;&amp;dt.lunar.leap" style="position:absolute;bottom:0px;right:0px;font-size:9px;color:#70a0f5;" class="ng-binding ng-hide">27/1*</span>
          <span ng-show="(dt.isTet||dt.isLeAL||dt.lunar.day==1||($parent.$index==0&amp;&amp;$index==0))&amp;&amp;!dt.lunar.leap" style="position:absolute;bottom:0px;right:0px;font-size:9px;color:#70a0f5;" class="ng-binding ng-hide">27/1</span>
          <span ng-show="!dt.isTet&amp;&amp;!dt.isLeAL&amp;&amp;dt.lunar.day!=1&amp;&amp;($parent.$index!=0||$index!=0)" style="position:absolute;bottom:0px;right:0px;font-size:9px;color:#70a0f5;" class="ng-binding">27</span>
        </button>
      </td> end ngRepeat: dt in row track by dt.date <td ng-repeat="dt in row track by dt.date" class="text-center ng-scope" role="gridcell" id="datepicker-04Z-2794-29" aria-disabled="false">
        <button type="button" style="font-size:13px;width:38px;height:30px;padding:0px 10px 10px 0px;position:relative;" ng-style="{'border-color':dt.isTet?'red':((dt.isLeAL||dt.isLeDL)?'#f8a383':undefined)}" class="btn btn-default btn-sm" ng-class="{'btn-info': dt.selected, active: isActive(dt)}" ng-click="select(dt.date)" ng-disabled="dt.disabled" tabindex="-1">
          <span ng-class="{'text-muted': dt.secondary, 'text-info': dt.current}" class="ng-binding">25</span>
          <span ng-show="(dt.isTet||dt.isLeAL||dt.lunar.day==1||($parent.$index==0&amp;&amp;$index==0))&amp;&amp;dt.lunar.leap" style="position:absolute;bottom:0px;right:0px;font-size:9px;color:#70a0f5;" class="ng-binding ng-hide">28/1*</span>
          <span ng-show="(dt.isTet||dt.isLeAL||dt.lunar.day==1||($parent.$index==0&amp;&amp;$index==0))&amp;&amp;!dt.lunar.leap" style="position:absolute;bottom:0px;right:0px;font-size:9px;color:#70a0f5;" class="ng-binding ng-hide">28/1</span>
          <span ng-show="!dt.isTet&amp;&amp;!dt.isLeAL&amp;&amp;dt.lunar.day!=1&amp;&amp;($parent.$index!=0||$index!=0)" style="position:absolute;bottom:0px;right:0px;font-size:9px;color:#70a0f5;" class="ng-binding">28</span>
        </button>
      </td> end ngRepeat: dt in row track by dt.date <td ng-repeat="dt in row track by dt.date" class="text-center ng-scope" role="gridcell" id="datepicker-04Z-2794-30" aria-disabled="false">
        <button type="button" style="font-size:13px;width:38px;height:30px;padding:0px 10px 10px 0px;position:relative;" ng-style="{'border-color':dt.isTet?'red':((dt.isLeAL||dt.isLeDL)?'#f8a383':undefined)}" class="btn btn-default btn-sm" ng-class="{'btn-info': dt.selected, active: isActive(dt)}" ng-click="select(dt.date)" ng-disabled="dt.disabled" tabindex="-1">
          <span ng-class="{'text-muted': dt.secondary, 'text-info': dt.current}" class="ng-binding">26</span>
          <span ng-show="(dt.isTet||dt.isLeAL||dt.lunar.day==1||($parent.$index==0&amp;&amp;$index==0))&amp;&amp;dt.lunar.leap" style="position:absolute;bottom:0px;right:0px;font-size:9px;color:#70a0f5;" class="ng-binding ng-hide">29/1*</span>
          <span ng-show="(dt.isTet||dt.isLeAL||dt.lunar.day==1||($parent.$index==0&amp;&amp;$index==0))&amp;&amp;!dt.lunar.leap" style="position:absolute;bottom:0px;right:0px;font-size:9px;color:#70a0f5;" class="ng-binding ng-hide">29/1</span>
          <span ng-show="!dt.isTet&amp;&amp;!dt.isLeAL&amp;&amp;dt.lunar.day!=1&amp;&amp;($parent.$index!=0||$index!=0)" style="position:absolute;bottom:0px;right:0px;font-size:9px;color:#70a0f5;" class="ng-binding">29</span>
        </button>
      </td> end ngRepeat: dt in row track by dt.date <td ng-repeat="dt in row track by dt.date" class="text-center ng-scope" role="gridcell" id="datepicker-04Z-2794-31" aria-disabled="false">
        <button type="button" style="font-size:13px;width:38px;height:30px;padding:0px 10px 10px 0px;position:relative;" ng-style="{'border-color':dt.isTet?'red':((dt.isLeAL||dt.isLeDL)?'#f8a383':undefined)}" class="btn btn-default btn-sm" ng-class="{'btn-info': dt.selected, active: isActive(dt)}" ng-click="select(dt.date)" ng-disabled="dt.disabled" tabindex="-1">
          <span ng-class="{'text-muted': dt.secondary, 'text-info': dt.current}" class="ng-binding">27</span>
          <span ng-show="(dt.isTet||dt.isLeAL||dt.lunar.day==1||($parent.$index==0&amp;&amp;$index==0))&amp;&amp;dt.lunar.leap" style="position:absolute;bottom:0px;right:0px;font-size:9px;color:#70a0f5;" class="ng-binding ng-hide">30/1*</span>
          <span ng-show="(dt.isTet||dt.isLeAL||dt.lunar.day==1||($parent.$index==0&amp;&amp;$index==0))&amp;&amp;!dt.lunar.leap" style="position:absolute;bottom:0px;right:0px;font-size:9px;color:#70a0f5;" class="ng-binding ng-hide">30/1</span>
          <span ng-show="!dt.isTet&amp;&amp;!dt.isLeAL&amp;&amp;dt.lunar.day!=1&amp;&amp;($parent.$index!=0||$index!=0)" style="position:absolute;bottom:0px;right:0px;font-size:9px;color:#70a0f5;" class="ng-binding">30</span>
        </button>
      </td> end ngRepeat: dt in row track by dt.date <td ng-repeat="dt in row track by dt.date" class="text-center ng-scope" role="gridcell" id="datepicker-04Z-2794-32" aria-disabled="false">
        <button type="button" style="font-size:13px;width:38px;height:30px;padding:0px 10px 10px 0px;position:relative;" ng-style="{'border-color':dt.isTet?'red':((dt.isLeAL||dt.isLeDL)?'#f8a383':undefined)}" class="btn btn-default btn-sm" ng-class="{'btn-info': dt.selected, active: isActive(dt)}" ng-click="select(dt.date)" ng-disabled="dt.disabled" tabindex="-1">
          <span ng-class="{'text-muted': dt.secondary, 'text-info': dt.current}" class="ng-binding">28</span>
          <span ng-show="(dt.isTet||dt.isLeAL||dt.lunar.day==1||($parent.$index==0&amp;&amp;$index==0))&amp;&amp;dt.lunar.leap" style="position:absolute;bottom:0px;right:0px;font-size:9px;color:#70a0f5;" class="ng-binding ng-hide">1/2*</span>
          <span ng-show="(dt.isTet||dt.isLeAL||dt.lunar.day==1||($parent.$index==0&amp;&amp;$index==0))&amp;&amp;!dt.lunar.leap" style="position:absolute;bottom:0px;right:0px;font-size:9px;color:#70a0f5;" class="ng-binding">1/2</span>
          <span ng-show="!dt.isTet&amp;&amp;!dt.isLeAL&amp;&amp;dt.lunar.day!=1&amp;&amp;($parent.$index!=0||$index!=0)" style="position:absolute;bottom:0px;right:0px;font-size:9px;color:#70a0f5;" class="ng-binding ng-hide">1</span>
        </button>
      </td> end ngRepeat: dt in row track by dt.date <td ng-repeat="dt in row track by dt.date" class="text-center ng-scope" role="gridcell" id="datepicker-04Z-2794-33" aria-disabled="false">
        <button type="button" style="font-size:13px;width:38px;height:30px;padding:0px 10px 10px 0px;position:relative;" ng-style="{'border-color':dt.isTet?'red':((dt.isLeAL||dt.isLeDL)?'#f8a383':undefined)}" class="btn btn-default btn-sm" ng-class="{'btn-info': dt.selected, active: isActive(dt)}" ng-click="select(dt.date)" ng-disabled="dt.disabled" tabindex="-1">
          <span ng-class="{'text-muted': dt.secondary, 'text-info': dt.current}" class="ng-binding text-muted">01</span>
          <span ng-show="(dt.isTet||dt.isLeAL||dt.lunar.day==1||($parent.$index==0&amp;&amp;$index==0))&amp;&amp;dt.lunar.leap" style="position:absolute;bottom:0px;right:0px;font-size:9px;color:#70a0f5;" class="ng-binding ng-hide">2/2*</span>
          <span ng-show="(dt.isTet||dt.isLeAL||dt.lunar.day==1||($parent.$index==0&amp;&amp;$index==0))&amp;&amp;!dt.lunar.leap" style="position:absolute;bottom:0px;right:0px;font-size:9px;color:#70a0f5;" class="ng-binding ng-hide">2/2</span>
          <span ng-show="!dt.isTet&amp;&amp;!dt.isLeAL&amp;&amp;dt.lunar.day!=1&amp;&amp;($parent.$index!=0||$index!=0)" style="position:absolute;bottom:0px;right:0px;font-size:9px;color:#70a0f5;" class="ng-binding">2</span>
        </button>
      </td> end ngRepeat: dt in row track by dt.date <td ng-repeat="dt in row track by dt.date" class="text-center ng-scope" role="gridcell" id="datepicker-04Z-2794-34" aria-disabled="false">
        <button type="button" style="font-size:13px;width:38px;height:30px;padding:0px 10px 10px 0px;position:relative;" ng-style="{'border-color':dt.isTet?'red':((dt.isLeAL||dt.isLeDL)?'#f8a383':undefined)}" class="btn btn-default btn-sm" ng-class="{'btn-info': dt.selected, active: isActive(dt)}" ng-click="select(dt.date)" ng-disabled="dt.disabled" tabindex="-1">
          <span ng-class="{'text-muted': dt.secondary, 'text-info': dt.current}" class="ng-binding text-muted">02</span>
          <span ng-show="(dt.isTet||dt.isLeAL||dt.lunar.day==1||($parent.$index==0&amp;&amp;$index==0))&amp;&amp;dt.lunar.leap" style="position:absolute;bottom:0px;right:0px;font-size:9px;color:#70a0f5;" class="ng-binding ng-hide">3/2*</span>
          <span ng-show="(dt.isTet||dt.isLeAL||dt.lunar.day==1||($parent.$index==0&amp;&amp;$index==0))&amp;&amp;!dt.lunar.leap" style="position:absolute;bottom:0px;right:0px;font-size:9px;color:#70a0f5;" class="ng-binding ng-hide">3/2</span>
          <span ng-show="!dt.isTet&amp;&amp;!dt.isLeAL&amp;&amp;dt.lunar.day!=1&amp;&amp;($parent.$index!=0||$index!=0)" style="position:absolute;bottom:0px;right:0px;font-size:9px;color:#70a0f5;" class="ng-binding">3</span>
        </button>
      </td> end ngRepeat: dt in row track by dt.date 
    </tr> end ngRepeat: row in rows track by $index <tr ng-repeat="row in rows track by $index" class="ng-scope">
      <td ng-show="showWeeks" class="text-center h6"><em class="ng-binding">10</em></td>
       ngRepeat: dt in row track by dt.date <td ng-repeat="dt in row track by dt.date" class="text-center ng-scope" role="gridcell" id="datepicker-04Z-2794-35" aria-disabled="false">
        <button type="button" style="font-size:13px;width:38px;height:30px;padding:0px 10px 10px 0px;position:relative;" ng-style="{'border-color':dt.isTet?'red':((dt.isLeAL||dt.isLeDL)?'#f8a383':undefined)}" class="btn btn-default btn-sm" ng-class="{'btn-info': dt.selected, active: isActive(dt)}" ng-click="select(dt.date)" ng-disabled="dt.disabled" tabindex="-1">
          <span ng-class="{'text-muted': dt.secondary, 'text-info': dt.current}" class="ng-binding text-muted">03</span>
          <span ng-show="(dt.isTet||dt.isLeAL||dt.lunar.day==1||($parent.$index==0&amp;&amp;$index==0))&amp;&amp;dt.lunar.leap" style="position:absolute;bottom:0px;right:0px;font-size:9px;color:#70a0f5;" class="ng-binding ng-hide">4/2*</span>
          <span ng-show="(dt.isTet||dt.isLeAL||dt.lunar.day==1||($parent.$index==0&amp;&amp;$index==0))&amp;&amp;!dt.lunar.leap" style="position:absolute;bottom:0px;right:0px;font-size:9px;color:#70a0f5;" class="ng-binding ng-hide">4/2</span>
          <span ng-show="!dt.isTet&amp;&amp;!dt.isLeAL&amp;&amp;dt.lunar.day!=1&amp;&amp;($parent.$index!=0||$index!=0)" style="position:absolute;bottom:0px;right:0px;font-size:9px;color:#70a0f5;" class="ng-binding">4</span>
        </button>
      </td> end ngRepeat: dt in row track by dt.date <td ng-repeat="dt in row track by dt.date" class="text-center ng-scope" role="gridcell" id="datepicker-04Z-2794-36" aria-disabled="false">
        <button type="button" style="font-size:13px;width:38px;height:30px;padding:0px 10px 10px 0px;position:relative;" ng-style="{'border-color':dt.isTet?'red':((dt.isLeAL||dt.isLeDL)?'#f8a383':undefined)}" class="btn btn-default btn-sm" ng-class="{'btn-info': dt.selected, active: isActive(dt)}" ng-click="select(dt.date)" ng-disabled="dt.disabled" tabindex="-1">
          <span ng-class="{'text-muted': dt.secondary, 'text-info': dt.current}" class="ng-binding text-muted">04</span>
          <span ng-show="(dt.isTet||dt.isLeAL||dt.lunar.day==1||($parent.$index==0&amp;&amp;$index==0))&amp;&amp;dt.lunar.leap" style="position:absolute;bottom:0px;right:0px;font-size:9px;color:#70a0f5;" class="ng-binding ng-hide">5/2*</span>
          <span ng-show="(dt.isTet||dt.isLeAL||dt.lunar.day==1||($parent.$index==0&amp;&amp;$index==0))&amp;&amp;!dt.lunar.leap" style="position:absolute;bottom:0px;right:0px;font-size:9px;color:#70a0f5;" class="ng-binding ng-hide">5/2</span>
          <span ng-show="!dt.isTet&amp;&amp;!dt.isLeAL&amp;&amp;dt.lunar.day!=1&amp;&amp;($parent.$index!=0||$index!=0)" style="position:absolute;bottom:0px;right:0px;font-size:9px;color:#70a0f5;" class="ng-binding">5</span>
        </button>
      </td> end ngRepeat: dt in row track by dt.date <td ng-repeat="dt in row track by dt.date" class="text-center ng-scope" role="gridcell" id="datepicker-04Z-2794-37" aria-disabled="false">
        <button type="button" style="font-size:13px;width:38px;height:30px;padding:0px 10px 10px 0px;position:relative;" ng-style="{'border-color':dt.isTet?'red':((dt.isLeAL||dt.isLeDL)?'#f8a383':undefined)}" class="btn btn-default btn-sm" ng-class="{'btn-info': dt.selected, active: isActive(dt)}" ng-click="select(dt.date)" ng-disabled="dt.disabled" tabindex="-1">
          <span ng-class="{'text-muted': dt.secondary, 'text-info': dt.current}" class="ng-binding text-muted">05</span>
          <span ng-show="(dt.isTet||dt.isLeAL||dt.lunar.day==1||($parent.$index==0&amp;&amp;$index==0))&amp;&amp;dt.lunar.leap" style="position:absolute;bottom:0px;right:0px;font-size:9px;color:#70a0f5;" class="ng-binding ng-hide">6/2*</span>
          <span ng-show="(dt.isTet||dt.isLeAL||dt.lunar.day==1||($parent.$index==0&amp;&amp;$index==0))&amp;&amp;!dt.lunar.leap" style="position:absolute;bottom:0px;right:0px;font-size:9px;color:#70a0f5;" class="ng-binding ng-hide">6/2</span>
          <span ng-show="!dt.isTet&amp;&amp;!dt.isLeAL&amp;&amp;dt.lunar.day!=1&amp;&amp;($parent.$index!=0||$index!=0)" style="position:absolute;bottom:0px;right:0px;font-size:9px;color:#70a0f5;" class="ng-binding">6</span>
        </button>
      </td> end ngRepeat: dt in row track by dt.date <td ng-repeat="dt in row track by dt.date" class="text-center ng-scope" role="gridcell" id="datepicker-04Z-2794-38" aria-disabled="false">
        <button type="button" style="font-size:13px;width:38px;height:30px;padding:0px 10px 10px 0px;position:relative;" ng-style="{'border-color':dt.isTet?'red':((dt.isLeAL||dt.isLeDL)?'#f8a383':undefined)}" class="btn btn-default btn-sm" ng-class="{'btn-info': dt.selected, active: isActive(dt)}" ng-click="select(dt.date)" ng-disabled="dt.disabled" tabindex="-1">
          <span ng-class="{'text-muted': dt.secondary, 'text-info': dt.current}" class="ng-binding text-muted">06</span>
          <span ng-show="(dt.isTet||dt.isLeAL||dt.lunar.day==1||($parent.$index==0&amp;&amp;$index==0))&amp;&amp;dt.lunar.leap" style="position:absolute;bottom:0px;right:0px;font-size:9px;color:#70a0f5;" class="ng-binding ng-hide">7/2*</span>
          <span ng-show="(dt.isTet||dt.isLeAL||dt.lunar.day==1||($parent.$index==0&amp;&amp;$index==0))&amp;&amp;!dt.lunar.leap" style="position:absolute;bottom:0px;right:0px;font-size:9px;color:#70a0f5;" class="ng-binding ng-hide">7/2</span>
          <span ng-show="!dt.isTet&amp;&amp;!dt.isLeAL&amp;&amp;dt.lunar.day!=1&amp;&amp;($parent.$index!=0||$index!=0)" style="position:absolute;bottom:0px;right:0px;font-size:9px;color:#70a0f5;" class="ng-binding">7</span>
        </button>
      </td> end ngRepeat: dt in row track by dt.date <td ng-repeat="dt in row track by dt.date" class="text-center ng-scope" role="gridcell" id="datepicker-04Z-2794-39" aria-disabled="false">
        <button type="button" style="font-size:13px;width:38px;height:30px;padding:0px 10px 10px 0px;position:relative;" ng-style="{'border-color':dt.isTet?'red':((dt.isLeAL||dt.isLeDL)?'#f8a383':undefined)}" class="btn btn-default btn-sm" ng-class="{'btn-info': dt.selected, active: isActive(dt)}" ng-click="select(dt.date)" ng-disabled="dt.disabled" tabindex="-1">
          <span ng-class="{'text-muted': dt.secondary, 'text-info': dt.current}" class="ng-binding text-muted">07</span>
          <span ng-show="(dt.isTet||dt.isLeAL||dt.lunar.day==1||($parent.$index==0&amp;&amp;$index==0))&amp;&amp;dt.lunar.leap" style="position:absolute;bottom:0px;right:0px;font-size:9px;color:#70a0f5;" class="ng-binding ng-hide">8/2*</span>
          <span ng-show="(dt.isTet||dt.isLeAL||dt.lunar.day==1||($parent.$index==0&amp;&amp;$index==0))&amp;&amp;!dt.lunar.leap" style="position:absolute;bottom:0px;right:0px;font-size:9px;color:#70a0f5;" class="ng-binding ng-hide">8/2</span>
          <span ng-show="!dt.isTet&amp;&amp;!dt.isLeAL&amp;&amp;dt.lunar.day!=1&amp;&amp;($parent.$index!=0||$index!=0)" style="position:absolute;bottom:0px;right:0px;font-size:9px;color:#70a0f5;" class="ng-binding">8</span>
        </button>
      </td> end ngRepeat: dt in row track by dt.date <td ng-repeat="dt in row track by dt.date" class="text-center ng-scope" role="gridcell" id="datepicker-04Z-2794-40" aria-disabled="false">
        <button type="button" style="font-size:13px;width:38px;height:30px;padding:0px 10px 10px 0px;position:relative;" ng-style="{'border-color':dt.isTet?'red':((dt.isLeAL||dt.isLeDL)?'#f8a383':undefined)}" class="btn btn-default btn-sm" ng-class="{'btn-info': dt.selected, active: isActive(dt)}" ng-click="select(dt.date)" ng-disabled="dt.disabled" tabindex="-1">
          <span ng-class="{'text-muted': dt.secondary, 'text-info': dt.current}" class="ng-binding text-muted">08</span>
          <span ng-show="(dt.isTet||dt.isLeAL||dt.lunar.day==1||($parent.$index==0&amp;&amp;$index==0))&amp;&amp;dt.lunar.leap" style="position:absolute;bottom:0px;right:0px;font-size:9px;color:#70a0f5;" class="ng-binding ng-hide">9/2*</span>
          <span ng-show="(dt.isTet||dt.isLeAL||dt.lunar.day==1||($parent.$index==0&amp;&amp;$index==0))&amp;&amp;!dt.lunar.leap" style="position:absolute;bottom:0px;right:0px;font-size:9px;color:#70a0f5;" class="ng-binding ng-hide">9/2</span>
          <span ng-show="!dt.isTet&amp;&amp;!dt.isLeAL&amp;&amp;dt.lunar.day!=1&amp;&amp;($parent.$index!=0||$index!=0)" style="position:absolute;bottom:0px;right:0px;font-size:9px;color:#70a0f5;" class="ng-binding">9</span>
        </button>
      </td> end ngRepeat: dt in row track by dt.date <td ng-repeat="dt in row track by dt.date" class="text-center ng-scope" role="gridcell" id="datepicker-04Z-2794-41" aria-disabled="false">
        <button type="button" style="font-size:13px;width:38px;height:30px;padding:0px 10px 10px 0px;position:relative;" ng-style="{'border-color':dt.isTet?'red':((dt.isLeAL||dt.isLeDL)?'#f8a383':undefined)}" class="btn btn-default btn-sm" ng-class="{'btn-info': dt.selected, active: isActive(dt)}" ng-click="select(dt.date)" ng-disabled="dt.disabled" tabindex="-1">
          <span ng-class="{'text-muted': dt.secondary, 'text-info': dt.current}" class="ng-binding text-muted">09</span>
          <span ng-show="(dt.isTet||dt.isLeAL||dt.lunar.day==1||($parent.$index==0&amp;&amp;$index==0))&amp;&amp;dt.lunar.leap" style="position:absolute;bottom:0px;right:0px;font-size:9px;color:#70a0f5;" class="ng-binding ng-hide">10/2*</span>
          <span ng-show="(dt.isTet||dt.isLeAL||dt.lunar.day==1||($parent.$index==0&amp;&amp;$index==0))&amp;&amp;!dt.lunar.leap" style="position:absolute;bottom:0px;right:0px;font-size:9px;color:#70a0f5;" class="ng-binding ng-hide">10/2</span>
          <span ng-show="!dt.isTet&amp;&amp;!dt.isLeAL&amp;&amp;dt.lunar.day!=1&amp;&amp;($parent.$index!=0||$index!=0)" style="position:absolute;bottom:0px;right:0px;font-size:9px;color:#70a0f5;" class="ng-binding">10</span>
        </button>
      </td> end ngRepeat: dt in row track by dt.date 
    </tr> end ngRepeat: row in rows track by $index 
  </tbody>
</table>-->
  <!-- ngSwitchWhen: month -->
  <!-- ngSwitchWhen: year -->
</div></li>
	<!-- ngIf: showButtonBar -->
</ul>
<!--                        <span class="input-group-btn">
                            <button type="button" class="btn btn-primary" ng-click="open_ngayDi($event)" style="padding: 6px 8px 7px 8px;">
                                <i class="glyphicon glyphicon-calendar" style="font-size: 18px;"></i>
                            </button>
                        </span>-->
                    </div>
                </div>
            </div>

            <div class="col-xs-4 col-sm-2 col-md-2">
                <label class="kt-form-label ng-binding">Số giấy tờ<!--Số giấy tờ--></label>
            </div>
            <div class="col-xs-8 col-sm-4 col-md-4">
                <div class="form-group">
                    <!--<span class="control-label" ng-show="cmtError">Vui lòng nhập số giấy tờ cá nhân ghi trên vé</span>-->
                    <input type="text" class="form-control ng-pristine ng-valid" ng-model="searchData.cmt" ng-change="cmtError=false" placeholder="Nhập giấy tờ cá nhân ghi trên vé" id="maVe">
                </div>
            </div>
        </div>
        <div class="row">
            <div class="col-md-12">
                <input analytics-on="click" analytics-event="DoCheckTicket" type="button" class="btn btn-primary" ng-click="submitForm()" value="Kiểm tra vé" style="border-radius: 4px !important;">
            </div>
        </div>
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
