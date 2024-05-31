<%
Function createPagination(pages, page)
    Dim str, i
    str = "<ul class='pagination'>"
    ' Kiểm tra nút "Previous"
    If page > 1 Then
        str = str & "<li class='page-item'><a class='page-link' href='?page=" & page - 1 & "'>Previous</a></li>"
    End If
    ' Hiển thị các trang
    If pages < 6 Then
        For i = 1 To pages
            str = str & "<li" 
            if(i = Clng(page)) Then
              str=str &" class='active page-item'"
            else
              str= str &" class='page-item'"
            end if 
            str=str & "><a class='page-link' href='?page=" & i & "'>" & i & "</a></li>"
        Next
    Else
        Dim startPage, endPage, gap
        startPage = page - 2
        endPage = page + 2
        If startPage < 1 Then
            startPage = 1
            endPage = 5
        ElseIf endPage > pages Then
            endPage = pages
            startPage = pages - 4
        End If
        gap = startPage - 1
        If gap >= 1 Then
            str = str & "<li class='page-item'><a class='page-link' href='?page=1'>1</a></li>"
            If gap >= 2 Then
                str = str & "<li class='page-item'><span>...</span></li>"
            End If
        End If
        For i = startPage To endPage
            str = str & "<li" 
            If(i = Clng(page)) Then
            str=str &" class='active page-item'"
            else
              str =str &" class='page-item'"
            end if
              str=str & "><a class='page-link' href='?page=" & i & "'>" & i & "</a></li>"
        Next
        gap = pages - endPage
        If gap >= 1 Then
            If gap >= 2 Then
                str = str & "<li class='page-item'><span>...</span></li>"
            End If
            str = str & "<li class='page-item'><a class='page-link' href='?page=" & pages & "'>" & pages & "</a></li>"
        End If
    End If
    ' Kiểm tra nút "Next"
    If Clng(page) < Clng(pages) Then
        str = str & "<li class='page-item'><a class='page-link' href='?page=" & page + 1 & "'>Next</a></li>"
    End If
    str = str & "</ul>"
    createPagination = str
End Function


if(trim(page) = "") or (isnull(page)) then
page = 1
end if
' Gọi hàm tạo chuỗi HTML cho thanh phân trang
pagination = createPagination(pages, page)

' In chuỗi HTML
Response.Write pagination

%>

<!-- #include file="./layout/header.asp" -->
<!--<link href="https://maxcdn.bootstrapcdn.com/font-awesome/4.3.0/css/font-awesome.min.css" rel="stylesheet" />
<link rel="stylesheet" href="./css/productlist.css">
<!-- Latest compiled and minified CSS -->
<!--<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" integrity="sha384-BVYiiSIFeK1dGmJRAkycuHAHRg32OmUcww7on3RYdg4Va+PmSTsz/K68vbdEjh4u" crossorigin="anonymous">

<!-- Optional theme -->
<!--<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css" integrity="sha384-rHyoN1iRsVXV4nD0JutlnGaslCJuC7uwjduW9SVrLvRYooPp2bWYgmgJQIXwl/Sp" crossorigin="anonymous">

<!-- Latest compiled and minified JavaScript -->
<!--<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" integrity="sha384-Tc5IQib027qvyjSMfHjOMaLkfuWVxZxUPnCJA7l2mCWNIpG9mGCD8wGNIcPD7Txa" crossorigin="anonymous"></script>
    <div id="pagination" class="pull-right">
    ' <%
    '     page = Request.QueryString("page")
    '     if (trim(page) = "") or (isnull(page)) then 
    '         page =1
    '     end if
    ' %>
    </div>
<!-- #include file="./layout/header.asp" -->
