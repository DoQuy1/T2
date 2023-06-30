<!-- #include file="./layout/header.asp" -->
   <!--#include file="connect.asp"-->
<%

'lay ve danh sach product theo id trong my cart
Dim idList, mycarts, totalProduct, subtotal, statusViews, rs
If (NOT IsEmpty(Session("mycarts"))) Then
  statusViews = "d-none"
  statusButtons = "d-block"
' true
	Set mycarts = Session("mycarts")
	idList = ""
	totalProduct=mycarts.Count    
	For Each List In mycarts.Keys
		If (idList="") Then
' true
			idList = List
		Else
			idList = idList & "," & List
		End if                               
	Next
	Dim sqlString
	sqlString = "Select * from Products where ProductID IN (" & idList &")"
	connDB.Open()
	set rs = connDB.execute(sqlString)
	calSubtotal(rs)
  Else
    'Session empty
    statusViews = "d-block"
    statusButtons = "d-none"
    totalProduct=0
  End If
  Sub calSubtotal(rs)
' Do Something...
		subtotal = 0
		do while not rs.EOF
			subtotal = subtotal + Clng(mycarts.Item(CStr(rs("ProductID")))) * CDbl(CStr(rs("Price")))
			rs.MoveNext
		loop
		rs.MoveFirst
	End Sub
  Sub defineItems(v)
    If (v>1) Then
      Response.Write(" Items")
    Else
      Response.Write(" Item")
    End If
  End Sub
%>


<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Carts</title>
    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.5.0/css/all.css" integrity="sha384-B4dIYHKNBt8Bc12p+WXckhzcICo0wtJAoU8YZTY5qE0Id1GSseTk6S+L3BlXeVIU" crossorigin="anonymous">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet"
        integrity="sha384-GLhlTQ8iRABdZLl6O3oVMWSktQOp6b7In1Zl3/Jr59b6EGGoI1aFkw7cmDA6j6gD" crossorigin="anonymous">

</head>
<body>
  

 <%
      If (NOT isnull(Session("Error"))) AND (TRIM(Session("Error"))<>"") Then
  %>
            <div class="alert alert-danger" role="alert">
              <%=Session("Error")%>
            </div>
  <%
            Session.Contents.Remove("Error")
      End If
  %>

<div class="container">
  <%
    If (not isnull(Session("CustomerID")) and not isnull(Session("admin"))) Then
          Response.Write("<input hidden id='checkCustomer' name='checkCustomer' value='checkuser'")
    Else
      Response.Write("<input hidden id='checkCustomer' name='checkCustomer' ")
    End If
  %>
