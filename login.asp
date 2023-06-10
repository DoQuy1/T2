<!--#include file="connect.asp"-->
<%
    Dim userNameOrEmail, password
    
    userNameOrEmail = Request.Form("userNameOrEmail")
    password = Request.Form("password")
    If(NOT isnull(userNameOrEmail) AND NOT isnull(password) AND TRIM(userNameOrEmail)<>"" AND TRIM(password)<>"" )Then
            Dim sql
            Dim cmdPrep
            set cmdPrep = Server.CreateObject("ADODB.Command")
            connDB.Open()
            cmdPrep.ActiveConnection = connDB
            cmdPrep.CommandType=1
            cmdPrep.Prepared=true
            Dim result
        If InStr(userNameOrEmail,"@") >0 Then
            sql = "select * from Customers where email = ? and password = ?"
            cmdPrep.CommandText = sql
            cmdPrep.Parameters(0)=userNameOrEmail
            cmdPrep.Parameters(1)=password
            set result = cmdPrep.execute()
            If not result.EOF Then
                Session("CustomerID") = result("CustomerID")
                Session("Success")="Login Successfully"
                Response.redirect("index.asp")
            Else
            ' dang nhap ko thanh cong
            Session("Error") = "Wrong email or password"
            End if
            result.Close()
            connDB.Close()
        Else
            sql = "select * from Customers where username = ? and password = ?"
            cmdPrep.CommandText = sql
            cmdPrep.Parameters(0)=userNameOrEmail
            cmdPrep.Parameters(1)=password
            set result = cmdPrep.execute()
            If not result.EOF Then
                Session("CustomerID") = result("CustomerID")
                Session("Success")="Login Successfully"
                Response.redirect("index.asp")
            Else
            Session("Error") = "Wrong username or password"
            End if
            result.Close()
            connDB.Close()
        End If
    ' Else
    '     ' false
    '     Session("Error")="Please input email or username and password."
    End if

%>



<link rel="stylesheet" href="./css/login.css">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
<section class="h-100 gradient-form" style="background-color: #eee;">
    <div class="container py-5 h-100">
      <div class="row d-flex justify-content-center align-items-center h-100">
        <div class="col-xl-10">
          <div class="card rounded-3 text-black">
            <div class="row g-0">
              <div class="col-lg-6">
                <div class="card-body p-md-5 mx-md-4">
  
                  <div class="text-center">
                    <img src="https://mdbcdn.b-cdn.net/img/Photos/new-templates/bootstrap-login-form/lotus.webp"
                      style="width: 185px;" alt="logo">
                    <h4 class="mt-1 mb-5 pb-1">We are The Lotus Team</h4>
                  </div>
  
                  <form method="post" action="login.asp">
                    <p>Please login to your account</p>
                    <div class="form-outline mb-4">
                      <label class="form-label" for="form2Example11" >Email</label>
                      <input type="text" id="form2Example11" class="form-control"
                        placeholder="Email or UserName" name="userNameOrEmail">
                    </div>
  
                    <div class="form-outline mb-4">
                      <label class="form-label" for="form2Example22">Password</label>
                      <input type="password" id="form2Example22" class="form-control"
                      placeholder="Password" name="password">
                    </div>
  
                    <div class="text-center pt-1 mb-5 pb-1">
                      <button class="btn btn-primary btn-block fa-lg gradient-custom-2 mb-3" type="submit" style="width: 100%;">Log
                        in</button>
                      <a class="text-muted" href="#!">Forgot password?</a>
                    </div>
  
                    <div class="d-flex align-items-center justify-content-center pb-4">
                      <p class="mb-0 me-2">Don't have an account?</p>
                      <button type="button" class="btn btn-outline-danger" onclick="location.href='http://localhost:86/signup.asp'">Create new</button>
                    </div>
  
                  </form>
  
                </div>
              </div>
              <div class="col-lg-6 d-flex align-items-center gradient-custom-2">
                <div class="text-white px-3 py-4 p-md-5 mx-md-4">
                  <h4 class="mb-4">We are more than just a company</h4>
                  <p class="small mb-0">Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod
                    tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud
                    exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.</p>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
  </section>