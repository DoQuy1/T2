
<!-- #include file="connect.asp" -->
<%
' ham lam tron so nguyen
    function Ceil(Number)
        Ceil = Int(Number)
        if Ceil<>Number Then
            Ceil = Ceil + 1
        end if
    end function

    function check(cond, ret) 
        if cond=true then
            Response.write ret
        else
            Response.write ""
        end if
    end function
    Dim currentUrl, queryStringName
    currentUrl = Request.ServerVariables("SCRIPT_NAME")
    queryStringName = Request.ServerVariables("QUERY_STRING")
    ' Response.Write(currentUrl)
    ' Response.Write("<br>")
    



    If InStr(queryStringName, "page=") > 0 Then     
    ' Loại bỏ tham số phân trang khỏi query string
        queryStringName = Replace(queryStringName, "page=" & Request.QueryString("page"), "")
        queryStringName = Replace(queryStringName, "&&", "&") ' Xóa các dấu && thừa
        queryStringName = Replace(queryStringName, "?&", "?") ' Xóa dấu ?& thừa
        ' Kiểm tra nếu query string rỗng sau khi loại bỏ tham số phân trang
        If queryStringName = "" Then
            currentUrl = currentUrl
        Else
            currentUrl = currentUrl & "?" & queryStringName
        End If
    End If

    ' Response.Write(currentUrl)

    category_input=Request.QueryString("input_category")
    brand_input= Request.QueryString("input_brand")
    sort_by_price=Request.QueryString("sort_by_price")

' trang hien tai
    page = Request.QueryString("page")
    limit=1
    inputsearch=Request.QueryString("input-search")
    Response.Write("<br>")
    Response.Write(inputsearch)
    if(trim(page) = "") or (isnull(page)) then
        page=1
    end if
    If Trim(inputsearch) <> "" Then
        strSQL = "SELECT Count(*)as count FROM Products WHERE Status='Enable' AND ProductName LIKE '%" & inputsearch & "%'"
        if(not IsEmpty(sort_by_price)) Then
        Else
        currentUrl="productList.asp?input-search="&inputsearch&"&sort_by_price="&sort_by_price&"&"
        End if
    End If

    If Trim(brand_input) <> "" Then
        strSQL = "SELECT Count(*)as count FROM Products WHERE Status='Enable' AND Brand = '" & brand_input & "'"
        if(not IsEmpty(sort_by_price)) Then
        currentUrl="productList.asp?input_brand="&brand_input&"&sort_by_price="&sort_by_price&"&"
        Else
        currentUrl="productList.asp?input_brand="&brand_input&"&"
        End if
    End If

    If Trim(category_input) <> "" Then
        strSQL = "SELECT Count(*)as count FROM Products WHERE Status='Enable' AND CategoryID = " & category_input&""
        if(not IsEmpty(sort_by_price)) Then
        currentUrl="productList.asp?input_category="&category_input&"&sort_by_price="&sort_by_price&"&"
        Else
        currentUrl="productList.asp?input_category="&category_input&"&"
        End if
    End If

    If Trim(inputsearch) <> "" And Trim(category_input) <> "" Then
        ' Trường hợp tìm kiếm theo tên và category
        ' Xử lý lọc theo tên và category ở đây
        strSQL = "SELECT Count(*)as count FROM Products WHERE Status='Enable' AND CategoryID = " & category_input&" and ProductName LIKE '%"&inputsearch&"%'"
        if(not IsEmpty(sort_by_price)) Then
        currentUrl="productList.asp?input_category="&category_input&"&input-search="&inputsearch&"&sort_by_price="&sort_by_price&"&"
        Else
        currentUrl="productList.asp?input_category="&category_input&"&input-search="&inputsearch&"&"
        End if
    End If

    If Trim(inputsearch) <> "" And Trim(brand_input) <> "" Then
        ' Trường hợp tìm kiếm theo tên và brand
        ' Xử lý lọc theo tên và brand ở đây
        strSQL = "SELECT Count(*)as count FROM Products WHERE Status='Enable' AND Brand = '"&brand_input&"' and ProductName LIKE '%"&inputsearch&"%'"
        if(not IsEmpty(sort_by_price)) Then
        currentUrl="productList.asp?input_brand="&brand_input&"&input-search="&inputsearch&"&sort_by_price="&sort_by_price&"&"
        Else
        currentUrl="productList.asp?input_brand="&brand_input&"&input-search="&inputsearch&"&"
        End if
    End If

    If Trim(category_input) <> "" And Trim(brand_input) <> "" Then
         ' Trường hợp tìm kiếm theo category và brand
        ' Xử lý lọc theo category và brand ở đây
        strSQL = "SELECT Count(*)as count FROM Products WHERE Status='Enable' AND Brand = '"&brand_input&"' and CategoryID = " & category_input&""
        if(not IsEmpty(sort_by_price)) Then
        currentUrl="productList.asp?input_brand="&brand_input&"&input_category="&category_input&"&sort_by_price="&sort_by_price&"&"
        Else
        currentUrl="productList.asp?input_brand="&brand_input&"&input_category="&category_input&"&"
        End if
    End If

    If Trim(category_input) <> "" And Trim(brand_input) <> "" And Trim(inputsearch) <> "" Then
        ' Trường hợp tìm kiếm theo tên, category và brand
        ' Xử lý lọc theo tên, category và brand ở đây
        strSQL = "SELECT Count(*)as count FROM Products WHERE Status='Enable' AND Brand = '"&brand_input&"' and CategoryID = " & category_input&" and ProductName LIKE '%"&inputsearch&"%' "
        if(not IsEmpty(sort_by_price)) Then
        currentUrl="productList.asp?input_brand="&brand_input&"&input_category="&category_input&"&input-search="&inputsearch&"&sort_by_price="&sort_by_price&"&"
        Else
        currentUrl="productList.asp?input_brand="&brand_input&"&input_category="&category_input&"&input-search="&inputsearch&"&"
        End If
    End If
    If Trim(category_input) = "" And Trim(brand_input) = "" And Trim(inputsearch) = "" Then
        strSQL = "SELECT Count(*)as count FROM Products WHERE Status='Enable'"
        if(not IsEmpty(sort_by_price)) Then
            currentUrl="productList.asp?sort_by_price="&sort_by_price&"&"
        Else
             currentUrl="productList.asp?"
        End if
    end if



    connDB.Open()
    Set CountResult = connDB.execute(strSQL)

    totalRows = CLng(CountResult("count"))

    Set CountResult = Nothing
