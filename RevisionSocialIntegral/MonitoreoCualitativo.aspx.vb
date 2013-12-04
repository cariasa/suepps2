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

    Public Structure Nodo
        Public IdPregunta As String
        Public IDComponente As String
        Public TipoPregunta As String
        Public EsGeneral As String
    End Structure

    Public Structure NodoOpcion
        Public IdOp As String
        Public Descripcion As String
        Public IdPreguntaM As String
    End Structure


    '..............................................................................................................................
    '///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

    Protected Sub ASPxButton1_Click(sender As Object, e As EventArgs)



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
                    Dim box1 As ASPxTextBox
                    box1 = TryCast(Panel.FindControl(NC.IDComponente), ASPxTextBox)

                    Dim Resp As String = box1.Text
                    Dim IdM As String = CStr(Session("IdMonitoreo"))


                    SqlRespuestas.InsertParameters(0).DefaultValue = IdM
                    SqlRespuestas.InsertParameters(1).DefaultValue = NC.IdPregunta
                    SqlRespuestas.InsertParameters(2).DefaultValue = Resp
                    SqlRespuestas.InsertParameters(3).DefaultValue = " "
                    SqlRespuestas.InsertParameters(5).DefaultValue = Membership.GetUser.UserName

                    SqlRespuestas.Insert()

                Else
                    'MsgBox("No encontro")
                End If

            End If

            If NC.TipoPregunta.Equals("2") Then

                Dim myControl1 As Control = Panel.FindControl(NC.IDComponente)
                If (Not myControl1 Is Nothing) Then
                    Dim Mul As New RadioButtonList
                    Mul = TryCast(Panel.FindControl(NC.IDComponente), RadioButtonList)


                    SqlRespuestas.InsertParameters(0).DefaultValue = CStr(Session("IdMonitoreo"))
                    SqlRespuestas.InsertParameters(1).DefaultValue = NC.IdPregunta
                    SqlRespuestas.InsertParameters(2).DefaultValue = " "
                    SqlRespuestas.InsertParameters(3).DefaultValue = Mul.SelectedValue
                    SqlRespuestas.InsertParameters(5).DefaultValue = Membership.GetUser.UserName
                    SqlRespuestas.Insert()

                Else

                End If

            End If

            If NC.TipoPregunta.Equals("3") Then


                Dim myControl1 As Control = Panel.FindControl(NC.IDComponente)

                If (Not myControl1 Is Nothing) Then


                    Dim Mul As New CheckBoxList()
                    Mul = TryCast(Panel.FindControl(NC.IDComponente), CheckBoxList)


                    SqlRespuestas.InsertParameters(0).DefaultValue = CStr(Session("IdMonitoreo"))
                    SqlRespuestas.InsertParameters(1).DefaultValue = NC.IdPregunta
                    SqlRespuestas.InsertParameters(2).DefaultValue = " "
                    SqlRespuestas.InsertParameters(3).DefaultValue = " "
                    SqlRespuestas.InsertParameters(5).DefaultValue = Membership.GetUser.UserName

                    SqlRespuestas.Insert()


                    If Mul.Items.Count > 1 Then
                        For s As Integer = 0 To Mul.Items.Count - 1
                            If Mul.Items(s).Selected = True Then


                                Dim nodoo As NodoOpcion = New NodoOpcion()
                                nodoo = ContenedorOpciones(contadoropciones)

                                If nodoo.Descripcion.Equals(Mul.Items(s).Text) And nodoo.IdPreguntaM.Equals(NC.IdPregunta) Then

                                    SqlRespuestasOpciones.InsertCommand = "INSERT INTO [OpcionesDeRespuesta] ([IdOpcionDePregunta],[IdRespuestaDeMonitoreoCualitativo],[Activo],[CreadoPor],[FechaCreacion]) VALUES (" + nodoo.IdOp + ", " + CStr(Session("IdRespuestaPregunta")) + ",1, '" + Membership.GetUser.UserName + "', getDate())"
                                    SqlRespuestasOpciones.Insert()



                                End If
                            End If
                            contadoropciones = contadoropciones + 1
                        Next
                    End If
                Else

                End If


            End If

            If NC.TipoPregunta.Equals("4") Then

                Dim myControl1 As Control = Panel.FindControl(NC.IDComponente)
                If (Not myControl1 Is Nothing) Then
                    Dim Mul As New RadioButtonList
                    Mul = TryCast(Panel.FindControl(NC.IDComponente), RadioButtonList)

                    SqlRespuestas.InsertParameters(0).DefaultValue = CStr(Session("IdMonitoreo"))
                    SqlRespuestas.InsertParameters(1).DefaultValue = NC.IdPregunta
                    SqlRespuestas.InsertParameters(2).DefaultValue = " "
                    SqlRespuestas.InsertParameters(3).DefaultValue = " "
                    SqlRespuestas.InsertParameters(5).DefaultValue = Membership.GetUser.UserName
                    SqlRespuestas.Insert()

                    For s As Integer = 0 To Mul.Items.Count - 1
                        Dim nodoo As NodoOpcion = New NodoOpcion()
                        nodoo = ContenedorOpciones(contadoropciones)

                        If nodoo.Descripcion.Equals(Mul.Text) And nodoo.IdPreguntaM.Equals(NC.IdPregunta) Then
                            'Es una respuesta seleccionada de esa pregunta, insertar opcion 
                            SqlRespuestasOpciones.InsertCommand = "INSERT INTO [OpcionesDeRespuesta] ([IdOpcionDePregunta],[IdRespuestaDeMonitoreoCualitativo],[Activo],[CreadoPor],[FechaCreacion]) VALUES (" + nodoo.IdOp + ", " + CStr(Session("IdRespuestaPregunta")) + ",1, '" + Membership.GetUser.UserName + "', getDate())"
                            SqlRespuestasOpciones.Insert()



                        End If
                        contadoropciones = contadoropciones + 1
                    Next

                Else
                    'MsgBox("No encontro")
                End If

            End If


        Next

        'MsgBox("Guardado con Exito")



        '    End If


        'End If

    End Sub


    Protected Sub callback_Callback(source As Object, e As CallbackEventArgs)
        If cmbAno.Text.Equals("") Then
            'MsgBox("Seleccione El año")
        Else

            Me.SqlMonitoreoCualitavivo.InsertParameters(0).DefaultValue = CodPrograma.Text
            Me.SqlMonitoreoCualitavivo.InsertParameters(1).DefaultValue = cmbAno.Text
            Me.SqlMonitoreoCualitavivo.InsertParameters(2).DefaultValue = cmbTrimestre.Text
            Me.SqlMonitoreoCualitavivo.InsertParameters(3).DefaultValue = Membership.GetUser.UserName
            Me.SqlMonitoreoCualitavivo.Insert()

            SqlMoniEncuesta.SelectParameters(0).DefaultValue = CodPrograma.Text
            SqlMoniEncuesta.SelectParameters(1).DefaultValue = Membership.GetUser.UserName
            SqlMoniEncuesta.DataBind()
            Me.ASPxGridView2.DataBind()

        End If
    End Sub

    Protected Sub SqladdIndicador_Inserted(sender As Object, e As SqlDataSourceStatusEventArgs)
        Dim command As DbCommand
        command = e.Command
        Session("IdMonitoreo") = command.Parameters("@IdMonitoreoCualitativo").Value

    End Sub

    Protected Sub SqlRespuestas_Inserted(sender As Object, e As SqlDataSourceStatusEventArgs)
        Dim command As DbCommand
        command = e.Command
        Session("IdRespuestaPregunta") = command.Parameters("@IdRespuestaDeMonitoreCualitativo").Value
    End Sub

    Protected Sub Page_Init(sender As Object, e As EventArgs) Handles Me.Init
        cmbTrimestre.Items.Add("1", 1)
        cmbTrimestre.Items.Add("2", 2)
        cmbTrimestre.Items.Add("3", 3)
        cmbTrimestre.Items.Add("4", 4)

        Dim Componentes As ArrayList = New ArrayList()
        Dim Opciones As ArrayList = New ArrayList()

        Me.Programa.Text = uf.QueryStringDecode(Request.QueryString.Get(0))
        Me.CodPrograma.Text = uf.QueryStringDecode(Request.QueryString.Get(1))



        '/////////////////////////////////////////////////////////////////////////////
        SqlMoniEncuesta.SelectParameters(0).DefaultValue = CodPrograma.Text
        SqlMoniEncuesta.SelectParameters(1).DefaultValue = Membership.GetUser.UserName
        SqlMoniEncuesta.DataBind()
        Me.ASPxGridView2.DataBind()

        '/////////////////////////////////////////////////////////////////////////////

        SqlAnoPrograma.SelectParameters(0).DefaultValue = Me.CodPrograma.Text
        '/////////////////////////////////////////////////////////////////////////////

        SqlPreguntas.SelectParameters(0).DefaultValue = Me.CodPrograma.Text

        SqlPreguntas.DataBind()

        Me.GridPreguntas.DataBind()

        '/////////////////////////////////////////////////////////////////////////////

        SqlPreguntasGenerales.DataBind()

        Me.GridPreguntasGenerales.DataBind()

        '/////////////////////////////////////////////////////////////////////////////

        SqlTipoActor.SelectParameters(0).DefaultValue = Membership.GetUser.UserName
        SqlTipoActor.SelectParameters(1).DefaultValue = Me.CodPrograma.Text
        SqlTipoActor.DataBind()
        Me.ASPxGridView1.DataBind()

        Dim IdTipoActores As String = ""

        If ASPxGridView1.VisibleRowCount = 1 Then
            'se filtran las preguntas actuales deacuerdo al actor
            IdTipoActores = ASPxGridView1.GetRowValues(0, "IdTipoDeActor")
        End If

        SqlPreguntasActor.SelectParameters(0).DefaultValue = Me.CodPrograma.Text
        SqlPreguntasActor.SelectParameters(1).DefaultValue = IdTipoActores
        SqlPreguntasActor.DataBind()
        Me.GridPreguntasActor.DataBind()

        '/////////////////////////////////////////////////////////////////////////////

        '/////////////////////////////////////////////////////////////////////////////
        'CREANDO PREGUNTAS GENERALES
        Dim bandera As Integer = 0
        Dim tipocategoria As Integer = 0


        Dim sizeg As Integer = Me.GridPreguntasGenerales.VisibleRowCount()

        If sizeg > 0 Then
            tipocategoria = CInt(GridPreguntasGenerales.GetRowValues(0, "IdCategoriaDePregunta"))
        End If


        For i As Integer = 0 To sizeg - 1



            Dim IdPregunta As String = GridPreguntasGenerales.GetRowValues(i, "IdPreguntaDeMonitoreo")
            Dim IdTipoPregunta As String = GridPreguntasGenerales.GetRowValues(i, "IdTipoDePregunta")
            Dim Descripcion As String = GridPreguntasGenerales.GetRowValues(i, "DescripcionPreguntaDeMonitoreo")
            Dim EsGeneral As String = GridPreguntasGenerales.GetRowValues(i, "EsGeneral")
            Dim IdCategoria As String = GridPreguntasGenerales.GetRowValues(i, "IdCategoriaDePregunta")
            Dim Categoria As String = GridPreguntasGenerales.GetRowValues(i, "DescripcionCategoriaDePregunta")




            If tipocategoria = CInt(IdCategoria) And bandera = 0 Then

                Me.Panel.Controls.Add(New LiteralControl("<h2>" + Categoria + " </h2>"))
                Me.Panel.Controls.Add(New LiteralControl("<br>"))
                bandera = 1
            Else
                If tipocategoria <> CInt(IdCategoria) And bandera = 1 Then



                    Me.Panel.Controls.Add(New LiteralControl("<h2>" + Categoria + " </h2>"))
                    Me.Panel.Controls.Add(New LiteralControl("<br>"))
                    tipocategoria = CInt(IdCategoria)
                End If

            End If




            If (IdTipoPregunta.Equals("1")) Then
                'La pregunta es abierta creara un textbox
                Dim Lbl As New ASPxLabel()
                Lbl.Text = Descripcion
                Lbl.ID = "Lbl" + CStr(contadorLabels)
                Lbl.Visible = True
                Lbl.AssociatedControlID = "txt" + CStr(contadorpabiertas)

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
                nodocomponente.EsGeneral = "1"

                Componentes.Add(nodocomponente)


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
                nodocomponente.EsGeneral = "1"

                Componentes.Add(nodocomponente)



                contadorLabels = contadorLabels + 1
                contadorplinker = contadorplinker + 1
                Me.Panel.Controls.Add(New LiteralControl("<br>"))

            End If

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
                    nodoo.Descripcion = GridOpciones.GetRowValues(j, "DescripcionOpcionDePregunta")
                    nodoo.IdPreguntaM = IdPregunta
                    nodoo.IdOp = GridOpciones.GetRowValues(j, "IdOpcionDePregunta")

                    Dim Opcion As String = GridOpciones.GetRowValues(j, "DescripcionOpcionDePregunta")
                    OMul.Items.Add(Opcion)
                    Opciones.Add(nodoo)

                Next

                Me.Panel.Controls.Add(OMul)

                Dim nodocomponente As Nodo = New Nodo()
                nodocomponente.IdPregunta = IdPregunta
                nodocomponente.IDComponente = OMul.ID
                nodocomponente.TipoPregunta = "3"
                nodocomponente.EsGeneral = "1"

                Componentes.Add(nodocomponente)


                contadorLabels = contadorLabels + 1
                contadorom = contadorom + 1
                Me.Panel.Controls.Add(New LiteralControl("<br>"))

            End If

            If (IdTipoPregunta.Equals("4")) Then
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

                Dim OUnica As New RadioButtonList()
                OUnica.ID = "OUnica" + CStr(contadorou)
                OUnica.Visible = True

                For j As Integer = 0 To size2 - 1

                    Dim nodoo As NodoOpcion = New NodoOpcion()
                    nodoo.Descripcion = GridOpciones.GetRowValues(j, "DescripcionOpcionDePregunta")
                    nodoo.IdPreguntaM = GridOpciones.GetRowValues(j, "IdPreguntaDeMonitoreo")
                    nodoo.IdOp = GridOpciones.GetRowValues(j, "IdOpcionDePregunta")

                    Dim Opcion As String = GridOpciones.GetRowValues(j, "DescripcionOpcionDePregunta")
                    OUnica.Items.Add(Opcion)
                    Opciones.Add(nodoo)
                Next

                Me.Panel.Controls.Add(OUnica)


                Dim nodocomponente As Nodo = New Nodo()
                nodocomponente.IdPregunta = IdPregunta
                nodocomponente.IDComponente = "OUnica" + CStr(contadorou)
                nodocomponente.TipoPregunta = "4"
                nodocomponente.EsGeneral = "1"

                Componentes.Add(nodocomponente)

                contadorLabels = contadorLabels + 1
                contadorou = contadorou + 1
                Me.Panel.Controls.Add(New LiteralControl("<br>"))


            End If

        Next

        '/////////////////////////////////////////////////////////////////////////////
        'CREANDO PREGUNTAS DEL PROGRAMA

        Dim bandera2 As Integer = 0
        Dim tipocategoria2 As Integer = 0

        Dim size As Integer = Me.GridPreguntas.VisibleRowCount

        If size > 0 Then
            tipocategoria2 = CInt(GridPreguntas.GetRowValues(0, "IdCategoriaDePregunta"))
        End If

        For i As Integer = 0 To size - 1
            Dim IdPregunta As String = GridPreguntas.GetRowValues(i, "IdPreguntaDeMonitoreo")
            Dim IdTipoPregunta As String = GridPreguntas.GetRowValues(i, "IdTipoDePregunta")
            Dim Descripcion As String = GridPreguntas.GetRowValues(i, "DescripcionPreguntaDeMonitoreo")
            Dim IdCategoria As String = GridPreguntas.GetRowValues(i, "IdCategoriaDePregunta")
            Dim Categoria As String = GridPreguntas.GetRowValues(i, "DescripcionCategoriaDePregunta")

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

                Componentes.Add(nodocomponente)


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

                Componentes.Add(nodocomponente)



                contadorLabels = contadorLabels + 1
                contadorplinker = contadorplinker + 1
                Me.Panel.Controls.Add(New LiteralControl("<br>"))

            End If

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
                    nodoo.Descripcion = GridOpciones.GetRowValues(j, "DescripcionOpcionDePregunta")
                    nodoo.IdPreguntaM = IdPregunta
                    nodoo.IdOp = GridOpciones.GetRowValues(j, "IdOpcionDePregunta")

                    Dim Opcion As String = GridOpciones.GetRowValues(j, "DescripcionOpcionDePregunta")
                    OMul.Items.Add(Opcion)
                    Opciones.Add(nodoo)

                Next

                Me.Panel.Controls.Add(OMul)

                Dim nodocomponente As Nodo = New Nodo()
                nodocomponente.IdPregunta = IdPregunta
                nodocomponente.IDComponente = OMul.ID
                nodocomponente.TipoPregunta = "3"

                Componentes.Add(nodocomponente)


                contadorLabels = contadorLabels + 1
                contadorom = contadorom + 1
                Me.Panel.Controls.Add(New LiteralControl("<br>"))

            End If

            If (IdTipoPregunta.Equals("4")) Then
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

                Dim OUnica As New RadioButtonList()
                OUnica.ID = "OUnica" + CStr(contadorou)
                OUnica.Visible = True

                For j As Integer = 0 To size2 - 1

                    Dim nodoo As NodoOpcion = New NodoOpcion()
                    nodoo.Descripcion = GridOpciones.GetRowValues(j, "DescripcionOpcionDePregunta")
                    nodoo.IdPreguntaM = GridOpciones.GetRowValues(j, "IdPreguntaDeMonitoreo")
                    nodoo.IdOp = GridOpciones.GetRowValues(j, "IdOpcionDePregunta")

                    Dim Opcion As String = GridOpciones.GetRowValues(j, "DescripcionOpcionDePregunta")
                    OUnica.Items.Add(Opcion)
                    Opciones.Add(nodoo)
                Next

                Me.Panel.Controls.Add(OUnica)


                Dim nodocomponente As Nodo = New Nodo()
                nodocomponente.IdPregunta = IdPregunta
                nodocomponente.IDComponente = "OUnica" + CStr(contadorou)
                nodocomponente.TipoPregunta = "4"

                Componentes.Add(nodocomponente)

                contadorLabels = contadorLabels + 1
                contadorou = contadorou + 1
                Me.Panel.Controls.Add(New LiteralControl("<br>"))

            End If


        Next

        '/////////////////////////////////////////////////////////////////////////////
        'CREANDO PREGUNTAS SEGUN EL ACTOR DEL MOCA

        Dim bandera3 As Integer = 0
        Dim tipocategoria3 As Integer = 0

        Dim size3 As Integer = Me.GridPreguntasActor.VisibleRowCount

        If size3 > 0 Then
            tipocategoria3 = CInt(GridPreguntasActor.GetRowValues(0, "IdCategoriaDePregunta"))
        End If

        For i As Integer = 0 To size3 - 1
            Dim IdPregunta As String = GridPreguntasActor.GetRowValues(i, "IdPreguntaDeMonitoreo")
            Dim IdTipoPregunta As String = GridPreguntasActor.GetRowValues(i, "IdTipoDePregunta")
            Dim Descripcion As String = GridPreguntasActor.GetRowValues(i, "DescripcionPreguntaDeMonitoreo")
            Dim IdCategoria As String = GridPreguntasActor.GetRowValues(i, "IdCategoriaDePregunta")
            Dim Categoria As String = GridPreguntasActor.GetRowValues(i, "DescripcionCategoriaDePregunta")

            If tipocategoria3 = CInt(IdCategoria) And bandera3 = 0 Then

                Me.Panel.Controls.Add(New LiteralControl("<h2>" + Categoria + " </h2>"))
                Me.Panel.Controls.Add(New LiteralControl("<br>"))
                bandera3 = 1
            Else
                If tipocategoria3 <> CInt(IdCategoria) And bandera3 = 1 Then
                   Me.Panel.Controls.Add(New LiteralControl("<h2>" + Categoria + " </h2>"))
                    Me.Panel.Controls.Add(New LiteralControl("<br>"))
                    tipocategoria3 = CInt(IdCategoria)
                End If
            End If


            If (IdTipoPregunta.Equals("1")) Then
                'La pregunta es abierta creara un textbox
                Dim Lbl As New ASPxLabel()
                Lbl.Text = Descripcion
                Lbl.ID = "Lbl" + CStr(contadorLabels)
                Lbl.Visible = True
                Lbl.AssociatedControlID = "txt" + CStr(contadorpabiertas)

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

                Componentes.Add(nodocomponente)


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

                Componentes.Add(nodocomponente)



                contadorLabels = contadorLabels + 1
                contadorplinker = contadorplinker + 1
                Me.Panel.Controls.Add(New LiteralControl("<br>"))

            End If

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
                    nodoo.Descripcion = GridOpciones.GetRowValues(j, "DescripcionOpcionDePregunta")
                    nodoo.IdPreguntaM = IdPregunta
                    nodoo.IdOp = GridOpciones.GetRowValues(j, "IdOpcionDePregunta")

                    Dim Opcion As String = GridOpciones.GetRowValues(j, "DescripcionOpcionDePregunta")
                    OMul.Items.Add(Opcion)
                    Opciones.Add(nodoo)

                Next

                Me.Panel.Controls.Add(OMul)

                Dim nodocomponente As Nodo = New Nodo()
                nodocomponente.IdPregunta = IdPregunta
                nodocomponente.IDComponente = OMul.ID
                nodocomponente.TipoPregunta = "3"

                Componentes.Add(nodocomponente)


                contadorLabels = contadorLabels + 1
                contadorom = contadorom + 1
                Me.Panel.Controls.Add(New LiteralControl("<br>"))

            End If

            If (IdTipoPregunta.Equals("4")) Then
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

                Dim OUnica As New RadioButtonList()
                OUnica.ID = "OUnica" + CStr(contadorou)
                OUnica.Visible = True

                For j As Integer = 0 To size2 - 1

                    Dim nodoo As NodoOpcion = New NodoOpcion()
                    nodoo.Descripcion = GridOpciones.GetRowValues(j, "DescripcionOpcionDePregunta")
                    nodoo.IdPreguntaM = GridOpciones.GetRowValues(j, "IdPreguntaDeMonitoreo")
                    nodoo.IdOp = GridOpciones.GetRowValues(j, "IdOpcionDePregunta")

                    Dim Opcion As String = GridOpciones.GetRowValues(j, "DescripcionOpcionDePregunta")
                    OUnica.Items.Add(Opcion)
                    Opciones.Add(nodoo)
                Next

                Me.Panel.Controls.Add(OUnica)


                Dim nodocomponente As Nodo = New Nodo()
                nodocomponente.IdPregunta = IdPregunta
                nodocomponente.IDComponente = "OUnica" + CStr(contadorou)
                nodocomponente.TipoPregunta = "4"

                Componentes.Add(nodocomponente)

                contadorLabels = contadorLabels + 1
                contadorou = contadorou + 1
                Me.Panel.Controls.Add(New LiteralControl("<br>"))


            End If


        Next

        Session("CRespuestas") = Componentes
        Session("COpciones") = Opciones

    End Sub

    Protected Sub Page_Load(sender As Object, e As EventArgs) Handles Me.Load
        'Verifica si el usuario tiene el acceso a la pagina solicitada
        Using dtMOCA As System.Data.DataTable = fMOCA.CheckPageAccess(2.01) 'este es el Id definido en el MOCA
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
    End Sub



End Class
