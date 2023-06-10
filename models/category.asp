
<% 
  Class Category
    'Private, class member variable
    Private c_id
    Private c_name
    ' getter and setter
    Public Property Get Id()
      Id = c_id
    End Property
    Public Property Let Id(value)
      c_id = value
    End Property

    Public Property Get Name()
      Name =  c_name
    End Property
    Public Property Let Name(value)
       c_name = value
    End Property
    
  End Class
%>