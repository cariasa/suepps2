Imports DevExpress.XtraCharts
Imports System.Windows.Forms
Imports DevExpress.Web.ASPxClasses
Imports DevExpress.Web.ASPxGauges
Imports DevExpress.Web.ASPxGauges.Base
Imports DevExpress.Web.ASPxGauges.Gauges.Circular
Imports DevExpress.XtraGauges.Core.Model
Imports DevExpress.XtraGauges.Core.Drawing
Imports System.Drawing
Imports DevExpress.XtraGauges.Base
Imports DevExpress.XtraCharts.Web
Imports DevExpress.XtraCharts.Native
Imports DevExpress.Web.ASPxGridView
Imports System.ComponentModel

Partial Class Reportes_ReportePoliticas
    Inherits System.Web.UI.Page

    Protected Sub Page_Init(sender As Object, e As EventArgs) Handles Me.Init
        ASPxComboBoxPeriodo.Items.Add("Trimestral", 0)
        ASPxComboBoxPeriodo.Items.Add("Semestral", 1)
        ASPxComboBoxPeriodo.Items.Add("Anual", 2)

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



    Protected Sub Page_Load(sender As Object, e As EventArgs) Handles Me.Load
        'Verifica si el usuario tiene el acceso a la pagina solicitada
        Using dtMOCA As System.Data.DataTable = fMOCA.CheckPageAccess(4.02) 'este es el Id definido en el MOCA
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
        Session("Ano") = ASPxComboBoxAno.Value



        SqlDataSourcePoliticas.SelectCommand = "SELECT " & _
        "PP.IdPolitica as IdPolitica, " & _
        "Nombre as NombrePolitica, " & _
        "SujetosDeAtencion, " & _
        "SUM(PesoComponente/100*PorcentajeEjecucionQ1) as PorcentajeEjecucionQ1, " & _
        "SUM(PesoComponente/100*PorcentajeEjecucionQ2) as PorcentajeEjecucionQ2, " & _
        "SUM(PesoComponente/100*PorcentajeEjecucionQ3) as PorcentajeEjecucionQ3, " & _
        "SUM(PesoComponente/100*PorcentajeEjecucionQ4) as PorcentajeEjecucionQ4, " & _
        "SUM(PesoComponente/100*PorcentajeEjecucion) as PorcentajeEjecucion " & _
        "FROM " & _
        "Politicas PP " & _
        "Join " & _
        "( " & _
        "SELECT " & _
            "IdPolitica, " & _
            "CDP.IdComponentesDePolitica, " & _
            "Peso as PesoComponente, " & _
            "Nombre as Componente, " & _
            "Descripcion as DescripcionComponente, " & _
            "SUM(PesoMeta/100*PorcentajeEjecucionQ1) as PorcentajeEjecucionQ1, " & _
            "SUM(PesoMeta/100*PorcentajeEjecucionQ2) as PorcentajeEjecucionQ2, " & _
            "SUM(PesoMeta/100*PorcentajeEjecucionQ3) as PorcentajeEjecucionQ3, " & _
            "SUM(PesoMeta/100*PorcentajeEjecucionQ4) as PorcentajeEjecucionQ4, " & _
            "SUM(PesoMeta/100*PorcentajeEjecucion) as PorcentajeEjecucion " & _
            "FROM " & _
            "ComponentesDePolitica CDP " & _
            "Join " & _
            "( " & _
                "SELECT " & _
                    "IdComponentesDePolitica, " & _
                    "MDC.IdMetasDeComponente, " & _
                    "Nombre as Meta, " & _
                    "Descripcion as DescripcionMeta, " & _
                    "Peso as PesoMeta, " & _
                    "SUM(PesoIndicadorMeta/100*PorcentajeEjecucionQ1) as PorcentajeEjecucionQ1, " & _
                    "SUM(PesoIndicadorMeta/100*PorcentajeEjecucionQ2) as PorcentajeEjecucionQ2, " & _
                    "SUM(PesoIndicadorMeta/100*PorcentajeEjecucionQ3) as PorcentajeEjecucionQ3, " & _
                    "SUM(PesoIndicadorMeta/100*PorcentajeEjecucionQ4) as PorcentajeEjecucionQ4, " & _
                    "SUM(PesoIndicadorMeta/100*PorcentajeEjecucion) as PorcentajeEjecucion " & _
                "FROM " & _
                    "MetasDeComponente MDC " & _
                    "Join " & _
                    "(SELECT " & _
                        "IdMetasDeComponente, " & _
                        "IDM.IdIndicadorDeMeta, " & _
                        "Peso as PesoIndicadorMeta, " & _
                        "I.DescripcionIndicador, " & _
                        "SUM(PesoPrograma/100*PorcentajeEjecucionQ1) as PorcentajeEjecucionQ1, " & _
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
                            "FROM " & _
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
                                            "WHERE " & _
                                                "Indicadores.Activo = 1 " & _
                                                "AND IndicadoresPorPrograma.Activo = 1) as IPP " & _
                                            "ON IPP.IdIndicadoresPorPrograma=IRDP.IdIndicadoresPorPrograma " & _
                                        "JOIN MetaYMonitoreoPorPeriodo MMPP ON MMPP.IdIndicadorPorPrograma=IPP.IdIndicadoresPorPrograma " & _
                                        "JOIN AreasDeInfluencia ADI ON ADI.IdAreaDeInfluencia=MMPP.IdAreaDeInfluencia " & _
                                    "WHERE " & _
                                        "IRDP.Activo = 1 " & _
                                        "AND MMPP.Activo = 1 " & _
                                        "AND Peso <> 0 " & _
                                        "AND Ano = @Ano " & _
                                        "AND MMPP.ProyectadoQ1<>0 AND MMPP.ProyectadoQ2<>0 AND MMPP.ProyectadoQ3<>0 AND MMPP.ProyectadoQ4<>0 " & _
                                    "GROUP BY " & _
                                        "IRDP.IdProgramaPorIndicadorDeMeta, " & _
                                        "IRDP.IdIndicadoresRelevantesDePrograma, " & _
                                        "IPP.IdIndicadoresPorPrograma, " & _
                                        "IPP.DescripcionIndicador, " & _
                                        "IPP.NombreProyecto, " & _
                                        "IRDP.Peso) as EPI " & _
                                "ON EPI.IdProgramaPorIndicadorDeMeta = PPIM.IdProgramasPorIndicadorDeMeta " & _
                            "WHERE " & _
                                "Activo = 1 " & _
                            "GROUP BY " & _
                                "IdIndicadorDeMeta, " & _
                                "IdProgramasPorIndicadorDeMeta, " & _
                                "Peso) as EPP " & _
                            "ON EPP.IdIndicadorDeMeta = IDM.IdIndicadorDeMeta " & _
                        "WHERE " & _
                             "IDM.Activo = 1 " & _
                        "GROUP BY " & _
                            "IdMetasDeComponente, " & _
                            "IDM.IdIndicadorDeMeta, " & _
                            "Peso, " & _
                            "I.DescripcionIndicador) as EPIM " & _
                    "ON EPIM.IdMetasDeComponente = MDC.IdMetasDeComponente " & _
                "WHERE " & _
                    "Activo = 1 " & _
                "GROUP BY " & _
                    "IdComponentesDePolitica, " & _
                    "MDC.IdMetasDeComponente, " & _
                    "Nombre , " & _
                    "Descripcion , " & _
                    "Peso ) as EPM " & _
            "ON EPM.IdComponentesDePolitica = CDP.IdComponentesDePolitica " & _
        "WHERE " & _
            "Activo = 1 " & _
        "GROUP BY " & _
            "IdPolitica, " & _
            "CDP.IdComponentesDePolitica, " & _
            "Peso, " & _
            "Nombre, " & _
            "Descripcion) as EPC " & _
    "ON EPC.IdPolitica = PP.IdPolitica " & _
