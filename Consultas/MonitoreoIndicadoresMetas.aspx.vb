Imports DevExpress.Web.ASPxGridView

Partial Class Consultas_MonitoreoIndicadoresMetas
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

        SqlDataSourceIndicadoresMetas.SelectParameters(0).DefaultValue = idMeta

        SqlDataSourceIndicadoresMetas.SelectCommand = "SELECT im.[IdIndicadorDeMeta], im.[IdMetasDeComponente], im.[IdIndicador], im.[Peso], ISNULL(SUM(sel.Peso / 100 * PorcentajeEjecucion),0) as PorcentajeEjecucion " & _
        "FROM [IndicadoresDeMeta] as im " & _
        "LEFT JOIN (SELECT pim.IdProgramasPorIndicadorDeMeta, pim.IdPrograma, pim.IdIndicadorDeMeta, pim.Peso, ISNULL(SUM(indrel.Peso / 100 * PorcentajeEjecucion),0) as PorcentajeEjecucion " & _
        "FROM [ProgramasPorIndicadorDeMeta] as pim " & _
        "LEFT JOIN (SELECT irp.[IdIndicadoresRelevantesDePrograma], irp.[IdProgramaPorIndicadorDeMeta], irp.[IdIndicadoresPorPrograma], irp.[Peso], " & _
        "COALESCE(SUM(mmpp.EjecutadoQ1+mmpp.EjecutadoQ2+mmpp.EjecutadoQ3+mmpp.EjecutadoQ4) / NULLIF(SUM(mmpp.ProyectadoQ1+mmpp.ProyectadoQ2+mmpp.ProyectadoQ3+mmpp.ProyectadoQ4),0), 0) as PorcentajeEjecucion, " & _
        "SUM(mmpp.ProyectadoQ1+mmpp.ProyectadoQ2+mmpp.ProyectadoQ3+mmpp.ProyectadoQ4) as Proyectado, " & _
        "SUM(mmpp.EjecutadoQ1+mmpp.EjecutadoQ2+mmpp.EjecutadoQ3+mmpp.EjecutadoQ4) as Ejectuado, " & _
        "NULLIF(SUM(mmpp.ProyectadoQ1+mmpp.ProyectadoQ2+mmpp.ProyectadoQ3+mmpp.ProyectadoQ4),0) as HayProyectado " & _
        "FROM [IndicadoresRelevantesDePrograma] as irp " & _
        "JOIN [dbo].[IndicadoresPorPrograma] as ipp ON irp.IdIndicadoresPorPrograma = ipp.IdIndicadoresPorPrograma " & _
        "JOIN [dbo].[MetaYMonitoreoPorPeriodo] as mmpp ON mmpp.IdIndicadorPorPrograma = ipp.IdIndicadoresPorPrograma " & _
        "WHERE [Peso] <> 0 " & _
        "GROUP BY irp.[IdIndicadoresRelevantesDePrograma], irp.[IdProgramaPorIndicadorDeMeta], irp.[IdIndicadoresPorPrograma], irp.[Peso]) as indrel " & _
        "ON pim.IdProgramasPorIndicadorDeMeta = indrel.IdProgramaPorIndicadorDeMeta " & _
        "WHERE pim.Peso <> 0 " & _
        "GROUP BY pim.IdProgramasPorIndicadorDeMeta, pim.IdPrograma, pim.IdIndicadorDeMeta, pim.Peso) as sel ON im.IdIndicadorDeMeta= sel.IdIndicadorDeMeta " & _
        "WHERE im.Peso <> 0 And [IdMetasDeComponente] = @IdMetasDeComponente " & _
        "GROUP BY im.[IdIndicadorDeMeta], im.[IdMetasDeComponente], im.[IdIndicador], im.[Peso]"
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


    Protected Sub ASPxGridViewProgramasIndicadoresMetas_HtmlDataCellPrepared(sender As Object, e As ASPxGridViewTableDataCellEventArgs)
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


    Protected Sub link1_Click(sender As Object, e As EventArgs)
        Dim idPolitica As String = uf.QueryStringDecode(Request.QueryString.Get(1))
        Dim politica As String = uf.QueryStringDecode(Request.QueryString.Get(0))
        Dim porcentaje As String = uf.QueryStringDecode(Request.QueryString.Get(2))

        Dim idComponente As String = uf.QueryStringDecode(Request.QueryString.Get(3))
        Dim componente As String = uf.QueryStringDecode(Request.QueryString.Get(4))
        Dim porcentajeC As String = uf.QueryStringDecode(Request.QueryString.Get(5))

        Dim idMeta As String = uf.QueryStringDecode(Request.QueryString.Get(6))
        Dim Meta As String = uf.QueryStringDecode(Request.QueryString.Get(7))
        Dim porcentajeM As String = uf.QueryStringDecode(Request.QueryString.Get(8))

        Dim index As Integer = ASPxGridViewindicadoresMetas.FocusedRowIndex

        Dim name As String = ASPxGridViewindicadoresMetas.GetRowValues(index, "IdIndicador").ToString

        Dim idIndicador As String = ASPxGridViewindicadoresMetas.GetRowValues(index, "IdIndicadorDeMeta").ToString

        Dim porI As String = ASPxGridViewindicadoresMetas.GetRowValues(index, "PorcentajeEjecucion").ToString


        Response.Redirect("MonitoreoProgramasIndicadores.aspx?NameP=" + uf.QueryStringEncode(politica) + "&CodP=" + uf.QueryStringEncode(idPolitica) + "&Porc=" + uf.QueryStringEncode(porcentaje) + "&CodC=" + uf.QueryStringEncode(idComponente) + "&NameC=" + uf.QueryStringEncode(componente) + "&PorcC=" + uf.QueryStringEncode(porcentajeC) + "&CodM=" + uf.QueryStringEncode(idMeta) + "&NameM=" + uf.QueryStringEncode(Meta) + "&PorM=" + uf.QueryStringEncode(porcentajeM) + "&CodI=" + uf.QueryStringEncode(idIndicador) + "&NameI=" + uf.QueryStringEncode(name) + "&PorI=" + uf.QueryStringEncode(porI))
    End Sub
End Class
