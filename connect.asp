<%
'code here
Dim connDB
set connDB = Server.CreateObject("ADODB.Connection")
Dim strConnection
strConnection = "Provider=SQLOLEDB.1;Data Source=KOSH1JO\KOSHIJO;Database=DoAnCNW;User Id=Anhtuan;Password=anhtuan123"
connDB.ConnectionString = strConnection
%>