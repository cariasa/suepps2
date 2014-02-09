Imports DevExpress.Web.ASPxGridView

Partial Class Cuantitativo_IndicadoresEvaluación
    Inherits System.Web.UI.Page


    Protected Sub Page_Load(sender As Object, e As EventArgs) Handles Me.Load
        'Verifica si el usuario tiene el acceso a la pagina solicitada
        'Using dtMOCA As System.Data.DataTable = fMOCA.CheckPageAccess(3.05) 'este es el Id definido en el MOCA
        '    If dtMOCA.Rows.Count() > 0 Then
        '        ''Activa o Inactiva los objetos,(sean botones, grid, hiperlinks, etc),  
        '        ''en la pagina que se indique deacuerdo al parametro indicado
        '        'btnAgregar.Visible = dtMOCA.Rows.Item(0).Item("AllowAdd")

        '        ''Los siguientes datos pueden ser cambiados por los nombres de Objetos a los que corresponde la acción que se desea realizar, 
        '        ''si no hay necesidad de utilizar esta sección silo la eliminan dejandola en blanco y solo evaluando el acceso a la pagina
        '        'btnModificar.Visible = dtMOCA.Rows.Item(0).Item("AllowUpdate")
        '        'btnEliminar.Visible = dtMOCA.Rows.Item(0).Item("AllowDelete")
        '        'btnAutorizar.Visible = dtMOCA.Rows.Item(0).Item("AllowAction01")
        '        ''Object5.Visible = dtMOCA.Rows.Item(0).Item("AllowAction02")
        '        ''Object6.Visible = dtMOCA.Rows.Item(0).Item("AllowAction03")
        '        ''Object7.Visible = dtMOCA.Rows.Item(0).Item("AllowAction04")
        '        ''Object8.Visible = dtMOCA.Rows.Item(0).Item("AllowAction05")
        '        ''Object9.Visible = dtMOCA.Rows.Item(0).Item("AllowAction06")
        '        ''Object10.Visible = dtMOCA.Rows.Item(0).Item("AllowAction07")

        '        'Para activar o desactivar los botones en un ASPxGridView preferiblemente use variables de sessión
        '        Session("AllowAdd") = dtMOCA.Rows.Item(0).Item("AllowAdd")
        '        Session("AllowUpdate") = dtMOCA.Rows.Item(0).Item("AllowUpdate")
        '        Session("AllowDelete") = dtMOCA.Rows.Item(0).Item("AllowDelete")
        '    Else
        '        'Si no se recupero ningun dato se entendera que el usuario no tiene acceso a la pagina solicitada
        '        'y sera redireccionado a la Pagina siguiente que le notifica al usuario que no tiene acceso
        '        Response.Redirect("~/NoAccess.aspx")
        '    End If



        'End Using
        Session("IdPrograma") = uf.QueryStringDecode(Request.QueryString.Get(0))
        Session("NomPrograma") = uf.QueryStringDecode(Request.QueryString.Get(1))
        ASPxLabelTitulo.Text = "Asociar Indicadores de Evaluación a Programa " + Session("NomPrograma")
        SqlDataSourceIndicadoresEvaluacion.SelectParameters(0).DefaultValue = Session("IdPrograma")
        SqlDataSourceIndicadoresEvaluacion.DataBind()
        SqlDataSourceIndicadoresEvaluacion.InsertParameters(2).DefaultValue = Membership.GetUser.UserName
        GrisIndicadoresEvaluacion.DataBind()
    End Sub

    Protected Sub GridIndicadores_CustomCallback(sender As Object, e As ASPxGridViewCustomCallbackEventArgs)

        If e.Parameters = "" Then
            If combosector.Text <> "" Then
                Me.SqlIndicadores.SelectParameters(0).DefaultValue = CInt(combosector.Value)
                Me.GridIndicadores.DataBind()
            End If
        Else
            SqlIndicadores.SelectParameters(0).DefaultValue = 0
            SqlIndicadores.DataBind()
            GridIndicadores.DataBind()
        End If
    End Sub

    Protected Sub addIdentificador(ByVal sender As Object, ByVal e As EventArgs)

        Dim index As Integer = GridIndicadores.FocusedRowIndex()

        SqlDataSourceIndicadoresEvaluacion.InsertParameters(0).DefaultValue = GridIndicadores.GetRowValues(index, "IdIndicador")
        SqlDataSourceIndicadoresEvaluacion.InsertParameters(1).DefaultValue = Session("IdPrograma")
        SqlDataSourceIndicadoresEvaluacion.Insert()
        SqlDataSourceIndicadoresEvaluacion.DataBind()
        GrisIndicadoresEvaluacion.DataBind()

    End Sub

    Protected Sub GridIndicadores_Load(sender As Object, e As EventArgs)
        Me.SqlIndicadores.SelectParameters(0).DefaultValue = CInt(combosector.Value)
        Me.GridIndicadores.DataBind()
    End Sub

   
End Class
