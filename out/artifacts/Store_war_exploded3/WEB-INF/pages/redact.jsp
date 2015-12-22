<%@ page import="store.Product" %>
<%--
  Created by IntelliJ IDEA.
  User: Anton
  Date: 04.12.2015
  Time: 13:18
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
  <title>Update</title>
  <link rel="stylesheet" href="./bootstrap/css/bootstrap.min.css">
  <script src="./bootstrap/js/bootstrap.min.js"></script>
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <meta name="description" content="">
  <meta name="author" content="">

  <!-- Le styles -->
  <link href="http://getbootstrap.com/2.3.2/assets/css/bootstrap.css" rel="stylesheet">
  <style type="text/css">
    body {
      padding-top: 40px;
      padding-bottom: 40px;
      background-color: #f5f5f5;
    }

    .form-signin {
      max-width: 300px;
      padding: 19px 29px 29px;
      margin: 0 auto 20px;
      background-color: #fff;
      border: 1px solid #e5e5e5;
      -webkit-border-radius: 5px;
      -moz-border-radius: 5px;
      border-radius: 5px;
      -webkit-box-shadow: 0 1px 2px rgba(0,0,0,.05);
      -moz-box-shadow: 0 1px 2px rgba(0,0,0,.05);
      box-shadow: 0 1px 2px rgba(0,0,0,.05);
    }
    .form-signin .form-signin-heading,
    .form-signin .checkbox {
      margin-bottom: 10px;
    }
    .form-signin input[type="text"],
    .form-signin input[type="password"] {
      font-size: 16px;
      height: auto;
      margin-bottom: 15px;
      padding: 7px 9px;
    }

  </style>
  <link href="http://getbootstrap.com/2.3.2/assets/css/bootstrap-responsive.css" rel="stylesheet">
</head>
<body>
<div class="container">



  <form role="form" enctype="multipart/form-data" class="form-signin" action="/update?id=${p.id}" method="post">
    <h2 class="form-signin-heading">Update</h2>

      <div class="form-group"><input type="text" class="input-block-level" name="name" placeholder="${p.name}"></div>
      <div class="form-group"><input type="text" class="input-block-level" name="cat" placeholder="${p.cat_id}"></div>
      <div class="form-group"><input type="text" class="input-block-level" name="desc" placeholder="${p.description}"></div>
      <div class="form-group"><input type="text" class="input-block-level" name="price" placeholder="${p.price}"></div>

      <div class="form-group">Photo: <input type="file" name="photo"></div>
      <div class="form-group"><img height="140" width="140" src="../images/${p.id}" /></div>

      <div class="form-group"><input type="submit" class="btn btn-large btn-primary" value="Изменить"></div>
  </form>
</div>




</body>
</html>