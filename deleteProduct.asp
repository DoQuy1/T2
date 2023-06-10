<!-- #include file="connect.asp" -->
<%
    listId= Request.Form("checkbox-selected")
    listId = Split(listId,",")
    Dim count 
    count =0
    for Each newid in listId
        count =count+1
    next
    Response.write(count)
    idproduct = Request.QueryString("idproduct")
    if(isnull(Session("CustomerID")) OR trim(Session("CustomerID"))="") then 
        Response.redirect("Login.asp")
        Response.End
    end if
    connDB.Open()
    if (trim(idproduct)<>"") then
        connDB.BeginTrans

        Set cmdUpdate  = Server.CreateObject("ADODB.Command")

        cmdUpdate.ActiveConnection = connDB
        cmdUpdate.CommandType = 1
        cmdUpdate.CommandText = "UPDATE OrderDetail SET ProductID=NULL where ProductID=?"
        cmdUpdate.parameters.Append cmdUpdate.createParameter("ProductID",3,1, ,idproduct)

        cmdUpdate.execute


        Set cmdPrep = Server.CreateObject("ADODB.Command")

        cmdPrep.ActiveConnection = connDB
        cmdPrep.CommandType = 1
        cmdPrep.CommandText = "DELETE FROM Products WHERE ProductID=?"
        cmdPrep.parameters.Append cmdPrep.createParameter("ProductID",3,1, ,idproduct)

        cmdPrep.execute
        connDB.CommitTrans

        connDB.Close
    end if

    if (count>0) then
        connDB.BeginTrans

        for Each newid in listId
        Set cmdUpdate  = Server.CreateObject("ADODB.Command")

        cmdUpdate.ActiveConnection = connDB
        cmdUpdate.CommandType = 1
        cmdUpdate.CommandText = "UPDATE OrderDetail SET ProductID=NULL where ProductID=?"
        cmdUpdate.parameters.Append cmdUpdate.createParameter("productId",3,1, ,newid)

        cmdUpdate.execute

        Set cmdPrep = Server.CreateObject("ADODB.Command")
        cmdPrep.ActiveConnection = connDB
        cmdPrep.CommandType = 1
        cmdPrep.CommandText = "DELETE FROM Products WHERE ProductID=?"
        cmdPrep.parameters.Append cmdPrep.createParameter("newID",3,1, ,newid)
        cmdPrep.execute
        next
        connDB.CommitTrans
        connDB.Close
    else
         Response.write("không có giá trị")
    end if

    Session("Success") = "Deleted"

    Response.Redirect("productManagement.asp")
%>