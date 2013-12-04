
Partial Class Cuantitativo_AplicacionInstrumento
    Inherits System.Web.UI.Page

    Protected Sub form1_Load(sender As Object, e As EventArgs)

        Session("IdInstrumento") = Request.QueryString.Get(0)

        SqlDataSource1.SelectParameters(0).DefaultValue = Session("IdInstrumento")
        SqlDataSource1.InsertParameters(1).DefaultValue = Session("IdInstrumento")






    End Sub
End Class
