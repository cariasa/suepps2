Imports DevExpress.Web.ASPxGridView

Partial Class Evaluacion_ValoresMacro
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(sender As Object, e As EventArgs) Handles Me.Load

        Using dtMOCA As System.Data.DataTable = fMOCA.CheckPageAccess(3.05) 'este es el Id definido en el MOCA


            If dtMOCA.Rows.Count() > 0 Then
                ''Activa o Inactiva los objetos,(sean botones, grid, hiperlinks, etc),  
                ''en la pagina que se indique deacuerdo al parametro indicado
                'btnAgregar.Visible = dtMOCA.Rows.Item(0).Item("AllowAdd")

                ''Los siguientes datos pueden ser cambiados por los nombres de Objetos a los que corresponde la acción que se desea realizar, 
                ''si no hay necesidad de utilizar esta sección silo la eliminan dejandola en blanco y solo evaluando el acceso a la pagina
                'btnModificar.Visible = dtMOCA.Rows.Item(0).Item("AllowUpdate")
                'btnEliminar.Visible = dtMOCA.Rows.Item(0).Item("AllowDelete")
                'btnAutorizar.Visible = dtMOCA.Rows.Item(0).Item("AllowAction01")
                ''Object5.Visible = dtMOCA.Rows.Item(0).Item("AllowAction02")
                ''Object6.Visible = dtMOCA.Rows.Item(0).Item("AllowAction03")
                ''Object7.Visible = dtMOCA.Rows.Item(0).Item("AllowAction04")
                ''Object8.Visible = dtMOCA.Rows.Item(0).Item("AllowAction05")
                ''Object9.Visible = dtMOCA.Rows.Item(0).Item("AllowAction06")
                ''Object10.Visible = dtMOCA.Rows.Item(0).Item("AllowAction07")

                'Para activar o desactivar los botones en un ASPxGridView preferiblemente use variables de sessión
                Session("AllowAdd") = dtMOCA.Rows.Item(0).Item("AllowAdd")
                Session("AllowUpdate") = dtMOCA.Rows.Item(0).Item("AllowUpdate")
                Session("AllowDelete") = dtMOCA.Rows.Item(0).Item("AllowDelete")
            Else
                'Si no se recupero ningun dato se entendera que el usuario no tiene acceso a la pagina solicitada
                'y sera redireccionado a la Pagina siguiente que le notifica al usuario que no tiene acceso
                Response.Redirect("~/NoAccess.aspx")
            End If
        End Using

        Session("Variable") = CInt(uf.QueryStringDecode(Request.QueryString("Variable")))
        ASPxLabelVariable.Text = "Valores Oficiales de Variable " + uf.QueryStringDecode(Request.QueryString("Nombre"))
        SqlDataSourceVariablesMacro.InsertCommand = "INSERT INTO [VariablesMacro] ([IdVariable], [Valor], [Fuente], [Fecha], [CreadoPor], [FechaCreacion]) VALUES (" + uf.QueryStringDecode(Request.QueryString("Variable")) + ", @Valor, @Fuente, @Fecha, '" + Membership.GetUser.UserName.ToString + "', getDate())"

        SqlDataSourceValoresDetalleMacro.InsertCommand = "INSERT INTO [ValoresDetalleMacro] ([IdDetalleVariableMacro], [NombreValor], [Valor], [CreadoPor], [FechaCreacion]) VALUES (@IdDetalleVariableMacro, @NombreValor, @Valor, '" + Membership.GetUser.UserName.ToString + "', getDate())"
        SqlDataSourceValoresDetalleMacro.UpdateCommand = "UPDATE [ValoresDetalleMacro] SET [NombreValor]=@NombreValor, [Valor]=@Valor, [ActualizadoPor]='" + Membership.GetUser.UserName.ToString + "', [FechaActualizacion]=getDate() WHERE IdValorVariableMacro=@IdValorVariableMacro"
        SqlDataSourceValoresDetalleMacro.DeleteCommand = "UPDATE [ValoresDetalleMacro] SET [Activo]=0 WHERE IdValorVariableMacro=@IdValorVariableMacro"

        SqlDataSourceDetallesVariablesMacro.InsertCommand = "INSERT INTO [DetallesVariableMacro] ([IdVariableMacro], [NombreDetalle], [CreadoPor], [FechaCreacion]) VALUES (@IdVariableMacro, @NombreDetalle, '" + Membership.GetUser.UserName.ToString + "', getDate())"
        SqlDataSourceDetallesVariablesMacro.UpdateCommand = "UPDATE [DetallesVariableMacro] SET [NombreDetalle]=@NombreDetalle, ActualizadoPor='" + Membership.GetUser.UserName.ToString + "', FechaActualizacion=getDate() WHERE IdDetalleVariableMacro=@IdDetalleVariableMacro"
        SqlDataSourceDetallesVariablesMacro.DeleteCommand = "UPDATE [DetallesVariableMacro] SET [Activo]=0 WHERE IdDetalleVariableMacro=@IdDetalleVariableMacro"

        SqlDataSourceVariablesMacro.UpdateCommand = "UPDATE [VariablesMacro] SET [Valor]=@Valor, [Fuente]=@Fuente, [Fecha]=@Fecha, [ActualizadoPor]='" + Membership.GetUser.UserName.ToString + "', FechaActualizacion=getDate() WHERE [IdVariableMacro]=@IdVariableMacro"
        SqlDataSourceVariablesMacro.DeleteCommand = "UPDATE [VariablesMacro] SET [Activo]=0 WHERE [IdVariableMacro]=@IdVariableMacro"
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
