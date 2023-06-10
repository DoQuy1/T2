<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<!--#include file="connect.asp"-->

<%
    ' code here to retrive the data from product table
    Dim idCustomer
    idCustomer = Request.QueryString("id")
    If (NOT IsNull(idCustomer) and idCustomer <> "") Then
        Dim cmdPrep, Result
        Set cmdPrep = Server.CreateObject("ADODB.Command")
            connDB.Open()
            cmdPrep.ActiveConnection = connDB
            cmdPrep.CommandType = 1
            cmdPrep.CommandText = "SELECT * FROM Customers WHERE CustomerID=?"
            cmdPrep.Parameters(0)=idCustomer
            Set Result = cmdPrep.execute      
            Set cmdPrep = Nothing
    End if    
%>
<%
    Dim username,name,password,address,phone,email
    username = Request.Form("username")
    name = Request.Form("name")
    password = Request.Form("password")
    address = Request.Form("address")
    phone = Request.Form("phone_number")
    email = Request.Form("email")
    If(NOT isnull(username) AND NOT isnull(name) AND NOT isnull(password) AND NOT isnull(address) AND NOT isnull(phone) AND  NOT isnull(email) AND  TRIM(username)<>"" AND  TRIM(name)<>"" AND TRIM(password)<>""  AND TRIM(address)<>"" AND  TRIM(phone)<>"" AND TRIM(email)<>"")Then
        Dim sql
        sql = "select COUNT(*) as count from Customers where email =? or username =?"
        set cmdPrep = Server.CreateObject("ADODB.Command")
        cmdPrep.ActiveConnection = connDB
        cmdPrep.CommandType=1
        cmdPrep.Prepared=true
        cmdPrep.CommandText = sql
        cmdPrep.Parameters(0)=email
        cmdPrep.Parameters(1)=username
        Dim rs
        set rs = cmdPrep.execute
        If rs("count") = 1 Then 
            cmdPrep.CommandText = "Update Customers SET Name=?,Address=?,Phone=?,Email=?,Username=?,Password=? Where CustomerID="&idCustomer&" "
            cmdPrep.parameters(0)=name
            cmdPrep.parameters(1)=address
            cmdPrep.parameters(2)=phone
            cmdPrep.parameters(3)=email
            cmdPrep.parameters(4)=username
            cmdPrep.parameters(5)=password
            cmdPrep.execute
            Dim currentURL
            currentURL = Request.ServerVariables("SCRIPT_NAME") & "?" & Request.ServerVariables("QUERY_STRING")
            Session("Success") = "Edit profile account succesful"             
        Else 
            Session("Error")= "Email or username already exists. Please choose another login email or username."
        END if
            Response.Redirect(currentURL)  
    End if
%>

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
          <input type="hidden" id="error" value="<%=Session("Error")%>">
<%
          Session.Contents.Remove("Error")
    End If
%>




<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ENjdO4Dr2bkBIFxQpeoTz1HIcje39Wm4jDKdf19U8gI4ddQ3GYNS7NTKfAdVQSZe" crossorigin="anonymous"></script>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-KK94CHFLLe+nY2dmCWGMq91rCGa5gtU4mk92HdvYe+M/SXH301p5ILy+dN9+nJOZ" crossorigin="anonymous">
<link rel="stylesheet" href="/css/user.css">
<div class="container rounded bg-white mt-5 mb-5">
  <div class="row ">
      <div class="col-md-3 border-right card">
          <div class="d-flex flex-column align-items-center text-center p-3 py-5"><img class="rounded-circle mt-5" width="150px" src="https://st3.depositphotos.com/15648834/17930/v/600/depositphotos_179308454-stock-illustration-unknown-person-silhouette-glasses-profile.jpg"><span class="font-weight-bold"><%=Result("Name")%></span><span class="text-black-50"><%=Result("Email")%></span><span> </span></div>
      </div>
      <div class="col-md-7 border-right card">
          <div class="p-3 py-5">
              <div class="d-flex justify-content-between align-items-center mb-3">
                  <h4 class="text-right">Profile Settings</h4>
              </div>
              <form action="" id="edituser" method="post">
                <div class="row mt-2">
                    <div class="col-md-12"><label class="labels">Name</label><input type="text" class="form-control" name="name" id="name" placeholder="name" value="<%=Result("Name")%>" disabled></div>
                </div>
                <div class="row mt-3">
                    <div class="col-md-12 mb-2"><label class="labels">Mobile Number</label><input type="text" name="phone_number" id="phone_number"class="form-control" placeholder="enter phone number" value="<%=Result("Phone")%>" disabled></div>
                    <div class="col-md-12 mb-2"><label class="labels">Address </label><input type="text" name="address" id="address" class="form-control" placeholder="enter address" value="<%=Result("Address")%>"disabled></div>
                    <div class="col-md-12 mb-2"><label class="labels">Email ID</label><input type="text" name="email" id="email" class="form-control" placeholder="enter email id" value="<%=Result("Email")%>"disabled></div>
                    <div class="col-md-12 mb-2"><label class="labels">Username</label><input type="text" name="username" id="username" class="form-control" placeholder="enter username" value="<%=Result("Username")%>"disabled></div>
                    <div class="col-md-12 mb-2"><label class="labels">Password</label><input type="password" name="password" id="password" class="form-control" placeholder="enter password" value="<%=Result("Password")%>"disabled></div>
                </div>
              </form>
              <div class="mt-5 text-center"><button id="saveButton" class="btn border px-3 p-1 add-experience" type="submit" form="edituser" hidden>Save Profile</button></div>
          </div>
      </div>
      <div class="col-md-1">
          <div class="p-3 py-5">
              <div class="d-flex justify-content-center align-items-center experience"><button id="editButton"class="btn border px-3 p-1 add-experience" type="button">Edit</button></div><br>
          </div>
      </div>
  </div>
</div>
</div>
</div>

<script>
  $(document).ready(function() {
    $("#editButton").click(function() {
      $("#name, #phone_number,#address,#email,#username,#password").prop("disabled", false);
      $("#saveButton").prop("hidden",false);
    });
  });
  $(document).ready(function() {
    $("#saveButton").click(function() {
       $("#edituser").submit();
    });
  });
  $(document).ready(function() {
        var inputValue = $("#error").val(); // Lấy giá trị của ô input
        if (inputValue) {
            $("#name, #phone_number,#address,#email,#username,#password").prop("disabled", false);
        }
    });



    window.setTimeout(function() {
    $(".alert").fadeTo(500, 0).slideUp(500, function(){
        $(this).remove(); 
    });
}, 2000);
  </script>