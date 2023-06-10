
<!-- #include file="connect.asp" -->
<%
' ham lam tron so nguyen
    function Ceil(Number)
        Ceil = Int(Number)
        if Ceil<>Number Then
            Ceil = Ceil + 1
        end if
    end function

    function checkPage(cond, ret) 
        if cond=true then
            Response.write ret
        else
            Response.write ""
        end if
    end function
' trang hien tai
    page = Request.QueryString("page")

    pageSize=Request.Form("pageSize")
    If Request.ServerVariables("REQUEST_METHOD") = "POST" Then
    ' Lấy giá trị mới của pageSize từ form
        Dim newPageSize
        newPageSize = Request.Form("pageSize")

        ' Kiểm tra nếu pageSize không rỗng
        If Not IsEmpty(newPageSize) Then
            ' Lưu giá trị mới của pageSize vào biến Session
            Session("pageSizeOrder") = newPageSize
        End If
    End If
    Dim pageSize
    pageSize = Session("pageSizeOrder")
    
    If IsEmpty(pageSize) Then
        pageSize = 5 ' Giá trị mặc định của pageSize
    End If
    
    inputsearch=Request.QueryString("input-search")
    optionsearch=Request.QueryString("option-search")
    fromDate = Request.QueryString("from_date")
    toDate = Request.QueryString("to_date")
    connDB.Open()
    if(trim(fromDate) <> "") and (NOT IsEmpty(fromDate)) and trim(toDate) <> "" and (NOT IsEmpty(toDate)) then
        strSQL = "SELECT COUNT(OrderID) AS count FROM Orders Where OrderDate >='"&fromDate&"' AND OrderDate <= '"&toDate&"' "
        currentUrl = "orderManagement.asp?from_date="&fromDate&"&to_date="&toDate&"&"
    end if
    if(trim(inputsearch) <> "") and (NOT IsEmpty(inputsearch)) and trim(optionsearch) <> "" and (NOT IsEmpty(optionsearch)) then
        
      Select Case optionsearch
      Case 0
      strSQL = "SELECT COUNT(OrderID) AS count FROM Orders "
      Case 1 
      strSQL = "SELECT COUNT(OrderID) AS count FROM Orders Where CustomerID IN(Select CustomerID From Customers where Name Like '%"&inputsearch&"%') "
      Case 2
      strSQL = "SELECT COUNT(OrderID) AS count FROM Orders Where CustomerID IN(Select CustomerID From Customers where Username Like '%"&inputsearch&"%') "
      Case 3
      strSQL = "SELECT COUNT(OrderID) AS count FROM Orders Where PaymentMethodID IN (Select PaymentID From PaymentMethods where PaymentMethodName Like '%"&inputsearch&"%') "
      Case 4
      strSQL = "SELECT COUNT(OrderID) AS count FROM Orders Where Status '%"&inputsearch&"%' "
      Case 5
      strSQL = "SELECT COUNT(OrderID) AS count FROM Orders Where ShippAddress '%"&inputsearch&"%' "
      Case 6
      strSQL = "SELECT COUNT(OrderID) AS count FROM Orders Where Price <= "&inputsearch&" "
    End Select
        currentUrl = "orderManagement.asp?input-search="&inputsearch&"&option-search="&optionsearch&"&"
    end if

    if(trim(inputsearch) = "") and (IsEmpty(inputsearch)) and (trim(optionsearch) = "") and (IsEmpty(optionsearch)) and (trim(toDate) = "") and (IsEmpty(toDate)) and (trim(fromDate) = "") and (IsEmpty(fromDate)) then
        strSQL = "SELECT COUNT(OrderID) AS count FROM Orders "
        currentUrl = "orderManagement.asp?"
    end if
    
    Set CountResult = connDB.execute(strSQL)

    totalRows = CLng(CountResult("count"))

    Set CountResult = Nothing
' lay ve tong so trang
    pages = Ceil(totalRows/pageSize)

    if (trim(page) = "") or (isnull(page) or page < 1) then
        page = 1
    end if
    offset = (Clng(page) * Clng(pageSize)) - Clng(pageSize)


%>

