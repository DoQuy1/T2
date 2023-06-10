<!--#include file="./models/product.asp" -->
<%
  ' --------------------------------------------------------
  '                     VBSCRIPT PART 
  ' --------------------------------------------------------
  ' declare the variables
  Dim connection, recordset, sql, connectionString
  Dim products
  categoryid = Request.QueryString("categoryid")

  
  ' to setup connectionString follow this tutorial https://stackoverflow.com/a/5678835/1843755
  connectionString = Application("connectionString")

  ' create an instance of ADO connection and recordset objects
  Set connection = Server.CreateObject("ADODB.Connection")
  Set products = Server.CreateObject("Scripting.Dictionary")
  Set productsCategory = Server.CreateObject("Scripting.Dictionary")
  ' open connection in the database
  connection.ConnectionString = connectionString
  connection.Open()


  Dim myProduct, seq
  if (trim(categoryid) = "") or (isnull(categoryid)) then
    Set recordset = connection.Execute("select * from Products")
  else
    Set recordset = connection.Execute("select * from Products where CategoryID="&categoryid&"")
  end if
  seq = 0
  Do While Not recordset.EOF
    seq = seq+1
    set myProduct = New Product
    myProduct.Id = recordset.Fields("ProductID")
    myProduct.Category = recordset.Fields("CategoryID")
    myProduct.Name = recordset.Fields("ProductName")
    myProduct.Description = recordset.Fields("Description")
    myProduct.Price = recordset.Fields("Price")
    myProduct.Image = recordset.Fields("Image")
    myProduct.Brand = recordset.Fields("Brand")
    myProduct.Status = recordset.Fields("Status")
    products.add seq, myProduct
    recordset.MoveNext
  Loop 
  set Session("ListProduct")=products
  connection.Close()
%>



  