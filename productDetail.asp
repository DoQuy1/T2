<!--#include file="connect.asp"-->
<%
    ' code here to retrive the data from product table
    Dim idProduct
    idProduct = Request.QueryString("id")
    If (NOT IsNull(idProduct) and idProduct <> "") Then
        Dim cmdPrep, Result
        Set cmdPrep = Server.CreateObject("ADODB.Command")
            connDB.Open()
            cmdPrep.ActiveConnection = connDB
            cmdPrep.CommandType = 1
            cmdPrep.CommandText = "SELECT * FROM Products WHERE ProductID=?"
            cmdPrep.Parameters(0)=idProduct
            Set Result = cmdPrep.execute      
    End if    
	Dim quantityValue
	If Request.Form("quantity") <> "" Then
		quantityValue = CInt(Request.Form("quantity"))
	Else
		quantityValue = 1
	End If
%>

<!-- #include file="./layout/header.asp" -->
<div class="container mt-4">
    <section class="content-header">
            <div class="container-fluid">
                <div class="row mb-2">
                    <div class="col-sm-6">
                        <h1>Product Details</h1>
                    </div>
                    <div class="col-sm-6">
                        <ol class="breadcrumb float-sm-right">
                            <li class="breadcrumb-item" style="list-style-type: none;"><a href="index.asp">Home</a></li>
                            <li class="breadcrumb-item active" style="list-style-type: none;">Product Details</li>
                        </ol>
                    </div>
                </div>
            </div>
        </section>
</div>

	<div class="pd-wrap" style="background-color:#ededed">
		<div class="container">
	        <div class="heading-section">
	            <h2>Product Details</h2>
	        </div>
	        <div class="row">
	        	<div class="col-md-6">
	        		<div id="slider" class="owl-carousel product-slider">
						<div class="item">
						  	<img src="<%=Result("Image")%>" />
						</div>
					</div>
	        	</div>
	        	<div class="col-md-6">
	        		<div class="product-dtl">
        				<div class="product-info">
		        			<div class="product-name"><%=Result("ProductName")%></div>
		        			<div class="product-price-discount"><span>$<%=Result("Price")%></span><span class="line-through">$29.00</span></div>
		        		</div>
	        			<div class="product-count">
	        				<label for="size">Quantity</label>
	        				<form id ="myForm"  method="post" action="">
							    <div class="d-flex">
								<div class="qtyminus" id="minus" onclick="decrement()"  >-</div>
									<input id = "quantity" min =1 type="number" name="quantity" value="<%=quantityValue%>" class="qty">
									<div class="qtyplus" id ="plus" onclick="increment()" >+</div>
								</div>
							<button type="button" onclick="addToCart()" class="round-black-btn">Add to Cart</button>
    						<button type="button" onclick="buyNow()" class="round-black-btn">Buy Now</button>
							</form>
	        			</div>
	        		</div>
	        	</div>
	        </div>
	        <div class="product-info-tabs">
				<ul class="nav nav-tabs" id="myTab" role="tablist">
					<li class="nav-item" style="list-style-type: none;">
						<a class="nav-link active" id="description-tab" data-toggle="tab" href="#description" role="tab" aria-controls="description" aria-selected="true">Description</a>
					</li>
					<li class="nav-item" style="list-style-type: none;">
						<a class="nav-link" id="specification-tab" data-toggle="tab" href="#specification" role="tab" aria-controls="specification" aria-selected="false">Specification</a>
					</li>
				</ul>

				<div class="tab-content" id="myTabContent">
					<div class="tab-pane fade show active" id="description" role="tabpanel" aria-labelledby="description-tab">
						<!-- Description content goes here -->
						<%=Result("Description")%>
					</div>
					<div class="tab-pane fade " id="specification" role="tabpanel" aria-labelledby="specification-tab">
						<!-- Specification content goes here -->
						<%=Result("Specification")%>
					</div>
				</div>
			</div>
			
			
		</div>
	</div>
	
	<!-- #include file="./layout/footer.asp" -->
<script src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>


<script src="./js/custom.js"></script>
<link rel="stylesheet" href="./css/productDetail.css">
<script>
    var idProduct = "<%=idProduct%>";

    function addToCart() {
       document.getElementById('myForm').action = 'addCart.asp?idproduct='+idProduct;
        document.getElementById('myForm').submit();
    }

    function buyNow() {
         document.getElementById('myForm').action = 'payment.asp?productId='+idProduct;
        document.getElementById('myForm').submit();
    }

	function increment() {
        var quantityInput = document.getElementById('quantity');
        quantityInput.stepUp();
        document.getElementById('myForm').submit();
    }

    function decrement() {
        var quantityInput = document.getElementById('quantity');
        quantityInput.stepDown();
        document.getElementById('myForm').submit();
    }
	
    $(document).ready(function() {
        $('#myTab a').on('click', function(event) {
            event.preventDefault();
            $(this).tab('show');
        });
    });

</script>


</body>
<html>