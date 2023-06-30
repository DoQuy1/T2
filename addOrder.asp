<!-- #include file="connect.asp" -->
<%
    Dim address,paymentMethod,customerID,payments
    Set payments = Session("payment")
    address = Request.Form("address")
    paymentMethodID = Request.Form("paymentMethod")
    if(IsEmpty(Session("admin"))) then
    customerID =Session("CustomerID")
    Else
    customerID =Session("admin")
    End if
    totalAmount=Session("totalAmount")
    orderDate = FormatDateTime(Now(), vbGeneralDate)  ' Lấy ngày hiện tại và định dạng thành chuỗi ngày tháng
    Response.write(customerID)
    Response.write("<br>")
    Response.write(address)
    Response.write("<br>")
    Response.write(totalAmount)
    Response.write("<br>")
    Response.write(orderDate)
    Response.write("<br>")
    Response.write(paymentMethodID)
    Response.write("<br>")
    ' For Each key In payments.Keys
    '         Response.write(key)
    '         Response.write("<br>")
    '         Response.write(payments.Item(key))
    '         Response.write("<br>")
    ' Next
    connDB.Open()
    dim idList
    idList = ""
    For Each List In payments.Keys
		If (idList="") Then
' true
			idList = List
		Else
			idList = idList & "," & List
		End if                               
	Next
    Dim sqlString
	sqlString = "Select * from Products where ProductID IN (" & idList &")"
	set result = connDB.execute(sqlString)
    Set priceDetails = Server.CreateObject("Scripting.Dictionary")
    For Each key In payments.Keys
            Response.write(key)
            Response.write("<br>")
            Response.write(payments.Item(key))
            Response.write("<br>")
            Do While Not result.EOF
                    ' Lấy giá trị từ các trường dữ liệu trong bản ghi hiện tại
            Dim fieldValue1, fieldValue2,priceDetail
            fieldValue1 = result("ProductID")
            fieldValue2 = result("Price")
            if Clng(key) = clng(fieldValue1) Then
            priceDetail= Clng(payments.Item(key)*CDbl(fieldValue2))
            priceDetails.Add key,priceDetail
            Response.write(priceDetail)
            Response.write("<br>")
            end if
            
            result.MoveNext
            Loop
            result.MoveFirst
    Next
    set result = Nothing

        If (NOT IsNull(address) And address <> "" And NOT IsNull(paymentMethodID) And paymentMethodID <> "" And NOT IsNull(customerID) And customerID <> "" And NOT IsNull(totalAmount) And totalAmount <> "") Then
        On Error Resume Next '*** Error Resume ***'
        '*** Transaction Start ***'
        connDB.BeginTrans

        Set cmdPrep = Server.CreateObject("ADODB.Command")
        cmdPrep.ActiveConnection = connDB
        cmdPrep.CommandType = 1
        cmdPrep.Prepared = True
        cmdPrep.CommandText = "INSERT INTO Orders (CustomerID, PaymentMethodID, OrderDate, Status, TotalAmount, ShippingAddress) VALUES ("&customerID&","&paymentMethodID&", '"&orderDate&"', 'Order Processed', "&totalAmount&", '"&address&"')"
        ' cmdPrep.Parameters.Append cmdPrep.CreateParameter("@CustomerID", adInteger, adParamInput, , customerID)
        ' cmdPrep.Parameters.Append cmdPrep.CreateParameter("@PaymentMethodID", adInteger, adParamInput, , paymentMethod)
        ' cmdPrep.Parameters.Append cmdPrep.CreateParameter("@OrderDate", adDBTimeStamp, adParamInput, , orderDate)
        ' cmdPrep.Parameters.Append cmdPrep.CreateParameter("@Status", adVarChar, adParamInput, , "Order Processed")
        ' cmdPrep.Parameters.Append cmdPrep.CreateParameter("@TotalAmount", adDouble, adParamInput, , totalAmount)
        ' cmdPrep.Parameters.Append cmdPrep.CreateParameter("@ShippingAddress", adVarChar, adParamInput, , address)

        cmdPrep.Execute

        Dim rs
        Dim orderID
        Set cmdPrep = Server.CreateObject("ADODB.Command")
        cmdPrep.ActiveConnection = connDB
        cmdPrep.CommandType = 1
        cmdPrep.Prepared = True
        cmdPrep.CommandText = "SELECT @@IDENTITY AS ID"
        Set rs = cmdPrep.Execute
        If Not rs.EOF Then
            orderID = cint(rs("ID"))
        End If
        if(orderID<>0) then
        Response.write(orderID)
        else
        Response.write("errror")
        end if
        rs.Close

        

        'Thực hiện thêm chi tiết hóa đơn
        If orderID<>0 Then
            For Each key In payments.Keys
                Response.write(key)
                Response.write("<br>")
                Response.write(payments.Item(key))
                Response.write("<br>")
                 For Each priceDetailkey In priceDetails.Keys
                    if Clng(key) = clng(priceDetailkey) Then
                    Set cmdDetail = Server.CreateObject("ADODB.Command")
                    cmdDetail.ActiveConnection = connDB
                    cmdDetail.CommandType = 1
                    cmdDetail.Prepared = True
                    cmdDetail.CommandText = "INSERT INTO OrderDetail (OrderID,ProductID,Quantity,Price) VALUES (?, ?, ?, ?)"
                    cmdDetail.parameters.Append cmdDetail.createParameter("OrderID",3,1,,orderID)
                    cmdDetail.parameters.Append cmdDetail.createParameter("ProductID",3,1,,key)
                    cmdDetail.parameters.Append cmdDetail.createParameter("Quantity",3,1,,payments.Item(key))
                    cmdDetail.parameters.Append cmdDetail.createParameter("Price",3,1,,priceDetails.Item(priceDetailkey))
                    cmdDetail.Execute
                    end if
                next
            Next
        End If
        If Err.Number = 0 Then
            Session("Success") = "Order was added!"
            ' Hoàn thành giao dịch
            connDB.CommitTrans
            Response.Redirect("purchaseForm.asp?id="&customerID&"")
        Else
            connDB.RollbackTrans
            Response.Write("Error Save (" & Err.Description & ")")
        End If

    ' Đóng kết nối
    connDB.Close
    Set connDB = Nothing
End If
%>