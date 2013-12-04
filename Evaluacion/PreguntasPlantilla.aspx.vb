Imports DevExpress.Web.ASPxGridView
Imports System.Web.Configuration
Imports System.Data.Common

Partial Class Cuantitativo_PreguntasPlantilla
    Inherits System.Web.UI.Page



    Protected Sub form1_Load(sender As Object, e As EventArgs)
        Session("IdPlantilla") = Request.QueryString.Get(0)
        SqlDataSource1.SelectParameters(0).DefaultValue = Session("IdPlantilla")
        SqlDataSource1.InsertParameters(0).DefaultValue = Session("IdPlantilla")
        SqlDataSource1.UpdateParameters(0).DefaultValue = Session("IdPlantilla")
        SqlDataSource1.DeleteParameters(0).DefaultValue = Session("IdPlantilla")

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
