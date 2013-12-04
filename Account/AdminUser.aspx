<%@ Page Title="Admin User" Language="VB" MasterPageFile="~/Site.master" AutoEventWireup="false" CodeFile="AdminUser.aspx.vb" Inherits="Account_AdminUser" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" Runat="Server">
    <table class="cTable">
        <tr>
            <td>
                <h2>Opciones del Usuario</h2>
            </td>
        </tr>
        <tr>
            <td>
                <asp:LinkButton ID="lbGenerales" runat="server" Enabled="False">Generales</asp:LinkButton>
&nbsp;|
                <asp:LinkButton ID="lbPass" runat="server">Contraseña</asp:LinkButton>
&nbsp;|
                <asp:LinkButton ID="lbSQ" runat="server">Pregunta Secreta</asp:LinkButton>
                <hr />
            </td>
        </tr>
        <tr>
            <td>
                                        <asp:Label ID="lblMsg" runat="server" 
                    CssClass="failureNotification"></asp:Label>
                <asp:MultiView ID="mvUserOptions" runat="server" ActiveViewIndex="0">
                    <asp:View ID="vUserGenerals" runat="server">
                        <table>
                                <tr>
                                    <td >
                                        Descripción
                                    </td>
                                    <td >
                                        <asp:TextBox ID="txtComment" runat="server" Columns="50" Rows="5" TextMode="MultiLine"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td >
                                        Correo Electronico
                                    </td>
                                    <td >
                                        <asp:TextBox ID="txtEMail" runat="server" Columns="40"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td >
                                        Fecha Creación
                                    </td>
                                    <td >
                                        <asp:Label ID="lblCreatedDate" runat="server"></asp:Label>
                                    </td>
                                </tr>
                                <tr>
                                    <td >
                                        Aprobado
                                    </td>
                                    <td >
                                        <asp:Label ID="lblIsApproved" runat="server"></asp:Label>
                                    </td>
                                </tr>
                                <tr>
                                    <td >
                                        Bloqueado
                                    </td>
                                    <td >
                                        <asp:Label ID="lblIsLockedOut" runat="server"></asp:Label>
                                    </td>
                                </tr>
                                <tr>
                                    <td >
                                        Fecha de Bloqueo
                                    </td>
                                    <td >
                                        <asp:Label ID="lblLasLockOutDate" runat="server"></asp:Label>
                                    </td>
                                </tr>
                                <tr>
                                    <td >
                                        Ultimo Ingreso
                                    </td>
                                    <td >
                                        <asp:Label ID="lblLastLogInDate" runat="server"></asp:Label>
                                    </td>
                                </tr>
                                <tr>
                                    <td >
                                        Ultimo Cambio de Contraseña
                                    </td>
                                    <td >
                                        <asp:Label ID="txtUltimoCambioPass" runat="server"></asp:Label>
                                    </td>
                                </tr>
                                <tr>
                                    <td >
                                    </td>
                                    <td >
                                        <asp:Button ID="btnSaveInfo" runat="server" Text="Guardar Cambios"></asp:Button>
                                    </td>
                                </tr>
                            </table>
                    </asp:View>
                    <asp:View ID="vUserPass" runat="server">
                        <table>
                                <tr>
                                    <td>
                                        Cambio de Contraseña
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        &nbsp;</td>
                                </tr>
                                <tr>
                                    <td>
                                        Contraseña Actual<asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server"
                                            ControlToValidate="txtOldPass" Display="Dynamic" ErrorMessage="*" SetFocusOnError="True"
                                            ValidationGroup="RP"></asp:RequiredFieldValidator>
                                    </td>
                                    <td>
                                        <asp:TextBox ID="txtOldPass" runat="server" Columns="30" TextMode="Password"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        Nueva Contraseña<asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server"
                                            ControlToValidate="txtPassword1" Display="Dynamic" ErrorMessage="*" SetFocusOnError="True"
                                            ValidationGroup="RP"></asp:RequiredFieldValidator>
                                    </td>
                                    <td>
                                        <asp:TextBox ID="txtPassword1" runat="server" TextMode="Password" ValidationGroup="RP"
                                            Columns="30"></asp:TextBox>
                                        <asp:LinkButton ID="lbGeneratePassword" runat="server" CausesValidation="False">Generar Contraseña</asp:LinkButton>
                                        &nbsp;<asp:Label ID="lblNewPassword" runat="server"></asp:Label>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        Confirmar Nueva Contraseña<asp:RequiredFieldValidator ID="RequiredFieldValidator2"
                                            runat="server" ControlToValidate="txtPassword2" Display="Dynamic" ErrorMessage="*"
                                            SetFocusOnError="True" ValidationGroup="RP"></asp:RequiredFieldValidator>
                                    </td>
                                    <td>
                                        <asp:TextBox ID="txtPassword2" runat="server" Columns="30" TextMode="Password" ValidationGroup="RP"></asp:TextBox>
                                        <asp:CompareValidator ID="CompareValidator1" runat="server" ControlToCompare="txtPassword2"
                                            ControlToValidate="txtPassword1" Display="Dynamic" ErrorMessage="Contraseña NO Coinciden"
                                            SetFocusOnError="True" ValidationGroup="RP"></asp:CompareValidator>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                    </td>
                                    <td>
                                        <asp:Button ID="btnResetPassword" runat="server" Text="Cambiar Contraseña" ValidationGroup="RP">
                                        </asp:Button>
                                    </td>
                                </tr>
                            </table>
                    </asp:View>
                    <asp:View ID="vUserSQ" runat="server">
                        <table>
                                <tr>
                                    <td>
                                        Cambio de Pregunta Secreta
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        Contraseña Actual
                                    </td>
                                    <td>
                                        <asp:TextBox ID="txtPassword" runat="server" TextMode="Password"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        Pregunta Secreta
                                    </td>
                                    <td>
                                        <asp:TextBox ID="txtPasswordQuestion" runat="server" Columns="60"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        Respuesta
                                    </td>
                                    <td>
                                        <asp:TextBox ID="txtPasswordAnswer" runat="server" Columns="60"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                    </td>
                                    <td>
                                        <asp:Button ID="btnResetPQ" runat="server" Text="Cambiar Pregunta/Respuesta" />
                                    </td>
                                </tr>
                            </table>
                    </asp:View>
                </asp:MultiView>
            </td>
        </tr>
    </table>
</asp:Content>

