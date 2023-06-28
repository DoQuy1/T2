<!-- #include file="connect.asp" -->
<%
    If (not IsEmpty(Session("CustomerID")) or not IsEmpty(Session("admin"))) Then
        Dim Result 
        Dim userId 
        if(IsEmpty(Session("admin"))) then
        userId = Session("CustomerID")
        Else
        userId = Session("admin")
        End if
        if CStr(userId)<>"" then
        connDB.Open()
        dim sql
        sql = "Select * from Customers where CustomerID="&userId&""
        Set Result = connDB.execute(sql)
        If not Result.EOF then
            name = Result("Name")
            username = Result("Username")
            email = Result("Email")
            address = Result("Address")
        End If
        connDB.Close()
        Set sql =Nothing
        end if
    Else
        Response.redirect("login.asp")
    End if
    
%>

<%
'lay ve danh sach product theo id trong my cart
Dim idList, payments, totalProduct, subtotal, statusViews, rs,sqlString
If (NOT IsEmpty(Session("payment"))) Then
  statusViews = "d-none"
  statusButtons = "d-block"
' true
	Set payments = Session("payment")
	idList = ""
	totalProduct=payments.Count    
	For Each List In payments.Keys
		If (idList="") Then
' true
			idList = List
		Else
			idList = idList & "," & List
		End if                               
	Next
	sqlString = "Select * from Products where ProductID IN (" & idList &")"
	connDB.Open()
	set rs = connDB.execute(sqlString)
    ' Response.write(totalProduct)

    subtotal=0
    Do While Not rs.EOF
    ' Lấy giá trị từ các trường dữ liệu trong bản ghi hiện tại
    Dim fieldValue1, fieldValue2
    fieldValue1 = rs("ProductID")
    fieldValue2 = rs("Price")
    for Each list In payments.Keys
        if Clng(list) = clng(fieldValue1) Then
        subtotal = subtotal + Clng(payments.Item(list)*CDbl(rs("Price")))
        end if
    Next
    ' Xử lý dữ liệu ở đây (ví dụ: in ra giá trị)
    ' Response.Write "Field 1: " & fieldValue1 & "<br>"
    ' Response.Write "Field 2: " & fieldValue2 & "<br>"
    
    ' Di chuyển đến bản ghi tiếp theo trong Recordset
    rs.MoveNext
    Loop
    rs.MoveFirst
    ' Response.Write(subtotal)

    ' Đóng kết nối và giải phóng đối tượng
    ' rs.Close
    ' Set rs = Nothing
    ' connDB.Close()
  Else
    'Session empty
    statusViews = "d-block"
    statusButtons = "d-none"
    totalProduct=0
    idproduct=Request.QueryString("productId")
    quantityValue= Request.Form("quantity")

	sqlString = "Select * from Products where ProductID="&idproduct&""
	connDB.Open()
	set rs = connDB.execute(sqlString)
    if(quantityValue<>"") then 
    subtotal=subtotal+CDbl(rs("Price"))*Clng(quantityValue)
    Else
    subtotal=subtotal+CDbl(rs("Price"))
    End if
    ' Response.write(totalProduct)
    totalProduct=1

  End If
'   Sub calSubtotal(rs)
' ' Do Something...
' 		subtotal = 0
' 		do while not rs.EOF
' 			subtotal = subtotal + Clng(payments.Item(CStr(rs("ProductID")))) * CDbl(CStr(rs("Price")))
' 			rs.MoveNext
' 		loop
' 	End Sub
%>
<%
    Session("totalAmount")=subtotal
%>



<style>
.container {
  max-width: 960px;
}

