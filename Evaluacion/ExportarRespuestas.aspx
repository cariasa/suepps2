<%@ Page Language="VB" AutoEventWireup="false" CodeFile="ExportarRespuestas.aspx.vb" Inherits="Evaluacion_ExportarRespuestas" MasterPageFile="~/Site.master" %>

<%@ Register Src="~/MOCA_UE.ascx" TagPrefix="uc1" TagName="MOCA_UE" %>

<asp:Content ID="cHeader" ContentPlaceHolderID="HeadContent" runat="Server">
</asp:Content>
<asp:Content ID="cBody" ContentPlaceHolderID="MainContent" runat="Server">
    <uc1:MOCA_UE runat="server" ID="MOCA_UE01" />
    <div>
        <dx:ASPxButton ID="ASPxButtonExportarRespuestas" runat="server" Text="Exportar Respuestas" OnClick="ASPxButtonExportarRespuestas_Click"></dx:ASPxButton>
        <dx:ASPxGridViewExporter ID="exporterRespuestas" runat="server" />
        <dx:ASPxGridView ID="ASPxGridViewRespuestas" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSourceRespuestas"><Columns>
<dx:GridViewDataTextColumn FieldName="NombreInstrumento" VisibleIndex="0"></dx:GridViewDataTextColumn>
<dx:GridViewDataTextColumn FieldName="IdAmigable" VisibleIndex="1"></dx:GridViewDataTextColumn>
<dx:GridViewDataTextColumn FieldName="PreguntaDeInstrumento" VisibleIndex="2"></dx:GridViewDataTextColumn>
<dx:GridViewDataTextColumn FieldName="Opcion" VisibleIndex="3"></dx:GridViewDataTextColumn>
<dx:GridViewDataTextColumn FieldName="Valor" VisibleIndex="4"></dx:GridViewDataTextColumn>
</Columns>
</dx:ASPxGridView>

    <asp:SqlDataSource runat="server" ID="SqlDataSourceRespuestas" ConnectionString='<%$ ConnectionStrings:SUEPPSConnectionString %>' SelectCommand="select 
	IE.NombreInstrumento,
	PPI.IdAmigable,
	PPI.PreguntaDeInstrumento,
	OPI.Opcion,
	OPI.Valor 
from 
	InstrumentosDeEvaluacion IE
	join PreguntasPorInstrumento PPI on IE.IdInstrumentoDeEvaluacion = PPI.IdInstrumentoDeEvaluacion
	join OpcionesPreguntaPorInstrumento OPI on PPI.IdPreguntaPorInstrumento = OPI.IdPreguntaPorInstrumento
where
	PPI.Activo = 1 and OPI.Activo = 1 and
	(PPI.IdTipoDePregunta >= 3)"></asp:SqlDataSource>
</div>
</asp:Content>