<div class="wrapper wrapper-content animated fadeInRight">
    <div class="mt-4">
    <section class="content-header">
            <div class="container-fluid">
                <div class="row mb-2">
                    <div class="col-sm-6">
                        <h1>Shopping Cart</h1>
                    </div>
                    <div class="col-sm-6">
                        <ol class="breadcrumb float-sm-right">
                            <li class="breadcrumb-item"><a href="index.asp">Home</a></li>
                            <li class="breadcrumb-item active">Shopping Cart</li>
                        </ol>
                    </div>
                </div>
            </div>
        </section>
    </div>
    <div class="row">
        <div class="col-md-9">
            <div class="ibox">
                <div class="ibox-title">
                    <span class="float-end"><%= totalProduct %> <%call defineItems(totalProduct) %></span>
                    <h5>Items in your cart</h5>
                    <h5 class="<%= statusButtons %>"><input name="select-all" id="select-all" type="checkbox" style="margin: 0 15px;" >Select All</h5>
                  <h5 class="mt-3 text-center text-body-secondary <%= statusViews %>">You have no products added in your shopping cart.</h5>
                </div>
              <form action="removecart.asp" method=post id ="myForm">
                <%
                If (totalProduct<>0) Then
                do while not rs.EOF
                %>
                <div class="ibox-content">
                    <div class="table-responsive">
                        <table class="table shoping-cart-table">
                            <tbody>
                            <tr>
                                <td class="align-middle" width="5">
                                  <input id="checkitem"type="checkbox" name="cb-selector" value="<%=rs("ProductID")%>" data-totalprice="<%=rs("Price")*mycarts.Item(CStr(rs("ProductID")))%>">
                                </td>
                                <td width="90">
                                    <div class="">
                                      <img src="<%=rs("Image")%>" alt="" >
                                    </div>
                                </td>
                                <td class="desc">
                                    <h3>
                                    <a href="#" class="text-navy">
                                        <%=rs("ProductName")%>
                                    </a>
                                    </h3>
                                    <p class="small">
                                        <%=rs("Brand")%>
                                    </p>
                                    <!--<div class="m-t-sm">
                                        <a href="#" class="text-muted"><i class="fa fa-gift"></i> Add gift package</a>
                                        
                                        <a href="" class="text-muted"><i class="fa fa-trash"></i> Remove item</a>
                                    </div>-->
                                </td>

                                <td width="65">
                                    <div class="col-md-3 col-lg-3 col-xl-2 d-flex">
                                        <button class="btn btn-link px-2" name="btn-up-down"
                                            onclick="this.parentNode.querySelector('input[type=number]').stepDown()">
                                            <i class="fas fa-minus"></i>
                                        </button>

                                        <input style="width:60px"id="form1" min="0" name="quantity" value="<%
                                                        Dim id
                                                        id  = CStr(rs("ProductID"))
                                                        Response.Write(mycarts.Item(id))                                     
                                                        %>" type="number"
                                            class="form-control form-control-sm" />

                                        <button class="btn btn-link px-2" name="btn-up-down"
                                            onclick="this.parentNode.querySelector('input[type=number]').stepUp()">
                                            <i class="fas fa-plus"></i>
                                        </button>
                                    </div>
                                </td>
                                <td>
                                    <h4>
                                        $<%=rs("Price")%>
                                        <s class="small text-muted"></s>
                                    </h4>
                                </td>
                                <td>
                                    <a href="removecart.asp?id=<%=rs("ProductID")%>" class="text-muted"><i class="fa fa-trash"></i></a>
                                </td>
                            </tr>
                            </tbody>
                        </table>
                    </div>

                </div>
                <%
                rs.MoveNext
                loop
                'phuc vu cho viec update subtotal
                rs.MoveFirst
                End If
                %> 

                 <div class="ibox-content">
                    <div class="row">
                        <div class="col">
                          <a href="productList.asp"class="btn btn-white"><i class="fa fa-arrow-left"></i> Continue shopping</a>
                        </div>
                        <div class="col d-flex justify-content-end">
                          <input type="hidden" name="sub_checkout" id="sub_checkout" value="">
                          <input type="submit" id="checkout" name="checkout" value="Checkout" class="btn btn-primary btn-md pull-right mr-2  <%= statusButtons %>"></input>
                          <input type="submit" name="update" value="Update" class="mr-2 pull-right btn btn-warning  btn-md text-white <%= statusButtons %>"
                          data-mdb-ripple-color="dark"/>
                        </div>
                    </div>
                </div>
              </form>
            </div>
        </div>

        <div class="col-md-3">
            <div class="ibox">
                <div class="ibox-title">
                    <h5>Cart Summary</h5>
                </div>
                <div class="ibox-content">
                    <span>
                        Total
                    </span>
                    <h2 class="font-bold" id="total">
                        $ <%= subtotal %>
                    </h2>

                    <hr>
                    <span class="text-muted small">
                        *For United States, France and Germany applicable sales tax will be applied
                    </span>
                    <div class="m-t-sm">
                        <div class="btn-group">
                        <input style="border-radius:7px" type="button" name ="myButton" id = "myButton" value="Checkout" class="btn btn-primary <%= statusButtons %>"></input>
                        <a href="productList.asp" class="btn btn-white btn-sm"> Cancel</a>
                        </div>
                    </div>
                </div>
            </div>

            <div class="ibox">
                <div class="ibox-title">
                    <h5>Support</h5>
                </div>
                <div class="ibox-content text-center">
                    <h3><i class="fa fa-phone"></i> +43 100 783 001</h3>
                    <span class="small">
                        Please contact with us if you have any questions. We are avalible 24h.
                    </span>
                </div>
            </div>
        </div>
    </div>
