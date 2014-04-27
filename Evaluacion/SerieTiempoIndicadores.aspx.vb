Imports Microsoft.VisualBasic
Imports System
Imports DevExpress.XtraCharts
Imports DevExpress.XtraCharts.Web
Imports System.Windows.Forms

Partial Class Reportes_SerieTiempoIndicadores
    Inherits System.Web.UI.Page

    Protected Sub Page_Init(sender As Object, e As EventArgs) Handles Me.Init
        Session("Programa") = Nothing
    End Sub



    Protected Sub Page_Load(sender As Object, e As EventArgs) Handles Me.Load
        'Verifica si el usuario tiene el acceso a la pagina solicitada
        Using dtMOCA As System.Data.DataTable = fMOCA.CheckPageAccess(4.06) 'este es el Id definido en el MOCA
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



            Me.SqlDataSourceProyectos.SelectCommand = _
                 "select " & _
                 "	distinct(Pro.codigo_ficha), " & _
                 "	Pol.IdPolitica, " & _
                 "	Pol.Nombre, " & _
                 "	Pro.NombreProyecto, " & _
                 "	Pro.codigo_proyecto " & _
                 "from " & _
                 "	Politicas Pol " & _
                 "	join ComponentesDePolitica CP on Pol.IdPolitica=CP.IdPolitica AND Pol.Activo = 1 " & _
                 "	join MetasDeComponente MC on CP.IdComponentesDePolitica=MC.IdComponentesDePolitica " & _
                 "	join IndicadoresDeMeta IM on MC.IdMetasDeComponente=IM.IdMetasDeComponente " & _
                 "	join ProgramasPorIndicadorDeMeta PIM on IM.IdIndicadorDeMeta=PIM.IdIndicadorDeMeta " & _
                 "	join vProyectos Pro ON PIM.IdPrograma=Pro.codigo_ficha " & _
                 "where " & _
                 "	Pro.codigo_ficha in " & _
                 "		(select distinct(IdPrograma) from InstrumentosDeEvaluacion where Activo=1) "
            Me.SqlDataSourceIndicadoresPrograma.SelectCommand = _
                "select " & _
                "	IEP.IdIndicadoresEvaluacionPorPrograma, " & _
                "	IEP.IdIndicador, " & _
                "	I.DescripcionIndicador, " & _
                "	IEP.IdPrograma " & _
                "from  " & _
                "	IndicadoresEvaluacionPorPrograma IEP " & _
                "	join Indicadores I on IEP.IdIndicador=I.IdIndicador and I.Activo=1 " & _
                "where " & _
                "	IEP.Activo = 1 and " & _
                "   IEP.IdPrograma=@IdPrograma"
            Me.SqlDataSourceIndicadores.SelectCommand = _
                "select " & _
                "	I.DescripcionIndicador, " & _
                "	AI.FechaAplicacion, " & _
                "	MA.DescripcionMomento, " & _
                "	VIPL.ValorIndicador, " & _
                "	IEPP.IdPrograma " & _
                "from " & _
                "	ValoresIndicadorPorLevantamiento VIPL " & _
                "	join AplicacionInstrumento AI on VIPL.IdAplicacionInstrumento=AI.IdAplicacionInstrumento and AI.Activo=1 " & _
                "	join IndicadoresEvaluacionPorPrograma IEPP on VIPL.IdIndicadoresEvaluacionPorPrograma=IEPP.IdIndicadoresEvaluacionPorPrograma " & _
                "	join Indicadores I on IEPP.IdIndicador = I.IdIndicador and I.Activo=1 " & _
                "	join MomentosDeAplicacion MA on AI.IdMomentoAplicacion = MA.IdMomentoDeAplicacion " & _
                "where " & _
                "	VIPL.IndicadorCalculado = 1 and " & _
                "   IEPP.IdPrograma=@IdPrograma and " & _
                "   I.IdIndicador=@IdIndicador"
        End Using

    End Sub

    Protected Sub linkElegirP_Click(sender As Object, e As EventArgs)
        Session("IdPrograma") = ASPxGridViewProyectos.GetRowValues(ASPxGridViewProyectos.FocusedRowIndex, "codigo_ficha")
        SqlDataSourceIndicadoresPrograma.SelectParameters(0).DefaultValue = CInt(ASPxGridViewProyectos.GetRowValues(ASPxGridViewProyectos.FocusedRowIndex, "codigo_ficha"))
        ASPxGridViewIndicadoresPrograma.DataBind()
    End Sub

    Protected Sub linkElegirI_Click(sender As Object, e As EventArgs)
        Session("IdIndicador") = ASPxGridViewIndicadoresPrograma.GetRowValues(ASPxGridViewIndicadoresPrograma.FocusedRowIndex, "IdIndicador")


        SqlDataSourceIndicadores.SelectParameters(0).DefaultValue = Session("IdPrograma")
        SqlDataSourceIndicadores.SelectParameters(1).DefaultValue = Session("IdIndicador")
        SqlDataSourceIndicadores.DataBind()
        ChartData.DataBind()

        Dim DataSeries As New Series(ASPxGridViewIndicadoresPrograma.GetRowValues(ASPxGridViewIndicadoresPrograma.FocusedRowIndex, "DescripcionIndicador"), ViewType.Point)
        For i As Integer = 0 To ChartData.VisibleRowCount - 1
            DataSeries.Points.Add(New SeriesPoint(ChartData.GetRowValues(i, "DescripcionMomento"), ChartData.GetRowValues(i, "ValorIndicador")))

        Next
        WebChartControlIndicadores.Series.Add(DataSeries)

    End Sub

    Protected Sub CmdClearSeries_Click(sender As Object, e As EventArgs)
        WebChartControlIndicadores.Series.Clear()
    End Sub
End Class
