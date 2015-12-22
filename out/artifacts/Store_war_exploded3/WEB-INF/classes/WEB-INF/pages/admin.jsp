<%@ page import="store.Product" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Arrays" %>
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
<sec:authorize access="hasRole('ADMIN')">
<div class="container">
  <h3>Добавить товар</h3>
  <div class="container">


    <form role="form" enctype="multipart/form-data" class="form-horizontal" action="/addProduct" method="post">
      <h2 class="form-signin-heading"></h2>
      <div class="form-group"><input type="text" class="input-block-level" name="name" placeholder="Название"></div>
      <div class="form-group"><input type="text" class="input-block-level" name="category" placeholder="Категория"></div>
      <div class="form-group"><input type="text" class="input-block-level" name="price" placeholder="Цена"></div>
      <div class="form-group"><input type="text" class="input-block-level" name="desc" placeholder="описание"></div>
      <div class="form-group">Photo: <input type="file" name="photo"></div>

      <div class="form-group"><input type="submit" class="btn btn-large btn-primary" value="add"></div>
    </form>

    <div class="row-fluid">
      <div class="span4"><a href="/"><h5>На главную </h5></a></div>
      <div class="span4">
        <li class="dropdown">
        <a href="#" class="dropdown-toggle" data-toggle="dropdown"><h5>Категории</h5> <b class="caret"></b></a>
        <ul class="dropdown-menu">
          <li><a href="./admin">Все</a></li>
          <% ArrayList<Product> products = (ArrayList<Product>)request.getAttribute("product");
            String[] cats = new String[products.size()];
            int count = 0;
            for (Product p : products){
              cats[count] = p.getDescription();
              count+=1;
            }
            count = 0;
            Arrays.sort(cats);
            ArrayList<String> noMatches = new ArrayList<String>(Arrays.asList(cats));
            for (int i = 0; i < noMatches.size()-1 ; i++) {
              String tmp = noMatches.get(i);
              if (tmp.equals(noMatches.get(i+1))){
                noMatches.remove(i+1);
              }
            }
            request.setAttribute("cats", noMatches);

          %>
          <c:forEach items="${cats}" var="c">

            <li><a href="admin?sort=${c}">${c}</a></li>


          </c:forEach>
        </ul>
      </li></div>
    </div>





  </div>
  <h3>Список товаров</h3>

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
        <td><img height="140" width="140" src="images/${prods.id}" /></td> >
        <td>${prods.name}</td> >
        <td>${prods.cat_id}</td> >
        <td>${prods.description}</td>
        <td>${prods.price}</td>
        <td><a href="/redact/${prods.id}">Редактировать</a></td>
        <td><a href="/delete?id=${prods.id}">Delete</a></td>
      </tr>
    </c:forEach>
  </table>
</div> <!-- /container -->
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