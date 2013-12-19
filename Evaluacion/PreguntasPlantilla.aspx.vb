Imports DevExpress.Web.ASPxGridView
Imports System.Web.Configuration
Imports System.Data.Common

Partial Class Cuantitativo_PreguntasPlantilla
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

            Session("IdPlantilla") = uf.QueryStringDecode(Request.QueryString.Get(0))
            Session("NomPlantilla") = uf.QueryStringDecode(Request.QueryString.Get(1))
            ASPxLabelTitulo.Text = "Definir Preguntas de Plantilla " + Session("NomPlantilla")
            SqlDataSource1.SelectParameters(0).DefaultValue = Session("IdPlantilla")
            SqlDataSource1.InsertParameters(0).DefaultValue = Session("IdPlantilla")
            SqlDataSource1.UpdateParameters(0).DefaultValue = Session("IdPlantilla")
            SqlDataSource1.DeleteParameters(0).DefaultValue = Session("IdPlantilla")


        End Using
    End Sub


    Protected Sub ASPxGridViewOpciones_BeforePerformDataSelect(sender As Object, e As EventArgs)
        Session("IdPreguntaPlantilla") = CType(sender, ASPxGridView).GetMasterRowKeyValue()
        SqlDataSourceOpciones.SelectParameters(0).DefaultValue = Session("IdPreguntaPlantilla")
        SqlDataSourceOpciones.InsertParameters(0).DefaultValue = Session("IdPreguntaPlantilla")

    End Sub

    Protected Function IsGridOpcionesVisible(ByVal IdPreguntaPlantilla As Object) As Boolean
        Dim Tipo As Integer = ASPxGridView1.GetRowValuesByKeyValue(IdPreguntaPlantilla, "IdTipoDePregunta")
        Return (3 = Tipo Or 4 = Tipo Or 5 = Tipo Or 6 = Tipo Or 7 = Tipo)
    End Function


    Protected Sub SqlDataSource1_Inserted(sender As Object, e As SqlDataSourceStatusEventArgs)

        Dim sqlConnection1 As New System.Data.SqlClient.SqlConnection(WebConfigurationManager.ConnectionStrings("SUEPPSConnectionString").ConnectionString)
        Dim command As DbCommand
        command = e.Command


        If IsDBNull(command.Parameters("@IdPreguntaPorPlantilla").Value) Then

        Else

            If command.Parameters("@IdTipoDePregunta").Value = 5 Or command.Parameters("@IdTipoDePregunta").Value = 6 Then

                SqlDataSourceOpciones.InsertParameters(0).DefaultValue = command.Parameters("@IdPreguntaPorPlantilla").Value
                SqlDataSourceOpciones.InsertParameters(1).DefaultValue = "Otro"
                SqlDataSourceOpciones.InsertParameters(2).DefaultValue = 0
                SqlDataSourceOpciones.Insert()
                SqlDataSourceOpciones.DataBind()


            End If

            If command.Parameters("@IdTipoDePregunta").Value = 7 Then

                SqlDataSourceOpciones.InsertParameters(0).DefaultValue = command.Parameters("@IdPreguntaPorPlantilla").Value
                SqlDataSourceOpciones.InsertParameters(1).DefaultValue = "Si"
                SqlDataSourceOpciones.InsertParameters(2).DefaultValue = 1
                SqlDataSourceOpciones.Insert()
                SqlDataSourceOpciones.DataBind()

                SqlDataSourceOpciones.InsertParameters(0).DefaultValue = command.Parameters("@IdPreguntaPorPlantilla").Value
                SqlDataSourceOpciones.InsertParameters(1).DefaultValue = "No"
                SqlDataSourceOpciones.InsertParameters(2).DefaultValue = 2
                SqlDataSourceOpciones.Insert()
                SqlDataSourceOpciones.DataBind()

            End If

        End If

    End Sub
End Class
