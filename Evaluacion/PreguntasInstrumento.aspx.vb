Imports DevExpress.Web.ASPxGridView
Imports System.Web.Configuration
Imports System.Data.Common

Partial Class Cuantitativo_PreguntasInstrumento
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(sender As Object, e As EventArgs) Handles Me.Load
        'Verifica si el usuario tiene el acceso a la pagina solicitada
        'Using dtMOCA As System.Data.DataTable = fMOCA.CheckPageAccess(3.05) 'este es el Id definido en el MOCA
        '    If dtMOCA.Rows.Count() > 0 Then
        '        ''Activa o Inactiva los objetos,(sean botones, grid, hiperlinks, etc),  
        '        ''en la pagina que se indique deacuerdo al parametro indicado
        '        'btnAgregar.Visible = dtMOCA.Rows.Item(0).Item("AllowAdd")

        '        ''Los siguientes datos pueden ser cambiados por los nombres de Objetos a los que corresponde la acción que se desea realizar, 
        '        ''si no hay necesidad de utilizar esta sección silo la eliminan dejandola en blanco y solo evaluando el acceso a la pagina
        '        'btnModificar.Visible = dtMOCA.Rows.Item(0).Item("AllowUpdate")
        '        'btnEliminar.Visible = dtMOCA.Rows.Item(0).Item("AllowDelete")
        '        'btnAutorizar.Visible = dtMOCA.Rows.Item(0).Item("AllowAction01")
        '        ''Object5.Visible = dtMOCA.Rows.Item(0).Item("AllowAction02")
        '        ''Object6.Visible = dtMOCA.Rows.Item(0).Item("AllowAction03")
        '        ''Object7.Visible = dtMOCA.Rows.Item(0).Item("AllowAction04")
        '        ''Object8.Visible = dtMOCA.Rows.Item(0).Item("AllowAction05")
        '        ''Object9.Visible = dtMOCA.Rows.Item(0).Item("AllowAction06")
        '        ''Object10.Visible = dtMOCA.Rows.Item(0).Item("AllowAction07")

        '        'Para activar o desactivar los botones en un ASPxGridView preferiblemente use variables de sessión
        '        Session("AllowAdd") = dtMOCA.Rows.Item(0).Item("AllowAdd")
        '        Session("AllowUpdate") = dtMOCA.Rows.Item(0).Item("AllowUpdate")
        '        Session("AllowDelete") = dtMOCA.Rows.Item(0).Item("AllowDelete")
        '    Else
        '        'Si no se recupero ningun dato se entendera que el usuario no tiene acceso a la pagina solicitada
        '        'y sera redireccionado a la Pagina siguiente que le notifica al usuario que no tiene acceso
        '        Response.Redirect("~/NoAccess.aspx")
        '    End If


        'End Using
        Session("IdInstrumento") = uf.QueryStringDecode(Request.QueryString.Get(0))
        Session("NomInstrumento") = uf.QueryStringDecode(Request.QueryString.Get(1))
        ASPxLabelTitulo.Text = "Definir Preguntas de Instrumento " + Session("NomInstrumento")
        SqlPreguntas.SelectParameters(0).DefaultValue = Session("IdInstrumento")
        SqlPreguntas.InsertParameters(0).DefaultValue = Session("IdInstrumento")
        SqlPreguntas.InsertParameters(8).DefaultValue = Membership.GetUser.UserName
        SqlPreguntas.UpdateParameters(8).DefaultValue = Membership.GetUser.UserName
        SqlDataSourceOpciones.InsertParameters(4).DefaultValue = Membership.GetUser.UserName

    End Sub

    Protected Sub ASPxGridViewOpciones_BeforePerformDataSelect(sender As Object, e As EventArgs)
        Session("IdPreguntaInstrumento") = CType(sender, ASPxGridView).GetMasterRowKeyValue()
        SqlDataSourceOpciones.SelectParameters(0).DefaultValue = Session("IdPreguntaInstrumento")
        SqlDataSourceOpciones.InsertParameters(0).DefaultValue = Session("IdPreguntaInstrumento")

    End Sub

    Protected Function IsGridOpcionesVisible(ByVal IdPreguntaInstrumento As Object) As Boolean
        Dim Tipo As Integer = GridPreguntas.GetRowValuesByKeyValue(IdPreguntaInstrumento, "IdTipoDePregunta")
        Return (3 = Tipo Or 4 = Tipo Or 5 = Tipo Or 6 = Tipo Or 7 = Tipo)
    End Function


    Protected Sub AsociarPlantilla(sender As Object, e As EventArgs)

        Dim index As Integer = GridPlantilla.FocusedRowIndex()

        Session("IdPlantilla") = GridPlantilla.GetRowValues(index, "IdPlantilla").ToString()

        SqlPreguntasPlantillas.SelectParameters(0).DefaultValue = Session("IdPlantilla")
        SqlPreguntasPlantillas.DataBind()

        Me.GridPreguntasPlantilla.DataBind()


        Dim sizegrid As Integer = Me.GridPreguntasPlantilla.VisibleRowCount()

        If sizegrid > 0 Then

            For i As Integer = 0 To sizegrid - 1

                SqlPreguntasI.InsertParameters(0).DefaultValue = Session("IdInstrumento")
                SqlPreguntasI.InsertParameters(1).DefaultValue = Me.GridPreguntasPlantilla.GetRowValues(i, "IdTipoDePregunta")
                SqlPreguntasI.InsertParameters(2).DefaultValue = Me.GridPreguntasPlantilla.GetRowValues(i, "IdSeccionFSU")
                SqlPreguntasI.InsertParameters(3).DefaultValue = Me.GridPreguntasPlantilla.GetRowValues(i, "PreguntaDePlantilla")
                SqlPreguntasI.InsertParameters(4).DefaultValue = Me.GridPreguntasPlantilla.GetRowValues(i, "Orden")
                SqlPreguntasI.InsertParameters(5).DefaultValue = Me.GridPreguntasPlantilla.GetRowValues(i, "Requerida")
                SqlPreguntasI.InsertParameters(6).DefaultValue = Me.GridPreguntasPlantilla.GetRowValues(i, "IdTipoDeRespuesta")
                SqlPreguntasI.InsertParameters(7).DefaultValue = Me.GridPreguntasPlantilla.GetRowValues(i, "IdAmigable")
                SqlPreguntasI.InsertParameters(8).DefaultValue = Membership.GetUser.UserName
                SqlPreguntasI.Insert()



                Session("IdPreguntaPorPlantilla") = Me.GridPreguntasPlantilla.GetRowValues(i, "IdPreguntaPorPlantilla")

                Dim Tipo As Integer = Me.GridPreguntasPlantilla.GetRowValues(i, "IdTipoDePregunta")

                If (3 = Tipo Or 4 = Tipo Or 5 = Tipo Or 6 = Tipo Or 7 = Tipo) Then

                    SqlOpcionesPlantilla.SelectParameters(0).DefaultValue = Session("IdPreguntaPorPlantilla")
                    SqlOpcionesPlantilla.DataBind()
                    Me.GridOpcionesPlantilla.DataBind()



                    If (Me.GridOpcionesPlantilla.VisibleRowCount() > 0) Then

                        For j As Integer = 0 To Me.GridOpcionesPlantilla.VisibleRowCount() - 1

                            SqlDataSourceOpciones.InsertParameters(0).DefaultValue = Session("IdPreguntaInstrumento")
                            SqlDataSourceOpciones.InsertParameters(1).DefaultValue = Me.GridOpcionesPlantilla.GetRowValues(j, "Opcion")
                            SqlDataSourceOpciones.InsertParameters(2).DefaultValue = Me.GridOpcionesPlantilla.GetRowValues(j, "Valor")
                            SqlDataSourceOpciones.InsertParameters(4).DefaultValue = Membership.GetUser.UserName

                            If (IsDBNull(Me.GridOpcionesPlantilla.GetRowValues(j, "SaltaACodigo"))) Then

                            Else

                                SqlDataSourceOpciones.InsertParameters(3).DefaultValue = Me.GridOpcionesPlantilla.GetRowValues(j, "SaltaACodigo")

                            End If

                            SqlDataSourceOpciones.Insert()

                        Next



                    End If

                End If

            Next

        End If

        SqlPreguntas.SelectParameters(0).DefaultValue = Session("IdInstrumento")
        SqlPreguntas.DataBind()
        Me.GridPreguntas.DataBind()






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
                SqlDataSourceOpciones.InsertParameters(2).DefaultValue = 99
                SqlDataSourceOpciones.InsertParameters(4).DefaultValue = Membership.GetUser.UserName
                SqlDataSourceOpciones.Insert()
                SqlDataSourceOpciones.DataBind()


            End If

            If command.Parameters("@IdTipoDePregunta").Value = 7 Then

                SqlDataSourceOpciones.InsertParameters(0).DefaultValue = command.Parameters("@IdPreguntaPorInstrumento").Value
                SqlDataSourceOpciones.InsertParameters(1).DefaultValue = "Si"
                SqlDataSourceOpciones.InsertParameters(2).DefaultValue = 1
                SqlDataSourceOpciones.InsertParameters(4).DefaultValue = Membership.GetUser.UserName
                SqlDataSourceOpciones.Insert()
                SqlDataSourceOpciones.DataBind()

                SqlDataSourceOpciones.InsertParameters(0).DefaultValue = command.Parameters("@IdPreguntaPorInstrumento").Value
                SqlDataSourceOpciones.InsertParameters(1).DefaultValue = "No"
                SqlDataSourceOpciones.InsertParameters(2).DefaultValue = 2
                SqlDataSourceOpciones.InsertParameters(4).DefaultValue = Membership.GetUser.UserName
                SqlDataSourceOpciones.Insert()
                SqlDataSourceOpciones.DataBind()

            End If

        End If

    End Sub

   

End Class