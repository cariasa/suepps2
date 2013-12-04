
Partial Class Evaluacion_Plantillas
    Inherits System.Web.UI.Page
    Protected Sub Page_Load(sender As Object, e As EventArgs) Handles Me.Load
        'Verifica si el usuario tiene el acceso a la pagina solicitada
        Using dtMOCA As System.Data.DataTable = fMOCA.CheckPageAccess(5.01)
            If dtMOCA.Rows.Count() > 0 Then
                'Activa o Inactiva los objetos,(sean botones, grid, hiperlinks, etc),  
                'en la pagina que se indique deacuerdo al parametro indicado
                'ASPxButton1.Visible = dtMOCA.Rows.Item(0).Item("AllowAdd")

                'Los siguientes datos pueden ser cambiados por los nombres de Objetos a los que corresponde la acción que se desea realizar, 
                'si no hay necesidad de utilizar esta sección silo la eliminan dejandola en blanco y solo evaluando el acceso a la pagina
                'ASPxButton2.Visible = dtMOCA.Rows.Item(0).Item("AllowUpdate")
                'ASPxButton3.Visible = dtMOCA.Rows.Item(0).Item("AllowDelete")
                'ASPxButton4.Visible = dtMOCA.Rows.Item(0).Item("AllowAction01")
                'Object5.Visible = dtMOCA.Rows.Item(0).Item("AllowAction02")
                'Object6.Visible = dtMOCA.Rows.Item(0).Item("AllowAction03")
                'Object7.Visible = dtMOCA.Rows.Item(0).Item("AllowAction04")
                'Object8.Visible = dtMOCA.Rows.Item(0).Item("AllowAction05")
                'Object9.Visible = dtMOCA.Rows.Item(0).Item("AllowAction06")
                'Object10.Visible = dtMOCA.Rows.Item(0).Item("AllowAction07")

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
End Class
