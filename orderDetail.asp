<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>

<!-- #include file="connect.asp" -->
<%
   orderId = Request.QueryString("orderId")
   connDB.open()
   Set cmdOrder = Server.CreateObject("ADODB.Command")
   cmdOrder.ActiveConnection = connDB
   cmdOrder.CommandType = 1
   cmdOrder.Prepared = True
   cmdOrder.CommandText = "Select * from Orders where OrderID = ?"
   cmdOrder.parameters.Append cmdOrder.createParameter("orderId",3,1, ,orderId)
   set OrderCurr = cmdOrder.execute

   set OrderCurrStatus=OrderCurr("Status")

   Set cmdOrderDetail = Server.CreateObject("ADODB.Command")
   cmdOrderDetail.ActiveConnection = connDB
   cmdOrderDetail.CommandType = 1
   cmdOrderDetail.Prepared = True
   cmdOrderDetail.CommandText = "Select * from OrderDetail where OrderID = ?"
   cmdOrderDetail.parameters.Append cmdOrderDetail.createParameter("orderId",3,1, ,orderId)
   set OrderDetailCurr = cmdOrderDetail.execute


  set PaymentMethodID = OrderCurr("PaymentMethodID")

  ' Response.write(PaymentMethodID)

  Set cmdPayment = Server.CreateObject("ADODB.Command")
   cmdPayment.ActiveConnection = connDB
   cmdPayment.CommandType = 1
   cmdPayment.Prepared = True
   cmdPayment.CommandText = "Select * from PaymentMethods where PaymentMethodID = ?"
   cmdPayment.parameters.Append cmdPayment.createParameter("PaymentMethodID",3,1, ,PaymentMethodID)
   set PaymentCurr = cmdPayment.execute


  set OrderCurrID=OrderCurr("OrderID")
  set OrderCurrUserID=OrderCurr("CustomerID")
  set OrderCurrStatus = OrderCurr("Status")
  set OrderCurrOrderDate = OrderCurr("OrderDate")
  set OrderCurrShippingAddress = OrderCurr("ShippingAddress")


  Response.write(OrderCurrID)
  Response.write("<br>")


  set PaymentMethodName=PaymentCurr("PaymentMethodName")
  Response.write(PaymentMethodName)
  Response.write("<br>")

  Set cmdOrderUserID = Server.CreateObject("ADODB.Command")
   cmdOrderUserID.ActiveConnection = connDB
   cmdOrderUserID.CommandType = 1
   cmdOrderUserID.Prepared = True
   cmdOrderUserID.CommandText = "Select * from Customers where CustomerID = ?"
   cmdOrderUserID.parameters.Append cmdOrderUserID.createParameter("OrderCurrUserID",3,1, ,OrderCurrUserID)
   set UserCurr = cmdOrderUserID.execute


