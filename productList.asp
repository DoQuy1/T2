<!-- #include file="database_product_read.asp" -->
<!-- #include file="database_category_read.asp" -->
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
' trang hien tai
    page = Request.QueryString("page")
    limit=9
    categoryid = Request.QueryString("categoryid")
    inputsearch=Request.QueryString("input-search")
    if(trim(page) = "") or (isnull(page)) then
        page=1
    end if
    if(trim(categoryid) = "") or (isnull(categoryid)) then
        if(trim(inputsearch) = "") or (IsEmpty(inputsearch)) then
        strSQL = "SELECT COUNT(ProductID) AS count FROM Products where Status='Enable'"
        currentUrl = "productList.asp?"
        else
            strSQL = "SELECT COUNT(ProductID) AS count FROM Products where Status='Enable' and ProductName like '%"&inputsearch&"%'"
            currentUrl = "productList.asp?input-search="&inputsearch&"&"
        end if
    else
        if(trim(inputsearch) = "") or (IsEmpty(inputsearch)) then
            strSQL = "SELECT COUNT(ProductID) AS count FROM Products where Status='Enable' and CategoryID="&categoryid&""
            currentUrl = "productList.asp?categoryid="&categoryid&"&"
        else
            strSQL = "SELECT COUNT(ProductID) AS count FROM Products where Status='Enable' and CategoryID="&categoryid&" and ProductName like '%"&inputsearch&"%'"
            currentUrl = "productList.asp?categoryid="&categoryid&"&input-search="&inputsearch&"&"
        end if
    end if

    connDB.Open()
    Set CountResult = connDB.execute(strSQL)

    totalRows = CLng(CountResult("count"))

    Set CountResult = Nothing
' lay ve tong so trang
    pages = Ceil(totalRows/limit)

    offset = (Clng(page) * Clng(limit)) - Clng(limit)
    
%>
<!-- #include file="./layout/header.asp" -->
<link rel="stylesheet" href="css/productlist.css">
<!-- Latest compiled and minified CSS -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" integrity="sha384-BVYiiSIFeK1dGmJRAkycuHAHRg32OmUcww7on3RYdg4Va+PmSTsz/K68vbdEjh4u" crossorigin="anonymous">
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
                <input type="text" value="<%=inputsearch%>"  name="input-search" id="input-search" placeholder="Keyword Search" class="form-control" />
                <input type="submit" hidden>
            </div>
        </section>
        </form>
        <section class="panel">
            <header class="panel-heading">
                Category
            </header>
            <div class="panel-body">
                <ul class="nav prod-cat">
                    <li>
                        <ul class="nav" style="flex-direction: column">
                            <%
                                for Each item in categories  
                            %>
                            <li class="<%=check(Clng(categoryid)=categories(item).Id,"active")%>"><a href="productList.asp?categoryid=<%=categories(item).Id%>">- <%=categories(item).Name%></a></li>
                            <%       
                                Next
                            %>
                        </ul>
                    </li>
                </ul>
            </div>
        </section>
        <section class="panel">
            <header class="panel-heading">
               Band
            </header>
             <div class="panel-body">
                <ul class="nav prod-cat">
                    <li>
                        <ul class="nav" style="flex-direction: column">
                            <li class="active"><a href="#">- Shirt</a></li>
                            <li><a href="#">- Pant</a></li>
                            <li><a href="#">- Shoes</a></li>
                        </ul>
                    </li>
                </ul>
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
        </section>

        <div class="row product-list">
            <%
                Set cmdPrep = Server.CreateObject("ADODB.Command")
                cmdPrep.ActiveConnection = connDB
                cmdPrep.CommandType = 1
                cmdPrep.Prepared = True
                if(trim(categoryid) = "") or (isnull(categoryid)) then
                    if(trim(inputsearch) = "") or (IsEmpty(inputsearch)) then
                    cmdPrep.CommandText = "SELECT * FROM Products where Status='Enable' ORDER BY ProductID OFFSET ? ROWS FETCH NEXT ? ROWS ONLY"
                    else
                        cmdPrep.CommandText = "SELECT * FROM Products where Status='Enable' and ProductName like '%"&inputsearch&"%' ORDER BY ProductID OFFSET ? ROWS FETCH NEXT ? ROWS ONLY"
                    end if 
                else
                    if(trim(inputsearch) = "") or (IsEmpty(inputsearch)) then
                    cmdPrep.CommandText = "SELECT * FROM Products where Status='Enable' and CategoryID="&categoryid&" ORDER BY ProductID OFFSET ? ROWS FETCH NEXT ? ROWS ONLY"
                    else
                    cmdPrep.CommandText = "SELECT * FROM Products where Status='Enable' and CategoryID="&categoryid&" and ProductName like '%"&inputsearch&"%' ORDER BY ProductID OFFSET ? ROWS FETCH NEXT ? ROWS ONLY"
                    end if
                end if
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
    </div>
</div>
<!-- #include file="./layout/footer.asp" -->
<script>
        $(document).ready(function() {
            $('#input-search').change(function() {
                $('#formsearch').submit();
            });
        });
</script>
</body>
</html>