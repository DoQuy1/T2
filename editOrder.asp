<!-- #include file="connect.asp" -->
<%
     function check(cond, ret) 
        if cond=true then
            Response.write ret
        else
            Response.write ""
        end if
    end function
    orderId = Request.QueryString("orderId")
    connDB.open()
    If (Request.ServerVariables("REQUEST_METHOD") = "GET") THEN        
        orderId = Request.QueryString("orderId")
        If (cint(orderId)<>0) Then
            Set cmdPrep = Server.CreateObject("ADODB.Command")
            cmdPrep.ActiveConnection = connDB
            cmdPrep.CommandType = 1
            cmdPrep.CommandText = "SELECT * FROM Orders WHERE OrderID=?"
            cmdPrep.Parameters(0)=orderId
            Set Result = cmdPrep.execute 

            OrderCurrUserID=Result("CustomerID")
            Set cmdOrderUserID = Server.CreateObject("ADODB.Command")
            cmdOrderUserID.ActiveConnection = connDB
            cmdOrderUserID.CommandType = 1
            cmdOrderUserID.Prepared = True
            cmdOrderUserID.CommandText = "Select * from Customers where CustomerID = ?"
            cmdOrderUserID.parameters.Append cmdOrderUserID.createParameter("OrderCurrUserID",3,1, ,OrderCurrUserID)
            set UserCurr = cmdOrderUserID.execute

            set PaymentMethodID = Result("PaymentMethodID")
            Set cmdPayment = Server.CreateObject("ADODB.Command")
            cmdPayment.ActiveConnection = connDB
            cmdPayment.CommandType = 1
            cmdPayment.Prepared = True
            cmdPayment.CommandText = "Select * from PaymentMethods where PaymentMethodID = ?"
            cmdPayment.parameters.Append cmdPayment.createParameter("PaymentMethodID",3,1, ,PaymentMethodID)
            set PaymentCurr = cmdPayment.execute
            
            StatusOrderCurr=Result("Status")
        End If
    Else
        PaymentMethod=Request.Form("PaymentMethod")
        StatusOrder=Request.Form("Status")
        ShippingAddress=Request.Form("ShippingAddress")
        if (NOT isnull(PaymentMethod) and PaymentMethod<>"" and NOT isnull(StatusOrder) and StatusOrder<>"" and NOT isnull(ShippingAddress) and ShippingAddress<>"") then
                Set cmdUpdate = Server.CreateObject("ADODB.Command")
                cmdUpdate.ActiveConnection = connDB
                cmdUpdate.CommandType = 1
                cmdUpdate.Prepared = True
                cmdUpdate.CommandText = "UPDATE Orders SET PaymentMethodID=?,Status=?,ShippingAddress=? WHERE OrderID=?"
                cmdUpdate.parameters(0)=PaymentMethod
                cmdUpdate.parameters(1)=StatusOrder
                cmdUpdate.parameters(2)=ShippingAddress
                cmdUpdate.parameters(3)=orderId

                cmdUpdate.execute
                Session("Success") = "The order was edited!"
                Response.redirect("orderManagement.asp") 
            else
                Session("Error") = "You have to input enough info"
            end if
    End if

    


    

    
%>

<!-- #include file="./layout/header.asp" -->
<link href="upload.css" rel="stylesheet" type="text/css" />
        <div class="container mt-4">
            <section class="content-header">
                    <div class="container-fluid">
                        <div class="row mb-2">
                            
                            <div class="col-sm-6">
                                <h1>Edit Order</h1>
                            </div>
                            <div class="col-sm-6">
                                <ol class="breadcrumb float-sm-right">
                                    <li class="breadcrumb-item"><a href="index.asp">Home</a></li>
                                    <li class="breadcrumb-item active">Edit Order</li>
                                </ol>
                            </div>
                            
                        </div>
                    </div>
                </section>
        </div>
        <div class="container mb-5">
            <form method="post">
                <div class="mb-3">
                    <label for="name" class="form-label">Name</label>
                    <input readonly type="text" class="form-control" id="Name" name="Name" value="<%=UserCurr("Name")%>">
                </div>
                <div class="mb-3">
                    <label for="name" class="form-label">Username</label>
                    <input readonly type="text" class="form-control" id="Username" name="Username" value="<%=UserCurr("Username")%>">
                </div>
                <div class="input-group mb-3">
                    <label for="PaymentMethod" class="form-label">PaymentMethod</label>
                    <select class="form-control" id="PaymentMethod" name="PaymentMethod" style="width:100%">
                        <option selected value="<%=PaymentMethodID%>"><%=PaymentCurr("PaymentMethodName")%></option> 
                        <%
                        Set paymentResult = connDB.execute("Select * from PaymentMethods")
                        Do while not paymentResult.EOF
                        %>
                        <option value="<%=paymentResult("PaymentMethodID")%>"><%=paymentResult("PaymentMethodName")%></option>
                        <%
                            paymentResult.MoveNext
                        Loop
                        %>

                    </select>
                </div>
                <div class="mb-3">
                    <label  for="OrderDate" class="form-label">OrderDate</label>
                    <input readonly type="text" class="form-control" id="OrderDate" name="OrderDate" value="<%=Result("OrderDate")%>">
                </div>
                <div class="mb-3">
                    <label for="Status" class="form-label">Status</label>
                    <select class="form-control" id="Status" name="Status" style="width:100%"> 
                        <option value="Order Processed" <%=check(StatusOrderCurr="Order Processed","selected")%>>Order Processed</option> 
                        <option value="Order Shipped" <%=check(StatusOrderCurr="Order Shipped","selected")%>>Order Shipped</option>
                        <option value="Order EnRoute" <%=check(StatusOrderCurr="Order EnRoute","selected")%>>Order EnRoute</option>
                        <option value="Order Arrived" <%=check(StatusOrderCurr="Order Arrived","selected")%>>Order Arrived</option>
                        <option value="Order Arrived" <%=check(StatusOrderCurr="Done","selected")%>>Done</option>
                        <option value="Order Arrived" <%=check(StatusOrderCurr="Huy","selected")%>>Cancel</option>
                    </select>
                </div>
                <div class="mb-3">
                    <label  for="TotalAmount" class="form-label">TotalAmount</label>
                    <input readonly type="text" class="form-control" id="TotalAmount" name="TotalAmount"value="<%=Result("TotalAmount")%>">
                </div> 
                 <div class="mb-3">
                    <label  for="ShippingAddress" class="form-label">ShippingAddress</label>
                    <input  type="text" class="form-control" id="ShippingAddress" name="ShippingAddress"value="<%=Result("ShippingAddress")%>">
                </div> 
                <button tyepe="submit" id="submitbutton" class="btn btn-primary">
                  Edit
                </button>
                    <%
                        connDB.Close()
                    %>
                <a href="index.asp" class="btn btn-info">Cancel</a>           
            </form>
        </div>
      <!-- #include file="./layout/footer.asp" -->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.1/dist/js/bootstrap.bundle.min.js" integrity="sha384-/bQdsTh/da6pkI1MST/rWKFNjaCP5gBSY4sEBT38Q/9RBh9AH40zEOg7Hlq2THRZ" crossorigin="anonymous"></script>
        <script type="text/javascript">
            
	</script>
    </body>
</html>