%>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-KK94CHFLLe+nY2dmCWGMq91rCGa5gtU4mk92HdvYe+M/SXH301p5ILy+dN9+nJOZ" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ENjdO4Dr2bkBIFxQpeoTz1HIcje39Wm4jDKdf19U8gI4ddQ3GYNS7NTKfAdVQSZe" crossorigin="anonymous"></script>
<link rel="stylesheet" type="text/css" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.3.0/font/bootstrap-icons.css">
<link rel="stylesheet" type="text/css" href="css/orderDetail.css">
<div class="container px-1 px-md-4 py-5 mx-auto">
    <div class="card">
        <div class="d-flex justify-content-between top">
            <div class="d-flex">
                <h5>ORDER <span class="text-primary font-weight-bold">#<%=OrderCurrID%></span></h5>
            </div>
            <div class="d-flex flex-column text-sm-right">
                <p class="mb-0">Expected Arrival <span>01/12/19</span></p>
                <p>USPS <span class="font-weight-bold">234094567242423422898</span></p>
            </div>
        </div>
        <!-- Add class 'active' to progress -->
        <div class="row d-flex justify-content-center ">
            <div class="col-12">
            <ul id="progressbar" class="text-center d-flex " >
                
                <%
                  Select Case OrderCurrStatus
                    Case "Order Processed"
                      Response.write("<li class='active step0'></li><li class='step0'></li><li class='step0'></li><li class='step0'></li><li class='step0'></li>")
                    Case "Order Shipped"
                        Response.write("<li class='active step0'></li><li class='active step0'></li><li class='step0'></li><li class='step0'></li><li class='step0'></li>")
                    Case "Order EnRoute"
                        Response.write("<li class='active step0'></li><li class='active step0'></li><li class='active step0'></li><li class=' step0'></li><li class='step0'></li>")
                    Case "Order Arrived"
                        Response.write("<li class='active step0'></li><li class='active step0'></li><li class='active step0'></li><li class='active step0'></li><li class='step0'></li>")
                    Case "Done"
                    Case "Cancel"
                        Response.write("<li class='active step0'></li><li class='active step0'></li><li class='active step0'></li><li class='active step0'></li><li class=' active step0'></li>")
                  End Select
                %>
            </ul>
            </div>
        </div>
        <div class="row justify-content-between top ">
            <div class="col  d-flex justify-content-start icon-content">
                <img class="icon" src="https://i.imgur.com/9nnc9Et.png">
                <div class="d-flex flex-column">
                    <p class="font-weight-bold">Order<br>Processed</p>
                </div>
            </div>
            <div class="col d-flex icon-content justify-content-center">
                <img class="icon" src="https://i.imgur.com/u1AzR7w.png">
                <div class="d-flex flex-column">
                    <p class="font-weight-bold">Order<br>Shipped</p>
                </div>
            </div>
            <div class="col d-flex icon-content justify-content-end">
                <img class="icon" src="https://i.imgur.com/TkPm63y.png">
                <div class="d-flex flex-column">
                    <p class="font-weight-bold">Order<br>En Route</p>
                </div>
            </div>
            <div class="col  d-flex justify-content-end icon-content">
                <img class="icon" src="https://i.imgur.com/HdsziHP.png">
                <div class=" flex-column">
                    <p class="font-weight-bold">Order<br>Arrived</p>
                </div>
            </div>
            <div class="col  d-flex justify-content-end icon-content">
                <img class="icon" src="https://i.imgur.com/w3UEu8o.jpeg">
                <div class=" flex-column">
                    <%
                    if (OrderCurrStatus = "Done") then
                    %>
                    <p class="font-weight-bold">Done</p>
                    <%
                    elseif (OrderCurrStatus="Cancel") then
                    %>
                    <p class="font-weight-bold">Cancel</p>
                    <%
                    end if
                    %>
                </div>
            </div>
        </div>
    </div>
    <div class="row">
        <div class="col-lg-8">
          <!-- Details -->
          <div class="card mb-4">
            <div class="card-body">
              <div class="mb-3 d-flex justify-content-between">
                <div>
                  <span class="me-3"><%=OrderCurrOrderDate%></span>
                  <span class="me-3">#<%=OrderCurrID%></span>
                  <span class="me-3"><%=PaymentMethodName%></span>
                  <span class="badge rounded-pill bg-info"><%=OrderCurrStatus%></span>
                </div>
                <div class="d-flex">
                  <button class="btn btn-link p-0 me-3 d-none d-lg-block btn-icon-text"><i class="bi bi-download"></i> <span class="text">Invoice</span></button>
                  <div class="dropdown">
                    <button class="btn btn-link p-0 text-muted" type="button" data-bs-toggle="dropdown">
                      <i class="bi bi-three-dots-vertical"></i>
                    </button>
                    <ul class="dropdown-menu dropdown-menu-end">
                      <li><a class="dropdown-item" href="#"><i class="bi bi-pencil"></i>Cancel</a></li>
                      <li><a class="dropdown-item" href="#"><i class="bi bi-printer"></i> Print</a></li>
                    </ul>
                  </div>
                </div>
              </div>
              <table class="table table-borderless">
                <tbody>
                  <%
                  do while not OrderDetailCurr.EOF
                        set OrderDetailCurrID = OrderDetailCurr("OrderDetailID")
                        
                        Set cmdOrderDetailProduct = Server.CreateObject("ADODB.Command")
                        cmdOrderDetailProduct.ActiveConnection = connDB
                        cmdOrderDetailProduct.CommandType = 1
                        cmdOrderDetailProduct.Prepared = True
                        cmdOrderDetailProduct.CommandText = "Select * from OrderDetail where OrderDetailID = ?"
                        cmdOrderDetailProduct.parameters.Append cmdOrderDetailProduct.createParameter("OrderDetailCurrID",3,1, ,OrderDetailCurrID)
                        set OrderDetailProductCurr = cmdOrderDetailProduct.execute
                        
                        
                        set OrderDetailProductID = OrderDetailProductCurr("ProductID")
                        Set cmdProduct = Server.CreateObject("ADODB.Command")
                        cmdProduct.ActiveConnection = connDB
                        cmdProduct.CommandType = 1
                        cmdProduct.Prepared = True
                        cmdProduct.CommandText = "Select * from Products where ProductID = ?"
                        cmdProduct.parameters.Append cmdProduct.createParameter("OrderDetailProductID",3,1, ,OrderDetailProductID)
                        set ProductCurr = cmdProduct.execute

                  %>
                  <tr>
                    <td>
                      <div class="d-flex mb-2">
                        <div class="flex-shrink-0">
                          <img src="<%=ProductCurr("Image")%>" alt="" width="35" class="img-fluid">
                        </div>
                        <div class="flex-lg-grow-1 ms-3">
                          <h6 class="small mb-0"><a href="productDetail.asp?id=<%=ProductCurr("ProductID")%>" class="text-reset"><%=ProductCurr("ProductName")%></a></h6>
                          <span class="small"><%=ProductCurr("Brand")%></span>
                        </div>
                      </div>
                    </td>
                    <td>x<%=OrderDetailProductCurr("Quantity")%></td>
                    <td class="text-end">$<%=OrderDetailProductCurr("Price")%></td>
                  </tr>
                  <%
                     OrderDetailCurr.MoveNext
                  loop
                  %>
                </tbody>
                <tfoot>
                  <tr class="fw-bold">
                    <td colspan="2">TOTAL</td>
                    <td class="text-end">$<%=OrderCurr("TotalAmount")%></td>
                  </tr>
                </tfoot>
              </table>
            </div>
          </div>
          <!-- Payment -->
          <div class="card mb-4">
            <div class="card-body">
              <div class="row">
                <div class="col-lg-6">
                  <h3 class="h6">Payment Method</h3>
                  <p><%=PaymentMethodName%><br>
                  Total: $<%=OrderCurr("TotalAmount")%> <span class="badge bg-success rounded-pill"><%=OrderCurrStatus%></span></p>
                </div>
                <div class="col-lg-6">
                  <h3 class="h6">Billing address</h3>
                  <address>
                    <strong><%=UserCurr("Name")%></strong><br>
                    <%=OrderCurrShippingAddress%><br>
                    <br>
                    <abbr title="Phone">P:</abbr> <%=UserCurr("Phone")%>
                  </address>
                </div>
              </div>
            </div>
          </div>
        </div>
        <div class="col-lg-4">
          <!-- Customer Notes -->
          <div class="card mb-4">
            <div class="card-body">
              <h3 class="h6">Customer Notes</h3>
              <p>Sed enim, faucibus litora velit vestibulum habitasse. Cras lobortis cum sem aliquet mauris rutrum. Sollicitudin. Morbi, sem tellus vestibulum porttitor.</p>
            </div>
          </div>
          <div class="card mb-4">
            <!-- Shipping information -->
            <div class="card-body">
              <h3 class="h6">Shipping Information</h3>
              <strong>FedEx</strong>
              <span><a href="#" class="text-decoration-underline" target="_blank">FF1234567890</a> <i class="bi bi-box-arrow-up-right"></i> </span>
              <hr>
              <h3 class="h6">Address</h3>
              <address>
                <strong><%=UserCurr("Name")%></strong><br>
                <%=OrderCurrShippingAddress%><br>
                    <br>
                <abbr title="Phone">P:</abbr> <%=UserCurr("Phone")%>
              </address>
            </div>
          </div>
        </div>
      </div>
</div>











