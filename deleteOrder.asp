<!-- #include file="connect.asp" -->
<%
    listId= Request.Form("checkbox-selected")
    listId = Split(listId,",")
    Dim count 
    count = 0
    for Each newid in listId
        count =count+1
        Response.write(newid)
    next

    orderId = Request.QueryString("orderId")
    connDB.Open()
    if(isnull(Session("admin")) OR trim(Session("admin"))="") then 
        Response.redirect("Login.asp")
        Response.End
    end if

    if(not IsEmpty(orderId) OR trim(orderId)<>"") then
        On Error Resume Next
        connDB.BeginTrans
        Set cmdDeleteOrderDetail = Server.CreateObject("ADODB.Command")
        
        cmdDeleteOrderDetail.ActiveConnection = connDB
        cmdDeleteOrderDetail.CommandType = 1
        cmdDeleteOrderDetail.CommandText = "DELETE FROM OrderDetail WHERE OrderID=?"
        cmdDeleteOrderDetail.parameters.Append cmdDeleteOrderDetail.createParameter("OrderID",3,1, ,orderId)

        cmdDeleteOrderDetail.execute

        Set cmdDeleteOrder = Server.CreateObject("ADODB.Command")
        cmdDeleteOrder.ActiveConnection = connDB
        cmdDeleteOrder.CommandText = "DELETE FROM Orders WHERE OrderID = ?"
        cmdDeleteOrder.parameters.Append cmdDeleteOrder.createParameter("OrderID",3,1, ,orderId)
        cmdDeleteOrder.Execute

        If Err.Number = 0 Then  
    '*** Commit Transaction ***'  
        connDB.CommitTrans  
        Session("Success") = "Delete order successful"
        Else  
        '*** Rollback Transaction ***'  
        connDB.RollbackTrans  
        Session("Error")="Error Save [Error1] ("&Err.Description&")"
        End If  
        ' Đóng kết nối
        connDB.Close
        Set connDB = Nothing
        Response.redirect("orderManagement.asp")
    Else
        
        if(count>0) then 
            On Error Resume Next
            connDB.BeginTrans
                for each key in listId
                Set cmdDeleteOrderDetail = Server.CreateObject("ADODB.Command")
                
                cmdDeleteOrderDetail.ActiveConnection = connDB
                cmdDeleteOrderDetail.CommandType = 1
                cmdDeleteOrderDetail.CommandText = "DELETE FROM OrderDetail WHERE OrderID=?"
                cmdDeleteOrderDetail.parameters.Append cmdDeleteOrderDetail.createParameter("OrderID",3,1, ,key)

                cmdDeleteOrderDetail.execute

                Set cmdDeleteOrder = Server.CreateObject("ADODB.Command")
                cmdDeleteOrder.ActiveConnection = connDB
                cmdDeleteOrder.CommandText = "DELETE FROM Orders WHERE OrderID = ?"
                cmdDeleteOrder.parameters.Append cmdDeleteOrder.createParameter("OrderID",3,1, ,key)
                cmdDeleteOrder.Execute

                next
                If Err.Number = 0 Then  
            '*** Commit Transaction ***'  
                connDB.CommitTrans  
                Session("Success") = "Delete order successful"
                Else  
            '*** Rollback Transaction ***'  
                connDB.RollbackTrans  
                Session("Error")="Error Save [Error2] ("&Err.Description&")"
                End If  

            ' Đóng kết nối
            connDB.Close
            Set connDB = Nothing
            Response.redirect("orderManagement.asp")
        end if
    end if

    
    
%>