Imports DevExpress.Web.ASPxEditors
Imports DevExpress.Web.ASPxCallback
Imports System.Data.Common

Partial Class RevisionSocial_MonitoreoCualitativo
    Inherits System.Web.UI.Page

    Dim contadorLabels As Integer = 1
    Dim contadorpabiertas As Integer = 1
    Dim contadorplinker As Integer = 1
    Dim contadorou As Integer = 1
    Dim contadorom As Integer = 1
    Dim contadoropciones As Integer = 0
    Dim contadorotros As Integer = 1
    Dim totalotros As Integer = 0

    Public Structure Nodo
        Public IdPregunta As String
        Public IDComponente As String
        Public TipoPregunta As String
        Public NumOpciones As Integer
        Public Requerida As Boolean
        Public TipoRespuesta As Integer
    End Structure

    Public Structure NodoOpcion
        Public IdOp As String
        Public Descripcion As String
        Public IdPreguntaM As String
        Public Valor As Integer
    End Structure


    '..............................................................................................................................
    '///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    Public Sub Limpiar()

        Dim ContenedorObjetos As ArrayList
        Dim ContenedorOpciones As ArrayList

        ContenedorObjetos = Session("CRespuestas")
        ContenedorOpciones = Session("COpciones")

        contadorotros = 1

        Dim size As Integer = ContenedorObjetos.Count

        For i As Integer = 0 To size - 1

            Dim NC As Nodo = New Nodo()
            NC = ContenedorObjetos(i)

            If NC.TipoPregunta.Equals("1") Then

                Dim myControl1 As Control = Panel.FindControl(NC.IDComponente)
                If (Not myControl1 Is Nothing) Then

                    If (NC.TipoRespuesta = 4) Then


                        Dim box1 As ASPxDateEdit = TryCast(Panel.FindControl(NC.IDComponente), ASPxDateEdit)
                        box1.Text = ""
                    Else
                        Dim box1 As ASPxTextBox = TryCast(Panel.FindControl(NC.IDComponente), ASPxTextBox)
                        box1.Text = ""
                    End If

                    

                End If

            End If

            If NC.TipoPregunta.Equals("2") Then

                Dim myControl1 As Control = Panel.FindControl(NC.IDComponente)
                If (Not myControl1 Is Nothing) Then
                    Dim box As RadioButtonList = TryCast(Panel.FindControl(NC.IDComponente), RadioButtonList)
                    box.ClearSelection()
                
                End If

            End If

            If NC.TipoPregunta.Equals("3") Or NC.TipoPregunta.Equals("5") Then


                Dim myControl1 As Control = Panel.FindControl(NC.IDComponente)

                If (Not myControl1 Is Nothing) Then

                    Dim box As CheckBoxList = TryCast(Panel.FindControl(NC.IDComponente), CheckBoxList)
                    box.ClearSelection()

                End If


            End If

            If NC.TipoPregunta.Equals("4") Or NC.TipoPregunta.Equals("6") Or NC.TipoPregunta.Equals("7") Then

                Dim myControl1 As Control = Panel.FindControl(NC.IDComponente)
                If (Not myControl1 Is Nothing) Then
  
                    TryCast(Panel.FindControl(NC.IDComponente), ASPxTextBox).Text = ""

                    End If


            End If


        Next


        For j As Integer = 1 To totalotros - 1

            Dim box1 As ASPxTextBox = TryCast(Panel.FindControl("Otro" + CStr(j)), ASPxTextBox)
            box1.Text = ""

        Next

    End Sub
    '///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


    Public Function Validar() As Boolean

        Dim ContenedorObjetos As ArrayList
        Dim ContenedorOpciones As ArrayList

        ContenedorObjetos = Session("CRespuestas")
        ContenedorOpciones = Session("COpciones")

        contadorotros = 1

        Dim size As Integer = ContenedorObjetos.Count

        For i As Integer = 0 To size - 1

            Dim NC As Nodo = New Nodo()
            NC = ContenedorObjetos(i)

            '-----------------------------------------------------------------------------------------
            If NC.TipoPregunta.Equals("1") Then

                Dim myControl1 As Control = Panel.FindControl(NC.IDComponente)
                If (Not myControl1 Is Nothing) Then

                    If (NC.TipoRespuesta = 4) Then

                        Dim box1 As ASPxDateEdit
                        box1 = TryCast(Panel.FindControl(NC.IDComponente), ASPxDateEdit)

                        Dim Respuesta As String = box1.Text

                        Dim IdEncabezado As String = CStr(Session("IdEncabezado"))


                        If (NC.Requerida = True And box1.Text = "") Then

                            MsgBox("Es Requerida de Fecha no puede estar en blanco")

                            Return False

                        End If

                    Else

                        Dim box1 As ASPxTextBox
                        box1 = TryCast(Panel.FindControl(NC.IDComponente), ASPxTextBox)

                        Dim Respuesta As String = box1.Text

                        Dim IdEncabezado As String = CStr(Session("IdEncabezado"))

                        If (NC.Requerida = True And box1.Text = "") Then


                            Return False

                        End If

                    End If

                   


                Else
                    'MsgBox("No encontro")
                End If

            End If

            '-----------------------------------------------------------------------------------------

            If NC.TipoPregunta.Equals("2") Then

                Dim myControl1 As Control = Panel.FindControl(NC.IDComponente)
                If (Not myControl1 Is Nothing) Then
                    Dim Mul As New RadioButtonList
                    Mul = TryCast(Panel.FindControl(NC.IDComponente), RadioButtonList)

                    If NC.Requerida = True And Mul.SelectedValue.Length = 0 Then

                        'MsgBox("Es Requerida Linker no puede estar en blanco")

                        Return False


                    End If

                Else

                End If

            End If

            '-----------------------------------------------------------------------------------------

            If NC.TipoPregunta.Equals("5") Then


                Dim myControl1 As Control = Panel.FindControl(NC.IDComponente)

                If (Not myControl1 Is Nothing) Then


                    Dim Mul As New CheckBoxList()
                    Mul = TryCast(Panel.FindControl(NC.IDComponente), CheckBoxList)

                    Dim Otrobox As New ASPxTextBox
                    Otrobox = TryCast(Panel.FindControl("Otro" + CStr(contadorotros)), ASPxTextBox)

                    If NC.Requerida = True And Mul.SelectedValue.Length = 0 And Otrobox.Text.Equals(" ") Then

                        MsgBox("Es Requerida Multiple Otro no puede estar en blanco")

                        Return False


                    End If

                    If Mul.Items.Count > 1 Then
                        For s As Integer = 0 To Mul.Items.Count - 1
                            contadoropciones = contadoropciones + 1
                        Next
                    End If

                    contadoropciones = contadoropciones + 1
                    contadorotros = contadorotros + 1

                Else

                End If


            End If

            '-----------------------------------------------------------------------------------------

            If NC.TipoPregunta.Equals("3") Then


                Dim myControl1 As Control = Panel.FindControl(NC.IDComponente)

                If (Not myControl1 Is Nothing) Then


                    Dim Mul As New CheckBoxList()
                    Mul = TryCast(Panel.FindControl(NC.IDComponente), CheckBoxList)


                    If NC.Requerida = True And Mul.SelectedValue.Length = 0 Then

                        MsgBox("Es Requerida Multiple no puede estar en blanco")

                        Return False


                    End If

                    If Mul.Items.Count > 1 Then
                        For s As Integer = 0 To Mul.Items.Count - 1
                            'Dim nodoo As NodoOpcion = New NodoOpcion()
                            'nodoo = ContenedorOpciones(contadoropciones)
                            'MsgBox(nodoo.Descripcion)
                            contadoropciones = contadoropciones + 1
                        Next
                    End If
                Else

                End If


            End If

            '-----------------------------------------------------------------------------------------

            If NC.TipoPregunta.Equals("6") Then

                Dim myControl1 As Control = Panel.FindControl(NC.IDComponente)
                If (Not myControl1 Is Nothing) Then
                   
                    Dim Mul As New ASPxTextBox
                    Mul = TryCast(Panel.FindControl(NC.IDComponente), ASPxTextBox)

                    Dim Otrobox As New ASPxTextBox
                    Otrobox = TryCast(Panel.FindControl("Otro" + CStr(contadorotros)), ASPxTextBox)


                    If NC.Requerida = True And Mul.Text.Equals("") And Otrobox.Text.Equals("") Then

                        MsgBox("Es Requerida Opcion no puede estar en blanco")

                        Return False

                    Else

                        If (Mul.Text <> " " And Otrobox.Text.Equals(" ")) Then

                            Dim bandera As Boolean = False

                            'MsgBox("Opciones 1: " + CStr(NC.NumOpciones))

                            For s As Integer = 0 To NC.NumOpciones - 1
                                Dim nodoo As NodoOpcion = New NodoOpcion()
                                nodoo = ContenedorOpciones(contadoropciones)
                                'MsgBox(nodoo.Descripcion)
                                If nodoo.Valor = Integer.Parse(Mul.Text) And nodoo.IdPreguntaM.Equals(NC.IdPregunta) Then
                                    bandera = True
                                End If
                                contadoropciones = contadoropciones + 1
                            Next

                            contadoropciones = contadoropciones + 1
                            contadorotros = contadorotros + 1

                            If (bandera = False) Then

                                MsgBox("Opcion no valida verifique una que exista/Unica Otro")

                                Return False

                            End If

                        ElseIf (Mul.Text <> " " And Otrobox.Text <> " ") Then

                            MsgBox("Opciones Varias Verifique")

                            Return False
                        ElseIf (Mul.Text.Equals(" ") And Otrobox.Text <> " ") Then

                            ' MsgBox("Opciones 2: " + CStr(NC.NumOpciones))

                            For s As Integer = 0 To NC.NumOpciones - 1
                                'Dim nodoo As NodoOpcion = New NodoOpcion()
                                'nodoo = ContenedorOpciones(contadoropciones)
                                'MsgBox(nodoo.Descripcion)
                                contadoropciones = contadoropciones + 1
                            Next

                            contadorotros = contadorotros + 1


                        End If


                    End If


                Else
                    'MsgBox("No encontro")
                End If

            End If

            '-----------------------------------------------------------------------------------------

            If NC.TipoPregunta.Equals("4") Or NC.TipoPregunta.Equals("7") Then

                Dim myControl1 As Control = Panel.FindControl(NC.IDComponente)
                If (Not myControl1 Is Nothing) Then

                    Dim Mul As New ASPxTextBox
                    Mul = TryCast(Panel.FindControl(NC.IDComponente), ASPxTextBox)

                    If NC.Requerida = True And Mul.Text = "" Then

                        'MsgBox("Es Requerida Opcion no puede estar en blanco")

                        Return False

                    Else

                        Dim bandera As Boolean = False

                        For s As Integer = 0 To NC.NumOpciones - 1
                            Dim nodoo As NodoOpcion = New NodoOpcion()
                            nodoo = ContenedorOpciones(contadoropciones)

                            ' MsgBox(nodoo.Descripcion)

                            If nodoo.Valor = Integer.Parse(Mul.Text) And nodoo.IdPreguntaM.Equals(NC.IdPregunta) Then
                                bandera = True
                            End If
                            contadoropciones = contadoropciones + 1
                        Next

                        If (bandera = False) Then


                            Return False


                        End If

                    End If



                Else
                    'MsgBox("No encontro")
                End If

            End If

            '-----------------------------------------------------------------------------------------

        Next



        Return True

    End Function

    '///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


    Protected Sub ASPxButton1_Click(sender As Object, e As EventArgs)

        If GridAplicacion.VisibleRowCount = 1 Then

            If Validar() = True Then
                contadoropciones = 0
                contadorotros = 1

                SqlDataSourceEncabezado.InsertParameters(0).DefaultValue = Session("CodFSU")
                SqlDataSourceEncabezado.InsertParameters(1).DefaultValue = Session("CodDigitador")
                SqlDataSourceEncabezado.InsertParameters(2).DefaultValue = Session("IdAplicacion")
                SqlDataSourceEncabezado.InsertParameters(3).DefaultValue = Membership.GetUser.UserName
                SqlDataSourceEncabezado.InsertParameters("IdVivienda").DefaultValue = uf.QueryStringDecode(Request.QueryString.Get("IdVivienda"))
                SqlDataSourceEncabezado.InsertParameters("IdHogar").DefaultValue = uf.QueryStringDecode(Request.QueryString.Get("IdHogar"))
                SqlDataSourceEncabezado.InsertParameters("IdMiembro").DefaultValue = uf.QueryStringDecode(Request.QueryString.Get("IdMiembro"))
                SqlDataSourceEncabezado.Insert()
                'Agregar campos de ancla

                Dim ContenedorObjetos As ArrayList
                Dim ContenedorOpciones As ArrayList

                ContenedorObjetos = Session("CRespuestas")
                ContenedorOpciones = Session("COpciones")


                Dim size As Integer = ContenedorObjetos.Count

                For i As Integer = 0 To size - 1

                    Dim NC As Nodo = New Nodo()
                    NC = ContenedorObjetos(i)


                    If NC.TipoPregunta.Equals("1") Then

                        Dim myControl1 As Control = Panel.FindControl(NC.IDComponente)
                        If (Not myControl1 Is Nothing) Then

                            If (NC.TipoRespuesta = 4) Then

                                Dim box1 As ASPxDateEdit
                                box1 = TryCast(Panel.FindControl(NC.IDComponente), ASPxDateEdit)

                                Dim IdEncabezado As String = CStr(Session("IdEncabezado"))

                                SqlRespuestas.InsertCommand = "INSERT INTO [RespuestasInstrumento] ([IdPreguntaPorInstrumento],[IdEncabezadoRespuesta],[RespuestaFecha],[Activo],[CreadoPor],[FechaCreacion],[RespuestaTexto]) VALUES (@IdPreguntaPorInstrumento, @IdEncabezadoRespuesta, @Respuesta, 1, @Usuario, getDate(),@Respuesta) SELECT @IdRespuestaInstrumento = SCOPE_IDENTITY()"
                                SqlRespuestas.InsertParameters(0).DefaultValue = NC.IdPregunta
                                SqlRespuestas.InsertParameters(1).DefaultValue = IdEncabezado
                                SqlRespuestas.InsertParameters(2).DefaultValue = box1.Text
                                SqlRespuestas.InsertParameters(3).DefaultValue = Membership.GetUser.UserName
                                SqlRespuestas.Insert()


                            ElseIf (NC.TipoRespuesta = 2) Then

                                Dim box1 As ASPxTextBox
                                box1 = TryCast(Panel.FindControl(NC.IDComponente), ASPxTextBox)

                                Dim IdEncabezado As String = CStr(Session("IdEncabezado"))

                                SqlRespuestas.InsertCommand = "INSERT INTO [RespuestasInstrumento] ([IdPreguntaPorInstrumento],[IdEncabezadoRespuesta],[RespuestaTexto],[Activo],[CreadoPor],[FechaCreacion]) VALUES (@IdPreguntaPorInstrumento, @IdEncabezadoRespuesta, @Respuesta, 1, @Usuario, getDate()) SELECT @IdRespuestaInstrumento = SCOPE_IDENTITY()"
                                SqlRespuestas.InsertParameters(0).DefaultValue = NC.IdPregunta
                                SqlRespuestas.InsertParameters(1).DefaultValue = IdEncabezado
                                SqlRespuestas.InsertParameters(2).DefaultValue = box1.Text
                                SqlRespuestas.InsertParameters(3).DefaultValue = Membership.GetUser.UserName
                                SqlRespuestas.Insert()

                            ElseIf (NC.TipoRespuesta = 1) Then
                                Dim box1 As ASPxTextBox
                                box1 = TryCast(Panel.FindControl(NC.IDComponente), ASPxTextBox)

                                Dim IdEncabezado As String = CStr(Session("IdEncabezado"))

                                SqlRespuestas.InsertCommand = "INSERT INTO [RespuestasInstrumento] ([IdPreguntaPorInstrumento],[IdEncabezadoRespuesta],[RespuestaEntera],[Activo],[CreadoPor],[FechaCreacion],[RespuestaTexto]) VALUES (@IdPreguntaPorInstrumento, @IdEncabezadoRespuesta, @Respuesta, 1, @Usuario, getDate(),@Respuesta) SELECT @IdRespuestaInstrumento = SCOPE_IDENTITY()"
                                SqlRespuestas.InsertParameters(0).DefaultValue = NC.IdPregunta
                                SqlRespuestas.InsertParameters(1).DefaultValue = IdEncabezado
                                SqlRespuestas.InsertParameters(2).DefaultValue = box1.Text
                                SqlRespuestas.InsertParameters(3).DefaultValue = Membership.GetUser.UserName
                                SqlRespuestas.Insert()
                            ElseIf (NC.TipoRespuesta = 3) Then
                                Dim box1 As ASPxTextBox
                                box1 = TryCast(Panel.FindControl(NC.IDComponente), ASPxTextBox)

                                Dim IdEncabezado As String = CStr(Session("IdEncabezado"))

                                SqlRespuestas.InsertCommand = "INSERT INTO [RespuestasInstrumento] ([IdPreguntaPorInstrumento],[IdEncabezadoRespuesta],[RespuestaReal],[Activo],[CreadoPor],[FechaCreacion],[RespuestaTexto]) VALUES (@IdPreguntaPorInstrumento, @IdEncabezadoRespuesta, @Respuesta, 1, @Usuario, getDate(),@Respuesta]) SELECT @IdRespuestaInstrumento = SCOPE_IDENTITY()"
                                SqlRespuestas.InsertParameters(0).DefaultValue = NC.IdPregunta
                                SqlRespuestas.InsertParameters(1).DefaultValue = IdEncabezado
                                SqlRespuestas.InsertParameters(2).DefaultValue = box1.Text
                                SqlRespuestas.InsertParameters(3).DefaultValue = Membership.GetUser.UserName
                                SqlRespuestas.Insert()

                            End If

                        Else
                            'MsgBox("No encontro")
                        End If

                    End If

                    If NC.TipoPregunta.Equals("2") Then

                        Dim myControl1 As Control = Panel.FindControl(NC.IDComponente)
                        If (Not myControl1 Is Nothing) Then
                            Dim Mul As New RadioButtonList
                            Mul = TryCast(Panel.FindControl(NC.IDComponente), RadioButtonList)

                            SqlRespuestas.InsertCommand = "INSERT INTO [RespuestasInstrumento] ([IdPreguntaPorInstrumento],[IdEncabezadoRespuesta],[RespuestaLikert],[Activo],[CreadoPor],[FechaCreacion]) VALUES (@IdPreguntaPorInstrumento, @IdEncabezadoRespuesta, @Respuesta, 1, @Usuario, getDate()) SELECT @IdRespuestaInstrumento = SCOPE_IDENTITY()"


                            SqlRespuestas.InsertParameters(0).DefaultValue = NC.IdPregunta
                            SqlRespuestas.InsertParameters(1).DefaultValue = CStr(Session("IdEncabezado"))
                            SqlRespuestas.InsertParameters(2).DefaultValue = Mul.SelectedValue
                            SqlRespuestas.InsertParameters(3).DefaultValue = Membership.GetUser.UserName
                            SqlRespuestas.Insert()

                        Else

                        End If

                    End If


                    If NC.TipoPregunta.Equals("5") Then

                        Dim myControl1 As Control = Panel.FindControl(NC.IDComponente)

                        If (Not myControl1 Is Nothing) Then


                            Dim Mul As New CheckBoxList()
                            Mul = TryCast(Panel.FindControl(NC.IDComponente), CheckBoxList)

                            SqlRespuestas.InsertCommand = "INSERT INTO [RespuestasInstrumento] ([IdPreguntaPorInstrumento],[IdEncabezadoRespuesta],[Activo],[CreadoPor],[FechaCreacion]) VALUES (@IdPreguntaPorInstrumento, @IdEncabezadoRespuesta,1, @Usuario, getDate()) SELECT @IdRespuestaInstrumento = SCOPE_IDENTITY()"


                            SqlRespuestas.InsertParameters(0).DefaultValue = NC.IdPregunta
                            SqlRespuestas.InsertParameters(1).DefaultValue = CStr(Session("IdEncabezado"))
                            SqlRespuestas.InsertParameters(3).DefaultValue = Membership.GetUser.UserName

                            SqlRespuestas.Insert()


                            If Mul.Items.Count > 1 Then
                                For s As Integer = 0 To Mul.Items.Count - 1
                                    If Mul.Items(s).Selected = True Then


                                        Dim nodoo As NodoOpcion = New NodoOpcion()
                                        nodoo = ContenedorOpciones(contadoropciones)

                                        If nodoo.Descripcion.Equals(Mul.Items(s).Text) And nodoo.IdPreguntaM.Equals(NC.IdPregunta) Then

                                            SqlRespuestasOpciones.InsertCommand = "INSERT INTO [OpcionesRespuestaInstrumento] ([IdOpcionPreguntaPorInstrumento],[IdRespuestaInstrumento],[Activo],[CreadoPor],[FechaCreacion]) VALUES (" + nodoo.IdOp + ", " + CStr(Session("IdRespuestaPregunta")) + ",1, '" + Membership.GetUser.UserName + "', getDate())"
                                            SqlRespuestasOpciones.Insert()

                                        End If
                                    End If
                                    contadoropciones = contadoropciones + 1
                                Next
                            End If


                            Dim boxotro As New ASPxTextBox()
                            boxotro = TryCast(Panel.FindControl("Otro" + CStr(contadorotros)), ASPxTextBox)

                            Dim nodooo As NodoOpcion = New NodoOpcion()
                            nodooo = ContenedorOpciones(contadoropciones)
                            contadoropciones = contadoropciones + 1

                            SqlRespuestasOpciones.InsertCommand = "INSERT INTO [OpcionesRespuestaInstrumento] ([IdOpcionPreguntaPorInstrumento],[IdRespuestaInstrumento],[Activo],[CreadoPor],[FechaCreacion],[Otro]) VALUES (" + nodooo.IdOp + ", " + CStr(Session("IdRespuestaPregunta")) + ",1, '" + Membership.GetUser.UserName + "', getDate(),'" + boxotro.Text + "')"
                            SqlRespuestasOpciones.Insert()
                            contadorotros = contadorotros + 1


                        Else

                        End If


                    End If


                    If NC.TipoPregunta.Equals("3") Then


                        Dim myControl1 As Control = Panel.FindControl(NC.IDComponente)

                        If (Not myControl1 Is Nothing) Then


                            Dim Mul As New CheckBoxList()
                            Mul = TryCast(Panel.FindControl(NC.IDComponente), CheckBoxList)

                            SqlRespuestas.InsertCommand = "INSERT INTO [RespuestasInstrumento] ([IdPreguntaPorInstrumento],[IdEncabezadoRespuesta],[Activo],[CreadoPor],[FechaCreacion]) VALUES (@IdPreguntaPorInstrumento, @IdEncabezadoRespuesta,1, @Usuario, getDate()) SELECT @IdRespuestaInstrumento = SCOPE_IDENTITY()"


                            SqlRespuestas.InsertParameters(0).DefaultValue = NC.IdPregunta
                            SqlRespuestas.InsertParameters(1).DefaultValue = CStr(Session("IdEncabezado"))
                            SqlRespuestas.InsertParameters(3).DefaultValue = Membership.GetUser.UserName

                            SqlRespuestas.Insert()


                            If Mul.Items.Count > 1 Then
                                For s As Integer = 0 To Mul.Items.Count - 1
                                    If Mul.Items(s).Selected = True Then


                                        Dim nodoo As NodoOpcion = New NodoOpcion()
                                        nodoo = ContenedorOpciones(contadoropciones)

                                        If nodoo.Descripcion.Equals(Mul.Items(s).Text) And nodoo.IdPreguntaM.Equals(NC.IdPregunta) Then

                                            SqlRespuestasOpciones.InsertCommand = "INSERT INTO [OpcionesRespuestaInstrumento] ([IdOpcionPreguntaPorInstrumento],[IdRespuestaInstrumento],[Activo],[CreadoPor],[FechaCreacion]) VALUES (" + nodoo.IdOp + ", " + CStr(Session("IdRespuestaPregunta")) + ",1, '" + Membership.GetUser.UserName + "', getDate())"
                                            SqlRespuestasOpciones.Insert()

                                        End If
                                    End If
                                    contadoropciones = contadoropciones + 1
                                Next
                            End If
                        Else

                        End If


                    End If

                    '----------------------------------------------------------------------------------------------------------------------------------

                    If (NC.TipoPregunta.Equals("6")) Then

                        Dim myControl1 As Control = Panel.FindControl(NC.IDComponente)
                        If (Not myControl1 Is Nothing) Then

                            Dim Mul As New ASPxTextBox
                            Mul = TryCast(Panel.FindControl(NC.IDComponente), ASPxTextBox)

                            Dim Otrobox As New ASPxTextBox
                            Otrobox = TryCast(Panel.FindControl("Otro" + CStr(contadorotros)), ASPxTextBox)


                            SqlRespuestas.InsertCommand = "INSERT INTO [RespuestasInstrumento] ([IdPreguntaPorInstrumento],[IdEncabezadoRespuesta],[Activo],[CreadoPor],[FechaCreacion]) VALUES (@IdPreguntaPorInstrumento, @IdEncabezadoRespuesta,1, @Usuario, getDate()) SELECT @IdRespuestaInstrumento = SCOPE_IDENTITY()"


                            SqlRespuestas.InsertParameters(0).DefaultValue = NC.IdPregunta
                            SqlRespuestas.InsertParameters(1).DefaultValue = CStr(Session("IdEncabezado"))
                            SqlRespuestas.InsertParameters(3).DefaultValue = Membership.GetUser.UserName
                            SqlRespuestas.Insert()

                            Dim almacenarvalor As Integer = contadoropciones

                            If (Mul.Text <> " " And Otrobox.Text = " ") Then

                                For s As Integer = 0 To NC.NumOpciones - 1
                                    Dim nodoo As NodoOpcion = New NodoOpcion()
                                    nodoo = ContenedorOpciones(contadoropciones)

                                    If nodoo.Valor = Integer.Parse(Mul.Text) And nodoo.IdPreguntaM.Equals(NC.IdPregunta) Then
                                        'Es una respuesta seleccionada de esa pregunta, insertar opcion 

                                        SqlRespuestasOpciones.InsertCommand = "INSERT INTO [OpcionesRespuestaInstrumento] ([IdOpcionPreguntaPorInstrumento],[IdRespuestaInstrumento],[Activo],[CreadoPor],[FechaCreacion]) VALUES (" + nodoo.IdOp + ", " + CStr(Session("IdRespuestaPregunta")) + ",1, '" + Membership.GetUser.UserName + "', getDate())"
                                        SqlRespuestasOpciones.Insert()
                                        SqlRespuestas.UpdateCommand = "UPDATE [RespuestasInstrumento] SET [RespuestaTexto]='" + nodoo.Descripcion + "',[ActualizadoPor]='" + Membership.GetUser.UserName + "', [FechaActualizacion]=getDate() WHERE  [IdRespuestaInstrumento] = " + Session("IdRespuestaPregunta") + ""
                                        SqlRespuestas.Update()


                                    End If
                                    contadoropciones = contadoropciones + 1
                                Next


                            End If

                            If (Mul.Text = " " And Otrobox.Text <> " ") Then

                                contadoropciones = almacenarvalor

                                For s As Integer = 0 To NC.NumOpciones - 1
                                    Dim nodoo As NodoOpcion = New NodoOpcion()
                                    nodoo = ContenedorOpciones(contadoropciones)

                                    If nodoo.Descripcion = "Otro" And nodoo.IdPreguntaM.Equals(NC.IdPregunta) Then
                                        'Es una respuesta seleccionada de esa pregunta, insertar opcion 

                                        SqlRespuestasOpciones.InsertCommand = "INSERT INTO [OpcionesRespuestaInstrumento] ([IdOpcionPreguntaPorInstrumento],[IdRespuestaInstrumento],[Activo],[CreadoPor],[FechaCreacion],[Otro]) VALUES (" + nodoo.IdOp + ", " + CStr(Session("IdRespuestaPregunta")) + ",1, '" + Membership.GetUser.UserName + "', getDate(),'" + Otrobox.Text + "')"
                                        SqlRespuestasOpciones.Insert()
                                        SqlRespuestas.UpdateCommand = "UPDATE [RespuestasInstrumento] SET [RespuestaTexto]='" + Otrobox.Text + "',[ActualizadoPor]='" + Membership.GetUser.UserName + "', [FechaActualizacion]=getDate() WHERE  [IdRespuestaInstrumento] = " + CStr(Session("IdRespuestaPregunta")) + ""
                                        SqlRespuestas.Update()

                                    End If
                                    contadoropciones = contadoropciones + 1
                                Next

                            End If

                            contadorotros = contadorotros + 1


                        Else
                            'MsgBox("No encontro")
                        End If

                    End If

                    '----------------------------------------------------------------------------------------------------------------------------------


                    If (NC.TipoPregunta.Equals("4") Or NC.TipoPregunta.Equals("7")) Then

                        Dim myControl1 As Control = Panel.FindControl(NC.IDComponente)
                        If (Not myControl1 Is Nothing) Then
                            'Dim Mul As New RadioButtonList
                            'Mul = TryCast(Panel.FindControl(NC.IDComponente), RadioButtonList)

                            Dim Mul As New ASPxTextBox
                            Mul = TryCast(Panel.FindControl(NC.IDComponente), ASPxTextBox)

                            SqlRespuestas.InsertCommand = "INSERT INTO [RespuestasInstrumento] ([IdPreguntaPorInstrumento],[IdEncabezadoRespuesta],[Activo],[CreadoPor],[FechaCreacion]) VALUES (@IdPreguntaPorInstrumento, @IdEncabezadoRespuesta,1, @Usuario, getDate()) SELECT @IdRespuestaInstrumento = SCOPE_IDENTITY()"


                            SqlRespuestas.InsertParameters(0).DefaultValue = NC.IdPregunta
                            SqlRespuestas.InsertParameters(1).DefaultValue = CStr(Session("IdEncabezado"))
                            SqlRespuestas.InsertParameters(3).DefaultValue = Membership.GetUser.UserName
                            SqlRespuestas.InsertParameters(2).DefaultValue =
                            SqlRespuestas.Insert()



                            For s As Integer = 0 To NC.NumOpciones - 1
                                Dim nodoo As NodoOpcion = New NodoOpcion()
                                nodoo = ContenedorOpciones(contadoropciones)

                                If nodoo.Valor = Integer.Parse(Mul.Text) And nodoo.IdPreguntaM.Equals(NC.IdPregunta) Then
                                    'Es una respuesta seleccionada de esa pregunta, insertar opcion 

                                    SqlRespuestasOpciones.InsertCommand = "INSERT INTO [OpcionesRespuestaInstrumento] ([IdOpcionPreguntaPorInstrumento],[IdRespuestaInstrumento],[Activo],[CreadoPor],[FechaCreacion]) VALUES (" + nodoo.IdOp + ", " + CStr(Session("IdRespuestaPregunta")) + ",1, '" + Membership.GetUser.UserName + "', getDate())"
                                    SqlRespuestasOpciones.Insert()
                                    SqlRespuestas.UpdateCommand = "UPDATE [RespuestasInstrumento] SET [RespuestaTexto]='" + nodoo.Descripcion + "',[ActualizadoPor]='" + Membership.GetUser.UserName + "', [FechaActualizacion]=getDate() WHERE  [IdRespuestaInstrumento] = " + CStr(Session("IdRespuestaPregunta")) + ""
                                    SqlRespuestas.Update()


                                End If
                                contadoropciones = contadoropciones + 1
                            Next

                        Else
                            'MsgBox("No encontro")
                        End If

                    End If


                Next

                'MsgBox("Guardado con Éxito")

                Limpiar()

            End If



        End If


    End Sub


    Protected Sub SqlRespuestas_Inserted(sender As Object, e As SqlDataSourceStatusEventArgs)
        Dim command As DbCommand
        command = e.Command
        Session("IdRespuestaPregunta") = command.Parameters("@IdRespuestaInstrumento").Value
    End Sub


    Protected Sub Page_Load(sender As Object, e As EventArgs) Handles Me.Load
        'Verifica si el usuario tiene el acceso a la pagina solicitada
        Using dtMOCA As System.Data.DataTable = fMOCA.CheckPageAccess(2) 'este es el Id definido en el MOCA
            If dtMOCA.Rows.Count() > 0 Then
                If True Then 'dtMOCA.Rows.Item(0).Item("AllowAction02") Then
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

        Session("CodFSU") = uf.QueryStringDecode(Request.QueryString.Get(0))
        Session("CodDigitador") = uf.QueryStringDecode(Request.QueryString.Get(1))
        Session("IdAplicacion") = uf.QueryStringDecode(Request.QueryString.Get(2))

        Me.SqlAplicacion.SelectParameters(0).DefaultValue = Session("IdAplicacion")
        Me.SqlAplicacion.DataBind()
        Me.GridAplicacion.DataBind()

        Dim Componentes As ArrayList = New ArrayList()
        Dim Opciones As ArrayList = New ArrayList()

        '/////////////////////////////////////////////////////////////////////////////

        If GridAplicacion.VisibleRowCount = 1 Then

            Me.Panel.Controls.Add(New LiteralControl("<p>La Escala Likert es una escala que nos permite evaluar los criterios de la siguiente manera: </p>"))
            Me.Panel.Controls.Add(New LiteralControl("<p>0. Sin comentario</p>"))
            Me.Panel.Controls.Add(New LiteralControl("<p>1. Totalmente en desacuerdo</p>"))
            Me.Panel.Controls.Add(New LiteralControl("<p>2. En desacuerdo</p>"))
            Me.Panel.Controls.Add(New LiteralControl("<p>3. Ni de acuerdo ni en desacuerdo</p>"))
            Me.Panel.Controls.Add(New LiteralControl("<p>4. De acuerdo</p>"))
            Me.Panel.Controls.Add(New LiteralControl("<p>5. Totalmente de acuerdo</p>"))

            Session("IdInstrumentoDeEvaluacion") = GridAplicacion.GetRowValues(0, "IdInstrumentoDeEvaluacion")

            SqlPreguntas.SelectParameters(0).DefaultValue = Session("IdInstrumentoDeEvaluacion")
            SqlPreguntas.DataBind()
            Me.GridPreguntas.DataBind()

            '/////////////////////////////////////////////////////////////////////////////
            'CREANDO PREGUNTAS DEL INSTRUMENTO

            Dim bandera2 As Integer = 0
            Dim tipocategoria2 As Integer = 0

            Dim size As Integer = Me.GridPreguntas.VisibleRowCount

            If size > 0 Then
                tipocategoria2 = CInt(GridPreguntas.GetRowValues(0, "IdSeccionFSU"))
            End If

            For i As Integer = 0 To size - 1
                Dim IdPregunta As String = GridPreguntas.GetRowValues(i, "IdPreguntaPorInstrumento")
                Dim IdTipoPregunta As String = GridPreguntas.GetRowValues(i, "IdTipoDePregunta")
                Dim Descripcion As String = GridPreguntas.GetRowValues(i, "PreguntaDeInstrumento")
                Dim IdCategoria As String = GridPreguntas.GetRowValues(i, "IdSeccionFSU")
                Dim Categoria As String = GridPreguntas.GetRowValues(i, "NombreSeccion")
                Dim TipoRespuesta As Integer = GridPreguntas.GetRowValues(i, "IdTipoDeRespuesta")

                If tipocategoria2 = CInt(IdCategoria) And bandera2 = 0 Then

                    Me.Panel.Controls.Add(New LiteralControl("<h2>" + Categoria + " </h2>"))
                    Me.Panel.Controls.Add(New LiteralControl("<br>"))
                    bandera2 = 1
                Else
                    If tipocategoria2 <> CInt(IdCategoria) And bandera2 = 1 Then
                        Me.Panel.Controls.Add(New LiteralControl("<h2>" + Categoria + " </h2>"))
                        Me.Panel.Controls.Add(New LiteralControl("<br>"))
                        tipocategoria2 = CInt(IdCategoria)
                    End If
                End If



                If (IdTipoPregunta.Equals("1")) Then
                    'La pregunta es abierta creara un textbox
                    Dim Lbl As New ASPxLabel()
                    Lbl.Text = Descripcion
                    Lbl.ID = "Lbl" + CStr(contadorLabels)
                    Lbl.Visible = True
                    Lbl.AssociatedControlID = "txt" + CStr(contadorpabiertas)

                    If (TipoRespuesta = 4) Then
                        Dim tb As New ASPxDateEdit()
                        tb.ID = "txt" + CStr(contadorpabiertas)
                        tb.Visible = True
                        Me.Panel.Controls.Add(Lbl)
                        Me.Panel.Controls.Add(tb)

                        Dim nodocomponente As Nodo = New Nodo()
                        nodocomponente.IdPregunta = IdPregunta
                        nodocomponente.IDComponente = "txt" + CStr(contadorpabiertas)
                        nodocomponente.TipoPregunta = "1"
                        nodocomponente.NumOpciones = 0
                        nodocomponente.Requerida = GridPreguntas.GetRowValues(i, "Requerida")
                        nodocomponente.TipoRespuesta = TipoRespuesta

                        Componentes.Add(nodocomponente)

                    Else
                        Dim tb As New ASPxTextBox()
                        tb.Text = " "
                        tb.ID = "txt" + CStr(contadorpabiertas)
                        tb.Visible = True
                        tb.Width = 850%

                        Me.Panel.Controls.Add(Lbl)
                        Me.Panel.Controls.Add(tb)

                        Dim nodocomponente As Nodo = New Nodo()
                        nodocomponente.IdPregunta = IdPregunta
                        nodocomponente.IDComponente = "txt" + CStr(contadorpabiertas)
                        nodocomponente.TipoPregunta = "1"
                        nodocomponente.NumOpciones = 0
                        nodocomponente.Requerida = GridPreguntas.GetRowValues(i, "Requerida")
                        nodocomponente.TipoRespuesta = TipoRespuesta
                        Componentes.Add(nodocomponente)

                    End If

                    contadorLabels = contadorLabels + 1
                    contadorpabiertas = contadorpabiertas + 1
                    Me.Panel.Controls.Add(New LiteralControl("<br>"))

                End If
                If (IdTipoPregunta.Equals("2")) Then
                    'Es Linker
                    Dim Lbl As New ASPxLabel()
                    Lbl.Text = Descripcion
                    Lbl.ID = "Lbl" + CStr(contadorLabels)
                    Lbl.Visible = True
                    Lbl.AssociatedControlID = "Linker" + CStr(contadorplinker)
                    Me.Panel.Controls.Add(Lbl)


                    Dim Linker As New RadioButtonList()
                    Linker.ID = "Linker" + CStr(contadorplinker)
                    Linker.Visible = True

                    Linker.Items.Add("0")
                    Linker.Items.Add("1")
                    Linker.Items.Add("2")
                    Linker.Items.Add("3")
                    Linker.Items.Add("4")
                    Linker.Items.Add("5")

                    Linker.RepeatDirection = RepeatDirection.Horizontal


                    Me.Panel.Controls.Add(Linker)

                    Dim nodocomponente As Nodo = New Nodo()
                    nodocomponente.IdPregunta = IdPregunta
                    nodocomponente.IDComponente = "Linker" + CStr(contadorplinker)
                    nodocomponente.TipoPregunta = "2"
                    nodocomponente.NumOpciones = 0
                    nodocomponente.Requerida = GridPreguntas.GetRowValues(i, "Requerida")




                    Componentes.Add(nodocomponente)



                    contadorLabels = contadorLabels + 1
                    contadorplinker = contadorplinker + 1
                    Me.Panel.Controls.Add(New LiteralControl("<br>"))

                End If

                '---------------------------------------------------------------------------------------------------------------
                If (IdTipoPregunta.Equals("5")) Then
                    'Opcion Multiple
                    SqlOpcionesPreguntas.SelectParameters(0).DefaultValue = IdPregunta
                    SqlOpcionesPreguntas.DataBind()
                    GridOpciones.DataBind()
                    'creando Label
                    Dim Lbl As New ASPxLabel()
                    Lbl.Text = Descripcion
                    Lbl.ID = "Lbl" + CStr(contadorLabels)
                    Lbl.Visible = True
                    Lbl.AssociatedControlID = "OMul" + CStr(contadorom)
                    Me.Panel.Controls.Add(Lbl)
                    'creando Checkbox
                    Dim OMul As New CheckBoxList()
                    OMul.ID = "OMul" + CStr(contadorom)
                    OMul.Visible = True
                    Dim size2 As Integer = Me.GridOpciones.VisibleRowCount
                    For j As Integer = 0 To size2 - 1

                        Dim nodoo As NodoOpcion = New NodoOpcion()
                        nodoo.Descripcion = GridOpciones.GetRowValues(j, "Opcion")
                        nodoo.IdPreguntaM = IdPregunta
                        nodoo.IdOp = GridOpciones.GetRowValues(j, "IdOpcionPreguntaPorInstrumento")
                        nodoo.Valor = GridOpciones.GetRowValues(j, "Valor")

                        If (nodoo.Descripcion.Equals("Otro")) Then

                            Me.Panel.Controls.Add(OMul)

                            Dim Op As New ASPxTextBox()
                            Op.Text = " "
                            Op.ID = "Otro" + CStr(contadorotros)
                            Op.Visible = True

                            Me.Panel.Controls.Add(New LiteralControl("<p>" + nodoo.Valor.ToString + "." + nodoo.Descripcion + "</p>"))
                            Me.Panel.Controls.Add(Op)
                            Me.Panel.Controls.Add(New LiteralControl("</br>"))
                            contadorotros = contadorotros + 1

                        Else
                            Dim Opcion As String = GridOpciones.GetRowValues(j, "Opcion")
                            OMul.Items.Add(Opcion)
                        End If

                        Opciones.Add(nodoo)

                    Next



                    Dim nodocomponente As Nodo = New Nodo()
                    nodocomponente.IdPregunta = IdPregunta
                    nodocomponente.IDComponente = OMul.ID
                    nodocomponente.TipoPregunta = "5"
                    nodocomponente.NumOpciones = size2
                    nodocomponente.Requerida = GridPreguntas.GetRowValues(i, "Requerida")
                    Componentes.Add(nodocomponente)


                    contadorLabels = contadorLabels + 1
                    contadorom = contadorom + 1
                    Me.Panel.Controls.Add(New LiteralControl("<br>"))

                End If

                '---------------------------------------------------------------------------------------------------------------


                If (IdTipoPregunta.Equals("3")) Then
                    'Opcion Multiple
                    SqlOpcionesPreguntas.SelectParameters(0).DefaultValue = IdPregunta
                    SqlOpcionesPreguntas.DataBind()
                    GridOpciones.DataBind()
                    'creando Label
                    Dim Lbl As New ASPxLabel()
                    Lbl.Text = Descripcion
                    Lbl.ID = "Lbl" + CStr(contadorLabels)
                    Lbl.Visible = True
                    Lbl.AssociatedControlID = "OMul" + CStr(contadorom)
                    Me.Panel.Controls.Add(Lbl)
                    'creando Checkbox
                    Dim OMul As New CheckBoxList()
                    OMul.ID = "OMul" + CStr(contadorom)
                    OMul.Visible = True
                    Dim size2 As Integer = Me.GridOpciones.VisibleRowCount
                    For j As Integer = 0 To size2 - 1

                        Dim nodoo As NodoOpcion = New NodoOpcion()
                        nodoo.Descripcion = GridOpciones.GetRowValues(j, "Opcion")
                        nodoo.IdPreguntaM = IdPregunta
                        nodoo.IdOp = GridOpciones.GetRowValues(j, "IdOpcionPreguntaPorInstrumento")
                        nodoo.Valor = GridOpciones.GetRowValues(j, "Valor")

                        Dim Opcion As String = GridOpciones.GetRowValues(j, "Opcion")
                        OMul.Items.Add(Opcion)
                        Opciones.Add(nodoo)

                    Next

                    Me.Panel.Controls.Add(OMul)

                    Dim nodocomponente As Nodo = New Nodo()
                    nodocomponente.IdPregunta = IdPregunta
                    nodocomponente.IDComponente = OMul.ID
                    nodocomponente.TipoPregunta = "3"
                    nodocomponente.NumOpciones = size2
                    nodocomponente.Requerida = GridPreguntas.GetRowValues(i, "Requerida")
                    Componentes.Add(nodocomponente)


                    contadorLabels = contadorLabels + 1
                    contadorom = contadorom + 1
                    Me.Panel.Controls.Add(New LiteralControl("<br>"))

                End If

                '---------------------------------------------------------------------------------------------------------------

                If (IdTipoPregunta.Equals("6")) Then
                    'Opcion Unica
                    SqlOpcionesPreguntas.SelectParameters(0).DefaultValue = IdPregunta
                    SqlOpcionesPreguntas.DataBind()
                    GridOpciones.DataBind()

                    Dim Lbl As New ASPxLabel()
                    Lbl.Text = Descripcion
                    Lbl.ID = "Lbl" + CStr(contadorLabels)
                    Lbl.Visible = True
                    Lbl.AssociatedControlID = "OUnica" + CStr(contadorou)
                    Me.Panel.Controls.Add(Lbl)

                    Dim size2 As Integer = Me.GridOpciones.VisibleRowCount


                    Dim OUnica As New ASPxTextBox()
                    OUnica.Text = " "
                    OUnica.ID = "OUnica" + CStr(contadorou)
                    OUnica.Visible = True
                    For j As Integer = 0 To size2 - 1

                        Dim nodoo As NodoOpcion = New NodoOpcion()
                        nodoo.Descripcion = GridOpciones.GetRowValues(j, "Opcion")
                        nodoo.IdPreguntaM = GridOpciones.GetRowValues(j, "IdPreguntaPorInstrumento")
                        nodoo.IdOp = GridOpciones.GetRowValues(j, "IdOpcionPreguntaPorInstrumento")
                        nodoo.Valor = GridOpciones.GetRowValues(j, "Valor")

                        If (nodoo.Descripcion.Equals("Otro")) Then
                            Dim Op As New ASPxTextBox()
                            Op.Text = " "
                            Op.ID = "Otro" + CStr(contadorotros)
                            Op.Visible = True

                            Me.Panel.Controls.Add(New LiteralControl("<p>" + nodoo.Valor.ToString + "." + nodoo.Descripcion + "</p>"))
                            Me.Panel.Controls.Add(Op)
                            Me.Panel.Controls.Add(New LiteralControl("</br>"))
                            contadorotros = contadorotros + 1

                        Else
                            Me.Panel.Controls.Add(New LiteralControl("<p>" + nodoo.Valor.ToString + "." + nodoo.Descripcion + "</p>"))
                        End If

                       
                        Opciones.Add(nodoo)
                    Next

                    Me.Panel.Controls.Add(OUnica)


                    Dim nodocomponente As Nodo = New Nodo()
                    nodocomponente.IdPregunta = IdPregunta
                    nodocomponente.IDComponente = "OUnica" + CStr(contadorou)
                    nodocomponente.TipoPregunta = "6"
                    nodocomponente.NumOpciones = size2
                    nodocomponente.Requerida = GridPreguntas.GetRowValues(i, "Requerida")

                    Componentes.Add(nodocomponente)

                    contadorLabels = contadorLabels + 1
                    contadorou = contadorou + 1
                    Me.Panel.Controls.Add(New LiteralControl("<br>"))

                End If

                '---------------------------------------------------------------------------------------------------------------

                If (IdTipoPregunta.Equals("4") Or IdTipoPregunta.Equals("7")) Then
                    'Opcion Unica


                    SqlOpcionesPreguntas.SelectParameters(0).DefaultValue = IdPregunta
                    SqlOpcionesPreguntas.DataBind()
                    GridOpciones.DataBind()

                    Dim Lbl As New ASPxLabel()
                    Lbl.Text = Descripcion
                    Lbl.ID = "Lbl" + CStr(contadorLabels)
                    Lbl.Visible = True
                    Lbl.AssociatedControlID = "OUnica" + CStr(contadorou)
                    Me.Panel.Controls.Add(Lbl)

                    Dim size2 As Integer = Me.GridOpciones.VisibleRowCount


                    Dim OUnica As New ASPxTextBox()
                    OUnica.Text = " "
                    OUnica.ID = "OUnica" + CStr(contadorou)
                    OUnica.Visible = True
                    'OUnica.Width = 850%

                    'Dim OUnica As New RadioButtonList()
                    'OUnica.ID = "OUnica" + CStr(contadorou)
                    'OUnica.Visible = True

                    For j As Integer = 0 To size2 - 1

                        Dim nodoo As NodoOpcion = New NodoOpcion()
                        nodoo.Descripcion = GridOpciones.GetRowValues(j, "Opcion")
                        nodoo.IdPreguntaM = GridOpciones.GetRowValues(j, "IdPreguntaPorInstrumento")
                        nodoo.IdOp = GridOpciones.GetRowValues(j, "IdOpcionPreguntaPorInstrumento")
                        nodoo.Valor = GridOpciones.GetRowValues(j, "Valor")

                        Me.Panel.Controls.Add(New LiteralControl("<p>" + nodoo.Valor.ToString + "." + nodoo.Descripcion + "</p>"))
                        'OUnica.Items.Add(nodoo.Descripcion)
                        Opciones.Add(nodoo)
                    Next

                    Me.Panel.Controls.Add(OUnica)


                    Dim nodocomponente As Nodo = New Nodo()
                    nodocomponente.IdPregunta = IdPregunta
                    nodocomponente.IDComponente = "OUnica" + CStr(contadorou)
                    nodocomponente.TipoPregunta = "4"
                    nodocomponente.NumOpciones = size2
                    nodocomponente.Requerida = GridPreguntas.GetRowValues(i, "Requerida")

                    Componentes.Add(nodocomponente)

                    contadorLabels = contadorLabels + 1
                    contadorou = contadorou + 1
                    Me.Panel.Controls.Add(New LiteralControl("<br>"))

                End If


            Next

            totalotros = contadorotros

        Else

            Me.Panel.Controls.Add(New LiteralControl("<h1> Código de digitación incorrecto verifique </h1>"))

        End If

        Session("CRespuestas") = Componentes
        Session("COpciones") = Opciones


    End Sub



    Protected Sub SqlDataSourceEncabezado_Inserted(sender As Object, e As SqlDataSourceStatusEventArgs)

        Dim command As DbCommand
        command = e.Command
        Session("IdEncabezado") = command.Parameters("@IdEncabezadoRespuesta").Value

    End Sub
End Class
