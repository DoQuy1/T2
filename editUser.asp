<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<!--#include file="connect.asp"-->
<%
    Dim username,name,password,passRepeat,address,phone,email
    username = Request.Form("username")
    name = Request.Form("name")
    password = Request.Form("password")
    passRepeat = Request.Form("passRepeat")
    address = Request.Form("address")
    phone = Request.Form("phone")
    email = Request.Form("email")
    userId= Request.QueryString("id")

    connDB.Open()
    If (NOT IsNull(userId) and userId <> "") Then
        Dim cmdPrepUser, ResultUser
        Set cmdPrepUser = Server.CreateObject("ADODB.Command")
            cmdPrepUser.ActiveConnection = connDB
            cmdPrepUser.CommandType = 1
            cmdPrepUser.CommandText = "SELECT * FROM Customers WHERE CustomerID=?"
            cmdPrepUser.Parameters(0)=userId
            Set ResultUser = cmdPrepUser.execute      
            Set cmdPrepUser = Nothing
    End if    

    If(NOT isnull(username) AND NOT isnull(name) AND NOT isnull(password) AND NOT isnull(address) AND NOT isnull(phone) AND  NOT isnull(email) AND  TRIM(username)<>"" AND  TRIM(name)<>"" AND TRIM(password)<>"" AND TRIM(address)<>"" AND  TRIM(phone)<>"" AND TRIM(email)<>"")Then
        Dim sql
        sql = "select COUNT(*) as count from Customers where email =? or username =?"
        Dim cmdPrep
        set cmdPrep = Server.CreateObject("ADODB.Command")
        cmdPrep.ActiveConnection = connDB
        cmdPrep.CommandType=1
        cmdPrep.Prepared=true
        cmdPrep.CommandText = sql
        cmdPrep.Parameters(0)=email
        cmdPrep.Parameters(1)=username
        Dim result
        set result = cmdPrep.execute
        If result("count") = 1 Then 
            
            if(cstr(password)=cstr(passRepeat))then
            cmdPrep.CommandText = "Update Customers SET Name=?,Address=?,Phone=?,Email=?,Username=?,Password=? Where CustomerID="&userId&""
            cmdPrep.parameters.Append cmdPrep.createParameter("name",202,1,255,name)
            cmdPrep.parameters.Append cmdPrep.createParameter("address",202,1,255,address)
            cmdPrep.parameters.Append cmdPrep.createParameter("phone",202,1,255,phone)
            cmdPrep.parameters.Append cmdPrep.createParameter("email",129,1,255,email)
            cmdPrep.parameters.Append cmdPrep.createParameter("username",202,1,255,username)
            cmdPrep.parameters.Append cmdPrep.createParameter("password",202,1,255,password)
            cmdPrep.execute
            Session("Success") = "Edit user account succesful"
            Response.redirect("userManagement.asp")
            Else
            Session("Error") = "Passwords do not match"   
            End if  
        Else        
        Session("Error")= "Email or username already exists. Please choose another login email or username."
        END if
    Else
        If (Request.ServerVariables("REQUEST_METHOD") = "POST") THEN
        Session("Error")="Something is empty. Please fill in all the information in the input boxes."
        End if
    End if
%>



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
      <title>Edit User</title>
      <!-- bootstrap css -->
      <!-- font awesome -->
        <script src="https://kit.fontawesome.com/9f795c2c0d.js" crossorigin="anonymous"></script>
      <!-- owl stylesheets -->
      <script src='https://kit.fontawesome.com/a076d05399.js' crossorigin='anonymous'></script>
      <link href="https://fonts.googleapis.com/css?family=Great+Vibes|Poppins:400,700&display=swap&subset=latin-ext" rel="stylesheet">
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
    <div class="container mt-4">
            <section class="content-header">
                    <div class="container-fluid">
                        <div class="row mb-2">
                                <div class="col-sm-6">
                                    <h1>Edit user</h1>
                                </div>
                                <div class="col-sm-6">
                                    <ol class="breadcrumb float-sm-right">
                                        <li class="breadcrumb-item"><a href="index.asp">Home</a></li>
                                        <li class="breadcrumb-item active">Edit user</li>
                                    </ol>
                                </div>
                        </div>
                    </div>
                </section>
        </div>

        <div class="container">
            <form method="post">
                <div class="mb-3">
                    <label class="form-label" for="Name">Your Name</label>
                    <input value="<%=ResultUser("Name")%>" type="text" id="Name" name="name" class="form-control" />
                </div>
                <div class="mb-3">
                    <label class="form-label" for="UserName">Your UserName</label>
                    <input value="<%=ResultUser("Username")%>" type="text" id="UserName" name="username" class="form-control" />
                </div>
                <div class="mb-3">
                    <label class="form-label" for="Address">Address</label>
                    <input value="<%=ResultUser("Address")%>" type="text" id="Address" name="address" class="form-control" />
                </div>
                <div class="mb-3">
                    <label class="form-label" for="Phone">Phone</label>
                    <input value="<%=ResultUser("Phone")%>" type="tel" id="Phone" name="phone"   class="form-control" />
                </div> 
                <div class="mb-3">
                    <label class="form-label" for="Email">Your Email</label>
                    <input value="<%=ResultUser("Email")%>" type="email" id="Email" name ="email" class="form-control" />
                </div> 
                 <div class="mb-3">
                    <label class="form-label" for="Password">Password</label>
                    <input value="<%=ResultUser("Password")%>" type="password" id="Password" name="password" class="form-control" />
                </div> 
                 <div class="mb-3">
                    <label class="form-label" for="PassRepeat">Repeat your password</label>
                    <input value="" type="password" id="PassRepeat" name="passRepeat" class="form-control" />
                </div> 
                <button type="submit" class="btn btn-primary">
                    Edit
                </button>
                <a href="userManagement.asp" class="btn btn-info">Cancel</a>           
            </form>
        </div>
        <script>
        window.setTimeout(function() {
    $(".alert").fadeTo(500, 0).slideUp(500, function(){
        $(this).remove(); 
    });
}, 2000);
        </script>
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.1/dist/js/bootstrap.bundle.min.js" integrity="sha384-/bQdsTh/da6pkI1MST/rWKFNjaCP5gBSY4sEBT38Q/9RBh9AH40zEOg7Hlq2THRZ" crossorigin="anonymous"></script>      
</body>
<html>