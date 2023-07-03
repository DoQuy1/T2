<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
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
    if(trim(fromDate) <> "") and (NOT IsEmpty(fromDate)) and trim(toDate) <> "" and (NOT IsEmpty(toDate) ) then
        strSQL = "SELECT COUNT(OrderID) AS count FROM Orders Where OrderDate >='"&fromDate&"' AND OrderDate <= '"&toDate&"' "
        currentUrl = "orderManagement.asp?from_date="&fromDate&"&to_date="&toDate&"&"
    Else
        if(trim(inputsearch) = "") or (IsEmpty(inputsearch)) or (trim(optionsearch) = "") or (IsEmpty(optionsearch)) then
        strSQL = "SELECT COUNT(OrderID) AS count FROM Orders "
        currentUrl = "orderManagement.asp?"
        End if
    end if
    if(trim(inputsearch) <> "") and (NOT IsEmpty(inputsearch)) and trim(optionsearch) <> "" and (NOT IsEmpty(optionsearch)) and (trim(fromDate) <> "") and (NOT IsEmpty(fromDate)) and trim(toDate) <> "" and (NOT IsEmpty(toDate)) then
        
        Select Case optionsearch
        Case 0
        strSQL = "SELECT COUNT(OrderID) AS count FROM Orders where OrderDate >='"&fromDate&"' AND OrderDate <= '"&toDate&"' "
        Case 1 
        strSQL = "SELECT COUNT(OrderID) AS count FROM Orders Where CustomerID IN(Select CustomerID From Customers where Name Like N'%"&inputsearch&"%') And OrderDate >='"&fromDate&"' AND OrderDate <= '"&toDate&"' "
        Case 2
        strSQL = "SELECT COUNT(OrderID) AS count FROM Orders Where CustomerID IN(Select CustomerID From Customers where Username Like '%"&inputsearch&"%') and OrderDate >='"&fromDate&"' AND OrderDate <= '"&toDate&"' "
        Case 3
        strSQL = "SELECT COUNT(OrderID) AS count FROM Orders Where PaymentMethodID = (Select PaymentMethodID From PaymentMethods where PaymentMethodName Like '%"&inputsearch&"%') and OrderDate >='"&fromDate&"' AND OrderDate <= '"&toDate&"' "
        Case 4
        strSQL = "SELECT COUNT(OrderID) AS count FROM Orders Where Status like'%"&inputsearch&"%' and OrderDate >='"&fromDate&"' AND OrderDate <= '"&toDate&"' "
        Case 5
        strSQL = "SELECT COUNT(OrderID) AS count FROM Orders Where ShippingAddress like '%"&inputsearch&"%' and OrderDate >='"&fromDate&"' AND OrderDate <= '"&toDate&"' "
        Case 6
        strSQL = "SELECT COUNT(OrderID) AS count FROM Orders Where TotalAmount <= "&inputsearch&" and OrderDate >='"&fromDate&"' AND OrderDate <= '"&toDate&"' "
        End Select
            currentUrl = "orderManagement.asp?input-search="&inputsearch&"&option-search="&optionsearch&"&from_date="&fromDate&"&to_date="&toDate&"&"
        Elseif(trim(fromDate) <> "") and (NOT IsEmpty(fromDate)) and trim(toDate) <> "" and (NOT IsEmpty(toDate) ) then
            strSQL = "SELECT COUNT(OrderID) AS count FROM Orders Where OrderDate >='"&fromDate&"' AND OrderDate <= '"&toDate&"' "
            currentUrl = "orderManagement.asp?from_date="&fromDate&"&to_date="&toDate&"&"
        Elseif (trim(inputsearch) <> "") and (NOT IsEmpty(inputsearch)) and trim(optionsearch) <> "" and (NOT IsEmpty(optionsearch)) then
            Select Case optionsearch
                Case 0
                strSQL = "SELECT COUNT(OrderID) AS count FROM Orders "
                Case 1 
                strSQL = "SELECT COUNT(OrderID) AS count FROM Orders Where CustomerID IN(Select CustomerID From Customers where Name Like N'%"&inputsearch&"%') "
                Case 2
                strSQL = "SELECT COUNT(OrderID) AS count FROM Orders Where CustomerID IN(Select CustomerID From Customers where Username Like '%"&inputsearch&"%') "
                Case 3
                strSQL = "SELECT COUNT(OrderID) AS count FROM Orders Where PaymentMethodID = (Select PaymentMethodID From PaymentMethods where PaymentMethodName Like '%"&inputsearch&"%') "
                Case 4
                strSQL = "SELECT COUNT(OrderID) AS count FROM Orders Where Status like'%"&inputsearch&"%' "
                Case 5
                strSQL = "SELECT COUNT(OrderID) AS count FROM Orders Where ShippingAddress like '%"&inputsearch&"%' "
                Case 6
                strSQL = "SELECT COUNT(OrderID) AS count FROM Orders Where TotalAmount <= "&inputsearch&" "
            End Select
                currentUrl = "orderManagement.asp?input-search="&inputsearch&"&option-search="&optionsearch&"&"
        Else
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
                        <h1>Invoice Management</h1>
                    </div>
                    <div class="col-sm-6">
                        <ol class="breadcrumb float-sm-right">
                            <li class="breadcrumb-item"><a href="index.asp">Home</a></li>
                            <li class="breadcrumb-item active">Invoice Management</li>
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
                        <button class="btn btn-danger mb-2" id="deleteButton" style="display: none;"><a data-bs-toggle="modal" data-bs-target="#confirm-deletes" title="Deletes">Deletes Selected Items</a></button>
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
                                
                                <div class="row justify-content-end m-3">
                                    <div class="d-flex ">
                                        <div class="col-md-5" >
                                            <div class="form-group">
                                                <label for="fromDate">Ngày bắt đầu:</label>
                                                <input style="width:100%" type="date" class="form-control" id="fromDate" name="from_date" value="<%=fromDate%>">
                                            </div>
                                        </div>
                                        <div class="col-md-5" style="width:100%">
                                            <div class="form-group">
                                                <label for="toDate">Ngày kết thúc:</label>
                                                <input style="width:100%" type="date" class="form-control" id="toDate" name="to_date" value="<%=toDate%>">
                                            </div>
                                        </div>
                                        <div class="col-md-2" style="margin-top:25px">
                                            <div class="form-group ">
                                                <button class="btn btn-outline-success " type="submit">Search</button>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </form>
                    </div>
                </div>

                <form id="filterForm" >
        
    </form>
            
                <form action="deleteOrder.asp" id="delete_products" method=post>
                <div class="table-responsive table-hover">
                    <table class="table table-striped w-100 " id="products-datatable">
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
                                    if(trim(inputsearch) <> "") and (NOT IsEmpty(inputsearch)) and trim(optionsearch) <> "" and (NOT IsEmpty(optionsearch)) and (trim(fromDate) <> "") and (NOT IsEmpty(fromDate)) and trim(toDate) <> "" and (NOT IsEmpty(toDate)) then
                                    Select Case optionsearch
                                      Case 0
                                      cmdPrep.CommandText = "SELECT * FROM Orders where OrderDate >='"&fromDate&"' AND OrderDate <= '"&toDate&"' ORDER BY OrderID  OFFSET ? ROWS FETCH NEXT ? ROWS ONLY"
                                      Case 1 
                                      cmdPrep.CommandText = "SELECT * FROM Orders Where CustomerID IN(Select CustomerID From Customers where Name Like N'%"&inputsearch&"%') and OrderDate >='"&fromDate&"' AND OrderDate <= '"&toDate&"' ORDER BY OrderID OFFSET ? ROWS FETCH NEXT ? ROWS ONLY"
                                      Case 2
                                      cmdPrep.CommandText = "SELECT * FROM Orders Where CustomerID IN(Select CustomerID From Customers where Username Like '%"&inputsearch&"%') and OrderDate >='"&fromDate&"' AND OrderDate <= '"&toDate&"' ORDER BY OrderID OFFSET ? ROWS FETCH NEXT ? ROWS ONLY"
                                      Case 3
                                      cmdPrep.CommandText = "SELECT * FROM Orders Where PaymentMethodID=(Select PaymentMethodID From PaymentMethods where PaymentMethodName Like '%"&inputsearch&"%') and OrderDate >='"&fromDate&"' AND OrderDate <= '"&toDate&"' ORDER BY OrderID OFFSET ? ROWS FETCH NEXT ? ROWS ONLY"
                                      Case 4
                                      cmdPrep.CommandText = "SELECT * FROM Orders Where Status like '%"&inputsearch&"%' and OrderDate >='"&fromDate&"' AND OrderDate <= '"&toDate&"' ORDER BY OrderID OFFSET ? ROWS FETCH NEXT ? ROWS ONLY"
                                      Case 5
                                      cmdPrep.CommandText = "SELECT * FROM Orders Where ShippingAddress like '%"&inputsearch&"%' and OrderDate >='"&fromDate&"' AND OrderDate <= '"&toDate&"' ORDER BY OrderID OFFSET ? ROWS FETCH NEXT ? ROWS ONLY"
                                      Case 6
                                      cmdPrep.CommandText = "SELECT * FROM Orders Where TotalAmount <= "&inputsearch&" and OrderDate >='"&fromDate&"' AND OrderDate <= '"&toDate&"' ORDER BY OrderID OFFSET ? ROWS FETCH NEXT ? ROWS ONLY"
                                    End Select
                                    Elseif(trim(fromDate) <> "") and (NOT IsEmpty(fromDate)) and trim(toDate) <> "" and (NOT IsEmpty(toDate))then
                                        cmdPrep.CommandText = "SELECT * FROM Orders Where OrderDate >='"&fromDate&"' AND OrderDate <= '"&toDate&"' ORDER BY OrderID OFFSET ? ROWS FETCH NEXT ? ROWS ONLY "
                                    Elseif (trim(inputsearch) <> "") and ( Not IsEmpty(inputsearch)) and (trim(optionsearch) <> "") and (Not IsEmpty(optionsearch)) then
                                         Select Case optionsearch
                                            Case 0
                                            cmdPrep.CommandText = "SELECT * FROM Orders ORDER BY OrderID OFFSET ? ROWS FETCH NEXT ? ROWS ONLY"
                                            Case 1 
                                            cmdPrep.CommandText = "SELECT * FROM Orders Where CustomerID IN(Select CustomerID From Customers where Name Like N'%"&inputsearch&"%') ORDER BY OrderID OFFSET ? ROWS FETCH NEXT ? ROWS ONLY"
                                            Case 2
                                            cmdPrep.CommandText = "SELECT * FROM Orders Where CustomerID IN(Select CustomerID From Customers where Username Like '%"&inputsearch&"%') ORDER BY OrderID OFFSET ? ROWS FETCH NEXT ? ROWS ONLY"
                                            Case 3
                                            cmdPrep.CommandText = "SELECT * FROM Orders Where PaymentMethodID=(Select PaymentMethodID From PaymentMethods where PaymentMethodName Like '%"&inputsearch&"%') ORDER BY OrderID OFFSET ? ROWS FETCH NEXT ? ROWS ONLY"
                                            Case 4
                                            cmdPrep.CommandText = "SELECT * FROM Orders Where Status like '%"&inputsearch&"%' ORDER BY OrderID OFFSET ? ROWS FETCH NEXT ? ROWS ONLY"
                                            Case 5
                                            cmdPrep.CommandText = "SELECT * FROM Orders Where ShippingAddress like '%"&inputsearch&"%' ORDER BY OrderID OFFSET ? ROWS FETCH NEXT ? ROWS ONLY"
                                            Case 6
                                            cmdPrep.CommandText = "SELECT * FROM Orders Where TotalAmount <= "&inputsearch&" ORDER BY OrderID OFFSET ? ROWS FETCH NEXT ? ROWS ONLY"
                                        End Select
                                    Else
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
                                            <a href="orderDetail.asp?orderId=<%=Result("OrderID")%>" class="text-body">#<%=Result("OrderID")%></a>
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
                                        <%
                                            if(ResultUser.EOF = true) then 
                                            Response.write("Null")
                                            Else
                                            Response.write(ResultUser("Name"))
                                            End if
                                        %>
                                    </td>
                                    <td class="align-middle">
                                        <%
                                            if(ResultUser.EOF = true) then 
                                            Response.write("Null")
                                            Else
                                            Response.write(ResultUser("Username"))
                                            End if
                                        %>
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
                                        <a href="editOrder.asp?orderId=<%=Result("OrderID")%>"><i class="fa-regular fa-pen-to-square"></i></a>
                                        <a data-href="deleteOrder.asp?orderId=<%=Result("OrderID")%>" data-bs-toggle="modal" data-bs-target="#confirm-delete" title="Delete"><i class="fa-regular fa-trash-can" style="cursor: pointer;color:#dc3545"></i></a>
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
            <div class="modal" tabindex="-1" id="confirm-deletes">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title">Deletes Confirmation</h5>
                            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                        </div>
                        <div class="modal-body">
                            <p>Are you sure?</p>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                            <a class="btn btn-danger btn-deletes">Deletes</a>
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
                    $("#confirm-deletes").modal('show');
                });

                $(".btn-deletes").click(function() {
                    $("#confirm-deletes").modal('hide');
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