Imports System.Web.Configuration
Imports System.Data.Common

Partial Class Cuantitativo_InstrumentosEvaluacion
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

            Session("IdPrograma") = Request.QueryString.Get(0)
            Session("NombrePrograma") = Request.QueryString.Get(1)

            Me.Programa.Text = "Crear Instrumento de Evaluación Programa < " + Session("NombrePrograma") + " >"

            SqlDataSource1.SelectCommand = "SELECT * FROM [InstrumentosDeEvaluacion] where [IdPrograma]=@IdPrograma and [Activo]=1"
            SqlDataSource1.InsertCommand = "Insert INTO [InstrumentosDeEvaluacion] ([IdPrograma], [NombreInstrumento],[DescripcionInstrumento],[Ano],[CreadoPor], [FechaCreacion], [Activo]) VALUES (@IdPrograma, @NombreInstrumento,@DescripcionInstrumento,@Ano,'PACO', getDate(), 1)"
            SqlDataSource1.UpdateCommand = "UPDATE [InstrumentosDeEvaluacion] SET [NombreInstrumento]=@NombreInstrumento, [DescripcionInstrumento]=@DescripcionInstrumento,[ActualizadoPor]='PACO',[FechaActualizacion]=getDate(),[Ano]=@Ano WHERE [IdInstrumentoDeEvaluacion]=@IdInstrumentoDeEvaluacion"
            SqlDataSource1.DeleteCommand = "UPDATE [InstrumentosDeEvaluacion] SET [Activo]=0 WHERE [IdInstrumentoDeEvaluacion]=@IdInstrumentoDeEvaluacion"

            SqlDataSource1.SelectParameters(0).DefaultValue = Session("IdPrograma")
            SqlDataSource1.InsertParameters(0).DefaultValue = Session("IdPrograma")


        End Using
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
