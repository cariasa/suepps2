<%@ Page Language="VB" AutoEventWireup="false" CodeFile="Encuesta.aspx.vb" Inherits="Cuantitativo_Encuesta" MasterPageFile="~/Site.master" %>

<%@ Register Src="~/MOCA_UE.ascx" TagPrefix="uc1" TagName="MOCA_UE" %>

<asp:Content ID="cHeader" ContentPlaceHolderID="HeadContent" Runat="Server">
</asp:Content>
<asp:Content ID="cBody" ContentPlaceHolderID="MainContent" Runat="Server">
    <uc1:MOCA_UE runat="server" ID="MOCA_UE01" />
    <div>

        <dx:ASPxLabel ID="ASPxLabel1" runat="server" Text="En Construcción" Font-Size="X-Large"></dx:ASPxLabel>

    </div>
</asp:Content>
