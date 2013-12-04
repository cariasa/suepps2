Imports System.Web.Configuration
Imports System.Data.Common

Partial Class Cuantitativo_InstrumentosEvaluacion
    Inherits System.Web.UI.Page

    Protected Sub form1_Load(sender As Object, e As EventArgs)



        Session("IdPrograma") = Request.QueryString.Get(0)
        Session("NombrePrograma") = Request.QueryString.Get(1)

        Me.Programa.Text = "Crear Instrumento de Evaluación Programa < " + Session("NombrePrograma") + " >"

        SqlDataSource1.SelectCommand = "SELECT * FROM [InstrumentosDeEvaluacion] where [IdPrograma]=@IdPrograma and [Activo]=1"
        SqlDataSource1.InsertCommand = "Insert INTO [InstrumentosDeEvaluacion] ([IdPrograma], [NombreInstrumento],[DescripcionInstrumento],[Ano],[CreadoPor], [FechaCreacion], [Activo]) VALUES (@IdPrograma, @NombreInstrumento,@DescripcionInstrumento,@Ano,'PACO', getDate(), 1)"
        SqlDataSource1.UpdateCommand = "UPDATE [InstrumentosDeEvaluacion] SET [NombreInstrumento]=@NombreInstrumento, [DescripcionInstrumento]=@DescripcionInstrumento,[ActualizadoPor]='PACO',[FechaActualizacion]=getDate(),[Ano]=@Ano WHERE [IdInstrumentoDeEvaluacion]=@IdInstrumentoDeEvaluacion"
        SqlDataSource1.DeleteCommand = "UPDATE [InstrumentosDeEvaluacion] SET [Activo]=0 WHERE [IdInstrumentoDeEvaluacion]=@IdInstrumentoDeEvaluacion"

        SqlDataSource1.SelectParameters(0).DefaultValue = Session("IdPrograma")
        SqlDataSource1.InsertParameters(0).DefaultValue = Session("IdPrograma")


    End Sub


   

    Protected Sub link1_Click(sender As Object, e As EventArgs)

        Dim index As Integer = ASPxGridView1.FocusedRowIndex()
        Dim codInstrumento As String = ASPxGridView1.GetRowValues(index, "IdInstrumentoDeEvaluacion").ToString
        Response.Redirect("PreguntasInstrumento.aspx?NameP=" + codInstrumento)

    End Sub

    Protected Sub link2_Click(sender As Object, e As EventArgs)

        Dim index As Integer = ASPxGridView1.FocusedRowIndex()
        Dim codInstrumento As String = ASPxGridView1.GetRowValues(index, "IdInstrumentoDeEvaluacion").ToString
        Response.Redirect("AplicacionInstrumento.aspx?NameP=" + codInstrumento)

    End Sub
End Class
