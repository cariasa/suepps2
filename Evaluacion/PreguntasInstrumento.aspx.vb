Imports DevExpress.Web.ASPxGridView
Imports System.Web.Configuration
Imports System.Data.Common

Partial Class Cuantitativo_PreguntasInstrumento
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

            Session("IdInstrumento") = uf.QueryStringDecode(Request.QueryString.Get(0))
            Session("NomInstrumento") = uf.QueryStringDecode(Request.QueryString.Get(1))
            ASPxLabelTitulo.Text = "Definir Preguntas de Instrumento " + Session("NomInstrumento")
            SqlDataSource1.SelectParameters(0).DefaultValue = Session("IdInstrumento")
            SqlDataSource1.InsertParameters(0).DefaultValue = Session("IdInstrumento")


        End Using
    End Sub

    Protected Sub ASPxGridViewOpciones_BeforePerformDataSelect(sender As Object, e As EventArgs)
        Session("IdPreguntaInstrumento") = CType(sender, ASPxGridView).GetMasterRowKeyValue()
        SqlDataSourceOpciones.SelectParameters(0).DefaultValue = Session("IdPreguntaInstrumento")
        SqlDataSourceOpciones.InsertParameters(0).DefaultValue = Session("IdPreguntaInstrumento")

    End Sub

    Protected Function IsGridOpcionesVisible(ByVal IdPreguntaInstrumento As Object) As Boolean
        Dim Tipo As Integer = ASPxGridView1.GetRowValuesByKeyValue(IdPreguntaInstrumento, "IdTipoDePregunta")
        Return (3 = Tipo Or 4 = Tipo Or 5 = Tipo Or 6 = Tipo Or 7 = Tipo)
    End Function


    Protected Sub AsociarPlantilla(sender As Object, e As EventArgs)

        Dim index As Integer = ASPxGridView4.FocusedRowIndex()

        Session("IdPlantilla") = ASPxGridView4.GetRowValues(index, "IdPlantilla").ToString

        SqlDataSource2.SelectParameters(0).DefaultValue = Session("IdPlantilla")
        SqlDataSource2.DataBind()

        Me.ASPxGridView2.DataBind()


        Dim sizegrid As Integer = Me.ASPxGridView2.VisibleRowCount()

        If sizegrid > 0 Then

            For i As Integer = 0 To sizegrid - 1

                SqlDataSource3.InsertParameters(0).DefaultValue = Session("IdInstrumento")
                SqlDataSource3.InsertParameters(1).DefaultValue = Me.ASPxGridView2.GetRowValues(i, "IdTipoDePregunta")
                SqlDataSource3.InsertParameters(2).DefaultValue = Me.ASPxGridView2.GetRowValues(i, "IdSeccionFSU")
                SqlDataSource3.InsertParameters(3).DefaultValue = Me.ASPxGridView2.GetRowValues(i, "PreguntaDePlantilla")
                SqlDataSource3.InsertParameters(4).DefaultValue = Me.ASPxGridView2.GetRowValues(i, "Orden")
                SqlDataSource3.InsertParameters(5).DefaultValue = Me.ASPxGridView2.GetRowValues(i, "Requerida")
                SqlDataSource3.InsertParameters(6).DefaultValue = Me.ASPxGridView2.GetRowValues(i, "IdTipoDeRespuesta")
                SqlDataSource3.InsertParameters(7).DefaultValue = Me.ASPxGridView2.GetRowValues(i, "IdAmigable")
                SqlDataSource3.Insert()



                Session("IdPreguntaPorPlantilla") = Me.ASPxGridView2.GetRowValues(i, "IdPreguntaPorPlantilla")

                Dim Tipo As Integer = Me.ASPxGridView2.GetRowValues(i, "IdTipoDePregunta")

                If (3 = Tipo Or 4 = Tipo Or 5 = Tipo Or 6 = Tipo Or 7 = Tipo) Then

                    SqlDataSource4.SelectParameters(0).DefaultValue = Session("IdPreguntaPorPlantilla")
                    SqlDataSource4.DataBind()
                    Me.ASPxGridView3.DataBind()



                    If (Me.ASPxGridView3.VisibleRowCount() > 0) Then

                        For j As Integer = 0 To Me.ASPxGridView3.VisibleRowCount() - 1

                            SqlDataSourceOpciones.InsertParameters(0).DefaultValue = Session("IdPreguntaInstrumento")
                            SqlDataSourceOpciones.InsertParameters(1).DefaultValue = Me.ASPxGridView3.GetRowValues(j, "Opcion")
                            SqlDataSourceOpciones.InsertParameters(2).DefaultValue = Me.ASPxGridView3.GetRowValues(j, "Valor")

                            If (IsDBNull(Me.ASPxGridView3.GetRowValues(j, "SaltaACodigo"))) Then

                            Else

                                SqlDataSourceOpciones.InsertParameters(3).DefaultValue = Me.ASPxGridView3.GetRowValues(j, "SaltaACodigo")

                            End If

                            SqlDataSourceOpciones.Insert()

                        Next



                    End If

                End If

            Next

        End If

        SqlDataSource1.SelectParameters(0).DefaultValue = Session("IdInstrumento")
        SqlDataSource1.DataBind()
        Me.ASPxGridView1.DataBind()






    End Sub

    Protected Sub SqlDataSource3_Inserted(sender As Object, e As SqlDataSourceStatusEventArgs)

        Dim sqlConnection1 As New System.Data.SqlClient.SqlConnection(WebConfigurationManager.ConnectionStrings("SUEPPSConnectionString").ConnectionString)
        Dim command As DbCommand
        command = e.Command

        If IsDBNull(command.Parameters("@IdPreguntaPorInstrumento").Value) Then

        Else

            Session("IdPreguntaInstrumento") = command.Parameters("@IdPreguntaPorInstrumento").Value

        End If

    End Sub


    Protected Sub SqlDataSource1_Inserted(sender As Object, e As SqlDataSourceStatusEventArgs)

        Dim sqlConnection1 As New System.Data.SqlClient.SqlConnection(WebConfigurationManager.ConnectionStrings("SUEPPSConnectionString").ConnectionString)
        Dim command As DbCommand
        command = e.Command


        If IsDBNull(command.Parameters("@IdPreguntaPorInstrumento").Value) Then

        Else

            If command.Parameters("@IdTipoDePregunta").Value = 5 Or command.Parameters("@IdTipoDePregunta").Value = 6 Then

                SqlDataSourceOpciones.InsertParameters(0).DefaultValue = command.Parameters("@IdPreguntaPorInstrumento").Value
                SqlDataSourceOpciones.InsertParameters(1).DefaultValue = "Otro"
                SqlDataSourceOpciones.InsertParameters(2).DefaultValue = 0
                SqlDataSourceOpciones.Insert()
                SqlDataSourceOpciones.DataBind()


            End If

            If command.Parameters("@IdTipoDePregunta").Value = 7 Then

                SqlDataSourceOpciones.InsertParameters(0).DefaultValue = command.Parameters("@IdPreguntaPorInstrumento").Value
                SqlDataSourceOpciones.InsertParameters(1).DefaultValue = "Si"
                SqlDataSourceOpciones.InsertParameters(2).DefaultValue = 1
                SqlDataSourceOpciones.Insert()
                SqlDataSourceOpciones.DataBind()

                SqlDataSourceOpciones.InsertParameters(0).DefaultValue = command.Parameters("@IdPreguntaPorInstrumento").Value
                SqlDataSourceOpciones.InsertParameters(1).DefaultValue = "No"
                SqlDataSourceOpciones.InsertParameters(2).DefaultValue = 2
                SqlDataSourceOpciones.Insert()
                SqlDataSourceOpciones.DataBind()

            End If

        End If

    End Sub
End Class