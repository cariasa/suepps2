Imports System.Data

Partial Class MOCA_UE
    Inherits System.Web.UI.UserControl

    Public Property Entidad() As String
        Get
            If String.IsNullOrEmpty(Me.ddlEntidades.SelectedValue) Then
                Return 0
            Else
                Return Me.ddlEntidades.SelectedValue
            End If
        End Get
        Set(ByVal pIdEntidad As String)
            Me.ddlEntidades.SelectedValue = pIdEntidad
        End Set
    End Property

    Public Property UnidadEjecutora() As String
        Get
            If String.IsNullOrEmpty(Me.ddlUnidadesEjecutoras.SelectedValue) Then
                Return 0
            Else
                Return Me.ddlUnidadesEjecutoras.SelectedValue
            End If
        End Get
        Set(ByVal pIdUC As String)
            Me.ddlUnidadesEjecutoras.SelectedValue = pIdUC
        End Set
    End Property

    Public Property Enable() As Boolean
        Set(ByVal pEnable As Boolean)
            Me.ddlEntidades.Enabled = pEnable
            Me.ddlUnidadesEjecutoras.Enabled = pEnable
        End Set
        Get
            If Me.ddlEntidades.Enabled And Me.ddlUnidadesEjecutoras.Enabled Then
                Return True
            Else
                Return False
            End If
        End Get
    End Property

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not IsPostBack Then
            'Verifica Entidades y Unidades de Compras Asignadas
            Dim ws As New MOCA.SecurityCredentialsSoapClient
            Dim dt As DataTable
            dt = ws.GetEntrepricesAssigedToUser(My.User.Name)
            ddlEntidades.DataSource=dt
            ddlEntidades.DataBind()

            'Unidades de Compra Asignadas
            Call CargarUE()

            'Tipo de control a mostrar
            If Me.ddlEntidades.Items.Count = 1 Then
                Me.ddlEntidades.Visible = False
                Me.lblEntidad.Text = ddlEntidades.SelectedItem.Text
                Me.lblEntidad.Visible = True
            Else
                Me.ddlEntidades.Visible = True
                Me.lblEntidad.Text = Nothing
                Me.lblEntidad.Visible = False
            End If
        End If
    End Sub

    Protected Sub ddlEntidades_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles ddlEntidades.SelectedIndexChanged
        Call CargarUE()
    End Sub

    Protected Sub CargarUE()
        'Unidades de Ejecutoras Asignadas

        Dim ws As New MOCA.SecurityCredentialsSoapClient
        Dim dt As DataTable
        dt = ws.GetBranchOfficesAssigedToUser(My.User.Name)
        ddlUnidadesEjecutoras.DataSource=dt
        ddlUnidadesEjecutoras.DataBind()

        If ddlUnidadesEjecutoras.Items.Count = 1 Then
            ddlUnidadesEjecutoras.Visible = False
            lblUnidadEjecutora.Text = ddlUnidadesEjecutoras.SelectedItem.Text
            lblUnidadEjecutora.Visible = True
        Else
            ddlUnidadesEjecutoras.Visible = True
            lblUnidadEjecutora.Text = Nothing
            lblUnidadEjecutora.Visible = False
        End If
    End Sub

End Class
