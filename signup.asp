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
    If(NOT isnull(username) AND NOT isnull(name) AND NOT isnull(password) AND NOT isnull(passRepeat) AND NOT isnull(address) AND NOT isnull(phone) AND  NOT isnull(email) AND  TRIM(username)<>"" AND  TRIM(name)<>"" AND TRIM(password)<>"" AND  TRIM(passRepeat)<>"" AND TRIM(address)<>"" AND  TRIM(phone)<>"" AND TRIM(email)<>"")Then
        Dim sql
        sql = "select COUNT(*) as count from Customers where email =? or username =?"
        Dim cmdPrep
        set cmdPrep = Server.CreateObject("ADODB.Command")
        connDB.Open()
        cmdPrep.ActiveConnection = connDB
        cmdPrep.CommandType=1
        cmdPrep.Prepared=true
        cmdPrep.CommandText = sql
        cmdPrep.Parameters(0)=email
        cmdPrep.Parameters(1)=username
        Dim result
        set result = cmdPrep.execute
        If result("count") > 0 Then 
            Session("Error")= "Email or username already exists. Please choose another login email or username."
        Else 
            cmdPrep.CommandText = "INSERT INTO Customers (Name,Address,Phone,Email,Username,Password) VALUES(?,?,?,?,?,?)"
            cmdPrep.parameters.Append cmdPrep.createParameter("name",202,1,255,name)
            cmdPrep.parameters.Append cmdPrep.createParameter("address",202,1,255,address)
            cmdPrep.parameters.Append cmdPrep.createParameter("phone",202,1,255,phone)
            cmdPrep.parameters.Append cmdPrep.createParameter("email",129,1,255,email)
            cmdPrep.parameters.Append cmdPrep.createParameter("username",202,1,255,username)
            cmdPrep.parameters.Append cmdPrep.createParameter("password",202,1,255,password)
            cmdPrep.execute
            Session("Success") = "Create account succesful"
            Response.redirect("login.asp")                
        END if
    End if
%>


<!-- #include file="./layout/header.asp" -->

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
<section class="vh-100" style="background-color: #eee;">
    <div class="container h-100">
      <div class="row d-flex justify-content-center align-items-center h-100">
        <div class="col-lg-12 col-xl-11">
          <div class="card text-black" style="border-radius: 25px;">
            <div class="card-body p-md-5">
              <div class="row justify-content-center">
                <div class="col-md-10 col-lg-6 col-xl-5 order-2 order-lg-1">
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
                  <p class="text-center h1 fw-bold mb-5 mx-1 mx-md-4 mt-4">Sign up</p>
  
                  <form class="mx-1 mx-md-4" method="Post" action="signup.asp">
  
                    <div class="d-flex flex-row align-items-center mb-4">
                      <i class="fas fa-user fa-lg me-3 fa-fw"></i>
                      <div class="form-outline flex-fill mb-0">
                        <label class="form-label" for="Name">Your Name</label>
                        <input type="text" id="Name" name="name" class="form-control" />
                      </div>
                    </div>

                    <div class="d-flex flex-row align-items-center mb-4">
                      <i class="fas fa-user fa-lg me-3 fa-fw"></i>
                      <div class="form-outline flex-fill mb-0">
                        <label class="form-label" for="UserName">Your UserName</label>
                        <input type="text" id="UserName" name="username" class="form-control" />
                      </div>
                    </div>
  
                    <div class="d-flex flex-row align-items-center mb-4">
                      <i class="fas fa-envelope fa-lg me-3 fa-fw"></i>
                      <div class="form-outline flex-fill mb-0">
                        <label class="form-label" for="Address">Address</label>
                        <input type="text" id="Address" name="address" class="form-control" />
                      </div>
                    </div>

                    <div class="d-flex flex-row align-items-center mb-4">
                      <i class="fas fa-envelope fa-lg me-3 fa-fw"></i>
                      <div class="form-outline flex-fill mb-0">
                        <label class="form-label" for="Phone">Phone</label>
                        <input type="tel" id="Phone" name="phone" pattern="[0-9]{3}-[0-9]{2}-[0-9]{3}" class="form-control" />
                      </div>
                    </div>

                    <div class="d-flex flex-row align-items-center mb-4">
                      <i class="fas fa-envelope fa-lg me-3 fa-fw"></i>
                      <div class="form-outline flex-fill mb-0">
                        <label class="form-label" for="Email">Your Email</label>
                        <input type="email" id="Email" name ="email" class="form-control" />
                      </div>
                    </div>

                    <div class="d-flex flex-row align-items-center mb-4">
                      <i class="fas fa-lock fa-lg me-3 fa-fw"></i>
                      <div class="form-outline flex-fill mb-0">
                        <label class="form-label" for="Password">Password</label>
                        <input type="password" id="Password" name="password" class="form-control" />
                      </div>
                    </div>
  
                    <div class="d-flex flex-row align-items-center mb-4">
                      <i class="fas fa-key fa-lg me-3 fa-fw"></i>
                      <div class="form-outline flex-fill mb-0">
                        <label class="form-label" for="PassRepeat">Repeat your password</label>
                        <input type="password" id="PassRepeat" name="passRepeat" class="form-control" />
                      </div>
                    </div>
  
                    <div class="d-flex flex-row align-items-center mb-4">
                      <input class="ml-2" type="checkbox" value="" id="form2Example3c" />
                      <label class="form-check-label" for="form2Example3" style="margin-left: 45px;">
                        I agree all statements in <a href="#!">Terms of service</a>
                      </label>
                    </div>
  
                    <div class="d-flex justify-content-center mx-4 mb-3 mb-lg-4">
                      <button class="btn btn-primary btn-lg" type="submit">Register</button>
                    </div>
  
                  </form>
  
                </div>
                <div class="col-md-10 col-lg-6 col-xl-7 d-flex align-items-center order-1 order-lg-2">
  
                  <img src="https://mdbcdn.b-cdn.net/img/Photos/new-templates/bootstrap-registration/draw1.webp"
                    class="img-fluid" alt="Sample image">
  
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
  </section>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>  
<script>
    window.setTimeout(function() {
    $(".alert").fadeTo(500, 0).slideUp(500, function(){
        $(this).remove(); 
    });
}, 2000);
</script>