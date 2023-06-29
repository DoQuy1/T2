
<!-- #include file="connect.asp" -->
<%
      function check(cond, ret) 
        if cond=true then
            Response.write ret
        else
            Response.write ""
        end if
    end function

      ' If (IsEmpty(Session("CustomerID")) or IsEmpty(Session("admin"))) Then
      '     Response.write(Session("CustomerID"))
      ' End If
      Dim customerID
      customerID=Request.QueryString("id")
      ' Response.write(customerID)
      ' if IsEmpty(Session("admin")) then
      ' customerID=Session("CustomerID")
      ' Else
      '   customerID=Session("admin")
      ' End if

      inputsearch=Request.QueryString("input-search")
      optionsearch=Request.QueryString("option-search")
      fromDate = Request.QueryString("from_date")
      toDate = Request.QueryString("to_date")
%>
<!-- #include file="./layout/header.asp" -->
<div class="mt-4">
    <section class="content-header">
            <div class="container-fluid">
                <div class="row mb-2">
                    <div class="col-sm-6">
                        <h1>Purchase</h1>
                    </div>
                    <div class="col-sm-6">
                        <ol class="breadcrumb float-sm-right">
                            <li class="breadcrumb-item"><a href="index.asp">Home</a></li>
                            <li class="breadcrumb-item active">Purchase</li>
                        </ol>
                    </div>
                </div>
            </div>
    </section>
