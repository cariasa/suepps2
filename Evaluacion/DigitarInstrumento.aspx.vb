
Partial Class Cuantitativo_DigitarInstrumento
    Inherits System.Web.UI.Page

    Protected Sub LinkButton1_Click(sender As Object, e As EventArgs)

        Response.Redirect("Encuesta.aspx?CodFSU=" + 58.ToString() + "&CodDigitador=" + 10.ToString() + "&IdAplicacion=" + Me.ASPxTextBox1.Text.ToString)


    End Sub
End Class