.lh-condensed { line-height: 1.25; }
</style>
<!-- #include file="./layout/header.asp" -->
<div class="container">
    <div class="py-5 text-center">
        
        <h2>Checkout form</h2>

    </div>
    <div class="row">
        <div class="col-md-4 order-md-2 mb-4">
            <h4 class="d-flex justify-content-between align-items-center mb-3">
                <span class="text-muted">Your cart</span>
                <span class="badge badge-secondary badge-pill"><%=totalProduct%></span>
            </h4>
            <ul class="list-group mb-3 sticky-top">
                <%
                If (totalProduct<>0) Then
                do while not rs.EOF
                %>
                <li class="list-group-item d-flex justify-content-between lh-condensed">
                    <div>
                        <h6 class="my-0">Product name</h6>
                        <small class="text-muted"><%=rs("ProductName")%></small>
                    </div>
                    <span class="text-muted">$<%=rs("Price")%></span>
                </li>
                <%
                rs.MoveNext
                loop
                End If
                %> 
                <li class="list-group-item d-flex justify-content-between bg-light">
                    <div class="text-success">
                        <h6 class="my-0">Promo code</h6>
                        <small>EXAMPLECODE</small>
                    </div>
                    <span class="text-success">-$5</span>
                </li>
                <li class="list-group-item d-flex justify-content-between">
                    <span>Total (USD)</span>
                    <strong>$<%=subtotal%></strong>
                </li>
                
            </ul>
            <form class="card p-2">
                <div class="input-group">
                    <input type="text" class="form-control" placeholder="Promo code">
                    <div class="input-group-append">
                        <button type="submit" class="btn btn-secondary">Redeem</button>
                    </div>
                </div>
            </form>
        </div>
        <div class="col-md-8 order-md-1">
            
            <h4 class="mb-3">Billing address</h4>
            <form class="needs-validation" novalidate="" action="addOrder.asp" method="post">
                <div class= "mb-3">
                    <label for="Name">Name</label>
                    <input type="text" class="form-control" name="name" id="Name" placeholder="Name" value="<%=name%>" required="">
                    <div class="invalid-feedback"> Valid name is required. </div>
                </div>
                <div class="mb-3">
                    <label for="username">Username</label>
                    <div class="input-group">
                        <div class="input-group-prepend">
                            <span class="input-group-text">@</span>
                        </div>
                        <input type="text" class="form-control" name="username" id="username" placeholder="Username" required="" value="<%=username%>">
                        <div class="invalid-feedback" style="width: 100%;"> Your username is required. </div>
                    </div>
                </div>
                <div class="mb-3">
                    <label for="email">Email <span class="text-muted">(Optional)</span></label>
                    <input type="email" class="form-control" name="email" id="email" placeholder="you@example.com" value="<%=email%>">
                    <div class="invalid-feedback"> Please enter a valid email address for shipping updates. </div>
                </div>
                <div class="mb-3">
                    <label for="address">Address</label>
                    <input type="text" class="form-control" name="address" id="address" placeholder="1234 Main St" required="" value="<%=address%>">
                    <div class="invalid-feedback"> Please enter your shipping address. </div>
                </div>
                <div class="mb-3">
                    <label for="address2">Address 2 <span class="text-muted">(Optional)</span></label>
                    <input type="text" class="form-control" id="address2" placeholder="Apartment or suite">
                </div>
                <!--
                <div class="row">
                    <div class="col-md-5 mb-3">
                        <label for="country">Country</label>
                        <select class="custom-select d-block w-100" id="country" required="">
                            <option value="">Choose...</option>
                            <option>United States</option>
                        </select>
                        <div class="invalid-feedback"> Please select a valid country. </div>
                    </div>
                    <div class="col-md-4 mb-3">
                        <label for="state">State</label>
                        <select class="custom-select d-block w-100" id="state" required="">
                            <option value="">Choose...</option>
                            <option>California</option>
                        </select>
                        <div class="invalid-feedback"> Please provide a valid state. </div>
                    </div>
                    <div class="col-md-3 mb-3">
                        <label for="zip">Zip</label>
                        <input type="text" class="form-control" id="zip" placeholder="" required="">
                        <div class="invalid-feedback"> Zip code required. </div>
                    </div>
                </div>
                -->
                <hr class="mb-4">
                <div class="custom-control custom-checkbox">
                    <input type="checkbox" class="custom-control-input" id="same-address">
                    <label class="custom-control-label" for="same-address">Shipping address is the same as my billing address</label>
                </div>
                <div class="custom-control custom-checkbox">
                    <input type="checkbox" class="custom-control-input" id="save-info">
                    <label class="custom-control-label" for="save-info">Save this information for next time</label>
                </div>
                <hr class="mb-4">
                <h4 class="mb-3">Payment</h4>
                <div class="d-block my-3">
                    <%
                        Dim paymentMethod
                        set paymentMethod = connDB.execute("Select * from PaymentMethods")
                        do while not paymentMethod.EOF
                    %>
                    <div class="custom-control custom-radio">
                        <input id="<%=paymentMethod("PaymentMethodName")%>" value="<%=paymentMethod("PaymentMethodID")%>" name="paymentMethod" type="radio" class="custom-control-input" required="">
                        <label class="custom-control-label" for="<%=paymentMethod("PaymentMethodName")%>"><%=paymentMethod("PaymentMethodName")%></label>
                    </div>
                    <%
                        paymentMethod.MoveNext
                        loop
                    %>
                    <!--<div class="custom-control custom-radio">
                        <input id="debit" name="paymentMethod" type="radio" class="custom-control-input" required="">
                        <label class="custom-control-label" for="debit">Debit card</label>
                    </div>
                    <div class="custom-control custom-radio">
                        <input id="paypal" name="paymentMethod" type="radio" class="custom-control-input" required="">
                        <label class="custom-control-label" for="paypal">PayPal</label>
                    </div>
                    -->
                </div>
                <div class="row">
                    <div class="col-md-6 mb-3">
                        <label for="cc-name">Name on card</label>
                        <input type="text" class="form-control" id="cc-name" placeholder="" required="">
                        <small class="text-muted">Full name as displayed on card</small>
                        <div class="invalid-feedback"> Name on card is required </div>
                    </div>
                    <div class="col-md-6 mb-3">
                        <label for="cc-number">Credit card number</label>
                        <input type="text" class="form-control" id="cc-number" placeholder="" required="">
                        <div class="invalid-feedback"> Credit card number is required </div>
                    </div>
                </div>
                <div class="row">
                    <div class="col-md-3 mb-3">
                        <label for="cc-expiration">Expiration</label>
                        <input type="text" class="form-control" id="cc-expiration" placeholder="" required="">
                        <div class="invalid-feedback"> Expiration date required </div>
                    </div>
                    <div class="col-md-3 mb-3">
                        <label for="cc-cvv">CVV</label>
                        <input type="text" class="form-control" id="cc-cvv" placeholder="" required="">
                        <div class="invalid-feedback"> Security code required </div>
                    </div>
                </div>
                <hr class="mb-4">
                <button class="btn btn-primary btn-lg btn-block" type="submit">Continue to checkout</button>
            </form>
        </div>
    </div>
    <footer class="my-5 pt-5 text-muted text-center text-small">
        <p class="mb-1">© 2017-2019 Company Name</p>
        <ul class="list-inline">
            <li class="list-inline-item"><a href="#">Privacy</a></li>
            <li class="list-inline-item"><a href="#">Terms</a></li>
            <li class="list-inline-item"><a href="#">Support</a></li>
        </ul>
    </footer>
</div>
<script>
    // Example starter JavaScript for disabling form submissions if there are invalid fields
(function () {
  'use strict'

  window.addEventListener('load', function () {
    // Fetch all the forms we want to apply custom Bootstrap validation styles to
    var forms = document.getElementsByClassName('needs-validation')

    // Loop over them and prevent submission
    Array.prototype.filter.call(forms, function (form) {
      form.addEventListener('submit', function (event) {
        if (form.checkValidity() === false) {
          event.preventDefault()
          event.stopPropagation()
        }
        form.classList.add('was-validated')
      }, false)
    })
  }, false)
}())
</script>




