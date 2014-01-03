
Imports Microsoft.VisualBasic
Imports System
Imports DevExpress.Web.ASPxGridView
Imports System.Web.UI
Imports DevExpress.Web.ASPxEditors

Partial Class Evaluacion_Exportart
    Inherits System.Web.UI.Page



    Protected Sub ASPxGridViewOpcionesDePregunta_BeforePerformDataSelect(sender As Object, e As EventArgs)
        Session("IdPreguntaDeMonitoreo") = (TryCast(sender, DevExpress.Web.ASPxGridView.ASPxGridView)).GetMasterRowKeyValue()
    End Sub

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
        If (Not IsPostBack) Then

            ASPxGridViewPreguntas.DataBind()


        End If

        
    End Sub

    Protected Sub ASPxButtonExportarPreguntas_Click(sender As Object, e As EventArgs)
        UpdateExportMode()
        exporter.WriteXlsToResponse()


    End Sub

    Protected Sub UpdateExportMode()
        ASPxGridViewPreguntas.SettingsDetail.ExportMode = GridViewDetailExportMode.All
    End Sub

   
End Class
