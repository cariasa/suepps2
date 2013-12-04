
Partial Class Account_AdminUser
    Inherits System.Web.UI.Page

        Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not IsPostBack Then
            Call LoadUserInfo(My.User.Name.TrimEnd(" ").ToLower)
        End If
    End Sub

    Protected Sub LoadUserInfo(ByVal UserId As String)
        Dim user As MembershipUser = Membership.GetUser(UserId)
        Me.txtComment.Text = user.Comment
        Me.txtEMail.Text = user.Email.ToString
        Me.lblCreatedDate.Text = user.CreationDate.ToString
        Me.lblIsApproved.text = IIf(user.IsApproved, "Sí", "No")
        If user.IsLockedOut Then
            Me.lblIsLockedOut.Text = "Sí"
            'Me.lbUnLock.Visible = True
            Me.lblLasLockOutDate.Text = user.LastLockoutDate
        Else
            Me.lblIsLockedOut.Text = "No"
            'Me.lbUnLock.Visible = False
            Me.lblLasLockOutDate.Text = ""
        End If
        Me.lblLastLogInDate.Text = user.LastLoginDate
        Me.txtUltimoCambioPass.Text = user.LastPasswordChangedDate
        Try
            Me.txtPasswordQuestion.Text = user.PasswordQuestion
        Catch ex As Exception
            Me.txtPasswordQuestion.Text = Nothing
        End Try
    End Sub

    Protected Sub btnSaveInfo_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnSaveInfo.Click
        Try
            Dim user As MembershipUser = Membership.GetUser(My.User.Name.TrimEnd(" ").ToLower)
            user.Comment = Me.txtComment.Text
            user.Email = Me.txtEMail.Text.ToString
            Membership.UpdateUser(user)
            Me.lblMsg.Text = "Datos Generales Actualizados"
        Catch ex As Exception
            Me.lblMsg.Text = "A ocurrido un error al intentar actualizar la información"
        End Try
    End Sub

    'Protected Sub lbUnLock_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles lbUnLock.Click
    '    Try
    '        Dim user As MembershipUser = Membership.GetUser(My.User.Name.TrimEnd(" ").ToLower)
    '        If user.UnlockUser() Then
    '            Me.lblMsg.Text = "Usuario Desbloqueado"
    '        Else
    '            Me.lblMsg.Text = "No se ha podido desbloquear el usuario"
    '        End If
    '    Catch ex As Exception
    '        Me.lblMsg.Text = "Ha Ocurrido un error grave al intentar desbloquear el usuario"
    '    End Try
    'End Sub

    Protected Sub lbGeneratePassword_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles lbGeneratePassword.Click
        Dim NewPassword As String
        NewPassword = System.Web.Security.Membership.GeneratePassword(11, 2)
        Me.lblNewPassword.Text = NewPassword
        Me.txtPassword1.Text = NewPassword
        Me.txtPassword2.Text = NewPassword
    End Sub

    Protected Sub btnResetPassword_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnResetPassword.Click
        Try
            Dim user As MembershipUser = Membership.GetUser(My.User.Name.TrimEnd(" ").ToLower)
            Dim oldpswd As String = Me.txtOldPass.Text
            Dim newpass As String = Me.txtPassword2.Text
            If user.ChangePassword(oldpswd, newpass) Then
                Me.lblMsg.Text = "Contraseña se cambio correctamente"
            Else
                Me.lblMsg.Text = "No se ha podido cambiar la contraseña"
            End If
        Catch ex As Exception
            Me.lblMsg.Text = "Ha ocurrido un Error al intentar cambiar la contraseña"
        End Try
    End Sub

    Protected Sub btnResetPQ_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnResetPQ.Click
        Try
            Dim user As MembershipUser = Membership.GetUser(My.User.Name.TrimEnd(" ").ToLower)
            If user.ChangePasswordQuestionAndAnswer(Me.txtPassword.Text, Me.txtPasswordQuestion.Text, Me.txtPasswordAnswer.Text) Then
                Me.lblMsg.Text = "Pregunta y Respuesta Secreta Cambiada Satisfactoriamente"
            Else
                Me.lblMsg.Text = "Ha Ocurrido un Error. Contraseña incorrecta o el usuario esta inactivo o bloqueado"
            End If
        Catch ex As Exception
            Me.lblMsg.Text = "Ha ocurrido un error al intentar actualizar la pregunta secreta y respuesta"
        End Try
    End Sub

    Protected Sub lbGenerales_Click(sender As Object, e As System.EventArgs) Handles lbGenerales.Click
        mvUserOptions.ActiveViewIndex=0
        lbGenerales.Enabled=False 
        lbPass.Enabled =True 
        lbSQ.Enabled=True 
    End Sub

    Protected Sub lbPass_Click(sender As Object, e As System.EventArgs) Handles lbPass.Click
        mvUserOptions.ActiveViewIndex=1
        lbGenerales.Enabled=True  
        lbPass.Enabled =False 
        lbSQ.Enabled=True 
    End Sub

    Protected Sub lbSQ_Click(sender As Object, e As System.EventArgs) Handles lbSQ.Click
        mvUserOptions.ActiveViewIndex=2
        lbGenerales.Enabled=True  
        lbPass.Enabled =true 
        lbSQ.Enabled=false
    End Sub
End Class