</div>
<div class="row">
    <div class="col-12">
        <div class="card">
            <div class="card-body">
                <div class="row">
                    <div class="col-sm-6">
                    <!--
                        <form method="post" id="form-pageSize" action="" name="form-pageSize">
                           <div class="row mb-3">
                                <label for="pageSize" class="p-2">Number of purchase displayed:</label>
                                <input type="number" style="width:70px;height:38px" class="form-control " id="pageSize" name="pageSize" value="<%=pageSize%>" min="1">
                            </div>
                        </form>
                        <button class="btn btn-danger mb-2" id="deleteButton" style="display: none;"><a data-bs-toggle="modal" data-bs-target="#confirm-delete" title="Delete">Delete Selected Items</a></button>
                    -->
                    </div>
                    <div class="col-sm-6 ">
                           <form class="form-inline mr-4" action="" style="justify-content: flex-end;">
                                <input value="<%=inputsearch%>" class="form-control mr-sm-2 col-md-5" name="input-search"type="search" placeholder="Search" aria-label="Search" style="min-width: 260px;">
                                <select class="form-select form-control mr-sm-2 col-md-2" name="option-search" aria-label="Default select example">
                                    <option value="0" <%=check(Clng(optionsearch)=0,"selected")%>>--Type--</option>
                                    <option value="1" <%=check(Clng(optionsearch)=1,"selected")%>>Status</option>
                                    <option value="2" <%=check(Clng(optionsearch)=2,"selected")%>>ProductName</option>
                                </select>
                                <button class="btn btn-outline-success my-2 my-sm-0 col-md-2" type="submit">Search</button>
                            </form>
                    </div>
                </div>

                <form id="filterForm" >
        <div class="row justify-content-end">
            
            <div class="col-6 d-flex ">
            <div class="col-md-5">
                <div class="form-group">
                    <label for="fromDate">Ngày bắt đầu:</label>
                    <input type="date" class="form-control" id="fromDate" name="from_date" value="<%=fromDate%>">
                </div>
            </div>
            <div class="col-md-5">
                <div class="form-group">
                    <label for="toDate">Ngày kết thúc:</label>
                    <input type="date" class="form-control" id="toDate" name="to_date" value="<%=toDate%>">
                </div>
            </div>
            <div class="col-md-2" style="margin-top:30px">
                <div class="form-group ">
                    <button type="submit" class="btn btn-primary">Lọc</button>
                </div>
            </div>
            </div>
        </div>
    </form>
           <%
              Set cmdPrep = Server.CreateObject("ADODB.Command")
              connDB.Open()
              cmdPrep.ActiveConnection = connDB
              cmdPrep.CommandType = 1
              cmdPrep.Prepared = True
              if(trim(inputsearch) <> "") and (NOT IsEmpty(inputsearch)) and trim(optionsearch) <> "" and (NOT IsEmpty(optionsearch)) then
              Select Case optionsearch
                Case 0
                cmdPrep.CommandText="Select * from Orders where CustomerID="&customerID&" ORDER BY OrderDate DESC"
                Case 1 
                cmdPrep.CommandText = "SELECT * FROM Orders Where Status Like '%"&inputsearch&"%'ORDER BY OrderDate DESC"
                Case 2
                cmdPrep.CommandText = "SELECT O.* FROM Orders O " & _
         "INNER JOIN OrderDetail OD ON O.OrderID = OD.OrderID " & _
         "INNER JOIN Products P ON OD.ProductID = P.ProductID " & _
         "WHERE P.ProductName LIKE '%"&inputsearch&"%'ORDER BY OrderDate DESC"
              End Select
              Else
                  cmdPrep.CommandText="Select * from Orders where CustomerID="&customerID&" ORDER BY OrderDate DESC"
              end if
              if(trim(fromDate) <> "") and (NOT IsEmpty(fromDate)) and trim(toDate) <> "" and (NOT IsEmpty(toDate)) then
                  cmdPrep.CommandText = "SELECT * FROM Orders Where OrderDate >='"&fromDate&"' AND OrderDate <= '"&toDate&"' ORDER BY OrderID "
              end if
            Set Result = cmdPrep.execute
            do while not Result.EOF

           %>
        <div class="col-lg-12">
          <!-- Details -->
          <div class="card mb-4">
            <div class="card-body">
              <div class="mb-3 d-flex justify-content-between mr-5 ">
                <div>
                  <%
                  paymentId=Result("PaymentMethodID")
                  Set cmdPrepPay = Server.CreateObject("ADODB.Command")
                  
                  cmdPrepPay.ActiveConnection = connDB
                  cmdPrepPay.CommandType = 1
                  cmdPrepPay.Prepared = True
                  cmdPrepPay.CommandText="Select * from PaymentMethods where PaymentMethodID =?"
                  cmdPrepPay.parameters.Append cmdPrepPay.createParameter("paymentId",3,1, ,paymentId)
                  Set ResultPay = cmdPrepPay.execute
                  %>
                  <span class="me-3"><%=Result("OrderDate")%></span>
                  <span class="me-3">#<%=Result("OrderID")%></span>
                  <span class="me-3"><%=ResultPay("PaymentMethodName")%></span>
                  <span class="badge rounded-pill bg-info"><%=Result("Status")%></span>
                </div>
                <div class="d-flex ">
                  <a href ="orderDetail.asp?orderId=<%=Result("OrderID")%>" class="btn btn-link p-0 me-3 d-none d-lg-block btn-icon-text"><i class="bi bi-download"></i> <span class="text">Invoice</span></a>
                </div>
              </div>
              <table class="table table-borderless">
                <%
                        orderID= Result("OrderID")
                        ' Response.write(orderID)
                        Set cmdPrepOrderDetails = Server.CreateObject("ADODB.Command")
                        cmdPrepOrderDetails.ActiveConnection = connDB
                        cmdPrepOrderDetails.CommandType = 1
                        cmdPrepOrderDetails.Prepared = True
                        cmdPrepOrderDetails.CommandText="Select * from OrderDetail where OrderID=? "
                        cmdPrepOrderDetails.parameters.Append cmdPrepOrderDetails.createParameter("orderID",3,1, ,orderID)
                        Set ResultOrderDetails = cmdPrepOrderDetails.execute

                        do while not ResultOrderDetails.EOF
                          
                          productID=ResultOrderDetails("ProductID")
                          if (not isnull(productID)) then
                          ' Response.write(productID)
                          Set cmdProduct = Server.CreateObject("ADODB.Command")
                          cmdProduct.ActiveConnection = connDB
                          cmdProduct.CommandType = 1
                          cmdProduct.Prepared = True
                          cmdProduct.CommandText="Select * from Products where ProductID=?"
                          cmdProduct.parameters.Append cmdProduct.createParameter("ProductID",3,1, ,productID)
                          Set ResultProduct = cmdProduct.execute
                  %>
                <tbody>
                  <tr>
                    <td>
                      <div class="d-flex mb-2">
                        <div class="flex-shrink-0">
                          <img src="<%=ResultProduct("Image")%>" alt="" width="35" class="img-fluid">
                        </div>
                        <div class="flex-lg-grow-1 ms-3 ml-3">
                          <h6 class="small mb-0"><a href="productDetail.asp?id=<%=ResultProduct("ProductID")%>" class="text-reset"><%=ResultProduct("ProductName")%></a></h6>
                          <span class="small"><%=ResultProduct("Brand")%></span>
                        </div>
                      </div>
                    </td>
                    <td>x<%=ResultOrderDetails("Quantity")%></td>
                    <td class="text-end">$<%=ResultProduct("Price")%></td>
                  </tr>
                </tbody>
                
                <%
                    Else
                      Response.write("<h1>product has been deleted</h1>")
                    End If
                    ResultOrderDetails.MoveNext
                  loop
                %>
                <tfoot>
                  <tr class="fw-bold">
                    <td colspan="2">TOTAL</td>
                    <td class="text-end">$<%=Result("TotalAmount")%></td>
                  </tr>
                </tfoot>
              </table>
            </div>
          </div>
        </div>
          <%
              Result.MoveNext
            loop
            %>
                </div>
            </div> <!-- end card-body-->
        </div> <!-- end card-->
        <div class="container mt-4">
                <div class="row align-items-center">
                
                
                <div class="col-ms-12 col-md-5" >
                    <nav aria-label="Page navigation example">
                        <div id="pagination" style="justify-content: flex-end" class="pull-right">


                        </div>
                    </nav>  
                </div>
            </div>
            
            <div class="modal" tabindex="-1" id="confirm-delete">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title">Delete Confirmation</h5>
                            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                        </div>
                        <div class="modal-body">
                            <p>Are you sure?</p>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                            <a class="btn btn-danger btn-delete">Delete</a>
                        </div>
                    </div>
                </div>
            </div>

    </div> <!-- end col -->
