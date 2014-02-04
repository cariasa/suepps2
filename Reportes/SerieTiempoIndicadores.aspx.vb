Imports Microsoft.VisualBasic
Imports System
Imports DevExpress.XtraCharts
Imports DevExpress.XtraCharts.Web
Imports System.Windows.Forms

Partial Class Reportes_SerieTiempoIndicadores
    Inherits System.Web.UI.Page



    Protected Sub Page_Load(sender As Object, e As EventArgs) Handles Me.Load


       

    End Sub

    Protected Sub linkElegirP_Click(sender As Object, e As EventArgs)
        Session("IdPrograma") = ASPxGridViewProyectos.GetRowValues(ASPxGridViewProyectos.FocusedRowIndex, "codigo_ficha")

        SqlDataSourceIndicadoresPrograma.SelectParameters(0).DefaultValue = CInt(ASPxGridViewProyectos.GetRowValues(ASPxGridViewProyectos.FocusedRowIndex, "codigo_ficha"))

        ASPxGridViewIndicadoresPrograma.DataBind()
    End Sub

    Protected Sub linkElegirI_Click(sender As Object, e As EventArgs)
        'MessageBox.Show(ASPxGridViewIndicadoresPrograma.GetRowValues(ASPxGridViewIndicadoresPrograma.FocusedRowIndex, "IdIndicador").ToString)
        AccessDataSource1.SelectCommand = "SELECT c.IdIndicador, c.DescripcionIndicador, a.Ano, (COALESCE((SUM(a.[EjecutadoQ1]+a.[EjecutadoQ2]+a.[EjecutadoQ3]+a.[EjecutadoQ4]))/ NULLIF((SUM(a.ProyectadoQ1+a.ProyectadoQ2+a.ProyectadoQ3+a.ProyectadoQ4)),0),0))*100 As PAA FROM [MetaYMonitoreoPorPeriodo] a join [IndicadoresPorPrograma] b on b.IdIndicadoresPorPrograma= a.IdIndicadorPorPrograma join [Indicadores] c on b.IdIndicador= c.IdIndicador join [TiposDeIndicador] d on c.IdTipoDeIndicador=d.IdTipoDeIndicador where b.IdPrograma = @IdPrograma And c.IdIndicador = @IdIndicador And c.IdTipoDeIndicador = 1 And a.Activo=1 And b.Activo=1 and c.Activo=1 and (a.ProyectadoQ1 <> 0 Or a.ProyectadoQ2 <> 0 OR a.ProyectadoQ3 <> 0 OR a.ProyectadoQ4 <> 0) GROUP BY c.IdIndicador,c.DescripcionIndicador, a.Ano"
        AccessDataSource1.SelectParameters(0).DefaultValue = CInt(ASPxGridViewIndicadoresPrograma.GetRowValues(ASPxGridViewIndicadoresPrograma.FocusedRowIndex, "IdIndicador"))
        AccessDataSource1.SelectParameters(1).DefaultValue = Session("IdPrograma")

        SqlDataSourceIndicadores.SelectParameters(1).DefaultValue = CInt(ASPxGridViewIndicadoresPrograma.GetRowValues(ASPxGridViewIndicadoresPrograma.FocusedRowIndex, "IdIndicador"))
        SqlDataSourceIndicadores.SelectParameters(0).DefaultValue = Session("IdPrograma")
        SqlDataSourceIndicadores.DataBind()
        ASPxGridViewIndicadores.DataBind()

        AccessDataSource1.DataBind()


        WebChartControlIndicadores.Series.Clear()

        Dim series1 As New Series(ASPxGridViewIndicadoresPrograma.GetRowValues(ASPxGridViewIndicadoresPrograma.FocusedRowIndex, "DescripcionIndicador"), ViewType.Point)


        For i As Integer = 0 To ASPxGridViewIndicadores.VisibleRowCount - 1
            series1.Points.Add(New SeriesPoint(ASPxGridViewIndicadores.GetRowValues(i, "Ano"), ASPxGridViewIndicadores.GetRowValues(i, "PAA")))

        Next
        WebChartControlIndicadores.Series.Add(series1)
    End Sub
End Class
