Imports Microsoft.VisualBasic
Imports System
Imports System.Data
Imports System.Configuration
Imports System.Collections
Imports System.Web
Imports System.Web.Security
Imports System.Web.UI
Imports System.Web.UI.WebControls
Imports System.Web.UI.WebControls.WebParts
Imports System.Web.UI.HtmlControls
Imports DevExpress.Web.ASPxGridView
Imports DevExpress.Web.ASPxEditors
Imports DevExpress.Web.ASPxTabControl
Imports DevExpress.Web.ASPxLoadingPanel
Imports DevExpress.Web.ASPxClasses
Imports System.Windows.Forms
Imports System.IO
Imports DevExpress.Web.ASPxUploadControl
Imports System.Drawing
Imports System.Threading

Partial Class GestionPublica_PlanificacionPolitica
    Inherits System.Web.UI.Page

    Public Programa As String
    Public CodPrograma As String
    Private Const UploadDirectory As String = "/suepps/Uploads/Politicas/"
    Public Politica As String

    Protected Sub ASPxGridView2_BeforePerformDataSelect(sender As Object, e As EventArgs)

        Session("IdPolitica") = CType(sender, ASPxGridView).GetMasterRowKeyValue()


    End Sub

    Protected Sub uplImage_FileUploadComplete(ByVal sender As Object, ByVal e As FileUploadCompleteEventArgs)


        Dim Ruta As String = "/suepps/Uploads/Politicas/"

        Dim unico As String = Format(Date.Now, "yyyyMMdd_HHmmss_") + e.UploadedFile.FileName
        Dim fileName As String = Path.Combine(MapPath(UploadDirectory), unico)

        e.UploadedFile.SaveAs(fileName)

        Politica = Session("IdPolitica")


        SqlDataSourceRecursos.InsertParameters(0).DefaultValue = Ruta + unico
        SqlDataSourceRecursos.InsertParameters(1).DefaultValue = Politica
        SqlDataSourceRecursos.InsertParameters(2).DefaultValue = e.UploadedFile.FileName
        SqlDataSourceRecursos.Insert()

        Me.SqlDataSourceRecursos.DataBind()
        Me.GridPoliticas.DataBind()


    End Sub

    Protected Sub SubirNuevo_Init(sender As Object, e As EventArgs)
        Dim boton As ASPxButton = CType(sender, ASPxButton)

    End Sub

    Protected Sub send2(ByVal sender As Object, ByVal e As EventArgs)

        Dim index As Integer = GridPoliticas.FocusedRowIndex()
        Dim codpolitica As String = GridPoliticas.GetRowValues(index, "IdPolitica").ToString
        Dim namepolitica As String = GridPoliticas.GetRowValues(index, "Nombre").ToString

        Response.Redirect("Politica.aspx?Tipo=" + uf.QueryStringEncode("2") + "&NameP=" + uf.QueryStringEncode(namepolitica) + "&CodP=" + uf.QueryStringEncode(codpolitica))

    End Sub

    Protected Sub Page_Load(sender As Object, e As EventArgs) Handles Me.Load
        'Verifica si el usuario tiene el acceso a la pagina solicitada
        Using dtMOCA As System.Data.DataTable = fMOCA.CheckPageAccess(1.01) 'este es el Id definido en el MOCA
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
                GridPoliticas.Columns(4).Visible = dtMOCA.Rows.Item(0).Item("AllowAction01")
            Else
                'Si no se recupero ningun dato se entendera que el usuario no tiene acceso a la pagina solicitada
                'y sera redireccionado a la Pagina siguiente que le notifica al usuario que no tiene acceso
                Response.Redirect("~/NoAccess.aspx")
            End If
        End Using

        SqlPolitica.InsertParameters(0).DefaultValue = Membership.GetUser.UserName
        SqlPolitica.UpdateParameters(0).DefaultValue = Membership.GetUser.UserName


    End Sub


    'Protected Sub GridPoliticas_CommandButtonInitialize(sender As Object, e As ASPxGridViewCommandButtonEventArgs) Handles GridPoliticas.CommandButtonInitialize
    '    'Este evento debe de usarse cuando se desean activar o desactivar los comandos de accion en un gridview
    '    'Con las variables de sessión inicializadas en el evento Page_Load se activan o desactivan los botones del Grid
    '    Select Case e.ButtonType
    '        Case DevExpress.Web.ASPxGridView.ColumnCommandButtonType.New
    '            e.Visible = Session("AllowAdd")
    '        Case DevExpress.Web.ASPxGridView.ColumnCommandButtonType.Edit
    '            e.Visible = Session("AllowUpdate")
    '        Case DevExpress.Web.ASPxGridView.ColumnCommandButtonType.Delete
    '            e.Visible = Session("AllowDelete")
    '    End Select

    'End Sub

    Protected Sub GridObjetivosEstrategicos_BeforePerformDataSelect(sender As Object, e As EventArgs)
        Session("IdPolitica") = CType(sender, ASPxGridView).GetMasterRowKeyValue()

        Me.SqlObjetivosEstrategicos.SelectParameters(0).DefaultValue = Session("IdPolitica")

        Me.SqlObjetivosEstrategicos.InsertParameters(1).DefaultValue = Session("IdPolitica")
        Me.SqlObjetivosEstrategicos.InsertParameters(2).DefaultValue = Membership.GetUser.UserName


        Me.SqlObjetivosEstrategicos.UpdateParameters(0).DefaultValue = Membership.GetUser.UserName


    End Sub

    Protected Sub GridObjetivosEspecificos_BeforePerformDataSelect(sender As Object, e As EventArgs)

        Session("IdPolitica") = CType(sender, ASPxGridView).GetMasterRowKeyValue()

        Me.SqlObjetivosEspecificos.SelectParameters(0).DefaultValue = Session("IdPolitica")

        Me.SqlObjetivosEspecificos.InsertParameters(1).DefaultValue = Session("IdPolitica")
        Me.SqlObjetivosEspecificos.InsertParameters(2).DefaultValue = Membership.GetUser.UserName

        Me.SqlObjetivosEspecificos.UpdateParameters(0).DefaultValue = Membership.GetUser.UserName
    End Sub

    Protected Sub ASPxGridView2_Load(sender As Object, e As EventArgs)
        SqlDataSourceRecursos.SelectParameters(0).DefaultValue = Session("IdSistematizacionMonitoreo")
        SqlDataSourceRecursos.DataBind()
    End Sub

    Protected Sub GridPoliticas_CommandButtonInitialize(sender As Object, e As ASPxGridViewCommandButtonEventArgs) Handles GridPoliticas.CommandButtonInitialize
        'Este evento debe de usarse cuando se desean activar o desactivar los comandos de accion en un gridview
        'Con las variables de sessión inicializadas en el evento Page_Load se activan o desactivan los botones del Grid
        Select Case e.ButtonType
            Case DevExpress.Web.ASPxGridView.ColumnCommandButtonType.New
                e.Visible = Session("AllowAdd")
            Case DevExpress.Web.ASPxGridView.ColumnCommandButtonType.Edit
                e.Visible = Session("AllowUpdate")
            Case DevExpress.Web.ASPxGridView.ColumnCommandButtonType.Delete
                e.Visible = Session("AllowDelete")
        End Select
    End Sub
End Class
