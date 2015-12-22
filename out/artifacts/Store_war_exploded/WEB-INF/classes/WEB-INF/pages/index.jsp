<%@ page import="store.db.Product" %>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="java.util.*" %>
<%@ page import="javax.management.relation.Role" %>
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
            <a class="brand" href="/">Мой магазин</a>
            <div class="nav-collapse collapse">
                <ul class="nav">
                    <li class="active"><a href="/">Главная</a></li>
                    <li><a href="#about">Доставка</a></li>
                    <li><a href="#contact">Контакты</a></li>
                </ul>

                <sec:authorize access="isAnonymous()">
                    <c:url value="/j_spring_security_check" var="loginUrl" />
                    <form class="navbar-form pull-right" action="${loginUrl}" method="post">
                        <input class="span2" type="text" name="j_username" placeholder="Email or admin">
                        <input class="span2" type="password" name="j_password" placeholder="Password or 1234">
                        <button type="submit" class="btn">Войти</button>
                        <a href="/reg">Регистрация</a>
                    </form>
                </sec:authorize>
                <sec:authorize access="isAuthenticated()">
                    <form class="navbar-form pull-right">
                    <p class="text-info">Ваш логин: <sec:authentication property="principal.username" />
                    <a class="btn btn-small btn-primary" href="<c:url value="/basket" />" role="button">кабинет${inbasket}</a>
                    <a class="btn btn-mini btn-danger" href="<c:url value="/logout" />" role="button">Выйти</a>
                    <sec:authorize access="hasRole('ADMIN')">
                        <a class="btn btn-inverse" href="<c:url value="/orders" />" role="button">Админка</a></form>
                    </sec:authorize>



                </sec:authorize>




            </div><!--/.nav-collapse -->
        </div>
    </div>
</div>

<div class="container">

    <!-- Main hero unit for a primary marketing message or call to action -->
    <div class="hero-unit">
        <h1>Заведение "НАЗВАНИЕ"</h1>
        <p>Описание блаблаблабла блабла блаблабла блаблаблабла блабла бла блаблабла РЕклама блаблаблабла блаблабла блаблабла
            блаблабла блаблаблабла блаблаблаблаблаблаблабла блаблаблабла блаблаблаблабла блаблабла АКЦИЯ! блаблаблабла
            блаблаблаблаблабла блаблаблабла блаблаблабла блаблаблаблаблабла блаблабла бла</p>
        <p><a href="#" class="btn btn-primary btn-large">Подробнее &raquo;</a></p>
    </div>

    <!-- Example row of columns -->


    <div class="row">
        <li class="dropdown">
            <a href="#" class="dropdown-toggle" data-toggle="dropdown"><h2>Категории</h2> <b class="caret"></b></a>
            <ul class="dropdown-menu">
                <li><a href="/">Все</a></li>
                <% ArrayList<Product> products = (ArrayList<Product>)request.getAttribute("products");
                    ArrayList<String> cats = new ArrayList<>();
                    for (Product p : products) {
                        cats.add(p.getCat_id());
                    }
                    String tmp = " hop hey lalaey! ";
                    try {
                        Collections.sort(cats);
                    } catch (NullPointerException e){
                        e.printStackTrace();
                        System.out.println("null photo uploaded");
                    }
                    for(Iterator<String> cat = cats.iterator(); cat.hasNext();){
                        String currentString = cat.next();
                        if (tmp != null && tmp.equals(currentString)) {
                            cat.remove();
                        } else {
                            tmp = currentString;
                        }
                    }


                    ArrayList<String> noMatches = cats;
                    for (int i = 0; i < noMatches.size()-1 ; i++) {
                        tmp = noMatches.get(i);
                        if (tmp != null && tmp.equals(noMatches.get(i+1))){
                            noMatches.remove(i+1);
                        }
                    }
                    System.out.println(noMatches.size());
                    request.setAttribute("cats", noMatches);

                %>
                <c:forEach items="${cats}" var="c">

                    <li><a href="${c}">${c}</a></li>


                </c:forEach>
            </ul>
        </li>
        <c:forEach items="${products}" var="p">
        <div class="span4">
            <h3>${p.name}</h3>
            <p><img height="140" width="140" src=./images/${p.id} class="img-polaroid" /></p>
            <p>${p.cat_id}</p>
            <p>${p.description}</p>
            <p>${p.price} грн</p>
            <p><a class="btn" href="./basket/${p.id}">В корзину &raquo;</a></p></div>

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
