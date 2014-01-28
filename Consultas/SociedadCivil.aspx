<%@ Page Title="Consultas de Sociedad Civil" Language="VB" AutoEventWireup="false" CodeFile="SociedadCivil.aspx.vb" Inherits="Consultas_SociedadCivil" MasterPageFile="~/Site.master"%>


<%@ Register Src="~/MOCA_UE.ascx" TagPrefix="uc1" TagName="MOCA_UE" %>
<asp:Content ID="cHeader" ContentPlaceHolderID="HeadContent" Runat="Server">
</asp:Content>
<asp:Content ID="cBody" ContentPlaceHolderID="MainContent" Runat="Server">
    <uc1:MOCA_UE runat="server" ID="MOCA_UE01" />

    <div>
    <table>
        <tr>
            <td>
                <asp:Image ImageUrl="~/Imagenes/enconstruccion.jpg" runat="server" /> 

            </td>
        </tr>
        <tr>
            <td>
                Página en Construcción, discúlpenos por el inconveniente.
            </td>
        </tr>
    </table>
    </div>

</asp:Content>