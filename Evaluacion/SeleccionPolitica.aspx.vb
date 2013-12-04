Imports DevExpress.Web.ASPxGridView
Imports System.Windows.Forms

Partial Class Cuantitativo_Default
    Inherits System.Web.UI.Page

    Protected Sub ASPxGridView2_BeforePerformDataSelect(sender As Object, e As EventArgs)

        Session("IdPolitica") = CType(sender, ASPxGridView).GetMasterRowKeyValue()
        Me.SqlDataSource2.SelectParameters(0).DefaultValue = Session("IdPolitica")
        Me.SqlDataSource2.DataBind()

        Session("indexpolitica") = ASPxGridView1.FocusedRowIndex()

    End Sub

    Protected Sub form1_Load(sender As Object, e As EventArgs)

        Me.SqlDataSource2.SelectCommand = "select DISTINCT(Pol.IdPolitica), Pol.Nombre, Pro.codigo_ficha, Pro.NombreProyecto, Pro.codigo_proyecto from Politicas Pol " & _
    "join ComponentesDePolitica CP on Pol.IdPolitica=CP.IdPolitica " & _
    "join MetasDeComponente MC on CP.IdComponentesDePolitica=MC.IdComponentesDePolitica " & _
    "join IndicadoresDeMeta IM on MC.IdMetasDeComponente=IM.IdMetasDeComponente " & _
    "join ProgramasPorIndicadorDeMeta PIM on IM.IdIndicadorDeMeta=PIM.IdIndicadorDeMeta " & _
    "join vProyectos Pro ON PIM.IdPrograma=Pro.codigo_ficha where Pol.[IdPolitica]=@IdPolitica"
    End Sub

    Protected Sub link1_Click(sender As Object, e As EventArgs)

        Dim detail As ASPxGridView = TryCast(ASPxGridView1.FindDetailRowTemplateControl(Session("indexpolitica"), "ASPxGridView2"), ASPxGridView)

        Dim index As Integer = detail.FocusedRowIndex()

        Dim codprograma As String = detail.GetRowValues(index, "codigo_ficha").ToString()

        Dim nombreprograma As String = detail.GetRowValues(index, "NombreProyecto").ToString()

        Response.Redirect("InstrumentosEvaluacion.aspx?CodP=" + codprograma + "&NomP=" + nombreprograma)




    End Sub

    Protected Sub LinkButton1_Click(sender As Object, e As EventArgs)

        Dim detail As ASPxGridView = TryCast(ASPxGridView1.FindDetailRowTemplateControl(Session("indexpolitica"), "ASPxGridView2"), ASPxGridView)

        Dim index As Integer = detail.FocusedRowIndex()

        Dim codprograma As String = detail.GetRowValues(index, "codigo_ficha").ToString()

        Dim nombreprograma As String = detail.GetRowValues(index, "NombreProyecto").ToString()

        Response.Redirect("IndicadoresEvaluacion.aspx?CodP=" + codprograma + "&NomP=" + nombreprograma)

    End Sub
End Class
