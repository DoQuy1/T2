
<!-- #include file="connect.asp" -->
<%
  connDB.Open()
  dim strSQL 
  strSQL= "SELECT ProductID, SUM(Quantity) AS TotalQuantity FROM OrderDetail GROUP BY ProductID ORDER BY TotalQuantity DESC"
  set maxResult=connDB.execute(strSQL)
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
                        <div class="col-sm-6 pb-2 ">
                            <button class="btn btn-danger mb-2"><i class="mdi mdi-plus-circle me-2"></i>San pham duoc ban nhieu nhat</button>
                            <p hidden>So luong ban:<%=TotalQuantity%><p>
                        </div>
                        <div class="col-sm-6 pb-2">
                            <button class="btn btn-danger mb-2"><i class="mdi mdi-plus-circle me-2"></i>San pham duoc ban it nhat</button>
                            <p hidden>So luong ban<p>
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
                                    
                                    Dim idcategory
                                    Do while not maxResult.EOF
                                    id = maxResult("ProductID")
                                    if not isnull(id) then 
                                    sqlstr = "Select * From Products where ProductID="&id&""
                                    set Result = connDB.execute(sqlstr)
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
                                            <a href="productDetail.asp?id=<%=Result("ProductID")%>" class="text-body"></a>
                                        </p>
                                    </td>
                                    <%
                                        categoryid=Result("CategoryID")
                                        sql = "Select * From Category where CategoryID="&categoryid&""
                                        set rs = connDB.execute(sql)

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
                                            <a href="isStatus.asp?idproduct=<%=maxResult("ProductID")%>"><i class="fa-regular fa-eye"></i></a>
                                        <%
                                            else 
                                        %>
                                        <a href="isStatus.asp?idproduct=<%=maxResult("ProductID")%>"><i class="fa-regular fa-eye-slash"></i></a>
                                        <%
                                            end if
                                        %>
                                        <a href="addeditProduct.asp?idproduct=<%=maxResult("ProductID")%>"><i class="fa-regular fa-pen-to-square"></i></a>
                                        <a data-href="deleteProduct.asp?idproduct=<%=maxResult("ProductID")%>" data-bs-toggle="modal" data-bs-target="#confirm-delete" title="Delete"><i class="fa-regular fa-trash-can" style="cursor: pointer;color:#007bff"></i></a>
                                    </td>
                                </tr>
                                <%
                                        end if
                                        maxResult.MoveNext
                                    loop
                                %>
                            </tbody>
                        </table>
                    </div>
                    </form>
                </div> <!-- end card-body-->
            </div> <!-- end card-->
           
            
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