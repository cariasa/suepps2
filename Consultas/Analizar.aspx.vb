Imports DevExpress.Web.ASPxGridView
Imports DevExpress.Web.ASPxTabControl
Imports DevExpress.Web.ASPxCallback
Imports DevExpress.XtraPrinting
Imports System.Web.UI.DataVisualization.Charting.Grid
Imports System
Imports System.Windows.Forms
Imports DevExpress.Web.ASPxGridView.Export
Imports System.Data.SqlClient
Imports DevExpress.Web.ASPxEditors
Imports DevExpress.Web.ASPxClasses

Partial Class Consultas_Analizar
    Inherits System.Web.UI.Page

    Dim idPrograma As Integer

    Protected Sub Page_Init(sender As Object, e As EventArgs) Handles Me.Init

        SqlCobertura.SelectCommand = "SELECT cic.CategoriaIndicadorCobertura, c.DescripcionIndicador,c.UnidadIndicador, SUM (a.Potenciales) as Potenciales, SUM(a.ProyectadoQ1+a.ProyectadoQ2+a.ProyectadoQ3+a.ProyectadoQ4) As Monto2, SUM (a.[EjecutadoQ1]+a.[EjecutadoQ2]+a.[EjecutadoQ3]+a.[EjecutadoQ4]) As Monto3 " & _
            "FROM [MetaYMonitoreoPorPeriodo] a " & _
            "join [IndicadoresPorPrograma] b on b.IdIndicadoresPorPrograma= a.IdIndicadorPorPrograma " & _
            "join [Indicadores] c on b.IdIndicador= c.IdIndicador " & _
            "join [CategoriaIndicadorCobertura] cic on c.IdCategoriaIndicadorCobertura = cic.IdCategoriaIndicadorCobertura " & _
            "where b.IdPrograma = @Programa And a.Ano = @Year And c.IdTipoDeIndicador = 2 And a.Activo = 1 " & _
            "GROUP BY cic.IdCategoriaIndicadorCobertura, cic.CategoriaIndicadorCobertura, c.IdIndicador, c.DescripcionIndicador,c.UnidadIndicador " & _
            "ORDER BY cic.IdCategoriaIndicadorCobertura ASC, c.IdIndicador ASC "

        'SqlMetaMonitoreo.SelectCommand = "SELECT c.DescripcionIndicador, " & _
        '    "SUM(a.[ProyectadoQ1]) as ProyectadoQ1, SUM(a.[ProyectadoQ2]) as ProyectadoQ2, SUM(a.[ProyectadoQ3]) as ProyectadoQ3,  SUM(a.[ProyectadoQ4]) as ProyectadoQ4, " & _
        '    "SUM(a.[EjecutadoQ1]) as EjecutadoQ1, SUM(a.[EjecutadoQ2]) as EjecutadoQ2, SUM(a.[EjecutadoQ3]) as EjecutadoQ3, SUM(a.[EjecutadoQ4]) as EjecutadoQ4, " & _
        '    "(COALESCE(SUM(a.EjecutadoQ1)/ NULLIF(SUM(a.ProyectadoQ1),0),0)) As P1, " & _
        '    "(COALESCE(SUM(a.EjecutadoQ2)/ NULLIF(SUM(a.ProyectadoQ2),0),0)) As P2, " & _
        '    "(COALESCE(SUM(a.EjecutadoQ3)/ NULLIF(SUM(a.ProyectadoQ3),0),0)) As P3, " & _
        '    "(COALESCE(SUM(a.EjecutadoQ4)/ NULLIF(SUM(a.ProyectadoQ4),0),0)) As P4, " & _
        '    "(SUM(a.ProyectadoQ1+a.ProyectadoQ2+a.ProyectadoQ3+a.ProyectadoQ4)) As PA, " & _
        '    "(SUM(a.[EjecutadoQ1]+a.[EjecutadoQ2]+a.[EjecutadoQ3]+a.[EjecutadoQ4])) As EA," & _
        '    "(COALESCE((SUM(a.[EjecutadoQ1]+a.[EjecutadoQ2]+a.[EjecutadoQ3]+a.[EjecutadoQ4]))/ NULLIF((SUM(a.ProyectadoQ1+a.ProyectadoQ2+a.ProyectadoQ3+a.ProyectadoQ4)),0),0)) As PAA " & _
        '    "FROM [MetaYMonitoreoPorPeriodo] a " & _
        '    "join [IndicadoresPorPrograma] b on b.IdIndicadoresPorPrograma= a.IdIndicadorPorPrograma " & _
        '    "join [Indicadores] c on b.IdIndicador= c.IdIndicador " & _
        '    "join [TiposDeIndicador] d on c.IdTipoDeIndicador=d.IdTipoDeIndicador " & _
        '    "where b.IdPrograma = @Programa And a.Ano = @Year And c.IdTipoDeIndicador = 1 And a.Activo=1 And b.Activo=1 and c.Activo=1 and a.IdAreaDeInfluencia=@Area  " & _
        '    "GROUP BY c.IdIndicador, c.DescripcionIndicador"

        'SqlMetaIndicadores.SelectCommand = "SELECT c.DescripcionIndicador, " & _
        '    "SUM(a.[ProyectadoQ1]) as ProyectadoQ1, SUM(a.[ProyectadoQ2]) as ProyectadoQ2, SUM(a.[ProyectadoQ3]) as ProyectadoQ3,  SUM(a.[ProyectadoQ4]) as ProyectadoQ4, " & _
        '    "SUM(a.[EjecutadoQ1]) as EjecutadoQ1, SUM(a.[EjecutadoQ2]) as EjecutadoQ2, SUM(a.[EjecutadoQ3]) as EjecutadoQ3, SUM(a.[EjecutadoQ4]) as EjecutadoQ4, " & _
        '    "(COALESCE(SUM(a.EjecutadoQ1)/ NULLIF(SUM(a.ProyectadoQ1),0),0)) As P1, " & _
        '    "(COALESCE(SUM(a.EjecutadoQ2)/ NULLIF(SUM(a.ProyectadoQ2),0),0)) As P2, " & _
        '    "(COALESCE(SUM(a.EjecutadoQ3)/ NULLIF(SUM(a.ProyectadoQ3),0),0)) As P3, " & _
        '    "(COALESCE(SUM(a.EjecutadoQ4)/ NULLIF(SUM(a.ProyectadoQ4),0),0)) As P4, " & _
        '    "(SUM(a.ProyectadoQ1+a.ProyectadoQ2+a.ProyectadoQ3+a.ProyectadoQ4)) As PA, " & _
        '    "(SUM(a.[EjecutadoQ1]+a.[EjecutadoQ2]+a.[EjecutadoQ3]+a.[EjecutadoQ4])) As EA," & _
        '    "(COALESCE((SUM(a.[EjecutadoQ1]+a.[EjecutadoQ2]+a.[EjecutadoQ3]+a.[EjecutadoQ4]))/ NULLIF((SUM(a.ProyectadoQ1+a.ProyectadoQ2+a.ProyectadoQ3+a.ProyectadoQ4)),0),0)) As PAA " & _
        '    "FROM [MetaYMonitoreoPorPeriodo] a " & _
        '    "join [IndicadoresPorPrograma] b on b.IdIndicadoresPorPrograma= a.IdIndicadorPorPrograma " & _
        '    "join [Indicadores] c on b.IdIndicador= c.IdIndicador " & _
        '    "join [TiposDeIndicador] d on c.IdTipoDeIndicador=d.IdTipoDeIndicador " & _
        '    "where b.IdPrograma = @Programa And a.Ano = @Year And c.IdTipoDeIndicador = 1 And a.Activo=1 And b.Activo=1 and c.Activo=1" & _
        '    "GROUP BY c.IdIndicador,c.DescripcionIndicador"

        SqlDataSource1.SelectCommand = " SELECT distinct e.DescripcionAreaDeInfluencia, a.ProyectadoQ1,a.ProyectadoQ2,a.ProyectadoQ3,a.ProyectadoQ4,a.EjecutadoQ1,EjecutadoQ2,EjecutadoQ3,EjecutadoQ4 " & _
            "FROM [MetaYMonitoreoPorPeriodo] a " & _
            "join [IndicadoresPorPrograma] b on b.IdIndicadoresPorPrograma= a.IdIndicadorPorPrograma " & _
            "join [Indicadores] c on b.IdIndicador= c.IdIndicador " & _
            "join [TiposDeIndicador] d on c.IdTipoDeIndicador=d.IdTipoDeIndicador " & _
            "join [AreasDeInfluencia] e on a.IdAreaDeInfluencia= e.IdAreaDeInfluencia " & _
            "where b.IdPrograma = @Programa And a.Ano = @Ano And c.IdTipoDeIndicador = 1 And a.Activo=1 and c.DescripcionIndicador=@Descripcion and e.Activo=1 " & _
            "GROUP BY a.IdMetaPorPeriodo,c.IdIndicador,e.DescripcionAreaDeInfluencia,a.ProyectadoQ1,a.ProyectadoQ2,a.ProyectadoQ3,a.ProyectadoQ4,a.EjecutadoQ1,a.EjecutadoQ2,a.EjecutadoQ3,a.EjecutadoQ4,c.IdIndicador,c.DescripcionIndicador " & _
            "ORDER BY e.DescripcionAreaDeInfluencia"

        SqlDataSource3.SelectCommand = " SELECT distinct e.DescripcionAreaDeInfluencia,e.IdAreaDeInfluencia " & _
            "FROM [MetaYMonitoreoPorPeriodo] a " & _
            "join [IndicadoresPorPrograma] b on b.IdIndicadoresPorPrograma= a.IdIndicadorPorPrograma " & _
            "join [Indicadores] c on b.IdIndicador= c.IdIndicador " & _
            "join [TiposDeIndicador] d on c.IdTipoDeIndicador=d.IdTipoDeIndicador " & _
            "join [AreasDeInfluencia] e on a.IdAreaDeInfluencia= e.IdAreaDeInfluencia " & _
            "where b.IdPrograma = @Programa And a.Ano = @Ano And c.IdTipoDeIndicador <> 1 And a.Activo=1 and c.DescripcionIndicador=@Descripcion and e.Activo=1 " & _
            "ORDER BY e.DescripcionAreaDeInfluencia"




        Session("CodPrograma") = uf.QueryStringDecode(Request.QueryString.Get(1))

        SqlRespuestas.SelectParameters(2).DefaultValue = Session("CodPrograma")

        Me.Programa.Text = uf.QueryStringDecode(Request.QueryString.Get(0))
        Me.CodPrograma.Text = Session("CodPrograma")

        SqlAno.SelectParameters(0).DefaultValue = Session("CodPrograma")
        SqlArea.SelectParameters(0).DefaultValue = Session("CodPrograma")
        SqlAnoP.SelectParameters(0).DefaultValue = Session("CodPrograma")

        If Session("IdPreguntaDeMonitoreo") Is Nothing Then

        Else


            SqlRespuestas.SelectParameters(0).DefaultValue = Session("IdPreguntaDeMonitoreo")
            SqlRespuestas.SelectParameters(1).DefaultValue = cmbAnoCualitativo.Text
            SqlRespuestas.DataBind()




        End If


    End Sub


    Protected Sub GridIndicadores_CustomCallback(sender As Object, e As ASPxGridViewCustomCallbackEventArgs)

        If cmbAno.Text <> "" And cmbArea.Text.Equals("") Then

        Else

            If cmbAno.Text <> "" And cmbArea.Text <> "" Then

                If (cmbTrimestre.Text = "Trimestre 1") Then
                    SqlMetaMonitoreo.SelectCommand = "SELECT " & _
                            "c.DescripcionIndicador, " & _
                            "SUM(a.[ProyectadoQ1]) as ProyectadoQ1, " & _
                            "SUM(a.[ProyectadoQ2]) as ProyectadoQ2, " & _
                            "SUM(a.[ProyectadoQ3]) as ProyectadoQ3, " & _
                            "SUM(a.[ProyectadoQ4]) as ProyectadoQ4, " & _
                            "SUM(a.[EjecutadoQ1]) as EjecutadoQ1, " & _
                            "SUM(a.[EjecutadoQ2]) as EjecutadoQ2, " & _
                            "SUM(a.[EjecutadoQ3]) as EjecutadoQ3, " & _
                            "SUM(a.[EjecutadoQ4]) as EjecutadoQ4, " & _
                            "(COALESCE(SUM(a.EjecutadoQ1)/ NULLIF(SUM(a.ProyectadoQ1),0),0)) As P1, " & _
                            "(COALESCE(SUM(a.EjecutadoQ2)/ NULLIF(SUM(a.ProyectadoQ2),0),0)) As P2, " & _
                            "(COALESCE(SUM(a.EjecutadoQ3)/ NULLIF(SUM(a.ProyectadoQ3),0),0)) As P3, " & _
                            "(COALESCE(SUM(a.EjecutadoQ4)/ NULLIF(SUM(a.ProyectadoQ4),0),0)) As P4, " & _
                            "(SUM(a.ProyectadoQ1)) As PA, " & _
                            "(SUM(a.[EjecutadoQ1])) As EA, " & _
                            "(COALESCE((SUM(a.[EjecutadoQ1]))/ NULLIF((SUM(a.ProyectadoQ1)),0),0)) As PAA " & _
                            "FROM " & _
                            "[MetaYMonitoreoPorPeriodo] a " & _
                            "join [IndicadoresPorPrograma] b on b.IdIndicadoresPorPrograma= a.IdIndicadorPorPrograma " & _
                            "join [Indicadores] c on b.IdIndicador= c.IdIndicador " & _
                            "join [TiposDeIndicador] d on c.IdTipoDeIndicador=d.IdTipoDeIndicador " & _
                            "where " & _
                            "b.IdPrograma = 133 And a.Ano = 2013 And c.IdTipoDeIndicador = 1 And a.Activo = 1 And b.Activo = 1 And c.Activo = 1 and a.IdAreaDeInfluencia=@Area and (a.ProyectadoQ1 <> 0 Or a.ProyectadoQ2 <> 0 OR a.ProyectadoQ3 <> 0 OR a.ProyectadoQ4 <> 0) " & _
                            "GROUP BY c.IdIndicador,c.DescripcionIndicador"

                ElseIf (cmbTrimestre.Text = "Trimestre 2") Then
                    SqlMetaMonitoreo.SelectCommand = "SELECT " & _
                            "c.DescripcionIndicador, " & _
                            "SUM(a.[ProyectadoQ1]) as ProyectadoQ1, " & _
                            "SUM(a.[ProyectadoQ2]) as ProyectadoQ2, " & _
                            "SUM(a.[ProyectadoQ3]) as ProyectadoQ3, " & _
                            "SUM(a.[ProyectadoQ4]) as ProyectadoQ4, " & _
                            "SUM(a.[EjecutadoQ1]) as EjecutadoQ1, " & _
                            "SUM(a.[EjecutadoQ2]) as EjecutadoQ2, " & _
                            "SUM(a.[EjecutadoQ3]) as EjecutadoQ3, " & _
                            "SUM(a.[EjecutadoQ4]) as EjecutadoQ4, " & _
                            "(COALESCE(SUM(a.EjecutadoQ1)/ NULLIF(SUM(a.ProyectadoQ1),0),0)) As P1, " & _
                            "(COALESCE(SUM(a.EjecutadoQ2)/ NULLIF(SUM(a.ProyectadoQ2),0),0)) As P2, " & _
                            "(COALESCE(SUM(a.EjecutadoQ3)/ NULLIF(SUM(a.ProyectadoQ3),0),0)) As P3, " & _
                            "(COALESCE(SUM(a.EjecutadoQ4)/ NULLIF(SUM(a.ProyectadoQ4),0),0)) As P4, " & _
                            "(SUM(a.ProyectadoQ1+a.ProyectadoQ2)) As PA, " & _
                            "(SUM(a.[EjecutadoQ1]+a.[EjecutadoQ2])) As EA, " & _
                            "(COALESCE((SUM(a.[EjecutadoQ1]+a.[EjecutadoQ2]))/ NULLIF((SUM(a.ProyectadoQ1+a.ProyectadoQ2)),0),0)) As PAA " & _
                            "FROM " & _
                            "[MetaYMonitoreoPorPeriodo] a " & _
                            "join [IndicadoresPorPrograma] b on b.IdIndicadoresPorPrograma= a.IdIndicadorPorPrograma  " & _
                            "join [Indicadores] c on b.IdIndicador= c.IdIndicador " & _
                            "join [TiposDeIndicador] d on c.IdTipoDeIndicador=d.IdTipoDeIndicador " & _
                            "where " & _
                            "b.IdPrograma = 133 And a.Ano = 2013 And c.IdTipoDeIndicador = 1 And a.Activo = 1 And b.Activo = 1 And c.Activo = 1 and a.IdAreaDeInfluencia=@Area and (a.ProyectadoQ1 <> 0 Or a.ProyectadoQ2 <> 0 OR a.ProyectadoQ3 <> 0 OR a.ProyectadoQ4 <> 0) " & _
                            "GROUP BY c.IdIndicador,c.DescripcionIndicador"
                ElseIf (cmbTrimestre.Text = "Trimestre 3") Then
                    SqlMetaMonitoreo.SelectCommand = "SELECT " & _
                            "c.DescripcionIndicador, " & _
                            "SUM(a.[ProyectadoQ1]) as ProyectadoQ1, " & _
                            "SUM(a.[ProyectadoQ2]) as ProyectadoQ2, " & _
                            "SUM(a.[ProyectadoQ3]) as ProyectadoQ3, " & _
                            "SUM(a.[ProyectadoQ4]) as ProyectadoQ4, " & _
                            "SUM(a.[EjecutadoQ1]) as EjecutadoQ1, " & _
                            "SUM(a.[EjecutadoQ2]) as EjecutadoQ2, " & _
                            "SUM(a.[EjecutadoQ3]) as EjecutadoQ3, " & _
                            "SUM(a.[EjecutadoQ4]) as EjecutadoQ4, " & _
                            "(COALESCE(SUM(a.EjecutadoQ1)/ NULLIF(SUM(a.ProyectadoQ1),0),0)) As P1, " & _
                            "(COALESCE(SUM(a.EjecutadoQ2)/ NULLIF(SUM(a.ProyectadoQ2),0),0)) As P2, " & _
                            "(COALESCE(SUM(a.EjecutadoQ3)/ NULLIF(SUM(a.ProyectadoQ3),0),0)) As P3, " & _
                            "(COALESCE(SUM(a.EjecutadoQ4)/ NULLIF(SUM(a.ProyectadoQ4),0),0)) As P4, " & _
                            "(SUM(a.ProyectadoQ1+a.ProyectadoQ2)) As PA, " & _
                            "(SUM(a.[EjecutadoQ1]+a.[EjecutadoQ2])) As EA, " & _
                            "(COALESCE((SUM(a.[EjecutadoQ1]+a.[EjecutadoQ2]))/ NULLIF((SUM(a.ProyectadoQ1+a.ProyectadoQ2)),0),0)) As PAA  " & _
                            "FROM " & _
                            "[MetaYMonitoreoPorPeriodo] a " & _
                            "join [IndicadoresPorPrograma] b on b.IdIndicadoresPorPrograma= a.IdIndicadorPorPrograma  " & _
                            "join [Indicadores] c on b.IdIndicador= c.IdIndicador " & _
                            "join [TiposDeIndicador] d on c.IdTipoDeIndicador=d.IdTipoDeIndicador " & _
                            "where " & _
                            "b.IdPrograma = 133 And a.Ano = 2013 And c.IdTipoDeIndicador = 1 And a.Activo = 1 And b.Activo = 1 And c.Activo = 1 and (a.ProyectadoQ1 <> 0 Or a.ProyectadoQ2 <> 0 OR a.ProyectadoQ3 <> 0 OR a.ProyectadoQ4 <> 0) " & _
                            "GROUP BY c.IdIndicador,c.DescripcionIndicador"

                Else

                    SqlMetaMonitoreo.SelectCommand = "SELECT c.DescripcionIndicador, " & _
                        "SUM(a.[ProyectadoQ1]) as ProyectadoQ1, SUM(a.[ProyectadoQ2]) as ProyectadoQ2, SUM(a.[ProyectadoQ3]) as ProyectadoQ3,  SUM(a.[ProyectadoQ4]) as ProyectadoQ4, " & _
                        "SUM(a.[EjecutadoQ1]) as EjecutadoQ1, SUM(a.[EjecutadoQ2]) as EjecutadoQ2, SUM(a.[EjecutadoQ3]) as EjecutadoQ3, SUM(a.[EjecutadoQ4]) as EjecutadoQ4, " & _
                        "(COALESCE(SUM(a.EjecutadoQ1)/ NULLIF(SUM(a.ProyectadoQ1),0),0)) As P1, " & _
                        "(COALESCE(SUM(a.EjecutadoQ2)/ NULLIF(SUM(a.ProyectadoQ2),0),0)) As P2, " & _
                        "(COALESCE(SUM(a.EjecutadoQ3)/ NULLIF(SUM(a.ProyectadoQ3),0),0)) As P3, " & _
                        "(COALESCE(SUM(a.EjecutadoQ4)/ NULLIF(SUM(a.ProyectadoQ4),0),0)) As P4, " & _
                        "(SUM(a.ProyectadoQ1+a.ProyectadoQ2+a.ProyectadoQ3+a.ProyectadoQ4)) As PA, " & _
                        "(SUM(a.[EjecutadoQ1]+a.[EjecutadoQ2]+a.[EjecutadoQ3]+a.[EjecutadoQ4])) As EA," & _
                        "(COALESCE((SUM(a.[EjecutadoQ1]+a.[EjecutadoQ2]+a.[EjecutadoQ3]+a.[EjecutadoQ4]))/ NULLIF((SUM(a.ProyectadoQ1+a.ProyectadoQ2+a.ProyectadoQ3+a.ProyectadoQ4)),0),0)) As PAA " & _
                        "FROM [MetaYMonitoreoPorPeriodo] a " & _
                        "join [IndicadoresPorPrograma] b on b.IdIndicadoresPorPrograma= a.IdIndicadorPorPrograma " & _
                        "join [Indicadores] c on b.IdIndicador= c.IdIndicador " & _
                        "join [TiposDeIndicador] d on c.IdTipoDeIndicador=d.IdTipoDeIndicador " & _
                        "where b.IdPrograma = @Programa And a.Ano = @Year And c.IdTipoDeIndicador = 1 And a.Activo=1 And b.Activo=1 and c.Activo=1 and a.IdAreaDeInfluencia=@Area and (a.ProyectadoQ1 <> 0 Or a.ProyectadoQ2 <> 0 OR a.ProyectadoQ3 <> 0 OR a.ProyectadoQ4 <> 0) " & _
                        "GROUP BY c.IdIndicador, c.DescripcionIndicador"
                End If

                SqlMetaMonitoreo.SelectParameters(0).DefaultValue = Session("CodPrograma")
                SqlMetaMonitoreo.SelectParameters(1).DefaultValue = cmbAno.Text
                SqlMetaMonitoreo.SelectParameters(2).DefaultValue = cmbArea.Value

                SqlMetaMonitoreo.DataBind()
                GridIndicadores.DataBind()
            End If


        End If

    End Sub


    Protected Sub GridIndicadores_HtmlDataCellPrepared(sender As Object, e As ASPxGridViewTableDataCellEventArgs)


        If e.DataColumn.FieldName = "P1" Then
            Session("Porcenta1") = Convert.ToDouble(e.CellValue)
        End If


        If e.DataColumn.Name = "S1" Then


            If Session("Porcenta1") < 0.5 Then
                e.Cell.BackColor = System.Drawing.Color.Red
            End If
            If Session("Porcenta1") >= 0.5 And Session("Porcenta1") < 0.8 Then
                e.Cell.BackColor = System.Drawing.Color.Yellow
            End If
            If Session("Porcenta1") >= 0.8 Then
                e.Cell.BackColor = System.Drawing.Color.Green
            End If
        End If


        If e.DataColumn.FieldName = "P2" Then
            Session("Porcenta2") = Convert.ToDouble(e.CellValue)

        End If


        If e.DataColumn.Name = "S2" Then


            If Session("Porcenta2") < 0.5 Then
                e.Cell.BackColor = System.Drawing.Color.Red
            End If
            If Session("Porcenta2") >= 0.5 And Session("Porcenta2") < 0.8 Then
                e.Cell.BackColor = System.Drawing.Color.Yellow
            End If
            If Session("Porcenta2") >= 0.8 Then
                e.Cell.BackColor = System.Drawing.Color.Green
            End If
        End If



        If e.DataColumn.FieldName = "P3" Then
            Session("Porcenta3") = Convert.ToDouble(e.CellValue)

        End If


        If e.DataColumn.Name = "S3" Then


            If Session("Porcenta3") < 0.5 Then
                e.Cell.BackColor = System.Drawing.Color.Red
            End If
            If Session("Porcenta3") >= 0.5 And Session("Porcenta3") < 0.8 Then
                e.Cell.BackColor = System.Drawing.Color.Yellow
            End If
            If Session("Porcenta3") >= 0.8 Then
                e.Cell.BackColor = System.Drawing.Color.Green
            End If
        End If

        If e.DataColumn.FieldName = "P4" Then
            Session("Porcenta4") = Convert.ToDouble(e.CellValue)

        End If


        If e.DataColumn.Name = "S4" Then


            If Session("Porcenta4") < 0.5 Then
                e.Cell.BackColor = System.Drawing.Color.Red
            End If
            If Session("Porcenta4") >= 0.5 And Session("Porcenta4") < 0.8 Then
                e.Cell.BackColor = System.Drawing.Color.Yellow
            End If
            If Session("Porcenta4") >= 0.8 Then
                e.Cell.BackColor = System.Drawing.Color.Green
            End If
        End If

        If e.DataColumn.FieldName = "PAA" Then
            Session("Porcenta5") = Convert.ToDouble(e.CellValue)

        End If


        If e.DataColumn.Name = "SA" Then


            If Session("Porcenta5") < 0.5 Then
                e.Cell.BackColor = System.Drawing.Color.Red
            End If
            If Session("Porcenta5") >= 0.5 And Session("Porcenta5") < 0.8 Then
                e.Cell.BackColor = System.Drawing.Color.Yellow
            End If
            If Session("Porcenta5") >= 0.8 Then
                e.Cell.BackColor = System.Drawing.Color.Green
            End If
        End If



    End Sub



    Protected Sub GridPresupuesto_CustomCallback(sender As Object, e As ASPxGridViewCustomCallbackEventArgs)

        SqlPresupuestoMeta.SelectParameters(0).DefaultValue = Session("CodPrograma")
        SqlPresupuestoMeta.SelectParameters(1).DefaultValue = cmbAnoP.Text

        SqlPresupuestoMeta.DataBind()
        GridPresupuesto.DataBind()

    End Sub


    Protected Sub GridCobertura_CustomCallback(sender As Object, e As ASPxGridViewCustomCallbackEventArgs)


        SqlCobertura.SelectParameters(0).DefaultValue = Session("CodPrograma")
        SqlCobertura.SelectParameters(1).DefaultValue = cmbAnoC.Text

        SqlCobertura.DataBind()
        GridCobertura.DataBind()

    End Sub

    Protected Sub GridCobertura_Load(sender As Object, e As EventArgs)


        SqlCobertura.SelectParameters(0).DefaultValue = Session("CodPrograma")

        SqlCobertura.SelectParameters(1).DefaultValue = cmbAnoC.Text

        SqlCobertura.DataBind()
        GridCobertura.DataBind()

    End Sub

    Protected Sub GridPreguntaRespuesta_CustomCallback(sender As Object, e As ASPxGridViewCustomCallbackEventArgs)
        SqlPreguntaRespuesta.SelectParameters(0).DefaultValue = Session("CodPrograma")

        SqlPreguntaRespuesta.DataBind()
        GridPreguntaRespuesta.DataBind()
    End Sub


    Protected Sub GridRespuestas_BeforePerformDataSelect(sender As Object, e As EventArgs)
        Session("IdPreguntaDeMonitoreo") = CType(sender, ASPxGridView).GetMasterRowKeyValue()

        SqlRespuestas.SelectParameters(0).DefaultValue = Session("IdPreguntaDeMonitoreo")
        SqlRespuestas.SelectParameters(1).DefaultValue = cmbAnoCualitativo.Text
        SqlRespuestas.DataBind()
    End Sub



    Protected Sub ASPxGridViewOpciones_BeforePerformDataSelect(sender As Object, e As EventArgs)
        Session("IdRespuesta") = CType(sender, ASPxGridView).GetMasterRowKeyValue()
        SqlDataSourceOpciones.SelectParameters(0).DefaultValue = Session("IdRespuesta")
        SqlDataSourceOpciones.DataBind()

    End Sub



    Public Property nombrePrograma As String

        Get
            Return getNombre(idPrograma)
        End Get

        Set(ByVal value As String)
            nombrePrograma = value
        End Set

    End Property

    Protected Function getNombre(idPrograma As String) As String
        Dim connectionString As String = ConfigurationManager.ConnectionStrings("SUEPPSConnectionString").ConnectionString
        Dim nombrePrograma As String
        Dim connection As SqlConnection = New SqlConnection(connectionString)
        connection.Open()
        Dim sql As String = "SELECT [NombreProyecto] FROM [vProyectos] WHERE [codigo_ficha]= " + idPrograma
        Dim command As SqlCommand = New SqlCommand(sql, connection)
        Dim reader As SqlDataReader = command.ExecuteReader()

        If (reader.Read()) Then

            nombrePrograma = reader.GetValue(0)

        End If
        reader.Close()
        Return nombrePrograma
    End Function



    Protected Overrides Sub OnLoad(ByVal e As EventArgs)
        MyBase.OnLoad(e)
        If (Not IsPostBack) Then
            ASPxGridViewCategoriasIndicadorCobertura.DataBind()
            ASPxGridViewCategoriasIndicadorCobertura.DetailRows.ExpandRow(0)
            GridPreguntaRespuesta.DataBind()
        End If
    End Sub


    Protected Sub ASPxGridViewIndicadoresCobertura_BeforePerformDataSelect(sender As Object, e As EventArgs)

        Session("IdCategoriaIndicadorCobertura") = CType(sender, ASPxGridView).GetMasterRowKeyValue()

        SqlDataSourceIndicadoresCobertura.SelectCommand = "SELECT ipp.IdIndicadoresPorPrograma, ipp.IdIndicador, ipp.IdPrograma, ipp.Activo, i.IdCategoriaIndicadorCobertura, i.IdCategoriaIndicadorCobertura, SUM(m.ProyectadoQ1 + m.ProyectadoQ2 + m.ProyectadoQ3 + m.ProyectadoQ4) as suma " & _
                                                            "FROM [IndicadoresPorPrograma] as ipp, [Indicadores] as i, [MetaYMonitoreoPorPeriodo] as m " & _
                                                            "WHERE ipp.IdIndicador = i.[IdIndicador] AND [IdCategoriaIndicadorCobertura] = @IdCategoriaIndicadorCobertura AND ipp.IdIndicadoresPorPrograma = m.IdIndicadorPorPrograma AND i.[IdTipoDeIndicador]=2 AND ipp.IdPrograma= " & Str(Session("CodPrograma")) & _
                                                            "GROUP BY ipp.IdIndicadoresPorPrograma, ipp.IdIndicador, ipp.IdPrograma, ipp.Activo, i.IdCategoriaIndicadorCobertura"

    End Sub

    Protected Sub Page_Load(sender As Object, e As EventArgs) Handles Me.Load
        'Verifica si el usuario tiene el acceso a la pagina solicitada
        Using dtMOCA As System.Data.DataTable = fMOCA.CheckPageAccess(3.01) 'este es el Id definido en el MOCA
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

        idPrograma = CInt(uf.QueryStringDecode(Request.QueryString.Get(1)))
        Dim connectionString As String = ConfigurationManager.ConnectionStrings("SUEPPSConnectionString").ConnectionString

        Dim connection As SqlConnection = New SqlConnection(connectionString)
        connection.Open()
        Dim sql As String = "SELECT [Beneficiario], [Objetivo] FROM [vObjetivosBeneficiarios] WHERE [IdPrograma]= " + idPrograma.ToString
        Dim command As SqlCommand = New SqlCommand(sql, connection)
        Dim reader As SqlDataReader = command.ExecuteReader()

        If (reader.Read()) Then

            ASPxLabelBeneficiarios.Text = reader.GetValue(0)
            ASPxLabelObjetivos.Text = reader.GetValue(1)
        End If
        reader.Close()
        ASPxLabelPrograma.Text = nombrePrograma

        SqlRespuestas.SelectParameters(2).DefaultValue = Session("CodPrograma")
    End Sub

    Protected Function IsGridOpcionesVisible(ByVal IdPreguntaDeMonitoreo As Object) As Boolean
        Dim Tipo As Integer = GridPreguntaRespuesta.GetRowValuesByKeyValue(IdPreguntaDeMonitoreo, "IdTipoDePregunta")

        Return (3 = Tipo Or 4 = Tipo)

        MsgBox(Tipo)

    End Function


    Protected Sub GridIndicadoresI_CustomCallback(sender As Object, e As ASPxGridViewCustomCallbackEventArgs)

        If (cmbTrimestreIndicadores.Text = "Trimestre 1") Then
            SqlMetaIndicadores.SelectCommand = "SELECT " & _
                "c.DescripcionIndicador, " & _
                "SUM(a.[ProyectadoQ1]) as ProyectadoQ1, " & _
                "SUM(a.[ProyectadoQ2]) as ProyectadoQ2, " & _
                "SUM(a.[ProyectadoQ3]) as ProyectadoQ3, " & _
                "SUM(a.[ProyectadoQ4]) as ProyectadoQ4, " & _
                "SUM(a.[EjecutadoQ1]) as EjecutadoQ1, " & _
                "SUM(a.[EjecutadoQ2]) as EjecutadoQ2, " & _
                "SUM(a.[EjecutadoQ3]) as EjecutadoQ3, " & _
                "SUM(a.[EjecutadoQ4]) as EjecutadoQ4, " & _
                "(COALESCE(SUM(a.EjecutadoQ1)/ NULLIF(SUM(a.ProyectadoQ1),0),0)) As P1, " & _
                "(COALESCE(SUM(a.EjecutadoQ2)/ NULLIF(SUM(a.ProyectadoQ2),0),0)) As P2, " & _
                "(COALESCE(SUM(a.EjecutadoQ3)/ NULLIF(SUM(a.ProyectadoQ3),0),0)) As P3, " & _
                "(COALESCE(SUM(a.EjecutadoQ4)/ NULLIF(SUM(a.ProyectadoQ4),0),0)) As P4, " & _
                "(SUM(a.ProyectadoQ1)) As PA, " & _
                "(SUM(a.[EjecutadoQ1])) As EA, " & _
                "(COALESCE((SUM(a.[EjecutadoQ1]))/ NULLIF((SUM(a.ProyectadoQ1)),0),0)) As PAA " & _
                "FROM " & _
                "[MetaYMonitoreoPorPeriodo] a " & _
                "join [IndicadoresPorPrograma] b on b.IdIndicadoresPorPrograma= a.IdIndicadorPorPrograma " & _
                "join [Indicadores] c on b.IdIndicador= c.IdIndicador " & _
                "join [TiposDeIndicador] d on c.IdTipoDeIndicador=d.IdTipoDeIndicador " & _
                "where " & _
                "b.IdPrograma = @Programa And a.Ano = @Year And c.IdTipoDeIndicador = 1 And a.Activo = 1 And b.Activo = 1 And c.Activo = 1 and (a.ProyectadoQ1 <> 0 Or a.ProyectadoQ2 <> 0 OR a.ProyectadoQ3 <> 0 OR a.ProyectadoQ4 <> 0) " & _
                "GROUP BY c.IdIndicador,c.DescripcionIndicador "
        ElseIf (cmbTrimestreIndicadores.Text = "Trimestre 2") Then
            SqlMetaIndicadores.SelectCommand = "SELECT " & _
                    "c.DescripcionIndicador, " & _
                    "SUM(a.[ProyectadoQ1]) as ProyectadoQ1, " & _
                    "SUM(a.[ProyectadoQ2]) as ProyectadoQ2, " & _
                    "SUM(a.[ProyectadoQ3]) as ProyectadoQ3, " & _
                    "SUM(a.[ProyectadoQ4]) as ProyectadoQ4, " & _
                    "SUM(a.[EjecutadoQ1]) as EjecutadoQ1, " & _
                    "SUM(a.[EjecutadoQ2]) as EjecutadoQ2, " & _
                    "SUM(a.[EjecutadoQ3]) as EjecutadoQ3, " & _
                    "SUM(a.[EjecutadoQ4]) as EjecutadoQ4, " & _
                    "(COALESCE(SUM(a.EjecutadoQ1)/ NULLIF(SUM(a.ProyectadoQ1),0),0)) As P1, " & _
                    "(COALESCE(SUM(a.EjecutadoQ2)/ NULLIF(SUM(a.ProyectadoQ2),0),0)) As P2, " & _
                    "(COALESCE(SUM(a.EjecutadoQ3)/ NULLIF(SUM(a.ProyectadoQ3),0),0)) As P3, " & _
                    "(COALESCE(SUM(a.EjecutadoQ4)/ NULLIF(SUM(a.ProyectadoQ4),0),0)) As P4, " & _
                    "(SUM(a.ProyectadoQ1+a.ProyectadoQ2)) As PA, " & _
                    "(SUM(a.[EjecutadoQ1]+a.[EjecutadoQ2])) As EA, " & _
                    "(COALESCE((SUM(a.[EjecutadoQ1]+a.[EjecutadoQ2]))/ NULLIF((SUM(a.ProyectadoQ1+a.ProyectadoQ2)),0),0)) As PAA " & _
                    "FROM " & _
                    "[MetaYMonitoreoPorPeriodo] a " & _
                    "join [IndicadoresPorPrograma] b on b.IdIndicadoresPorPrograma= a.IdIndicadorPorPrograma " & _
                    "join [Indicadores] c on b.IdIndicador= c.IdIndicador " & _
                    "join [TiposDeIndicador] d on c.IdTipoDeIndicador=d.IdTipoDeIndicador " & _
                    "where " & _
                    "b.IdPrograma = @Programa And a.Ano = @Year And c.IdTipoDeIndicador = 1 And a.Activo = 1 And b.Activo = 1 And c.Activo = 1 and (a.ProyectadoQ1 <> 0 Or a.ProyectadoQ2 <> 0 OR a.ProyectadoQ3 <> 0 OR a.ProyectadoQ4 <> 0) " & _
                    "GROUP BY c.IdIndicador,c.DescripcionIndicador"
        ElseIf (cmbTrimestreIndicadores.Text = "Trimestre 3") Then
            SqlMetaIndicadores.SelectCommand = "SELECT " & _
                    "c.DescripcionIndicador, " & _
                    "SUM(a.[ProyectadoQ1]) as ProyectadoQ1, " & _
                    "SUM(a.[ProyectadoQ2]) as ProyectadoQ2, " & _
                    "SUM(a.[ProyectadoQ3]) as ProyectadoQ3, " & _
                    "SUM(a.[ProyectadoQ4]) as ProyectadoQ4, " & _
                    "SUM(a.[EjecutadoQ1]) as EjecutadoQ1, " & _
                    "SUM(a.[EjecutadoQ2]) as EjecutadoQ2, " & _
                    "SUM(a.[EjecutadoQ3]) as EjecutadoQ3, " & _
                    "SUM(a.[EjecutadoQ4]) as EjecutadoQ4, " & _
                    "(COALESCE(SUM(a.EjecutadoQ1)/ NULLIF(SUM(a.ProyectadoQ1),0),0)) As P1, " & _
                    "(COALESCE(SUM(a.EjecutadoQ2)/ NULLIF(SUM(a.ProyectadoQ2),0),0)) As P2, " & _
                    "(COALESCE(SUM(a.EjecutadoQ3)/ NULLIF(SUM(a.ProyectadoQ3),0),0)) As P3, " & _
                    "(COALESCE(SUM(a.EjecutadoQ4)/ NULLIF(SUM(a.ProyectadoQ4),0),0)) As P4, " & _
                    "(SUM(a.ProyectadoQ1+a.ProyectadoQ2+a.ProyectadoQ3)) As PA, " & _
                    "(SUM(a.[EjecutadoQ1]+a.[EjecutadoQ2]+a.[EjecutadoQ3])) As EA, " & _
                    "(COALESCE((SUM(a.[EjecutadoQ1]+a.[EjecutadoQ2]+a.[EjecutadoQ3]))/ NULLIF((SUM(a.ProyectadoQ1+a.ProyectadoQ2+a.ProyectadoQ3)),0),0)) As PAA " & _
                    "FROM " & _
                    "[MetaYMonitoreoPorPeriodo] a " & _
                    "join [IndicadoresPorPrograma] b on b.IdIndicadoresPorPrograma= a.IdIndicadorPorPrograma " & _
                    "join [Indicadores] c on b.IdIndicador= c.IdIndicador " & _
                    "join [TiposDeIndicador] d on c.IdTipoDeIndicador=d.IdTipoDeIndicador " & _
                    "where " & _
                    "b.IdPrograma = 133 And a.Ano = 2013 And c.IdTipoDeIndicador = 1 And a.Activo = 1 And b.Activo = 1 And c.Activo = 1 and (a.ProyectadoQ1 <> 0 Or a.ProyectadoQ2 <> 0 OR a.ProyectadoQ3 <> 0 OR a.ProyectadoQ4 <> 0) " & _
                    "GROUP BY c.IdIndicador,c.DescripcionIndicador"
        Else
            SqlMetaIndicadores.SelectCommand = "SELECT c.DescripcionIndicador, " & _
                "SUM(a.[ProyectadoQ1]) as ProyectadoQ1, SUM(a.[ProyectadoQ2]) as ProyectadoQ2, SUM(a.[ProyectadoQ3]) as ProyectadoQ3,  SUM(a.[ProyectadoQ4]) as ProyectadoQ4, " & _
                "SUM(a.[EjecutadoQ1]) as EjecutadoQ1, SUM(a.[EjecutadoQ2]) as EjecutadoQ2, SUM(a.[EjecutadoQ3]) as EjecutadoQ3, SUM(a.[EjecutadoQ4]) as EjecutadoQ4, " & _
                "(COALESCE(SUM(a.EjecutadoQ1)/ NULLIF(SUM(a.ProyectadoQ1),0),0)) As P1, " & _
                "(COALESCE(SUM(a.EjecutadoQ2)/ NULLIF(SUM(a.ProyectadoQ2),0),0)) As P2, " & _
                "(COALESCE(SUM(a.EjecutadoQ3)/ NULLIF(SUM(a.ProyectadoQ3),0),0)) As P3, " & _
                "(COALESCE(SUM(a.EjecutadoQ4)/ NULLIF(SUM(a.ProyectadoQ4),0),0)) As P4, " & _
                "(SUM(a.ProyectadoQ1+a.ProyectadoQ2+a.ProyectadoQ3+a.ProyectadoQ4)) As PA, " & _
                "(SUM(a.[EjecutadoQ1]+a.[EjecutadoQ2]+a.[EjecutadoQ3]+a.[EjecutadoQ4])) As EA," & _
                "(COALESCE((SUM(a.[EjecutadoQ1]+a.[EjecutadoQ2]+a.[EjecutadoQ3]+a.[EjecutadoQ4]))/ NULLIF((SUM(a.ProyectadoQ1+a.ProyectadoQ2+a.ProyectadoQ3+a.ProyectadoQ4)),0),0)) As PAA " & _
                "FROM [MetaYMonitoreoPorPeriodo] a " & _
                "join [IndicadoresPorPrograma] b on b.IdIndicadoresPorPrograma= a.IdIndicadorPorPrograma " & _
                "join [Indicadores] c on b.IdIndicador= c.IdIndicador " & _
                "join [TiposDeIndicador] d on c.IdTipoDeIndicador=d.IdTipoDeIndicador " & _
                "where b.IdPrograma = @Programa And a.Ano = @Year And c.IdTipoDeIndicador = 1 And a.Activo=1 And b.Activo=1 and c.Activo=1 and (a.ProyectadoQ1 <> 0 Or a.ProyectadoQ2 <> 0 OR a.ProyectadoQ3 <> 0 OR a.ProyectadoQ4 <> 0) " & _
                "GROUP BY c.IdIndicador,c.DescripcionIndicador"
        End If


        SqlMetaIndicadores.SelectParameters(0).DefaultValue = Session("CodPrograma")
        SqlMetaIndicadores.SelectParameters(1).DefaultValue = cmbAnoI.Text
        SqlMetaIndicadores.DataBind()
        GridIndicadoresI.DataBind()

    End Sub

    Protected Sub GridIndicadoresI_HtmlDataCellPrepared(sender As Object, e As ASPxGridViewTableDataCellEventArgs)

        If e.DataColumn.FieldName = "P1" Then
            Session("Porcenta1") = Convert.ToDouble(e.CellValue)
        End If


        If e.DataColumn.Name = "S1" Then


            If Session("Porcenta1") < 0.5 Then
                e.Cell.BackColor = System.Drawing.Color.Red
            End If
            If Session("Porcenta1") >= 0.5 And Session("Porcenta1") < 0.8 Then
                e.Cell.BackColor = System.Drawing.Color.Yellow
            End If
            If Session("Porcenta1") >= 0.8 Then
                e.Cell.BackColor = System.Drawing.Color.Green
            End If
        End If


        If e.DataColumn.FieldName = "P2" Then
            Session("Porcenta2") = Convert.ToDouble(e.CellValue)

        End If


        If e.DataColumn.Name = "S2" Then


            If Session("Porcenta2") < 0.5 Then
                e.Cell.BackColor = System.Drawing.Color.Red
            End If
            If Session("Porcenta2") >= 0.5 And Session("Porcenta2") < 0.8 Then
                e.Cell.BackColor = System.Drawing.Color.Yellow
            End If
            If Session("Porcenta2") >= 0.8 Then
                e.Cell.BackColor = System.Drawing.Color.Green
            End If
        End If



        If e.DataColumn.FieldName = "P3" Then
            Session("Porcenta3") = Convert.ToDouble(e.CellValue)

        End If


        If e.DataColumn.Name = "S3" Then


            If Session("Porcenta3") < 0.5 Then
                e.Cell.BackColor = System.Drawing.Color.Red
            End If
            If Session("Porcenta3") >= 0.5 And Session("Porcenta3") < 0.8 Then
                e.Cell.BackColor = System.Drawing.Color.Yellow
            End If
            If Session("Porcenta3") >= 0.8 Then
                e.Cell.BackColor = System.Drawing.Color.Green
            End If
        End If

        If e.DataColumn.FieldName = "P4" Then
            Session("Porcenta4") = Convert.ToDouble(e.CellValue)

        End If


        If e.DataColumn.Name = "S4" Then


            If Session("Porcenta4") < 0.5 Then
                e.Cell.BackColor = System.Drawing.Color.Red
            End If
            If Session("Porcenta4") >= 0.5 And Session("Porcenta4") < 0.8 Then
                e.Cell.BackColor = System.Drawing.Color.Yellow
            End If
            If Session("Porcenta4") >= 0.8 Then
                e.Cell.BackColor = System.Drawing.Color.Green
            End If
        End If

        If e.DataColumn.FieldName = "PAA" Then
            Session("Porcenta5") = Convert.ToDouble(e.CellValue)

        End If


        If e.DataColumn.Name = "SA" Then


            If Session("Porcenta5") < 0.5 Then
                e.Cell.BackColor = System.Drawing.Color.Red
            End If
            If Session("Porcenta5") >= 0.5 And Session("Porcenta5") < 0.8 Then
                e.Cell.BackColor = System.Drawing.Color.Yellow
            End If
            If Session("Porcenta5") >= 0.8 Then
                e.Cell.BackColor = System.Drawing.Color.Green
            End If
        End If


    End Sub

    Protected Sub GridDetalleIndicador_BeforePerformDataSelect(sender As Object, e As EventArgs)
        Session("Descripcion") = CType(sender, ASPxGridView).GetMasterRowKeyValue()
        SqlDataSource1.SelectParameters(0).DefaultValue = Session("CodPrograma")
        SqlDataSource1.SelectParameters(1).DefaultValue = cmbAnoI.Text
        SqlDataSource1.SelectParameters(2).DefaultValue = Session("Descripcion")
        SqlDataSource1.DataBind()
    End Sub

    Protected Sub ExportarPresupuesto_Click(sender As Object, e As EventArgs)

        SqlPresupuestoMeta.SelectParameters(0).DefaultValue = Session("CodPrograma")
        SqlPresupuestoMeta.SelectParameters(1).DefaultValue = cmbAnoP.Text

        SqlPresupuestoMeta.DataBind()
        GridPresupuesto.DataBind()
        ASPxGridViewExporter1.WriteXlsToResponse()


    End Sub


    Protected Sub ExportarIndicador_Click(sender As Object, e As EventArgs)

        If (cmbTrimestreIndicadores.Text = "Trimestre 1") Then
            SqlMetaIndicadores.SelectCommand = "SELECT " & _
                "c.DescripcionIndicador, " & _
                "SUM(a.[ProyectadoQ1]) as ProyectadoQ1, " & _
                "SUM(a.[ProyectadoQ2]) as ProyectadoQ2, " & _
                "SUM(a.[ProyectadoQ3]) as ProyectadoQ3, " & _
                "SUM(a.[ProyectadoQ4]) as ProyectadoQ4, " & _
                "SUM(a.[EjecutadoQ1]) as EjecutadoQ1, " & _
                "SUM(a.[EjecutadoQ2]) as EjecutadoQ2, " & _
                "SUM(a.[EjecutadoQ3]) as EjecutadoQ3, " & _
                "SUM(a.[EjecutadoQ4]) as EjecutadoQ4, " & _
                "(COALESCE(SUM(a.EjecutadoQ1)/ NULLIF(SUM(a.ProyectadoQ1),0),0)) As P1, " & _
                "(COALESCE(SUM(a.EjecutadoQ2)/ NULLIF(SUM(a.ProyectadoQ2),0),0)) As P2, " & _
                "(COALESCE(SUM(a.EjecutadoQ3)/ NULLIF(SUM(a.ProyectadoQ3),0),0)) As P3, " & _
                "(COALESCE(SUM(a.EjecutadoQ4)/ NULLIF(SUM(a.ProyectadoQ4),0),0)) As P4, " & _
                "(SUM(a.ProyectadoQ1)) As PA, " & _
                "(SUM(a.[EjecutadoQ1])) As EA, " & _
                "(COALESCE((SUM(a.[EjecutadoQ1]))/ NULLIF((SUM(a.ProyectadoQ1)),0),0)) As PAA " & _
                "FROM " & _
                "[MetaYMonitoreoPorPeriodo] a " & _
                "join [IndicadoresPorPrograma] b on b.IdIndicadoresPorPrograma= a.IdIndicadorPorPrograma " & _
                "join [Indicadores] c on b.IdIndicador= c.IdIndicador " & _
                "join [TiposDeIndicador] d on c.IdTipoDeIndicador=d.IdTipoDeIndicador " & _
                "where " & _
                "b.IdPrograma = @Programa And a.Ano = @Year And c.IdTipoDeIndicador = 1 And a.Activo = 1 And b.Activo = 1 And c.Activo = 1 and (a.ProyectadoQ1 <> 0 Or a.ProyectadoQ2 <> 0 OR a.ProyectadoQ3 <> 0 OR a.ProyectadoQ4 <> 0) " & _
                "GROUP BY c.IdIndicador,c.DescripcionIndicador "
        ElseIf (cmbTrimestreIndicadores.Text = "Trimestre 2") Then
            SqlMetaIndicadores.SelectCommand = "SELECT " & _
                    "c.DescripcionIndicador, " & _
                    "SUM(a.[ProyectadoQ1]) as ProyectadoQ1, " & _
                    "SUM(a.[ProyectadoQ2]) as ProyectadoQ2, " & _
                    "SUM(a.[ProyectadoQ3]) as ProyectadoQ3, " & _
                    "SUM(a.[ProyectadoQ4]) as ProyectadoQ4, " & _
                    "SUM(a.[EjecutadoQ1]) as EjecutadoQ1, " & _
                    "SUM(a.[EjecutadoQ2]) as EjecutadoQ2, " & _
                    "SUM(a.[EjecutadoQ3]) as EjecutadoQ3, " & _
                    "SUM(a.[EjecutadoQ4]) as EjecutadoQ4, " & _
                    "(COALESCE(SUM(a.EjecutadoQ1)/ NULLIF(SUM(a.ProyectadoQ1),0),0)) As P1, " & _
                    "(COALESCE(SUM(a.EjecutadoQ2)/ NULLIF(SUM(a.ProyectadoQ2),0),0)) As P2, " & _
                    "(COALESCE(SUM(a.EjecutadoQ3)/ NULLIF(SUM(a.ProyectadoQ3),0),0)) As P3, " & _
                    "(COALESCE(SUM(a.EjecutadoQ4)/ NULLIF(SUM(a.ProyectadoQ4),0),0)) As P4, " & _
                    "(SUM(a.ProyectadoQ1+a.ProyectadoQ2)) As PA, " & _
                    "(SUM(a.[EjecutadoQ1]+a.[EjecutadoQ2])) As EA, " & _
                    "(COALESCE((SUM(a.[EjecutadoQ1]+a.[EjecutadoQ2]))/ NULLIF((SUM(a.ProyectadoQ1+a.ProyectadoQ2)),0),0)) As PAA " & _
                    "FROM " & _
                    "[MetaYMonitoreoPorPeriodo] a " & _
                    "join [IndicadoresPorPrograma] b on b.IdIndicadoresPorPrograma= a.IdIndicadorPorPrograma " & _
                    "join [Indicadores] c on b.IdIndicador= c.IdIndicador " & _
                    "join [TiposDeIndicador] d on c.IdTipoDeIndicador=d.IdTipoDeIndicador " & _
                    "where " & _
                    "b.IdPrograma = @Programa And a.Ano = @Year And c.IdTipoDeIndicador = 1 And a.Activo = 1 And b.Activo = 1 And c.Activo = 1 and (a.ProyectadoQ1 <> 0 Or a.ProyectadoQ2 <> 0 OR a.ProyectadoQ3 <> 0 OR a.ProyectadoQ4 <> 0) " & _
                    "GROUP BY c.IdIndicador,c.DescripcionIndicador"
        ElseIf (cmbTrimestreIndicadores.Text = "Trimestre 3") Then
            SqlMetaIndicadores.SelectCommand = "SELECT " & _
                    "c.DescripcionIndicador, " & _
                    "SUM(a.[ProyectadoQ1]) as ProyectadoQ1, " & _
                    "SUM(a.[ProyectadoQ2]) as ProyectadoQ2, " & _
                    "SUM(a.[ProyectadoQ3]) as ProyectadoQ3, " & _
                    "SUM(a.[ProyectadoQ4]) as ProyectadoQ4, " & _
                    "SUM(a.[EjecutadoQ1]) as EjecutadoQ1, " & _
                    "SUM(a.[EjecutadoQ2]) as EjecutadoQ2, " & _
                    "SUM(a.[EjecutadoQ3]) as EjecutadoQ3, " & _
                    "SUM(a.[EjecutadoQ4]) as EjecutadoQ4, " & _
                    "(COALESCE(SUM(a.EjecutadoQ1)/ NULLIF(SUM(a.ProyectadoQ1),0),0)) As P1, " & _
                    "(COALESCE(SUM(a.EjecutadoQ2)/ NULLIF(SUM(a.ProyectadoQ2),0),0)) As P2, " & _
                    "(COALESCE(SUM(a.EjecutadoQ3)/ NULLIF(SUM(a.ProyectadoQ3),0),0)) As P3, " & _
                    "(COALESCE(SUM(a.EjecutadoQ4)/ NULLIF(SUM(a.ProyectadoQ4),0),0)) As P4, " & _
                    "(SUM(a.ProyectadoQ1+a.ProyectadoQ2+a.ProyectadoQ3)) As PA, " & _
                    "(SUM(a.[EjecutadoQ1]+a.[EjecutadoQ2]+a.[EjecutadoQ3])) As EA, " & _
                    "(COALESCE((SUM(a.[EjecutadoQ1]+a.[EjecutadoQ2]+a.[EjecutadoQ3]))/ NULLIF((SUM(a.ProyectadoQ1+a.ProyectadoQ2+a.ProyectadoQ3)),0),0)) As PAA " & _
                    "FROM " & _
                    "[MetaYMonitoreoPorPeriodo] a " & _
                    "join [IndicadoresPorPrograma] b on b.IdIndicadoresPorPrograma= a.IdIndicadorPorPrograma " & _
                    "join [Indicadores] c on b.IdIndicador= c.IdIndicador " & _
                    "join [TiposDeIndicador] d on c.IdTipoDeIndicador=d.IdTipoDeIndicador " & _
                    "where " & _
                    "b.IdPrograma = 133 And a.Ano = 2013 And c.IdTipoDeIndicador = 1 And a.Activo = 1 And b.Activo = 1 And c.Activo = 1 and (a.ProyectadoQ1 <> 0 Or a.ProyectadoQ2 <> 0 OR a.ProyectadoQ3 <> 0 OR a.ProyectadoQ4 <> 0) " & _
                    "GROUP BY c.IdIndicador,c.DescripcionIndicador"
        Else
            SqlMetaIndicadores.SelectCommand = "SELECT c.DescripcionIndicador, " & _
                "SUM(a.[ProyectadoQ1]) as ProyectadoQ1, SUM(a.[ProyectadoQ2]) as ProyectadoQ2, SUM(a.[ProyectadoQ3]) as ProyectadoQ3,  SUM(a.[ProyectadoQ4]) as ProyectadoQ4, " & _
                "SUM(a.[EjecutadoQ1]) as EjecutadoQ1, SUM(a.[EjecutadoQ2]) as EjecutadoQ2, SUM(a.[EjecutadoQ3]) as EjecutadoQ3, SUM(a.[EjecutadoQ4]) as EjecutadoQ4, " & _
                "(COALESCE(SUM(a.EjecutadoQ1)/ NULLIF(SUM(a.ProyectadoQ1),0),0)) As P1, " & _
                "(COALESCE(SUM(a.EjecutadoQ2)/ NULLIF(SUM(a.ProyectadoQ2),0),0)) As P2, " & _
                "(COALESCE(SUM(a.EjecutadoQ3)/ NULLIF(SUM(a.ProyectadoQ3),0),0)) As P3, " & _
                "(COALESCE(SUM(a.EjecutadoQ4)/ NULLIF(SUM(a.ProyectadoQ4),0),0)) As P4, " & _
                "(SUM(a.ProyectadoQ1+a.ProyectadoQ2+a.ProyectadoQ3+a.ProyectadoQ4)) As PA, " & _
                "(SUM(a.[EjecutadoQ1]+a.[EjecutadoQ2]+a.[EjecutadoQ3]+a.[EjecutadoQ4])) As EA," & _
                "(COALESCE((SUM(a.[EjecutadoQ1]+a.[EjecutadoQ2]+a.[EjecutadoQ3]+a.[EjecutadoQ4]))/ NULLIF((SUM(a.ProyectadoQ1+a.ProyectadoQ2+a.ProyectadoQ3+a.ProyectadoQ4)),0),0)) As PAA " & _
                "FROM [MetaYMonitoreoPorPeriodo] a " & _
                "join [IndicadoresPorPrograma] b on b.IdIndicadoresPorPrograma= a.IdIndicadorPorPrograma " & _
                "join [Indicadores] c on b.IdIndicador= c.IdIndicador " & _
                "join [TiposDeIndicador] d on c.IdTipoDeIndicador=d.IdTipoDeIndicador " & _
                "where b.IdPrograma = @Programa And a.Ano = @Year And c.IdTipoDeIndicador = 1 And a.Activo=1 And b.Activo=1 and c.Activo=1 and (a.ProyectadoQ1 <> 0 Or a.ProyectadoQ2 <> 0 OR a.ProyectadoQ3 <> 0 OR a.ProyectadoQ4 <> 0) " & _
                "GROUP BY c.IdIndicador,c.DescripcionIndicador"
        End If

        SqlMetaIndicadores.SelectParameters(0).DefaultValue = Session("CodPrograma")
        SqlMetaIndicadores.SelectParameters(1).DefaultValue = cmbAnoI.Text
        SqlMetaIndicadores.DataBind()
        GridIndicadoresI.DataBind()

        ASPxGridViewExporter4.WriteXlsxToResponse()
    End Sub


    Protected Sub ExportarCarateristica_Click(ByVal sender As Object, ByVal e As EventArgs)

        exporter.PageHeader.Center = nombrePrograma
        exporter.WriteXlsxToResponse()
    End Sub

    Protected Sub ExportarEncuesta_Click(sender As Object, e As EventArgs)
        SqlPreguntaRespuesta.SelectParameters(0).DefaultValue = Session("CodPrograma")
        SqlPreguntaRespuesta.DataBind()
        GridPreguntaRespuesta.DataBind()
        exporter.WriteXlsxToResponse()
    End Sub

    Protected Sub ExportarCobertura_Click(sender As Object, e As EventArgs)
        SqlCobertura.SelectParameters(0).DefaultValue = Session("CodPrograma")
        SqlCobertura.SelectParameters(1).DefaultValue = cmbAnoC.Text

        SqlCobertura.DataBind()
        GridCobertura.DataBind()

        ASPxGridViewExporter2.WriteXlsToResponse()

    End Sub

    Protected Sub ExportarIndicadorArea_Click(sender As Object, e As EventArgs)

        If (cmbTrimestre.Text = "Trimestre 1") Then
            SqlMetaMonitoreo.SelectCommand = "SELECT " & _
                    "c.DescripcionIndicador, " & _
                    "SUM(a.[ProyectadoQ1]) as ProyectadoQ1, " & _
                    "SUM(a.[ProyectadoQ2]) as ProyectadoQ2, " & _
                    "SUM(a.[ProyectadoQ3]) as ProyectadoQ3, " & _
                    "SUM(a.[ProyectadoQ4]) as ProyectadoQ4, " & _
                    "SUM(a.[EjecutadoQ1]) as EjecutadoQ1, " & _
                    "SUM(a.[EjecutadoQ2]) as EjecutadoQ2, " & _
                    "SUM(a.[EjecutadoQ3]) as EjecutadoQ3, " & _
                    "SUM(a.[EjecutadoQ4]) as EjecutadoQ4, " & _
                    "(COALESCE(SUM(a.EjecutadoQ1)/ NULLIF(SUM(a.ProyectadoQ1),0),0)) As P1, " & _
                    "(COALESCE(SUM(a.EjecutadoQ2)/ NULLIF(SUM(a.ProyectadoQ2),0),0)) As P2, " & _
                    "(COALESCE(SUM(a.EjecutadoQ3)/ NULLIF(SUM(a.ProyectadoQ3),0),0)) As P3, " & _
                    "(COALESCE(SUM(a.EjecutadoQ4)/ NULLIF(SUM(a.ProyectadoQ4),0),0)) As P4, " & _
                    "(SUM(a.ProyectadoQ1)) As PA, " & _
                    "(SUM(a.[EjecutadoQ1])) As EA, " & _
                    "(COALESCE((SUM(a.[EjecutadoQ1]))/ NULLIF((SUM(a.ProyectadoQ1)),0),0)) As PAA " & _
                    "FROM " & _
                    "[MetaYMonitoreoPorPeriodo] a " & _
                    "join [IndicadoresPorPrograma] b on b.IdIndicadoresPorPrograma= a.IdIndicadorPorPrograma " & _
                    "join [Indicadores] c on b.IdIndicador= c.IdIndicador " & _
                    "join [TiposDeIndicador] d on c.IdTipoDeIndicador=d.IdTipoDeIndicador " & _
                    "where " & _
                    "b.IdPrograma = 133 And a.Ano = 2013 And c.IdTipoDeIndicador = 1 And a.Activo = 1 And b.Activo = 1 And c.Activo = 1 and a.IdAreaDeInfluencia=@Area and (a.ProyectadoQ1 <> 0 Or a.ProyectadoQ2 <> 0 OR a.ProyectadoQ3 <> 0 OR a.ProyectadoQ4 <> 0) " & _
                    "GROUP BY c.IdIndicador,c.DescripcionIndicador"

        ElseIf (cmbTrimestre.Text = "Trimestre 2") Then
            SqlMetaMonitoreo.SelectCommand = "SELECT " & _
                    "c.DescripcionIndicador, " & _
                    "SUM(a.[ProyectadoQ1]) as ProyectadoQ1, " & _
                    "SUM(a.[ProyectadoQ2]) as ProyectadoQ2, " & _
                    "SUM(a.[ProyectadoQ3]) as ProyectadoQ3, " & _
                    "SUM(a.[ProyectadoQ4]) as ProyectadoQ4, " & _
                    "SUM(a.[EjecutadoQ1]) as EjecutadoQ1, " & _
                    "SUM(a.[EjecutadoQ2]) as EjecutadoQ2, " & _
                    "SUM(a.[EjecutadoQ3]) as EjecutadoQ3, " & _
                    "SUM(a.[EjecutadoQ4]) as EjecutadoQ4, " & _
                    "(COALESCE(SUM(a.EjecutadoQ1)/ NULLIF(SUM(a.ProyectadoQ1),0),0)) As P1, " & _
                    "(COALESCE(SUM(a.EjecutadoQ2)/ NULLIF(SUM(a.ProyectadoQ2),0),0)) As P2, " & _
                    "(COALESCE(SUM(a.EjecutadoQ3)/ NULLIF(SUM(a.ProyectadoQ3),0),0)) As P3, " & _
                    "(COALESCE(SUM(a.EjecutadoQ4)/ NULLIF(SUM(a.ProyectadoQ4),0),0)) As P4, " & _
                    "(SUM(a.ProyectadoQ1+a.ProyectadoQ2)) As PA, " & _
                    "(SUM(a.[EjecutadoQ1]+a.[EjecutadoQ2])) As EA, " & _
                    "(COALESCE((SUM(a.[EjecutadoQ1]+a.[EjecutadoQ2]))/ NULLIF((SUM(a.ProyectadoQ1+a.ProyectadoQ2)),0),0)) As PAA " & _
                    "FROM " & _
                    "[MetaYMonitoreoPorPeriodo] a " & _
                    "join [IndicadoresPorPrograma] b on b.IdIndicadoresPorPrograma= a.IdIndicadorPorPrograma  " & _
                    "join [Indicadores] c on b.IdIndicador= c.IdIndicador " & _
                    "join [TiposDeIndicador] d on c.IdTipoDeIndicador=d.IdTipoDeIndicador " & _
                    "where " & _
                    "b.IdPrograma = 133 And a.Ano = 2013 And c.IdTipoDeIndicador = 1 And a.Activo = 1 And b.Activo = 1 And c.Activo = 1 and a.IdAreaDeInfluencia=@Area and (a.ProyectadoQ1 <> 0 Or a.ProyectadoQ2 <> 0 OR a.ProyectadoQ3 <> 0 OR a.ProyectadoQ4 <> 0) " & _
                    "GROUP BY c.IdIndicador,c.DescripcionIndicador"
        ElseIf (cmbTrimestre.Text = "Trimestre 3") Then
            SqlMetaMonitoreo.SelectCommand = "SELECT " & _
                    "c.DescripcionIndicador, " & _
                    "SUM(a.[ProyectadoQ1]) as ProyectadoQ1, " & _
                    "SUM(a.[ProyectadoQ2]) as ProyectadoQ2, " & _
                    "SUM(a.[ProyectadoQ3]) as ProyectadoQ3, " & _
                    "SUM(a.[ProyectadoQ4]) as ProyectadoQ4, " & _
                    "SUM(a.[EjecutadoQ1]) as EjecutadoQ1, " & _
                    "SUM(a.[EjecutadoQ2]) as EjecutadoQ2, " & _
                    "SUM(a.[EjecutadoQ3]) as EjecutadoQ3, " & _
                    "SUM(a.[EjecutadoQ4]) as EjecutadoQ4, " & _
                    "(COALESCE(SUM(a.EjecutadoQ1)/ NULLIF(SUM(a.ProyectadoQ1),0),0)) As P1, " & _
                    "(COALESCE(SUM(a.EjecutadoQ2)/ NULLIF(SUM(a.ProyectadoQ2),0),0)) As P2, " & _
                    "(COALESCE(SUM(a.EjecutadoQ3)/ NULLIF(SUM(a.ProyectadoQ3),0),0)) As P3, " & _
                    "(COALESCE(SUM(a.EjecutadoQ4)/ NULLIF(SUM(a.ProyectadoQ4),0),0)) As P4, " & _
                    "(SUM(a.ProyectadoQ1+a.ProyectadoQ2)) As PA, " & _
                    "(SUM(a.[EjecutadoQ1]+a.[EjecutadoQ2])) As EA, " & _
                    "(COALESCE((SUM(a.[EjecutadoQ1]+a.[EjecutadoQ2]))/ NULLIF((SUM(a.ProyectadoQ1+a.ProyectadoQ2)),0),0)) As PAA  " & _
                    "FROM " & _
                    "[MetaYMonitoreoPorPeriodo] a " & _
                    "join [IndicadoresPorPrograma] b on b.IdIndicadoresPorPrograma= a.IdIndicadorPorPrograma  " & _
                    "join [Indicadores] c on b.IdIndicador= c.IdIndicador " & _
                    "join [TiposDeIndicador] d on c.IdTipoDeIndicador=d.IdTipoDeIndicador " & _
                    "where " & _
                    "b.IdPrograma = 133 And a.Ano = 2013 And c.IdTipoDeIndicador = 1 And a.Activo = 1 And b.Activo = 1 And c.Activo = 1 and (a.ProyectadoQ1 <> 0 Or a.ProyectadoQ2 <> 0 OR a.ProyectadoQ3 <> 0 OR a.ProyectadoQ4 <> 0) " & _
                    "GROUP BY c.IdIndicador,c.DescripcionIndicador"

        Else

            SqlMetaMonitoreo.SelectCommand = "SELECT c.DescripcionIndicador, " & _
                "SUM(a.[ProyectadoQ1]) as ProyectadoQ1, SUM(a.[ProyectadoQ2]) as ProyectadoQ2, SUM(a.[ProyectadoQ3]) as ProyectadoQ3,  SUM(a.[ProyectadoQ4]) as ProyectadoQ4, " & _
                "SUM(a.[EjecutadoQ1]) as EjecutadoQ1, SUM(a.[EjecutadoQ2]) as EjecutadoQ2, SUM(a.[EjecutadoQ3]) as EjecutadoQ3, SUM(a.[EjecutadoQ4]) as EjecutadoQ4, " & _
                "(COALESCE(SUM(a.EjecutadoQ1)/ NULLIF(SUM(a.ProyectadoQ1),0),0)) As P1, " & _
                "(COALESCE(SUM(a.EjecutadoQ2)/ NULLIF(SUM(a.ProyectadoQ2),0),0)) As P2, " & _
                "(COALESCE(SUM(a.EjecutadoQ3)/ NULLIF(SUM(a.ProyectadoQ3),0),0)) As P3, " & _
                "(COALESCE(SUM(a.EjecutadoQ4)/ NULLIF(SUM(a.ProyectadoQ4),0),0)) As P4, " & _
                "(SUM(a.ProyectadoQ1+a.ProyectadoQ2+a.ProyectadoQ3+a.ProyectadoQ4)) As PA, " & _
                "(SUM(a.[EjecutadoQ1]+a.[EjecutadoQ2]+a.[EjecutadoQ3]+a.[EjecutadoQ4])) As EA," & _
                "(COALESCE((SUM(a.[EjecutadoQ1]+a.[EjecutadoQ2]+a.[EjecutadoQ3]+a.[EjecutadoQ4]))/ NULLIF((SUM(a.ProyectadoQ1+a.ProyectadoQ2+a.ProyectadoQ3+a.ProyectadoQ4)),0),0)) As PAA " & _
                "FROM [MetaYMonitoreoPorPeriodo] a " & _
                "join [IndicadoresPorPrograma] b on b.IdIndicadoresPorPrograma= a.IdIndicadorPorPrograma " & _
                "join [Indicadores] c on b.IdIndicador= c.IdIndicador " & _
                "join [TiposDeIndicador] d on c.IdTipoDeIndicador=d.IdTipoDeIndicador " & _
                "where b.IdPrograma = @Programa And a.Ano = @Year And c.IdTipoDeIndicador = 1 And a.Activo=1 And b.Activo=1 and c.Activo=1 and a.IdAreaDeInfluencia=@Area and (a.ProyectadoQ1 <> 0 Or a.ProyectadoQ2 <> 0 OR a.ProyectadoQ3 <> 0 OR a.ProyectadoQ4 <> 0) " & _
                "GROUP BY c.IdIndicador, c.DescripcionIndicador"
        End If


        SqlMetaMonitoreo.SelectParameters(0).DefaultValue = Session("CodPrograma")
        SqlMetaMonitoreo.SelectParameters(1).DefaultValue = cmbAno.Text
        SqlMetaMonitoreo.SelectParameters(2).DefaultValue = cmbArea.Value

        SqlMetaMonitoreo.DataBind()
        GridIndicadores.DataBind()
        gridExport.WriteXlsToResponse()
    End Sub



    Protected Sub GridComentarios_BeforePerformDataSelect(sender As Object, e As EventArgs)
        Session("IdPreguntaDeMonitoreo") = CType(sender, ASPxGridView).GetMasterRowKeyValue()

        Me.SqlComentarios.SelectParameters(0).DefaultValue = Session("IdPreguntaDeMonitoreo")

        Me.SqlComentarios.InsertParameters(1).DefaultValue = Session("IdPreguntaDeMonitoreo")
        Me.SqlComentarios.InsertParameters(2).DefaultValue = Membership.GetUser.UserName


        Me.SqlComentarios.UpdateParameters(0).DefaultValue = Membership.GetUser.UserName


    End Sub

    Protected Sub GridIndicadores_Load(sender As Object, e As EventArgs)

        SqlMetaMonitoreo.SelectParameters(0).DefaultValue = Session("CodPrograma")
        SqlMetaMonitoreo.SelectParameters(1).DefaultValue = cmbAno.Text
        SqlMetaMonitoreo.SelectParameters(2).DefaultValue = cmbArea.Value

        SqlMetaMonitoreo.DataBind()
        GridIndicadores.DataBind()

    End Sub

    Protected Sub GridPreguntaRespuesta_Load(sender As Object, e As EventArgs)
        SqlPreguntaRespuesta.SelectParameters(0).DefaultValue = Session("CodPrograma")

        SqlPreguntaRespuesta.DataBind()
        GridPreguntaRespuesta.DataBind()
    End Sub

    Protected Sub GridPresupuesto_Load(sender As Object, e As EventArgs)
        SqlPresupuestoMeta.SelectParameters(0).DefaultValue = Session("CodPrograma")
        SqlPresupuestoMeta.SelectParameters(1).DefaultValue = cmbAnoP.Text

        SqlPresupuestoMeta.DataBind()
        GridPresupuesto.DataBind()
    End Sub

    Protected Sub GridIndicadoresI_Load(sender As Object, e As EventArgs)
        SqlMetaIndicadores.SelectParameters(0).DefaultValue = Session("CodPrograma")
        SqlMetaIndicadores.SelectParameters(1).DefaultValue = cmbAnoI.Text
        SqlMetaIndicadores.DataBind()
        GridIndicadoresI.DataBind()
    End Sub

    Protected Function IsGridOpcionesVisible2(ByVal IdPreguntaDeMonitoreo As Object) As Boolean
        Session("TipoP") = GridPreguntaRespuesta.GetRowValuesByKeyValue(IdPreguntaDeMonitoreo, "IdTipoDePregunta")
        Return True
    End Function

    Protected Function IsGridOpcionesVisible3(ByVal IdPreguntaDeMonitoreo As Object) As Boolean
        Dim Tipo As Integer = Session("TipoP")

        Return (3 = Tipo Or 4 = Tipo)

    End Function


    Protected Sub GridEjecutadoPresupuesto_BeforePerformDataSelect(sender As Object, e As EventArgs)


        SqlDataSource2.SelectParameters(0).DefaultValue = Session("CodPrograma")
        SqlDataSource2.SelectParameters(1).DefaultValue = cmbAnoP.Text

        SqlDataSource2.DataBind()

    End Sub

    Protected Sub GridDetalleIndicadorcobertura_BeforePerformDataSelect(sender As Object, e As EventArgs)
        Session("DescripcionC") = CType(sender, ASPxGridView).GetMasterRowKeyValue()

        SqlDataSource3.SelectParameters(0).DefaultValue = Session("CodPrograma")
        SqlDataSource3.SelectParameters(1).DefaultValue = cmbAnoC.Text
        SqlDataSource3.SelectParameters(2).DefaultValue = Session("DescripcionC")
        SqlDataSource3.DataBind()
    End Sub

    Protected Sub GridCobertura_Load1(sender As Object, e As EventArgs)
        SqlCobertura.SelectParameters(0).DefaultValue = Session("CodPrograma")

        SqlCobertura.SelectParameters(1).DefaultValue = cmbAnoC.Text

        SqlCobertura.DataBind()
        GridCobertura.DataBind()
    End Sub

    Protected Sub GridDetalleIndicadorcobertura_Load(sender As Object, e As EventArgs)
        SqlDataSource3.SelectParameters(0).DefaultValue = Session("CodPrograma")
        SqlDataSource3.SelectParameters(1).DefaultValue = cmbAnoC.Text
        SqlDataSource3.SelectParameters(2).DefaultValue = Session("DescripcionC")
        SqlDataSource3.DataBind()

    End Sub

    Protected Sub ASPxGridViewUbicacionAreaDeInfluencia_BeforePerformDataSelect(sender As Object, e As EventArgs)
        Session("IdAreaDeInfluencia") = CType(sender, ASPxGridView).GetMasterRowKeyValue()
        SqlDataSourceUbicacionArea.SelectParameters(0).DefaultValue = Session("IdAreaDeInfluencia")
        SqlDataSourceUbicacionArea.DataBind()

    End Sub

    Protected Sub cmbAnoI_Callback(sender As Object, e As CallbackEventArgsBase)
        cmbAnoI.Text = " "
    End Sub

    Protected Sub cmbAno_Callback(sender As Object, e As CallbackEventArgsBase)
        cmbAno.Text = " "
    End Sub
End Class
