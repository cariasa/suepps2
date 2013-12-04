
Partial Class Cuantitativo_Encuesta
    Inherits System.Web.UI.Page

    Protected Sub form1_Load(sender As Object, e As EventArgs)


        Session("CodFSU") = Request.QueryString.Get(0)
        Session("CodDigitador") = Request.QueryString.Get(1)
        Session("IdAplicacion") = Request.QueryString.Get(2)




    End Sub
End Class
