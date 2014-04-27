Imports DevExpress.Web.ASPxGridView
Imports DevExpress.Web.ASPxEditors

Partial Class Consultas_MapTest
    Inherits System.Web.UI.Page




    Protected Sub Page_Load(sender As Object, e As EventArgs) Handles Me.Load
        'Verifica si el usuario tiene el acceso a la pagina solicitada
        Using dtMOCA As System.Data.DataTable = fMOCA.CheckPageAccess(4.05) 'este es el Id definido en el MOCA
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
        'Session("NombrePrograma") = uf.QueryStringDecode(Request.QueryString.Get(0))
        'Session("CodPrograma") = uf.QueryStringDecode(Request.QueryString.Get(1))




        Me.SqlPrograma.SelectCommand = "select DISTINCT(Pol.IdPolitica), Pol.Nombre, Pro.codigo_ficha, Pro.NombreProyecto from Politicas Pol " & _
        "join ComponentesDePolitica CP on Pol.IdPolitica=CP.IdPolitica " & _
        "join MetasDeComponente MC on CP.IdComponentesDePolitica=MC.IdComponentesDePolitica " & _
        "join IndicadoresDeMeta IM on MC.IdMetasDeComponente=IM.IdMetasDeComponente " & _
        "join ProgramasPorIndicadorDeMeta PIM on IM.IdIndicadorDeMeta=PIM.IdIndicadorDeMeta " & _
        "join vProyectos Pro ON PIM.IdPrograma=Pro.codigo_ficha where Pol.[IdPolitica]=@IdPolitica And Pol.Activo=1 Order by Pro.NombreProyecto "

        Me.SqlInstrumentos.SelectCommand = " select IdInstrumentoDeEvaluacion,NombreInstrumento,Ano from InstrumentosDeEvaluacion Where IdPrograma=@IdPrograma And Activo=1 order by NombreInstrumento,Ano "


        Me.SqlAplicacion.SelectCommand = " select AI.IdAplicacionInstrumento,MA.DescripcionMomento,AI.UsaFSU,AI.FechaAplicacion,IE.IdInstrumentoDeEvaluacion from InstrumentosDeEvaluacion IE " & _
        "join AplicacionInstrumento AI on IE.IdInstrumentoDeEvaluacion= AI.IdInstrumentoDeEvaluacion " & _
        "join MomentosDeAplicacion MA on MA.IdMomentoDeAplicacion=IdMomentoAplicacion where AI.[IdInstrumentoDeEvaluacion]=@IdInstrumento and AI.[Activo]=1 and IE.Activo=1"


        Me.SqlDataSourceCabeceras.SelectCommand = "select AI.IdAplicacionInstrumento,I.DescripcionIndicador,M.DescripcionMunicipio,D.DescripcionDepartamento,VM.Valor,MG.Latitud,MG.Longitud from AplicacionInstrumento AI " & _
        "join ValoresMunicipio VM on AI.IdAplicacionInstrumento = VM.IdAplicacionInstrumento " & _
        "join IndicadoresEvaluacionPorPrograma IEP on VM.IdIndicadorEvaluacionPorPrograma = IEP.IdIndicadoresEvaluacionPorPrograma " & _
        "join Indicadores I on IEP.IdIndicador = I.IdIndicador " & _
        "join vMunicipios M on VM.IdDepartamento = M.IdDepartamento and VM.IdMunicipio=M.IdMunicipio " & _
        "join vDepartamentos D on VM.IdDepartamento=D.IdDepartamento " & _
        "join MunicipiosGeoreferenciados MG on M.IdMunicipio = MG.IdMunicipio where AI.IdAplicacionInstrumento=@IdAplicacionInstrumento"

    End Sub


    Protected Sub GridIndicadores_HtmlDataCellPrepared(sender As Object, e As ASPxGridViewTableDataCellEventArgs)

        If e.DataColumn.Name = "Valor" Then

            Session("Porcenta1") = Convert.ToDouble(e.CellValue)

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

    End Sub


    Protected Sub DataGrid_CustomCallback(sender As Object, e As ASPxGridViewCustomCallbackEventArgs)


        Me.SqlDataSourceCabeceras.SelectParameters(0).DefaultValue = Session("IdAplicacionInstrumento")
        Me.SqlDataSourceCabeceras.DataBind()
        Me.DataGrid.DataBind()
    End Sub

    Protected Sub link1_Click(sender As Object, e As EventArgs)



        Dim IndexPolitica As Integer
        Dim IndexPrograma As Integer
        Dim IndexInstrumento As Integer
        Dim IndexAplicacion As Integer

        For i As Integer = 0 To Me.GridPolitica.VisibleRowCount - 1

            Dim IPolitica As Integer = CInt(GridPolitica.GetRowValues(i, "IdPolitica"))

            If (IPolitica = Session("IdPolitica")) Then
                IndexPolitica = i

            End If

        Next


        Dim GridDetallePrograma As ASPxGridView = TryCast(GridPolitica.FindDetailRowTemplateControl(IndexPolitica, "GridPrograma"), ASPxGridView)


        For i As Integer = 0 To GridDetallePrograma.VisibleRowCount - 1

            Dim IPrograma As Integer = CInt(GridDetallePrograma.GetRowValues(i, "codigo_ficha"))

            If (IPrograma = Session("IdPrograma")) Then
                IndexPrograma = i

            End If

        Next

        Dim GridDetalleInstrumento As ASPxGridView = TryCast(GridDetallePrograma.FindDetailRowTemplateControl(IndexPrograma, "GridInstrumentos"), ASPxGridView)


        For i As Integer = 0 To GridDetalleInstrumento.VisibleRowCount - 1

            Dim IInstrumento As Integer = CInt(GridDetalleInstrumento.GetRowValues(i, "IdInstrumentoDeEvaluacion"))

            If (IInstrumento = Session("IdInstrumento")) Then
                IndexInstrumento = i

            End If

        Next

        Dim GridDetalleAplicacion As ASPxGridView = TryCast(GridDetalleInstrumento.FindDetailRowTemplateControl(IndexInstrumento, "GridAplicacion"), ASPxGridView)

        IndexAplicacion = GridDetalleAplicacion.FocusedRowIndex()
        'Session("IdAplicacion") = CInt(GridDetalleAplicacion.GetRowValues(IndexAplicacion, "IdAplicacionInstrumento"))


        Dim IdAplicacion As Integer = CInt(GridDetalleAplicacion.GetRowValues(IndexAplicacion, "IdAplicacionInstrumento"))

        Me.SqlDataSourceCabeceras.SelectParameters(0).DefaultValue = IdAplicacion
        Me.SqlDataSourceCabeceras.DataBind()
        Me.DataGrid.DataBind()
    End Sub


    Protected Sub DataGrid_Load(sender As Object, e As EventArgs)
        'Me.SqlDataSourceCabeceras.SelectParameters(0).DefaultValue = Session("IdAplicacion")
        'Me.SqlDataSourceCabeceras.DataBind()
        'Me.DataGrid.DataBind()
    End Sub

    Protected Sub ASPxGridView2_BeforePerformDataSelect(sender As Object, e As EventArgs)

        Session("IdPolitica") = CType(sender, ASPxGridView).GetMasterRowKeyValue()
        Me.SqlPrograma.SelectParameters(0).DefaultValue = Session("IdPolitica")
        Me.SqlPrograma.DataBind()


    End Sub



    Protected Sub ASPxGridView3_BeforePerformDataSelect(sender As Object, e As EventArgs)

        Session("IdInstrumento") = CType(sender, ASPxGridView).GetMasterRowKeyValue()
        Me.SqlAplicacion.SelectParameters(0).DefaultValue = Session("IdInstrumento")
        Me.SqlAplicacion.DataBind()


    End Sub

    Protected Sub GridInstrumentos_BeforePerformDataSelect(sender As Object, e As EventArgs)

        Session("IdPrograma") = CType(sender, ASPxGridView).GetMasterRowKeyValue()

        SqlInstrumentos.SelectParameters(0).DefaultValue = Session("IdPrograma")
        SqlInstrumentos.DataBind()

    End Sub

    Protected Sub cbAll_Init(sender As Object, e As EventArgs)
        Dim chk As ASPxCheckBox = TryCast(sender, ASPxCheckBox)
        Dim grid As ASPxGridView = (TryCast(chk.NamingContainer, GridViewHeaderTemplateContainer).Grid)
        chk.Checked = (grid.Selection.Count = grid.VisibleRowCount)
    End Sub
End Class
