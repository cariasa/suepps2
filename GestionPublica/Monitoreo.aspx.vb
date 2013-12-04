Imports Microsoft.VisualBasic
Imports System
Imports System.Web.UI
Imports DevExpress.Web.ASPxEditors
Imports DevExpress.Web.ASPxTabControl
Imports DevExpress.Web.ASPxGridView
Imports System.Collections
Imports System.Web
Imports System.Web.Security

Partial Class GestionPublica_Monitoreo
    Inherits System.Web.UI.Page


    Public user As String

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As EventArgs)
        'Verifica si el usuario tiene el acceso a la pagina solicitada
        Using dtMOCA As System.Data.DataTable = fMOCA.CheckPageAccess(1.03) 'este es el Id definido en el MOCA
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

    Protected Sub grid_custom(ByVal sender As Object, ByVal e As ASPxGridViewCustomCallbackEventArgs)

        If comboPolitica.Text = "" Then


            If Session("Asociar") = True Then

                SqlDataSourceProyectos.SelectCommand = "SELECT * FROM [vProyectos]"

                grid.DataBind()

            Else

                SqlDataSourceProyectos.SelectCommand = "SELECT * FROM [vProyectos] a join [UsuariosPorPrograma] b on b.IdPrograma= a.codigo_ficha   WHERE (b.[Usuario]='" + user + "' and b.Activo=1)"

                grid.DataBind()

            End If


        Else

            If Session("Asociar") Then

                SqlDataSourceProyectos.SelectCommand = "SELECT * FROM [vProyectos] WHERE ([Politica] = '" + comboPolitica.Text + "')"

                grid.DataBind()

            Else

                SqlDataSourceProyectos.SelectCommand = "SELECT * FROM [vProyectos] a join [UsuariosPorPrograma] b on b.IdPrograma= a.codigo_ficha   WHERE (a.[Politica] = '" + comboPolitica.Text + "' and b.[Usuario]='" + user + "' and b.Activo=1)"

                grid.DataBind()

            End If


        End If


    End Sub

    Protected Sub send(ByVal sender As Object, ByVal e As EventArgs)

        Dim index As Integer = grid.FocusedRowIndex

        Dim nameproyecto As String = grid.GetRowValues(index, "NombreProyecto").ToString

        Dim codproyecto As String = grid.GetRowValues(index, "codigo_ficha").ToString


        Response.Redirect("MonitoreoCuantitativo.aspx?NameP=" + uf.QueryStringEncode(nameproyecto) + "&CodP=" + uf.QueryStringEncode(codproyecto))

    End Sub

    Protected Sub sendI(ByVal sender As Object, ByVal e As EventArgs)

        Dim index As Integer = grid.FocusedRowIndex

        Dim nameproyecto As String = grid.GetRowValues(index, "NombreProyecto").ToString

        Dim codproyecto As String = grid.GetRowValues(index, "codigo_ficha").ToString


        Response.Redirect("InsumosDeSistematizacion.aspx?NameP=" + uf.QueryStringEncode(nameproyecto) + "&CodP=" + uf.QueryStringEncode(codproyecto))

    End Sub



    Protected Sub grid_Load(sender As Object, e As EventArgs)

        'user = Membership.GetUser.UserName
        user = "pacoloco"

        If comboPolitica.Text = "" Then


            If Session("Asociar") = True Then

                SqlDataSourceProyectos.SelectCommand = "SELECT * FROM [vProyectos]"

                grid.DataBind()

            Else

                SqlDataSourceProyectos.SelectCommand = "SELECT * FROM [vProyectos] a join [UsuariosPorPrograma] b on b.IdPrograma= a.codigo_ficha   WHERE (b.[Usuario]='" + user + "' and b.Activo=1)"

                grid.DataBind()

            End If


        Else

            If Session("Asociar") Then

                SqlDataSourceProyectos.SelectCommand = "SELECT * FROM [vProyectos] WHERE ([Politica] = '" + comboPolitica.Text + "')"

                grid.DataBind()

            Else

                SqlDataSourceProyectos.SelectCommand = "SELECT * FROM [vProyectos] a join [UsuariosPorPrograma] b on b.IdPrograma= a.codigo_ficha   WHERE (a.[Politica] = '" + comboPolitica.Text + "' and b.[Usuario]='" + user + "' and b.Activo=1)"

                grid.DataBind()

            End If


        End If

    End Sub

    Protected Sub Page_Load1(sender As Object, e As EventArgs) Handles Me.Load
        'Verifica si el usuario tiene el acceso a la pagina solicitada
        Using dtMOCA As System.Data.DataTable = fMOCA.CheckPageAccess(1.03) 'este es el Id definido en el MOCA
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
                grid.Columns(4).Visible = dtMOCA.Rows.Item(0).Item("AllowAction01")
                Session("Asociar") = dtMOCA.Rows.Item(0).Item("AllowAction02")
            Else
                'Si no se recupero ningun dato se entendera que el usuario no tiene acceso a la pagina solicitada
                'y sera redireccionado a la Pagina siguiente que le notifica al usuario que no tiene acceso
                Response.Redirect("~/NoAccess.aspx")
            End If
        End Using

        user = Membership.GetUser.UserName
        'user = "pacoloco"



        If Session("Asociar") = True Then

            SqlDataSourceProyectos.SelectCommand = "SELECT * FROM [vProyectos] WHERE ([Politica] = '" + comboPolitica.Text + "')"

            grid.DataBind()

        Else


            SqlDataSourceProyectos.SelectCommand = "SELECT * FROM [vProyectos] a join [UsuariosPorPrograma] b on b.IdPrograma= a.codigo_ficha   WHERE ( b.[Usuario]='" + user + "' and b.Activo=1 )"

            grid.DataBind()

        End If
    End Sub
End Class