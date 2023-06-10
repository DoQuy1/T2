<!-- #include file="connect.asp" -->
<%
    listId= Request.Form("checkbox-selected")
    listId = Split(listId,",")
    Dim count 
    count = 0
    for Each newid in listId
        count =count+1
    next

    orderId = Request.QueryString("orderId")
    connDB.Open()
    if(isnull(Session("CustomerID")) OR trim(Session("CustomerID"))="") then 
        Response.redirect("Login.asp")
        Response.End
    end if
    if (isnull(idproduct) OR trim(idproduct)="" or count=0) then
        Response.redirect("orderManagement.asp")
        Response.End
    end if
    if(not isnull(idproduct) OR trim(idproduct)<>"")
    connDB.BeginTrans
    Set cmdDeleteOrderDetail = Server.CreateObject("ADODB.Command")
    
    cmdDeleteOrderDetail.ActiveConnection = connDB
    cmdDeleteOrderDetail.CommandType = 1
    cmdDeleteOrderDetail.CommandText = "DELETE FROM OrderDetail WHERE OrderID=?"
    cmdDeleteOrderDetail.parameters.Append cmdPrep.createParameter("OrderID",3,1, ,orderId)

    cmdDeleteOrderDetail.execute

    Set cmdDeleteOrder = Server.CreateObject("ADODB.Command")
    cmdDeleteOrder.ActiveConnection = connDB
    cmdDeleteOrder.CommandText = "DELETE FROM Orders WHERE OrderID = ?"
    cmdDeleteOrder.parameters.Append cmdPrep.createParameter("OrderID",3,1, ,orderId)
    cmdDeleteOrder.Execute

    ' Hoàn thành giao dịch
    connDB.CommitTrans

    ' Đóng kết nối
    connDB.Close
    Set connDB = Nothing
    end if

    if(count>0) then 

    connDB.BeginTrans
    for each key in listId
    Set cmdDeleteOrderDetail = Server.CreateObject("ADODB.Command")
    
    cmdDeleteOrderDetail.ActiveConnection = connDB
    cmdDeleteOrderDetail.CommandType = 1
    cmdDeleteOrderDetail.CommandText = "DELETE FROM OrderDetail WHERE OrderID=?"
    cmdDeleteOrderDetail.parameters.Append cmdPrep.createParameter("OrderID",3,1, ,key)

    cmdDeleteOrderDetail.execute

    Set cmdDeleteOrder = Server.CreateObject("ADODB.Command")
    cmdDeleteOrder.ActiveConnection = connDB
    cmdDeleteOrder.CommandText = "DELETE FROM Orders WHERE OrderID = ?"
    cmdDeleteOrder.parameters.Append cmdPrep.createParameter("OrderID",3,1, ,key)
    cmdDeleteOrder.Execute

    next
    ' Hoàn thành giao dịch
    connDB.CommitTrans

    ' Đóng kết nối
    connDB.Close
    Set connDB = Nothing

    end if
    
%>