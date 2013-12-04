Imports DevExpress.Web.ASPxClasses
Imports DevExpress.Web.ASPxGridView

Partial Class GestionPublica_AgregarUbicacion
    Inherits System.Web.UI.Page

    Protected Sub AgregarUbicacion_Click(sender As Object, e As EventArgs)

        Dim idareai As String = Session("IdAreaDeInfluencia")


        Dim depto As String = Me.ComboDepartamentos.Value
        Dim muni As String = Me.ComboMunicipios.Value
        Dim Aldea As String = Me.ComboAldeas.Value
        Dim Caserio As String = Me.ComboCaserio.Value
        Dim Barrio As String = Me.ComboBarrio.Value

        MsgBox("Departamento: " + Me.ComboDepartamentos.Text)
        MsgBox("Municipio: " + Me.ComboMunicipios.Text)

        If muni = "" And depto <> "" Then

            Me.SqlUbicacion.InsertCommand = "SET @AP = (SELECT IdUbicacionPorAreaDeInfluencia FROM [UbicacionPorAreaDeInfluencia] " & _
       "where IdAreaDeInfluencia =" + idareai + "" & _
        " and IdDepartamento=" + depto + " and Activo=1 and EsTodoDepartamento=1" & _
           ")" & _
       "IF (@AP is NULL)" & _
           "BEGIN " & _
   "INSERT INTO [UbicacionPorAreaDeInfluencia]([IdAreaDeInfluencia],[IdDepartamento], [EsTodoDepartamento], [Activo]) VALUES (" + idareai + "," + depto + ", 1 ,1  )" & _
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
  "INSERT INTO [UbicacionPorAreaDeInfluencia]([IdAreaDeInfluencia],[IdDepartamento],[IdMunicipio], [EsTodoMunicipio], [Activo]) VALUES (" + idareai + "," + depto + "," + muni + ",1,1)" & _
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
  "INSERT INTO [UbicacionPorAreaDeInfluencia]([IdAreaDeInfluencia],[IdDepartamento],[IdMunicipio],[IdAldea], [EsTodoAldea], [Activo]) VALUES (" + idareai + "," + depto + "," + muni + "," + Aldea + ",1,1)" & _
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
 "INSERT INTO [UbicacionPorAreaDeInfluencia]([IdAreaDeInfluencia],[IdDepartamento],[IdMunicipio],[IdAldea],[IdCaserio],[Activo],[EsTodoCacerio]) VALUES (" + idareai + "," + depto + "," + muni + "," + Aldea + "," + Caserio + ",1,1)" & _
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
"INSERT INTO [UbicacionPorAreaDeInfluencia]([IdAreaDeInfluencia],[IdDepartamento],[IdMunicipio],[IdAldea],[IdCaserio],[IdBarrio],[Activo]) VALUES (" + idareai + "," + depto + "," + muni + "," + Aldea + "," + Caserio + "," + Barrio + ",1)" & _
 "END"

            'Me.SqlUbicacion.InsertCommand = "INSERT INTO [UbicacionPorAreaDeInfluencia]([IdAreaDeInfluencia],[IdDepartamento],[IdMunicipio],[IdAldea],[IdCaserio],[IdBarrio]) VALUES (" + idareai + "," + depto + "," + muni + "," + Aldea + "," + Caserio + "," + Barrio + ")"

            Me.SqlUbicacion.Insert()

        End If

        Me.SqlDataSourceUbicacionArea.SelectParameters(0).DefaultValue = Session("IdAreaDeInfluencia")
        'ASPxGridViewAreaDeInfluencia.DataBind()

    End Sub

    Protected Sub SqlDataSourceUbicacionArea_Inserted(sender As Object, e As SqlDataSourceStatusEventArgs)
        Me.SqlDataSourceUbicacionArea.SelectParameters(0).DefaultValue = Session("IdAreaDeInfluencia")
        'ASPxGridViewAreaDeInfluencia.DataBind()
    End Sub


    Protected Sub ASPxGridViewUbicacionAreaDeInfluencia_Init(sender As Object, e As EventArgs)
        Dim grid As ASPxGridView = sender
        Dim index As Integer = grid.FocusedRowIndex

        SqlDataSourceMunicipios.SelectParameters(0).DefaultValue = grid.GetRowValues(index, "IdDepartamento")

        SqlDataSourceAldeas.SelectParameters(0).DefaultValue = grid.GetRowValues(index, "IdDepartamento")
        SqlDataSourceAldeas.SelectParameters(1).DefaultValue = grid.GetRowValues(index, "IdMunicipio")

        SqlDataSourceBarrios.SelectParameters(0).DefaultValue = grid.GetRowValues(index, "IdDepartamento")
        SqlDataSourceBarrios.SelectParameters(1).DefaultValue = grid.GetRowValues(index, "IdMunicipio")
        SqlDataSourceBarrios.SelectParameters(2).DefaultValue = grid.GetRowValues(index, "IdAldea")
        SqlDataSourceBarrios.SelectParameters(3).DefaultValue = grid.GetRowValues(index, "IdCaserio")

        SqlDataSourceCaserios.SelectParameters(0).DefaultValue = grid.GetRowValues(index, "IdDepartamento")
        SqlDataSourceCaserios.SelectParameters(1).DefaultValue = grid.GetRowValues(index, "IdMunicipio")
        SqlDataSourceCaserios.SelectParameters(2).DefaultValue = grid.GetRowValues(index, "IdAldea")

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

    Protected Sub Page_Load(sender As Object, e As EventArgs) Handles Me.Load
        SqlDataSourceUbicacionArea.SelectParameters(0).DefaultValue = uf.QueryStringDecode(Request.QueryString.Get(0))

    End Sub
End Class
