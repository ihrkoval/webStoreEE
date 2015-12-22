<%@ page import="java.util.List" %>
<%@ page import="store.Product" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.io.PrintWriter" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <title>MyShop</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="">
    <meta name="author" content="">

    <!-- Le styles -->
    <link href="http://getbootstrap.com/2.3.2/assets/css/bootstrap.css" rel="stylesheet">
    <style type="text/css">
        body {
            padding-top: 60px;
            padding-bottom: 40px;
        }
    </style>
    <link href="http://getbootstrap.com/2.3.2/assets/css/bootstrap-responsive.css" rel="stylesheet">

</head>

<body>

<div class="navbar navbar-inverse navbar-fixed-top">
    <div class="navbar-inner">
        <div class="container">
            <button type="button" class="btn btn-navbar" data-toggle="collapse" data-target=".nav-collapse">
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
            </button>
            <a class="brand" href="#">Project name</a>
            <div class="nav-collapse collapse">
                <ul class="nav">
                    <li class="active"><a href="#">Home</a></li>
                    <li><a href="#about">About</a></li>
                    <li><a href="#contact">Contact</a></li>
                    <li class="dropdown">
                        <a href="#" class="dropdown-toggle" data-toggle="dropdown">Dropdown <b class="caret"></b></a>
                        <ul class="dropdown-menu">
                            <li><a href="#">Action</a></li>
                            <li><a href="#">Another action</a></li>
                            <li><a href="#">Something else here</a></li>
                            <li class="divider"></li>
                            <li class="nav-header">Nav header</li>
                            <li><a href="#">Separated link</a></li>
                            <li><a href="#">One more separated link</a></li>
                        </ul>
                    </li>
                </ul>
                <sec:authorize access="isAnonymous()">
                    <c:url value="/j_spring_security_check" var="loginUrl" />
                    <form class="navbar-form pull-right" action="${loginUrl}" method="post">
                        <input class="span2" type="text" name="j_username" placeholder="Email">
                        <input class="span2" type="password" name="j_password" placeholder="Password">
                        <button type="submit" class="btn">Войти</button>
                        <a href="/reg">Регистрация</a>
                    </form>
                </sec:authorize>
                <sec:authorize access="isAuthenticated()">
                    <form class="navbar-form pull-right">
                    <p class="text-info">Ваш логин: <sec:authentication property="principal.username" />
                    <a class="btn btn-lg btn-danger" href="<c:url value="/logout" />" role="button">Выйти</a>
                    <sec:authorize access="hasRole('ADMIN')">
                        <a class="btn btn-inverse" href="<c:url value="/admin" />" role="button">Админка</a></form>
                    </sec:authorize>
                    </p>
                    </form>

                </sec:authorize>




            </div><!--/.nav-collapse -->
        </div>
    </div>
</div>

<div class="container">

    <!-- Main hero unit for a primary marketing message or call to action -->
    <div class="hero-unit">
        <h1>Hello, world!</h1>
        <p>This is a template for a simple marketing or informational website. It includes a large callout called the hero unit and three supporting pieces of content. Use it as a starting point to create something more unique.</p>
        <p><a href="#" class="btn btn-primary btn-large">Learn more &raquo;</a></p>
    </div>

    <!-- Example row of columns -->


    <div class="row">
        <%--<% ArrayList<Product> products = (ArrayList<Product>)request.getAttribute("products");
            PrintWriter pw = response.getWriter();

            for (int i = 0; i <  products.size()-1; i++) {
                Product p = products.get(i);
                pw.println("<div class=\"span4\">");
                pw.println("<h3> "+p.getName()+"</h3>");
                pw.println("<p><img height=\"140\" width=\"140\" src=./images/"+p.getId()+" class=\"img-polaroid\" /></p>\n");
                pw.println("<p>"+p.getCat_id()+"</p>");
                pw.println("<p>"+p.getDescription()+"</p>");
                pw.println("<p>"+p.getPrice()+"</p>");
                pw.println("<p><a class=\"btn\" href=\"#\">View details &raquo;</a></p></div>");
            }

        %>--%>
        <c:forEach items="${products}" var="p">
        <div class="span4">
            <h3>${p.name}</h3>
            <p><img height="140" width="140" src=./images/${p.id} class="img-polaroid" /></p>
            <p>${p.cat_id}</p>
            <p>${p.description}</p>
            <p>${p.price} грн</p>
            <p><a class="btn" href="./basket?id=${p.id}">В корзину &raquo;</a></p></div>

        </c:forEach>

    </div>

    <hr>

    <footer>
        <p>&copy; Company 2013</p>
    </footer>

</div> <!-- /container -->

<!-- Le javascript
================================================== -->
<!-- Placed at the end of the document so the pages load faster -->
<script src="http://getbootstrap.com/2.3.2/assets/js/jquery.js"></script>
<script src="http://getbootstrap.com/2.3.2/assets/js/bootstrap-transition.js"></script>
<script src="http://getbootstrap.com/2.3.2/assets/js/bootstrap-alert.js"></script>
<script src="http://getbootstrap.com/2.3.2/assets/js/bootstrap-modal.js"></script>
<script src="http://getbootstrap.com/2.3.2/assets/js/bootstrap-dropdown.js"></script>
<script src="http://getbootstrap.com/2.3.2/assets/js/bootstrap-scrollspy.js"></script>
<script src="http://getbootstrap.com/2.3.2/assets/js/bootstrap-tab.js"></script>
<script src="http://getbootstrap.com/2.3.2/assets/js/bootstrap-tooltip.js"></script>
<script src="http://getbootstrap.com/2.3.2/assets/js/bootstrap-popover.js"></script>
<script src="http://getbootstrap.com/2.3.2/assets/js/bootstrap-button.js"></script>
<script src="http://getbootstrap.com/2.3.2/assets/js/bootstrap-collapse.js"></script>
<script src="http://getbootstrap.com/2.3.2/assets/js/bootstrap-carousel.js"></script>
<script src="http://getbootstrap.com/2.3.2/assets/js/bootstrap-typeahead.js"></script>

</body>
</html>
