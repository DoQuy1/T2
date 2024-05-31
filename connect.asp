<%
'code here
Dim connDB
set connDB = Server.CreateObject("ADODB.Connection")
Dim strConnection
strConnection = "Provider=SQLOLEDB.1;Data Source=ADMIN\SQLEXPRESS;Database=DoAnCNW;User Id=quy03;Password=Ongthandongtoi"
connDB.ConnectionString = strConnection
%>