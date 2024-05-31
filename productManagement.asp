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
                        </div>
                        <div class="col-sm-6">
                                <form class="form-inline" action="searchProduct.asp" style="justify-content: flex-end;">
                                <input class="form-control mr-sm-2" name="input-search"type="search" placeholder="Search" aria-label="Search" style="min-width: 260px;">
                                <select class="form-select form-control mr-sm-2" aria-label="Default select example">
                                    <option selected>--Type--</option>
                                    <option value="1">Name</option>
                                    <option value="2">Category</option>
                                    <option value="3">Price</option>
                                </select>
                                <button class="btn btn-outline-success my-2 my-sm-0" type="submit">Search</button>
                                </form>
                        </div>
                    </div>

                    <div class="table-responsive table-hover">
                        <table class="table w-100 " id="products-datatable">
                            <thead class="table-light">
                                <tr>
                                    <th class="" style="width: 20px;">
                                        <div class="form-check">
                                            <input type="checkbox" class="form-check-input" id="customCheck1">
                                            <label class="form-check-label" for="customCheck1">&nbsp;</label>
                                        </div>
                                    </th>
                                    <th style="width: 20%;">Product</th>
                                    <th>Category</th>
                                    <th>Added Date</th>
                                    <th>Price</th>
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
                                            <input type="checkbox" class="form-check-input" id="customCheck2">
                                            <label class="form-check-label" for="customCheck2">&nbsp;</label>
                                        </div>
                                    </td>
                                    <td class="align-middle">
                                        <img src="/images/dress-shirt-img.png" alt="contact-img" title="contact-img" class="rounded me-3" style="width: 50%;" />
                                        <p class="m-0 d-inline-block align-middle font-16">
                                            <a href="productDetail.asp?id=<%=Result("ProductID")%>" class="text-body"><%=Result("ProductName")%></a>
                                        </p>
                                    </td>
                                    <td class="align-middle">
                                        
                                    </td>
                                    <td class="align-middle">
                                        
                                    </td>
                                    <td class="align-middle">
                                        <%=Result("Price")%>
                                    </td>

                                    <td class="align-middle">
                                        
                                        <%=Result("Status")%>
                                    </td>

                                    <td class="align-middle" >
                                        <%
                                            if (Result("Status") = "enable") then
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
        </script>
</body>
<html>