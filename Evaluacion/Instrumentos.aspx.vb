Imports DevExpress.Web.ASPxGridView
Imports System.Windows.Forms

Partial Class Cuantitativo_Default
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


            Session("IdPrograma") = Nothing

            Me.SqlPrograma.SelectCommand = "select DISTINCT(Pol.IdPolitica), Pol.Nombre, Pro.codigo_ficha, Pro.NombreProyecto, Pro.codigo_proyecto from Politicas Pol " & _
        "join ComponentesDePolitica CP on Pol.IdPolitica=CP.IdPolitica " & _
        "join MetasDeComponente MC on CP.IdComponentesDePolitica=MC.IdComponentesDePolitica " & _
        "join IndicadoresDeMeta IM on MC.IdMetasDeComponente=IM.IdMetasDeComponente " & _
        "join ProgramasPorIndicadorDeMeta PIM on IM.IdIndicadorDeMeta=PIM.IdIndicadorDeMeta " & _
        "join vProyectos Pro ON PIM.IdPrograma=Pro.codigo_ficha where Pol.[IdPolitica]=@IdPolitica"


        End Using
    End Sub

    Protected Sub ASPxGridView2_BeforePerformDataSelect(sender As Object, e As EventArgs)

        Session("IdPolitica") = CType(sender, ASPxGridView).GetMasterRowKeyValue()
        Me.SqlPrograma.SelectParameters(0).DefaultValue = Session("IdPolitica")
        Me.SqlPrograma.DataBind()

        Session("indexpolitica") = GridPolitica.FocusedRowIndex()

    End Sub

    Protected Sub link1_Click(sender As Object, e As EventArgs)



        Dim detail As ASPxGridView = TryCast(GridPolitica.FindDetailRowTemplateControl(Session("indexpolitica"), "GridPrograma"), ASPxGridView)

        Dim index As Integer = detail.FocusedRowIndex()

        Dim codprograma As String = detail.GetRowValues(index, "codigo_ficha").ToString()

        Dim nombreprograma As String = detail.GetRowValues(index, "NombreProyecto").ToString()

        Response.Redirect("InstrumentosEvaluacion.aspx?CodP=" + uf.QueryStringEncode(codprograma) + "&NomP=" + uf.QueryStringEncode(nombreprograma))




    End Sub

    Protected Sub LinkButton1_Click(sender As Object, e As EventArgs)

        Dim detail As ASPxGridView = TryCast(GridPolitica.FindDetailRowTemplateControl(Session("indexpolitica"), "GridPrograma"), ASPxGridView)

        Dim index As Integer = detail.FocusedRowIndex()

        Dim codprograma As String = detail.GetRowValues(index, "codigo_ficha").ToString()

        Dim nombreprograma As String = detail.GetRowValues(index, "NombreProyecto").ToString()

        Response.Redirect("IndicadoresEvaluacion.aspx?CodP=" + uf.QueryStringEncode(codprograma) + "&NomP=" + uf.QueryStringEncode(nombreprograma))

    End Sub
    Protected Sub Documento_Click(sender As Object, e As EventArgs)

        Dim detail As ASPxGridView = TryCast(GridPolitica.FindDetailRowTemplateControl(Session("indexpolitica"), "GridPrograma"), ASPxGridView)

        Dim index As Integer = detail.FocusedRowIndex()

        Dim codprograma As String = detail.GetRowValues(index, "codigo_ficha").ToString()

        Dim nombreprograma As String = detail.GetRowValues(index, "NombreProyecto").ToString()




        Response.Redirect("DocumentosEvaluacion.aspx?CodP=" + uf.QueryStringEncode(codprograma) + "&NomP=" + uf.QueryStringEncode(nombreprograma))
        'Response.Redirect("DocumentosEvaluacion.aspx?CodP=113" + "&NomP=" + nombreprograma)

    End Sub
End Class
