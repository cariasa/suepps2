Imports DevExpress.Web.ASPxGridView
Imports System.Windows.Forms

Partial Class GestionPublica_PlanificacionPrograma
    Inherits System.Web.UI.Page

    Public Programa As String
    Public CodPrograma As String
    Public user As String


    Protected Sub GridPrograma_CustomCallback(ByVal sender As Object, ByVal e As ASPxGridViewCustomCallbackEventArgs)

        If comboPolitica.Text = "" Then


            If user.Equals("suepps") = True Then

                SqlPrograma.SelectCommand = "SELECT * FROM [vProyectos]"

                GridPrograma.DataBind()

            Else

                SqlPrograma.SelectCommand = "SELECT * FROM [vProyectos] a join [UsuariosPorPrograma] b on b.IdPrograma= a.codigo_ficha   WHERE (b.[Usuario]='" + user + "' and b.Activo=1)"

                GridPrograma.DataBind()

            End If


        Else

            If user.Equals("suepps") Then

                SqlPrograma.SelectCommand = "SELECT * FROM [vProyectos] WHERE ([Politica] = '" + comboPolitica.Text + "')"

                GridPrograma.DataBind()

            Else

                SqlPrograma.SelectCommand = "SELECT * FROM [vProyectos] a join [UsuariosPorPrograma] b on b.IdPrograma= a.codigo_ficha   WHERE (a.[Politica] = '" + comboPolitica.Text + "' and b.[Usuario]='" + user + "' and b.Activo=1)"

                GridPrograma.DataBind()

            End If


        End If

    End Sub


    Protected Sub send(ByVal sender As Object, ByVal e As EventArgs)

        Dim index As Integer = GridPrograma.FocusedRowIndex()
        Dim nameproyecto As String = GridPrograma.GetRowValues(index, "NombreProyecto").ToString
        Dim codproyecto As String = GridPrograma.GetRowValues(index, "codigo_ficha").ToString

        Response.Redirect("Programa.aspx?NameP=" + uf.QueryStringEncode(nameproyecto) + "&CodP=" + uf.QueryStringEncode(codproyecto))

    End Sub

    Protected Sub Page_Load(sender As Object, e As EventArgs) Handles Me.Load
        'Verifica si el usuario tiene el acceso a la pagina solicitada
        Using dtMOCA As System.Data.DataTable = fMOCA.CheckPageAccess(1.02) 'este es el Id definido en el MOCA
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
                GridPrograma.Columns(4).Visible = dtMOCA.Rows.Item(0).Item("AllowAction01")
                Session("Asociar") = dtMOCA.Rows.Item(0).Item("AllowAction02")
            Else
                'Si no se recupero ningun dato se entendera que el usuario no tiene acceso a la pagina solicitada
                'y sera redireccionado a la Pagina siguiente que le notifica al usuario que no tiene acceso
                Response.Redirect("~/NoAccess.aspx")
            End If
        End Using

        user = Membership.GetUser.UserName
        'user = "jgarcia"



        If Session("Asociar") = True Then

            SqlPrograma.SelectCommand = "SELECT * FROM [vProyectos] WHERE ([Politica] = '" + comboPolitica.Text + "')"

            GridPrograma.DataBind()

        Else


            SqlPrograma.SelectCommand = "SELECT * FROM [vProyectos] a join [UsuariosPorPrograma] b on b.IdPrograma= a.codigo_ficha   WHERE ( b.[Usuario]='" + user + "' and b.Activo=1 )"

            GridPrograma.DataBind()

        End If



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

    Protected Sub GridPrograma_Load(sender As Object, e As EventArgs)


        If comboPolitica.Text = "" Then


            If Session("Asociar") = True Then

                SqlPrograma.SelectCommand = "SELECT * FROM [vProyectos]"

                GridPrograma.DataBind()

            Else

                SqlPrograma.SelectCommand = "SELECT * FROM [vProyectos] a join [UsuariosPorPrograma] b on b.IdPrograma= a.codigo_ficha   WHERE (b.[Usuario]='" + user + "' and b.Activo=1)"

                GridPrograma.DataBind()

            End If


        Else

            If Session("Asociar") = True Then

                SqlPrograma.SelectCommand = "SELECT * FROM [vProyectos] WHERE ([Politica] = '" + comboPolitica.Text + "')"

                GridPrograma.DataBind()

            Else

                SqlPrograma.SelectCommand = "SELECT * FROM [vProyectos] a join [UsuariosPorPrograma] b on b.IdPrograma= a.codigo_ficha   WHERE (a.[Politica] = '" + comboPolitica.Text + "' and b.[Usuario]='" + user + "' and b.Activo=1)"

                GridPrograma.DataBind()

            End If


        End If

    End Sub

    Protected Sub LinkButton1_Click(sender As Object, e As EventArgs)

        Dim index As Integer = GridPrograma.FocusedRowIndex()
        Dim nameproyecto As String = GridPrograma.GetRowValues(index, "NombreProyecto").ToString
        Dim codproyecto As String = GridPrograma.GetRowValues(index, "codigo_ficha").ToString

        Response.Redirect("Usuarios.aspx?NameP=" + nameproyecto + "&CodP=" + codproyecto)

    End Sub
End Class
