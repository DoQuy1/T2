<%
    Dim currentURL
    currentURL = Request.ServerVariables("SCRIPT_NAME") & "?" & Request.ServerVariables("QUERY_STRING")
    Response.Write(currentURL)
%>


<%
    dim checkboxArr
    Set payments = Server.CreateObject("Scripting.Dictionary")
    payments.Add "1", "Credit Card"
    payments.Add "2", "Visa"
    payments.Add "3", "4111111111111111"
    checkboxArr = Request.Form("checkbox")
    checkboxArs = Split(checkboxArr,",")
    for Each temp in checkboxArs
        for Each payment In payments.Keys
            if Clng(payment)= Clng(temp) then
                Response.write(temp)
                Response.write("<br>")
                
                Response.write(payments.Item(payment))
                Response.write("<br>")
            end if
        Next
    NEXT

%>
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
    limit=Request.Form("select-limit")
    inputsearch=Request.QueryString("input-search")
    optionsearch=Request.QueryString("option-search")
    if(trim(inputsearch) <> "") or (NOT IsNull(inputsearch) or trim(optionsearch) <> "") or (NOT IsNull(optionsearch)) then
    dim sql 
    Select Case 

    end if

    if(trim(limit) = "") or (isnull(limit)) then
        limit=5
    end if

    strSQL = "SELECT COUNT(ProductID) AS count FROM Products"
    connDB.Open()
    Set CountResult = connDB.execute(strSQL)

    totalRows = CLng(CountResult("count"))

    Set CountResult = Nothing
' lay ve tong so trang
    pages = Ceil(totalRows/limit)

    if (trim(page) = "") or (isnull(page) or page < 1) then
        page = 1
    end if
    offset = (Clng(page) * Clng(limit)) - Clng(limit)
    limit_select= 20
%>
<!-- #include file="./layout/header.asp" -->
<div class="container">
    <div class="mt-4">
    <section class="content-header">
            <div class="container-fluid">
                <div class="row mb-2">
                    <div class="col-sm-6">
                        <h1>Product Management</h1>
                    </div>
                    <div class="col-sm-6">
                        <ol class="breadcrumb float-sm-right">
                            <li class="breadcrumb-item"><a href="index.asp">Home</a></li>
                            <li class="breadcrumb-item active">Product Management</li>
                        </ol>
                    </div>
                </div>
            </div>
        </section>
