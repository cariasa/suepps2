Imports Microsoft.VisualBasic
Imports System
Imports System.Data
Imports System.Configuration
Imports System.Collections
Imports System.Web
Imports System.Web.Security
Imports System.Web.UI
Imports System.Web.UI.WebControls
Imports System.Web.UI.WebControls.WebParts
Imports System.Web.UI.HtmlControls
Imports DevExpress.Web.ASPxGridView
Imports DevExpress.Web.ASPxEditors
Imports DevExpress.Web.ASPxTabControl
Imports DevExpress.Web.ASPxLoadingPanel
Imports DevExpress.Web.ASPxClasses
Imports DevExpress.Web.ASPxCallback
Imports DevExpress.Web.ASPxUploadControl
Imports System.Drawing
Imports System.IO
Imports System.Windows.Forms
Imports System.Threading
Imports System.Data.Common
Imports System.Web.Configuration
Imports System.Data.SqlClient



Partial Class GestionPublica_Programa
    Inherits System.Web.UI.Page

    Private Const UploadDirectory As String = "/suepps/Uploads/Programas/"

    Public Programaa As String

    Protected Sub BeforeSelect(ByVal sender As Object, ByVal e As EventArgs)
        Dim controlParameter As ControlParameter = CType(SqlIndicadores.SelectParameters(0), ControlParameter)
        controlParameter.ControlID = combosector.UniqueID

    End Sub


    Protected Sub Combosector_Load(ByVal sender As Object, ByVal e As EventArgs)
        combosector = CType(sender, ASPxComboBox)
    End Sub


    Protected Sub addIdentificador(ByVal sender As Object, ByVal e As EventArgs)
        Dim index As Integer = GridIndicadores.FocusedRowIndex()
        Dim idindicador As String = GridIndicadores.GetRowValues(index, "IdIndicador").ToString
        Dim idprograma As String = Me.CodPrograma.Text
        Dim b As Boolean = False

        For i As Integer = 0 To GridIndicadoresPorPrograma.VisibleRowCount - 1
            Dim id As String = GridIndicadoresPorPrograma.GetRowValues(i, "IdIndicador").ToString
            If id = idindicador Then
                b = True
            End If
        Next
        If b = False Then

            'Me.SqladdIndicador.InsertCommand = "INSERT INTO [IndicadoresPorPrograma]([IdIndicador] ,[IdPrograma],[Activo]) VALUES (" + idindicador + "," + idprograma + ", 1)"
            Me.SqladdIndicador.InsertParameters(0).DefaultValue = idindicador
            Me.SqladdIndicador.InsertParameters(1).DefaultValue = idprograma
            SqladdIndicador.InsertParameters(3).DefaultValue = Membership.GetUser.UserName
            Me.SqladdIndicador.Insert()



            Me.SqlIndicadoresPorPrograma.SelectParameters(0).DefaultValue = CInt(CodPrograma.Text)
            Me.GridIndicadoresPorPrograma.DataBind()
        Else
            'MessageBox.Show("El indicador ya ha sido agregado")
        End If



    End Sub

    Protected Sub deleteIdentificadorPrograma(ByVal sender As Object, ByVal e As EventArgs)

        Dim index As Integer = Me.GridIndicadoresPorPrograma.FocusedRowIndex()
        Dim idindicador As String = GridIndicadoresPorPrograma.GetRowValues(index, "IdIndicador").ToString
        Dim idprograma As String = Me.CodPrograma.Text

        Me.SqlDeleteIndicador.DeleteCommand = "DELETE [IndicadoresPorPrograma] WHERE [IdIndicador]= " + idindicador + "AND [IdPrograma]= " + idprograma
        Me.SqlDeleteIndicador.Delete()

        Me.SqlIndicadoresPorPrograma.DataBind()
        Me.GridIndicadoresPorPrograma.DataBind()

        Me.SqlIndicadoresm.SelectCommand = "select * form [IndicadoresPorPrograma] where [IdPrograma]=" + CodPrograma.Text
        Me.GridIndicadoresm.DataBind()



    End Sub





    Protected Sub GridMeta_CustomCallback(ByVal sender As Object, ByVal e As ASPxGridViewCustomCallbackEventArgs)



        If e.Parameters = "" Then


            If ComboAreaInfluencia.Text <> "" And comboAño.Text.Equals("") Then

            Else

                If ComboAreaInfluencia.Text <> "" And comboAño.Text <> "" Then

                    Me.SqlIndicadoresm.SelectCommand = "select * from [IndicadoresPorPrograma] where [IdPrograma]=" + CodPrograma.Text + "and [Activo]=1"
                    Me.SqlIndicadoresm.DataBind()
                    Me.GridIndicadoresm.DataBind()

                    SqlMetas.SelectParameters(0).DefaultValue = CInt(CodPrograma.Text)
                    SqlMetas.SelectParameters(1).DefaultValue = CInt(ComboAreaInfluencia.Value)
                    SqlMetas.SelectParameters(2).DefaultValue = comboAño.Value
                    SqlMetas.DataBind()
                    GridMetas.DataBind()
                End If


            End If

        Else
           
            SqlMetas.SelectParameters(0).DefaultValue = 0
            SqlMetas.SelectParameters(1).DefaultValue = 0
            SqlMetas.SelectParameters(2).DefaultValue = 0
            SqlMetas.DataBind()
            GridMetas.DataBind()


        End If






    End Sub

    Protected Sub GridIndicadores_CustomCallback(sender As Object, e As ASPxGridViewCustomCallbackEventArgs)

        If e.Parameters = "" Then
            If combosector.Text <> "" Then
                Me.SqlIndicadores.SelectParameters(0).DefaultValue = CInt(combosector.Value)
                Me.GridIndicadores.DataBind()
            End If
        Else
            SqlIndicadores.SelectParameters(0).DefaultValue = 0
            SqlIndicadores.DataBind()
            GridIndicadores.DataBind()
        End If

    End Sub

    Protected Sub SqlMetas_Updated(sender As Object, e As SqlDataSourceStatusEventArgs)
        SqlMetas.SelectParameters(0).DefaultValue = CInt(CodPrograma.Text)
        SqlMetas.SelectParameters(1).DefaultValue = CInt(ComboAreaInfluencia.Value)
        SqlMetas.SelectParameters(2).DefaultValue = comboAño.Value
        SqlMetas.DataBind()
        GridMetas.DataBind()
    End Sub

    Protected Sub ComboAreaInfluencia_Callback(sender As Object, e As CallbackEventArgsBase)

        Me.SqlAreaInfluenciac.SelectParameters(0).DefaultValue = CInt(CodPrograma.Text)
        Me.SqlAreaInfluenciac.DataBind()
        Me.ComboAreaInfluencia.DataBind()

    End Sub

    Protected Sub ComboAreaInfluencia_Callback2(sender As Object, e As CallbackEventArgsBase)

        Me.SqlDataSourceAreasUbicaciones.SelectParameters(0).DefaultValue = CInt(CodPrograma.Text)
        Me.SqlDataSourceAreasUbicaciones.DataBind()
        Me.ASPxComboBoxAreaUbicaciones.DataBind()

    End Sub



    Protected Sub GridIndicadoresPorPrograma_CustomCallback(sender As Object, e As ASPxGridViewCustomCallbackEventArgs)
        Dim idP As String = uf.QueryStringDecode(Request.QueryString.Get(1))
        SqlIndicadoresPorPrograma.SelectParameters(0).DefaultValue = idP
        'paco
        'SqlIndicadoresPorPrograma.SelectParameters(0).DefaultValue = CInt(CodPrograma.Text)

        SqlIndicadoresPorPrograma.DataBind()
        GridIndicadoresPorPrograma.DataBind()

    End Sub

    Protected Sub SqlAnoPrograma_Inserted(sender As Object, e As SqlDataSourceStatusEventArgs)
        Dim sqlConnection1 As New System.Data.SqlClient.SqlConnection(WebConfigurationManager.ConnectionStrings("SUEPPSConnectionString").ConnectionString)
        Dim command As DbCommand
        command = e.Command

        Dim cmd As New System.Data.SqlClient.SqlCommand
        cmd.CommandType = System.Data.CommandType.Text
        cmd.CommandText = "INSERT INTO MetaYMonitoreoPorPeriodo (IdAreaDeInfluencia, IdIndicadorPorPrograma, Ano, CreadoPor,FechaCreacion ,Activo) " & _
            "SELECT adi.IdAreaDeInfluencia, ipp.IdIndicadoresPorPrograma, " & command.Parameters("@Ano").Value & ",'" + Membership.GetUser.UserName + "' , getDate(), 1 " & _
            "FROM dbo.AreasDeInfluencia as adi " & _
            "JOIN dbo.IndicadoresPorPrograma as ipp ON adi.IdPrograma = ipp.IdPrograma " & _
            "JOIN dbo.Indicadores as indi ON ipp.IdIndicador = indi.IdIndicador " & _
            "JOIN dbo.TiposDeIndicador as tdi ON tdi.IdTipoDeIndicador = indi.IdTipoDeIndicador " & _
            "WHERE adi.IdPrograma = " & CodPrograma.Text & " And (tdi.NivelTipoDeIndicador = 1 OR tdi.NivelTipoDeIndicador = 0)"
        cmd.Connection = sqlConnection1

        sqlConnection1.Open()
        cmd.ExecuteNonQuery()
        sqlConnection1.Close()

        sqlDataSourceComboAno.DataBind()
        comboAño.DataBind()

    End Sub

    'Protected Sub SqlAreaInfluencia_Inserted(sender As Object, e As SqlDataSourceStatusEventArgs)
    '    Dim sqlConnection1 As New System.Data.SqlClient.SqlConnection(WebConfigurationManager.ConnectionStrings("SUEPPSConnectionString").ConnectionString)
    '    Dim command As DbCommand
    '    command = e.Command

    '    Dim cmd As New System.Data.SqlClient.SqlCommand
    '    cmd.CommandType = System.Data.CommandType.Text
    '    cmd.CommandText = "INSERT INTO MetaYMonitoreoPorPeriodo (Ano, IdIndicadorPorPrograma, IdAreaDeInfluencia, Activo) " & _
    '        "SELECT an.Ano, ipp.IdIndicadoresPorPrograma, " & command.Parameters("@IdAreaDeInfluencia").Value & ", 1 " & _
    '        "FROM dbo.AnoPrograma as an " & _
    '        "JOIN dbo.IndicadoresPorPrograma as ipp ON an.IdPrograma = ipp.IdPrograma " & _
    '        "JOIN dbo.Indicadores as indi ON ipp.IdIndicador = indi.IdIndicador " & _
    '        "JOIN dbo.TiposDeIndicador as tdi ON tdi.IdTipoDeIndicador = indi.IdTipoDeIndicador " & _
    '        "WHERE an.IdPrograma = " & CodPrograma.Text & " And (tdi.NivelTipoDeIndicador = 1 OR tdi.NiveTipoDeIndicador = 0) "
    '    cmd.Connection = sqlConnection1

    '    sqlConnection1.Open()
    '    cmd.ExecuteNonQuery()
    '    sqlConnection1.Close()

    'End Sub

    Protected Sub SqladdIndicador_Inserted(sender As Object, e As SqlDataSourceStatusEventArgs)
        Dim sqlConnection1 As New System.Data.SqlClient.SqlConnection(WebConfigurationManager.ConnectionStrings("SUEPPSConnectionString").ConnectionString)
        Dim command As DbCommand
        command = e.Command

        Dim cmd As New System.Data.SqlClient.SqlCommand
        cmd.CommandType = System.Data.CommandType.Text
        cmd.CommandText = "INSERT INTO MetaYMonitoreoPorPeriodo (Ano, IdAreaDeInfluencia, IdIndicadorPorPrograma, CreadoPor, FechaCreacion, Activo) " & _
            "SELECT an.Ano, adi.IdAreaDeInfluencia, " & command.Parameters("@IdIndicadoresPorPrograma").Value & ", '" + Membership.GetUser.UserName + "', getDate(), 1 " & _
            "FROM dbo.AnoPrograma as an " & _
            "JOIN dbo.AreasDeInfluencia as adi  ON an.IdPrograma = adi.IdPrograma " & _
            "WHERE an.Activo=1 and  an.IdPrograma = " & CodPrograma.Text
        cmd.Connection = sqlConnection1

        sqlConnection1.Open()
        cmd.ExecuteNonQuery()
        sqlConnection1.Close()
    End Sub


    Protected Sub ASPxGridView2_BeforePerformDataSelect(sender As Object, e As EventArgs)

        Session("IdPolitica") = CType(sender, ASPxGridView).GetMasterRowKeyValue()


    End Sub

    Protected Sub uplImage_FileUploadComplete(ByVal sender As Object, ByVal e As FileUploadCompleteEventArgs)


        Dim Ruta As String = "/suepps/Uploads/Programas/"

        Dim unico As String = Format(Date.Now, "yyyyMMdd_HHmmss_") + e.UploadedFile.FileName
        Dim fileName As String = Path.Combine(MapPath(UploadDirectory), unico)

        e.UploadedFile.SaveAs(fileName)

        Me.Programa.Text = uf.QueryStringDecode(Request.QueryString.Get(0))
        Me.CodPrograma.Text = uf.QueryStringDecode(Request.QueryString.Get(1))
        Programaa = Me.CodPrograma.Text

        SqlDataSourceRecursos.InsertParameters(0).DefaultValue = Ruta + unico
        SqlDataSourceRecursos.InsertParameters(1).DefaultValue = Programaa
        SqlDataSourceRecursos.InsertParameters(2).DefaultValue = e.UploadedFile.FileName
        Me.SqlDataSourceRecursos.InsertParameters(3).DefaultValue = Membership.GetUser.UserName
        SqlDataSourceRecursos.Insert()

        Me.SqlDataSourceRecursos.DataBind()


    End Sub

    Protected Sub SubirNuevo_Init(sender As Object, e As EventArgs)
        Dim boton As ASPxButton = CType(sender, ASPxButton)

    End Sub

    Protected Sub ASPxGridViewUbicacionAreaDeInfluencia_BeforePerformDataSelect(sender As Object, e As EventArgs)

        Session("IdAreaDeInfluencia") = CType(sender, ASPxGridView).GetMasterRowKeyValue()

    End Sub

    Protected Sub Page_Init(sender As Object, e As EventArgs) Handles Me.Init
        'Dim sqlConnection1 As New System.Data.SqlClient.SqlConnection(WebConfigurationManager.ConnectionStrings("SUEPPSConnectionString").ConnectionString)
        'Dim idP As String = uf.QueryStringDecode(Request.QueryString.Get(1))

        'Dim cmd As New System.Data.SqlClient.SqlCommand
        'cmd.CommandType = System.Data.CommandType.Text
        'cmd.CommandText = "Insert into IndicadoresPorPrograma (IdIndicador, IdPrograma) " & _
        '                  "select IdIndicador, " & idP & " from Indicadores where IdTipoDeIndicador=2 and IdIndicador not in( " & _
        '                  "select IdIndicador from IndicadoresPorPrograma where IdPrograma= " & idP & " and IdIndicador in ( " & _
        '                  "select IdIndicador from Indicadores where IdTipoDeIndicador=2)) "

        'cmd.Connection = sqlConnection1
        'sqlConnection1.Open()
        'cmd.ExecuteNonQuery()
        'sqlConnection1.Close()

        SqlAnoPrograma.InsertParameters(1).DefaultValue = Membership.GetUser.UserName

        SqlDataSourceAreaDeInfluencia.InsertParameters(2).DefaultValue = Membership.GetUser.UserName
        SqlDataSourceAreaDeInfluencia.UpdateParameters(1).DefaultValue = Membership.GetUser.UserName


        SqlDataSourceRecursos.InsertParameters(3).DefaultValue = Membership.GetUser.UserName


        SqlAno.SelectParameters(0).DefaultValue = CodPrograma.Text



    End Sub

    Protected Sub Page_Load1(sender As Object, e As EventArgs) Handles Me.Load
        'Verifica si el usuario tiene el acceso a la pagina solicitada
        Using dtMOCA As System.Data.DataTable = fMOCA.CheckPageAccess(1.02) 'este es el Id definido en el MOCA
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

        Me.Programa.Text = uf.QueryStringDecode(Request.QueryString.Get(0))
        Me.CodPrograma.Text = uf.QueryStringDecode(Request.QueryString.Get(1))
        Programaa = Me.CodPrograma.Text


        Me.SqlIndicadoresm.SelectCommand = "select * from [IndicadoresPorPrograma] where [IdPrograma]=" + CodPrograma.Text + "and [Activo]=1"

        Me.SqlIndicadoresPorPrograma.SelectParameters(0).DefaultValue = CInt(CodPrograma.Text)

        Me.SqlAreaInfluenciac.SelectParameters(0).DefaultValue = CInt(CodPrograma.Text)

        SqlDataSourceAreasUbicaciones.SelectParameters(0).DefaultValue = CInt(CodPrograma.Text)

        Me.SqlMetasIndicador.SelectCommand = "SELECT * FROM [MetaYMonitoreoPorPeriodo] where [Activo]=1"


        Me.SqlAnoPrograma.SelectParameters(0).DefaultValue = CodPrograma.Text
        Me.SqlAnoPrograma.InsertParameters(0).DefaultValue = CodPrograma.Text


        Me.SqlDataSourceRecursos.SelectParameters(0).DefaultValue = CodPrograma.Text

        SqlDataSourceAreaDeInfluencia.SelectParameters(0).DefaultValue = CodPrograma.Text
        SqlDataSourceAreaDeInfluencia.InsertParameters(0).DefaultValue = CodPrograma.Text


        Me.SqlIndicadoresPorPrograma.SelectParameters(0).DefaultValue = CodPrograma.Text
        Me.GridIndicadoresPorPrograma.DataBind()

        Me.SqlDataSourceRecursos.InsertParameters(3).DefaultValue = Membership.GetUser.UserName


        SqlAno.SelectParameters(0).DefaultValue = CodPrograma.Text

        ' "" & _
        ''"DECLARE @AP int" & _
        SqlAnoPrograma.InsertCommand = "SET @AP = (SELECT IdAnoPrograma FROM [AnoPrograma] " & _
        "where IdPrograma = @p1" & _
         " and Ano=@Ano and Activo=1" & _
            ")" & _
        "IF (@AP is NULL)" & _
            "BEGIN " & _
    "INSERT INTO [AnoPrograma] ([IdPrograma],[Ano],[CreadoPor],[FechaCreacion],[Activo]) VALUES (@p1,@Ano,@Usuario,getDate(),1)" & _
     "END"

        SqlDataSourceAreaDeInfluencia.InsertCommand = "SET @AP = (SELECT IdAreaDeInfluencia FROM [AreasDeInfluencia] " & _
        "where IdPrograma = @IdPrograma" & _
         " and DescripcionAreaDeInfluencia= @DescripcionAreaDeInfluencia and Activo=1" & _
            ")" & _
        "IF (@AP is NULL)" & _
            "BEGIN " & _
     "INSERT INTO [AreasDeInfluencia] (IdPrograma, DescripcionAreaDeInfluencia, CreadoPor, FechaCreacion, Activo) VALUES (@IdPrograma,@DescripcionAreaDeInfluencia,@Usuario,getDate(),1) SELECT @IdAreaDeInfluencia = SCOPE_IDENTITY() " & _
     "END"



    End Sub

    Protected Sub comboAño_Load(sender As Object, e As EventArgs) Handles comboAño.Load
        sqlDataSourceComboAno.SelectParameters(0).DefaultValue = CInt(uf.QueryStringDecode(Request.QueryString.Get(1)))
        sqlDataSourceComboAno.DataBind()
        comboAño.DataBind()
    End Sub

    Protected Sub comboAño_Callback(sender As Object, e As CallbackEventArgsBase)
        sqlDataSourceComboAno.SelectParameters(0).DefaultValue = CInt(uf.QueryStringDecode(Request.QueryString.Get(1)))
        sqlDataSourceComboAno.DataBind()
        comboAño.DataBind()
    End Sub



    Protected Sub AgregarUbicacion_Click(sender As Object, e As EventArgs)

        Dim idareai As String = ASPxComboBoxAreaUbicaciones.Value


        Dim depto As String = Me.ComboDepartamentos.Value
        Dim muni As String = Me.ComboMunicipios.Value
        Dim Aldea As String = Me.ComboAldeas.Value
        Dim Caserio As String = Me.ComboCaserio.Value
        Dim Barrio As String = Me.ComboBarrio.Value

        'MsgBox("Departamento: " + Me.ComboDepartamentos.Text)
        'MsgBox("Municipio: " + Me.ComboMunicipios.Text)

        If muni = "" And depto <> "" Then

            Me.SqlUbicacion.InsertCommand = "SET @AP = (SELECT IdUbicacionPorAreaDeInfluencia FROM [UbicacionPorAreaDeInfluencia] " & _
       "where IdAreaDeInfluencia =" + idareai + "" & _
        " and IdDepartamento=" + depto + " and Activo=1 and EsTodoDepartamento=1" & _
           ")" & _
       "IF (@AP is NULL)" & _
           "BEGIN " & _
   "INSERT INTO [UbicacionPorAreaDeInfluencia]([IdAreaDeInfluencia],[IdDepartamento], [EsTodoDepartamento], [CreadoPor], [FechaCreacion] , [Activo]) VALUES (" + idareai + "," + depto + ", 1 , '" + Membership.GetUser.UserName + "' , getDate() ,1  )" & _
    "END"

            Me.SqlUbicacion.Insert()

        End If

        If Aldea = "" And muni <> "" Then


            Me.SqlUbicacion.InsertCommand = "SET @AP = (SELECT IdUbicacionPorAreaDeInfluencia FROM [UbicacionPorAreaDeInfluencia] " & _
      "where IdAreaDeInfluencia =" + idareai + "" & _
       " and IdDepartamento=" + depto + " and IdMunicipio=" + muni + " and Activo=1 and EsTodoMunicipio=1" & _
          ")" & _
      "IF (@AP is NULL)" & _
          "BEGIN " & _
  "INSERT INTO [UbicacionPorAreaDeInfluencia]([IdAreaDeInfluencia],[IdDepartamento],[IdMunicipio], [EsTodoMunicipio], [CreadoPor], [FechaCreacion], [Activo]) VALUES (" + idareai + "," + depto + "," + muni + ",1,'" + Membership.GetUser.UserName + "', getDate(),1)" & _
   "END"


            'Me.SqlUbicacion.InsertCommand = "INSERT INTO [UbicacionPorAreaDeInfluencia]([IdAreaDeInfluencia],[IdDepartamento],[IdMunicipio], [EsTodoAldea], [Activo]) VALUES (" + idareai + "," + depto + "," + muni + ",1,1)"

            Me.SqlUbicacion.Insert()

        End If

        If Caserio = "" And Aldea <> "" Then


            Me.SqlUbicacion.InsertCommand = "SET @AP = (SELECT IdUbicacionPorAreaDeInfluencia FROM [UbicacionPorAreaDeInfluencia] " & _
      "where IdAreaDeInfluencia =" + idareai + "" & _
       " and IdDepartamento=" + depto + " and IdMunicipio=" + muni + " and IdAldea=" + Aldea + " and  Activo=1 and EsTodoAldea=1" & _
          ")" & _
      "IF (@AP is NULL)" & _
          "BEGIN " & _
  "INSERT INTO [UbicacionPorAreaDeInfluencia]([IdAreaDeInfluencia],[IdDepartamento],[IdMunicipio],[IdAldea], [EsTodoAldea], [CreadoPor], [FechaCreacion],[Activo]) VALUES (" + idareai + "," + depto + "," + muni + "," + Aldea + ",1,'" + Membership.GetUser.UserName + "',getDate(),1)" & _
   "END"



            ' Me.SqlUbicacion.InsertCommand = "INSERT INTO [UbicacionPorAreaDeInfluencia]([IdAreaDeInfluencia],[IdDepartamento],[IdMunicipio],[IdAldea], [EsTodoCaserio], [Activo]) VALUES (" + idareai + "," + depto + "," + muni + "," + Aldea + ",1,1)"

            Me.SqlUbicacion.Insert()

        End If

        If Barrio = "" And Caserio <> "" Then

            Me.SqlUbicacion.InsertCommand = "SET @AP = (SELECT IdUbicacionPorAreaDeInfluencia FROM [UbicacionPorAreaDeInfluencia] " & _
     "where IdAreaDeInfluencia =" + idareai + "" & _
      " and IdDepartamento=" + depto + " and IdMunicipio=" + muni + " and IdAldea=" + Aldea + " and IdCaserio=" + Caserio + " and Activo=1 and EsTodoCacerio=1" & _
         ")" & _
     "IF (@AP is NULL)" & _
         "BEGIN " & _
 "INSERT INTO [UbicacionPorAreaDeInfluencia]([IdAreaDeInfluencia],[IdDepartamento],[IdMunicipio],[IdAldea],[IdCaserio],[Activo],[EsTodoCacerio],[CreadoPor],[FechaCreacion]) VALUES (" + idareai + "," + depto + "," + muni + "," + Aldea + "," + Caserio + ",1,1,'" + Membership.GetUser.UserName + "', getDate())" & _
  "END"


            'Me.SqlUbicacion.InsertCommand = "INSERT INTO [UbicacionPorAreaDeInfluencia]([IdAreaDeInfluencia],[IdDepartamento],[IdMunicipio],[IdAldea],[IdCaserio],[Activo]) VALUES (" + idareai + "," + depto + "," + muni + "," + Aldea + "," + Caserio + ",1)"

            Me.SqlUbicacion.Insert()

        End If

        If Barrio <> "" Then

            Me.SqlUbicacion.InsertCommand = "SET @AP = (SELECT IdUbicacionPorAreaDeInfluencia FROM [UbicacionPorAreaDeInfluencia] " & _
    "where IdAreaDeInfluencia =" + idareai + "" & _
     " and IdDepartamento=" + depto + " and IdMunicipio=" + muni + " and IdAldea=" + Aldea + " and IdCaserio=" + Caserio + " and IdBarrio=" + Barrio + " and Activo=1 " & _
        ")" & _
    "IF (@AP is NULL)" & _
        "BEGIN " & _
