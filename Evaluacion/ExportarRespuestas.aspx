﻿<%@ Page Title="Exportar Respuestas Instrumentos" Language="VB" AutoEventWireup="false" CodeFile="ExportarRespuestas.aspx.vb" Inherits="Evaluacion_Exportart" MasterPageFile="~/Site.master" %>

<%@ Register Src="~/MOCA_UE.ascx" TagPrefix="uc1" TagName="MOCA_UE" %>

<asp:Content ID="cHeader" ContentPlaceHolderID="HeadContent" runat="Server">
</asp:Content>
<asp:Content ID="cBody" ContentPlaceHolderID="MainContent" runat="Server">
    <uc1:MOCA_UE runat="server" ID="MOCA_UE01" />
    <div>
        <dx:ASPxButton ID="ASPxButtonExportarPreguntas" runat="server" Text="Exportar" OnClick="ASPxButtonExportarPreguntas_Click"></dx:ASPxButton>
        <dx:ASPxGridViewExporter ID="exporter" runat="server" />

        <dx:ASPxGridView ID="ASPxGridViewPreguntas" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSourcePreguntas" Settings-ShowFilterRow="true">
            <Columns>
                <dx:GridViewDataTextColumn FieldName="NombreInstrumento" Caption="Instrumento" VisibleIndex="0"></dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Ano" VisibleIndex="1" Caption="Año"></dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="DescripcionMomento" VisibleIndex="2" Caption="Aplicación"></dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="IdAmigable" VisibleIndex="3" Caption="ID Pregunta"></dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="PreguntaDeInstrumento" VisibleIndex="4" Caption="Pregunta"></dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Opcion" VisibleIndex="5" Caption="Texto"></dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Valor" VisibleIndex="6" Caption="Valor"></dx:GridViewDataTextColumn>
            </Columns>
            <SettingsPager>
                <AllButton Visible="True" Text="Todos">
                </AllButton>
            </SettingsPager>
        </dx:ASPxGridView>








        <asp:SqlDataSource runat="server" ID="SqlDataSourcePreguntas" ConnectionString='<%$ ConnectionStrings:SUEPPSConnectionString %>' SelectCommand="select
	IE.NombreInstrumento,
	IE.Ano,
	MDA.DescripcionMomento,
	PPI.IdAmigable,
	PPI.PreguntaDeInstrumento,
	OPI.Opcion,
	OPI.Valor
from
	InstrumentosDeEvaluacion IE
	join AplicacionInstrumento AI on IE.IdInstrumentoDeEvaluacion = AI.IdInstrumentoDeEvaluacion
	join MomentosDeAplicacion MDA on AI.IdMomentoAplicacion = MDA.IdMomentoDeAplicacion
	join EncabezadoRespuesta ER on AI.IdAplicacionInstrumento = ER.IdAplicacionInstrumento
	join RespuestasInstrumento RI on ER.IdEncabezadoRespuesta = RI.IdEncabezadoRespuesta
	join PreguntasPorInstrumento PPI on PPI.IdPreguntaPorInstrumento = RI.IdPreguntaPorInstrumento
	join OpcionesRespuestaInstrumento ORI on RI.IdRespuestaInstrumento = ORI.IdRespuestaInstrumento
	join OpcionesPreguntaPorInstrumento OPI on ORI.IdOpcionPreguntaPorInstrumento = OPI.IdOpcionPreguntaPorInstrumento
"></asp:SqlDataSource>
    </div>
</asp:Content>