</div>
    <div class="row">
        <div class="col-12">
            <div class="card">
                <div class="card-body" style="padding-bottom: 0px">
                    <div class="row">
                        <div class="col-sm-5 pb-2">
                            <a href="addeditProduct.asp" class="btn btn-danger mb-2"><i class="mdi mdi-plus-circle me-2"></i> Add Products</a>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-sm-6">
                            <form method="post" id="form-limit" action="" name="form-limit">
                                <label for="" class="form-label">
                                    Display
                                    <select name="select-limit" id="select-limit" class="custom-select" style="width:auto">
                                        <%
                                            For i=5 To limit_select Step 5
                                        %>
                                            <option value="<%=i%>"<%=checkPage(Clng(i)=Clng(limit),"selected")%>><%=i%></option>
                                        <%       
                                            Next
                                        %>
                                    </select>
                                    products
                                </label>
                            </form>
                            <button class="btn btn-danger mb-2" id="deleteButton" style="display: none;"><a data-bs-toggle="modal" data-bs-target="#confirm-delete" title="Delete">Delete</a></button>
                        </div>
                        <div class="col-sm-6">
                                <form class="form-inline" action="#" style="justify-content: flex-end;">
                                <input class="form-control mr-sm-2" name="input-search"type="search" placeholder="Search" aria-label="Search" style="min-width: 260px;">
                                <select class="form-select form-control mr-sm-2" name="option-search" aria-label="Default select example">
                                    <option value="0">--Type--</option>
                                    <option value="1">Name</option>
                                    <option value="2">Category</option>
                                    <option value="3">Price</option>
                                </select>
                                <button class="btn btn-outline-success my-2 my-sm-0" type="submit">Search</button>
                                </form>
                        </div>
                    </div>
                    <form action="deleteProduct.asp" id="delete_products" method=post>
                    <div class="table-responsive table-hover">
                        <table class="table w-100 " id="products-datatable">
                            <thead class="table-light">
                                <tr>
                                    <th class="" style="width: 20px;">
                                        <div class="form-check">
                                            <input type="checkbox" class="form-check-input" id="customCheck-all">
                                            <label class="form-check-label" for="customCheck-all">&nbsp;</label>
                                        </div>
                                    </th>
                                    <th style="width: 20%;">Product</th>
                                    <th>Category</th>
                                    <th>Description</th>
                                    <th>Price</th>
                                    <th>Band</th>
                                    <th>Status</th>
                                    <th style="width: 85px;">Action</th>
                                </tr>
                            </thead>
                            <tbody>
                                
                                <%
                                    Set cmdPrep = Server.CreateObject("ADODB.Command")
                                    cmdPrep.ActiveConnection = connDB
                                    cmdPrep.CommandType = 1
                                    cmdPrep.Prepared = True
                                    cmdPrep.CommandText = "SELECT * FROM Products ORDER BY ProductID OFFSET ? ROWS FETCH NEXT ? ROWS ONLY"
                                    cmdPrep.parameters.Append cmdPrep.createParameter("offset",3,1, ,offset)
                                    cmdPrep.parameters.Append cmdPrep.createParameter("limit",3,1, , limit)
                                    Set Result = cmdPrep.execute
                                    do while not Result.EOF
                                %>
                                <tr>
                                    <td class="align-middle">
                                        <div class="form-check">
                                            <input type="checkbox" name="checkbox-selected"class="form-check-input" id="customCheck" value="<%=Result("ProductID")%>">
                                            <label class="form-check-label" for="customCheck">&nbsp;</label>
                                        </div>
                                    </td>
                                    <td class="align-middle">
                                        <img src="/images/dress-shirt-img.png" alt="contact-img" title="contact-img" class="rounded me-3" style="width: 50%;" />
                                        <p class="m-0 d-inline-block align-middle font-16">
                                            <a href="productDetail.asp?id=<%=Result("ProductID")%>" class="text-body"><%=Result("ProductName")%></a>
                                        </p>
                                    </td>
                                    <%
                                        Dim sql 
                                        Dim idcategory
                                        idcategory = Result("CategoryID")
                                        sql = "Select * From Category where CategoryID="&idcategory&""
	                                    set rs = connDB.execute(sql)
                                        set sql = Nothing
                                    %>
                                    <td class="align-middle">
                                        <%=rs("CategoryName")%>
                                    </td>
                                    <td class="align-middle">
                                        <%=Result("Description")%>
                                    </td>
                                    <td class="align-middle">
                                        <%=Result("Price")%>
                                    </td>

                                    <td class="align-middle">
                                        <%=Result("Brand")%>
                                    </td>

                                    <td class="align-middle">
                                        
                                        <%=Result("Status")%>
                                    </td>

                                    <td class="align-middle" >
                                        <%
                                            if (Result("Status") = "Enable") then
                                        %>
                                            <a href="isStatus.asp?idproduct=<%=Result("ProductID")%>"><i class="fa-regular fa-eye"></i></a>
                                        <%
                                            else 
                                        %>
                                        <a href="isStatus.asp?idproduct=<%=Result("ProductID")%>"><i class="fa-regular fa-eye-slash"></i></a>
                                        <%
                                            end if
                                        %>
                                        <a href="addeditProduct.asp?idproduct=<%=Result("ProductID")%>"><i class="fa-regular fa-pen-to-square"></i></a>
                                        <a data-href="deleteProduct.asp?idproduct=<%=Result("ProductID")%>" data-bs-toggle="modal" data-bs-target="#confirm-delete" title="Delete"><i class="fa-regular fa-trash-can" style="cursor: pointer;color:#007bff"></i></a>
                                    </td>
                                </tr>
                                <%
                                        Result.MoveNext
                                    loop
                                %>
                            </tbody>
                        </table>
                    </div>
                    </form>
                </div> <!-- end card-body-->
            </div> <!-- end card-->
            <div class="container mt-4">
                <div class="row align-items-center">
                
                <%
                    if(page=(pages-1) OR page=1) then 
                %>
                    <div class="col-ms-12 col-md-5 " >Showing product <%=offset+1%> to <%=limit%> of <%=totalRows%></div>
                <%
                    Else
                %>
                    <div class="col-ms-12 col-md-5" >Showing product <%=offset%> to <%=totalRows%> of <%=totalRows%></div>
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
                $('#select-limit').change(function() {
                    $('#form-limit').submit();
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



<%
                                Function createPagination(pages, page,currentUrl)
                                    Dim str, i
                                    str = "<ul class='pagination'>"
                                    ' Kiểm tra nút "Previous"
                                    If page > 1 Then
                                        str = str & "<li class='page-item'><a class='page-link' href='"&currentUrl&"page=" & page - 1 & "'>Previous</a></li>"
                                    End If
                                    ' Hiển thị các trang
                                    If pages < 6 Then
                                        For i = 1 To pages
                                            str = str & "<li" 
                                            if(i = Clng(page)) Then
                                              str=str &" class='active page-item'"
                                            else
                                              str= str &" class='page-item'"
                                            end if 
                                            str=str & "><a class='page-link' href='"&currentUrl&"page=" & i & "'>" & i & "</a></li>"
                                        Next
                                    Else
                                        Dim startPage, endPage, gap
                                        startPage = page - 2
                                        endPage = page + 2
                                        If startPage < 1 Then
                                            startPage = 1
                                            endPage = 5
                                        ElseIf endPage > pages Then
                                            endPage = pages
                                            startPage = pages - 4
                                        End If
                                        gap = startPage - 1
                                        If gap >= 1 Then
                                            str = str & "<li class='page-item'><a class='page-link' href='"&currentUrl&"page=1'>1</a></li>"
                                            If gap >= 2 Then
                                                str = str & "<li class='page-item'><span>...</span></li>"
                                            End If
                                        End If
                                        For i = startPage To endPage
                                            str = str & "<li" 
                                            If(i = Clng(page)) Then
                                            str=str &" class='active page-item'"
                                            else
                                              str =str &" class='page-item'"
                                            end if
                                              str=str & "><a class='page-link' href='"&currentUrl&"page=" & i & "'>" & i & "</a></li>"
                                        Next
                                        gap = pages - endPage
                                        If gap >= 1 Then
                                            If gap >= 2 Then
                                                str = str & "<li class='page-item'><span>...</span></li>"
                                            End If
                                            str = str & "<li class='page-item'><a class='page-link' href='"&currentUrl&"page=" & pages & "'>" & pages & "</a></li>"
                                        End If
                                    End If
                                    ' Kiểm tra nút "Next"
                                    If Clng(page) < Clng(pages) Then
                                        str = str & "<li class='page-item'><a class='page-link' href='"&currentUrl&"page=" & page + 1 & "'>Next</a></li>"
                                    End If
                                    str = str & "</ul>"
                                    createPagination = str
                                End Function


                                if(trim(page) = "") or (isnull(page)) then
                                page = 1
                                end if
                                ' Gọi hàm tạo chuỗi HTML cho thanh phân trang
                                pagination = createPagination(pages, page,currentUrl)

                                ' In chuỗi HTML
                                Response.Write pagination

                                %>



------------------------------------

<!-- #include file="connect.asp" -->
<%
    Dim address,paymentMethod,customerID,payments
    Set payments = Session("payment")
    address = Request.Form("address")
    paymentMethodID = Request.Form("paymentMethod")
    customerID =Session("CustomerID")
    totalAmount=Session("totalAmount")
    orderDate = FormatDateTime(Now(), vbGeneralDate)  ' Lấy ngày hiện tại và định dạng thành chuỗi ngày tháng
    Response.write(customerID)
    Response.write("<br>")
    Response.write(address)
    Response.write("<br>")
    Response.write(totalAmount)
    Response.write("<br>")
    Response.write(orderDate)
    Response.write("<br>")
    Response.write(paymentMethodID)
    Response.write("<br>")
    ' For Each key In payments.Keys
    '         Response.write(key)
    '         Response.write("<br>")
    '         Response.write(payments.Item(key))
    '         Response.write("<br>")
    ' Next
    connDB.Open()

        If (NOT IsNull(address) And address <> "" And NOT IsNull(paymentMethodID) And paymentMethodID <> "" And NOT IsNull(customerID) And customerID <> "" And NOT IsNull(totalAmount) And totalAmount <> "") Then
        On Error Resume Next '*** Error Resume ***'
        '*** Transaction Start ***'
        connDB.BeginTrans

        Set cmdPrep = Server.CreateObject("ADODB.Command")
        cmdPrep.ActiveConnection = connDB
        cmdPrep.CommandType = 1
        cmdPrep.Prepared = True
        cmdPrep.CommandText = "INSERT INTO Orders (CustomerID, PaymentMethodID, OrderDate, Status, TotalAmount, ShippingAddress) VALUES ("&customerID&","&paymentMethodID&", '"&orderDate&"', 'Order Processed', "&totalAmount&", '"&address&"')"
        ' cmdPrep.Parameters.Append cmdPrep.CreateParameter("@CustomerID", adInteger, adParamInput, , customerID)
        ' cmdPrep.Parameters.Append cmdPrep.CreateParameter("@PaymentMethodID", adInteger, adParamInput, , paymentMethod)
        ' cmdPrep.Parameters.Append cmdPrep.CreateParameter("@OrderDate", adDBTimeStamp, adParamInput, , orderDate)
        ' cmdPrep.Parameters.Append cmdPrep.CreateParameter("@Status", adVarChar, adParamInput, , "Order Processed")
        ' cmdPrep.Parameters.Append cmdPrep.CreateParameter("@TotalAmount", adDouble, adParamInput, , totalAmount)
        ' cmdPrep.Parameters.Append cmdPrep.CreateParameter("@ShippingAddress", adVarChar, adParamInput, , address)

        cmdPrep.Execute

        Dim rs
        Dim orderID
        Set cmdPrep = Server.CreateObject("ADODB.Command")
        cmdPrep.ActiveConnection = connDB
        cmdPrep.CommandType = 1
        cmdPrep.Prepared = True
        cmdPrep.CommandText = "SELECT @@IDENTITY AS ID"
        Set rs = cmdPrep.Execute
        If Not rs.EOF Then
            orderID = cint(rs("ID"))
        End If
        if(orderID<>0) then
        Response.write(orderID)
        else
        Response.write("errror")
        end if
        rs.Close

        'Thực hiện thêm chi tiết hóa đơn
        If orderID<>0 Then
            For Each key In payments.Keys
                Response.write(key)
                Response.write("<br>")
                Response.write(payments.Item(key))
                Response.write("<br>")
                  Set cmdDetail = Server.CreateObject("ADODB.Command")
                    cmdDetail.ActiveConnection = connDB
                    cmdDetail.CommandType = 1
                    cmdDetail.Prepared = True
                    cmdDetail.CommandText = "INSERT INTO OrderDetail (OrderID,ProductID,Quantity,Price) VALUES (?, ?, ?, 10)"
                    cmdDetail.parameters.Append cmdDetail.createParameter("OrderID",3,1,,orderID)
                    cmdDetail.parameters.Append cmdDetail.createParameter("ProductID",3,1,,key)
                    cmdDetail.parameters.Append cmdDetail.createParameter("Quantity",3,1,,payments.Item(key))
                    cmdDetail.Execute
            Next
        End If
        If Err.Number = 0 Then
            Session("Success") = "Order was added!"
            ' Hoàn thành giao dịch
            connDB.CommitTrans
            Response.Redirect("orderDetail.asp")
        Else
            connDB.RollbackTrans
            Response.Write("Error Save (" & Err.Description & ")")
        End If

    ' Đóng kết nối
    connDB.Close
    Set connDB = Nothing
End If
%>