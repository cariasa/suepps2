Imports System.Windows.Forms
Imports DevExpress.XtraCharts
Imports DevExpress.Web.ASPxEditors

Partial Class Reportes_ReporteProgramas
    Inherits System.Web.UI.Page


    Protected Sub Page_Init(sender As Object, e As EventArgs) Handles Me.Init

    End Sub

    'Protected Sub ASPxListBoxProgramas_SelectedIndexChanged(sender As Object, e As EventArgs)
    '    SqlDataSourceAnoPrograma.SelectParameters(0).DefaultValue = ASPxListBoxProgramas.SelectedValues(ASPxListBoxProgramas.SelectedIndex)
    '    MessageBox.Show(ASPxListBoxProgramas.SelectedValues(ASPxListBoxProgramas.SelectedIndex))
    '    ASPxComboBoxAno.DataBind()
    'End Sub


    'Protected Sub ASPxButtonAgregar_Click(sender As Object, e As EventArgs)
    '    SqlDataSourceAnoPrograma.SelectParameters(0).DefaultValue = ASPxListBoxProgramas.SelectedItem.Value

    '    ASPxComboBoxAno.DataBind()
    'End Sub

    Protected Sub ASPxButtonGraficar_Click(sender As Object, e As EventArgs)
        If cobertura.Checked Then
            SqlDataSourceProgramasGraficar.SelectCommand = "SELECT " & _
                "	IPP.DescripcionIndicador as Indicador,  " & _
                "	MMPP.EjecutadoQ1 as E1,  " & _
                "	MMPP.EjecutadoQ2 as E2,  " & _
                "	MMPP.EjecutadoQ3 as E3,  " & _
                "	MMPP.EjecutadoQ4 as E4,  " & _
                "	MMPP.ProyectadoQ1 as P1,  " & _
                "	MMPP.ProyectadoQ2 as P2,  " & _
                "	MMPP.ProyectadoQ3 as P3,  " & _
                "	MMPP.ProyectadoQ4 as P4,  " & _
                "	CONVERT(DECIMAL(6,2), (MMPP.EjecutadoQ1 + MMPP.EjecutadoQ2 + MMPP.EjecutadoQ3 + MMPP.EjecutadoQ4) / (MMPP.ProyectadoQ1 + MMPP.ProyectadoQ2 + MMPP.ProyectadoQ3 + MMPP.ProyectadoQ4)*100) as TotalEjecucion,  " & _
                "	CONVERT(DECIMAL(6,2), MMPP.EjecutadoQ1 / MMPP.ProyectadoQ1*100) as PE1,  " & _
                "	CONVERT(DECIMAL(6,2), MMPP.EjecutadoQ2 / MMPP.ProyectadoQ2*100) as PE2,  " & _
                "	CONVERT(DECIMAL(6,2), MMPP.EjecutadoQ3 / MMPP.ProyectadoQ3*100) as PE3,  " & _
                "	CONVERT(DECIMAL(6,2), MMPP.EjecutadoQ4 / MMPP.ProyectadoQ4*100) as PE4,  " & _
                "	ADI.DescripcionAreaDeInfluencia as AreaDeInfluencia " & _
                "FROM  " & _
                "		(select  " & _
                "			IdIndicadoresPorPrograma,  " & _
                "			DescripcionIndicador,  " & _
                "			NombreProyecto,  " & _
                "			IdPrograma  " & _
                "		from  " & _
                "			IndicadoresPorPrograma  " & _
                "			join Indicadores ON Indicadores.IdIndicador = IndicadoresPorPrograma.IdIndicador  " & _
                "			join vProyectos  ON vProyectos.codigo_ficha = IndicadoresPorPrograma.IdPrograma WHERE Indicadores.Activo=1) as IPP  " & _
                "	JOIN MetaYMonitoreoPorPeriodo MMPP ON MMPP.IdIndicadorPorPrograma=IPP.IdIndicadoresPorPrograma  " & _
                "	JOIN AreasDeInfluencia ADI ON ADI.IdAreaDeInfluencia=MMPP.IdAreaDeInfluencia  " & _
                "WHERE  " & _
                "	Ano = @Ano  " & _
                "	AND IPP.IdPrograma= @IdPrograma " & _
                "	AND MMPP.ProyectadoQ1<>0 AND MMPP.ProyectadoQ2<>0 AND MMPP.ProyectadoQ3<>0 AND MMPP.ProyectadoQ4<>0  AND MMPP.Activo=1"
        Else
            SqlDataSourceProgramasGraficar.SelectCommand = "SELECT " & _
            "	IPP.DescripcionIndicador as Indicador,  " & _
            "	MMPP.EjecutadoQ1 as E1,  " & _
            "	MMPP.EjecutadoQ2 as E2,  " & _
            "	MMPP.EjecutadoQ3 as E3,  " & _
            "	MMPP.EjecutadoQ4 as E4,  " & _
            "	MMPP.ProyectadoQ1 as P1,  " & _
            "	MMPP.ProyectadoQ2 as P2,  " & _
            "	MMPP.ProyectadoQ3 as P3,  " & _
            "	MMPP.ProyectadoQ4 as P4,  " & _
            "	CONVERT(DECIMAL(6,2), (MMPP.EjecutadoQ1 + MMPP.EjecutadoQ2 + MMPP.EjecutadoQ3 + MMPP.EjecutadoQ4) / (MMPP.ProyectadoQ1 + MMPP.ProyectadoQ2 + MMPP.ProyectadoQ3 + MMPP.ProyectadoQ4)*100) as TotalEjecucion,  " & _
            "	CONVERT(DECIMAL(6,2), MMPP.EjecutadoQ1 / MMPP.ProyectadoQ1*100) as PE1,  " & _
            "	CONVERT(DECIMAL(6,2), MMPP.EjecutadoQ2 / MMPP.ProyectadoQ2*100) as PE2,  " & _
            "	CONVERT(DECIMAL(6,2), MMPP.EjecutadoQ3 / MMPP.ProyectadoQ3*100) as PE3,  " & _
            "	CONVERT(DECIMAL(6,2), MMPP.EjecutadoQ4 / MMPP.ProyectadoQ4*100) as PE4,  " & _
            "	ADI.DescripcionAreaDeInfluencia as AreaDeInfluencia " & _
            "FROM  " & _
            "		(select  " & _
            "			IdIndicadoresPorPrograma,  " & _
            "			DescripcionIndicador,  " & _
            "			NombreProyecto,  " & _
            "			IdPrograma  " & _
            "		from  " & _
            "			IndicadoresPorPrograma  " & _
            "			join Indicadores ON Indicadores.IdIndicador = IndicadoresPorPrograma.IdIndicador  " & _
            "           join TiposDeIndicador ON Indicadores.IdTipoDeIndicador = TiposDeIndicador.IdTipoDeIndicador " & _
            "			join vProyectos  ON vProyectos.codigo_ficha = IndicadoresPorPrograma.IdPrograma WHERE TiposDeIndicador.NivelTipoDeIndicador = 1 AND Indicadores.Activo=1) as IPP  " & _
            "	JOIN MetaYMonitoreoPorPeriodo MMPP ON MMPP.IdIndicadorPorPrograma=IPP.IdIndicadoresPorPrograma  " & _
            "	JOIN AreasDeInfluencia ADI ON ADI.IdAreaDeInfluencia=MMPP.IdAreaDeInfluencia  " & _
            "WHERE  " & _
            "	Ano = @Ano  " & _
            "	AND IPP.IdPrograma= @IdPrograma " & _
            "	AND MMPP.ProyectadoQ1<>0 AND MMPP.ProyectadoQ2<>0 AND MMPP.ProyectadoQ3<>0 AND MMPP.ProyectadoQ4<>0 "
        End If
        SqlDataSourceProgramasGraficar.SelectParameters(0).DefaultValue = ASPxComboBoxAno.Value
        SqlDataSourceProgramasGraficar.SelectParameters(1).DefaultValue = ASPxGridViewProgramas.GetRowValues(ASPxGridViewProgramas.FocusedRowIndex, "codigo_ficha")
        ASPxGridView1.DataBind()

        Me.chart.DataSourceID = "SqlDataSourceProgramasGraficar"
        chart.SeriesDataMember = "AreaDeInfluencia"
        For i As Integer = 0 To ASPxGridView1.VisibleRowCount - 1



            chart.SeriesTemplate.ArgumentDataMember = "Indicador"
            chart.SeriesTemplate.ValueDataMembers.AddRange(New String() {"PE1", "PE2", "PE3", "PE4"})


            ' Specify the template's series view.
            '
            'chart.SeriesTemplate.View = New StackedBarSeriesView()
            chart.SeriesTemplate.View = New SideBySideBarSeriesView()

            ' Specify the template's name prefix.

        Next

        chart.SeriesNameTemplate.BeginText = "Area de Influencia: "







    End Sub

    Protected Sub VerAno_Click(sender As Object, e As EventArgs)
        SqlDataSourceAnoPrograma.SelectParameters(0).DefaultValue = ASPxGridViewProgramas.GetRowValues(ASPxGridViewProgramas.FocusedRowIndex, "codigo_ficha")

        ASPxComboBoxAno.DataBind()
    End Sub

    Protected Sub VerAno_Init(sender As Object, e As EventArgs)
        Dim btn As ASPxButton = CType(sender, ASPxButton)

        btn.CssFilePath = String.Empty
        btn.CssPostfix = String.Empty
        btn.SpriteCssFilePath = String.Empty
    End Sub

    Protected Sub ASPxGridView1_Load(sender As Object, e As EventArgs)
        If cobertura.CheckState = CheckState.Checked Then
            SqlDataSourceProgramasGraficar.SelectCommand = "SELECT " & _
                "	IPP.DescripcionIndicador as Indicador,  " & _
                "	MMPP.EjecutadoQ1 as E1,  " & _
                "	MMPP.EjecutadoQ2 as E2,  " & _
                "	MMPP.EjecutadoQ3 as E3,  " & _
                "	MMPP.EjecutadoQ4 as E4,  " & _
                "	MMPP.ProyectadoQ1 as P1,  " & _
                "	MMPP.ProyectadoQ2 as P2,  " & _
                "	MMPP.ProyectadoQ3 as P3,  " & _
                "	MMPP.ProyectadoQ4 as P4,  " & _
                "	CONVERT(DECIMAL(6,2), (MMPP.EjecutadoQ1 + MMPP.EjecutadoQ2 + MMPP.EjecutadoQ3 + MMPP.EjecutadoQ4) / (MMPP.ProyectadoQ1 + MMPP.ProyectadoQ2 + MMPP.ProyectadoQ3 + MMPP.ProyectadoQ4)*100) as TotalEjecucion,  " & _
                "	CONVERT(DECIMAL(6,2), MMPP.EjecutadoQ1 / MMPP.ProyectadoQ1*100) as PE1,  " & _
                "	CONVERT(DECIMAL(6,2), MMPP.EjecutadoQ2 / MMPP.ProyectadoQ2*100) as PE2,  " & _
                "	CONVERT(DECIMAL(6,2), MMPP.EjecutadoQ3 / MMPP.ProyectadoQ3*100) as PE3,  " & _
                "	CONVERT(DECIMAL(6,2), MMPP.EjecutadoQ4 / MMPP.ProyectadoQ4*100) as PE4,  " & _
                "	ADI.DescripcionAreaDeInfluencia as AreaDeInfluencia " & _
                "FROM  " & _
                "		(select  " & _
                "			IdIndicadoresPorPrograma,  " & _
                "			DescripcionIndicador,  " & _
                "			NombreProyecto,  " & _
                "			IdPrograma  " & _
                "		from  " & _
                "			IndicadoresPorPrograma  " & _
                "			join Indicadores ON Indicadores.IdIndicador = IndicadoresPorPrograma.IdIndicador  " & _
                "			join vProyectos  ON vProyectos.codigo_ficha = IndicadoresPorPrograma.IdPrograma) as IPP  " & _
                "	JOIN MetaYMonitoreoPorPeriodo MMPP ON MMPP.IdIndicadorPorPrograma=IPP.IdIndicadoresPorPrograma  " & _
                "	JOIN AreasDeInfluencia ADI ON ADI.IdAreaDeInfluencia=MMPP.IdAreaDeInfluencia  " & _
                "WHERE  " & _
                "	Ano = @Ano  " & _
                "	AND IPP.IdPrograma= @IdPrograma " & _
                "	AND MMPP.ProyectadoQ1<>0 AND MMPP.ProyectadoQ2<>0 AND MMPP.ProyectadoQ3<>0 AND MMPP.ProyectadoQ4<>0 "
        Else
            SqlDataSourceProgramasGraficar.SelectCommand = "SELECT " & _
            "	IPP.DescripcionIndicador as Indicador,  " & _
            "	MMPP.EjecutadoQ1 as E1,  " & _
            "	MMPP.EjecutadoQ2 as E2,  " & _
            "	MMPP.EjecutadoQ3 as E3,  " & _
            "	MMPP.EjecutadoQ4 as E4,  " & _
            "	MMPP.ProyectadoQ1 as P1,  " & _
            "	MMPP.ProyectadoQ2 as P2,  " & _
            "	MMPP.ProyectadoQ3 as P3,  " & _
            "	MMPP.ProyectadoQ4 as P4,  " & _
            "	CONVERT(DECIMAL(6,2), (MMPP.EjecutadoQ1 + MMPP.EjecutadoQ2 + MMPP.EjecutadoQ3 + MMPP.EjecutadoQ4) / (MMPP.ProyectadoQ1 + MMPP.ProyectadoQ2 + MMPP.ProyectadoQ3 + MMPP.ProyectadoQ4)*100) as TotalEjecucion,  " & _
            "	CONVERT(DECIMAL(6,2), MMPP.EjecutadoQ1 / MMPP.ProyectadoQ1*100) as PE1,  " & _
            "	CONVERT(DECIMAL(6,2), MMPP.EjecutadoQ2 / MMPP.ProyectadoQ2*100) as PE2,  " & _
            "	CONVERT(DECIMAL(6,2), MMPP.EjecutadoQ3 / MMPP.ProyectadoQ3*100) as PE3,  " & _
            "	CONVERT(DECIMAL(6,2), MMPP.EjecutadoQ4 / MMPP.ProyectadoQ4*100) as PE4,  " & _
            "	ADI.DescripcionAreaDeInfluencia as AreaDeInfluencia " & _
            "FROM  " & _
            "		(select  " & _
            "			IdIndicadoresPorPrograma,  " & _
            "			DescripcionIndicador,  " & _
            "			NombreProyecto,  " & _
            "			IdPrograma  " & _
            "		from  " & _
            "			IndicadoresPorPrograma  " & _
            "			join Indicadores ON Indicadores.IdIndicador = IndicadoresPorPrograma.IdIndicador  " & _
            "			join vProyectos  ON vProyectos.codigo_ficha = IndicadoresPorPrograma.IdPrograma WHERE Indicadores.IdTipoDeIndicador <> 3) as IPP  " & _
            "	JOIN MetaYMonitoreoPorPeriodo MMPP ON MMPP.IdIndicadorPorPrograma=IPP.IdIndicadoresPorPrograma  " & _
            "	JOIN AreasDeInfluencia ADI ON ADI.IdAreaDeInfluencia=MMPP.IdAreaDeInfluencia  " & _
            "WHERE  " & _
            "	Ano = @Ano  " & _
            "	AND IPP.IdPrograma= @IdPrograma " & _
            "	AND MMPP.ProyectadoQ1<>0 AND MMPP.ProyectadoQ2<>0 AND MMPP.ProyectadoQ3<>0 AND MMPP.ProyectadoQ4<>0 "
        End If
        SqlDataSourceProgramasGraficar.SelectParameters(0).DefaultValue = ASPxComboBoxAno.Value
        SqlDataSourceProgramasGraficar.SelectParameters(1).DefaultValue = ASPxGridViewProgramas.GetRowValues(ASPxGridViewProgramas.FocusedRowIndex, "codigo_ficha")
        ASPxGridView1.DataBind()
    End Sub

    Protected Sub Page_Load(sender As Object, e As EventArgs) Handles Me.Load
        'Verifica si el usuario tiene el acceso a la pagina solicitada
        Using dtMOCA As System.Data.DataTable = fMOCA.CheckPageAccess(4.01) 'este es el Id definido en el MOCA
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
