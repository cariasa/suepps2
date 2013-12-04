Imports DevExpress.Web.ASPxGridView
Imports System.Windows.Forms

Partial Class Consultas_MonitoreoPoliticasComponentes
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
        Dim porcentajeL As Double = porcentaje * 100
        Dim porcentajeS As String = porcentajeL.ToString + "%"

        ASPxHyperLinkPolitica.Text = politica
        ASPxHyperLinkPolitica.NavigateUrl = "MonitoreoPoliticas.aspx"
        ASPxLabelPorcentaje.Text = (porcentaje * 100).ToString + "%"
        ASPxLabelPorcentaje.BackColor = devolverColor(porcentaje)

        If porcentaje < 0.5 Then
            ASPxLabelPorcentaje.BackColor = Drawing.Color.Salmon
        Else
            If porcentaje < 80 Then
                ASPxLabelPorcentaje.BackColor = Drawing.Color.PaleGoldenrod
            Else
                ASPxLabelPorcentaje.BackColor = Drawing.Color.LightGreen
            End If

        End If

        SqlDataSourceComponentesPoliticas.SelectParameters(0).DefaultValue = idPolitica

        SqlDataSourceComponentesPoliticas.SelectCommand = "SELECT cdp.IdComponentesDePolitica, cdp.[IdPolitica], cdp.[Nombre], cdp.[Descripcion], cdp.[Peso], ISNULL(SUM(sigC.Peso / 100 * PorcentajeEjecucion),0) as PorcentajeEjecucion " & _
       "FROM [ComponentesDePolitica] as cdp " & _
       "Left Join " & _
       "(SELECT mdp.[IdMetasDeComponente], mdp.[IdComponentesDePolitica], mdp.[Nombre], mdp.[Descripcion], mdp.[Peso], ISNULL(SUM(cond.Peso / 100 * PorcentajeEjecucion),0) as PorcentajeEjecucion " & _
       "FROM [MetasDeComponente] as mdp " & _
       "Left Join " & _
       "(SELECT im.[IdIndicadorDeMeta], im.[IdMetasDeComponente], im.[IdIndicador], im.[Peso], ISNULL(SUM(sel.Peso / 100 * PorcentajeEjecucion),0) as PorcentajeEjecucion " & _
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
       "WHERE im.Peso <> 0 " & _
       "GROUP BY im.[IdIndicadorDeMeta], im.[IdMetasDeComponente], im.[IdIndicador], im.[Peso]) as cond " & _
       "ON mdp.[IdMetasDeComponente] = cond.IdMetasDeComponente  " & _
       "GROUP BY mdp.[IdMetasDeComponente], mdp.[IdComponentesDePolitica], mdp.[Nombre], mdp.[Descripcion], mdp.[Peso]) as sigC " & _
       "ON cdp.IdComponentesDePolitica = sigC.[IdComponentesDePolitica] " & _
       "WHERE [IdPolitica]=@IdPolitica AND cdp.[Peso]<>0 " & _
       "GROUP BY cdp.IdComponentesDePolitica, cdp.[IdPolitica], cdp.[Nombre], cdp.[Descripcion], cdp.[Peso]"


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

    Protected Sub ASPxGridViewPoliticas_HtmlDataCellPrepared(sender As Object, e As ASPxGridViewTableDataCellEventArgs)
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


        Dim index As Integer = ASPxGridViewComponentesPoliticas.FocusedRowIndex

        Dim name As String = ASPxGridViewComponentesPoliticas.GetRowValues(index, "Nombre").ToString

        Dim codcomp As String = ASPxGridViewComponentesPoliticas.GetRowValues(index, "IdComponentesDePolitica").ToString



        Dim porC As String = ASPxGridViewComponentesPoliticas.GetRowValues(index, "PorcentajeEjecucion").ToString


        Response.Redirect("MonitoreoMetasComponentes.aspx?NameP=" + uf.QueryStringEncode(politica) + "&CodP=" + uf.QueryStringEncode(idPolitica) + "&Porc=" + uf.QueryStringEncode(porcentaje) + "&CodC=" + uf.QueryStringEncode(codcomp) + "&NameC=" + uf.QueryStringEncode(name) + "&PorcC=" + uf.QueryStringEncode(porC))
    End Sub
End Class
