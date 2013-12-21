﻿
Imports System.Windows.Forms

Partial Class Evaluacion_Condiciones
    Inherits System.Web.UI.Page

    Protected Sub Page_Init(sender As Object, e As EventArgs) Handles Me.Init
        SqlDataSourceCondiciones.InsertCommand = "INSERT INTO [Condiciones] (IdVariable, IdTipoCondicion, NombreCondicion, DescripcionCondicion, Raiz, Total, Operando1, Operador,  Operando2, CreadoPor, FechaCreacion) VALUES (@IdVariable, @IdTipoCondicion, @NombreCondicion, @DescripcionCondicion, @Raiz, @Total, @Operando1, @Operador,  @Operando2, '" + Request.QueryString("Variable") + "', getDate())"
        SqlDataSourceCondiciones.UpdateCommand = "UPDATE [Condiciones] SET [IdTipoCondicion]=@IdTipoCondicion, NombreCondicion=@NombreCondicion, DescripcionCondicion=@DescripcionCondicion, Raiz=@Raiz, Total=@Total, Operando1=@Operando1, Operador=@Operador, Operando2=@Operando2, ActualizadoPor='" + Request.QueryString("Variable") + "', FechaActualizacion=getDate() WHERE IdCondicion=@IdCondicion"
        SqlDataSourceCondiciones.DeleteCommand = "UPDATE [Condiciones] SET [ActualizadoPor]='" + Membership.GetUser.UserName.ToString + "', [FechaActualizacion]=getDate(), [Activo]=0 WHERE IdCondicion=@IdCondicion"
    End Sub

    Protected Sub Page_Load(sender As Object, e As EventArgs) Handles Me.Load

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


        Session("IdVariable") = CInt(Request.QueryString("Variable"))

        ASPxLabelVariable.Text = "Definir Condición de Acumulación de Variable " + Request.QueryString("Nombre")

    End Sub

End Class
