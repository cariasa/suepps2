<%@ Page Title="Acceso Denegado" Language="VB" MasterPageFile="~/Site.master" AutoEventWireup="false" CodeFile="NoAccess.aspx.vb" Inherits="NoAccess" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" Runat="Server">
    <table align="center" width="700px">
        <tr>
            <td>
                &nbsp;</td>
            <td>
                &nbsp;&nbsp;</td>
        </tr>
        <tr>
            <td valign="top">
                <br />
                <asp:Image ID="Image1" runat="server" ImageUrl="~/Imagenes/seguridad.jpg" />
            </td>
            <td valign="top">
                <h1 style="color: #FF0000">
                    Usted no Tiene Acceso a la opción solicitada.
                </h1>
                <hr />
                Si el acceso le ha sido brindado, intentelo nuevamente. Si este mensaje persiste favor comuniquese con el Administrador del Sistema.
            </td>
        </tr>
    </table>
</asp:Content>

