Imports DevExpress.Web.ASPxGridView

Partial Class Evaluacion_Levantamientos
    Inherits System.Web.UI.Page
    Private GridPrograma As ASPxGridView
    Private GridInstrumentos As ASPxGridView
    Private GridAplicacion As ASPxGridView

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


            Me.SqlPrograma.SelectCommand = _
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

            Me.SqlInstrumentos.SelectCommand = _
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

            Me.SqlAplicacion.SelectCommand = _
                "select " & _
                "	AI.IdAplicacionInstrumento, " & _
                "	MA.DescripcionMomento, " & _
                "	AI.UsaFSU, " & _
                "	AI.FechaAplicacion, " & _
                "	IE.IdInstrumentoDeEvaluacion  " & _
                "from  " & _
                "	InstrumentosDeEvaluacion IE  " & _
                "	join AplicacionInstrumento AI on IE.IdInstrumentoDeEvaluacion= AI.IdInstrumentoDeEvaluacion  " & _
                "	join MomentosDeAplicacion MA on MA.IdMomentoDeAplicacion=IdMomentoAplicacion  " & _
                "where  " & _
                "	AI.[IdInstrumentoDeEvaluacion]= @IdInstrumentoDeEvaluacion and  " & _
                "	AI.[Activo]=1 and " & _
                "	IE.[Activo]=1"



        End Using

    End Sub


    Protected Sub ASPxGridView2_BeforePerformDataSelect(sender As Object, e As EventArgs)

        Session("IdPolitica") = CType(sender, ASPxGridView).GetMasterRowKeyValue()

    End Sub



    Protected Sub ASPxGridView3_BeforePerformDataSelect(sender As Object, e As EventArgs)
        GridInstrumentos = (TryCast(sender, ASPxGridView))
        Session("IdInstrumentoDeEvaluacion") = GridInstrumentos.GetMasterRowKeyValue()

        'Session("IdInstrumento") = CType(sender, ASPxGridView).GetMasterRowKeyValue()
        'Me.SqlAplicacion.SelectParameters(0).DefaultValue = Session("IdInstrumento")
        'Me.SqlAplicacion.DataBind()

        'Dim detail As ASPxGridView = TryCast(GridPolitica.FindDetailRowTemplateControl(GridPolitica.FocusedRowIndex(), "GridPrograma"), ASPxGridView)

        'Dim index As Integer = detail.FocusedRowIndex()

        'Session("IdPrograma") = detail.GetRowValues(index, "codigo_ficha")




    End Sub

    


    Protected Sub link1_Click(sender As Object, e As EventArgs)
        Dim IdLevantamiento As Integer = GridInstrumentos.GetRowValues(GridInstrumentos.FocusedRowIndex, "IdAplicacionInstrumento")
        Dim Calculadora As New CalculadoraIndicadores(SqlPolitica.ConnectionString, Session("IdPrograma"), IdLevantamiento)
        Calculadora.Run(Membership.GetUser.UserName.ToString)
    End Sub

    Protected Sub GridInstrumentos_BeforePerformDataSelect(sender As Object, e As EventArgs)
        Session("IdPrograma") = (TryCast(sender, ASPxGridView)).GetMasterRowKeyValue()
    End Sub

    Protected Sub GridPolitica_DetailRowExpandedChanged(sender As Object, e As ASPxGridViewDetailRowEventArgs)

    End Sub
End Class