<!-- #include file="./layout/header.asp" -->
<div class="mt-4">
    <section class="content-header">
            <div class="container-fluid">
                <div class="row mb-2">
                    <div class="col-sm-6">
                        <h1>Order Management</h1>
                    </div>
                    <div class="col-sm-6">
                        <ol class="breadcrumb float-sm-right">
                            <li class="breadcrumb-item"><a href="index.asp">Home</a></li>
                            <li class="breadcrumb-item active">Order Management</li>
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
                        <form method="post" id="form-pageSize" action="" name="form-pageSize">
                           <div class="row mb-3">
                                <label for="pageSize" class="p-2">Number of invoices displayed:</label>
                                <input type="number" style="width:70px;height:38px" class="form-control " id="pageSize" name="pageSize" value="<%=pageSize%>" min="1">
                            </div>
                        </form>
                        <button class="btn btn-danger mb-2" id="deleteButton" style="display: none;"><a data-bs-toggle="modal" data-bs-target="#confirm-delete" title="Delete">Delete Selected Items</a></button>
                    </div>
                    <div class="col-sm-6 ">
                           <form class="form-inline mr-4" action="" style="justify-content: flex-end;">
                                <input value="<%=inputsearch%>" class="form-control mr-sm-2 col-md-5" name="input-search"type="search" placeholder="Search" aria-label="Search" style="min-width: 260px;">
                                <select class="form-select form-control mr-sm-2 col-md-2" name="option-search" aria-label="Default select example">
                                    
                                    <option value="0" <%=checkPage(Clng(optionsearch)=0,"selected")%>>--Type--</option>
                                    <option value="1" <%=checkPage(Clng(optionsearch)=1,"selected")%>>Name</option>
                                    <option value="2" <%=checkPage(Clng(optionsearch)=2,"selected")%>>Username</option>
                                    <option value="3" <%=checkPage(Clng(optionsearch)=3,"selected")%>>PaymentMethod</option>
                                    <option value="4" <%=checkPage(Clng(optionsearch)=4,"selected")%>>Status</option>
                                    <option value="5" <%=checkPage(Clng(optionsearch)=5,"selected")%>>ShippingAddress</option>
                                    <option value="6" <%=checkPage(Clng(optionsearch)=6,"selected")%>>Price</option>
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
            
                <form action="deleteProduct.asp" id="delete_products" method=post>
                <div class="table-responsive">
                    <table class="table table-centered w-100 dt-responsive nowrap" id="products-datatable">
                        <thead class="table-light">
                            <tr>
                                <th class="all" style="width: 20px;">
                                    <div class="form-check">
                                        <input type="checkbox" class="form-check-input" id="customCheck-all"">
                                        <label class="form-check-label" for="customCheck-all">&nbsp;</label>
                                    </div>
                                </th>
                                <th class="all">OrderId</th>
                                <th>Name</th>
                                <th>Username</th>
                                <th>Payment Method</th>
                                <th>OrderDate</th>
                                <th>Status</th>
                                <th>TotalAmount</th>
                                <th>ShippingAddress</th>
                                <th style="width: 85px;">Action</th>
                            </tr>
                        </thead>
                        <tbody>
                            <%
                                    Set cmdPrep = Server.CreateObject("ADODB.Command")
                                    cmdPrep.ActiveConnection = connDB
                                    cmdPrep.CommandType = 1
                                    cmdPrep.Prepared = True
                                    if(trim(inputsearch) <> "") and (NOT IsEmpty(inputsearch)) and trim(optionsearch) <> "" and (NOT IsEmpty(optionsearch)) then

                                    Select Case optionsearch
                                      Case 0
                                      cmdPrep.CommandText = "SELECT * FROM Orders ORDER BY OrderID OFFSET ? ROWS FETCH NEXT ? ROWS ONLY"
                                      Case 1 
                                      cmdPrep.CommandText = "SELECT * FROM Orders Where CustomerID IN(Select CustomerID From Customers where Name Like '%"&inputsearch&"%') ORDER BY OrderID OFFSET ? ROWS FETCH NEXT ? ROWS ONLY"
                                      Case 2
                                      cmdPrep.CommandText = "SELECT * FROM Orders Where CustomerID IN(Select CustomerID From Customers where Username Like '%"&inputsearch&"%') ORDER BY OrderID OFFSET ? ROWS FETCH NEXT ? ROWS ONLY"
                                      Case 3
                                      cmdPrep.CommandText = "SELECT * FROM Orders Where PaymentMethodID IN(Select PaymentID From PaymentMethods where PaymentMethodName Like '%"&inputsearch&"%') ORDER BY OrderID OFFSET ? ROWS FETCH NEXT ? ROWS ONLY"
                                      Case 4
                                      cmdPrep.CommandText = "SELECT * FROM Orders Where Status '%"&inputsearch&"%' ORDER BY OrderID OFFSET ? ROWS FETCH NEXT ? ROWS ONLY"
                                      Case 5
                                      cmdPrep.CommandText = "SELECT * FROM Orders Where ShippAddress '%"&inputsearch&"%' ORDER BY OrderID OFFSET ? ROWS FETCH NEXT ? ROWS ONLY"
                                      Case 6
                                      cmdPrep.CommandText = "SELECT * FROM Orders Where Price <= "&inputsearch&" ORDER BY OrderID OFFSET ? ROWS FETCH NEXT ? ROWS ONLY"
                                    End Select
                                    end if
                                    if(trim(fromDate) <> "") and (NOT IsEmpty(fromDate)) and trim(toDate) <> "" and (NOT IsEmpty(toDate)) then
                                        cmdPrep.CommandText = "SELECT * FROM Orders Where OrderDate >='"&fromDate&"' AND OrderDate <= '"&toDate&"' ORDER BY OrderID OFFSET ? ROWS FETCH NEXT ? ROWS ONLY "
                                    end if
                                    if(trim(inputsearch) = "") and (IsEmpty(inputsearch)) and (trim(optionsearch) = "") and (IsEmpty(optionsearch)) and (trim(toDate) = "") and (IsEmpty(toDate)) and (trim(fromDate) = "") and (IsEmpty(fromDate)) then
                                    cmdPrep.CommandText = "SELECT * FROM Orders ORDER BY OrderID OFFSET ? ROWS FETCH NEXT ? ROWS ONLY"
                                    end if
                                    cmdPrep.parameters.Append cmdPrep.createParameter("offset",3,1, ,offset)
                                    cmdPrep.parameters.Append cmdPrep.createParameter("limit",3,1, , pageSize)
                                    Set Result = cmdPrep.execute
                                    do while not Result.EOF
                                %>
                                <tr>
                                    <td class="align-middle">
                                        <div class="form-check">
                                            <input type="checkbox" name="checkbox-selected"class="form-check-input" id="customCheck" value="<%=Result("OrderID")%>">
                                            <label class="form-check-label" for="customCheck">&nbsp;</label>
                                        </div>
                                    </td>
                                    <td class="align-middle">
                                        <p class="m-0 d-inline-block align-middle font-16">
                                            <a href="orderDetail.asp?orderId=<%=Result("OrderID")%>" class="text-body"><%=Result("OrderID")%></a>
                                        </p>
                                    </td>
                                         <%
                                            Dim customerID
                                            customerID=Result("CustomerID")
                                            Set cmdUser = Server.CreateObject("ADODB.Command")
                                            cmdUser.ActiveConnection = connDB
                                            cmdUser.CommandType = 1
                                            cmdUser.Prepared = True
                                            cmdUser.CommandText = "Select * from Customers where CustomerID=?"
                                            cmdUser.parameters.Append cmdUser.createParameter("CustomerID",3,1, ,customerID)
                                            Set ResultUser = cmdUser.execute
                                        %>
                                    <td class="align-middle">
                                        <%=ResultUser("Name")%>
                                    </td>
                                    <td class="align-middle">
                                        <%=ResultUser("Username")%>
                                    </td>
                                    <td class="align-middle">
                                        <%
                                            Set cmdPay = Server.CreateObject("ADODB.Command")
                                            cmdPay.ActiveConnection = connDB
                                            cmdPay.CommandType = 1
                                            cmdPay.Prepared = True
                                            cmdPay.CommandText = "Select * from PaymentMethods where PaymentMethodID="&Result("PaymentMethodID")&""
                                            Set ResultPay = cmdPay.execute
                                        %>
                                        <%=ResultPay("PaymentMethodName")%>
                                    </td>
                                    <td class="align-middle">
                                        <%=Result("OrderDate")%>
                                    </td>

                                    <td class="align-middle">
                                        <%=Result("Status")%>
                                    </td>

                                    <td class="align-middle">
                                        
                                        <%=Result("TotalAmount")%>
                                    </td>

                                     <td class="align-middle">
                                        
                                        <%=Result("ShippingAddress")%>
                                    </td>

                                    <td class="align-middle" >
                                        <a href="#"><i class="fa-regular fa-pen-to-square"></i></a>
                                        <a data-href="deleteOrder.asp?orderId=<%=Result("OrderID")%>" data-bs-toggle="modal" data-bs-target="#confirm-delete" title="Delete"><i class="fa-regular fa-trash-can" style="cursor: pointer;color:#007bff"></i></a>
                                    </td>
                                </tr>
                                <%
                                        Result.MoveNext
                                    loop
                                %>
                        </tbody>
                    </table>
                    </form>
                </div>
            </div> <!-- end card-body-->
        </div> <!-- end card-->
        <div class="container mt-4">
                <div class="row align-items-center">
                
                <%
                    if(page=pages) then 
                %>
                    <div class="col-ms-12 col-md-5 " >Showing product <%=offset+1%> to <%=totalRows%> of <%=totalRows%></div>
                <%
                    Else
                %>
                    <div class="col-ms-12 col-md-5" >Showing product <%=offset+1%> to <%=offset+pageSize%> of <%=totalRows%></div>
                <%
                    end if
                %>
                <div class="col-ms-12 col-md-5" >
                    <nav aria-label="Page navigation example">
                        <div id="pagination" style="justify-content: flex-end" class="pull-right">
                             <!-- #include file="pagination.asp" -->
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