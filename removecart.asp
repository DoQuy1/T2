<%
        'code for delete a product from my cart
        'lay ve product id
        ' If (isnull(Session("CustomerID")) OR TRIM(Session("CustomerID")) = "") Then
        ' Response.redirect("login.asp")
        ' End If
        Dim mycarts
        If (NOT IsEmpty(Session("mycarts"))) Then
            Set mycarts = Session("mycarts")
            If (Request.ServerVariables("REQUEST_METHOD") = "GET") THEN
                Dim pid
                pid = Request.QueryString("id")
                if mycarts.Exists(pid) = true then
                    mycarts.Remove(pid)
                    If (mycarts.Count>0) Then
                        'True
                        Set Session("mycarts") = mycarts
                    Else
                        'remove session mycarts
                        Session.Contents.Remove("mycarts")
                    End If
                    'saving new session value
                    
                    Session("Success") = "The Product has been removed from your cart."
                Else
                    Session("Error") = "The Product haven't been removed from your cart."
                End If    
            ElseIf (Request.ServerVariables("REQUEST_METHOD") = "POST") Then
                    Dim product_select
                    product_select = Request.Form("cb-selector")
                    if Request.Form("checkout")<>"" or Request.Form("sub_checkout")<>"" then
                        if(product_select<>"") then
                            product_selectArr=Split(product_select,",")
                            Set payment = Server.CreateObject("Scripting.Dictionary")
                            for Each temp in product_selectArr
                                for Each tmp In mycarts.Keys
                                    if Clng(tmp)= Clng(temp) then
                                        ' Response.write(temp)
                                        ' Response.write("<br>")
                                        Dim q 
                                        q=mycarts.Item(tmp)
                                        ' Response.write(q)
                                        ' Response.write("<br>")
                                        payment.Add temp,q
                                    end if
                                Next
                            NEXT
                            set Session("payment")=payment
                            set payment=Nothing
                            Response.Redirect("payment.asp")   
                        Else
                            Session("Error") = "You haven't chosen which product to buy"
                        end if
                    end if

                        Dim quantityArray
                        quantityArray = Request.Form("quantity")
                        quantityArrays = Split(quantityArray,",")
                        Dim count
                        count = 0  
                        For Each tmp In mycarts.Keys
                        mycarts.Item(tmp) = Clng(quantityArrays(count))
                        ' Response.write(tmp)
                        ' Response.write("<br>")
                        ' Response.write(mycarts.Item(tmp))
                        ' Response.write("<br>")
                        count = count + 1
                        Next
                    'saving new session value
                        Set Session("mycarts") = mycarts     
                        
            End If
        End If
        Response.Redirect("shoppingCart.asp")              
%>