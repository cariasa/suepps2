<%@ Page Language="VB" AutoEventWireup="false" CodeFile="ExportarRespuestas.aspx.vb" Inherits="Evaluacion_ExportarRespuestas" MasterPageFile="~/Site.master" %>

<%@ Register Src="~/MOCA_UE.ascx" TagPrefix="uc1" TagName="MOCA_UE" %>

<asp:Content ID="cHeader" ContentPlaceHolderID="HeadContent" runat="Server">
</asp:Content>
<asp:Content ID="cBody" ContentPlaceHolderID="MainContent" runat="Server">
    <uc1:MOCA_UE runat="server" ID="MOCA_UE01" />
    <div>
        <dx:ASPxButton ID="ASPxButtonExportarRespuestas" runat="server" Text="Exportar Respuestas" OnClick="ASPxButtonExportarRespuestas_Click"></dx:ASPxButton>
        <dx:ASPxGridViewExporter ID="exporterRespuestas" runat="server" />
        <dx:ASPxGridView ID="ASPxGridViewRespuestas" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSourceRespuestas" KeyFieldName="IdPreguntaPorInstrumento">
            <Columns>
                <dx:GridViewDataTextColumn FieldName="IdPreguntaPorInstrumento" ReadOnly="True" VisibleIndex="0">
                    <EditFormSettings Visible="False"></EditFormSettings>
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="PreguntaDeInstrumento" VisibleIndex="1"></dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="IdRespuestaInstrumento" ReadOnly="True" VisibleIndex="2">
                    <EditFormSettings Visible="False"></EditFormSettings>
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="RespuestaTexto" VisibleIndex="3"></dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="RespuestaLikert" VisibleIndex="4"></dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="RespuestaEntera" VisibleIndex="5"></dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="RespuestaReal" VisibleIndex="6"></dx:GridViewDataTextColumn>
            </Columns>
        </dx:ASPxGridView>

        <asp:SqlDataSource runat="server" ID="SqlDataSourceRespuestas" ConnectionString='<%$ ConnectionStrings:SUEPPSConnectionString %>' SelectCommand="SELECT T1.IdPreguntaPorInstrumento, T1.PreguntaDeInstrumento, T0.[IdRespuestaInstrumento], T0.[RespuestaTexto] ,T0.[RespuestaLikert],T0.[RespuestaEntera],T0.[RespuestaReal]
FROM [SUEPPS-BD].[dbo].[RespuestasInstrumento] T0, [SUEPPS-BD].[dbo].[PreguntasPorInstrumento] T1"></asp:SqlDataSource>

    </div>
</asp:Content>
