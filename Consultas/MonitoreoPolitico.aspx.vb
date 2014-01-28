Imports DevExpress.Web.ASPxGridView

Partial Class Consultas_MonitoreoPolitico
    Inherits System.Web.UI.Page

    Protected Sub ASPxGridViewComponentesPoliticas_BeforePerformDataSelect(sender As Object, e As EventArgs)

        Session("IdPolitica") = CType(sender, ASPxGridView).GetMasterRowKeyValue()


    End Sub
    Protected Sub ASPxGridViewMetasComponentes_BeforePerformDataSelect(sender As Object, e As EventArgs)

        Session("IdComponentesDePolitica") = CType(sender, ASPxGridView).GetMasterRowKeyValue()


    End Sub
    Protected Sub ASPxGridViewindicadoresMetas_BeforePerformDataSelect(sender As Object, e As EventArgs)

        Session("IdMetasDeComponente") = CType(sender, ASPxGridView).GetMasterRowKeyValue()


    End Sub
    Protected Sub ASPxGridViewProgramasIndicadoresMetas_BeforePerformDataSelect(sender As Object, e As EventArgs)

        Session("IdIndicadorDeMeta") = CType(sender, ASPxGridView).GetMasterRowKeyValue()


    End Sub
    Protected Sub ASPxGridViewIndicadoresRelevantes_BeforePerformDataSelect(sender As Object, e As EventArgs)

        Session("IdProgramaPorIndicadorDeMeta") = CType(sender, ASPxGridView).GetMasterRowKeyValue()


    End Sub


    Protected Sub form1_Load(sender As Object, e As EventArgs)


    End Sub


    Protected Sub ASPxGridViewIndicadoresRelevantes_HtmlRowPrepared(sender As Object, e As ASPxGridViewTableRowEventArgs)
        ColorearGrid(sender, e)
    End Sub

    Protected Sub ASPxGridViewProgramasIndicadoresMetas_HtmlRowPrepared(sender As Object, e As ASPxGridViewTableRowEventArgs)
        ColorearGrid(sender, e)
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

    Protected Sub ASPxGridViewMetasComponentes_HtmlRowPrepared(sender As Object, e As ASPxGridViewTableRowEventArgs)

        ColorearGrid(sender, e)
    End Sub

    Protected Sub ASPxGridViewindicadoresMetas_HtmlRowPrepared(sender As Object, e As ASPxGridViewTableRowEventArgs)
        ColorearGrid(sender, e)
    End Sub

    Protected Sub ASPxGridViewPoliticas_HtmlRowPrepared(sender As Object, e As ASPxGridViewTableRowEventArgs)
        ColorearGrid(sender, e)
    End Sub

    Protected Sub ASPxGridViewComponentesPoliticas_HtmlRowPrepared(sender As Object, e As ASPxGridViewTableRowEventArgs)
        ColorearGrid(sender, e)
    End Sub

    Protected Sub Page_Load(sender As Object, e As EventArgs) Handles Me.Load
        'Verifica si el usuario tiene el acceso a la pagina solicitada
        Using dtMOCA As System.Data.DataTable = fMOCA.CheckPageAccess(3.02) 'este es el Id definido en el MOCA
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

        SqlDataSourceIndicadoresRelevantes.SelectCommand = "SELECT irp.[IdIndicadoresRelevantesDePrograma], irp.[IdProgramaPorIndicadorDeMeta], irp.[IdIndicadoresPorPrograma], irp.[Peso], " & _
            "COALESCE(SUM(mmpp.EjecutadoQ1+mmpp.EjecutadoQ2+mmpp.EjecutadoQ3+mmpp.EjecutadoQ4) / NULLIF(SUM(mmpp.ProyectadoQ1+mmpp.ProyectadoQ2+mmpp.ProyectadoQ3+mmpp.ProyectadoQ4),0), 0) as PorcentajeEjecucion, " & _
            "SUM(mmpp.ProyectadoQ1+mmpp.ProyectadoQ2+mmpp.ProyectadoQ3+mmpp.ProyectadoQ4) as Proyectado, " & _
            "SUM(mmpp.EjecutadoQ1+mmpp.EjecutadoQ2+mmpp.EjecutadoQ3+mmpp.EjecutadoQ4) as Ejectuado, " & _
            "NULLIF(SUM(mmpp.ProyectadoQ1+mmpp.ProyectadoQ2+mmpp.ProyectadoQ3+mmpp.ProyectadoQ4),0) as HayProyectado " & _
            "FROM [IndicadoresRelevantesDePrograma] as irp " & _
            "JOIN [dbo].[IndicadoresPorPrograma] as ipp ON irp.IdIndicadoresPorPrograma = ipp.IdIndicadoresPorPrograma " & _
            "JOIN [dbo].[MetaYMonitoreoPorPeriodo] as mmpp ON mmpp.IdIndicadorPorPrograma = ipp.IdIndicadoresPorPrograma " & _
            "WHERE [Peso]<>0 AND irp.Activo = 1 AND irp.[IdProgramaPorIndicadorDeMeta]=@IdProgramaPorIndicadorDeMeta GROUP BY irp.[IdIndicadoresRelevantesDePrograma], irp.[IdProgramaPorIndicadorDeMeta], irp.[IdIndicadoresPorPrograma], irp.[Peso]"

        SqlDataSourceProgramasIndicadoresMetas.SelectCommand = "SELECT pim.IdProgramasPorIndicadorDeMeta, pim.IdPrograma, pim.IdIndicadorDeMeta, pim.Peso, ISNULL(SUM(indrel.Peso / 100 * PorcentajeEjecucion),0) as PorcentajeEjecucion " & _
        "FROM [ProgramasPorIndicadorDeMeta] as pim " & _
        "LEFT JOIN " & _
        "(SELECT irp.[IdIndicadoresRelevantesDePrograma], irp.[IdProgramaPorIndicadorDeMeta], irp.[IdIndicadoresPorPrograma], irp.[Peso], " & _
        "COALESCE(SUM(mmpp.EjecutadoQ1+mmpp.EjecutadoQ2+mmpp.EjecutadoQ3+mmpp.EjecutadoQ4) / NULLIF(SUM(mmpp.ProyectadoQ1+mmpp.ProyectadoQ2+mmpp.ProyectadoQ3+mmpp.ProyectadoQ4),0), 0) as PorcentajeEjecucion, " & _
        "SUM(mmpp.ProyectadoQ1+mmpp.ProyectadoQ2+mmpp.ProyectadoQ3+mmpp.ProyectadoQ4) as Proyectado, " & _
        "SUM(mmpp.EjecutadoQ1+mmpp.EjecutadoQ2+mmpp.EjecutadoQ3+mmpp.EjecutadoQ4) as Ejectuado, " & _
        "NULLIF(SUM(mmpp.ProyectadoQ1+mmpp.ProyectadoQ2+mmpp.ProyectadoQ3+mmpp.ProyectadoQ4),0) as HayProyectado " & _
        "FROM [IndicadoresRelevantesDePrograma] as irp " & _
        "JOIN [dbo].[IndicadoresPorPrograma] as ipp ON irp.IdIndicadoresPorPrograma = ipp.IdIndicadoresPorPrograma " & _
        "JOIN [dbo].[MetaYMonitoreoPorPeriodo] as mmpp ON mmpp.IdIndicadorPorPrograma = ipp.IdIndicadoresPorPrograma " & _
        "WHERE [Peso] <> 0 AND irp.Activo = 1 " & _
        "GROUP BY irp.[IdIndicadoresRelevantesDePrograma], irp.[IdProgramaPorIndicadorDeMeta], irp.[IdIndicadoresPorPrograma], irp.[Peso]) as indrel " & _
        "ON pim.IdProgramasPorIndicadorDeMeta = indrel.IdProgramaPorIndicadorDeMeta " & _
        "WHERE pim.Peso <> 0 AND pim.Activo = 1 AND pim.IdIndicadorDeMeta = @IdIndicadorDeMeta " & _
        "Group BY pim.IdProgramasPorIndicadorDeMeta, pim.IdPrograma, pim.IdIndicadorDeMeta, pim.Peso "

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
        "WHERE [Peso] <> 0 AND irp.Activo = 1 " & _
        "GROUP BY irp.[IdIndicadoresRelevantesDePrograma], irp.[IdProgramaPorIndicadorDeMeta], irp.[IdIndicadoresPorPrograma], irp.[Peso]) as indrel " & _
        "ON pim.IdProgramasPorIndicadorDeMeta = indrel.IdProgramaPorIndicadorDeMeta " & _
        "WHERE pim.Peso <> 0 AND pim.Activo = 1 " & _
        "GROUP BY pim.IdProgramasPorIndicadorDeMeta, pim.IdPrograma, pim.IdIndicadorDeMeta, pim.Peso) as sel ON im.IdIndicadorDeMeta= sel.IdIndicadorDeMeta " & _
        "WHERE im.Peso <> 0 AND im.Activo = 1 AND [IdMetasDeComponente] = @IdMetasDeComponente " & _
        "GROUP BY im.[IdIndicadorDeMeta], im.[IdMetasDeComponente], im.[IdIndicador], im.[Peso]"

        SqlDataSourceMetasComponentes.SelectCommand = "SELECT mdp.[IdMetasDeComponente], mdp.[IdComponentesDePolitica], mdp.[Nombre], mdp.[Descripcion], mdp.[Peso], ISNULL(SUM(cond.Peso / 100 * PorcentajeEjecucion),0) as PorcentajeEjecucion " & _
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
        "WHERE [Peso] <> 0 AND irp.Activo = 1 " & _
        "GROUP BY irp.[IdIndicadoresRelevantesDePrograma], irp.[IdProgramaPorIndicadorDeMeta], irp.[IdIndicadoresPorPrograma], irp.[Peso]) as indrel " & _
        "ON pim.IdProgramasPorIndicadorDeMeta = indrel.IdProgramaPorIndicadorDeMeta " & _
        "WHERE pim.Peso <> 0 AND pim.Activo = 1 " & _
        "GROUP BY pim.IdProgramasPorIndicadorDeMeta, pim.IdPrograma, pim.IdIndicadorDeMeta, pim.Peso) as sel ON im.IdIndicadorDeMeta= sel.IdIndicadorDeMeta " & _
        "WHERE im.Peso <> 0 AND im.Activo = 1 " & _
        "GROUP BY im.[IdIndicadorDeMeta], im.[IdMetasDeComponente], im.[IdIndicador], im.[Peso]) as cond " & _
        "ON mdp.[IdMetasDeComponente] = cond.IdMetasDeComponente " & _
        "WHERE mdp.Peso<>0 AND mdp.Activo = 1 AND [IdComponentesDePolitica]=@IdComponentesDePolitica " & _
        "GROUP BY mdp.[IdMetasDeComponente], mdp.[IdComponentesDePolitica], mdp.[Nombre], mdp.[Descripcion], mdp.[Peso] "

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
        "WHERE [Peso] <> 0 AND irp.Activo = 1 " & _
        "GROUP BY irp.[IdIndicadoresRelevantesDePrograma], irp.[IdProgramaPorIndicadorDeMeta], irp.[IdIndicadoresPorPrograma], irp.[Peso]) as indrel " & _
        "ON pim.IdProgramasPorIndicadorDeMeta = indrel.IdProgramaPorIndicadorDeMeta " & _
        "WHERE pim.Peso <> 0 AND pim.Activo = 1 " & _
        "GROUP BY pim.IdProgramasPorIndicadorDeMeta, pim.IdPrograma, pim.IdIndicadorDeMeta, pim.Peso) as sel ON im.IdIndicadorDeMeta= sel.IdIndicadorDeMeta " & _
        "WHERE im.Peso <> 0 AND im.Activo = 1 " & _
        "GROUP BY im.[IdIndicadorDeMeta], im.[IdMetasDeComponente], im.[IdIndicador], im.[Peso]) as cond " & _
        "ON mdp.[IdMetasDeComponente] = cond.IdMetasDeComponente  " & _
        "GROUP BY mdp.[IdMetasDeComponente], mdp.[IdComponentesDePolitica], mdp.[Nombre], mdp.[Descripcion], mdp.[Peso]) as sigC " & _
        "ON cdp.IdComponentesDePolitica = sigC.[IdComponentesDePolitica] " & _
        "WHERE [IdPolitica]=@IdPolitica AND cdp.[Peso]<>0 AND cdp.Activo = 1 " & _
        "GROUP BY cdp.IdComponentesDePolitica, cdp.[IdPolitica], cdp.[Nombre], cdp.[Descripcion], cdp.[Peso]"

        SqlDataSourcePoliticas.SelectCommand = "SELECT p.[IdPolitica], p.[Nombre], p.[SujetosDeAtencion], ISNULL(SUM(ultima.Peso / 100 * PorcentajeEjecucion),0) as PorcentajeEjecucion " & _
        "FROM [Politicas] as p " & _
        "Left Join (SELECT cdp.IdComponentesDePolitica, cdp.[IdPolitica], cdp.[Nombre], cdp.[Descripcion], cdp.[Peso], ISNULL(SUM(sigC.Peso / 100 * PorcentajeEjecucion),0) as PorcentajeEjecucion " & _
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
        "WHERE [Peso] <> 0 AND irp.Activo = 1 " & _
        "GROUP BY irp.[IdIndicadoresRelevantesDePrograma], irp.[IdProgramaPorIndicadorDeMeta], irp.[IdIndicadoresPorPrograma], irp.[Peso]) as indrel " & _
        "ON pim.IdProgramasPorIndicadorDeMeta = indrel.IdProgramaPorIndicadorDeMeta " & _
        "WHERE pim.Peso <> 0 AND pim.Activo = 1 " & _
        "GROUP BY pim.IdProgramasPorIndicadorDeMeta, pim.IdPrograma, pim.IdIndicadorDeMeta, pim.Peso) as sel ON im.IdIndicadorDeMeta= sel.IdIndicadorDeMeta " & _
        "WHERE im.Peso <> 0 AND im.Activo = 1 " & _
        "GROUP BY im.[IdIndicadorDeMeta], im.[IdMetasDeComponente], im.[IdIndicador], im.[Peso]) as cond " & _
        "ON mdp.[IdMetasDeComponente] = cond.IdMetasDeComponente " & _
        "GROUP BY mdp.[IdMetasDeComponente], mdp.[IdComponentesDePolitica], mdp.[Nombre], mdp.[Descripcion], mdp.[Peso]) as sigC " & _
        "ON cdp.IdComponentesDePolitica = sigC.[IdComponentesDePolitica] " & _
        "WHERE cdp.[Peso] <> 0 AND cdp.Activo = 1 " & _
        "GROUP BY cdp.IdComponentesDePolitica, cdp.[IdPolitica], cdp.[Nombre], cdp.[Descripcion], cdp.[Peso]) " & _
        "as ultima ON p.[IdPolitica] = ultima.IdPolitica   AND p.[Activo] = 1 " & _
        "GROUP BY p.[IdPolitica], p.[Nombre], p.[SujetosDeAtencion]"
    End Sub


    'Protected Sub GridPoliticas_CommandButtonInitialize(sender As Object, e As ASPxGridViewCommandButtonEventArgs) Handles GridPoliticas.CommandButtonInitialize
    '    'Este evento debe de usarse cuando se desean activar o desactivar los comandos de accion en un gridview
    '    'Con las variables de sessión inicializadas en el evento Page_Load se activan o desactivan los botones del Grid
    '    Select Case e.ButtonType
    '        Case DevExpress.Web.ASPxGridView.ColumnCommandButtonType.New
    '            e.Visible = Session("AllowAdd")
    '        Case DevExpress.Web.ASPxGridView.ColumnCommandButtonType.Edit
    '            e.Visible = Session("AllowUpdate")
    '        Case DevExpress.Web.ASPxGridView.ColumnCommandButtonType.Delete
    '            e.Visible = Session("AllowDelete")
    '    End Select

    'End Sub
End Class
