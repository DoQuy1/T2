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
    idUser = Request.QueryString("id")
    if(isnull(Session("admin")) OR trim(Session("admin"))="") then 
        Response.redirect("Login.asp")
        Response.End
    end if
    connDB.Open()
    if (trim(idUser)<>"") then
        connDB.BeginTrans

        Set cmdUpdate  = Server.CreateObject("ADODB.Command")

        cmdUpdate.ActiveConnection = connDB
        cmdUpdate.CommandType = 1
        cmdUpdate.CommandText = "UPDATE Orders SET CustomerID=NULL where CustomerID=?"
        cmdUpdate.parameters.Append cmdUpdate.createParameter("CustomerID",3,1, ,idUser)

        cmdUpdate.execute


        Set cmdPrep = Server.CreateObject("ADODB.Command")

        cmdPrep.ActiveConnection = connDB
        cmdPrep.CommandType = 1
        cmdPrep.CommandText = "DELETE FROM Customers WHERE CustomerID=?"
        cmdPrep.parameters.Append cmdPrep.createParameter("CustomerID",3,1, ,idUser)

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
        cmdUpdate.CommandText = "UPDATE Orders SET CustomerID=NULL where CustomerID=?"
        cmdUpdate.parameters.Append cmdUpdate.createParameter("userId",3,1, ,newid)

        cmdUpdate.execute

        Set cmdPrep = Server.CreateObject("ADODB.Command")
        cmdPrep.ActiveConnection = connDB
        cmdPrep.CommandType = 1
        cmdPrep.CommandText = "DELETE FROM Customers WHERE CustomerID=?"
        cmdPrep.parameters.Append cmdPrep.createParameter("newID",3,1, ,newid)
        cmdPrep.execute
        next
        connDB.CommitTrans
        connDB.Close
    else
         Response.write("không có giá trị")
    end if

    Session("Success") = "Deleted"

    Response.Redirect("userManagement.asp")
%>