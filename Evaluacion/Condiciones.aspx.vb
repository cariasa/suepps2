
Imports System.Windows.Forms

Partial Class Evaluacion_Condiciones
    Inherits System.Web.UI.Page

    Protected Sub Page_Init(sender As Object, e As EventArgs) Handles Me.Init
        
    End Sub

    Protected Sub Page_Load(sender As Object, e As EventArgs) Handles Me.Load

        Session("IdVariable") = CInt(Request.QueryString("Variable"))

        ASPxLabelVariable.Text = "Definir Condición de Acumulación de Variable " + Request.QueryString("Nombre")

    End Sub

End Class