</div>
</div>
        <div class="modal" tabindex="-1" id="confirmModal">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title">Confirmation</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                        <p>You must be logged in to get paid! 
                        <br>Click continue to go to the login page, click Close to cancel </p>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary"  id="cancelButton" data-bs-dismiss="modal">Close</button>
                        <a href="login.asp"class="btn btn-danger btn-delete" id="continueButton">Countinue</a>
                    </div>
                </div>
            </div>
        </div>
<!-- #include file="./layout/footer.asp" -->
</body>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.1/dist/js/bootstrap.bundle.min.js" 
integrity="sha384-/bQdsTh/da6pkI1MST/rWKFNjaCP5gBSY4sEBT38Q/9RBh9AH40zEOg7Hlq2THRZ" 
crossorigin="anonymous">
</script> 
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>  
<script>

    $(document).ready(function() {
       $("#checkout").click(function(event) {
            var idcustomer = $("#checkCustomer").val();
            if(idcustomer==""){
              event.preventDefault()
              $("#confirmModal").modal('show');
            }
            else{ 
              $("#myForm").submit();
            }
          })
          
       });




    window.setTimeout(function() {
    $(".alert").fadeTo(500, 0).slideUp(500, function(){
        $(this).remove(); 
    });
}, 2000);

    $(document).ready(function() {
       $("#myButton").click(function(event) {
          var idcustomer = $("#checkCustomer").val();
            if(idcustomer==""){
              event.preventDefault()
              $("#confirmModal").modal('show');
            }
            else{ 
              $("#myForm").submit();
            }
       });
    });

   $(document).ready(function() {
      // Theo dõi sự kiện click của checkbox
      $('input[type="checkbox"]').on('click', function() {
        var total = 0;
        
        // Duyệt qua tất cả checkbox
        $('input[type="checkbox"]:checked').each(function() {
          // Lấy giá trị của checkbox và cộng vào tổng
          var price = parseFloat($(this).data('totalprice'));
          total += price;
        });
        
        // Hiển thị tổng tiền
        $('#total').text("$"+total.toFixed(2));
      });
    });

  $('#select-all').click(function(event) {   
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
</script>
</html>



<style>
    body{margin-top:20px;
    background:#eee;
  }
  h3 {
      font-size: 16px;
  }
  .text-navy {
      color: #1ab394;
  }
  .cart-product-imitation {
    text-align: center;
    padding-top: 30px;
    height: 80px;
    width: 80px;
    background-color: #f8f8f9;
  }
  .product-imitation.xl {
    padding: 120px 0;
  }
  .product-desc {
    padding: 20px;
    position: relative;
  }
  .ecommerce .tag-list {
    padding: 0;
  }
  .ecommerce .fa-star {
    color: #d1dade;
  }
  .ecommerce .fa-star.active {
    color: #f8ac59;
  }
  .ecommerce .note-editor {
    border: 1px solid #e7eaec;
  }
  table.shoping-cart-table {
    margin-bottom: 0;
  }
  table.shoping-cart-table tr td {
    border: none;
    text-align: right;
  }
  table.shoping-cart-table tr td.desc,
  table.shoping-cart-table tr td:first-child {
    text-align: left;
  }
  table.shoping-cart-table tr td:last-child {
    width: 80px;
  }
  .ibox {
    clear: both;
    margin-bottom: 25px;
    margin-top: 0;
    padding: 0;
  }
  .ibox.collapsed .ibox-content {
    display: none;
  }
  .ibox:after,
  .ibox:before {
    display: table;
  }
  .ibox-title {
    -moz-border-bottom-colors: none;
    -moz-border-left-colors: none;
    -moz-border-right-colors: none;
    -moz-border-top-colors: none;
    background-color: #ffffff;
    border-color: #e7eaec;
    border-image: none;
    border-style: solid solid none;
    border-width: 3px 0 0;
    color: inherit;
    margin-bottom: 0;
    padding: 14px 15px 7px;
    min-height: 48px;
  }
  .ibox-content {
    background-color: #ffffff;
    color: inherit;
    padding: 15px 20px 20px 20px;
    border-color: #e7eaec;
    border-image: none;
    border-style: solid solid none;
    border-width: 1px 0;
  }
  .ibox-footer {
    color: inherit;
    border-top: 1px solid #e7eaec;
    font-size: 90%;
    background: #ffffff;
    padding: 10px 15px;
  }
</style>
