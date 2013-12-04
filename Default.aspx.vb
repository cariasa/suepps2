
Partial Class Buscar
    Inherits System.Web.UI.Page

    Protected Sub btbuscar_Click(sender As Object, e As EventArgs)


        If txtbuscar.Text.Equals("") Then

        Else
            Dim txtSql As String = "SELECT [IdPolitica], [Nombre], [SujetosDeAtencion] FROM [Politicas]"
            Dim txtSql2 As String = "SELECT [codigo_ficha], [ley], [NombreProyecto], [decreto], [codigo_proyecto], [TotalFinanciamientoML] FROM [vProyectos]"
            Dim txtSql3 As String = "SELECT b.[NombreProyecto], a.[Comentario], a.[Fecha], a.[Usuario], a.[Ano], a.[Periodo] FROM [SistematizacionDeMonitoreo] a join [vProyectos] b on a.[IdPrograma]= b.[codigo_ficha]"



            Dim TestString As String = txtbuscar.Text

            Dim TestArray() As String = Split(TestString)

            Dim LastNonEmpty As Integer = -1
            For i As Integer = 0 To TestArray.Length - 1
                If TestArray(i) <> "" Then
                    LastNonEmpty += 1
                    TestArray(LastNonEmpty) = TestArray(i)
                End If
            Next
            ReDim Preserve TestArray(LastNonEmpty)


            For i As Integer = 0 To TestArray.Length - 1
                If i = 0 Then
                    txtSql = txtSql + " WHERE [Nombre] LIKE '%" + TestArray(i) + "%"
                    txtSql2 = txtSql2 + " WHERE [NombreProyecto] LIKE '%" + TestArray(i) + "%"
                    txtSql3 = txtSql3 + " WHERE [Comentario] LIKE '%" + TestArray(i) + "%"
                Else
                    txtSql = txtSql + TestArray(i) + "%"
                    txtSql2 = txtSql2 + TestArray(i) + "%"
                    txtSql3 = txtSql3 + TestArray(i) + "%"
                End If

            Next
            txtSql = txtSql + "'"
            txtSql2 = txtSql2 + "'"
            txtSql3 = txtSql3 + "'"

            'For i As Integer = 0 To TestArray.Length - 1
            '    If i = 0 Then
            '        txtSql = txtSql + " OR [ObjetivosEstrategicos] LIKE '%" + TestArray(i) + "%"
            '    Else
            '        txtSql = txtSql + TestArray(i) + "%"
            '    End If

            'Next
            'txtSql = txtSql + "'"

            'For i As Integer = 0 To TestArray.Length - 1
            '    If i = 0 Then
            '        txtSql = txtSql + " OR [ObjetivosEspecificos] LIKE '%" + TestArray(i) + "%"
            '    Else
            '        txtSql = txtSql + TestArray(i) + "%"
            '    End If

            'Next
            'txtSql = txtSql + "'"

            For i As Integer = 0 To TestArray.Length - 1
                If i = 0 Then
                    txtSql = txtSql + " OR [SujetosDeAtencion] LIKE '%" + TestArray(i) + "%"
                Else
                    txtSql = txtSql + TestArray(i) + "%"
                End If

            Next
            txtSql = txtSql + "'"


            Me.SqlPolitica.SelectCommand = txtSql
            Me.SqlPolitica.DataBind()

            Me.SqlProgramas.SelectCommand = txtSql2
            Me.SqlProgramas.DataBind()

            Me.SqlInsumos.SelectCommand = txtSql3
            Me.SqlInsumos.DataBind()
            'MsgBox(txtSql)

        End If



    End Sub
End Class