</div>

</div>
<!-- #include file="./layout/footer.asp" -->
        
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.1/dist/js/bootstrap.bundle.min.js" integrity="sha384-/bQdsTh/da6pkI1MST/rWKFNjaCP5gBSY4sEBT38Q/9RBh9AH40zEOg7Hlq2THRZ" crossorigin="anonymous"></script>

        <script>
                $(document).ready(function() {
                $("#deleteButton").click(function() {
                    $("#confirm-delete").modal('show');
                });

                $(".btn-delete").click(function() {
                    $("#confirm-delete").modal('hide');
                    $("#delete_products").submit();
                });
                });


            $(function()
            {
                $('#confirm-delete').on('show.bs.modal', function(e){
                    $(this).find('.btn-delete').attr('href', $(e.relatedTarget).data('href'));
                });
            });

            $(document).ready(function() {
                $('#pageSize').change(function() {
                    $('#form-pageSize').submit();
                });
            });



            $('#customCheck-all').click(function(event) {   
                if(this.checked) {
                    // Iterate each checkbox
                    $(':checkbox').each(function() {
                        this.checked = true;                        
                    });
                } else {
                    $(':checkbox').each(function() {
                        this.checked = false;                       
                    });
                }
            }); 


        $(document).ready(function() {
            $('.form-check-input').change(function() {
                var checkedCount = $('.form-check-input:checked').length;
                
                if (checkedCount > 1) {
                $('#deleteButton').show();
                } else {
                $('#deleteButton').hide();
                }
            });
            });
        </script>
</body>
<html>