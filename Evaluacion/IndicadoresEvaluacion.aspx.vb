Imports DevExpress.Web.ASPxGridView

Partial Class Cuantitativo_IndicadoresEvaluación
    Inherits System.Web.UI.Page

    Protected Sub GridIndicadores_CustomCallback(sender As Object, e As ASPxGridViewCustomCallbackEventArgs)

        If e.Parameters = "" Then
            If combosector.Text <> "" Then
                Me.SqlIndicadores.SelectParameters(0).DefaultValue = CInt(combosector.Value)
                Me.GridIndicadores.DataBind()
            End If
        Else
            SqlIndicadores.SelectParameters(0).DefaultValue = 0
            SqlIndicadores.DataBind()
            GridIndicadores.DataBind()
        End If
    End Sub

    Protected Sub addIdentificador(ByVal sender As Object, ByVal e As EventArgs)

        Dim index As Integer = GridIndicadores.FocusedRowIndex()

        SqlDataSourceIndicadoresEvaluacion.InsertParameters(0).DefaultValue = GridIndicadores.GetRowValues(index, "IdIndicador")
        SqlDataSourceIndicadoresEvaluacion.InsertParameters(1).DefaultValue = Session("IdPrograma")
        SqlDataSourceIndicadoresEvaluacion.Insert()
        SqlDataSourceIndicadoresEvaluacion.DataBind()
        ASPxGridView1.DataBind()

    End Sub

    Protected Sub GridIndicadores_Load(sender As Object, e As EventArgs)
        Me.SqlIndicadores.SelectParameters(0).DefaultValue = CInt(combosector.Value)
        Me.GridIndicadores.DataBind()
    End Sub

    Protected Sub form1_Load(sender As Object, e As EventArgs)

        Session("IdPrograma") = Request.QueryString.Get(0)

        SqlDataSourceIndicadoresEvaluacion.SelectParameters(0).DefaultValue = Session("IdPrograma")
        SqlDataSourceIndicadoresEvaluacion.DataBind()
        ASPxGridView1.DataBind()

    End Sub
End Class