"WHERE " & _
     "PP.Activo = 1 " & _
"GROUP BY " & _
    "Nombre, " & _
    "SujetosDeAtencion, " & _
    "PP.IdPolitica "

        SqlDataSourceComponente.SelectCommand = "SELECT " & _
        "IdPolitica, " & _
        "CDP.IdComponentesDePolitica, " & _
        "Peso as PesoComponente, " & _
        "Nombre as Componente, " & _
        "Descripcion as DescripcionComponente, " & _
        "SUM(PesoMeta/100*PorcentajeEjecucionQ1) as PorcentajeEjecucionQ1, " & _
        "SUM(PesoMeta/100*PorcentajeEjecucionQ2) as PorcentajeEjecucionQ2, " & _
        "SUM(PesoMeta/100*PorcentajeEjecucionQ3) as PorcentajeEjecucionQ3, " & _
        "SUM(PesoMeta/100*PorcentajeEjecucionQ4) as PorcentajeEjecucionQ4, " & _
        "SUM(PesoMeta/100*PorcentajeEjecucion) as PorcentajeEjecucion " & _
        "FROM " & _
            "ComponentesDePolitica CDP " & _
        "Join " & _
        "(SELECT " & _
            "IdComponentesDePolitica, " & _
            "MDC.IdMetasDeComponente, " & _
            "Nombre as Meta, " & _
            "Descripcion as DescripcionMeta, " & _
            "Peso as PesoMeta, " & _
            "SUM(PesoIndicadorMeta/100*PorcentajeEjecucionQ1) as PorcentajeEjecucionQ1, " & _
            "SUM(PesoIndicadorMeta/100*PorcentajeEjecucionQ2) as PorcentajeEjecucionQ2, " & _
            "SUM(PesoIndicadorMeta/100*PorcentajeEjecucionQ3) as PorcentajeEjecucionQ3, " & _
            "SUM(PesoIndicadorMeta/100*PorcentajeEjecucionQ4) as PorcentajeEjecucionQ4, " & _
            "SUM(PesoIndicadorMeta/100*PorcentajeEjecucion) as PorcentajeEjecucion " & _
        "FROM " & _
        "MetasDeComponente MDC " & _
        "Join " & _
            "(SELECT " & _
                "IdMetasDeComponente, " & _
                "IDM.IdIndicadorDeMeta, " & _
                "Peso as PesoIndicadorMeta, " & _
                "I.DescripcionIndicador, " & _
                "SUM(PesoPrograma/100*PorcentajeEjecucionQ1) as PorcentajeEjecucionQ1, " & _
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
        "FROM " & _
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
        "AND Indicadores.Activo = 1) as IPP " & _
        "ON IPP.IdIndicadoresPorPrograma=IRDP.IdIndicadoresPorPrograma " & _
        "JOIN MetaYMonitoreoPorPeriodo MMPP ON MMPP.IdIndicadorPorPrograma=IPP.IdIndicadoresPorPrograma " & _
        "JOIN AreasDeInfluencia ADI ON ADI.IdAreaDeInfluencia=MMPP.IdAreaDeInfluencia " & _
        "WHERE " & _
            "IRDP.Activo = 1 " & _
            "AND MMPP.Activo = 1 " & _
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
        "PPIM.Activo = 1 " & _
        "Group BY " & _
            "IdIndicadorDeMeta, " & _
            "IdProgramasPorIndicadorDeMeta, " & _
            "Peso) as EPP " & _
            "ON EPP.IdIndicadorDeMeta = IDM.IdIndicadorDeMeta " & _
        "WHERE " & _
        "IDM.Activo = 1 " & _
        "Group BY " & _
                    "IdMetasDeComponente, " & _
                    "IDM.IdIndicadorDeMeta, " & _
                    "Peso, " & _
                    "I.DescripcionIndicador) as EPIM " & _
            "ON EPIM.IdMetasDeComponente = MDC.IdMetasDeComponente " & _
        "WHERE " & _
        "MDC.Activo = 1 " & _
        "Group BY " & _
            "IdComponentesDePolitica, " & _
            "MDC.IdMetasDeComponente, " & _
            "Nombre , " & _
            "Descripcion , " & _
            "Peso ) as EPM " & _
    "ON EPM.IdComponentesDePolitica = CDP.IdComponentesDePolitica " & _
    "WHERE " & _
        "CDP.Activo = 1 " & _
        "AND IdPolitica=@IdPolitica " & _
    "Group BY " & _
    "IdPolitica, " & _
    "CDP.IdComponentesDePolitica, " & _
    "Peso, " & _
    "Nombre, " & _
    "Descripcion"

        SqlDataSourceMetas.SelectCommand = "SELECT " & _
        "IdComponentesDePolitica, " & _
        "MDC.IdMetasDeComponente, " & _
        "Nombre as Meta, " & _
        "Descripcion as DescripcionMeta, " & _
        "Peso as PesoMeta, " & _
        "SUM(PesoIndicadorMeta/100*PorcentajeEjecucionQ1) as PorcentajeEjecucionQ1, " & _
        "SUM(PesoIndicadorMeta/100*PorcentajeEjecucionQ2) as PorcentajeEjecucionQ2, " & _
        "SUM(PesoIndicadorMeta/100*PorcentajeEjecucionQ3) as PorcentajeEjecucionQ3, " & _
        "SUM(PesoIndicadorMeta/100*PorcentajeEjecucionQ4) as PorcentajeEjecucionQ4, " & _
        "SUM(PesoIndicadorMeta/100*PorcentajeEjecucion) as PorcentajeEjecucion " & _
        "From " & _
        "MetasDeComponente MDC " & _
        "Join " & _
        "(SELECT " & _
        "IdMetasDeComponente, " & _
        "IDM.IdIndicadorDeMeta, " & _
        "Peso as PesoIndicadorMeta, " & _
        "I.DescripcionIndicador, " & _
        "SUM(PesoPrograma/100*PorcentajeEjecucionQ1) as PorcentajeEjecucionQ1, " & _
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
        "FROM " & _
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
        "AND Indicadores.Activo = 1) as IPP " & _
        "ON IPP.IdIndicadoresPorPrograma=IRDP.IdIndicadoresPorPrograma " & _
                        "JOIN MetaYMonitoreoPorPeriodo MMPP ON MMPP.IdIndicadorPorPrograma=IPP.IdIndicadoresPorPrograma " & _
                        "JOIN AreasDeInfluencia ADI ON ADI.IdAreaDeInfluencia=MMPP.IdAreaDeInfluencia " & _
        "WHERE " & _
        "IRDP.Activo = 1 " & _
                        "AND MMPP.Activo = 1 " & _
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
        "PPIM.Activo = 1 " & _
        "Group BY " & _
                    "IdIndicadorDeMeta, " & _
                    "IdProgramasPorIndicadorDeMeta, " & _
                    "Peso) as EPP " & _
            "ON EPP.IdIndicadorDeMeta = IDM.IdIndicadorDeMeta " & _
        "WHERE " & _
        "IDM.Activo = 1 " & _
        "Group BY " & _
            "IdMetasDeComponente, " & _
            "IDM.IdIndicadorDeMeta, " & _
            "Peso, " & _
            "I.DescripcionIndicador) as EPIM " & _
    "ON EPIM.IdMetasDeComponente = MDC.IdMetasDeComponente " & _
        "WHERE " & _
        "Activo = 1 " & _
    "AND IdComponentesDePolitica = @IdComponentesDePolitica " & _
        "Group BY " & _
    "IdComponentesDePolitica, " & _
    "MDC.IdMetasDeComponente, " & _
    "Nombre , " & _
    "Descripcion , " & _
    "Peso "

        SqlDataSourceIndicadoresMetas.SelectCommand = "SELECT " & _
        "IdMetasDeComponente, " & _
        "IDM.IdIndicadorDeMeta, " & _
        "Peso as PesoIndicadorMeta, " & _
        "I.DescripcionIndicador, " & _
        "SUM(PesoPrograma/100*PorcentajeEjecucionQ1) as PorcentajeEjecucionQ1, " & _
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
        "FROM " & _
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
                "AND MMPP.Activo = 1 " & _
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
        "Group BY " & _
    "IdMetasDeComponente, " & _
    "IDM.IdIndicadorDeMeta, " & _
    "Peso, " & _
    "I.DescripcionIndicador "


        SqlDataSourceProgramasIndicadoresMetas.SelectCommand = "SELECT " & _
        "IdIndicadorDeMeta, " & _
        "IdProgramasPorIndicadorDeMeta, " & _
        "Peso as PesoPrograma, " & _
        "vProyectos.codigo_ficha as IdProyecto, " & _
        "vProyectos.NombreProyecto as NombreProyecto, " & _
        "SUM(PesoIndicadorPrograma/100*PorcentajeEjecucionQ1) as PorcentajeEjecucionQ1, " & _
        "SUM(PesoIndicadorPrograma/100*PorcentajeEjecucionQ2) as PorcentajeEjecucionQ2, " & _
        "SUM(PesoIndicadorPrograma/100*PorcentajeEjecucionQ3) as PorcentajeEjecucionQ3, " & _
        "SUM(PesoIndicadorPrograma/100*PorcentajeEjecucionQ4) as PorcentajeEjecucionQ4, " & _
        "SUM(PesoIndicadorPrograma/100*PorcentajeEjecucion) as PorcentajeEjecucion " & _
        "FROM " & _
        "ProgramasPorIndicadorDeMeta PPIM " & _
        "JOIN vProyectos on vProyectos.codigo_ficha = PPIM.IdPrograma " & _
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
                    "AND Indicadores.Activo = 1) as IPP " & _
                "ON IPP.IdIndicadoresPorPrograma=IRDP.IdIndicadoresPorPrograma " & _
            "JOIN MetaYMonitoreoPorPeriodo MMPP ON MMPP.IdIndicadorPorPrograma=IPP.IdIndicadoresPorPrograma " & _
            "JOIN AreasDeInfluencia ADI ON ADI.IdAreaDeInfluencia=MMPP.IdAreaDeInfluencia " & _
        "WHERE " & _
        "IRDP.Activo = 1 " & _
            "AND MMPP.Activo = 1 " & _
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
        "AND IdIndicadorDeMeta = @IdIndicadorDeMeta " & _
        "Group BY " & _
        "IdIndicadorDeMeta, " & _
        "IdProgramasPorIndicadorDeMeta, " & _
        "Peso, " & _
        "vProyectos.NombreProyecto, " & _
        "vProyectos.codigo_ficha "

        SqlDataSourceIndicadoresRelevantes.SelectCommand = "SELECT " & _
        "IRDP.IdProgramaPorIndicadorDeMeta, " & _
        "IRDP.IdIndicadoresRelevantesDePrograma, " & _
        "IPP.IdIndicadoresPorPrograma, " & _
        "IPP.DescripcionIndicador, " & _
        "IPP.NombreProyecto, " & _
        "IPP.IdPrograma, " & _
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
        "IndicadoresPorPrograma " &
            "join Indicadores ON Indicadores.IdIndicador = IndicadoresPorPrograma.IdIndicador " & _
            "join vProyectos  ON vProyectos.codigo_ficha = IndicadoresPorPrograma.IdPrograma " & _
        "where " & _
        "IndicadoresPorPrograma.Activo = 1 " & _
            "AND Indicadores.Activo = 1) as IPP " & _
        "ON IPP.IdIndicadoresPorPrograma=IRDP.IdIndicadoresPorPrograma " & _
    "JOIN MetaYMonitoreoPorPeriodo MMPP ON MMPP.IdIndicadorPorPrograma=IPP.IdIndicadoresPorPrograma " & _
    "JOIN AreasDeInfluencia ADI ON ADI.IdAreaDeInfluencia=MMPP.IdAreaDeInfluencia " & _
        "WHERE " & _
        "IRDP.Activo = 1 " & _
    "AND MMPP.Activo = 1 " & _
    "AND Peso <> 0 " & _
    "AND Ano = @Ano " & _
    "AND IRDP.IdProgramaPorIndicadorDeMeta = @IdProgramaPorIndicadorDeMeta " & _
    "AND MMPP.ProyectadoQ1<>0 AND MMPP.ProyectadoQ2<>0 AND MMPP.ProyectadoQ3<>0 AND MMPP.ProyectadoQ4<>0 " & _
        "Group BY " & _
        "IRDP.IdProgramaPorIndicadorDeMeta, " & _
        "IRDP.IdIndicadoresRelevantesDePrograma, " & _
        "IPP.IdIndicadoresPorPrograma, " & _
        "IPP.DescripcionIndicador, " & _
        "IPP.NombreProyecto, " & _
        "IRDP.Peso, " & _
        "IPP.IdPrograma " & _
        "ORDER BY " & _
        "IdProgramaPorIndicadorDeMeta "

    End Sub
    Protected Sub ColorearGrid(sender As Object, e As ASPxGridViewTableRowEventArgs)
        If e.RowType <> GridViewRowType.Data Then
            Return
        End If
        Dim porcentaje As Double = Convert.ToDouble(e.GetValue("PorcentajeEjecucion"))
        If porcentaje < 0.5 Then
            e.Row.BackColor = System.Drawing.Color.Salmon
        End If
        If porcentaje >= 0.5 And (porcentaje < 0.8) Then
            e.Row.BackColor = System.Drawing.Color.PaleGoldenrod
        End If
        If (porcentaje >= 0.8) Then
            e.Row.BackColor = System.Drawing.Color.LightGreen
        End If
    End Sub
    Protected Sub link1_Click(sender As Object, e As EventArgs)

        Dim index As Integer = ASPxGridViewPoliticas.FocusedRowIndex

        Dim name As String = ASPxGridViewPoliticas.GetRowValues(index, "NombrePolitica").ToString

        Dim codpolitica As String = ASPxGridViewPoliticas.GetRowValues(index, "IdPolitica").ToString

        Dim Q1 As String = ASPxGridViewPoliticas.GetRowValues(index, "PorcentajeEjecucionQ1").ToString

        Dim Q2 As String = ASPxGridViewPoliticas.GetRowValues(index, "PorcentajeEjecucionQ2").ToString

        Dim Q3 As String = ASPxGridViewPoliticas.GetRowValues(index, "PorcentajeEjecucionQ3").ToString

        Dim Q4 As String = ASPxGridViewPoliticas.GetRowValues(index, "PorcentajeEjecucionQ4").ToString

        Dim porcentaje As String = ASPxGridViewPoliticas.GetRowValues(index, "PorcentajeEjecucion").ToString

        Dim tipo As String = ASPxComboBoxPeriodo.Value.ToString

        Response.Redirect("Grafico.aspx?NameP=" + uf.QueryStringEncode(name) + "&CodP=" + uf.QueryStringEncode(codpolitica) + "&Tipo=" + uf.QueryStringEncode(tipo) + "&Q1=" + uf.QueryStringEncode(Q1) + "&Q2=" + uf.QueryStringEncode(Q2) + "&Q3=" + uf.QueryStringEncode(Q3) + "&Q4=" + uf.QueryStringEncode(Q4) + "&Porc=" + uf.QueryStringEncode(porcentaje))


    End Sub


    Protected Sub ASPxGridViewPoliticas_CustomCallback(sender As Object, e As ASPxGridViewCustomCallbackEventArgs)
        SqlDataSourcePoliticas.SelectParameters(0).DefaultValue = ASPxComboBoxAno.Value
        SqlDataSourcePoliticas.DataBind()
        ASPxGridViewPoliticas.DataBind()
    End Sub

    Protected Sub linkGraficoComponente_Click(sender As Object, e As EventArgs)
        Dim index As Integer = ASPxGridViewComponentesPoliticas.FocusedRowIndex

        Dim name As String = ASPxGridViewComponentesPoliticas.GetRowValues(index, "Componente").ToString

        Dim codpolitica As String = ASPxGridViewComponentesPoliticas.GetRowValues(index, "IdPolitica").ToString

        Dim Q1 As String = ASPxGridViewComponentesPoliticas.GetRowValues(index, "PorcentajeEjecucionQ1").ToString

        Dim Q2 As String = ASPxGridViewComponentesPoliticas.GetRowValues(index, "PorcentajeEjecucionQ2").ToString

        Dim Q3 As String = ASPxGridViewComponentesPoliticas.GetRowValues(index, "PorcentajeEjecucionQ3").ToString

        Dim Q4 As String = ASPxGridViewComponentesPoliticas.GetRowValues(index, "PorcentajeEjecucionQ4").ToString

        Dim porcentaje As String = ASPxGridViewComponentesPoliticas.GetRowValues(index, "PorcentajeEjecucion").ToString

        Dim tipo As String = ASPxComboBoxPeriodo.Value.ToString

        Response.Redirect("Grafico.aspx?NameP=" + uf.QueryStringEncode(name) + "&CodP=" + uf.QueryStringEncode(codpolitica) + "&Tipo=" + uf.QueryStringEncode(tipo) + "&Q1=" + uf.QueryStringEncode(Q1) + "&Q2=" + uf.QueryStringEncode(Q2) + "&Q3=" + uf.QueryStringEncode(Q3) + "&Q4=" + uf.QueryStringEncode(Q4) + "&Porc=" + uf.QueryStringEncode(porcentaje))
    End Sub


    Protected Sub linkVerComponentes_Click(sender As Object, e As EventArgs)

        SqlDataSourceComponente.SelectParameters(0).DefaultValue = ASPxGridViewPoliticas.GetRowValues(ASPxGridViewPoliticas.FocusedRowIndex, "IdPolitica")
        SqlDataSourceComponente.SelectParameters(1).DefaultValue = ASPxComboBoxAno.Value
        ASPxGridViewComponentesPoliticas.DataBind()
        'MessageBox.Show(ASPxGridViewPoliticas.GetRowValues(ASPxGridViewPoliticas.FocusedRowIndex, "IdPolitica"))
    End Sub

    Protected Sub linkVerMetas_Click(sender As Object, e As EventArgs)
        SqlDataSourceMetas.SelectParameters(0).DefaultValue = ASPxGridViewComponentesPoliticas.GetRowValues(ASPxGridViewComponentesPoliticas.FocusedRowIndex, "IdComponentesDePolitica")
        SqlDataSourceMetas.SelectParameters(1).DefaultValue = ASPxComboBoxAno.Value
        ASPxGridViewMetasComponentes.DataBind()
    End Sub


    Protected Sub ASPxGridViewMetasComponentes_HtmlRowPrepared(sender As Object, e As ASPxGridViewTableRowEventArgs)
        ColorearGrid(sender, e)

    End Sub

    Protected Sub linkVerGraficoMetas_Click(sender As Object, e As EventArgs)
        Dim index As Integer = ASPxGridViewMetasComponentes.FocusedRowIndex

        Dim name As String = ASPxGridViewMetasComponentes.GetRowValues(index, "Meta").ToString

        Dim codpolitica As String = ASPxGridViewMetasComponentes.GetRowValues(index, "IdMetasDeComponente").ToString

        Dim Q1 As String = ASPxGridViewMetasComponentes.GetRowValues(index, "PorcentajeEjecucionQ1").ToString

        Dim Q2 As String = ASPxGridViewMetasComponentes.GetRowValues(index, "PorcentajeEjecucionQ2").ToString

        Dim Q3 As String = ASPxGridViewMetasComponentes.GetRowValues(index, "PorcentajeEjecucionQ3").ToString

        Dim Q4 As String = ASPxGridViewMetasComponentes.GetRowValues(index, "PorcentajeEjecucionQ4").ToString

        Dim porcentaje As String = ASPxGridViewMetasComponentes.GetRowValues(index, "PorcentajeEjecucion").ToString

        Dim tipo As String = ASPxComboBoxPeriodo.Value.ToString

        Response.Redirect("Grafico.aspx?NameP=" + uf.QueryStringEncode(name) + "&CodP=" + uf.QueryStringEncode(codpolitica) + "&Tipo=" + uf.QueryStringEncode(tipo) + "&Q1=" + uf.QueryStringEncode(Q1) + "&Q2=" + uf.QueryStringEncode(Q2) + "&Q3=" + uf.QueryStringEncode(Q3) + "&Q4=" + uf.QueryStringEncode(Q4) + "&Porc=" + uf.QueryStringEncode(porcentaje))
    End Sub


    Protected Sub ASPxGridViewindicadoresMetas_HtmlRowPrepared(sender As Object, e As ASPxGridViewTableRowEventArgs)
        ColorearGrid(sender, e)

    End Sub

    Protected Sub linkVerGraficoIndicadores_Click(sender As Object, e As EventArgs)
        Dim index As Integer = ASPxGridViewindicadoresMetas.FocusedRowIndex

        Dim name As String = ASPxGridViewindicadoresMetas.GetRowValues(index, "DescripcionIndicador").ToString

        Dim codpolitica As String = ASPxGridViewindicadoresMetas.GetRowValues(index, "IdIndicadorDeMeta").ToString

        Dim Q1 As String = ASPxGridViewindicadoresMetas.GetRowValues(index, "PorcentajeEjecucionQ1").ToString

        Dim Q2 As String = ASPxGridViewindicadoresMetas.GetRowValues(index, "PorcentajeEjecucionQ2").ToString

        Dim Q3 As String = ASPxGridViewindicadoresMetas.GetRowValues(index, "PorcentajeEjecucionQ3").ToString

        Dim Q4 As String = ASPxGridViewindicadoresMetas.GetRowValues(index, "PorcentajeEjecucionQ4").ToString

        Dim porcentaje As String = ASPxGridViewindicadoresMetas.GetRowValues(index, "PorcentajeEjecucion").ToString

        Dim tipo As String = ASPxComboBoxPeriodo.Value.ToString

        Response.Redirect("Grafico.aspx?NameP=" + uf.QueryStringEncode(name) + "&CodP=" + uf.QueryStringEncode(codpolitica) + "&Tipo=" + uf.QueryStringEncode(tipo) + "&Q1=" + uf.QueryStringEncode(Q1) + "&Q2=" + uf.QueryStringEncode(Q2) + "&Q3=" + uf.QueryStringEncode(Q3) + "&Q4=" + uf.QueryStringEncode(Q4) + "&Porc=" + uf.QueryStringEncode(porcentaje))


    End Sub

    Protected Sub linkVerProgramas_Click(sender As Object, e As EventArgs)
        SqlDataSourceProgramasIndicadoresMetas.SelectParameters(0).DefaultValue = ASPxGridViewindicadoresMetas.GetRowValues(ASPxGridViewindicadoresMetas.FocusedRowIndex, "IdIndicadorDeMeta")
        SqlDataSourceProgramasIndicadoresMetas.SelectParameters(1).DefaultValue = ASPxComboBoxAno.Value
        ASPxGridViewProgramasIndicadoresMetas.DataBind()
    End Sub



    Protected Sub linkVerIndicadoresMetas_Click(sender As Object, e As EventArgs)
        SqlDataSourceIndicadoresMetas.SelectParameters(0).DefaultValue = ASPxGridViewMetasComponentes.GetRowValues(ASPxGridViewMetasComponentes.FocusedRowIndex, "IdMetasDeComponente")
        SqlDataSourceIndicadoresMetas.SelectParameters(1).DefaultValue = ASPxComboBoxAno.Value
    End Sub

    Protected Sub ASPxGridViewProgramasIndicadoresMetas_HtmlRowPrepared(sender As Object, e As ASPxGridViewTableRowEventArgs)
        ColorearGrid(sender, e)
    End Sub

    Protected Sub linkVerGraficoprogramas_Click(sender As Object, e As EventArgs)
        Dim index As Integer = ASPxGridViewProgramasIndicadoresMetas.FocusedRowIndex

        Dim name As String = ASPxGridViewProgramasIndicadoresMetas.GetRowValues(index, "NombreProyecto").ToString

        Dim codpolitica As String = ASPxGridViewProgramasIndicadoresMetas.GetRowValues(index, "IdProgramasPorIndicadorDeMeta").ToString

        Dim Q1 As String = ASPxGridViewProgramasIndicadoresMetas.GetRowValues(index, "PorcentajeEjecucionQ1").ToString

        Dim Q2 As String = ASPxGridViewProgramasIndicadoresMetas.GetRowValues(index, "PorcentajeEjecucionQ2").ToString

        Dim Q3 As String = ASPxGridViewProgramasIndicadoresMetas.GetRowValues(index, "PorcentajeEjecucionQ3").ToString

        Dim Q4 As String = ASPxGridViewProgramasIndicadoresMetas.GetRowValues(index, "PorcentajeEjecucionQ4").ToString

        Dim porcentaje As String = ASPxGridViewProgramasIndicadoresMetas.GetRowValues(index, "PorcentajeEjecucion").ToString

        Dim tipo As String = ASPxComboBoxPeriodo.Value.ToString

        Response.Redirect("Grafico.aspx?NameP=" + uf.QueryStringEncode(name) + "&CodP=" + uf.QueryStringEncode(codpolitica) + "&Tipo=" + uf.QueryStringEncode(tipo) + "&Q1=" + uf.QueryStringEncode(Q1) + "&Q2=" + uf.QueryStringEncode(Q2) + "&Q3=" + uf.QueryStringEncode(Q3) + "&Q4=" + uf.QueryStringEncode(Q4) + "&Porc=" + uf.QueryStringEncode(porcentaje))
    End Sub

    Protected Sub linkVerIndicadoresRelevantes_Click(sender As Object, e As EventArgs)
        SqlDataSourceIndicadoresRelevantes.SelectParameters(0).DefaultValue = ASPxGridViewProgramasIndicadoresMetas.GetRowValues(ASPxGridViewProgramasIndicadoresMetas.FocusedRowIndex, "IdProgramasPorIndicadorDeMeta")
        SqlDataSourceIndicadoresRelevantes.SelectParameters(1).DefaultValue = ASPxComboBoxAno.Value
        ASPxGridViewIndicadoresRelevantes.DataBind()

    End Sub

    Protected Sub linkVerGraficoIndicadoresRelevantes_Click(sender As Object, e As EventArgs)
        Dim index As Integer = ASPxGridViewIndicadoresRelevantes.FocusedRowIndex

        Dim name As String = ASPxGridViewIndicadoresRelevantes.GetRowValues(index, "DescripcionIndicador").ToString

        Dim codpolitica As String = ASPxGridViewIndicadoresRelevantes.GetRowValues(index, "IdIndicadoresRelevantesDePrograma").ToString

        Dim Q1 As String = ASPxGridViewIndicadoresRelevantes.GetRowValues(index, "PorcentajeEjecucionQ1").ToString

        Dim Q2 As String = ASPxGridViewIndicadoresRelevantes.GetRowValues(index, "PorcentajeEjecucionQ2").ToString

        Dim Q3 As String = ASPxGridViewIndicadoresRelevantes.GetRowValues(index, "PorcentajeEjecucionQ3").ToString

        Dim Q4 As String = ASPxGridViewIndicadoresRelevantes.GetRowValues(index, "PorcentajeEjecucionQ4").ToString

        Dim porcentaje As String = ASPxGridViewIndicadoresRelevantes.GetRowValues(index, "PorcentajeEjecucion").ToString

        Dim tipo As String = ASPxComboBoxPeriodo.Value.ToString

        Response.Redirect("Grafico.aspx?NameP=" + uf.QueryStringEncode(name) + "&CodP=" + uf.QueryStringEncode(codpolitica) + "&Tipo=" + uf.QueryStringEncode(tipo) + "&Q1=" + uf.QueryStringEncode(Q1) + "&Q2=" + uf.QueryStringEncode(Q2) + "&Q3=" + uf.QueryStringEncode(Q3) + "&Q4=" + uf.QueryStringEncode(Q4) + "&Porc=" + uf.QueryStringEncode(porcentaje))
    End Sub

    Protected Sub ASPxGridViewIndicadoresRelevantes_HtmlRowPrepared(sender As Object, e As ASPxGridViewTableRowEventArgs)
        ColorearGrid(sender, e)
    End Sub

    Protected Sub ASPxGridViewPoliticas_HtmlRowPrepared(sender As Object, e As ASPxGridViewTableRowEventArgs)
        ColorearGrid(sender, e)
    End Sub

    Protected Sub ASPxGridViewComponentesPoliticas_HtmlRowPrepared(sender As Object, e As ASPxGridViewTableRowEventArgs)
        ColorearGrid(sender, e)
    End Sub
End Class
