
<!-- #include file="connect.asp" -->
<%
    

    fromDate = Request.QueryString("from_date")
    toDate = Request.QueryString("to_date")
    inputsearch=Request.QueryString("input-search")
    ' Response.write(fromDate)
    ' Response.write("<br>")
    ' Response.write(toDate)
    '  Response.write("<br>")
    ' Response.write(inputsearch)
    connDB.Open()
    

%>


<!-- #include file="./layout/header.asp" -->
<div class="mt-4">
    <section class="content-header">
            <div class="container-fluid">
                <div class="row mb-2">
                    <div class="col-sm-6">
                        <h1>Statistics</h1>
                    </div>
                    <div class="col-sm-6">
                        <ol class="breadcrumb float-sm-right">
                            <li class="breadcrumb-item"><a href="index.asp">Home</a></li>
                            <li class="breadcrumb-item active">Statistics</li>
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
                <form name="form-search">
                    <div class="row m-2">
                        <div class="col-sm-5 pb-2">
                        </div>
                        <div class="col-sm-6">
                            <div class="form-inline" action="" style="justify-content: flex-end;">
                                Search by name: 
                                <div class="pl-2" style="display: inline-block;">
                                <input value="<%=inputsearch%>" class="form-control mr-sm-2" name="input-search"type="search" placeholder="Type name to search" aria-label="Search" style="min-width: 260px;">
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-5 d-flex justify-content-start">
                        </div>
                        <div class="col-7 d-flex justify-content-end">
                        <div class="col-sm-5">
                            <div class="form-group">
                                <label for="fromDate">Ngày bắt đầu:</label>
                                <input type="date" class="form-control" id="fromDate" name="from_date" value="<%=fromDate%>">
                            </div>
                        </div>
                        <div class="col-sm-5">
                            <div class="form-group">
                                <label for="toDate">Ngày kết thúc:</label>
                                <input type="date" class="form-control" id="toDate" name="to_date" value="<%=toDate%>">
                            </div>
                        </div>
                        <div class="col-sm-2" style="margin-top:30px">
                            <div class="form-group ">
                               <button class="btn btn-success my-2 my-sm-0" type="submit"><i class='fas fa-search' style='color:white'></i>  Search</button>
                            </div>
                        </div>
                        </div>
                    </div>
                </form>

                <div class="table-responsive table-hover">
                        <table class="table table-striped w-100 " id="products-datatable">
                            <thead class="table-light">
                            <tr>
                                
                                <th>ProductName</th>
                                <th>TotalQuantity</th>
                                <th>TotalValue</th>
                                <th></th>
                                <th></th>
                            </tr>
                        </thead>
                        <tbody>
                                <%
                                    Set cmdPrep = Server.CreateObject("ADODB.Command")
                                    cmdPrep.ActiveConnection = connDB
                                    cmdPrep.CommandType = 1
                                    cmdPrep.Prepared = True
                                    if(trim(fromDate) <> "") and (NOT IsEmpty(fromDate)) and trim(toDate) <> "" and (NOT IsEmpty(toDate)) and (trim(inputsearch) <> "") and (NOT IsEmpty(inputsearch)) then
                                        cmdPrep.CommandText = "SELECT p.ProductID, p.ProductName, SUM(od.Quantity) AS TotalQuantity, SUM(o.TotalAmount) AS TotalValue " & _
                                    "FROM Products p " & _
                                    "INNER JOIN OrderDetail od ON p.ProductID = od.ProductID " & _
                                    "INNER JOIN Orders o ON od.OrderID = o.OrderID " & _
                                    "Where OrderDate >='"&fromDate&"' AND OrderDate <= '"&toDate&"' and p.ProductName Like '%"&inputsearch&"%' " & _
                                    "GROUP BY p.ProductID, p.ProductName, o.TotalAmount " & _
                                    "ORDER BY TotalQuantity DESC"
                                    Elseif(trim(inputsearch) <>"") and (Not IsEmpty(inputsearch)) then
                                        cmdPrep.CommandText = "SELECT p.ProductID, p.ProductName, SUM(od.Quantity) AS TotalQuantity, SUM(o.TotalAmount) AS TotalValue " & _
                                        "FROM Products p " & _
                                        "INNER JOIN OrderDetail od ON p.ProductID = od.ProductID " & _
                                        "INNER JOIN Orders o ON od.OrderID = o.OrderID " & _
                                        "Where p.ProductName Like '%"&inputsearch&"%' " & _
                                        "GROUP BY p.ProductID, p.ProductName, o.TotalAmount " & _
                                        "ORDER BY TotalQuantity DESC"
                                    Elseif(trim(fromDate) <>"") and (Not IsEmpty(fromDate)) and trim(toDate) <>"" and (Not IsEmpty(toDate)) then
                                        cmdPrep.CommandText = "SELECT p.ProductID, p.ProductName, SUM(od.Quantity) AS TotalQuantity, SUM(o.TotalAmount) AS TotalValue " & _
                                        "FROM Products p " & _
                                        "INNER JOIN OrderDetail od ON p.ProductID = od.ProductID " & _
                                        "INNER JOIN Orders o ON od.OrderID = o.OrderID " & _
                                        "Where OrderDate >='"&fromDate&"' AND OrderDate <= '"&toDate&"'"& _
                                        "GROUP BY p.ProductID, p.ProductName, o.TotalAmount " & _
                                        "ORDER BY TotalQuantity DESC"
                                    Else
                                        cmdPrep.CommandText = "SELECT p.ProductID, p.ProductName, SUM(od.Quantity) AS TotalQuantity, SUM(o.TotalAmount) AS TotalValue " & _
                                        "FROM Products p " & _
                                        "INNER JOIN OrderDetail od ON p.ProductID = od.ProductID " & _
                                        "INNER JOIN Orders o ON od.OrderID = o.OrderID " & _
                                        "GROUP BY p.ProductID, p.ProductName, o.TotalAmount " & _
                                        "ORDER BY TotalQuantity DESC"
                                    End if
                                    Set Result = cmdPrep.execute
                                    Dim totalSalary
                                    totalSalary=0
                                    do while not Result.EOF

                                %>
                                <tr>
                                        
                                    <td class="align-middle">
                                       <%=Result("ProductName")%>
                                    </td>
                                    <td class="align-middle">
                                        <%=Result("TotalQuantity")%>
                                    </td>
                                    <td class="align-middle">
                                        <%=Result("TotalValue")%>
                                    </td>
                                    
                                    
                                </tr>
                               <%
                                totalSalary= totalSalary+Result("TotalValue")
                                Result.MoveNext
                                Loop
                               %>
                            <tfoot>
                                <tr>
                                <td><b>Total</b></td>
                                <td></td>
                                <td><%=totalSalary%></td>
                                <td></td>
                                
                                </tr>
                            </tfoot>
                        </tbody>
                    </table>
                    </form>
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

<!-- #include file="./layout/footer.asp" -->
        
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.1/dist/js/bootstrap.bundle.min.js" integrity="sha384-/bQdsTh/da6pkI1MST/rWKFNjaCP5gBSY4sEBT38Q/9RBh9AH40zEOg7Hlq2THRZ" crossorigin="anonymous"></script>
</body>
<html>