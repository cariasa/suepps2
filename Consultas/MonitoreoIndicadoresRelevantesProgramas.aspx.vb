Imports DevExpress.Web.ASPxGridView
Imports System.Data.Common
Imports System.Data.SqlClient

Partial Class Consultas_MonitoreoIndicadoresRelevantesPrograma
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As EventArgs) Handles Me.Load
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
        End Using
        Dim idPolitica As Integer = uf.QueryStringDecode(Request.QueryString.Get(1))
        Dim politica As String = uf.QueryStringDecode(Request.QueryString.Get(0))
        Dim porcentaje As Double = uf.QueryStringDecode(Request.QueryString.Get(2))

        Dim idComponente As String = uf.QueryStringDecode(Request.QueryString.Get(3))
        Dim componente As String = uf.QueryStringDecode(Request.QueryString.Get(4))
        Dim porcentajeC As String = uf.QueryStringDecode(Request.QueryString.Get(5))

        Dim idMeta As String = uf.QueryStringDecode(Request.QueryString.Get(6))
        Dim meta As String = uf.QueryStringDecode(Request.QueryString.Get(7))
        Dim porcentajeM As String = uf.QueryStringDecode(Request.QueryString.Get(8))

        Dim idIndicador As String = uf.QueryStringDecode(Request.QueryString.Get(9))
        Dim indicador As String = uf.QueryStringDecode(Request.QueryString.Get(10))
        Dim porcentajeI As String = uf.QueryStringDecode(Request.QueryString.Get(11))

        Dim idPrograma As String = uf.QueryStringDecode(Request.QueryString.Get(12))
        Dim programa As String = uf.QueryStringDecode(Request.QueryString.Get(13))
        Dim porcentajeP As String = uf.QueryStringDecode(Request.QueryString.Get(14))


        ASPxHyperLinkPolitica.Text = politica
        ASPxHyperLinkPolitica.NavigateUrl = "MonitoreoPoliticas.aspx"
        ASPxLabelPorcentaje.Text = (porcentaje * 100).ToString + "%"
        ASPxLabelPorcentaje.BackColor = devolverColor(porcentaje)

        ASPxHyperLinkComponente.Text = componente
        ASPxHyperLinkComponente.NavigateUrl = "MonitoreoPoliticasComponentes.aspx?NameP=" + uf.QueryStringEncode(politica) + "&CodP=" + uf.QueryStringEncode(idPolitica.ToString) + "&Porc=" + uf.QueryStringEncode(porcentaje.ToString)
        ASPxLabelPorcentajeC.Text = (porcentajeC * 100).ToString + "%"
        ASPxLabelPorcentajeC.BackColor = devolverColor(porcentajeC)

        ASPxHyperLinkMeta.Text = meta
        ASPxHyperLinkMeta.NavigateUrl = "MonitoreoMetasComponentes.aspx?NameP=" + uf.QueryStringEncode(politica) + "&CodP=" + uf.QueryStringEncode(idPolitica.ToString) + "&Porc=" + uf.QueryStringEncode(porcentaje.ToString) + "&CodC=" + uf.QueryStringEncode(idComponente) + "&NameC=" + uf.QueryStringEncode(componente) + "&PorcC=" + uf.QueryStringEncode(porcentajeC)
        ASPxLabelPorcentajeM.Text = (porcentajeM * 100).ToString + "%"
        ASPxLabelPorcentajeM.BackColor = devolverColor(porcentajeM)

        ASPxLabelPorcentajeI.Text = (porcentajeI * 100).ToString + "%"
        ASPxLabelPorcentajeI.BackColor = devolverColor(porcentajeI)

        ASPxLabelPorcentajeP.Text = (porcentajeP * 100).ToString + "%"
        ASPxLabelPorcentajeP.BackColor = devolverColor(porcentajeP)

        SqlDataSourceIndicadoresRelevantes.SelectParameters(0).DefaultValue = idPrograma
        SqlDataSourceIndicadoresRelevantes.SelectCommand = "SELECT irp.[IdIndicadoresRelevantesDePrograma], irp.[IdProgramaPorIndicadorDeMeta], irp.[IdIndicadoresPorPrograma], irp.[Peso], " & _
            "COALESCE(SUM(mmpp.EjecutadoQ1+mmpp.EjecutadoQ2+mmpp.EjecutadoQ3+mmpp.EjecutadoQ4) / NULLIF(SUM(mmpp.ProyectadoQ1+mmpp.ProyectadoQ2+mmpp.ProyectadoQ3+mmpp.ProyectadoQ4),0), 0) as PorcentajeEjecucion, " & _
            "SUM(mmpp.ProyectadoQ1+mmpp.ProyectadoQ2+mmpp.ProyectadoQ3+mmpp.ProyectadoQ4) as Proyectado, " & _
            "SUM(mmpp.EjecutadoQ1+mmpp.EjecutadoQ2+mmpp.EjecutadoQ3+mmpp.EjecutadoQ4) as Ejectuado, " & _
            "NULLIF(SUM(mmpp.ProyectadoQ1+mmpp.ProyectadoQ2+mmpp.ProyectadoQ3+mmpp.ProyectadoQ4),0) as HayProyectado " & _
            "FROM [IndicadoresRelevantesDePrograma] as irp " & _
            "JOIN [dbo].[IndicadoresPorPrograma] as ipp ON irp.IdIndicadoresPorPrograma = ipp.IdIndicadoresPorPrograma " & _
            "JOIN [dbo].[MetaYMonitoreoPorPeriodo] as mmpp ON mmpp.IdIndicadorPorPrograma = ipp.IdIndicadoresPorPrograma " & _
             "WHERE [Peso]<>0 AND irp.[IdProgramaPorIndicadorDeMeta]=@IdProgramaPorIndicadorDeMeta GROUP BY irp.[IdIndicadoresRelevantesDePrograma], irp.[IdProgramaPorIndicadorDeMeta], irp.[IdIndicadoresPorPrograma], irp.[Peso]"


        Dim connectionString As String = ConfigurationManager.ConnectionStrings("SUEPPSConnectionString").ConnectionString
        Dim connection As SqlConnection = New SqlConnection(connectionString)
        connection.Open()
        Dim sql As String = "SELECT [NombreProyecto] FROM [vProyectos] WHERE [codigo_ficha]= " + programa
        Dim command As SqlCommand = New SqlCommand(sql, connection)
        Dim reader As SqlDataReader = command.ExecuteReader()
        'Dim customerId As Integer
        If (reader.Read()) Then

            ASPxHyperLinkPrograma.Text = reader.GetValue(0)
            ASPxHyperLinkPrograma.NavigateUrl = "MonitoreoProgramasIndicadores.aspx?NameP=" + uf.QueryStringEncode(politica) + "&CodP=" + uf.QueryStringEncode(idPolitica.ToString) + "&Porc=" + uf.QueryStringEncode(porcentaje.ToString) + "&CodC=" + uf.QueryStringEncode(idComponente) + "&NameC=" + uf.QueryStringEncode(componente) + "&PorcC=" + uf.QueryStringEncode(porcentajeC) + "&CodM=" + uf.QueryStringEncode(idMeta) + "&NameM=" + uf.QueryStringEncode(meta) + "&PorM=" + uf.QueryStringEncode(porcentajeM) + "&CodI=" + uf.QueryStringEncode(idIndicador) + "&NameI=" + uf.QueryStringEncode(indicador) + "&PorI=" + uf.QueryStringEncode(porcentajeI)
        End If
        reader.Close()

        sql = "SELECT [DescripcionIndicador] FROM [Indicadores] WHERE [IdIndicador]=" + indicador
        command = New SqlCommand(sql, connection)
        reader = command.ExecuteReader()
        If (reader.Read()) Then

            ASPxHyperLinkIndicador.Text = reader.GetValue(0)
            ASPxHyperLinkIndicador.NavigateUrl = "MonitoreoIndicadoresMetas.aspx?NameP=" + uf.QueryStringEncode(politica) + "&CodP=" + uf.QueryStringEncode(idPolitica.ToString) + "&Porc=" + uf.QueryStringEncode(porcentaje.ToString) + "&CodC=" + uf.QueryStringEncode(idComponente) + "&NameC=" + uf.QueryStringEncode(componente) + "&PorcC=" + uf.QueryStringEncode(porcentajeC) + "&CodM=" + uf.QueryStringEncode(idMeta) + "&NameM=" + uf.QueryStringEncode(meta) + "&PorM=" + uf.QueryStringEncode(porcentajeM)


        End If
        reader.Close()


    End Sub

    Protected Function devolverColor(porcentaje As Double) As Drawing.Color
        If porcentaje < 0.5 Then
            Return Drawing.Color.Salmon
        Else
            If porcentaje < 0.8 Then
                Return Drawing.Color.PaleGoldenrod
            Else
                Return Drawing.Color.LightGreen
            End If

        End If
    End Function




    Protected Sub ASPxGridViewIndicadoresRelevantes_HtmlDataCellPrepared(sender As Object, e As ASPxGridViewTableDataCellEventArgs)
        If e.DataColumn.FieldName = "PorcentajeEjecucion" Then

            If Convert.ToDouble(e.CellValue) < 0.5 Then

                'e.Row.BackColor = System.Drawing.Color.Salmon
                e.Cell.BackColor = System.Drawing.Color.Salmon
            End If
            If Convert.ToDouble(e.CellValue) >= 0.5 And (Convert.ToDouble(e.CellValue) < 0.8) Then

                'e.Row.BackColor = System.Drawing.Color.PaleGoldenrod
                e.Cell.BackColor = System.Drawing.Color.PaleGoldenrod
            End If
            If (Convert.ToDouble(e.CellValue) >= 0.8) Then

                'e.Row.BackColor = System.Drawing.Color.LightGreen
                e.Cell.BackColor = System.Drawing.Color.LightGreen
            End If
        Else
            e.Cell.BackColor = System.Drawing.Color.White
        End If
    End Sub


End Class