' lay ve tong so trang
    pages = Ceil(totalRows/limit)

    offset = (Clng(page) * Clng(limit)) - Clng(limit)
    
%>

<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" integrity="sha384-BVYiiSIFeK1dGmJRAkycuHAHRg32OmUcww7on3RYdg4Va+PmSTsz/K68vbdEjh4u" crossorigin="anonymous">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>  
<link rel="stylesheet" href="css/productlist.css">
<style>
    html{
        font-family: "Helvetica Neue",Helvetica,Arial,sans-serif;
        font-size: 14px;
        line-height: 1.42857143;
        color: #333;
        background-color: #fff;
    }
</style>
<body>
<div class="container mt-4" style="background: #f9f9f9;">
    <section class="content-header">
            <div class="container-fluid">
                <div class="row mb-2">
                    <div class="col-sm-6">
                        <h1>Product</h1>
                    </div>
                    <div class="col-sm-6">
                        <ol class="breadcrumb float-sm-right">
                            <li class="breadcrumb-item"><a href="index.asp">Home</a></li>
                            <li class="breadcrumb-item active">Product</li>
                        </ol>
                    </div>
                </div>
            </div>
        </section>
</div>

<div class="container bootdey"style="background: #f9f9f9;" >
    <div class="col-md-3">
        <form id="formsearch" action="">
        <section class="panel">
            <div class="panel-body">
                <input type="text" value="<%=Trim(inputsearch)%>"  name="input-search" id="input-search" placeholder="Keyword Search" class="form-control" />
                <input type="submit" hidden>
            </div>
        </section>
        </form>
        <section class="panel">
            <header class="panel-heading">
                Category
            </header>
            <div class="panel-body">
                <form method=get id="formcategory" action="">
                <%
                    Set cmdcategory = Server.CreateObject("ADODB.Command")
                    cmdcategory.ActiveConnection = connDB
                    cmdcategory.CommandType = 1
                    cmdcategory.Prepared = True
                    If Trim(inputsearch) <> "" or Not IsEmpty(inputsearch) Then
                        cmdcategory.CommandText = "SELECT CategoryID, COUNT(*) AS TotalCount FROM Products WHERE Status='Enable' and ProductName LIKE '%"&inputsearch&"%' GROUP BY CategoryID"
                    End if
                    If Trim(brand_input) <> "" Then
                        cmdcategory.CommandText = "SELECT CategoryID, COUNT(*) AS TotalCount FROM Products WHERE Status='Enable' AND Brand = '" & brand_input & "' GROUP BY CategoryID"
                    End If

                    If Trim(category_input) <> "" Then
                        cmdcategory.CommandText = "SELECT CategoryID, COUNT(*) AS TotalCount FROM Products WHERE Status='Enable' AND CategoryID = " & category_input&" GROUP BY CategoryID"
                    End If

                    If Trim(inputsearch) <> "" And Trim(category_input) <> "" Then
                        cmdcategory.CommandText = "SELECT CategoryID, COUNT(*) AS TotalCount FROM Products WHERE Status='Enable'and ProductName LIKE '%"&inputsearch&"%' and CategoryID="& category_input&" GROUP BY CategoryID"
                    End if

                    If Trim(inputsearch) <> "" And Trim(brand_input) <> "" Then
                        cmdcategory.CommandText = "SELECT CategoryID, COUNT(*) AS TotalCount FROM Products WHERE Status='Enable' AND Brand = '"&brand_input&" and ProductName LIKE '%"&inputsearch&"%' GROUP BY CategoryID"
                    End If

                    If Trim(category_input) <> "" And Trim(brand_input) <> "" Then
                        cmdcategory.CommandText = "SELECT CategoryID, COUNT(*) AS TotalCount FROM Products WHERE Status='Enable' AND Brand = '"&brand_input&"' and CategoryID = " & category_input&" GROUP BY CategoryID"
                    End If

                    If Trim(category_input) = "" And Trim(brand_input) = "" And Trim(inputsearch) = "" Then
                        cmdcategory.CommandText = "SELECT CategoryID, COUNT(*) AS TotalCount FROM Products WHERE Status='Enable' GROUP BY CategoryID"
                    End if

                    If Trim(category_input) <>"" And Trim(brand_input) <> "" And Trim(inputsearch) <> "" Then
                        cmdcategory.CommandText = "SELECT CategoryID, COUNT(*) AS TotalCount FROM Products WHERE Status='Enable' and Brand = '"&brand_input&"' and ProductName LIKE '%"&inputsearch&"%' and CategoryID="& category_input&" GROUP BY CategoryID"
                    End if
                        Set rsCategory = cmdcategory.execute
                        
                        Do While Not rsCategory.EOF
                            %>
                                <div class="m-2">
                                    <%
                                    category_id = rsCategory("CategoryID")
                                    Categorytemp = connDB.Execute("SELECT * FROM Category WHERE CategoryID=" & category_id)
                                    %>
                                    <input <%=check(Clng(category_input)=Clng(category_id),"checked")%> name="input_category" class="mr-2" type="checkbox" value="<%= category_id %>" id="<%=Categorytemp("CategoryName")%>">

                                    <label style="font-weight: 400" class="" >
                                        <a style="color:#222222" href=""><%= Categorytemp("CategoryName") %> (<%= rsCategory("TotalCount") %>)</a>
                                    </label>
                                </div>
                            <%
                            rsCategory.MoveNext
                        Loop
                        %>
                </form>
            </div>
        </section>
         <section class="panel">
            <header class="panel-heading">
               Brand
            </header>
             <div class="panel-body">
                <%
                Set brandGroup = Server.CreateObject("ADODB.Command")
                brandGroup.ActiveConnection = connDB
                brandGroup.CommandType = 1
                brandGroup.Prepared = True
                    If Trim(inputsearch) <> "" or Not IsEmpty(inputsearch) Then
                    brandGroup.CommandText="SELECT Brand, COUNT(ProductID) AS TotalCount FROM Products Where ProductName LIKE '%"&inputsearch&"%' and Status='Enable' GROUP BY Brand"
                    end if
                    If Trim(brand_input) <> "" Then
                        brandGroup.CommandText="SELECT Brand, COUNT(ProductID) AS TotalCount FROM Products Where Brand = '" & brand_input & "'And Status='Enable' GROUP BY Brand"
                    End If
                    If Trim(category_input) <> "" Then
                        brandGroup.CommandText="SELECT Brand, COUNT(ProductID) AS TotalCount FROM Products Where CategoryID="& category_input&" And Status='Enable' GROUP BY Brand"
                    End If
                    If Trim(category_input) = "" And Trim(brand_input) = "" And Trim(inputsearch) = "" Then
                        brandGroup.CommandText="SELECT Brand, COUNT(ProductID) AS TotalCount FROM Products Where Status='Enable' GROUP BY Brand"
                    End if
                     If Trim(inputsearch) <> "" And Trim(brand_input) <> "" Then
                        brandGroup.CommandText = "SELECT  Brand, COUNT(ProductID) AS TotalCount FROM Products WHERE Status='Enable' AND Brand = '"&brand_input&"' and ProductName LIKE '%"&inputsearch&"%' GROUP BY Brand"
                    End If
                    If Trim(category_input) <> "" And Trim(brand_input) <> "" Then
                        brandGroup.CommandText = "SELECT Brand, COUNT(ProductID) AS TotalCount FROM Products WHERE Status='Enable' AND Brand = '"&brand_input&"' and CategoryID = " & category_input&" GROUP BY Brand"
                    End If
                    If Trim(inputsearch) <> "" And Trim(category_input) <> "" Then
                        brandGroup.CommandText = "SELECT Brand, COUNT(ProductID) AS TotalCount FROM Products WHERE Status='Enable'and ProductName LIKE '%"&inputsearch&"%' and CategoryID="& category_input&" GROUP BY Brand"
                    End if
                    If Trim(category_input) <>"" And Trim(brand_input) <> "" And Trim(inputsearch) <> "" Then
                        brandGroup.CommandText = "SELECT Brand, COUNT(ProductID) AS TotalCount FROM Products WHERE Status='Enable' and Brand = '"&brand_input&"' and ProductName LIKE '%"&inputsearch&"%' and CategoryID="& category_input&" GROUP BY Brand"
                    End if
                        Set Resultbrand = brandGroup.execute
                        
                    Do While Not Resultbrand.EOF
                    %>
                    <div class="m-2">
                        <input <%=check(Cstr(brand_input)=Trim(Resultbrand("Brand")),"checked")%> name="input_brand" class="mr-2" type="checkbox" value="<%=trim(Resultbrand("Brand"))%>" id="">
                        <label style="font-weight: 400" class="" >
                            <%= Resultbrand("Brand") %> (<%= Resultbrand("TotalCount") %>)
                        </label>
                    </div>

                    <%
                   
                    Resultbrand.MoveNext
                    Loop
                    %>
            </div>
        </section>
        <section class="panel">
            <header class="panel-heading">
               Price range
            </header>
             <div class="panel-body">
                <div class="m-2">
                    <input class="mr-2" type="checkbox" value="1" id="">
                    <label  style="font-weight: 400" class="" >
                        From under $50
                    </label>
                </div>
                <div class="m-2">
                    <input class="mr-2" type="checkbox" value="2" id="">
                    <label  style="font-weight: 400" class="" >
                        From $50 - $150
                    </label>
                </div>
                <div class="m-2">
                    <input class="mr-2" type="checkbox" value="3" id="">
                    <label  style="font-weight: 400" class="" >
                        From $150 - $400
                    </label>
                </div>
                <div class="m-2">
                    <input class="mr-2" type="checkbox" value="3" id="">
                    <label  style="font-weight: 400" class="" >
                        From over $400 
                    </label>
                </div>
            </div>
        </section>
    </div>
    <div class="col-md-9">
        <section class="panel">
            <div class="panel-body">
                <div class="pull-left">
                    <a href="shoppingCart.asp" style="line-height: 40px;display: inline-block;padding-left: 0; margin: 20px 0;border-radius: 4px;">
                        <i class="fa fa-shopping-cart"> My Cart</i>
                    </a>
                </div>
                <div id="pagination" class="pull-right">
                    <!-- #include file="pagination.asp" -->
                </div>
            </div>
             <div class="d-flex justify-content-end p-3 ">
                <select id="sortbyprice" name ="sort_by_price" style="width:15%" class="form-select form-control p-1" aria-label="Default select example">
                    <option value="">Sort by Price</option>
                    <option <%=check(Cstr(sort_by_price)="ASC","selected")%> value="ASC">ASC</option>
                    <option <%=check(Cstr(sort_by_price)="DESC","selected")%> value="DESC">DESC</option>
                </select>
            </div>
            
        </section>

        <div class="row product-list">
            <%
                Set cmdPrep = Server.CreateObject("ADODB.Command")
                cmdPrep.ActiveConnection = connDB
                cmdPrep.CommandType = 1
                cmdPrep.Prepared = True
                if (trim(category_input) = "") and (IsEmpty(category_input)) and (trim(category_input) = "") and (IsEmpty(category_input)) and (trim(inputsearch) = "") and (IsEmpty(inputsearch)) then
                    if(not IsEmpty(sort_by_price)) Then
                        cmdPrep.CommandText = "SELECT * FROM Products where Status='Enable' ORDER BY Price "&sort_by_price&" OFFSET ? ROWS FETCH NEXT ? ROWS ONLY"  
                    Else
                    cmdPrep.CommandText = "SELECT * FROM Products where Status='Enable' ORDER BY ProductID OFFSET ? ROWS FETCH NEXT ? ROWS ONLY" 
                    End if
                End if
                If Trim(category_input) <> "" Then
                    if(not IsEmpty(sort_by_price)) Then
                    cmdPrep.CommandText = "SELECT * FROM Products where Status='Enable' AND CategoryID = " & category_input&" ORDER BY Price "&sort_by_price&" OFFSET ? ROWS FETCH NEXT ? ROWS ONLY"
                    Else
                    cmdPrep.CommandText = "SELECT * FROM Products where Status='Enable' AND CategoryID = " & category_input&" ORDER BY ProductID OFFSET ? ROWS FETCH NEXT ? ROWS ONLY"
                    End if
                End If
                If Trim(brand_input) <> "" Then
                    if(not IsEmpty(sort_by_price)) Then
                    cmdPrep.CommandText = "SELECT * FROM Products where Status='Enable' and Brand = '"&brand_input&"' ORDER BY Price "&sort_by_price&" OFFSET ? ROWS FETCH NEXT ? ROWS ONLY"
                    Else
                    cmdPrep.CommandText = "SELECT * FROM Products where Status='Enable' and Brand = '"&brand_input&"' ORDER BY ProductID OFFSET ? ROWS FETCH NEXT ? ROWS ONLY"
                    End If
                End if
                if((trim(inputsearch) <>"") and (Not IsEmpty(inputsearch))) then
                    if(not IsEmpty(sort_by_price)) Then
                    cmdPrep.CommandText = "SELECT * FROM Products where ProductName like '%"&inputsearch&"%' and Status='Enable' ORDER BY Price "&sort_by_price&" OFFSET ? ROWS FETCH NEXT ? ROWS ONLY"
                    Else
                    cmdPrep.CommandText = "SELECT * FROM Products where ProductName like '%"&inputsearch&"%' and Status='Enable' ORDER BY ProductID OFFSET ? ROWS FETCH NEXT ? ROWS ONLY"
                    End if
                End if
                If Trim(category_input) <> "" And Trim(brand_input) <> "" Then
                    if(not IsEmpty(sort_by_price)) Then
                    cmdPrep.CommandText = "SELECT * FROM Products WHERE Status='Enable' AND Brand = '"&brand_input&"' and CategoryID = " & category_input&" ORDER BY Price "&sort_by_price&" OFFSET ? ROWS FETCH NEXT ? ROWS ONLY"
                    Else
                    cmdPrep.CommandText = "SELECT * FROM Products WHERE Status='Enable' AND Brand = '"&brand_input&"' and CategoryID = " & category_input&" ORDER BY ProductID OFFSET ? ROWS FETCH NEXT ? ROWS ONLY"
                    End If
                End if
                If Trim(inputsearch) <> "" And Trim(category_input) <> "" Then
                    if(not IsEmpty(sort_by_price)) Then
                    cmdPrep.CommandText = "SELECT * FROM Products where Status='Enable' and ProductName LIKE '%"&inputsearch&"%' and CategoryID="& category_input&" ORDER BY Price "&sort_by_price&" OFFSET ? ROWS FETCH NEXT ? ROWS ONLY"
                    Else
                    cmdPrep.CommandText = "SELECT * FROM Products where Status='Enable' and ProductName LIKE '%"&inputsearch&"%' and CategoryID="& category_input&" ORDER BY ProductID OFFSET ? ROWS FETCH NEXT ? ROWS ONLY"
                    End if
                End if
                If Trim(category_input) <>"" And Trim(brand_input) <> "" And Trim(inputsearch) <> "" Then
                    if(not IsEmpty(sort_by_price)) Then
                    cmdPrep.CommandText = "SELECT * FROM Products WHERE Status='Enable' and Brand = '"&brand_input&"' and ProductName LIKE '%"&inputsearch&"%' and CategoryID="& category_input&" ORDER BY Price "&sort_by_price&" OFFSET ? ROWS FETCH NEXT ? ROWS ONLY"
                    Else
                    cmdPrep.CommandText = "SELECT * FROM Products WHERE Status='Enable' and Brand = '"&brand_input&"' and ProductName LIKE '%"&inputsearch&"%' and CategoryID="& category_input&" ORDER BY ProductID OFFSET ? ROWS FETCH NEXT ? ROWS ONLY"
                    End if
                End if
                cmdPrep.parameters.Append cmdPrep.createParameter("offset",3,1, ,offset)
                cmdPrep.parameters.Append cmdPrep.createParameter("limit",3,1, , limit)

                Set Result = cmdPrep.execute
                do while not Result.EOF
            %>
            <div class="col-md-4">
                <section class="panel">
                    <div class="pro-img-box">
                        <img src="<%=Result("Image")%>" alt="Image" />
                        <a href="addCart.asp?idproduct=<%=Result("ProductID")%>" class="adtocart">
                            <i class="fa fa-shopping-cart"></i>
                        </a>
                    </div>
                    <div class="panel-body text-center">
                        <h4>
                            <a href="productDetail.asp?id=<%=Result("ProductID")%>" class="pro-title">
                                <%=Result("ProductName")%>
                            </a>
                        </h4>
                        <p class="price"><%=Result("Price")%></p>
                        <button type="button" class="btn btn-outline-primary"><a href="payment.asp">Buy Now</a></button>
                    </div>
                </section>
            </div>
            <%
                Result.MoveNext
            loop
            %>
        </div>
        <div id="pagination" class="pull-right">
            <!-- #include file="pagination.asp" -->
        </div>
    </div>
