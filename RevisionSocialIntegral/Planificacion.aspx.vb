Imports DevExpress.Web.ASPxGridView
Imports DevExpress.Web.ASPxClasses

Partial Class RevisionSocial_Planificacion
    Inherits System.Web.UI.Page

    Protected Sub GridPreguntas_CustomCallback(sender As Object, e As ASPxGridViewCustomCallbackEventArgs)

        Session("TipoActor") = Me.comboTipoActor.Value

        Me.SqlDataSourcePreguntas.SelectParameters(0).DefaultValue = Session("Programa").ToString
        Me.SqlDataSourcePreguntas.SelectParameters(1).DefaultValue = Me.comboTipoActor.Value

        Me.SqlDataSourcePreguntas.InsertParameters(0).DefaultValue = Me.comboTipoActor.Value
        Me.SqlDataSourcePreguntas.InsertParameters(1).DefaultValue = Session("Programa").ToString
        Me.SqlDataSourcePreguntas.InsertParameters(2).DefaultValue = Membership.GetUser.UserName

        Me.SqlDataSourcePreguntas.UpdateParameters(0).DefaultValue = Membership.GetUser.UserName

        GridPreguntas.DataBind()

    End Sub

    Protected Function IsGridOpcionesVisible(ByVal IdPreguntaDeMonitoreo As Object) As Boolean
        Dim Tipo As Integer = GridPreguntas.GetRowValuesByKeyValue(IdPreguntaDeMonitoreo, "IdTipoDePregunta")
        Return (3 = Tipo Or 4 = Tipo)
    End Function

    Protected Function IsGridOpcionesVisible2(ByVal IdPreguntaDeMonitoreo As Object) As Boolean
        Dim Tipo As Integer = ASPxGridViewPreguntasPorPrograma.GetRowValuesByKeyValue(IdPreguntaDeMonitoreo, "IdTipoDePregunta")
        Return (3 = Tipo Or 4 = Tipo)
    End Function


    Protected Sub ASPxGridViewOpciones_BeforePerformDataSelect(sender As Object, e As EventArgs)
        Session("IdPreguntaDeMonitoreo") = CType(sender, ASPxGridView).GetMasterRowKeyValue()
    End Sub

    Protected Sub Page_Init(sender As Object, e As EventArgs) Handles Me.Init

        Me.Programa.Text = uf.QueryStringDecode(Request.QueryString.Get(0))

        Session("Programa") = uf.QueryStringDecode(Request.QueryString.Get(1))

        SqlActoresPorPrograma.SelectParameters(0).DefaultValue = Session("Programa").ToString

        SqlActoresPorPrograma.InsertParameters(0).DefaultValue = Session("Programa").ToString
        SqlActoresPorPrograma.InsertParameters(1).DefaultValue = Membership.GetUser.UserName


        SqlActoresPorPrograma.UpdateParameters(0).DefaultValue = Membership.GetUser.UserName

        SqlActoresPorPrograma.DeleteParameters(1).DefaultValue = Membership.GetUser.UserName

        Me.SqlDataSourcePreguntasPorPrograma.SelectParameters(0).DefaultValue = Session("Programa")

        Me.SqlDataSourcePreguntasPorPrograma.InsertParameters(0).DefaultValue = Session("Programa")
        Me.SqlDataSourcePreguntasPorPrograma.InsertParameters(1).DefaultValue = Membership.GetUser.UserName

        Me.SqlDataSourcePreguntasPorPrograma.UpdateParameters(0).DefaultValue = Membership.GetUser.UserName

        If Session("Programa") Is Nothing Or Session("TipoActor") Is Nothing Then

        Else

            Me.SqlDataSourcePreguntas.SelectParameters(0).DefaultValue = Session("Programa").ToString
            Me.SqlDataSourcePreguntas.SelectParameters(1).DefaultValue = Session("TipoActor").ToString

            Me.SqlDataSourcePreguntas.InsertParameters(0).DefaultValue = Session("TipoActor").ToString
            Me.SqlDataSourcePreguntas.InsertParameters(1).DefaultValue = Session("Programa").ToString
            Me.SqlDataSourcePreguntas.InsertParameters(2).DefaultValue = Membership.GetUser.UserName

            Me.SqlDataSourcePreguntas.UpdateParameters(0).DefaultValue = Membership.GetUser.UserName



            '///////////////////////////////////////////////////////////////////////////////////////////////
            Me.SqlDataSourcePreguntasPorPrograma.SelectParameters(0).DefaultValue = Session("Programa")

            Me.SqlDataSourcePreguntasPorPrograma.InsertParameters(0).DefaultValue = Session("Programa")
            Me.SqlDataSourcePreguntasPorPrograma.InsertParameters(1).DefaultValue = Membership.GetUser.UserName

            Me.SqlDataSourcePreguntasPorPrograma.UpdateParameters(0).DefaultValue = Membership.GetUser.UserName



        End If


        SqlActoresPorPrograma.InsertCommand = "SET @AP = (SELECT IdActorPorPrograma FROM [ActoresPorPrograma] " & _
        "where Usuario = @Usuario and IdPrograma= @Programa " & _
         " and Activo=1" & _
            ")" & _
        "IF (@AP is NULL)" & _
            "BEGIN " & _
    "INSERT INTO [ActoresPorPrograma] ([Usuario],[IdTipoDeActor],[IdPrograma],[CreadoPor],[FechaCreacion],[Activo]) VALUES (@Usuario,@IdTipoDeActor,@Programa,@Creado,getDate(),1)" & _
     "END"

        'Me.SqlDataSourcePreguntasPorPrograma.SelectParameters(0).DefaultValue = Session("Programa").ToString
        'Me.SqlDataSourcePreguntasPorPrograma.InsertParameters(0).DefaultValue = Session("Programa").ToString
    End Sub

    Protected Sub Page_Load(sender As Object, e As EventArgs) Handles Me.Load
        'Verifica si el usuario tiene el acceso a la pagina solicitada
        Using dtMOCA As System.Data.DataTable = fMOCA.CheckPageAccess(2.01) 'este es el Id definido en el MOCA
            If True Then 'dtMOCA.Rows.Count() > 0 Then
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

    End Sub



    Protected Sub ASPxGridViewOpcionesPreguntasPorPrograma_BeforePerformDataSelect1(sender As Object, e As EventArgs)
        Session("IdPreguntaDeMonitoreo") = CType(sender, ASPxGridView).GetMasterRowKeyValue()
        SqlDataSourceOpcionesPreguntasPorPrograma.InsertParameters(0).DefaultValue = Session("IdPreguntaDeMonitoreo")
    End Sub

    Protected Sub ASPxGridViewPreguntasPorPrograma_BeforePerformDataSelect(sender As Object, e As EventArgs)
        Me.SqlDataSourcePreguntasPorPrograma.SelectParameters(0).DefaultValue = Session("Programa")
        Me.SqlDataSourcePreguntasPorPrograma.InsertParameters(0).DefaultValue = Session("Programa")
    End Sub

    Protected Sub ASPxGridViewPreguntasPorPrograma_Load(sender As Object, e As EventArgs)
        Me.SqlDataSourcePreguntasPorPrograma.SelectParameters(0).DefaultValue = Session("Programa")

    End Sub

    Protected Sub SqlActoresPorPrograma_Inserted(sender As Object, e As SqlDataSourceStatusEventArgs)
        SqlActoresPorPrograma.SelectParameters(0).DefaultValue = Session("Programa").ToString
        SqlActoresPorPrograma.DataBind()
        Me.ASPxGridView1.DataBind()
    End Sub

    Protected Sub SqlDataSourcePreguntasPorPrograma_Inserted(sender As Object, e As SqlDataSourceStatusEventArgs)
        Me.SqlDataSourcePreguntasPorPrograma.SelectParameters(0).DefaultValue = Session("Programa")
        SqlDataSourceOpcionesPreguntasPorPrograma.DataBind()
        Me.ASPxGridViewPreguntasPorPrograma.DataBind()

    End Sub

    Protected Sub ASPxGridView1_Load(sender As Object, e As EventArgs)
        SqlActoresPorPrograma.SelectParameters(0).DefaultValue = Session("Programa")
        ASPxGridView1.DataBind()
    End Sub

    Protected Sub GridPreguntas_Load(sender As Object, e As EventArgs)
        Me.SqlDataSourcePreguntas.SelectParameters(0).DefaultValue = Session("Programa").ToString
        Me.SqlDataSourcePreguntas.SelectParameters(1).DefaultValue = Me.comboTipoActor.Value
        Me.GridPreguntas.DataBind()
    End Sub


End Class
