<!--#include file="./models/category.asp" -->
<%
  ' --------------------------------------------------------
  '                     VBSCRIPT PART 
  ' --------------------------------------------------------
  ' declare the variables
  Dim categories
  Dim connectionC, recordsetC, sqlC, connectionStringC

  ' to setup connectionString follow this tutorial https://stackoverflow.com/a/5678835/1843755
  connectionStringC = Application("connectionString")

  ' create an instance of ADO connection and recordset objects
  Set connectionC = Server.CreateObject("ADODB.Connection")
  Set categories = Server.CreateObject("Scripting.Dictionary")
  ' open connection in the database
  connectionC.ConnectionString = connectionStringC
  connectionC.Open()
  
  Dim myCategory, seqC
  Set recordsetC = connectionC.Execute("select * from Category")
  seqC = 0
  Do While Not recordsetC.EOF
    seqC = seqC+1
    set myCategory = New Category
    myCategory.Id = recordsetC.Fields("CategoryID")
    myCategory.Name = recordsetC.Fields("CategoryName")
    categories.add seqC, myCategory
    recordsetC.MoveNext
  Loop 
  set Session("ListCategory")=categories
  connectionC.Close()
%>