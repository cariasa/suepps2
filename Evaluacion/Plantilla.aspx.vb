
Partial Class Cuantitativo_Plantilla
    Inherits System.Web.UI.Page

    Protected Sub send(ByVal sender As Object, ByVal e As EventArgs)

        Dim index As Integer = ASPxGridView1.FocusedRowIndex()
        Dim codplantilla As String = ASPxGridView1.GetRowValues(index, "IdPlantilla").ToString
        Response.Redirect("PreguntasPlantilla.aspx?NameP=" + codplantilla)

    End Sub


End Class