</div>
<!-- #include file="./layout/footer.asp" -->

<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script>
        $(document).ready(function() {
            $('#input-search').change(function() {
                $('#formsearch').submit();
            });
        });

        $(document).ready(function() {
            $('input[name="input_category"]').change(function() {
                updateSearchParam();
            });
        });

        $(document).ready(function() {
            $('input[name="input_brand"]').change(function() {
                updateSearchParam();
            });
        })

        $(document).ready(function() {
            $('#sortbyprice').change(function() {
                updateSearchParam();
            });
        })

function updateSearchParam() {
    var searchByCategory = $('input[name="input_category"]').is(':checked');
    var searchByBrand = $('input[name="input_brand"]').is(':checked');
    var searchName = $("#input-search").val();
    var sortByPrice = $("#sortbyprice").find(":selected").val();
    var url = new URL(window.location.href);

    if (sortByPrice !== "") {
        url.searchParams.set("sort_by_price", sortByPrice);
    } else {
        url.searchParams.delete("sort_by_price");
    }

    if (searchByCategory) {
        var categoryValue = $('input[name="input_category"]').filter(':checked').val();
        url.searchParams.set("input_category",categoryValue );
    } else {
        url.searchParams.delete("input_category");
    }

    if (searchByBrand) {
        var brandValue = $('input[name="input_brand"]').filter(':checked').val();
        url.searchParams.set("input_brand", brandValue);
    } else {
        url.searchParams.delete("input_brand");
    }

    if (searchName !== "") {
        url.searchParams.set("input-search", searchName);
    } else {
        url.searchParams.delete("input-search");
    }
    // Cập nhật URL trong thanh địa chỉ của trình duyệt
        url.searchParams.delete("page");
     window.location.href = url.href.replace(/\++$/g, '');
}
</script>
</body>
</html>