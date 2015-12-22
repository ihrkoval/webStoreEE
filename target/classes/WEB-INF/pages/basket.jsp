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
          <a class="btn btn-small btn-primary" href="<c:url value="/basket" />" role="button">кабинет</a>
          <a class="btn btn-mini btn-danger" href="<c:url value="/logout" />" role="button">Выйти</a>
          <sec:authorize access="hasRole('ADMIN')">
            <a class="btn btn-inverse" href="<c:url value="/orders" />" role="button">Админка</a>
          </sec:authorize>
          </p>
          </form>

        </sec:authorize>




      </div><!--/.nav-collapse -->
    </div>
  </div>
</div>

<div class="container">
  <div class="span6">
  <h3>В корзине:</h3>
  <table class="table table-bordered">
    <thead>



    <tr>
      <td><b>ID</b></td>
      <td><b>фото</b></td>
      <td><b>Название</b></td>
      <td><b>Цена</b></td>
      <td><b>удалить</b></td>
    </tr>

    </thead>
    <tr>

    </tr>
    <c:forEach items="${products}" var="product">
      <tr>
        <td>${product.id}</td>
        <td><img height="140" width="140" src="images/${product.id}" /></td>
        <td>${product.name}</td>
        <td>${product.price}</td>
        <td><a href="/basket/delete/p/${product.id}">Delete</a></td>
      </tr>
    </c:forEach>

    <tr>
      <td>.</td>
      <td>.</td>
<c:choose>
  <c:when test="${orders.id ne null}">
      <td><a href="/basket/delete/${orders.id}">Delete</a></td>
      <td><b>${orders.price}</b></td>
      <td><a class="btn" href="./basket/confirm/">Подтвердить</a></td>
</c:when>
  </c:choose>
    </tr>
    </table>

    </div>

    <div class="span4">
      <h2>История заказов</h2>
      <table class="table table-bordered">
      <tr>
        <td><b>ID</b></td>
        <td><b>Заказ</b></td>
        <td><b>Цена</b></td>
      </tr>
      <c:forEach items="${history}" var="order">
        <tr>
          <td>${order.id}</td>
          <td>${order.name}</td>
          <td>${order.price}</td>
        </tr>
      </c:forEach>

  </table>
    </div>


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
