<!-- #include file="connect.asp" -->
<%
    idproduct = Request.QueryString("idproduct")
    if(isnull(Session("CustomerID")) OR trim(Session("CustomerID"))="") then 
        Response.redirect("Login.asp")
        Response.End
    end if
    if (isnull(idproduct) OR trim(idproduct)="" ) then
        Response.redirect("productManagement.asp")
        Response.End
    end if

    Set cmdPrep = Server.CreateObject("ADODB.Command")
    connDB.Open()
    cmdPrep.ActiveConnection = connDB
    cmdPrep.CommandType = 1
    cmdPrep.CommandText = "DELETE FROM Products WHERE ProductID=?"
    cmdPrep.parameters.Append cmdPrep.createParameter("productId",3,1, ,idproduct)

    cmdPrep.execute
    connDB.Close()

    Session("Success") = "Deleted"

    Response.Redirect("productManagement.asp")
%>