<%@ Page Language="VB" AutoEventWireup="false" CodeFile="Grafico.aspx.vb" Inherits="Reportes_Grafico" MasterPageFile="~/Site.master" %>

<%@ Register Assembly="DevExpress.Web.ASPxGauges.v13.1, Version=13.1.8.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web.ASPxGauges" TagPrefix="dx" %>

<%@ Register Assembly="DevExpress.Web.ASPxGauges.v13.1, Version=13.1.8.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web.ASPxGauges.Gauges" TagPrefix="dx" %>
<%@ Register Assembly="DevExpress.Web.ASPxGauges.v13.1, Version=13.1.8.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web.ASPxGauges.Gauges.Linear" TagPrefix="dx" %>
<%@ Register Assembly="DevExpress.Web.ASPxGauges.v13.1, Version=13.1.8.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web.ASPxGauges.Gauges.Circular" TagPrefix="dx" %>
<%@ Register Assembly="DevExpress.Web.ASPxGauges.v13.1, Version=13.1.8.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web.ASPxGauges.Gauges.State" TagPrefix="dx" %>
<%@ Register Assembly="DevExpress.Web.ASPxGauges.v13.1, Version=13.1.8.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web.ASPxGauges.Gauges.Digital" TagPrefix="dx" %>

<%@ Register Src="~/MOCA_UE.ascx" TagPrefix="uc1" TagName="MOCA_UE" %>


<asp:Content ID="cHeader" ContentPlaceHolderID="HeadContent" runat="Server">
</asp:Content>
<asp:Content ID="cBody" ContentPlaceHolderID="MainContent" runat="Server">
    <uc1:MOCA_UE runat="server" ID="MOCA_UE01" />
    <div>
        <div style="display: table-row">
            <div style="display: table-cell; padding:45px">
                <dx:WebChartControl ID="chart" runat="server" CrosshairEnabled="True" Height="200px" SideBySideEqualBarWidth="True" Width="300px"></dx:WebChartControl>
            </div>
            <div style="display: table-cell; padding:45px">
                <dx:ASPxGaugeControl ID="gaugeControl" runat="server" BackColor="White" Height="250px" Width="250px"></dx:ASPxGaugeControl>
            </div>
        </div>
    </div>
</asp:Content>
