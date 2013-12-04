Imports DevExpress.Web.ASPxClasses
Imports System.Windows.Forms
Imports DevExpress.Web.ASPxGridView
Imports System.Data.Common
Imports Microsoft.VisualBasic
Imports System
Imports System.Web.UI
Imports System.Drawing
Imports System.Activities



Partial Class GestionPublica_Politica
    Inherits System.Web.UI.Page
    Dim IdPolitica As Integer
    Dim NombrePolitica As String

    
    Protected Sub grid_custom(ByVal sender As Object, ByVal e As ASPxGridViewCustomCallbackEventArgs)

     

        'If e.Parameters = "" Then

        Session("IdComponenteP") = CmbComponente.Value
        Me.SqlDataSourceMetas.SelectParameters(0).DefaultValue = CmbComponente.Value

        Me.SqlDataSourceMetas.DataBind()
        Me.ASPxGridViewMetas.DataBind()



        'Else
        '    Session("IdComponenteP") =
        '    Me.SqlDataSourceMetas.SelectParameters(0).DefaultValue = 0
        '    Me.SqlDataSourceMetas.DataBind()
        '    Me.ASPxGridViewMetas.DataBind()


        'End If





    End Sub

    Protected Sub CmbComponente_Callback(sender As Object, e As CallbackEventArgsBase)
        Me.CmbComponente.DataBind()
    End Sub



    Protected Sub cmbMetaComponente_Callback(sender As Object, e As CallbackEventArgsBase)
            SqlMetaComponente.SelectParameters(0).DefaultValue = Me.cmbComponenteI.Value
            SqlMetaComponente.DataBind()
            cmbMetaComponente.DataBind()
    End Sub

    Protected Sub GridSectorNivelIndicador_CustomCallback(sender As Object, e As ASPxGridViewCustomCallbackEventArgs)

        SqlSectorNivelIndicador.SelectParameters(0).DefaultValue = Me.cmbsector.Value
        SqlSectorNivelIndicador.SelectParameters(1).DefaultValue = Me.cmbNivel.Value
        SqlSectorNivelIndicador.DataBind()
        GridSectorNivelIndicador.DataBind()
    End Sub


    Protected Sub ASPxGridViewIndicadoresDeMeta_CustomCallback(sender As Object, e As ASPxGridViewCustomCallbackEventArgs)

            Me.SqlDataSourceIndicadoresDeMeta.SelectParameters(0).DefaultValue = cmbMetaComponente.Value

            Me.SqlDataSourceIndicadoresDeMeta.DataBind()
            Me.ASPxGridViewIndicadoresDeMeta.DataBind()
       

        
    End Sub

    Protected Sub SqlDataSourceIndicadoresDeMeta_Updated(sender As Object, e As SqlDataSourceStatusEventArgs)
        Me.SqlDataSourceIndicadoresDeMeta.SelectParameters(0).DefaultValue = cmbMetaComponente.Value

        Me.SqlDataSourceIndicadoresDeMeta.DataBind()
        Me.ASPxGridViewIndicadoresDeMeta.DataBind()
    End Sub

    Protected Sub cmbMetaComponenteP_Callback(sender As Object, e As CallbackEventArgsBase)

        SqlMetaComponenteP.SelectParameters(0).DefaultValue = Me.cmbComponenteP.Value
        SqlMetaComponenteP.DataBind()
        cmbMetaComponenteP.DataBind()
    End Sub

    Protected Sub cmbIndicadoresP_Callback(sender As Object, e As CallbackEventArgsBase)

        SqlIndicadoresP.SelectParameters(0).DefaultValue = cmbMetaComponenteP.Value
        SqlIndicadoresP.DataBind()
        cmbIndicadoresP.DataBind()
    End Sub

    Protected Sub Unnamed1_ActiveTabChanged(source As Object, e As TabControlEventArgs)

    End Sub

    Protected Sub AgregarPrograma_Click(sender As Object, e As EventArgs)
        Dim index As Integer = Me.ASPxGridViewPrograma.FocusedRowIndex()
        Dim idprograma As String = ASPxGridViewPrograma.GetRowValues(index, "codigo_ficha").ToString
        Dim b As Boolean = False

        For i As Integer = 0 To ASPxGridView1.VisibleRowCount - 1
            Dim id As String = ASPxGridView1.GetRowValues(i, "IdPrograma").ToString
            If id = idprograma Then
                b = True
            End If
        Next
        If b = False Then
            Dim idindicador As String = cmbIndicadoresP.Value

            If cmbIndicadoresP.Text = "" Then

                'MsgBox("Esta vacio el combo no se puede insertar")

            Else
                Me.SqlDataSource1.InsertCommand = "INSERT INTO [ProgramasPorIndicadorDeMeta]([IdPrograma] ,[IdIndicadorDeMeta],[Peso],[CreadoPor],[FechaCreacion],[Activo]) VALUES (" + idprograma + "," + idindicador + ",0,'" + Membership.GetUser.UserName + "', getDate() ,1) " & _
                "SELECT @IdProgramaIndicadorMeta = SCOPE_IDENTITY()"

                Me.SqlDataSource1.Insert()
                Me.SqlDataSourceProgramasGrid.SelectParameters(0).DefaultValue = cmbIndicadoresP.Value
                Me.SqlDataSourceProgramasGrid.DataBind()
                Me.ASPxGridView1.DataBind()

                ASPxGridView1.DataBind()
            End If


            


        Else
            'MessageBox.Show("El Programa ya ha sido agregado")
        End If

    End Sub

    Protected Sub SqlDataSource1_Inserted(sender As Object, e As SqlDataSourceStatusEventArgs)
        Dim command As DbCommand = e.Command
        Dim idProgramaIndicadorMeta As Integer = ASPxGridViewPrograma.FocusedRowIndex()
        Dim index As Integer = Me.ASPxGridViewPrograma.FocusedRowIndex()
        Dim idprograma As String = ASPxGridViewPrograma.GetRowValues(index, "codigo_ficha").ToString

        'MsgBox(command.Parameters("@IdProgramaIndicadorMeta").Value.ToString)

        
        Me.SqlIndicadoresRelevantes.InsertCommand = "Insert into IndicadoresRelevantesDePrograma (IdProgramaPorIndicadorDeMeta, IdIndicadoresPorPrograma, Peso, CreadoPor, FechaCreacion, Activo) " & _
           "select " + command.Parameters("@IdProgramaIndicadorMeta").Value.ToString + " as IdProgramaIndicadorMeta, IP.IdIndicadoresPorPrograma, 0, '" + Membership.GetUser.UserName + "', getDate(), 1 " & _
           "from vProyectos P join IndicadoresPorPrograma IP on P.codigo_ficha=IP.IdPrograma " & _
           "join Indicadores I on I.IdIndicador= IP.IdIndicador " & _
           "join TiposDeIndicador TI on I.IdTipoDeIndicador=TI.IdTipoDeIndicador " & _
           "where TI.NivelTipoDeIndicador=1 and P.codigo_ficha=" + idprograma.ToString + " "


        Me.SqlIndicadoresRelevantes.Insert()

        Me.SqlDataSourceProgramasGrid.SelectParameters(0).DefaultValue = cmbIndicadoresP.Value
        Me.SqlDataSourceProgramasGrid.DataBind()
        Me.ASPxGridView1.DataBind()

        SqlDataSourceRelevantesGrid.DataBind()


    End Sub

    Protected Sub ASPxGridView_BeforePerformDataSelect(sender As Object, e As EventArgs)
        Session("IdProMetaP") = CType(sender, ASPxGridView).GetMasterRowKeyValue()

    End Sub

    Protected Sub ASPxGridView1_CustomCallback(sender As Object, e As ASPxGridViewCustomCallbackEventArgs)


        SqlDataSourceProgramasGrid.SelectParameters(0).DefaultValue = cmbIndicadoresP.Value
        SqlDataSourceProgramasGrid.DataBind()
        ASPxGridView1.DataBind()
      

    End Sub

    Protected Sub ASPxGridView2_BeforePerformDataSelect(sender As Object, e As EventArgs)
        Session("IdProgramasPorIndicadorDeMeta") = CType(sender, ASPxGridView).GetMasterRowKeyValue()

    End Sub

    Protected Sub cmbMetaComponenteInstitucion_Callback(sender As Object, e As CallbackEventArgsBase)
        SqlMetaComponenteInstitucion.SelectParameters(0).DefaultValue = Me.cmbComponenteInstitucion.Value
        SqlMetaComponenteInstitucion.DataBind()
        cmbMetaComponenteInstitucion.DataBind()

    End Sub

    Protected Sub cmbIndicadoresInstitucion_Callback(sender As Object, e As CallbackEventArgsBase)
        SqlIndicadoresInstitucion.SelectParameters(0).DefaultValue = cmbMetaComponenteInstitucion.Value
        SqlIndicadoresInstitucion.DataBind()
        cmbIndicadoresInstitucion.DataBind()
    End Sub

    Protected Sub AgregarInstitucion_Click(sender As Object, e As EventArgs)

        Dim index As Integer = Me.ASPxGridViewInstitucion.FocusedRowIndex()
        Dim idinstitucion As String = ASPxGridViewInstitucion.GetRowValues(index, "IdInstitucion").ToString

        Dim b As Boolean = False


        For i As Integer = 0 To GridInstitucionMeta.VisibleRowCount - 1
            Dim id As String = GridInstitucionMeta.GetRowValues(i, "IdInstitucion").ToString
            If id = idinstitucion Then
                b = True
            End If
        Next

        If b = False Then

            If cmbIndicadoresInstitucion.Text <> "" Then

                'MsgBox("Insertando")

                Dim idindicador As String = cmbIndicadoresInstitucion.Value

                Me.SqlDataSource6.InsertCommand = "INSERT INTO [InstitucionesPorIndicadorDeMeta]([IdInstitucion] ,[IdIndicadorDeMeta],[CreadoPor],[FechaCreacion],[Activo]) VALUES (" + idinstitucion + "," + idindicador + ",'" + Membership.GetUser.UserName + "', getDate(), 1 ) "

                Me.SqlDataSource6.Insert()
            End If

            

        Else
            'MessageBox.Show("Institución ya ha sido agregada")

        End If

    End Sub

    Protected Sub link1_Click(sender As Object, e As EventArgs)
        Dim index As Integer = GridSectorNivelIndicador.FocusedRowIndex()
        Dim idindicador As String = GridSectorNivelIndicador.GetRowValues(index, "IdIndicador").ToString
        Dim idmetacomponente As String = Me.cmbMetaComponente.Value()
        Dim b As Boolean = False

        Me.SqlDataSourceIndicadoresDeMeta.SelectParameters(0).DefaultValue = cmbMetaComponente.Value
        Me.SqlDataSourceIndicadoresDeMeta.DataBind()
        Me.ASPxGridViewIndicadoresDeMeta.DataBind()

        For i As Integer = 0 To ASPxGridViewIndicadoresDeMeta.VisibleRowCount - 1
            Dim id As String = ASPxGridViewIndicadoresDeMeta.GetRowValues(i, "IdIndicador").ToString
            If id = idindicador Then
                b = True
            End If
        Next

        If b = False Then

            If cmbMetaComponente.Text = "" Then

                'MsgBox("Vacio combo de Meta")

            Else
                Me.SqlSectorNivelIndicador.InsertCommand = "INSERT INTO [IndicadoresDeMeta]([IdMetasDeComponente] ,[IdIndicador],[CreadoPor],[FechaCreacion],[Activo]) VALUES (" + idmetacomponente + "," + idindicador + ",'" + Membership.GetUser.UserName + "',getDate(), 1)"

                Me.SqlSectorNivelIndicador.Insert()

                SqlSectorNivelIndicador.SelectParameters(0).DefaultValue = Me.cmbsector.Value
                SqlSectorNivelIndicador.SelectParameters(1).DefaultValue = Me.cmbNivel.Value
                SqlSectorNivelIndicador.DataBind()
                GridSectorNivelIndicador.DataBind()


                Me.SqlDataSourceIndicadoresDeMeta.SelectParameters(0).DefaultValue = cmbMetaComponente.Value

                Me.SqlDataSourceIndicadoresDeMeta.DataBind()
                Me.ASPxGridViewIndicadoresDeMeta.DataBind()
            End If

            
        Else

        End If

    End Sub

    Protected Sub SqlDataSource6_Inserted(sender As Object, e As SqlDataSourceStatusEventArgs)
        SqlInstitucionMeta.SelectParameters(0).DefaultValue = cmbIndicadoresInstitucion.Value
        SqlInstitucionMeta.DataBind()
        GridInstitucionMeta.DataBind()


    End Sub

    Protected Sub GridInstitucionMeta_CustomCallback(sender As Object, e As ASPxGridViewCustomCallbackEventArgs)


        SqlInstitucionMeta.SelectParameters(0).DefaultValue = cmbIndicadoresInstitucion.Value
        SqlInstitucionMeta.DataBind()
        GridInstitucionMeta.DataBind()



    End Sub


    Protected Sub SqlDataSourceProgramasGrid_Updated(sender As Object, e As SqlDataSourceStatusEventArgs)
        Me.SqlDataSourceProgramasGrid.SelectParameters(0).DefaultValue = cmbIndicadoresP.Value
        Me.SqlDataSourceProgramasGrid.DataBind()
        Me.ASPxGridView1.DataBind()
    End Sub

    Protected Sub ASPxGridViewComponentes_RowUpdated(sender As Object, e As DevExpress.Web.Data.ASPxDataUpdatedEventArgs)

        cambiarFooterColorUpdate(sender, e)

    End Sub

    Protected Sub cambiarFooterColorUpdate(sender As Object, e As DevExpress.Web.Data.ASPxDataUpdatedEventArgs)
        Dim c As ASPxGridView = sender
        c.DataBind()

        Dim siValue = CDbl(c.GetTotalSummaryValue(c.TotalSummary("Peso", DevExpress.Data.SummaryItemType.Sum)))


        If siValue <> 100 Then
            c.JSProperties("cp_Arg") = "Not100"

            c.Styles.Footer.BackColor = Color.Red


        Else
            c.JSProperties("cp_Arg") = "Is100"
            c.Styles.Footer.BackColor = Color.LightGray

        End If
    End Sub
    Protected Sub ASPxButtonRepartirComponentesPesos_Click(sender As Object, e As EventArgs)
        Dim p As Double = Math.Round((100 / ASPxGridViewComponentes.VisibleRowCount), 2)

        For i As Integer = 0 To ASPxGridViewComponentes.VisibleRowCount - 1
            Dim index As Integer = ASPxGridViewComponentes.GetRowValues(i, "IdComponentesDePolitica")
            SqlDataSourceComponentesCambiarPesos.UpdateCommand = "UPDATE [ComponentesDePolitica] SET [Peso] = " + p.ToString(New Globalization.CultureInfo("en-US", False)) + " WHERE [IdComponentesDePolitica] = " + index.ToString + " "
            SqlDataSourceComponentesCambiarPesos.Update()
            SqlDataSourceComponentesCambiarPesos.DataBind()
            ASPxGridViewComponentes.DataBind()
        Next

        Dim siValue As Double = CDbl(ASPxGridViewComponentes.GetTotalSummaryValue(ASPxGridViewComponentes.TotalSummary("Peso", DevExpress.Data.SummaryItemType.Sum)))
        If siValue <> 100 Then
            Dim diferencia As Double = 100 - siValue
            Dim codigo As Integer = ASPxGridViewComponentes.GetRowValues(ASPxGridViewComponentes.VisibleRowCount - 1, "IdComponentesDePolitica")

            Dim pesoV As Double = ASPxGridViewComponentes.GetRowValues(ASPxGridViewComponentes.VisibleRowCount - 1, "Peso")


            Dim pe As Double = pesoV + diferencia

            SqlDataSourceComponentesCambiarPesos.UpdateCommand = "UPDATE [ComponentesDePolitica] SET [Peso] = " + pe.ToString(New Globalization.CultureInfo("en-US", False)) + " WHERE [IdComponentesDePolitica] = " + codigo.ToString + " "
            SqlDataSourceComponentesCambiarPesos.Update()
            SqlDataSourceComponentesCambiarPesos.DataBind()
            ASPxGridViewComponentes.DataBind()
        End If

    End Sub

    Protected Sub ASPxButtonRepartirPesosMetas_Click(sender As Object, e As EventArgs)
        Dim p As Double = Math.Round((100 / ASPxGridViewMetas.VisibleRowCount), 2)

        For i As Integer = 0 To ASPxGridViewMetas.VisibleRowCount - 1
            Dim index As Integer = ASPxGridViewMetas.GetRowValues(i, "IdMetasDeComponente")
            SqlDataSourceMetasCambiarPesos.UpdateCommand = "UPDATE [MetasDeComponente] SET [Peso] = " + p.ToString(New Globalization.CultureInfo("en-US", False)) + " WHERE [IdMetasDeComponente] = " + index.ToString + " "
            SqlDataSourceMetasCambiarPesos.Update()
            SqlDataSourceMetasCambiarPesos.DataBind()
            ASPxGridViewMetas.DataBind()
        Next

        Dim siValue As Double = CDbl(ASPxGridViewMetas.GetTotalSummaryValue(ASPxGridViewMetas.TotalSummary("Peso", DevExpress.Data.SummaryItemType.Sum)))
        If siValue <> 100 Then
            Dim diferencia As Double = 100 - siValue
            Dim codigo As Integer = ASPxGridViewMetas.GetRowValues(ASPxGridViewComponentes.VisibleRowCount - 1, "IdMetasDeComponente")

            Dim pesoV As Double = ASPxGridViewMetas.GetRowValues(ASPxGridViewComponentes.VisibleRowCount - 1, "Peso")


            Dim pe As Double = pesoV + diferencia

            SqlDataSourceMetasCambiarPesos.UpdateCommand = "UPDATE [MetasDeComponente] SET [Peso] = " + pe.ToString(New Globalization.CultureInfo("en-US", False)) + " WHERE [IdMetasDeComponente] = " + codigo.ToString + " "
            SqlDataSourceMetasCambiarPesos.Update()
            SqlDataSourceMetasCambiarPesos.DataBind()
            ASPxGridViewMetas.DataBind()
        End If
    End Sub

    Protected Sub ASPxButtonRepartirPesosIndicadores_Click(sender As Object, e As EventArgs)

        Dim p As Double = Math.Round((100 / ASPxGridViewIndicadoresDeMeta.VisibleRowCount), 2)

        For i As Integer = 0 To ASPxGridViewIndicadoresDeMeta.VisibleRowCount - 1
            Dim index As Integer = ASPxGridViewIndicadoresDeMeta.GetRowValues(i, "IdIndicadorDeMeta")
            SqlDataSourceIndicadoresCambiarPesos.UpdateCommand = "UPDATE [IndicadoresDeMeta] SET [Peso] = " + p.ToString(New Globalization.CultureInfo("en-US", False)) + " WHERE [IdIndicadorDeMeta] = " + index.ToString + " "
            SqlDataSourceIndicadoresCambiarPesos.Update()
            SqlDataSourceIndicadoresCambiarPesos.DataBind()
            Me.SqlDataSourceIndicadoresDeMeta.SelectParameters(0).DefaultValue = cmbMetaComponente.Value
            Me.SqlDataSourceIndicadoresDeMeta.DataBind()
            Me.ASPxGridViewIndicadoresDeMeta.DataBind()
        Next

        Dim siValue As Double = CDbl(ASPxGridViewIndicadoresDeMeta.GetTotalSummaryValue(ASPxGridViewIndicadoresDeMeta.TotalSummary("Peso", DevExpress.Data.SummaryItemType.Sum)))
        If siValue <> 100 Then
            Dim diferencia As Double = 100 - siValue
            Dim codigo As Integer = ASPxGridViewIndicadoresDeMeta.GetRowValues(ASPxGridViewIndicadoresDeMeta.VisibleRowCount - 1, "IdIndicadorDeMeta")

            Dim pesoV As Double = ASPxGridViewIndicadoresDeMeta.GetRowValues(ASPxGridViewIndicadoresDeMeta.VisibleRowCount - 1, "Peso")


            Dim pe As Double = pesoV + diferencia

            SqlDataSourceIndicadoresCambiarPesos.UpdateCommand = "UPDATE [IndicadoresDeMeta] SET [Peso] = " + pe.ToString(New Globalization.CultureInfo("en-US", False)) + " WHERE [IdIndicadorDeMeta] = " + codigo.ToString + " "
            SqlDataSourceIndicadoresCambiarPesos.Update()
            SqlDataSourceIndicadoresCambiarPesos.DataBind()

            Me.SqlDataSourceIndicadoresDeMeta.SelectParameters(0).DefaultValue = cmbMetaComponente.Value
            Me.SqlDataSourceIndicadoresDeMeta.DataBind()
            Me.ASPxGridViewIndicadoresDeMeta.DataBind()

        End If
    End Sub

    Protected Sub ASPxButtonRepartirProgramas_Click(sender As Object, e As EventArgs)

        Dim p As Double = Math.Round((100 / ASPxGridView1.VisibleRowCount), 2)

        For i As Integer = 0 To ASPxGridView1.VisibleRowCount - 1
            Dim index As Integer = ASPxGridView1.GetRowValues(i, "IdProgramasPorIndicadorDeMeta")
            SqlDataSourceProgramasCambiarPesos.UpdateCommand = "UPDATE [ProgramasPorIndicadorDeMeta] SET [Peso] = " + p.ToString(New Globalization.CultureInfo("en-US", False)) + " WHERE [IdProgramasPorIndicadorDeMeta] = " + index.ToString + " "
            SqlDataSourceProgramasCambiarPesos.Update()
            SqlDataSourceProgramasCambiarPesos.DataBind()
            'Actualizar grid
            SqlDataSourceProgramasGrid.SelectParameters(0).DefaultValue = cmbIndicadoresP.Value
            SqlDataSourceProgramasGrid.DataBind()
            ASPxGridView1.DataBind()
        Next

        Dim siValue As Double = CDbl(ASPxGridView1.GetTotalSummaryValue(ASPxGridView1.TotalSummary("Peso", DevExpress.Data.SummaryItemType.Sum)))
        If siValue <> 100 Then
            Dim diferencia As Double = 100 - siValue
            Dim codigo As Integer = ASPxGridView1.GetRowValues(ASPxGridView1.VisibleRowCount - 1, "IdProgramasPorIndicadorDeMeta")

            Dim pesoV As Double = ASPxGridView1.GetRowValues(ASPxGridView1.VisibleRowCount - 1, "Peso")


            Dim pe As Double = pesoV + diferencia

            SqlDataSourceProgramasCambiarPesos.UpdateCommand = "UPDATE [ProgramasPorIndicadorDeMeta] SET [Peso] = " + pe.ToString(New Globalization.CultureInfo("en-US", False)) + " WHERE [IdProgramasPorIndicadorDeMeta] = " + codigo.ToString + " "
            SqlDataSourceProgramasCambiarPesos.Update()
            SqlDataSourceProgramasCambiarPesos.DataBind()
            'Actualizar grid
            SqlDataSourceProgramasGrid.SelectParameters(0).DefaultValue = cmbIndicadoresP.Value
            SqlDataSourceProgramasGrid.DataBind()
            ASPxGridView1.DataBind()

        End If
    End Sub

    Protected Sub ASPxGridViewComponentes_RowDeleted(sender As Object, e As DevExpress.Web.Data.ASPxDataDeletedEventArgs)
        cambiarFooterColorDelete(sender, e)
    End Sub
    Protected Sub cambiarFooterColorDelete(sender As Object, e As DevExpress.Web.Data.ASPxDataDeletedEventArgs)
        Dim c As ASPxGridView = sender
        c.DataBind()

        Dim siValue = CDbl(c.GetTotalSummaryValue(c.TotalSummary("Peso", DevExpress.Data.SummaryItemType.Sum)))


        If siValue <> 100 Then
            c.JSProperties("cp_Arg") = "Not100"

            c.Styles.Footer.BackColor = Color.Red


        Else
            c.JSProperties("cp_Arg") = "Is100"
            c.Styles.Footer.BackColor = Color.LightGray

        End If
    End Sub

    Protected Sub ASPxGridViewComponentes_RowInserted(sender As Object, e As DevExpress.Web.Data.ASPxDataInsertedEventArgs)
        cambiarFooterColorInsert(sender, e)

    End Sub

    Protected Sub cambiarFooterColorInsert(sender As Object, e As DevExpress.Web.Data.ASPxDataInsertedEventArgs)
        Dim c As ASPxGridView = sender
        c.DataBind()

        Dim siValue = CDbl(c.GetTotalSummaryValue(c.TotalSummary("Peso", DevExpress.Data.SummaryItemType.Sum)))


        If siValue <> 100 Then
            c.JSProperties("cp_Arg") = "Not100"

            c.Styles.Footer.BackColor = Color.Red


        Else
            c.JSProperties("cp_Arg") = "Is100"
            c.Styles.Footer.BackColor = Color.LightGray

        End If
    End Sub

    Protected Sub ASPxGridViewMetas_RowUpdated(sender As Object, e As DevExpress.Web.Data.ASPxDataUpdatedEventArgs)
        cambiarFooterColorUpdate(sender, e)
    End Sub


    Protected Sub ASPxGridViewMetas_RowDeleted(sender As Object, e As DevExpress.Web.Data.ASPxDataDeletedEventArgs)
        cambiarFooterColorDelete(sender, e)
    End Sub


    Protected Sub ASPxGridViewMetas_RowInserted(sender As Object, e As DevExpress.Web.Data.ASPxDataInsertedEventArgs)
        cambiarFooterColorInsert(sender, e)
    End Sub

    Protected Sub ASPxGridViewIndicadoresDeMeta_RowUpdated(sender As Object, e As DevExpress.Web.Data.ASPxDataUpdatedEventArgs)
        cambiarFooterColorUpdate(sender, e)
    End Sub

    Protected Sub ASPxGridView1_RowUpdated(sender As Object, e As DevExpress.Web.Data.ASPxDataUpdatedEventArgs)
        cambiarFooterColorUpdate(sender, e)
    End Sub

    Protected Sub ASPxGridView2_RowUpdated(sender As Object, e As DevExpress.Web.Data.ASPxDataUpdatedEventArgs)
        cambiarFooterColorUpdate(sender, e)
    End Sub

    Protected Sub Page_Load1(sender As Object, e As EventArgs) Handles Me.Load
        'Verifica si el usuario tiene el acceso a la pagina solicitada
        Using dtMOCA As System.Data.DataTable = fMOCA.CheckPageAccess(1.01) 'este es el Id definido en el MOCA
            If dtMOCA.Rows.Count() > 0 Then
                If dtMOCA.Rows.Item(0).Item("AllowAction01") Then

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
                    Response.Redirect("~/NoAccess.aspx")
                End If
            Else
                'Si no se recupero ningun dato se entendera que el usuario no tiene acceso a la pagina solicitada
                'y sera redireccionado a la Pagina siguiente que le notifica al usuario que no tiene acceso
                Response.Redirect("~/NoAccess.aspx")
            End If
        End Using
        IdPolitica = uf.QueryStringDecode(Request.QueryString.Get(2))
        NombrePolitica = uf.QueryStringDecode(Request.QueryString.Get(1))
        Me.ASPxLabelPolitica.Text = "Polìtica: " + NombrePolitica


        Me.SqlDataSourceComponentes.SelectParameters(0).DefaultValue = IdPolitica
        Me.SqlDataSourceComponentes.DataBind()
        Me.ASPxGridViewComponentes.DataBind()


        Me.SqlDataSourceComponentes.InsertParameters(3).DefaultValue = IdPolitica
        Me.SqlDataSourceComponentes.InsertParameters(4).DefaultValue = Membership.GetUser.UserName

        Me.SqlDataSourceComponentes.UpdateParameters(3).DefaultValue = Membership.GetUser.UserName


        Me.SqlComponente.SelectParameters(0).DefaultValue = IdPolitica

        Me.SqlComponenteP.SelectParameters(0).DefaultValue = IdPolitica

        Me.SqlComponenteInstitucion.SelectParameters(0).DefaultValue = IdPolitica


        SqlDataSourceMetas.InsertParameters(4).DefaultValue = Membership.GetUser.UserName
        SqlDataSourceMetas.UpdateParameters(3).DefaultValue = Membership.GetUser.UserName

        SqlDataSourceIndicadoresDeMeta.UpdateParameters(1).DefaultValue = Membership.GetUser.UserName

        Me.cmbNivel.DataBind()
        Me.cmbNivel.DataBind()


    End Sub



    Protected Sub SqlDataSourceComponentes_Inserted(sender As Object, e As SqlDataSourceStatusEventArgs)
        SqlComponente.SelectParameters(0).DefaultValue = IdPolitica
        cmbComponenteI.DataBind()
    End Sub

    Protected Sub cmbComponenteI_Callback(sender As Object, e As CallbackEventArgsBase)
        SqlComponente.SelectParameters(0).DefaultValue = IdPolitica
        cmbComponenteI.DataBind()
    End Sub

    Protected Sub cmbComponenteInstitucion_Callback(sender As Object, e As CallbackEventArgsBase)
        SqlComponenteInstitucion.SelectParameters(0).DefaultValue = IdPolitica
        cmbComponenteInstitucion.DataBind()
    End Sub

    Protected Sub cmbComponenteP_Callback(sender As Object, e As CallbackEventArgsBase)
        SqlComponenteP.SelectParameters(0).DefaultValue = IdPolitica
        cmbComponenteP.DataBind()
    End Sub

    Protected Sub ASPxGridViewComponentes_Load(sender As Object, e As EventArgs)
        Me.SqlDataSourceComponentes.SelectParameters(0).DefaultValue = IdPolitica
        Me.ASPxGridViewComponentes.DataBind()
    End Sub

    Protected Sub ASPxGridViewMetas_Load(sender As Object, e As EventArgs)
        Me.SqlDataSourceMetas.SelectParameters(0).DefaultValue = CmbComponente.Value
        Me.ASPxGridViewMetas.DataBind()
    End Sub

    Protected Sub GridSectorNivelIndicador_Load(sender As Object, e As EventArgs)
        Me.SqlSectorNivelIndicador.SelectParameters(0).DefaultValue = Me.cmbsector.Value
        Me.SqlSectorNivelIndicador.SelectParameters(1).DefaultValue = Me.cmbNivel.Value
        Me.GridSectorNivelIndicador.DataBind()
    End Sub

    Protected Sub ASPxGridViewIndicadoresDeMeta_Load(sender As Object, e As EventArgs)
        Me.SqlDataSourceIndicadoresDeMeta.SelectParameters(0).DefaultValue = Me.cmbMetaComponente.Value
        Me.ASPxGridViewIndicadoresDeMeta.DataBind()
    End Sub

    Protected Sub ASPxGridView1_Load(sender As Object, e As EventArgs)
        Me.SqlDataSourceProgramasGrid.SelectParameters(0).DefaultValue = cmbIndicadoresP.Value
        Me.ASPxGridView1.DataBind()
    End Sub

    Protected Sub GridInstitucionMeta_Load(sender As Object, e As EventArgs)
        SqlInstitucionMeta.SelectParameters(0).DefaultValue = cmbIndicadoresInstitucion.Value
        SqlInstitucionMeta.DataBind()
        GridInstitucionMeta.DataBind()
    End Sub

    Protected Sub ASPxGridView1_RowInserted(sender As Object, e As DevExpress.Web.Data.ASPxDataInsertedEventArgs)
        cambiarFooterColorInsert(sender, e)
    End Sub

    
End Class
