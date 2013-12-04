Imports DevExpress.Web.ASPxGridView


Partial Class RevisionSocialIntegral
    Inherits System.Web.UI.Page

    Public Programa As String
    Public CodPrograma As String


    Protected Sub GridPrograma_CustomCallback(ByVal sender As Object, ByVal e As ASPxGridViewCustomCallbackEventArgs)
        If comboPolitica.Text = "" Then

            SqlPrograma.SelectCommand = "SELECT * FROM [vProyectos]"
            Me.GridPrograma.DataBind()

        Else
            SqlPrograma.SelectCommand = "SELECT * FROM [vProyectos] WHERE ([Politica] = '" + comboPolitica.Text + "')"

            Me.GridPrograma.DataBind()
        End If

    End Sub


    Protected Sub send(ByVal sender As Object, ByVal e As EventArgs)

        Dim index As Integer = GridPrograma.FocusedRowIndex()
        Dim nameproyecto As String = GridPrograma.GetRowValues(index, "NombreProyecto").ToString
        Dim codproyecto As String = GridPrograma.GetRowValues(index, "codigo_ficha").ToString

        Session("Programa") = Nothing
        Session("TipoActor") = Nothing

        Response.Redirect("Planificacion.aspx?NameP=" + uf.QueryStringEncode(nameproyecto) + "&CodP=" + uf.QueryStringEncode(codproyecto))

    End Sub

    Protected Sub ASPxGridView2_BeforePerformDataSelect(sender As Object, e As EventArgs)

        Session("IdPolitica") = CType(sender, ASPxGridView).GetMasterRowKeyValue()


    End Sub

    Protected Sub send2(ByVal sender As Object, ByVal e As EventArgs)

        Dim index As Integer = GridPrograma.FocusedRowIndex()
        Dim nameproyecto As String = GridPrograma.GetRowValues(index, "NombreProyecto").ToString
        Dim codproyecto As String = GridPrograma.GetRowValues(index, "codigo_ficha").ToString

        Response.Redirect("MonitoreoCualitativo.aspx?NameP=" + uf.QueryStringEncode(nameproyecto) + "&CodP=" + uf.QueryStringEncode(codproyecto))

    End Sub


    Protected Sub Page_Load(sender As Object, e As EventArgs) Handles Me.Load
        'Verifica si el usuario tiene el acceso a la pagina solicitada
        Using dtMOCA As System.Data.DataTable = fMOCA.CheckPageAccess(2.01) 'este es el Id definido en el MOCA
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

    Protected Sub link3_Click(sender As Object, e As EventArgs)
        Dim index As Integer = GridPrograma.FocusedRowIndex()
        Dim nameproyecto As String = GridPrograma.GetRowValues(index, "NombreProyecto").ToString
        Dim codproyecto As String = GridPrograma.GetRowValues(index, "codigo_ficha").ToString
        Response.Redirect("InsumosDeSistematizacion.aspx?NameP=" + uf.QueryStringEncode(nameproyecto) + "&CodP=" + uf.QueryStringEncode(codproyecto))
    End Sub

    Protected Sub GridPrograma_Load(sender As Object, e As EventArgs)
        If comboPolitica.Text = "" Then

            SqlPrograma.SelectCommand = "SELECT * FROM [vProyectos]"
            Me.GridPrograma.DataBind()

        Else
            SqlPrograma.SelectCommand = "SELECT * FROM [vProyectos] WHERE ([Politica] = '" + comboPolitica.Text + "')"

            Me.GridPrograma.DataBind()
        End If
    End Sub
End Class
