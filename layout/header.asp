<!DOCTYPE html>
<html lang="en">
   <head>
      <!-- basic -->
      <meta charset="utf-8">
      <meta http-equiv="X-UA-Compatible" content="IE=edge">
      <meta name="viewport" content="width=device-width, initial-scale=1">
      <!-- mobile metas -->
      <meta name="viewport" content="width=device-width, initial-scale=1">
      <meta name="viewport" content="initial-scale=1, maximum-scale=1">
      <!-- site metas -->
      <title>Web Tai Nghe</title>
      <!-- bootstrap css -->
      <link rel="stylesheet" type="text/css" href="./css/bootstrap.min.css">
      <!-- style css -->
      <link rel="stylesheet" type="text/css" href="./css/style.css">
      <!-- Responsive-->
      <link rel="stylesheet" href="./css/responsive.css">
      <!-- fevicon -->
      <link rel="icon" href="images/fevicon.png" type="image/gif" />
      <!-- font awesome -->
        <script src="https://kit.fontawesome.com/9f795c2c0d.js" crossorigin="anonymous"></script>
      <!-- owl stylesheets -->
      <script src="./ckeditor/ckeditor.js"></script>
      <link href="https://fonts.googleapis.com/css?family=Great+Vibes|Poppins:400,700&display=swap&subset=latin-ext" rel="stylesheet">
      <link rel="stylesheet" href="./css/owl.carousel.min.css">
      <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/fancybox/2.1.5/jquery.fancybox.min.css" media="screen">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
   </head>
<body>
<%
               If (NOT isnull(Session("Success"))) AND (TRIM(Session("Success"))<>"") Then
            %>
                     <div class="alert alert-success" role="alert">
                        <%=Session("Success")%>
                     </div>
            <%
                     Session.Contents.Remove("Success")
               End If
            %>
            <%
               If (NOT isnull(Session("Error"))) AND (TRIM(Session("Error"))<>"") Then
            %>
                     <div class="alert alert-danger" role="alert">
                        <%=Session("Error")%>
                     </div>
            <%
                     Session.Contents.Remove("Error")
               End If
            %>