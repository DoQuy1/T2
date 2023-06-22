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
                            <li class="breadcrumb-item"><a href="index.asp">Home</a></li>
                            <li class="breadcrumb-item active">Product Details</li>
                        </ol>
                    </div>
                </div>
            </div>
        </section>
</div>

	<div class="pd-wrap">
		<div class="container">
	        <div class="heading-section">
	            <h2>Product Details</h2>
	        </div>
	        <div class="row">
	        	<div class="col-md-6">
	        		<div id="slider" class="owl-carousel product-slider">
						<div class="item">
						  	<img src="https://images.unsplash.com/photo-1505740420928-5e560c06d30e?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&w=1000&q=80" />
						</div>
					</div>
	        	</div>
	        	<div class="col-md-6">
	        		<div class="product-dtl">
        				<div class="product-info">
		        			<div class="product-name"><%=Result("ProductName")%></div>
		        			<div class="product-price-discount"><span>$<%=Result("Price")%></span><span class="line-through">$29.00</span></div>
		        		</div>
	        			<p><%=Result("Description")%></p>
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
				  	<li class="nav-item">
				    	<a class="nav-link active" id="description-tab" data-toggle="tab" href="#description" role="tab" aria-controls="description" aria-selected="true">Description</a>
				  	</li>
				</ul>
				<div class="tab-content" id="myTabContent">
				  	<div class="tab-pane fade show active" id="description" role="tabpanel" aria-labelledby="description-tab">
				  		Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum. Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam.
				  	</div>
				</div>
			</div>
			
		</div>
	</div>
	
	<!-- #include file="./layout/footer.asp" -->
<script src="//maxcdn.bootstrapcdn.com/bootstrap/4.1.1/js/bootstrap.min.js"></script>
<script src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
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
	
</script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/OwlCarousel2/2.3.4/owl.carousel.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js" integrity="	sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>
<script src="./js/custom.js"></script>

</body>
<html>