Imports DevExpress.Web.ASPxClasses
Imports DevExpress.Web.ASPxGridView
Imports System.Windows.Forms
Imports System.IO
Imports Microsoft.VisualBasic
Imports System
Imports DevExpress.Web.ASPxUploadControl
Imports System.Web.UI
Imports System.Drawing
Imports DevExpress.Web.ASPxEditors

Partial Class RevisionSocial_InsumosDeSistematizacion
    Inherits System.Web.UI.Page

    Public Programa As String
    Public CodPrograma As String
    Private Const UploadDirectory As String = "/suepps/Uploads/RevisionSocialIntegral/"
    Public sistematizacion As String

    Protected Sub send(ByVal sender As Object, ByVal e As EventArgs)

        sistematizacion = Me.ASPxGridView1.FocusedRowIndex


        'Response.Redirect("MonitoreoCualitativo.aspx?NameP=" + "&CodP=" + codproyecto)

    End Sub

    'Protected Sub load_Init(ByVal sender As Object, ByVal e As EventArgs)
    '    Programa = uf.QueryStringDecode(Request.QueryString.Get(0))
    '    CodPrograma = uf.QueryStringDecode(Request.QueryString.Get(1))
    '    'ASPxLabelPrograma.Text = Programa

    'End Sub

    'Protected Sub Page_Load(ByVal sender As Object, ByVal e As EventArgs)
    '    Programa = uf.QueryStringDecode(Request.QueryString.Get(0))
    '    CodPrograma = uf.QueryStringDecode(Request.QueryString.Get(1))
    '    ASPxLabelPrograma.Text = Programa
    '    SqlDataSourceSistematizacion.InsertParameters(0).DefaultValue = CodPrograma
    '    SqlDataSourceSistematizacion.InsertParameters(1).DefaultValue = CmbAno.Value
    '    SqlDataSourceSistematizacion.InsertParameters(2).DefaultValue = CmbTri.Value
    '    If (Not IsCallback) Then

    '        CmbAno.SelectedIndex = 0
    '    End If
    'End Sub
    'Protected Sub CmbAno_Callback(ByVal source As Object, ByVal e As CallbackEventArgsBase)
    '    FillAnoCombo(e.Parameter)
    'End Sub

    'Protected Sub FillAnoCombo(ByVal IdAreaDeInfluencia As String)
    '    If String.IsNullOrEmpty(IdAreaDeInfluencia) Then
    '        Return
    '    End If

    'End Sub
    'Protected Sub CmbTri_Callback(ByVal source As Object, ByVal e As CallbackEventArgsBase)
    '    FillTriCombo(e.Parameter)
    'End Sub


    'Protected Sub FillTriCombo(ByVal Ano As String)
    '    If String.IsNullOrEmpty(Ano) Then
    '        Return
    '    End If

    'End Sub

    Protected Sub ASPxGridView2_BeforePerformDataSelect(sender As Object, e As EventArgs)

        Session("IdSistematizacionMonitoreo") = CType(sender, ASPxGridView).GetMasterRowKeyValue()


        SqlDataSourceRecursos.SelectParameters(0).DefaultValue = Session("IdSistematizacionMonitoreo")



    End Sub

    Protected Sub grid_custom(ByVal sender As Object, ByVal e As ASPxGridViewCustomCallbackEventArgs)
        Programa = uf.QueryStringDecode(Request.QueryString.Get(0))
        CodPrograma = uf.QueryStringDecode(Request.QueryString.Get(1))

        Me.SqlDataSourceSistematizacion.SelectParameters(0).DefaultValue = CmbTri.Value
        Me.SqlDataSourceSistematizacion.SelectParameters(1).DefaultValue = CodPrograma
        Me.SqlDataSourceSistematizacion.SelectParameters(2).DefaultValue = CmbAno.Value
        Me.SqlDataSourceSistematizacion.SelectParameters(3).DefaultValue = Membership.GetUser.UserName
        Me.SqlDataSourceSistematizacion.DataBind()
        'MessageBox.Show(CmbTri.Value)
        Me.ASPxGridView1.DataBind()

    End Sub




    Protected Sub uplImage_FileUploadComplete(ByVal sender As Object, ByVal e As FileUploadCompleteEventArgs)

        Dim Ruta As String = "/suepps/Uploads/RevisionSocialIntegral/"

        Dim unico As String = Format(Date.Now, "yyyyMMdd_HHmmss_") + e.UploadedFile.FileName
        Dim fileName As String = Path.Combine(MapPath(UploadDirectory), unico)

        e.UploadedFile.SaveAs(fileName)

        sistematizacion = Session("IdSistematizacionMonitoreo")



        'MessageBox.Show("se guardo" + sistematizacion)

        SqlDataSourceRecursos.InsertParameters(0).DefaultValue = Ruta + unico
        SqlDataSourceRecursos.InsertParameters(1).DefaultValue = sistematizacion
        SqlDataSourceRecursos.InsertParameters(2).DefaultValue = e.UploadedFile.FileName
        SqlDataSourceRecursos.InsertParameters(3).DefaultValue = Membership.GetUser.UserName

        SqlDataSourceRecursos.Insert()
        'pcLogin.ShowOnPageLoad = False

        Me.SqlDataSourceRecursos.DataBind()


    End Sub

    Protected Sub SubirNuevo_Init(sender As Object, e As EventArgs)
        Dim boton As ASPxButton = CType(sender, ASPxButton)

    End Sub



    Protected Sub SqlDataSourceSistematizacion_Inserted(sender As Object, e As SqlDataSourceStatusEventArgs)
        Me.SqlDataSourceSistematizacion.SelectParameters(0).DefaultValue = CmbTri.Value
        Me.SqlDataSourceSistematizacion.SelectParameters(1).DefaultValue = CodPrograma
        Me.SqlDataSourceSistematizacion.SelectParameters(2).DefaultValue = CmbAno.Value
        Me.SqlDataSourceSistematizacion.SelectParameters(3).DefaultValue = Membership.GetUser.UserName
        Me.SqlDataSourceSistematizacion.DataBind()
        Me.ASPxGridView1.DataBind()
    End Sub

    'Protected Sub form1_Init(sender As Object, e As EventArgs)
    '    Me.CmbAno.Items.Add("2010", 2010)
    '    Me.CmbAno.Items.Add("2011", 2011)
    '    Me.CmbAno.Items.Add("2012", 2012)
    '    Me.CmbAno.Items.Add("2013", 2013)
    '    Me.CmbAno.Items.Add("2014", 2014)
    '    Me.CmbAno.Items.Add("2015", 2015)
    '    Me.CmbAno.Items.Add("2016", 2016)
    '    Me.CmbAno.Items.Add("2017", 2017)
    '    Me.CmbAno.Items.Add("2018", 2018)
    '    Me.CmbAno.Items.Add("2019", 2019)
    '    Me.CmbAno.Items.Add("2020", 2020)

    '    CmbTri.Items.Add("1", 1)
    '    CmbTri.Items.Add("2", 2)
    '    CmbTri.Items.Add("3", 3)
    '    CmbTri.Items.Add("4", 4)
    'End Sub

    Protected Sub Page_Init(sender As Object, e As EventArgs) Handles Me.Init
        Programa = uf.QueryStringDecode(Request.QueryString.Get(0))
        CodPrograma = uf.QueryStringDecode(Request.QueryString.Get(1))

        SqlAno.SelectParameters(0).DefaultValue = CodPrograma
        SqlDataSourceRecursos.InsertParameters(3).DefaultValue = Membership.GetUser.UserName

        CmbTri.Items.Add("1", 1)
        CmbTri.Items.Add("2", 2)
        CmbTri.Items.Add("3", 3)
        CmbTri.Items.Add("4", 4)
    End Sub

    Protected Sub Page_Load1(sender As Object, e As EventArgs) Handles Me.Load
        'Verifica si el usuario tiene el acceso a la pagina solicitada
        Using dtMOCA As System.Data.DataTable = fMOCA.CheckPageAccess(2.01) 'este es el Id definido en el MOCA
            If dtMOCA.Rows.Count() > 0 Then
                If True Then 'dtMOCA.Rows.Item(0).Item("AllowAction03") Then
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
                    Response.Redirect("~/NoAccess.aspx")
                End If

            Else
                'Si no se recupero ningun dato se entendera que el usuario no tiene acceso a la pagina solicitada
                'y sera redireccionado a la Pagina siguiente que le notifica al usuario que no tiene acceso
                Response.Redirect("~/NoAccess.aspx")
            End If
        End Using

        Programa = uf.QueryStringDecode(Request.QueryString.Get(0))
        CodPrograma = uf.QueryStringDecode(Request.QueryString.Get(1))

        SqlAno.SelectParameters(0).DefaultValue = CodPrograma

        ASPxLabelPrograma.Text = Programa
        SqlDataSourceSistematizacion.InsertParameters(0).DefaultValue = CodPrograma
        SqlDataSourceSistematizacion.InsertParameters(1).DefaultValue = CmbAno.Value
        SqlDataSourceSistematizacion.InsertParameters(2).DefaultValue = CmbTri.Value
        SqlDataSourceSistematizacion.InsertParameters(3).DefaultValue = Membership.GetUser.UserName

        SqlDataSourceRecursos.InsertParameters(3).DefaultValue = Membership.GetUser.UserName
        If (Not IsCallback) Then

            CmbAno.SelectedIndex = 0
        End If
    End Sub

    Protected Sub ASPxGridView1_Load(sender As Object, e As EventArgs)
        Programa = uf.QueryStringDecode(Request.QueryString.Get(0))
        CodPrograma = uf.QueryStringDecode(Request.QueryString.Get(1))

        Me.SqlDataSourceSistematizacion.SelectParameters(0).DefaultValue = CmbTri.Value
        Me.SqlDataSourceSistematizacion.SelectParameters(1).DefaultValue = CodPrograma
        Me.SqlDataSourceSistematizacion.SelectParameters(2).DefaultValue = CmbAno.Value
        Me.SqlDataSourceSistematizacion.SelectParameters(3).DefaultValue = Membership.GetUser.UserName
        Me.SqlDataSourceSistematizacion.DataBind()
        'MessageBox.Show(CmbTri.Value)
        Me.ASPxGridView1.DataBind()
    End Sub

    
    Protected Sub SqlDataSourceRecursos_Inserted(sender As Object, e As SqlDataSourceStatusEventArgs)
        SqlDataSourceRecursos.SelectParameters(0).DefaultValue = Session("IdSistematizacionMonitoreo")
        SqlDataSourceRecursos.DataBind()
    End Sub
End Class
