Imports Microsoft.VisualBasic
Imports System
Imports System.Web.UI
Imports DevExpress.Web.ASPxEditors
Imports DevExpress.Web.ASPxTabControl
Imports DevExpress.Web.ASPxGridView


Partial Class Administracion_Parametrizacion
    Inherits System.Web.UI.Page

    Protected Sub ASPxGridView2_BeforePerformDataSelect(sender As Object, e As EventArgs)

        Session("IdPreguntaDeMonitoreo") = CType(sender, ASPxGridView).GetMasterRowKeyValue()




    End Sub

    Protected Function IsGridOpcionesVisible(ByVal IdPreguntaDeMonitoreo As Object) As Boolean
        Dim Tipo As Integer = ASPxGridViewPreguntas.GetRowValuesByKeyValue(IdPreguntaDeMonitoreo, "IdTipoDePregunta")
        Return (3 = Tipo Or 4 = Tipo)
    End Function


    Protected Sub Page_Load(sender As Object, e As EventArgs) Handles Me.Load
        'Verifica si el usuario tiene el acceso a la pagina solicitada
        Using dtMOCA As System.Data.DataTable = fMOCA.CheckPageAccess(0.01) 'este es el Id definido en el MOCA
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

        SqlDataSourceTiposIndicadores.InsertParameters(0).DefaultValue = Membership.GetUser.UserName
        SqlDataSourceTiposIndicadores.UpdateParameters(0).DefaultValue = Membership.GetUser.UserName

        SqlDataSourceIndicadores.InsertParameters(0).DefaultValue = Membership.GetUser.UserName
        SqlDataSourceIndicadores.UpdateParameters(0).DefaultValue = Membership.GetUser.UserName

        SqlDataSourcePreguntas.InsertParameters(0).DefaultValue = Membership.GetUser.UserName
        SqlDataSourcePreguntas.UpdateParameters(0).DefaultValue = Membership.GetUser.UserName

        SqlDataSourceOpciones.InsertParameters(2).DefaultValue = Membership.GetUser.UserName
        SqlDataSourceOpciones.UpdateParameters(2).DefaultValue = Membership.GetUser.UserName

        SqlDataSourceTiposDeActor.InsertParameters(0).DefaultValue = Membership.GetUser.UserName
        SqlDataSourceTiposDeActor.UpdateParameters(0).DefaultValue = Membership.GetUser.UserName

        SqlDataSourceCategorias.InsertParameters(0).DefaultValue = Membership.GetUser.UserName
        SqlDataSourceCategorias.UpdateParameters(0).DefaultValue = Membership.GetUser.UserName


    End Sub
End Class
