<!--#include file="connect.asp"-->
<%
    If (isnull(Session("CustomerID")) OR TRIM(Session("CustomerID")) = "") Then
        Response.redirect("login.asp")
    End If
    idproduct=Request.QueryString("idproduct")
    
    if (NOT isnull(idproduct) and idproduct<>"" ) then
            Set cmdPrep = Server.CreateObject("ADODB.Command")
            connDB.Open()
            cmdPrep.ActiveConnection = connDB
            cmdPrep.CommandType = 1
            cmdPrep.CommandText = "SELECT * FROM Products WHERE ProductID=?"
            cmdPrep.Parameters(0)=idproduct
            Set Result = cmdPrep.execute 
            set statuspd = Result("Status")
            if(statuspd="enable") then
                Set cmdPrep = Server.CreateObject("ADODB.Command")
                
                cmdPrep.ActiveConnection = connDB
                cmdPrep.CommandType = 1
                cmdPrep.Prepared = True
                cmdPrep.CommandText = "UPDATE Products SET Status=? WHERE ProductID=?"
                cmdPrep.parameters(0)="disable"
                cmdPrep.parameters(1)=idproduct
                cmdPrep.execute
            else
                Set cmdPrep = Server.CreateObject("ADODB.Command")
                
                cmdPrep.ActiveConnection = connDB
                cmdPrep.CommandType = 1
                cmdPrep.Prepared = True
                cmdPrep.CommandText = "UPDATE Products SET Status=? WHERE ProductID=?"
                cmdPrep.parameters(0)="enable"
                cmdPrep.parameters(1)=idproduct
                cmdPrep.execute
            end if
            Response.redirect("productManagement.asp")
            connDB.close()
    end if

%>