Imports System.Data

Partial Class MOCA_MenuControl
    Inherits System.Web.UI.UserControl
    '
    'Protected Sub Page_PreInit(ByVal sender As Object, ByVal e As EventArgs)
    '    'Dim index As Integer = 0
    '    'Integer.TryParse(Request.Form("ASPxRadioButtonList1"), index)
    '    'ASPxGridView1.SkinID = Convert.ToString(ASPxRadioButtonList1.Items(index).Value)
    '    mMainMenu.SkinID = "Office2010Black"
    'End Sub

    Protected Sub Page_Load(sender As Object, e As System.EventArgs) Handles Me.Load
        Dim ws As New MOCA.SecurityCredentialsSoapClient
        Dim dt As DataTable

        Dim vMenuItemParent As New DevExpress.Web.ASPxMenu.MenuItem
        Dim vMenuItemChild As New DevExpress.Web.ASPxMenu.MenuItem

        If My.User.IsAuthenticated Then
            dt = ws.BuildMenu(My.User.Name, ConfigurationManager.AppSettings.Item("AppTOKEN"))
            Dim iMenuItemIndexParent As Integer = 0
            Dim iMenuItemIndexChild As Integer = 0
            For i = 0 To dt.Rows.Count() - 1
                If dt.Rows.Item(i).Item("RoleOptionType") = 0 Then
                    iMenuItemIndexParent += 1
                    iMenuItemIndexChild = 0
                    vMenuItemParent = New DevExpress.Web.ASPxMenu.MenuItem
                    vMenuItemParent.Text = dt.Rows.Item(i).Item("RoleOptionName").ToString
                    vMenuItemParent.ToolTip = dt.Rows.Item(i).Item("ToolTip").ToString
                    vMenuItemParent.Enabled = dt.Rows.Item(i).Item("Selectable")
                    vMenuItemParent.NavigateUrl = dt.Rows.Item(i).Item("NavigateUrl")
                    mMainMenu.Items.Insert(iMenuItemIndexParent, vMenuItemParent)
                Else
                    vMenuItemChild = New DevExpress.Web.ASPxMenu.MenuItem
                    If dt.Rows.Item(i).Item("Enabled") = True Then
                        vMenuItemChild.Text = dt.Rows.Item(i).Item("RoleOptionName").ToString
                        vMenuItemChild.ToolTip = dt.Rows.Item(i).Item("ToolTip").ToString
                        vMenuItemChild.Enabled = dt.Rows.Item(i).Item("Selectable")
                        vMenuItemChild.NavigateUrl = dt.Rows.Item(i).Item("NavigateUrl")
                        mMainMenu.Items(iMenuItemIndexParent).Items.Insert(iMenuItemIndexChild, vMenuItemChild)
                        iMenuItemIndexChild += 1
                    End If
                End If
            Next
        End If
        mMainMenu.Items.Add("Acerca de...", "Acerca_de", "", "~/About.aspx")
    End Sub
End Class
