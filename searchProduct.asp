
<%
    dim checkboxArr
    Set payments = Server.CreateObject("Scripting.Dictionary")
    payments.Add "1", "Credit Card"
    payments.Add "2", "Visa"
    payments.Add "3", "4111111111111111"
    checkboxArr = Request.Form("checkbox")
    checkboxArs = Split(checkboxArr,",")
    for Each temp in checkboxArs
        for Each payment In payments.Keys
            if Clng(payment)= Clng(temp) then
                Response.write(temp)
                Response.write("<br>")
                
                Response.write(payments.Item(payment))
                Response.write("<br>")
            end if
        Next
    NEXT

%>




<form action="searchProduct.asp" method="post" id="myForm">
  <label for="checkbox1">
    <input type="checkbox" id="checkbox1" name="checkbox" value="1"> Checkbox 1
  </label><br>
  <label for="checkbox2">
    <input type="checkbox" id="checkbox2" name="checkbox" value="2"> Checkbox 2
  </label><br>
  <label for="checkbox3">
    <input type="checkbox" id="checkbox3" name="checkbox" value="3"> Checkbox 3
  </label><br>
  <input type="submit" value="Submit">
</form>