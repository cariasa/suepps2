﻿<%@ Page Title="Digitación de Instrumentos de Evaluación" Language="VB" AutoEventWireup="false" CodeFile="Digitacion.aspx.vb" Inherits="Cuantitativo_DigitarInstrumento" MasterPageFile="~/Site.master" %>

<%@ Register Assembly="DevExpress.Web.v13.2, Version=13.2.7.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web.ASPxEditors" TagPrefix="dx" %>

<%@ Register Src="~/MOCA_UE.ascx" TagPrefix="uc1" TagName="MOCA_UE" %>

<asp:Content ID="cHeader" ContentPlaceHolderID="HeadContent" Runat="Server">
</asp:Content>
<asp:Content ID="cBody" ContentPlaceHolderID="MainContent" Runat="Server">
    <uc1:MOCA_UE runat="server" ID="MOCA_UE01" />
    <div>


        <dx:ASPxLabel ID="ASPxLabel1" runat="server" Text="Código Digitación" AssociatedControlID="ASPxTextBox1" ></dx:ASPxLabel>
        <dx:ASPxTextBox ID="ASPxTextBox1" runat="server" Width="170px"></dx:ASPxTextBox>

        <dx:ASPxLabel ID="ASPxLabel2" runat="server" Text="Código FSU" AssociatedControlID="ASPxTextBoxIdFicha" ></dx:ASPxLabel>
        <dx:ASPxTextBox ID="ASPxTextBoxIdFicha" runat="server" Width="170px"></dx:ASPxTextBox>

        <dx:ASPxLabel ID="ASPxLabel3" runat="server" Text="Id Vivienda" AssociatedControlID="ASPxTextBoxIdVivienda" ></dx:ASPxLabel>
        <dx:ASPxTextBox ID="ASPxTextBoxIdVivienda" runat="server" Width="170px"></dx:ASPxTextBox>

        <dx:ASPxLabel ID="ASPxLabel4" runat="server" Text="Id Hogar" AssociatedControlID="ASPxTextBoxIdHogar" ></dx:ASPxLabel>
        <dx:ASPxTextBox ID="ASPxTextBoxIdHogar" runat="server" Width="170px"></dx:ASPxTextBox>

        <dx:ASPxLabel ID="ASPxLabel5" runat="server" Text="Id Miembro" AssociatedControlID="ASPxTextBoxIdMiembro" ></dx:ASPxLabel>
        <dx:ASPxTextBox ID="ASPxTextBoxIdMiembro" runat="server" Width="170px"></dx:ASPxTextBox>

        <asp:LinkButton ID="LinkDigitacion" runat="server" OnClick="LinkDigitacion_Click">Iniciar Digitación</asp:LinkButton>



    </div>
   </asp:Content>