Imports DevExpress.Web.ASPxGridView

Partial Class Evaluacion_Levantamientos
    Inherits System.Web.UI.Page

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


            Session("IdInstrumento") = uf.QueryStringDecode(Request.QueryString.Get(0))
            Session("IdAplicacion") = uf.QueryStringDecode(Request.QueryString.Get(1))
            Session("NomInstrumento") = uf.QueryStringDecode(Request.QueryString.Get(2))
            ASPxLabelTitulo.Text = "Análisis Cualitativo de Instrumento " + Session("NomInstrumento")
            Me.SqlPreguntas.SelectCommand = " select PI.IdPreguntaPorInstrumento,PI.IdInstrumentoDeEvaluacion,PI.PreguntaDeInstrumento,PI.IdAmigable,PI.IdTipoDePregunta,SF.NombreSeccion,PI.Orden  from PreguntasPorInstrumento PI " & _
            "join SeccionesFSU SF on SF.IdSeccionFSU= PI.IdSeccionFSU " & _
            "where PI.[IdInstrumentoDeEvaluacion]=@IdInstrumento and PI.Activo=1 order by SF.NombreSeccion,PI.Orden "

            Me.SqlPreguntas.SelectParameters(0).DefaultValue = Session("IdInstrumento")
            Me.SqlPreguntas.DataBind()
            Me.GridPreguntas.DataBind()

           

        End Using

    End Sub

    Protected Function IsGridOpcionesVisible3(ByVal IdPreguntaDeMonitoreo As Object) As Boolean

        Dim Tipo As Integer = Session("IdTipo")

        If (3 = Tipo Or 4 = Tipo Or 5 = Tipo Or 6 = Tipo Or 7 = Tipo) Then

            Return True
        Else
            Return False

        End If
  
    End Function

    Protected Sub GridRespuestas_BeforePerformDataSelect1(sender As Object, e As EventArgs)

        Dim index As Integer

        For i As Integer = 0 To GridPreguntas.VisibleRowCount - 1

            If (GridPreguntas.GetRowValues(i, "IdPreguntaPorInstrumento") = CType(sender, ASPxGridView).GetMasterRowKeyValue()) Then
                index = i
            End If

        Next

        Session("IdTipo") = GridPreguntas.GetRowValues(index, "IdTipoDePregunta")

        SqlRespuestas.SelectParameters(0).DefaultValue = CType(sender, ASPxGridView).GetMasterRowKeyValue()
        SqlRespuestas.SelectParameters(1).DefaultValue = Session("IdAplicacion")
        SqlRespuestas.DataBind()


    End Sub

    Protected Sub ASPxGridViewOpciones_BeforePerformDataSelect1(sender As Object, e As EventArgs)

        SqlDataSourceOpciones.SelectParameters(0).DefaultValue = CType(sender, ASPxGridView).GetMasterRowKeyValue()
        SqlDataSourceOpciones.DataBind()

    End Sub

    Protected Sub ASPxGridView1_BeforePerformDataSelect(sender As Object, e As EventArgs)

        SqlAnalisisCualitativo.SelectParameters(0).DefaultValue = CType(sender, ASPxGridView).GetMasterRowKeyValue()
        SqlAnalisisCualitativo.DataBind()

        SqlAnalisisCualitativo.InsertParameters(0).DefaultValue = CType(sender, ASPxGridView).GetMasterRowKeyValue()
        SqlAnalisisCualitativo.InsertParameters(2).DefaultValue = Membership.GetUser.UserName






    End Sub
End Class
