<%@ Page Title="Digitación de Instrumentos de Evaluación" Language="VB" AutoEventWireup="false" CodeFile="Digitacion.aspx.vb" Inherits="Cuantitativo_DigitarInstrumento" MasterPageFile="~/Site.master" %>

<%@ Register Assembly="DevExpress.Web.v13.2, Version=13.2.6.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web.ASPxEditors" TagPrefix="dx" %>

<%@ Register Src="~/MOCA_UE.ascx" TagPrefix="uc1" TagName="MOCA_UE" %>

<asp:Content ID="cHeader" ContentPlaceHolderID="HeadContent" Runat="Server">
</asp:Content>
<asp:Content ID="cBody" ContentPlaceHolderID="MainContent" Runat="Server">
    <uc1:MOCA_UE runat="server" ID="MOCA_UE01" />
    <div>


        <dx:ASPxLabel ID="ASPxLabel1" runat="server" Text="Código Digitación" AssociatedControlID="ASPxTextBox1" ></dx:ASPxLabel>
        <dx:ASPxTextBox ID="ASPxTextBox1" runat="server" Width="170px"></dx:ASPxTextBox>

        <asp:LinkButton ID="LinkButton1" runat="server" OnClick="LinkButton1_Click">Iniciar Digitación</asp:LinkButton>



    </div>
   </asp:Content>