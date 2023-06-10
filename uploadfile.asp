
<%@ Language="VBScript" %>
<!-- #include file="aspuploader/include_aspuploader.asp" -->
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<title>
		Form - Start uploading manually
	</title>
	<link href="upload.css" rel="stylesheet" type="text/css" />
			
	<script type="text/javascript">
	function doStart()
	{
		var uploadobj = document.getElementById('myuploader');
		if (uploadobj.getqueuecount() > 0)
		{
			uploadobj.startupload();
		}
		else
		{
			alert("Please browse files for upload");
		}
	}
	</script>
	
</head>
<%
				Dim uploader
				Set uploader=new AspUploader
				uploader.MaxSizeKB=10240
				uploader.Name="myuploader"
				uploader.InsertText="Upload File (Max 10M)"
				uploader.MultipleFilesUpload=true
				
				uploader.ManualStartUpload=true
				
				%>

                <%

If Request.Form("myuploader")&""<>"" Then

	Dim list
	list=Request.Form("myuploader")


		Dim mvcfile
		Set mvcfile=uploader.GetUploadedFile(list)

		Response.Write("<div style='font-family:Fixedsys'>")
		Response.Write("Uploaded File:")
		Response.Write("<br/>FileName : ")
		Response.Write(mvcfile.FileName)
		Response.Write("<br/>FileSize : ")
		Response.Write(mvcfile.FileSize)
		Response.Write("<br/>FilePath : ")
		Response.Write(mvcfile.FilePath)
		Response.Write("</div>")
End If

%>
<body>
	<div class="demo">     
			<h2>Start uploading manually</h2>
			<p>This sample demonstrates how to start uploading manually after file selection vs automatically.</p>

			<!-- do not need enctype="multipart/form-data" -->
			<form id="form1" method="POST">
				
				<%=uploader.GetString() %>
			
				<br /><br /><br />
				<button id="submitbutton" onclick="doStart();return false;">Start Uploading Files</button>

			</form>
			
			<br/><br/><br/>

				
	</div>
</body>
</html>