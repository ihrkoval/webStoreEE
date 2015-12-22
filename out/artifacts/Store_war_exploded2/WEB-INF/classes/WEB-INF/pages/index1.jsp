<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
  <title>MyShop</title>
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.1/css/bootstrap.min.css">
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.1/js/bootstrap.min.js"></script>
</head>
<body>
<div class="container">
  <h3>Advertisements List</h3>
  <a href="/reg">Регистрация</a>

  <form class="form-inline" role="form" action="/search" method="post">
    <input type="text" class="form-control" name="pattern" placeholder="Search">
    <input type="submit" class="btn btn-default" value="Search">
  </form>

  <table class="table table-striped">
    <thead>
    <tr>
      <td><b>Photo</b></td>
      <td><b>Name</b></td>
      <td><b>Short Desc</b></td>
      <td><b>Long Desc</b></td>
      <td><b>Phone</b></td>
      <td><b>Price</b></td>
      <td><b>Action</b></td>
    </tr>
    </thead>
    <c:forEach items="${products}" var="prod">
      <tr>
        <td><img height="40" width="40" src="/SpringMVC_war_exploded/image/${prod.photo.id}" /></td>
        <td>${prod.name}</td>
        <td>${prod.cat_id}</td>
        <td>${prod.price}</td>
        <td>${prod.photo}</td>
        <td>${prod.description}</td>
        <td><a href="/SpringMVC_war_exploded/delete?id=${prod.id}">Delete</a></td>
      </tr>
    </c:forEach>
  </table>

  <form class="form-inline" role="form" action="/SpringMVC_war_exploded/add_page" method="post">
    <input type="submit" class="btn btn-default" value="Add new">
  </form>
</div>
</body>
</html>