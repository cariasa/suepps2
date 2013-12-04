Imports DevExpress.Web.ASPxClasses
Imports DevExpress.Web.ASPxEditors
Imports DevExpress.Web.ASPxGridView
Imports System.Windows.Forms
Imports System.ComponentModel

Partial Class GestionPublica_MonitoreoCuantitativo
    Inherits System.Web.UI.Page
    Public Programa As String
    Public CodPrograma As String



    Protected Sub CmbAno_Callback(ByVal source As Object, ByVal e As CallbackEventArgsBase)

    End Sub

    Protected Sub FillAnoCombo(ByVal IdAreaDeInfluencia As String)
  
    End Sub
    Protected Sub load_Init(ByVal sender As Object, ByVal e As EventArgs)
        Dim total As Integer

        For i As Integer = 0 To ASPxGridView1.VisibleRowCount - 1
            total += ASPxGridView1.GetRowValues(i, "ProyectadoQ1")
            total += ASPxGridView1.GetRowValues(i, "ProyectadoQ2")
            ASPxGridView1.GetDataRow(i).Item("Total") = total

        Next

    End Sub
    Protected Sub tbTotal_Init(ByVal sender As Object, ByVal e As EventArgs)
        Dim tb As ASPxTextBox = TryCast(sender, ASPxTextBox)
        Dim container As GridViewDataItemTemplateContainer = TryCast(tb.NamingContainer, GridViewDataItemTemplateContainer)

        tb.ClientInstanceName = String.Format("txtBox{0}", container.VisibleIndex)
    End Sub


    Protected Sub SqlDataSourceMonitoreo_Updated(sender As Object, e As SqlDataSourceStatusEventArgs)
        CodPrograma = uf.QueryStringDecode(Request.QueryString.Get(1))
        Me.SqlDataSourceMonitoreo.SelectParameters(0).DefaultValue = CmbAno.Value
        Me.SqlDataSourceMonitoreo.SelectParameters(1).DefaultValue = CodPrograma
        Me.SqlDataSourceMonitoreo.SelectParameters(2).DefaultValue = CmbArea.Value
        SqlDataSourceMonitoreo.UpdateParameters(0).DefaultValue = Membership.GetUser.UserName

        Me.SqlDataSourceMonitoreo.DataBind()
        Me.ASPxGridView1.DataBind()
    End Sub

    Protected Sub ASPxGridView1_CustomCallback(sender As Object, e As ASPxGridViewCustomCallbackEventArgs)
        Programa = uf.QueryStringDecode(Request.QueryString.Get(0))
        CodPrograma = uf.QueryStringDecode(Request.QueryString.Get(1))

        Me.SqlDataSourceMonitoreo.SelectParameters(0).DefaultValue = CmbAno.Value
        Me.SqlDataSourceMonitoreo.SelectParameters(1).DefaultValue = Me.CodPrograma
        Me.SqlDataSourceMonitoreo.SelectParameters(2).DefaultValue = CmbArea.Value
        SqlDataSourceMonitoreo.UpdateParameters(0).DefaultValue = Membership.GetUser.UserName

        Me.SqlDataSourceMonitoreo.DataBind()
        Me.ASPxGridView1.DataBind()
        Dim total As Integer

        For i As Integer = 0 To ASPxGridView1.VisibleRowCount - 1
            total += CInt(ASPxGridView1.GetRowValues(i, "ProyectadoQ1"))
            total += CInt(ASPxGridView1.GetRowValues(i, "ProyectadoQ2"))


        Next
    End Sub

    Protected Sub CmbArea_Load(sender As Object, e As EventArgs) Handles CmbArea.Load
        CodPrograma = uf.QueryStringDecode(Request.QueryString.Get(1))
        SqlDataSourceArea.SelectParameters(0).DefaultValue = CodPrograma
        SqlDataSourceArea.DataBind()
        CmbArea.DataBind()
    End Sub

    Protected Sub CmbAno_Load(sender As Object, e As EventArgs) Handles CmbAno.Load
        CodPrograma = uf.QueryStringDecode(Request.QueryString.Get(1))
        SqlDataSourceMeta.SelectParameters(0).DefaultValue = CodPrograma
        SqlDataSourceMeta.DataBind()
        CmbAno.DataBind()
    End Sub

    Protected Sub ASPxGridView1_Load(sender As Object, e As EventArgs)
        Programa = uf.QueryStringDecode(Request.QueryString.Get(0))
        CodPrograma = uf.QueryStringDecode(Request.QueryString.Get(1))

        Me.SqlDataSourceMonitoreo.SelectParameters(0).DefaultValue = CmbAno.Value
        Me.SqlDataSourceMonitoreo.SelectParameters(1).DefaultValue = Me.CodPrograma
        Me.SqlDataSourceMonitoreo.SelectParameters(2).DefaultValue = CmbArea.Value


        Me.SqlDataSourceMonitoreo.DataBind()
        Me.ASPxGridView1.DataBind()
        Dim total As Integer

        For i As Integer = 0 To ASPxGridView1.VisibleRowCount - 1
            total += CInt(ASPxGridView1.GetRowValues(i, "ProyectadoQ1"))
            total += CInt(ASPxGridView1.GetRowValues(i, "ProyectadoQ2"))


        Next
    End Sub

    Protected Sub Page_Init(sender As Object, e As EventArgs) Handles Me.Init
        LabelProgramaTitulo.Text = "Proyecto: " + uf.QueryStringDecode(Request.QueryString.Get(0))
    End Sub

    Protected Sub Page_Load1(sender As Object, e As EventArgs) Handles Me.Load
        'Verifica si el usuario tiene el acceso a la pagina solicitada
        Using dtMOCA As System.Data.DataTable = fMOCA.CheckPageAccess(1.03) 'este es el Id definido en el MOCA
            If dtMOCA.Rows.Count() > 0 Then
                If dtMOCA.Rows.Item(0).Item("AllowAction01") Then
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

        If (Not IsCallback) Then
            'Programa = uf.QueryStringDecode(Request.QueryString.Get(0))
            'CodPrograma = uf.QueryStringDecode(Request.QueryString.Get(1))

            CmbAno.SelectedIndex = 0
        End If

        SqlDataSourceMonitoreo.UpdateParameters(0).DefaultValue = Membership.GetUser.UserName
    End Sub
End Class
