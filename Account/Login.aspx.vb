
Partial Class Account_Login
    Inherits System.Web.UI.Page

    'Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
    '    RegisterHyperLink.NavigateUrl = "Register.aspx?ReturnUrl=" + HttpUtility.UrlEncode(Request.QueryString("ReturnUrl"))
    'End Sub
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        'Create membership user
        '
        'Dim user As MembershipUser = Nothing
        'Dim users As MembershipUserCollection = Membership.FindUsersByName("suepps")
        'If users.Count > 0 Then
        '    user = users("suepps")
        'Else
        '    user = Membership.CreateUser("suepps", "suepps", "suepps@desarrollosocial.gob.hn")
        'End If
        'If Not Roles.RoleExists("suepps") Then
        '    Roles.CreateRole("suepps")
        '    Roles.AddUserToRole("suepps", "suepps")
        'End If

        If Not IsPostBack Then
            Try
                If Request.QueryString("d") <> Nothing Then
                    If Request.QueryString("d") <= 0 Then
                        lblMsg.Visible = True
                        lblMsg.Text = "Su contraseña ha caducado y ha sido desactivada. Consulte a la mesa de ayuda"
                        'LoginUser.FailureText = "Su contraseña ha caducado y ha sido desactivada. Consulte a la mesa de ayuda"
                    Else
                        lblMsg.Visible = True
                        lblMsg.Text = "Su contraseña esta por caducar en " + Request.QueryString("d").ToString() + _
                                      " días, debe de cambiarla o será bloqueada. </ br>" + _
                                      "<a href='ChangePassword.aspx'>Para Cambiar la contraseña de un clic aquí</a>"
                        LoginUser.Visible = False
                        'LoginUser.FailureText = "Su contraseña esta por caducar en " + Request.QueryString("d").ToString() + _
                        '               " días, debe de cambiarla o será bloqueada"
                    End If
                End If
            Catch ex As Exception
                'LoginUser.FailureText = Nothing 
                lblMsg.Visible = False
                lblMsg.Text = Nothing
            End Try
        Else
            lblMsg.Visible = False
            Me.lblMsg.Text = Nothing
            'LoginUser.FailureText = Nothing 
        End If
    End Sub

    Protected Sub LoginUser_LoggedIn(sender As Object, e As System.EventArgs) Handles LoginUser.LoggedIn
        Dim UserName As String = DirectCast(sender, System.Web.UI.WebControls.Login).UserName
        Dim user As MembershipUser = Membership.GetUser(UserName)
        If user.IsOnline Then
            Dim DiasVigenciaPass As Integer = ConfigurationManager.AppSettings.Get("DiasVigenciaPass")
            Dim DiasAvisoVigenciaPass As Integer = ConfigurationManager.AppSettings.Get("DiasAvisoVigenciaPass")
            Dim FechaVencimientoPass As Date = user.LastPasswordChangedDate.AddDays(DiasVigenciaPass)
            Dim DiasFaltantes As Integer = (FechaVencimientoPass - Now()).TotalDays

            If DiasAvisoVigenciaPass > DiasFaltantes Then
                If DiasFaltantes <= 0 Then
                    user.IsApproved = False
                    Membership.UpdateUser(user)
                    Session.Abandon()
                    FormsAuthentication.SignOut()
                    Roles.DeleteCookie()
                    Session.Clear()
                    'FormsAuthentication.RedirectToLoginPage()
                    Response.Redirect("Login.aspx?d=" + DiasFaltantes.ToString)
                Else
                    Response.Redirect("Login.aspx?d=" + DiasFaltantes.ToString)
                End If
            Else
                'Response.Redirect("Default.aspx")
            End If
        Else
            Response.Redirect("Login.aspx")
        End If
    End Sub

End Class