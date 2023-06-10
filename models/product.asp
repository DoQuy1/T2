<% 
  Class Product
    'Private, class member variable
    Private p_id
    Private p_name
    Private p_category
    Private p_description
    Private p_price
    Private p_image
    Private p_brand
    Private p_status

    ' getter and setter
    Public Property Get Id()
      Id = p_id
    End Property
    Public Property Let Id(value)
      p_id = value
    End Property

    Public Property Get Name()
      Name = p_name
    End Property
    Public Property Let Name(value)
      p_name = value
    End Property
    
    Public Property Get Category()
      Category = p_category
    End Property
    Public Property Let Category(value)
      p_category = value
    End Property

    Public Property Get Description()
      Description = p_description
    End Property
    Public Property Let Description(value)
      p_description = value
    End Property
    
    Public Property Get Price()
      Price = p_price
    End Property
    Public Property Let Price(value)
      p_price = value
    End Property
    
    Public Property Get Image()
      Image = p_image
    End Property
    Public Property Let Image(value)
      p_image = value
    End Property

    Public Property Get Brand()
      Band = p_band
    End Property
    Public Property Let Brand(value)
      p_band = value
    End Property

    Public Property Get Status()
      Status = p_status
    End Property
    Public Property Let Status(value)
      p_status = value
    End Property

  End Class
%>
