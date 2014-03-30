Imports DevExpress.Web.ASPxGridView
Imports System.Windows.Forms

Partial Class Evaluacion_Levantamientos
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(sender As Object, e As EventArgs) Handles Me.Load
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
                "	Pol.[IdPolitica]=@IdPolitica and " & _
                "	Pro.codigo_ficha in " & _
                "		(select distinct(IdPrograma) from InstrumentosDeEvaluacion where Activo=1) "

            Me.SqlDataSourceInstrumentos.SelectCommand = _
                "select  " & _
                "	distinct(IE.IdInstrumentoDeEvaluacion),  " & _
                "	TI.TipoDeInstrumento,  " & _
                "	IE.IdPrograma,  " & _
                "	IE.NombreInstrumento,  " & _
                "	IE.Ano  " & _
                "from  " & _
                "	AplicacionInstrumento AI  " & _
                "	join MomentosDeAplicacion MA on AI.IdMomentoAplicacion=MA.IdMomentoDeAplicacion  " & _
                "	join InstrumentosDeEvaluacion IE on AI.IdInstrumentoDeEvaluacion=IE.IdInstrumentoDeEvaluacion and IE.Activo=1 " & _
                "	join ProcesosEvaluacion PE on IE.IdProcesoEvaluacion=PE.IdProcesoEvaluacion  " & _
                "	join TiposDeInstrumento TI on IE.IdTipoDeInstrumento=TI.IdTipoDeInstrumento  " & _
                "where " & _
                "	IE.IdPrograma = @IdPrograma"

            Me.SqlDataSourceLevantamientos.SelectCommand = " select AI.IdAplicacionInstrumento,MA.DescripcionMomento,PE.ProcesoEvaluacion,AI.FechaAplicacion,VIP.FechaCalculo from InstrumentosDeEvaluacion IE" & _
            " join AplicacionInstrumento AI on IE.IdInstrumentoDeEvaluacion= AI.IdInstrumentoDeEvaluacion" & _
            " join ProcesosEvaluacion PE on PE.IdProcesoEvaluacion=IE.IdProcesoEvaluacion" & _
            " join MomentosDeAplicacion MA on MA.IdMomentoDeAplicacion=AI.IdMomentoAplicacion" & _
            " join vProyectos P on IE.IdPrograma=P.codigo_ficha" & _
            " join IndicadoresEvaluacionPorPrograma IEP on IE.IdPrograma = IEP.IdPrograma" & _
            " join Indicadores I on IEP.IdIndicador = I.IdIndicador" & _
            " left join ValoresIndicadorPorLevantamiento VIP on AI.IdAplicacionInstrumento=VIP.IdAplicacionInstrumento" & _
            " AND IEP.IdIndicadoresEvaluacionPorPrograma=VIP.IdIndicadoresEvaluacionPorPrograma where AI.[IdInstrumentoDeEvaluacion]=@IdInstrumento and AI.[Activo]=1 and IE.[Activo]=1 group by AI.IdAplicacionInstrumento,MA.DescripcionMomento,PE.ProcesoEvaluacion,AI.FechaAplicacion,VIP.FechaCalculo  "

            Me.SqlDataSourceIndicadores.SelectCommand = "Select distinct(I.IdIndicador), " & _
                "I.DescripcionIndicador Indicador, " & _
                "VI.ValorIndicador ValorCalculado, " & _
                "VIP.ValorIndicador ValorPrograma, " & _
                "VIO.ValorIndicador ValorOficial " & _
                "from " & _
                "ValoresIndicadorPorLevantamiento VI " & _
                "join IndicadoresEvaluacionPorPrograma IEP on VI.IdIndicadoresEvaluacionPorPrograma=IEP.IdIndicadoresEvaluacionPorPrograma and VI.IndicadorCalculado = 1 " & _
                "join Indicadores I on IEP.IdIndicador = I.IdIndicador " & _
                "left join ValoresIndicadorPorLevantamiento VIP on VI.IdIndicadoresEvaluacionPorPrograma = VIP.IdIndicadoresEvaluacionPorPrograma AND VIP.IndicadorPrograma=1 " & _
                "left join ValoresIndicadorPorLevantamiento VIO on VI.IdIndicadoresEvaluacionPorPrograma = VIO.IdIndicadoresEvaluacionPorPrograma AND VIO.IndicadorOficial=1 " & _
                "where " & _
                "VI.IdAplicacionInstrumento = @IdAplicacion"

        End Using

    End Sub


    Protected Sub ASPxGridViewProyectos_BeforePerformDataSelect(sender As Object, e As EventArgs)

        Session("IdPolitica") = CType(sender, ASPxGridView).GetMasterRowKeyValue()
        Me.SqlDataSourceProyectos.SelectParameters(0).DefaultValue = Session("IdPolitica")
        Me.SqlDataSourceProyectos.DataBind()

        Session("indexpolitica") = ASPxGridViewPoliticas.FocusedRowIndex()



    End Sub



    Protected Sub ASPxGridViewLevantamientos_BeforePerformDataSelect(sender As Object, e As EventArgs)

        Session("IdInstrumento") = CType(sender, ASPxGridView).GetMasterRowKeyValue()
        Me.SqlDataSourceLevantamientos.SelectParameters(0).DefaultValue = Session("IdInstrumento")
        Me.SqlDataSourceLevantamientos.DataBind()

        Dim detail As ASPxGridView = TryCast(ASPxGridViewPoliticas.FindDetailRowTemplateControl(ASPxGridViewPoliticas.FocusedRowIndex(), "ASPxGridViewProyectos"), ASPxGridView)

        Dim index As Integer = detail.FocusedRowIndex()

        Session("IdPrograma") = detail.GetRowValues(index, "codigo_ficha")




    End Sub


    Protected Sub ASPxGridViewIndicadores_BeforePerformDataSelect(sender As Object, e As EventArgs)

        Session("IdAplicacion") = CType(sender, ASPxGridView).GetMasterRowKeyValue()

        Me.SqlDataSourceIndicadores.SelectParameters(0).DefaultValue = Session("IdAplicacion")
        Me.SqlDataSourceIndicadores.DataBind()


    End Sub

    Protected Sub ASPxGridViewLevantamientos_HtmlDataCellPrepared(sender As Object, e As ASPxGridViewTableDataCellEventArgs)

        If e.DataColumn.FieldName = "FechaCalculo" Then

            If IsDBNull(e.CellValue) Then

                Session("bandera") = False

            Else

                Session("bandera") = True

            End If

        End If

        If e.DataColumn.Name = "Calculado" Then

            If Session("bandera") = True Then

                e.Cell.Text = "No"

            Else
                e.Cell.Text = "Si"

            End If

        End If

    End Sub


    Protected Sub ASPxGridViewDepartamentos_BeforePerformDataSelect(sender As Object, e As EventArgs)

        Me.SqlDataSourceDepartamentos.SelectCommand = "select IEP.IdIndicadoresEvaluacionPorPrograma,D.DescripcionDepartamento,VD.Valor from AplicacionInstrumento AI " & _
        " join InstrumentosDeEvaluacion IE on AI.IdInstrumentoDeEvaluacion=IE.IdInstrumentoDeEvaluacion" & _
        " join IndicadoresEvaluacionPorPrograma IEP on IE.IdPrograma = IEP.IdPrograma" & _
        " left join ValoresDepartamento VD on AI.IdAplicacionInstrumento=VD.IdAplicacionInstrumento AND IEP.IdIndicadoresEvaluacionPorPrograma=VD.IdIndicadorEvaluacionPorPrograma" & _
        " left join vDepartamentos D on VD.IdDepartamento = D.IdDepartamento where AI.IdAplicacionInstrumento = @IdAplicacion and IEP.IdIndicador=@IdIndicador"

        Session("IdIndicador") = CType(sender, ASPxGridView).GetMasterRowKeyValue()

        Me.SqlDataSourceDepartamentos.SelectParameters(0).DefaultValue = Session("IdAplicacion")
        Me.SqlDataSourceDepartamentos.SelectParameters(1).DefaultValue = Session("IdIndicador")
        Me.SqlDataSourceDepartamentos.DataBind()




    End Sub

    Protected Sub ASPxGridViewMunicipios_BeforePerformDataSelect(sender As Object, e As EventArgs)

        Me.SqlDataSourceMunicipios.SelectCommand = "select IEP.IdIndicadoresEvaluacionPorPrograma,D.DescripcionDepartamento,M.DescripcionMunicipio,VM.Valor from AplicacionInstrumento AI" & _
       " join InstrumentosDeEvaluacion IE on AI.IdInstrumentoDeEvaluacion=IE.IdInstrumentoDeEvaluacion" & _
       " join IndicadoresEvaluacionPorPrograma IEP on IE.IdPrograma = IEP.IdPrograma" & _
       " left join ValoresMunicipio VM on AI.IdAplicacionInstrumento=VM.IdAplicacionInstrumento AND IEP.IdIndicadoresEvaluacionPorPrograma=VM.IdIndicadorEvaluacionPorPrograma" & _
       " left join vMunicipios M on VM.IdMunicipio=M.IdMunicipio and VM.IdDepartamento=M.IdDepartamento" & _
       " left join vDepartamentos D on VM.IdDepartamento=D.IdDepartamento where AI.IdAplicacionInstrumento = @IdAplicacion and IEP.IdIndicador=@IdIndicador"

        Session("IdIndicador") = CType(sender, ASPxGridView).GetMasterRowKeyValue()

        Me.SqlDataSourceMunicipios.SelectParameters(0).DefaultValue = Session("IdAplicacion")
        Me.SqlDataSourceMunicipios.SelectParameters(1).DefaultValue = Session("IdIndicador")
        Me.SqlDataSourceMunicipios.DataBind()



    End Sub

    Protected Sub ASPxGridViewSexo_BeforePerformDataSelect(sender As Object, e As EventArgs)

        Me.SqlDataSourceSexo.SelectCommand = "select IEP.IdIndicadoresEvaluacionPorPrograma,S.DescripcionSexo,VS.Valor from AplicacionInstrumento AI" & _
    " join InstrumentosDeEvaluacion IE on AI.IdInstrumentoDeEvaluacion=IE.IdInstrumentoDeEvaluacion" & _
    " join IndicadoresEvaluacionPorPrograma IEP on IE.IdPrograma = IEP.IdPrograma" & _
    " left join ValoresSexo VS on AI.IdAplicacionInstrumento=VS.IdAplicacionInstrumento AND IEP.IdIndicadoresEvaluacionPorPrograma=VS.IdIndicadorEvaluacionPorPrograma" & _
    " left join vSexo S on VS.IdSexo = S.IdSexo where AI.IdAplicacionInstrumento = @IdAplicacion and IEP.IdIndicador=@IdIndicador"

        Session("IdIndicador") = CType(sender, ASPxGridView).GetMasterRowKeyValue()

        Me.SqlDataSourceSexo.SelectParameters(0).DefaultValue = Session("IdAplicacion")
        Me.SqlDataSourceSexo.SelectParameters(1).DefaultValue = Session("IdIndicador")
        Me.SqlDataSourceSexo.DataBind()


    End Sub

    Protected Sub ASPxGridViewInstrumentos_BeforePerformDataSelect(sender As Object, e As EventArgs)
        Session("IdPrograma") = (TryCast(sender, ASPxGridView)).GetMasterRowKeyValue()

        
    End Sub

End Class
