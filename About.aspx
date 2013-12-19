<%@ Page Title="Acerca de SUEPPS" Language="VB" MasterPageFile="~/Site.Master" AutoEventWireup="false"
    CodeFile="About.aspx.vb" Inherits="About" %>

<asp:Content ID="HeaderContent" runat="server" ContentPlaceHolderID="HeadContent">
</asp:Content>
<asp:Content ID="BodyContent" runat="server" ContentPlaceHolderID="MainContent">
    <h2>
        Acerca del Sistema Único de Evaluación de Políticas Públicas Sociales
        (SUEPPS)
    </h2>
    
        <table style="width:100%;">
            <tr>
                <td>
                <br />
                    <asp:Image ID="Image2" runat="server" 
                        ImageUrl="~/Imagenes/suepps-logo.png" />
                </td>
                <td>
                    &nbsp;</td>
                <td align="justify" valign="top">
                    Producto hondureño desarrollado cien por ciento por hondureños.

                </td>
            </tr>
            <tr>
                <td>
                    </td>
                <td>
                    &nbsp;</td>
                <td>
                    &nbsp;</td>
            </tr>
        </table>
    <div>
    <table>
        <tr>
            <td>Instituciones Colaboradoras</td>
        </tr>
        <tr>
            <td>
                <asp:Image ID="Image3" runat="server" 
                        ImageUrl="~/Imagenes/logounitec.jpg" />
            </td>
        </tr>
        <tr>
            <td>
<asp:Image ID="Image1" runat="server" 
                        ImageUrl="~/Imagenes/bancomundial.jpg" />
            </td>
        </tr>
    </table>

    </div>
    
</asp:Content>