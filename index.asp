<!-- #include file="connect.asp" -->
<%
    function Ceil(Number)
        Ceil = Int(Number)
        if Ceil<>Number Then
            Ceil = Ceil + 1
        end if
    end function
    limit = 3
    connDB.Open()
    strSQL = "SELECT COUNT(ProductID) AS count FROM Products where Status ='Enable'"
    Set CountResult = connDB.execute(strSQL)

    totalRows = CLng(CountResult("count"))

    Set CountResult = Nothing
' lay ve tong so trang
    pages = Ceil(totalRows/limit)
%>

<!-- #include file="./layout/header.asp" -->
      <!-- banner bg main start -->
      <div class="banner_bg_main">
         <!-- header top section start -->
        
         <!-- header top section start -->
         <!-- logo section start -->
         <div class="logo_section">
            <div class="container">
               <div class="row">
                  <div class="col-sm-12">
                     <div class="logo"><a href="index.asp"><img src="images/logo.png"></a></div>
                  </div>
               </div>
            </div>
         </div>
         <!-- logo section end -->
         <!-- header section start -->
         <div class="header_section">
            <div class="container">
               <div class="containt_main">
                  <div id="mySidenav" class="sidenav">
                     <a href="javascript:void(0)" class="closebtn" onclick="closeNav()">&times;</a>
                     <a href="index.asp">Home</a>
                     <a href="productList.asp">Danh sách sản phẩm</a>
                     <a href="userManagement.asp">Quản lý tài khoản người dùng</a>
                     <a href="productManagement.asp">Quản lý sản phẩm</a>
                     <a href="orderManagement.asp">Quản lý hóa đơn</a>
                  </div>
                  <span class="toggle_icon" onclick="openNav()"><img src="images/toggle-icon.png"></span>
                  <div class="dropdown">
                     <button class="btn btn-secondary dropdown-toggle" type="button" id="dropdownMenuButton" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">All Category 
                     </button>
                     <div class="dropdown-menu" aria-labelledby="dropdownMenuButton">
                        <a class="dropdown-item" href="#inear_main_slider">Tai Nghe In Ear</a>
                        <a class="dropdown-item" href="#onear_main_slider">Tai Nghe On Ear</a>
                        <a class="dropdown-item" href="#over_main_slider">Tai Nghe Over Ear</a>
                     </div>
                  </div>
                  <div class="main">
                     <!-- Another variation with a button -->
                     <div class="input-group">
                        <input type="text" class="form-control" placeholder="Search this blog">
                        <div class="input-group-append">
                           <button class="btn btn-secondary" type="button" style="background-color: #f26522; border-color:#f26522 ">
                           <i class="fa fa-search"></i>
                           </button>
                        </div>
                     </div>
                  </div>
                  <div class="header_box">
                     <div class="lang_box ">
                        <a href="#" title="Language" class="nav-link" data-toggle="dropdown" aria-expanded="true">
                        <img src="images/flag-uk.png" alt="flag" class="mr-2 " title="United Kingdom"> English <i class="fa fa-angle-down ml-2" aria-hidden="true"></i>
                        </a>
                        <div class="dropdown-menu ">
                           <a href="#" class="dropdown-item">
                           <img src="images/flag-france.png" class="mr-2" alt="flag">
                           French
                           </a>
                        </div>
                     </div>
                     <div class="login_menu">
                        <ul>
                           <li><a href="shoppingCart.asp">
                              <i class="fa fa-shopping-cart" aria-hidden="true"></i>
                              <span class="padding_10">Cart</span></a>
                           </li>
                           <li>
                           <div class="dropdown">
                              <button class="btn btn-secondary dropdown-toggle" type="button" id="dropdownMenuButton" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false"><i class="fa fa-user" aria-hidden="true"></i>
                              <span class="padding_10">User</span></a>
                              </button>
                              <div class="dropdown-menu" aria-labelledby="dropdownMenuButton">
                                 <%
                                    If (NOT IsEmpty(Session("CustomerID"))) Then
                                 %>
                                    <a class="dropdown-item" href="userDetail.asp?id=<%=Session("CustomerID")%>" style="color:black">Information</a>
                                    <a class="dropdown-item" href="purchaseForm.asp?id=<%=Session("CustomerID")%>" style="color:black">Purchase Form</a>
                                    <a class="dropdown-item" href="logout.asp" style="color:black">Logout</a>
                                 <%                        
                                    Else
                                 %>                
                                    <a class="dropdown-item" href="/login.asp" style="color:black">Login</a>
                                 <%
                                    End If
                                 %>
                                 
                              </div>
                           </div>
                        </ul>
                     </div>
                  </div>
               </div>
            </div>
         </div>
         <!-- header section end -->
         <!-- banner section start -->
         <div class="banner_section layout_padding">
            <div class="container">
               <div id="my_slider" class="carousel slide" data-ride="carousel">
                  <div class="carousel-inner">
                     <div class="carousel-item active">
                        <div class="row">
                           <div class="col-sm-12">
                              <h1 class="banner_taital">Get Start <br>Your favriot shoping</h1>
                              <div class="buynow_bt"><a href="#">Buy Now</a></div>
                           </div>
                        </div>
                     </div>
                     <div class="carousel-item">
                        <div class="row">
                           <div class="col-sm-12">
                              <h1 class="banner_taital">Get Start <br>Your favriot shoping</h1>
                              <div class="buynow_bt"><a href="#">Buy Now</a></div>
                           </div>
                        </div>
                     </div>
                     <div class="carousel-item">
                        <div class="row">
                           <div class="col-sm-12">
                              <h1 class="banner_taital">Get Start <br>Your favriot shoping</h1>
                              <div class="buynow_bt"><a href="#">Buy Now</a></div>
                           </div>
                        </div>
                     </div>
                  </div>
                  <a class="carousel-control-prev" href="index.asp?page=2"" role="button" data-slide="prev">
                  <i class="fa fa-angle-left"></i>
                  </a>
                  <a class="carousel-control-next" href="#my_slider" role="button" data-slide="next">
                  <i class="fa fa-angle-right"></i>
                  </a>
               </div>
            </div>
         </div>
         <!-- banner section end -->
      </div>
      <!-- banner bg main end -->
      <!-- Tai nghe section start -->
      <%
         Dim slide_start, i, SQL, Result,j
      %>
      <div class="product_section">
         <div id="main_slider" class="carousel slide" data-ride="carousel">
            <div class="carousel-inner">
                  <%
                      strSQL = "SELECT COUNT(ProductID) AS count FROM Products where Status ='Enable'"
                     Set CountResult = connDB.execute(strSQL)

                     totalRows = CLng(CountResult("count"))

                     Set CountResult = Nothing
                  ' lay ve tong so trang
                     pages = Ceil(totalRows/limit)
                     if pages<>0 then
                  slide_start = 1
                  SQL ="Select * from Products where Status = 'Enable'"
                  Set Result = connDB.execute(SQL)
                  For i= 0 To pages - 1
                  %>
                     <div class="carousel-item <% If i=0 then Response.write("active")%>">
                        <div class="container">
                           <h1 class="fashion_taital">Tai nghe</h1>
                           <div class="product_section_">
                              <div class="row">
                                    <% 
                                    For j = slide_start To slide_start + limit - 1
                                       if j > totalRows then exit for
                                       %>
                                       <div class="col-lg-4 col-sm-4">
                                          <div class="box_main">
                                             <h4 class="shirt_text"><%=Result("ProductName")%></h4>
                                             <p class="price_text">Price  <span style="color: #262626;"><%=Result("Price")%></span></p>
                                             <p class="price_text"><span class="text-danger" style="color: #262626;"><s>$ 45</s></span></p>
                                             <div class="tshirt_img"><img src="images/tshirt-img.png"></div>
                                             <div class="btn_main">
                                                <div class="buy_bt"><a href="payment.asp?productId=<%=Result("ProductID")%>">Buy Now</a></div>
                                                <div class="buy_bt"><a href="addCart.asp?idproduct=<%=Result("ProductID")%>">Add To Cart</a></div>
                                                <div class="seemore_bt"><a href="productDetail.asp?id=<%=Result("ProductID")%>">See More</a></div>
                                             </div>
                                          </div>
                                       </div>
                                       <%
                                       Result.MoveNext
                                    Next
                                    slide_start = slide_start + limit
                                    %>
                              </div>
                           </div>
                        </div>
                     </div>
                     <%
                     Next
                     %>
            </div>
            <a class="carousel-control-prev" href="#main_slider" role="button" data-slide="prev">
            <i class="fa fa-angle-left"></i>
            </a>
            <a class="carousel-control-next" href="#main_slider" role="button" data-slide="next">
            <i class="fa fa-angle-right"></i>
            </a>
         </div>
         <%
         end if
         set SQL=nothing 
         set Result=nothing
      %>
      </div>
      <!-- Tai nghe section end -->
      <!-- Tai nghe in ear section start -->
      <div class="product_section">
         <div id="inear_main_slider" class="carousel slide" data-ride="carousel">
            <div class="carousel-inner">
            <%
                   strSQL = "SELECT COUNT(ProductID) AS count FROM Products where Status ='Enable' and CategoryID=1"
                  Set CountResult = connDB.execute(strSQL)

                  totalRows = CLng(CountResult("count"))

                  Set CountResult = Nothing
               ' lay ve tong so trang
                  pages = Ceil(totalRows/limit)
                  if pages<>0 then
               slide_start = 1
               SQL ="Select * from Products where Status = 'Enable'and CategoryID=1"
               Set Result = connDB.execute(SQL)
               For i= 0 To pages - 1
            %>
               <div class="carousel-item <% If i=0 then Response.write("active")%>">
                  <div class="container">
                     <h1 class="fashion_taital">Tai Nghe In Ear</h1>
                     <div class="product_section_2">
                        <div class="row">
                           <% 
                              For j = slide_start To slide_start + limit - 1
                                 if j > totalRows then exit for
                                 %>
                                 <div class="col-lg-4 col-sm-4">
                                    <div class="box_main">
                                       <h4 class="shirt_text"><%=Result("ProductName")%></h4>
                                       <p class="price_text">Price  <span style="color: #262626;"><%=Result("Price")%></span></p>
                                       <p class="price_text"><span class="text-danger" style="color: #262626;"><s>$ 45</s></span></p>
                                       <div class="tshirt_img"><img src="images/tshirt-img.png"></div>
                                       <div class="btn_main">
                                          <div class="buy_bt"><a href="payment.asp?productId=<%=Result("ProductID")%>">Buy Now</a></div>
                                          <div class="buy_bt"><a href="addCart.asp?idproduct=<%=Result("ProductID")%>">Add To Cart</a></div>
                                          <div class="seemore_bt"><a href="productDetail.asp?id=<%=Result("ProductID")%>">See More</a></div>
                                       </div>
                                    </div>
                                 </div>
                                 <%
                                 Result.MoveNext
                              Next
                              slide_start = slide_start + limit
                              %>
                           </div>
                           </div>
                        </div>
                     </div>
                     <%
                     Next
                     %>
            </div>
            <a class="carousel-control-prev" href="#inear_main_slider" role="button" data-slide="prev">
            <i class="fa fa-angle-left"></i>
            </a>
            <a class="carousel-control-next" href="#inear_main_slider" role="button" data-slide="next">
            <i class="fa fa-angle-right"></i>
            </a>
         </div>
         <%end if%>
      </div>
      <!-- Tai nghe in ear section end -->
      <!-- Tai nghe on ear  section start -->
      <div class="product_section">
         <div id="onear_main_slider" class="carousel slide" data-ride="carousel">
            <div class="carousel-inner">
            <%
                   strSQL = "SELECT COUNT(ProductID) AS count FROM Products where Status ='Enable'and CategoryID=2"
                     Set CountResult = connDB.execute(strSQL)

                     totalRows = CLng(CountResult("count"))

                     Set CountResult = Nothing
                  ' lay ve tong so trang
                     pages = Ceil(totalRows/limit)
                     if pages<>0 then
               slide_start = 1
               SQL ="Select * from Products where Status = 'Enable' and CategoryID=2"
               Set Result = connDB.execute(SQL)
               For i= 0 To pages - 1
            %>
               <div class="carousel-item <% If i=0 then Response.write("active")%>">
                  <div class="container">
                     <h1 class="fashion_taital">Tai Nghe On Ear</h1>
                     <div class="product_section_2">
                        <div class="row">
                           <% 
                              For j = slide_start To slide_start + limit - 1
                                 if j > totalRows then exit for
                                 %>
                                 <div class="col-lg-4 col-sm-4">
                                    <div class="box_main">
                                       <h4 class="shirt_text"><%=Result("ProductName")%></h4>
                                       <p class="price_text">Price  <span style="color: #262626;"><%=Result("Price")%></span></p>
                                       <p class="price_text"><span class="text-danger" style="color: #262626;"><s>$ 45</s></span></p>
                                       <div class="tshirt_img"><img src="images/tshirt-img.png"></div>
                                       <div class="btn_main">
                                          <div class="buy_bt"><a href="payment.asp?productId=<%=Result("ProductID")%>">Buy Now</a></div>
                                          <div class="buy_bt"><a href="addCart.asp?idproduct=<%=Result("ProductID")%>">Add To Cart</a></div>
                                          <div class="seemore_bt"><a href="productDetail.asp?id=<%=Result("ProductID")%>">See More</a></div>
                                       </div>
                                    </div>
                                 </div>
                                 <%
                                 Result.MoveNext
                              Next
                              slide_start = slide_start + limit
                              %>
                           </div>
                           </div>
                        </div>
                     </div>
                     <%
                     Next
                     %>
            </div>
            <a class="carousel-control-prev" href="#onear_main_slider" role="button" data-slide="prev">
            <i class="fa fa-angle-left"></i>
            </a>
            <a class="carousel-control-next" href="#onear_main_slider" role="button" data-slide="next">
            <i class="fa fa-angle-right"></i>
            </a>
         </div>
         <%end if%>
      </div>
      <!-- Tai nghe on ear  section end -->
      <!-- Tai nghe over ear start -->
      <div class="product_section">
         <div id="overear_main_slider" class="carousel slide" data-ride="carousel">
            <div class="carousel-inner">
            <%
                   strSQL = "SELECT COUNT(ProductID) AS count FROM Products where Status ='Enable' and CategoryID=3"
                     Set CountResult = connDB.execute(strSQL)

                     totalRows = CLng(CountResult("count"))

                     Set CountResult = Nothing
                  ' lay ve tong so trang
                     pages = Ceil(totalRows/limit)
               if pages<>0 then
               slide_start = 1
               SQL ="Select * from Products where Status = 'Enable' and CategoryID=3"
               Set Result = connDB.execute(SQL)
               For i= 0 To pages - 1
            %>
               <div class="carousel-item <% If i=0 then Response.write("active")%>">
                  <div class="container">
                     <h1 class="fashion_taital">Tai Nghe Over Ear</h1>
                     <div class="product_section_2">
                        <div class="row">
                           <% 
                              For j = slide_start To slide_start + limit - 1
                                 if j > totalRows then exit for
                                 %>
                                 <div class="col-lg-4 col-sm-4">
                                    <div class="box_main">
                                       <h4 class="shirt_text"><%=Result("ProductName")%></h4>
                                       <p class="price_text">Price  <span style="color: #262626;"><%=Result("Price")%></span></p>
                                       <p class="price_text"><span class="text-danger" style="color: #262626;"><s>$ 45</s></span></p>
                                       <div class="tshirt_img"><img src="images/tshirt-img.png"></div>
                                       <div class="btn_main">
                                          <div class="buy_bt"><a href="payment.asp?productId=<%=Result("ProductID")%>">Buy Now</a></div>
                                          <div class="buy_bt"><a href="addCart.asp?idproduct=<%=Result("ProductID")%>">Add To Cart</a></div>
                                          <div class="seemore_bt"><a href="productDetail.asp?id=<%=Result("ProductID")%>">See More</a></div>
                                       </div>
                                    </div>
                                 </div>
                                 <%
                                 Result.MoveNext
                              Next
                              slide_start = slide_start + limit
                              %>
                           </div>
                           </div>
                        </div>
                     </div>
                     <%
                     Next
                     %>
            </div>
            <a class="carousel-control-prev" href="#overear_main_slider" role="button" data-slide="prev">
            <i class="fa fa-angle-left"></i>
            </a>
            <a class="carousel-control-next" href="#overear_main_slider" role="button" data-slide="next">
            <i class="fa fa-angle-right"></i>
            </a>
         </div>
         <%end if%>
      </div>
      <!-- Tai nghe over ear  section end -->

      <!-- #include file="./layout/footer.asp" -->
      <!-- copyright section end -->
      <!-- Javascript files-->
      <script src="js/jquery.min.js"></script>
      <script src="js/popper.min.js"></script>
      <script src="js/bootstrap.bundle.min.js"></script>
      <script src="js/jquery-3.0.0.min.js"></script>
      <script src="js/plugin.js"></script>
      <!-- sidebar -->
      <script src="js/jquery.mCustomScrollbar.concat.min.js"></script>
      <script src="js/custom.js"></script>
      <script>
         function openNav() {
           document.getElementById("mySidenav").style.width = "250px";
         }
         
         function closeNav() {
           document.getElementById("mySidenav").style.width = "0";
         }

         window.setTimeout(function() {
         $(".alert").fadeTo(500, 0).slideUp(500, function(){
            $(this).remove(); 
         });
      }, 2000);

      </script>
   </body>
</html>