<%--
  Created by IntelliJ IDEA.
  User: Anton
  Date: 20.12.2015
  Time: 13:42
  To change this template use File | Settings | File Templates.
--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<html>
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
<head>
  <title></title>
</head>
<body>

<sec:authorize access="hasRole('ADMIN')">
  <div class="container">
    <table class="table table-striped">
      <thead>
      <tr>
        <td><b><a href="/">На главную </a></b></td>

        <td><b><a href="/orders">Заказы  (${users.size()})</a></b></td>
        <td><b><a href="/product">Товары</a></b></td>
        <td><b><a href="/users">Пользователи</a></b></td>
        <td><b>Цена</b></td>
        <td><b>удалить</b></td>
      </tr>
      </thead>
    </table>

    <table class="table table-striped">
      <thead>
      <tr>
        <td><b>ID</b></td>
        <td><b>ИМЯ</b></td>
        <td><b>ФАМИЛИЯ</b></td>
        <td><b>ПОЧТА</b></td>
        <td><b>ТЕЛЕФОН</b></td>
        <td><b>РЕДАКТИРОВАТЬ</b></td>
      </tr>
      </thead>
      <tr>

      </tr>
      <c:forEach items="${users}" var="u">
        <tr>
          <td>${u.id}</td>
          <td>${u.name}</td>
          <td>${u.surname}</td>
          <td>${u.email}</td>
          <td>${u.phone}</td>
          <td><a href="/asdf/${prods.id}">Редактировать</a></td>
          <td><a href="/asfd?id=${prods.id}">Delete</a></td>
        </tr>
      </c:forEach>
    </table>


  </div>




</sec:authorize>
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