"INSERT INTO [UbicacionPorAreaDeInfluencia]([IdAreaDeInfluencia],[IdDepartamento],[IdMunicipio],[IdAldea],[IdCaserio],[IdBarrio],[Activo],[CreadoPor],[FechaCreacion]) VALUES (" + idareai + "," + depto + "," + muni + "," + Aldea + "," + Caserio + "," + Barrio + ",1, '" + Membership.GetUser.UserName + "', getDate())" & _
 "END"

            'Me.SqlUbicacion.InsertCommand = "INSERT INTO [UbicacionPorAreaDeInfluencia]([IdAreaDeInfluencia],[IdDepartamento],[IdMunicipio],[IdAldea],[IdCaserio],[IdBarrio]) VALUES (" + idareai + "," + depto + "," + muni + "," + Aldea + "," + Caserio + "," + Barrio + ")"

            Me.SqlUbicacion.Insert()

        End If


        SqlDataSourceAgregarUbicaciones.SelectParameters(0).DefaultValue = ASPxComboBoxAreaUbicaciones.Value
        ASPxGridViewUbicacionAreaDeInfluencia.DataBind()


    End Sub


    Protected Sub SqlDataSourceUbicacionArea_Inserted(sender As Object, e As SqlDataSourceStatusEventArgs)
        Me.SqlDataSourceUbicacionArea.SelectParameters(0).DefaultValue = Session("IdAreaDeInfluencia")
        ASPxGridViewAreaDeInfluencia.DataBind()
    End Sub

    Protected Sub GridMetas_Load(sender As Object, e As EventArgs)
        SqlMetas.SelectParameters(0).DefaultValue = CInt(CodPrograma.Text)
        SqlMetas.SelectParameters(1).DefaultValue = CInt(ComboAreaInfluencia.Value)
        SqlMetas.SelectParameters(2).DefaultValue = comboAño.Value
        SqlMetas.DataBind()
        GridMetas.DataBind()
    End Sub

    Protected Sub SqlDataSourceAreaDeInfluencia_Inserted(sender As Object, e As SqlDataSourceStatusEventArgs)
        'Dim command As DbCommand
        'command = e.Command
        'Session("IdAreaDeInfluencia") = command.Parameters("@IdAreaDeInfluencia").Value
        Dim sqlConnection1 As New System.Data.SqlClient.SqlConnection(WebConfigurationManager.ConnectionStrings("SUEPPSConnectionString").ConnectionString)
        Dim command As DbCommand
        command = e.Command


        'MsgBox(CStr(command.Parameters("@IdAreaDeInfluencia").Value))

        If IsDBNull(command.Parameters("@IdAreaDeInfluencia").Value) Then

        Else
            Dim cmd As New System.Data.SqlClient.SqlCommand
            cmd.CommandType = System.Data.CommandType.Text
            cmd.CommandText = "INSERT INTO MetaYMonitoreoPorPeriodo (Ano, IdIndicadorPorPrograma, IdAreaDeInfluencia, Activo, CreadoPor, FechaCreacion) " & _
                "SELECT an.Ano, ipp.IdIndicadoresPorPrograma, " & command.Parameters("@IdAreaDeInfluencia").Value & ", 1, '" + Membership.GetUser.UserName + "', getDate() " & _
                "FROM dbo.AnoPrograma as an " & _
                "JOIN dbo.IndicadoresPorPrograma as ipp ON an.IdPrograma = ipp.IdPrograma " & _
                "JOIN dbo.Indicadores as indi ON ipp.IdIndicador = indi.IdIndicador " & _
                "JOIN dbo.TiposDeIndicador as tdi ON tdi.IdTipoDeIndicador = indi.IdTipoDeIndicador " & _
                "WHERE an.Activo=1 and an.IdPrograma = " & CodPrograma.Text & " "
            cmd.Connection = sqlConnection1

            sqlConnection1.Open()
            cmd.ExecuteNonQuery()
            sqlConnection1.Close()

        End If




    End Sub

    Protected Sub combosector_Callback(sender As Object, e As CallbackEventArgsBase)
        Sqlcombosector.SelectCommand = "SELECT [DescripcionSectorIndicador],[IdSectorIndicador] FROM [vROISectorIndicadores]"
        Sqlcombosector.DataBind()
        combosector.DataBind()
    End Sub

    Protected Sub GridIndicadores_Load(sender As Object, e As EventArgs)
        Me.SqlIndicadores.SelectParameters(0).DefaultValue = CInt(combosector.Value)
        Me.GridIndicadores.DataBind()
    End Sub

    Protected Sub GridAno_Load(sender As Object, e As EventArgs)
        SqlAnoPrograma.SelectParameters(0).DefaultValue = Me.CodPrograma.Text
        Me.GridAno.DataBind()
    End Sub


    Protected Sub ASPxButtonAgregarIndicadoresDeCobertura_Click(sender As Object, e As EventArgs)
        'MessageBox.Show("Entra aqui")
        Dim sqlConnection1 As New System.Data.SqlClient.SqlConnection(WebConfigurationManager.ConnectionStrings("SUEPPSConnectionString").ConnectionString)
        Dim idP As String = uf.QueryStringDecode(Request.QueryString.Get(1))

        Dim cmd As New System.Data.SqlClient.SqlCommand
        cmd.CommandType = System.Data.CommandType.Text
        cmd.CommandText = "Insert into IndicadoresPorPrograma (IdIndicador, IdPrograma, Activo, CreadoPor, FechaCreacion ) " & _
                          "select IdIndicador, " & idP & ", 1, '" + Membership.GetUser.UserName + "', getDate() from Indicadores where IdTipoDeIndicador=2 and IdIndicador not in( " & _
                          "select IdIndicador from IndicadoresPorPrograma where IdPrograma= " & idP & " and IdIndicador in ( " & _
                          "select IdIndicador from Indicadores where IdTipoDeIndicador=2)) "

        cmd.Connection = sqlConnection1
        sqlConnection1.Open()
        cmd.ExecuteNonQuery()
        sqlConnection1.Close()
        AgregarMetasDeIndicadoresDeCobertura(idP)
        Me.SqlIndicadoresPorPrograma.SelectParameters(0).DefaultValue = idP
        Me.GridIndicadoresPorPrograma.DataBind()
    End Sub

    Protected Sub AgregarMetasDeIndicadoresDeCobertura(idP As String)
        Dim sqlConnection1 As New System.Data.SqlClient.SqlConnection(WebConfigurationManager.ConnectionStrings("SUEPPSConnectionString").ConnectionString)


        Dim cmd As New System.Data.SqlClient.SqlCommand
        cmd.CommandType = System.Data.CommandType.Text
        cmd.CommandText = "INSERT INTO MetaYMonitoreoPorPeriodo (Ano, IdAreaDeInfluencia, IdIndicadorPorPrograma, Activo, CreadoPor, FechaCreacion ) " & _
            "SELECT an.Ano, adi.IdAreaDeInfluencia, ipp.IdIndicadoresPorPrograma, 1, '" + Membership.GetUser.UserName + "', getDate() " & _
            "FROM dbo.AnoPrograma as an " & _
            "JOIN dbo.AreasDeInfluencia as adi  ON an.IdPrograma = adi.IdPrograma " & _
            "JOIN dbo.IndicadoresPorPrograma as ipp ON ipp.IdPrograma = an.IdPrograma " & _
            "JOIN dbo.Indicadores as i ON ipp.IdIndicador = i.IdIndicador " &
            "WHERE  an.Activo=1 and an.IdPrograma = " & idP & " And i.IdTipoDeIndicador = 2 And " & _
            "Not EXISTS " & _
            "(SELECT Ano, IdAreaDeInfluencia, IdIndicadorPorPrograma " & _
            "FROM dbo.MetaYMonitoreoPorPeriodo " & _
            "WHERE  Ano = an.Ano AND IdAreaDeInfluencia = adi.IdAreaDeInfluencia AND IdIndicadorPorPrograma = ipp.IdIndicadoresPorPrograma AND Activo=1) "
        cmd.Connection = sqlConnection1

        sqlConnection1.Open()
        cmd.ExecuteNonQuery()
        sqlConnection1.Close()
    End Sub

    Protected Sub Programa_Load(sender As Object, e As EventArgs) Handles Programa.Load
        Dim idP As String = uf.QueryStringDecode(Request.QueryString.Get(1))

        Me.SqlIndicadoresPorPrograma.SelectParameters(0).DefaultValue = idP
        SqlIndicadoresPorPrograma.DataBind()
        Me.GridIndicadoresPorPrograma.DataBind()
    End Sub

    Protected Sub ASPxButtonExportarIndicadoresPorPrograma_Click(sender As Object, e As EventArgs)
        ASPxGridViewExporterIndicadoresPorPrograma.WriteXlsxToResponse()

    End Sub

    Protected Sub ASPxButtonExportarIndicadoresm_Click(sender As Object, e As EventArgs)
        ASPxGridViewExporterExportarIndicadoresm.WriteXlsxToResponse()

    End Sub



    Protected Sub ASPxGridViewAreaDeInfluencia_Load(sender As Object, e As EventArgs)
        SqlDataSourceAreaDeInfluencia.SelectParameters(0).DefaultValue = Me.CodPrograma.Text
        Me.ASPxGridViewAreaDeInfluencia.DataBind()
    End Sub


    Protected Sub GridIndicadoresPorPrograma_Load(sender As Object, e As EventArgs)
        Me.SqlIndicadoresPorPrograma.SelectParameters(0).DefaultValue = CInt(CodPrograma.Text)
        Me.GridIndicadoresPorPrograma.DataBind()


    End Sub


    Protected Sub SqlDataSourceRecursos_Inserted(sender As Object, e As SqlDataSourceStatusEventArgs)
        SqlDataSourceRecursos.SelectParameters(0).DefaultValue = CInt(CodPrograma.Text)
        SqlDataSourceRecursos.DataBind()
        ASPxGridView2.DataBind()
    End Sub

    Protected Sub ASPxGridView2_Load(sender As Object, e As EventArgs)
        SqlDataSourceRecursos.SelectParameters(0).DefaultValue = CInt(CodPrograma.Text)
        SqlDataSourceRecursos.DataBind()
        ASPxGridView2.DataBind()
    End Sub

    Protected Sub linkUbicacion_Click(sender As Object, e As EventArgs)
        Dim index As Integer = ASPxGridViewAreaDeInfluencia.FocusedRowIndex()
        Dim nameproyecto As String = ASPxGridViewAreaDeInfluencia.GetRowValues(index, "IdAreaDeInfluencia").ToString
        Dim codproyecto As String = ASPxGridViewAreaDeInfluencia.GetRowValues(index, "DescripcionAreaDeInfluencia").ToString

        Response.Redirect("AgregarUbicacion.aspx?NameP=" + uf.QueryStringEncode(nameproyecto) + "&CodP=" + uf.QueryStringEncode(codproyecto))
    End Sub

    Protected Sub ASPxGridViewUbicacionAreaDeInfluencia_BeforePerformDataSelect1(sender As Object, e As EventArgs)
        SqlDataSourceAgregarUbicaciones.SelectParameters(0).DefaultValue = ASPxComboBoxAreaUbicaciones.Value
        ASPxGridViewUbicacionAreaDeInfluencia.DataBind()

    End Sub

    Protected Sub ComboMunicipios_Callback(ByVal source As Object, ByVal e As CallbackEventArgsBase)


        SqlMunicipio.SelectParameters(0).DefaultValue = Me.ComboDepartamentos.Value
        ComboMunicipios.DataBind()
    End Sub

    Protected Sub ComboAldeas_Callback(ByVal source As Object, ByVal e As CallbackEventArgsBase)
        SqlAldeas.SelectParameters(0).DefaultValue = ComboMunicipios.Value
        ComboAldeas.DataBind()
    End Sub

    Protected Sub ComboCaserio_Callback(ByVal source As Object, ByVal e As CallbackEventArgsBase)
        SqlCaserio.SelectParameters(0).DefaultValue = ComboAldeas.Value
        ComboCaserio.DataBind()
    End Sub

    Protected Sub ComboBarrio_Callback(ByVal source As Object, ByVal e As CallbackEventArgsBase)
        SqlBarrio.SelectParameters(0).DefaultValue = ComboCaserio.Value
        ComboBarrio.DataBind()
    End Sub

    Protected Sub ASPxComboBox2_Callback(sender As Object, e As CallbackEventArgsBase)
        SqlDataSource2.SelectParameters(0).DefaultValue = ASPxComboBox1.Value
        SqlDataSource2.SelectParameters(1).DefaultValue = CInt(CodPrograma.Text)
        SqlDataSource2.DataBind()
        ASPxComboBox2.DataBind()
    End Sub

    Protected Sub ASPxGridView1_Load(sender As Object, e As EventArgs)
        SqlDataSource3.SelectParameters(0).DefaultValue = ASPxComboBox2.Value
        SqlDataSource3.SelectParameters(1).DefaultValue = cmbAnoC.Text
        SqlDataSource3.DataBind()
        ASPxGridView1.DataBind()
    End Sub

    Protected Sub ASPxGridView1_CustomCallback(sender As Object, e As ASPxGridViewCustomCallbackEventArgs)



        If ASPxComboBox2.Text <> " " And cmbAnoC.Text = " " Then
            'No ha seleccionado el Año
        Else
            If ASPxComboBox2.Text <> " " And cmbAnoC.Text = " " Then
                SqlDataSource3.SelectParameters(0).DefaultValue = ASPxComboBox2.Value
                SqlDataSource3.SelectParameters(1).DefaultValue = cmbAnoC.Text
                SqlDataSource3.DataBind()
                ASPxGridView1.DataBind()
            End If
        End If
    End Sub

    Protected Sub ASPxComboBoxAreaUbicaciones_Callback(sender As Object, e As CallbackEventArgsBase)
        SqlDataSourceAreasUbicaciones.SelectParameters(0).DefaultValue = CInt(CodPrograma.Text)
        SqlDataSourceAreasUbicaciones.DataBind()
        ASPxComboBoxAreaUbicaciones.DataBind()
    End Sub
End Class


