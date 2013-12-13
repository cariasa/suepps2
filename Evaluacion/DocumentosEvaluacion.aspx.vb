Imports DevExpress.Web.ASPxGridView
Imports System.Windows.Forms
Imports System.IO
Imports DevExpress.Web.ASPxUploadControl
Imports System.Data.SqlClient

Partial Class Evaluacion_DocumentosEvaluacion
    Inherits System.Web.UI.Page
    Public Programa As String
    Public CodPrograma As String
    Private Const UploadDirectory As String = "../Uploads/Evaluacion/"
    Public Politica As String

    Protected Sub Page_Load(sender As Object, e As EventArgs) Handles Me.Load
        'Verifica si el usuario tiene el acceso a la pagina solicitada
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
    End Sub
    Protected Sub uplImage_FileUploadComplete(ByVal sender As Object, ByVal e As FileUploadCompleteEventArgs)
        Dim Ruta As String = "..\Uploads\Evaluacion\"
        Dim unico As String = Format(Date.Now, "yyyyMMdd_HHmmss_") + e.UploadedFile.FileName
        Dim fileName As String = Path.Combine(MapPath(UploadDirectory), unico)

        e.UploadedFile.SaveAs(fileName)

        Politica = Session("IdPolitica")

        CodPrograma = Request.QueryString.Get(0)


        Dim enlace As String = Ruta + unico
        

        SqlDataSourceDetalleDocumentosEvaluacion.InsertCommand = "INSERT INTO [DetalleDocumentosEvaluacion] ([IdDocumentoEvaluacion], [Enlace], [NombreDocumento], [CreadoPor], [FechaCreacion]) VALUES (" + Session("IdDocumentoEvaluacion").ToString + ",'" + enlace + "','" + e.UploadedFile.FileName + "','" + Membership.GetUser.UserName.ToString + "',getDate())"
        SqlDataSourceDetalleDocumentosEvaluacion.Insert()
        SqlDataSourceDetalleDocumentosEvaluacion.DataBind()
        'TryCast(ASPxGridViewDocumentosEvaluacion.FindDetailRowTemplateControl(ASPxGridViewDocumentosEvaluacion.FocusedRowIndex(), "ASPxGridViewDetalleDocumentosEvaluacion"), ASPxGridView).DataBind()

        ASPxGridViewDocumentosEvaluacion.DataBind()

    End Sub

    Protected Sub grid_custom(ByVal sender As Object, ByVal e As ASPxGridViewCustomCallbackEventArgs)
        Session("IdPrograma") = CInt(Request.QueryString("CodP"))
        CodPrograma = CInt(Request.QueryString("CodP"))

        SqlDataSourceDocumentosEvaluacion.SelectParameters(0).DefaultValue = CodPrograma
        SqlDataSourceDocumentosEvaluacion.InsertParameters(0).DefaultValue = Session("IdPrograma")
        ASPxGridViewDocumentosEvaluacion.DataBind()

    End Sub

    Protected Sub ASPxGridViewDocumentosEvaluacion_Load(sender As Object, e As EventArgs)
        Session("IdPrograma") = CInt(Request.QueryString("CodP"))
        CodPrograma = CInt(Request.QueryString("CodP"))

        SqlDataSourceDocumentosEvaluacion.SelectParameters(0).DefaultValue = CodPrograma
        SqlDataSourceDocumentosEvaluacion.InsertParameters(0).DefaultValue = Session("IdPrograma")
        ASPxGridViewDocumentosEvaluacion.DataBind()
    End Sub

    Protected Sub ASPxGridViewDetalleDocumentosEvaluacion_BeforePerformDataSelect(sender As Object, e As EventArgs)
        Session("IdDocumentoEvaluacion") = CType(sender, ASPxGridView).GetMasterRowKeyValue()
        SqlDataSourceDetalleDocumentosEvaluacion.SelectParameters(0).DefaultValue = Session("IdDocumentoEvaluacion")
        SqlDataSourceDetalleDocumentosEvaluacion.DeleteParameters(0).DefaultValue = Session("IdDocumentoEvaluacion")
    End Sub

    Protected Sub SqlDataSourceDetalleDocumentosEvaluacion_Inserted(sender As Object, e As SqlDataSourceStatusEventArgs)

        SqlDataSourceDetalleDocumentosEvaluacion.SelectParameters(0).DefaultValue = Session("IdDocumentoEvaluacion")
        SqlDataSourceDetalleDocumentosEvaluacion.DataBind()
    End Sub
End Class
