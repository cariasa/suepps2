Imports DevExpress.Web.ASPxGridView

Partial Class Evaluacion_ValoresMacro
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(sender As Object, e As EventArgs) Handles Me.Load

        Session("Variable") = CInt(Request.QueryString("Variable"))
        ASPxLabelVariable.Text = "Valores Oficiales de Variable " + Request.QueryString("Nombre")
        SqlDataSourceVariablesMacro.InsertCommand = "INSERT INTO [VariablesMacro] ([IdVariable], [Valor], [Fuente], [Fecha], [CreadoPor], [FechaCreacion]) VALUES (" + Request.QueryString("Variable") + ", @Valor, @Fuente, @Fecha, 'SUEPPS', getDate())"
    End Sub

    Protected Sub SqlDataSourceVariablesMacro_Deleted(sender As Object, e As SqlDataSourceStatusEventArgs)
        ASPxGridViewValoresMacro.DataBind()
    End Sub

    Protected Sub SqlDataSourceVariablesMacro_Updated(sender As Object, e As SqlDataSourceStatusEventArgs)
        ASPxGridViewValoresMacro.DataBind()
    End Sub

    Protected Sub ASPxGridViewDetallesVariablesMacro_BeforePerformDataSelect(sender As Object, e As EventArgs)
        Session("IdVariableMacro") = (TryCast(sender, DevExpress.Web.ASPxGridView.ASPxGridView)).GetMasterRowKeyValue()
    End Sub

    Protected Sub ASPxGridViewValoresDetalleMacro_BeforePerformDataSelect(ByVal sender As Object, ByVal e As EventArgs)

        Session("IdDetalleVariableMacro") = (TryCast(sender, DevExpress.Web.ASPxGridView.ASPxGridView)).GetMasterRowKeyValue()


    End Sub
End Class
