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
Imports DevExpress.Web.ASPxCallback
Imports DevExpress.Web.ASPxUploadControl
Imports System.Drawing
Imports System.IO
Imports System.Windows.Forms
Imports System.Threading
Imports System.Data.Common
Imports System.Web.Configuration
Imports System.Data.SqlClient


Partial Class GestionPublica_TestUpload
    Inherits System.Web.UI.Page
    Private Const UploadDirectory As String = "~/Uploads/"


    Protected Sub uplImage_FileUploadComplete(ByVal sender As Object, ByVal e As FileUploadCompleteEventArgs)
        e.CallbackData = SavePostedFile(e.UploadedFile)
    End Sub

    Private Function SavePostedFile(ByVal uploadedFile As UploadedFile) As String
        If (Not uploadedFile.IsValid) Then
            Return String.Empty
        End If

        Dim unico As String = Format(Date.Now, "yyyyMMdd_HHmmss_") + uploadedFile.FileName
        Dim fileName As String = Path.Combine(MapPath(UploadDirectory), unico)

        uploadedFile.SaveAs(fileName)
        Return fileName

    End Function
End Class
