Imports DevExpress.Web.ASPxGridView

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

            Me.SqlDataSource2.SelectCommand = "select DISTINCT(Pol.IdPolitica), Pol.Nombre, Pro.codigo_ficha, Pro.NombreProyecto, Pro.codigo_proyecto,IE.Ano,IE.NombreInstrumento,IE.IdInstrumentoDeEvaluacion from Politicas Pol " & _
       "join ComponentesDePolitica CP on Pol.IdPolitica=CP.IdPolitica " & _
       "join MetasDeComponente MC on CP.IdComponentesDePolitica=MC.IdComponentesDePolitica " & _
       "join IndicadoresDeMeta IM on MC.IdMetasDeComponente=IM.IdMetasDeComponente " & _
       "join ProgramasPorIndicadorDeMeta PIM on IM.IdIndicadorDeMeta=PIM.IdIndicadorDeMeta " & _
       "join vProyectos Pro ON PIM.IdPrograma=Pro.codigo_ficha " & _
       "join InstrumentosDeEvaluacion IE ON Pro.codigo_ficha= IE.IdPrograma where Pol.[IdPolitica]=@IdPolitica "

            Me.SqlDataSource3.SelectCommand = " select AI.IdAplicacionInstrumento,MA.DescripcionMomento,AI.UsaFSU,AI.FechaAplicacion,IE.IdInstrumentoDeEvaluacion from InstrumentosDeEvaluacion IE " & _
            "join AplicacionInstrumento AI on IE.IdInstrumentoDeEvaluacion= AI.IdInstrumentoDeEvaluacion " & _
            "join MomentosDeAplicacion MA on MA.IdMomentoDeAplicacion=IdMomentoAplicacion where AI.[IdInstrumentoDeEvaluacion]=@IdInstrumento and AI.[Activo]=1 "

            Me.SqlDataSource4.SelectCommand = "select distinct(IND.IdIndicador),IND.DescripcionIndicador from IndicadoresEvaluacionPorPrograma INE " & _
                "join Indicadores IND on IND.IdIndicador= INE.IdIndicador where INE.[IdPrograma]= @IdPrograma"



        End Using

    End Sub


    Protected Sub ASPxGridView2_BeforePerformDataSelect(sender As Object, e As EventArgs)

        Session("IdPolitica") = CType(sender, ASPxGridView).GetMasterRowKeyValue()
        Me.SqlDataSource2.SelectParameters(0).DefaultValue = Session("IdPolitica")
        Me.SqlDataSource2.DataBind()

        Session("indexpolitica") = ASPxGridView1.FocusedRowIndex()

    End Sub



    Protected Sub ASPxGridView3_BeforePerformDataSelect(sender As Object, e As EventArgs)

        Session("IdInstrumento") = CType(sender, ASPxGridView).GetMasterRowKeyValue()
        Me.SqlDataSource3.SelectParameters(0).DefaultValue = Session("IdInstrumento")
        Me.SqlDataSource3.DataBind()

        Dim detail As ASPxGridView = TryCast(ASPxGridView1.FindDetailRowTemplateControl(ASPxGridView1.FocusedRowIndex(), "ASPxGridView2"), ASPxGridView)

        Dim index As Integer = detail.FocusedRowIndex()

        Session("IdPrograma") = detail.GetRowValues(index, "codigo_ficha")




    End Sub

    Protected Sub ASPxGridView3_HtmlDataCellPrepared(sender As Object, e As ASPxGridViewTableDataCellEventArgs)

        If e.DataColumn.FieldName = "UsaFSU" Then

            If IsDBNull(e.CellValue) Then


            Else

                If e.CellValue.ToString() = "True" Then

                    e.Cell.Text = "Revisión Social Integral"

                Else

                    e.Cell.Text = "Gestión Pública"


                End If
            End If


        End If

    End Sub

    Protected Sub ASPxGridView4_BeforePerformDataSelect(sender As Object, e As EventArgs)

        Me.SqlDataSource4.SelectParameters(0).DefaultValue = Session("IdPrograma")
        Me.SqlDataSource4.DataBind()


    End Sub
End Class
