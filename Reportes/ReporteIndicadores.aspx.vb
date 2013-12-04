Imports System.Windows.Forms
Imports System.Data
Imports DevExpress.Web.ASPxClasses
Imports DevExpress.XtraCharts

Partial Class Reportes_ReporteIndicadores
    Inherits System.Web.UI.Page


    Protected Sub Page_Init(sender As Object, e As EventArgs) Handles Me.Init
        ASPxComboBoxAno.Items.Add("2010", 2010)
        ASPxComboBoxAno.Items.Add("2011", 2011)
        ASPxComboBoxAno.Items.Add("2012", 2012)
        ASPxComboBoxAno.Items.Add("2013", 2013)
        ASPxComboBoxAno.Items.Add("2014", 2014)
        ASPxComboBoxAno.Items.Add("2015", 2015)
        ASPxComboBoxAno.Items.Add("2016", 2016)
        ASPxComboBoxAno.Items.Add("2017", 2017)
        ASPxComboBoxAno.Items.Add("2018", 2018)
        ASPxComboBoxAno.Items.Add("2019", 2019)
        ASPxComboBoxAno.Items.Add("2020", 2020)


    End Sub

    Protected Sub lbAvailable_Init(sender As Object, e As EventArgs) Handles lbAvailable.Init
        SqlDataSourceIndicadoresDeMeta.SelectCommand = "SELECT im.IdIndicadorDeMeta, i.DescripcionIndicador, i.IdIndicador from [IndicadoresDeMeta] im, [Indicadores] i WHERE im.IdIndicador = i.IdIndicador AND im.IdMetasDeComponente = @IdMetasDeComponente AND im.Activo=1 and i.Activo=1"


    End Sub

    Protected Sub cmbComponente_Callback(sender As Object, e As CallbackEventArgsBase)
        SqlDataSourceComponentes.SelectParameters(0).DefaultValue = Me.cmbPolitica.Value

        cmbComponente.DataBind()
    End Sub

    Protected Sub cmbMetas_Callback(sender As Object, e As CallbackEventArgsBase)

        SqlDataSourceMetas.SelectParameters(0).DefaultValue = Me.cmbComponente.Value
        cmbMetas.DataBind()
    End Sub

    Protected Sub lbAvailable_Callback(sender As Object, e As CallbackEventArgsBase)

        SqlDataSourceIndicadoresDeMeta.SelectParameters(0).DefaultValue = cmbMetas.Value
        lbAvailable.DataBind()
    End Sub

    Protected Sub ASPxButtonGraficar_Click(sender As Object, e As EventArgs)
        For i As Integer = 0 To lbChoosen.SelectedItems.Count - 1

            SqlDataSourceIndicadoresMetasGraficar.SelectCommand = "SELECT " & _
            "IdMetasDeComponente," & _
            "IDM.IdIndicadorDeMeta, " & _
            "Peso as PesoIndicadorMeta, " & _
            "I.IdIndicador, " & _
            "I.DescripcionIndicador, " & _
            "SUM(PesoPrograma/100*PorcentajeEjecucionQ1) as PorcentajeEjecucionQ1," & _
            "SUM(PesoPrograma/100*PorcentajeEjecucionQ2) as PorcentajeEjecucionQ2, " & _
            "SUM(PesoPrograma/100*PorcentajeEjecucionQ3) as PorcentajeEjecucionQ3, " & _
            "SUM(PesoPrograma/100*PorcentajeEjecucionQ4) as PorcentajeEjecucionQ4, " & _
            "SUM(PesoPrograma/100*PorcentajeEjecucion) as PorcentajeEjecucion " & _
            "FROM " & _
            "IndicadoresDeMeta IDM " & _
            "JOIN Indicadores I on I.IdIndicador=IDM.IdIndicador " & _
            "Join " & _
            "(SELECT " & _
                "IdIndicadorDeMeta, " & _
                "IdProgramasPorIndicadorDeMeta, " & _
                "Peso as PesoPrograma, " & _
                "SUM(PesoIndicadorPrograma/100*PorcentajeEjecucionQ1) as PorcentajeEjecucionQ1, " & _
                "SUM(PesoIndicadorPrograma/100*PorcentajeEjecucionQ2) as PorcentajeEjecucionQ2, " & _
                "SUM(PesoIndicadorPrograma/100*PorcentajeEjecucionQ3) as PorcentajeEjecucionQ3, " & _
                "SUM(PesoIndicadorPrograma/100*PorcentajeEjecucionQ4) as PorcentajeEjecucionQ4, " & _
                "SUM(PesoIndicadorPrograma/100*PorcentajeEjecucion) as PorcentajeEjecucion " & _
            "From " & _
            "ProgramasPorIndicadorDeMeta PPIM " & _
            "Join " & _
                "(SELECT " & _
                    "IRDP.IdProgramaPorIndicadorDeMeta, " & _
                    "IRDP.IdIndicadoresRelevantesDePrograma, " & _
                    "IPP.IdIndicadoresPorPrograma, " & _
                    "IPP.DescripcionIndicador, " & _
                    "IPP.NombreProyecto, " & _
                    "IRDP.Peso as PesoIndicadorPrograma, " & _
                    "SUM(MMPP.EjecutadoQ1) as EjecutadoQ1, " & _
                    "SUM(MMPP.EjecutadoQ2) as EjecutadoQ2, " & _
                    "SUM(MMPP.EjecutadoQ3) as EjecutadoQ3, " & _
                    "SUM(MMPP.EjecutadoQ4) as EjecutadoQ4, " & _
                    "SUM(MMPP.ProyectadoQ1) as ProyectadoQ1, " & _
                    "SUM(MMPP.ProyectadoQ2) as ProyectadoQ2, " & _
                    "SUM(MMPP.ProyectadoQ3) as ProyectadoQ3, " & _
                    "SUM(MMPP.ProyectadoQ4) as ProyectadoQ4, " & _
                    "(SUM(MMPP.EjecutadoQ1 + MMPP.EjecutadoQ2 + MMPP.EjecutadoQ3 + MMPP.EjecutadoQ4)) / (SUM(MMPP.ProyectadoQ1 + MMPP.ProyectadoQ2 + MMPP.ProyectadoQ3 + MMPP.ProyectadoQ4)) as PorcentajeEjecucion, " & _
                    "SUM(MMPP.EjecutadoQ1) / SUM(MMPP.ProyectadoQ1) as PorcentajeEjecucionQ1, " & _
                    "SUM(MMPP.EjecutadoQ2) / SUM(MMPP.ProyectadoQ2) as PorcentajeEjecucionQ2, " & _
                    "SUM(MMPP.EjecutadoQ3) / SUM(MMPP.ProyectadoQ3) as PorcentajeEjecucionQ3, " & _
                    "SUM(MMPP.EjecutadoQ4) / SUM(MMPP.ProyectadoQ4) as PorcentajeEjecucionQ4 " & _
            "FROM " & _
            "IndicadoresRelevantesDePrograma IRDP " & _
            "Join " & _
            "(select " & _
            "IdIndicadoresPorPrograma, " & _
            "DescripcionIndicador, " & _
            "NombreProyecto, " & _
            "IdPrograma " & _
            "from " & _
            "IndicadoresPorPrograma " & _
                            "join Indicadores ON Indicadores.IdIndicador = IndicadoresPorPrograma.IdIndicador " & _
                            "join vProyectos  ON vProyectos.codigo_ficha = IndicadoresPorPrograma.IdPrograma " & _
            "where " & _
            "IndicadoresPorPrograma.Activo = 1 " & _
                            "and Indicadores.Activo = 1) as IPP " & _
                        "ON IPP.IdIndicadoresPorPrograma=IRDP.IdIndicadoresPorPrograma " & _
                    "JOIN MetaYMonitoreoPorPeriodo MMPP ON MMPP.IdIndicadorPorPrograma=IPP.IdIndicadoresPorPrograma " & _
                    "JOIN AreasDeInfluencia ADI ON ADI.IdAreaDeInfluencia=MMPP.IdAreaDeInfluencia " & _
            "WHERE " & _
            "IRDP.Activo = 1 " & _
                    "AND MMPP.Activo = 1" & _
                    "AND Peso <> 0 " & _
                    "AND Ano = @Ano " & _
                    "AND MMPP.ProyectadoQ1<>0 AND MMPP.ProyectadoQ2<>0 AND MMPP.ProyectadoQ3<>0 AND MMPP.ProyectadoQ4<>0 " & _
            "Group BY " & _
                    "IRDP.IdProgramaPorIndicadorDeMeta, " & _
                    "IRDP.IdIndicadoresRelevantesDePrograma, " & _
                    "IPP.IdIndicadoresPorPrograma, " & _
                    "IPP.DescripcionIndicador, " & _
                    "IPP.NombreProyecto, " & _
                    "IRDP.Peso) as EPI " & _
            "ON EPI.IdProgramaPorIndicadorDeMeta = PPIM.IdProgramasPorIndicadorDeMeta " & _
            "WHERE " & _
            "Activo = 1 " & _
            "Group BY " & _
                "IdIndicadorDeMeta, " & _
                "IdProgramasPorIndicadorDeMeta, " & _
                "Peso) as EPP " & _
        "ON EPP.IdIndicadorDeMeta = IDM.IdIndicadorDeMeta " & _
            "WHERE " & _
            "IDM.Activo = 1 " & _
        "AND I.Activo = 1 " & _
        "AND IdMetasDeComponente = @IdMetasDeComponente " & _
        "AND I.IdIndicador = @IdIndicador " & _
            "Group BY " & _
        "IdMetasDeComponente, " & _
        "IDM.IdIndicadorDeMeta, " & _
        "Peso, " & _
        "I.DescripcionIndicador, " & _
            "I.IdIndicador "

            SqlDataSourceIndicadoresMetasGraficar.SelectParameters(0).DefaultValue = cmbMetas.Value
            SqlDataSourceIndicadoresMetasGraficar.SelectParameters(1).DefaultValue = ASPxComboBoxAno.Value
            SqlDataSourceIndicadoresMetasGraficar.SelectParameters(2).DefaultValue = lbChoosen.Items(i).Value
            ASPxGridViewIndicadoresGraficar.DataBind()

            Dim chartSeries As New Series("Side-by-Side Bar Series 1", ViewType.Bar)
            chart.DataSourceID = "SqlDataSourceIndicadoresMetasGraficar"

            chartSeries.Points.Add(New SeriesPoint("T1", New Double() {ASPxGridViewIndicadoresGraficar.GetRowValues(0, "PorcentajeEjecucionQ1")}))
            chartSeries.Points.Add(New SeriesPoint("T2", New Double() {ASPxGridViewIndicadoresGraficar.GetRowValues(0, "PorcentajeEjecucionQ2")}))
            chartSeries.Points.Add(New SeriesPoint("T3", New Double() {ASPxGridViewIndicadoresGraficar.GetRowValues(0, "PorcentajeEjecucionQ3")}))
            chartSeries.Points.Add(New SeriesPoint("T4", New Double() {ASPxGridViewIndicadoresGraficar.GetRowValues(0, "PorcentajeEjecucionQ4")}))
            chartSeries.LegendText = ASPxGridViewIndicadoresGraficar.GetRowValues(0, "DescripcionIndicador")
            chart.Series.Add(chartSeries)

        Next


    End Sub

    Protected Sub Page_Load(sender As Object, e As EventArgs) Handles Me.Load
        'Verifica si el usuario tiene el acceso a la pagina solicitada
        Using dtMOCA As System.Data.DataTable = fMOCA.CheckPageAccess(4.03) 'este es el Id definido en el MOCA
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
End Class
