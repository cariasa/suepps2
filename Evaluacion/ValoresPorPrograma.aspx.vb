Imports System.Windows.Forms

Partial Class Evaluacion_ValoresPorPrograma
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
        ASPxLabelVariable.Text = "Valores Por Programa de Variable " + uf.QueryStringDecode(Request.QueryString("Nombre"))

        SqlDataSourceVariablesPrograma.InsertCommand = "INSERT INTO [VariablesPrograma] ([IdVariable], [Valor], [Fuente], [Fecha], [CreadoPor], [FechaCreacion]) VALUES (" + Session("Variable").ToString + ", @Valor, @Fuente, @Fecha, '" + Membership.GetUser.UserName.ToString + "', getDate())"
        SqlDataSourceVariablesPrograma.UpdateCommand = "UPDATE [VariablesPrograma] SET Valor=@Valor, Fuente = @Fuente, Fecha=@Fecha, ActualizadoPor='" + Membership.GetUser.UserName.ToString + "', FechaActualizacion=getDate() WHERE IdVariablePrograma=@IdVariablePrograma"
        SqlDataSourceVariablesPrograma.DeleteCommand = "UPDATE [VariablesPrograma] SET Activo=0, ActualizadoPor='" + Membership.GetUser.UserName.ToString + "', FechaActualizacion=getDate() WHERE IdVariablePrograma=@IdVariablePrograma"

        SqlDataSourceDetalleVariablesPrograma.InsertCommand = "INSERT INTO [DetallesVariablePrograma] ([IdVariablePrograma], [NombreDetalle], [CreadoPor], [FechaCreacion]) VALUES (@IdVariablePrograma, @NombreDetalle, '" + Membership.GetUser.UserName.ToString + "', getDate())"
        SqlDataSourceDetalleVariablesPrograma.UpdateCommand = "UPDATE [DetallesVariablePrograma] SET [NombreDetalle]=@NombreDetalle, [ActualizadoPor]='" + Membership.GetUser.UserName.ToString + "', FechaActualizacion=getDate() WHERE IdDetalleVariablePrograma=@IdDetalleVariablePrograma"
        SqlDataSourceDetalleVariablesPrograma.DeleteCommand = "UPDATE [DetallesVariablePrograma] SET [Activo] = 0, ActualizadoPor='" + Membership.GetUser.UserName.ToString + "', FechaActualizacion=getDate() WHERE IdDetalleVariablePrograma=@IdDetalleVariablePrograma"

        SqlDataSourceValoresDetallePrograma.InsertCommand = "INSERT INTO [ValoresDetallePrograma] ([IdDetalleVariablePrograma], [Nombrevalor], [Valor], [CreadoPor], [FechaCreacion]) VALUES (@IdDetalleVariablePrograma, @NombreValor, @Valor, '" + Membership.GetUser.UserName.ToString + "', getDate())"
        SqlDataSourceValoresDetallePrograma.UpdateCommand = "UPDATE [ValoresDetallePrograma] SET [Nombrevalor]=@NombreValor, [Valor]=@Valor, [ActualizadoPor]='" + Membership.GetUser.UserName.ToString + "', FechaActualizacion=getDate() WHERE [IdValorVariablePrograma] = @IdValorVariablePrograma"
        SqlDataSourceValoresDetallePrograma.DeleteCommand = "UPDATE [ValoresDetallePrograma] SET [Activo]=0, [ActualizadoPor]='" + Membership.GetUser.UserName.ToString + "', FechaActualizacion=getDate() WHERE [IdValorVariablePrograma] = @IdValorVariablePrograma"

        

    End Sub

    Protected Sub ASPxGridViewDetalleVariablesPrograma_BeforePerformDataSelect(sender As Object, e As EventArgs)
        Session("IdVariablePrograma") = (TryCast(sender, DevExpress.Web.ASPxGridView.ASPxGridView)).GetMasterRowKeyValue()

    End Sub

    Protected Sub ASPxGridViewValoresDetallePrograma_BeforePerformDataSelect(sender As Object, e As EventArgs)

        Session("IdDetalleVariablePrograma") = (TryCast(sender, DevExpress.Web.ASPxGridView.ASPxGridView)).GetMasterRowKeyValue()
    End Sub
End Class
