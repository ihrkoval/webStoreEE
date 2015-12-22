<%@ page import="store.db.Product" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.Collections" %>
<%@ page import="java.util.Iterator" %>
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
      </tr>
      </thead>
    </table>

    <div class="span4">
      <h3>Добавить товар</h3>


      <form role="form" enctype="multipart/form-data" class="form-horizontal" action="/addProduct" method="post">
        <h2 class="form-signin-heading"></h2>
        <div class="form-group"><input type="text" class="input-block-level" name="name" placeholder="Название"></div>
        <div class="form-group"><input type="text" class="input-block-level" name="category" placeholder="Категория"></div>
        <div class="form-group"><input type="text" class="input-block-level" name="price" placeholder="Цена"></div>
        <div class="form-group"><input type="text" class="input-block-level" name="desc" rows="3" placeholder="описание"></div>
        <div class="form-group">Photo: <input type="file" name="photo"></div>

        <div class="form-group"><input type="submit" class="btn btn-large btn-primary" value="add"></div>
      </form>
    </div>



  </div>



  <li class="dropdown">
    <a href="#" class="dropdown-toggle" data-toggle="dropdown"><h2>категории</h2><b class="caret"></b></a>
    <ul class="dropdown-menu">
      <li><a href="/orders">Все</a></li>
      <% ArrayList<Product> products = (ArrayList<Product>)request.getAttribute("product");
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
        for (int i = 0; i < cats.size()-1 ; i++) {
          tmp = cats.get(i);
          if (tmp != null && tmp.equals(cats.get(i+1))){
            cats.remove(i+1);
          }
        }
        request.setAttribute("cats", cats);

      %>
      <c:forEach items="${cats}" var="c">

        <li><a href="./${c}">${c}</a></li>


      </c:forEach>
    </ul>
  </li>

  <table class="table table-striped">
    <thead>
    <tr>
      <td><b>ID</b></td>
      <td><b>фото</b></td>
      <td><b>Название</b></td>
      <td><b>Категория</b></td>
      <td><b>Описание</b></td>
      <td><b>Цена</b></td>
      <td><b>удалить</b></td>
    </tr>
    </thead>
    <tr>

    </tr>
    <c:forEach items="${product}" var="prods">
      <tr>
        <td>${prods.id}</td>
        <td><img height="140" width="140" src="./images/${prods.id}" /></td> >
        <td>${prods.name}</td> >
        <td>${prods.cat_id}</td> >
        <td>${prods.description}</td>
        <td>${prods.price}</td>
        <td><a href="/redact/${prods.id}">Редактировать</a></td>
        <td><a href="/delete?id=${prods.id}">Delete</a></td>
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
