
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<header id="header">
    <div id="header-wrap">
        <c:if test="${sessionScope.acc==null}">
            <nav class="secondary-nav border-bottom">
                <div class="container">
                    <div class="row d-flex align-items-center">
                        <div class="col-lg-1 col-md-1 header-contact">
                            <a class="navbar-brand" href="home">Shoes</a>

                        </div>
                        <div class="navbar col-lg-6 col-md-6">
                            <div id="main-nav" class="stellarnav d-flex justify-content-end right">
                                <ul class="menu-list">

                                    <li class="menu-item has-sub">
                                        <a href="home" class="item-anchor active d-flex align-item-center" data-effect="Home">Home</a>

                                    </li>
                                    <li class="menu-item has-sub">
                                        <a href="shop.html" class="item-anchor d-flex align-item-center" data-effect="Shop">Hàng mới</a>

                                    </li>

                                    <li class="menu-item has-sub">
                                        <a href="#" class="item-anchor d-flex align-item-center" data-effect="Pages">Thương hiệu<i class="icon icon-chevron-down"></i></a>
                                        <ul class="submenu">
                                            <c:forEach items="${listCC}" var="o">
                                                <li class="list-group-item text-white ${tag == o.cid ? "active":""}"><a href="category?cid=${o.cid}" class="item-anchor">${o.cname}</a></li>
                                                </c:forEach>
                                            <!--                                                <li><a href="coming-soon.html" class="item-anchor">Coming soon<span class="text-primary"> (PRO)</span></a></li>
                                                                                            <li><a href="login.jsp" class="item-anchor">Login<span class="text-primary"> (PRO)</span></a></li>
                                                                                            <li><a href="faqs.html" class="item-anchor">FAQs<span class="text-primary"> (PRO)</span></a></li>
                                                                                            <li><a href="styles.html" class="item-anchor">Styles</a></li>
                                                                                            <li><a href="thank-you.html" class="item-anchor">Thankyou</a></li>
                                                                                            <li><a href="error.html" class="item-anchor">Error page<span class="text-primary"> (PRO)</span></a></li>-->
                                        </ul>
                                    </li>

                                    <!--                                        <li class="menu-item has-sub">
                                                                                <a href="blog.html" class="item-anchor d-flex align-item-center" data-effect="Blog">Blog<i class="icon icon-chevron-down"></i></a>
                                                                                <ul class="submenu">
                                                                                    <li><a href="blog.html" class="item-anchor">Blog</a></li>
                                                                                    <li><a href="blog-sidebar.html" class="item-anchor">Blog with sidebar<span class="text-primary"> (PRO)</span></a></li>
                                                                                    <li><a href="blog-masonry.html" class="item-anchor">Blog masonry<span class="text-primary"> (PRO)</span></a></li>
                                                                                    <li><a href="single-post.html" class="item-anchor">Single post</a></li>
                                                                                </ul>
                                                                            </li>-->

                                    <li><a href="contact.html" class="item-anchor" data-effect="Contact">Contact</a></li>

                                </ul>
                            </div>
                        </div>
                        <div class="col-lg-5 col-md-5 col-sm-12 user-items">
                            <ul class="d-flex justify-content-end list-unstyled">
                                <li class="user-items search-item pe-3">
                                    <div class="header-search">
                                        <form role="search" method="get" class="search-form" action="">
                                            <input type="search" id="search-form" class="search-field" placeholder="Type and press enter" value="${param.search}" name="s"  />
                                            <button type="submit" class="search-submit"><a href="#"><i class="icon icon-search"></i></a></button>
                                        </form>
                                    </div>
                                </li>
                                <li class="icon-header ">
                                    <a href="Login.jsp">
                                        <i class="icon icon-user"></i>
                                    </a>
                                </li>
                                <li class="icon-header">
                                    <a href="Cart.jsp">
                                        <i class="icon icon-shopping-cart"></i>                                            
                                        <span class="current-cart-count">
                                            <span class="inner-count">
                                                1
                                            </span>
                                        </span>
                                    </a>
                                </li>
                                <li class="icon-header">
                                    <a href="wishlist.html">
                                        <i class="icon icon-heart"></i>
                                    </a>
                                </li>

                            </ul>
                        </div>
                    </div>
                </div>
            </nav>  
        </c:if>
        <c:if test="${sessionScope.acc!=null}">
            <c:if test="${sessionScope.acc.isAdmin == 1||sessionScope.acc.isSell == 1}">
                <nav class="navbar navbar-expand-md navbar-dark bg-dark">
                    <div class="container">
                        <div class="collapse navbar-collapse justify-content-end" id="navbarsExampleDefault">
                            <ul class="navbar-nav m-auto">
                                <li class="nav-item">
                                    <a class="nav-link" href="#">Hello ${sessionScope.acc.user}</a>
                                </li>
                                <c:if test="${sessionScope.acc.isAdmin == 1}">
                                    <li class="nav-item">
                                        <a class="nav-link" href="#">Manager Account</a>
                                    </li>
                                </c:if>
                                <c:if test="${sessionScope.acc.isSell == 1}">
                                    <li class="nav-item">
                                        <a class="nav-link" href="managerproduct">Manager Product</a>
                                    </li>
                                    <li class="nav-item">
                                        <a class="nav-link" href="managecategory">Manager Category</a>
                                    </li>
                                </c:if>
                            </ul>
                        </div>
                    </div>
                </nav>
            </c:if> 
            <nav aria-label="navbar" class="secondary-nav border-bottom">
                <div class="container">
                    <div class="row d-flex align-items-center">
                        <div class="col-lg-1 col-md-1 header-contact">
                            <a class="navbar-brand" href="home">Shoes</a>

                        </div>
                        <div class="navbar col-lg-6 col-md-6">
                            <div id="main-nav" class="stellarnav d-flex justify-content-end right">
                                <ul class="menu-list">

                                    <li class="menu-item has-sub">
                                        <a href="home" class="item-anchor active d-flex align-item-center" data-effect="Home">Home</a>

                                    </li>
                                    <li class="menu-item has-sub">
                                        <a href="shop.html" class="item-anchor d-flex align-item-center" data-effect="Shop">Hàng mới</a>

                                    </li>

                                    <li class="menu-item has-sub">
                                        <a href="#" class="item-anchor d-flex align-item-center" data-effect="Pages">Thương hiệu<i class="icon icon-chevron-down"></i></a>
                                        <ul class="submenu">
                                            <c:forEach items="${listCC}" var="o">
                                                <li class="list-group-item text-white ${tag == o.cid ? "active":""}"><a href="category?cid=${o.cid}" class="item-anchor">${o.cname}</a></li>
                                                </c:forEach>
                                            <!--                                                <li><a href="coming-soon.html" class="item-anchor">Coming soon<span class="text-primary"> (PRO)</span></a></li>
                                                                                            <li><a href="login.jsp" class="item-anchor">Login<span class="text-primary"> (PRO)</span></a></li>
                                                                                            <li><a href="faqs.html" class="item-anchor">FAQs<span class="text-primary"> (PRO)</span></a></li>
                                                                                            <li><a href="styles.html" class="item-anchor">Styles</a></li>
                                                                                            <li><a href="thank-you.html" class="item-anchor">Thankyou</a></li>
                                                                                            <li><a href="error.html" class="item-anchor">Error page<span class="text-primary"> (PRO)</span></a></li>-->
                                        </ul>
                                    </li>

                                    

                                    <li><a href="contact.html" class="item-anchor" data-effect="Contact">Contact</a></li>

                                </ul>
                            </div>
                        </div>
                        <div class="col-lg-5 col-md-5 col-sm-12 user-items">
                            <ul class="d-flex justify-content-end list-unstyled">
                                <li class="user-items search-item pe-3">
                                    <div class="header-search">
                                        <form role="search" method="get" class="search-form" action="">
                                            <input type="search" id="search-form" class="search-field" placeholder="Type and press enter" value="${param.search}" name="s"  />
                                            <button type="submit" class="search-submit"><a href="#"><i class="icon icon-search"></i></a></button>
                                        </form>
                                    </div>
                                </li>
                                <li class="icon-header ">
                                    <a href="logout">
                                        <i class="icon icon-user"></i>
                                    </a>
                                </li>
                                <li class="icon-header">
                                    <a href="Cart.jsp">
                                        <i class="icon icon-shopping-cart"></i>                                            
                                        <span class="current-cart-count">
                                            <span class="inner-count">
                                                1
                                            </span>
                                        </span>
                                    </a>
                                </li>
                                <li class="icon-header">
                                    <a href="wishlist.html">
                                        <i class="icon icon-heart"></i>
                                    </a>
                                </li>

                            </ul>
                        </div>
                    </div>
                </div>
            </nav>  
        </c:if>


    </div>
</header>

