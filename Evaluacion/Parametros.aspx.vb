Imports Microsoft.VisualBasic
Imports System
Imports System.Web.UI
Imports DevExpress.Web.ASPxEditors
Imports DevExpress.Web.ASPxTabControl
Imports DevExpress.Web.ASPxGridView
Imports System.Collections
Imports System.Web
Imports System.Web.Security
Imports System.Data.SqlClient
Imports System.Windows.Forms

Partial Class Evaluacion_Parametros
    Inherits System.Web.UI.Page

    Dim idIndicador As Integer
    Dim indicador As String
    Dim idVariableNumerador As Integer
    Dim variableNumerador As String
    Dim idvariableDenominador As Integer
    Dim variableDenominador As String

    Protected Sub sendValoresMacro(ByVal sender As Object, ByVal e As EventArgs)

        Dim index As Integer = ASPxGridViewDefinicionVariables.FocusedRowIndex

        Dim variable As String = ASPxGridViewDefinicionVariables.GetRowValues(index, "IdVariable").ToString


        Dim SqlConn As New SqlConnection
        SqlConn.ConnectionString = SqlDataSourceFormulas.ConnectionString
        Dim Command As New SqlCommand("SELECT NombreVariable FROM Variables WHERE IdVariable = " + variable, SqlConn)
        SqlConn.Open()

        Dim reader As SqlDataReader = Command.ExecuteReader()

        If (reader.Read) Then
            Response.Redirect("ValoresMacro.aspx?Variable=" + uf.QueryStringEncode(variable) + "&Nombre=" + uf.QueryStringEncode(Convert.ToString(reader("NombreVariable"))))
        Else
            Response.Redirect("ValoresMacro.aspx?Variable=" + uf.QueryStringEncode(variable) + "&Nombre=" + uf.QueryStringEncode("0"))
        End If
        reader.Close()
        SqlConn.Close()



    End Sub

    Protected Sub linkCondiciones_Click(sender As Object, e As EventArgs)
        Dim index As Integer = ASPxGridViewDefinicionVariables.FocusedRowIndex

        Dim variable As String = ASPxGridViewDefinicionVariables.GetRowValues(index, "IdVariable").ToString

        Dim SqlConn As New SqlConnection
        SqlConn.ConnectionString = SqlDataSourceFormulas.ConnectionString
        Dim Command As New SqlCommand("SELECT NombreVariable FROM Variables WHERE IdVariable = " + variable, SqlConn)
        SqlConn.Open()

        Dim reader As SqlDataReader = Command.ExecuteReader()

        If (reader.Read) Then
            Response.Redirect("Condiciones.aspx?Variable=" + uf.QueryStringEncode(variable) + "&Nombre=" + uf.QueryStringEncode(Convert.ToString(reader("NombreVariable"))))
        Else
            Response.Redirect("Condiciones.aspx?Variable=" + uf.QueryStringEncode(variable) + "&Nombre=" + uf.QueryStringEncode("0"))
        End If
        reader.Close()
        SqlConn.Close()

    End Sub

    'Formulas*****************************************************************************************************************

    Protected Sub linkElegir_Click(sender As Object, e As EventArgs)
        indicador = ASPxGridViewIndicadores.GetRowValues(ASPxGridViewIndicadores.FocusedRowIndex, "DescripcionIndicador")
        Session("idIndicador") = ASPxGridViewIndicadores.GetRowValues(ASPxGridViewIndicadores.FocusedRowIndex, "IdIndicador")

        ASPxTextBoxIndicador.Text = indicador
        ASPxTextBoxIndicador.DataBind()

    End Sub


    Protected Sub linkElegirVariable_Click(sender As Object, e As EventArgs)


        If ASPxComboBoxPosicion.SelectedItem.Value = 0 Then
            variableNumerador = ASPxGridViewVariables.GetRowValues(ASPxGridViewVariables.FocusedRowIndex, "NombreVariable")
            Session("idVariableNumerador") = ASPxGridViewVariables.GetRowValues(ASPxGridViewVariables.FocusedRowIndex, "IdVariable")
            ASPxTextBoxNumerador.Text = variableNumerador
            ASPxTextBoxNumerador.DataBind()

        Else
            variableDenominador = ASPxGridViewVariables.GetRowValues(ASPxGridViewVariables.FocusedRowIndex, "NombreVariable")
            Session("idvariableDenominador") = ASPxGridViewVariables.GetRowValues(ASPxGridViewVariables.FocusedRowIndex, "IdVariable")
            ASPxTextBoxDenominador.Text = variableDenominador
            ASPxTextBoxDenominador.DataBind()
        End If

    End Sub

    Protected Sub ASPxButtonGuardar_Click(sender As Object, e As EventArgs)
        Dim usuario As String
        usuario = "'SUEPPS'"
        Dim unum As Integer
        Dim uden As Integer

        If ASPxCheckBoxUsarVMacroN.Checked Then
            unum = 1
        Else
            unum = 0
        End If

        If ASPxCheckBoxUsarVMacroD.Checked Then
            uden = 1
        Else
            uden = 0
        End If

        SqlDataSourceFormulas.InsertCommand = "INSERT INTO [FormulaIndicador] (IdIndicador, IdVariableNumerador, IdVariableDenominador, UsaVariableMacroNumerador, UsaVariableMacroDenominador, Factor, DescripcionFormula, CreadoPor, FechaCreacion) VALUES (" + Session("idIndicador").ToString + "," + Session("idVariableNumerador").ToString + "," + Session("idvariableDenominador").ToString + "," + unum.ToString + "," + uden.ToString + "," + ASPxTextBoxFactor.Text + ",'" + ASPxTextBoxDes.Text + "'," + usuario + ",getDate())"
        'Revisar si IdVariableDenominador tiene una condición Q o C en la tabla de variables (O sea que no sea Total)
        'Si el denominador no es un contador de la muestra, su condición debe ser heredada al numerador, esto es mediante COPIA de esas condiciones
        'En condiciones nuevas
        'Para lograr esto se CREA una condición más de tipo C con operador AND que pegue con la raíz del denominador, y con la
        'raíz del denominador, y este nuevo nodo deberá convertirse en la raíz del numerador
        SqlDataSourceFormulas.Insert()
        ASPxGridViewFormulas.DataBind()

        ASPxTextBoxIndicador.Text = ""
        ASPxTextBoxNumerador.Text = ""
        ASPxTextBoxDenominador.Text = ""
        ASPxTextBoxFactor.Text = ""
        ASPxTextBoxDes.Text = ""
    End Sub

    Protected Sub linkEditarFormula_Click(sender As Object, e As EventArgs)
        ASPxButtonGuardar.Visible = False
        ASPxButtonGuardarEditar.Visible = True

        Session("idIndicador") = ASPxGridViewFormulas.GetRowValues(ASPxGridViewFormulas.FocusedRowIndex, "IdIndicador")
        Session("idVariableNumerador") = ASPxGridViewFormulas.GetRowValues(ASPxGridViewFormulas.FocusedRowIndex, "IdVariableNumerador")
        Session("idVariableDenominador") = ASPxGridViewFormulas.GetRowValues(ASPxGridViewFormulas.FocusedRowIndex, "IdVariableDenominador")

        Dim SqlConn As New SqlConnection
        SqlConn.ConnectionString = SqlDataSourceIndicadoresCombo.ConnectionString
        Dim Command As New SqlCommand("SELECT DescripcionIndicador FROM Indicadores WHERE IdIndicador = " + Session("idIndicador").ToString, SqlConn)
        SqlConn.Open()

        Dim reader As SqlDataReader = Command.ExecuteReader()
        If (reader.Read) Then
            ASPxTextBoxIndicador.Text = Convert.ToString(reader("DescripcionIndicador"))
        Else
            ASPxTextBoxIndicador.Text = ""
        End If
        reader.Close()


        Dim commandNum As New SqlCommand("SELECT NombreVariable FROM [Variables] WHERE IdVariable = " + Session("idVariableNumerador").ToString, SqlConn)
        reader = commandNum.ExecuteReader()
        If (reader.Read) Then
            ASPxTextBoxNumerador.Text = Convert.ToString(reader("NombreVariable"))
        Else
            ASPxTextBoxNumerador.Text = ""
        End If
        reader.Close()

        Dim commandDen As New SqlCommand("SELECT NombreVariable FROM [Variables] WHERE IdVariable = " + Session("idVariableDenominador").ToString, SqlConn)
        reader = commandDen.ExecuteReader()
        If (reader.Read) Then
            ASPxTextBoxDenominador.Text = Convert.ToString(reader("NombreVariable"))
        Else
            ASPxTextBoxDenominador.Text = ""
        End If
        reader.Close()

        SqlConn.Close()

        ASPxTextBoxFactor.Text = ASPxGridViewFormulas.GetRowValues(ASPxGridViewFormulas.FocusedRowIndex, "Factor")
        ASPxTextBoxDes.Text = ASPxGridViewFormulas.GetRowValues(ASPxGridViewFormulas.FocusedRowIndex, "DescripcionFormula")

        If (ASPxGridViewFormulas.GetRowValues(ASPxGridViewFormulas.FocusedRowIndex, "UsaVariableMacroNumerador") = 1) Then
            ASPxCheckBoxUsarVMacroN.Checked() = True
        Else
            ASPxCheckBoxUsarVMacroN.Checked() = False
        End If

        If (ASPxGridViewFormulas.GetRowValues(ASPxGridViewFormulas.FocusedRowIndex, "UsaVariableMacroDenominador") = 1) Then
            ASPxCheckBoxUsarVMacroD.Checked() = True
        Else
            ASPxCheckBoxUsarVMacroD.Checked() = False
        End If

    End Sub

    Protected Sub linkEliminarFormula_Click(sender As Object, e As EventArgs)
        SqlDataSourceFormulas.DeleteCommand = "UPDATE [FormulaIndicador] SET [Activo]=0 WHERE idFormulaIndicador=" + ASPxGridViewFormulas.GetRowValues(ASPxGridViewFormulas.FocusedRowIndex, "IdFormulaIndicador").ToString
        SqlDataSourceFormulas.Delete()
        ASPxGridViewFormulas.DataBind()
    End Sub

    Protected Sub ASPxButtonGuardarEditar_Click(sender As Object, e As EventArgs)
        Dim usuario As String
        usuario = "'SUEPPS'"
        Dim unum As Integer
        Dim uden As Integer

        If ASPxCheckBoxUsarVMacroN.Checked Then
            unum = 1
        Else
            unum = 0
        End If

        If ASPxCheckBoxUsarVMacroD.Checked Then
            uden = 1
        Else
            uden = 0
        End If

        SqlDataSourceFormulas.UpdateCommand = "UPDATE [FormulaIndicador] SET IdIndicador=" + Session("idIndicador").ToString + ", IdVariableNumerador=" + Session("idVariableNumerador").ToString + ", IdVariableDenominador=" + Session("idvariableDenominador").ToString + ", UsaVariableMacroNumerador=" + unum.ToString + ", UsaVariableMacroDenominador=" + uden.ToString + ", Factor=" + ASPxTextBoxFactor.Text + ", DescripcionFormula='" + ASPxTextBoxDes.Text + "', CreadoPor=" + usuario + ", FechaCreacion=getDate() WHERE idFormulaIndicador=" + ASPxGridViewFormulas.GetRowValues(ASPxGridViewFormulas.FocusedRowIndex, "IdFormulaIndicador").ToString
        SqlDataSourceFormulas.Update()
        ASPxGridViewFormulas.DataBind()

        ASPxButtonGuardar.Visible = True
        ASPxButtonGuardarEditar.Visible = False

        ASPxTextBoxIndicador.Text = ""
        ASPxTextBoxNumerador.Text = ""
        ASPxTextBoxDenominador.Text = ""
        ASPxTextBoxFactor.Text = ""
        ASPxTextBoxDes.Text = ""

    End Sub

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
        End Using
    End Sub

    Protected Sub SqlDataSourceSUEPPS_Inserted(sender As Object, e As SqlDataSourceStatusEventArgs)
        ASPxGridViewVariables.DataBind()
    End Sub

    Protected Sub SqlDataSourceSUEPPS_Updated(sender As Object, e As SqlDataSourceStatusEventArgs)
        ASPxGridViewVariables.DataBind()
    End Sub

    Protected Sub SqlDataSourceSUEPPS_Deleted(sender As Object, e As SqlDataSourceStatusEventArgs)
        ASPxGridViewVariables.DataBind()
    End Sub
End Class
