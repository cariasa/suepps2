<%@ Page Language="VB" AutoEventWireup="false" CodeFile="DigitarInstrumento.aspx.vb" Inherits="Cuantitativo_DigitarInstrumento" %>

<%@ Register Assembly="DevExpress.Web.v13.1, Version=13.1.8.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web.ASPxEditors" TagPrefix="dx" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
    <div>


        <dx:ASPxLabel ID="ASPxLabel1" runat="server" Text="Código Digitación" AssociatedControlID="ASPxTextBox1" ></dx:ASPxLabel>
        <dx:ASPxTextBox ID="ASPxTextBox1" runat="server" Width="170px"></dx:ASPxTextBox>

        <asp:LinkButton ID="LinkButton1" runat="server" OnClick="LinkButton1_Click">Iniciar Digitación</asp:LinkButton>



    </div>
    </form>
</body>
</html>
