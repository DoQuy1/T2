<!--#include file="connect.asp"-->
<%
    If (isnull(Session("admin")) OR TRIM(Session("admin")) = "") Then
        Response.redirect("login.asp")
    End If
    idproduct=Request.QueryString("idproduct")
    iduser = Request.QueryString("id")
    if (NOT isnull(idproduct) and idproduct<>"" ) then
            Set cmdPrep = Server.CreateObject("ADODB.Command")
            connDB.Open()
            cmdPrep.ActiveConnection = connDB
            cmdPrep.CommandType = 1
            cmdPrep.CommandText = "SELECT * FROM Products WHERE ProductID=?"
            cmdPrep.Parameters(0)=idproduct
            Set Result = cmdPrep.execute 
            set statuspd = Result("Status")
            if(statuspd="Enable") then
                Set cmdPrep = Server.CreateObject("ADODB.Command")
                
                cmdPrep.ActiveConnection = connDB
                cmdPrep.CommandType = 1
                cmdPrep.Prepared = True
                cmdPrep.CommandText = "UPDATE Products SET Status=? WHERE ProductID=?"
                cmdPrep.parameters(0)="Disable"
                cmdPrep.parameters(1)=idproduct
                cmdPrep.execute
            else
                Set cmdPrep = Server.CreateObject("ADODB.Command")
                
                cmdPrep.ActiveConnection = connDB
                cmdPrep.CommandType = 1
                cmdPrep.Prepared = True
                cmdPrep.CommandText = "UPDATE Products SET Status=? WHERE ProductID=?"
                cmdPrep.parameters(0)="Enable"
                cmdPrep.parameters(1)=idproduct
                cmdPrep.execute
            end if
            Response.redirect("productManagement.asp")
            connDB.close()
    end if



    if (NOT isnull(iduser) and iduser<>"" ) then
            Set cmdPrep = Server.CreateObject("ADODB.Command")
            connDB.Open()
            cmdPrep.ActiveConnection = connDB
            cmdPrep.CommandType = 1
            cmdPrep.CommandText = "SELECT * FROM Customers WHERE CustomerID=?"
            cmdPrep.Parameters(0)=iduser
            Set Result = cmdPrep.execute 
            set statuspd = Result("Status")
            if(statuspd="Enable") then
                Set cmdPrep = Server.CreateObject("ADODB.Command")
                
                cmdPrep.ActiveConnection = connDB
                cmdPrep.CommandType = 1
                cmdPrep.Prepared = True
                cmdPrep.CommandText = "UPDATE Customers SET Status=? WHERE CustomerID=?"
                cmdPrep.parameters(0)="Disable"
                cmdPrep.parameters(1)=iduser
                cmdPrep.execute
            else
                Set cmdPrep = Server.CreateObject("ADODB.Command")
                
                cmdPrep.ActiveConnection = connDB
                cmdPrep.CommandType = 1
                cmdPrep.Prepared = True
                cmdPrep.CommandText = "UPDATE Customers SET Status=? WHERE CustomerID=?"
                cmdPrep.parameters(0)="Enable"
                cmdPrep.parameters(1)=iduser
                cmdPrep.execute
            end if
            Response.redirect("userManagement.asp")
            connDB.close()
    end if

%>