<%@ Page Title="Análisis de Indicadores (Pivot)" Language="VB" AutoEventWireup="false" CodeFile="AnalisisIndicadores.aspx.vb" Inherits="Evaluacion_Default" MasterPageFile="~/Site.master" %>

<%@ Register Assembly="DevExpress.Web.v13.1, Version=13.1.8.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web.ASPxGridView" TagPrefix="dx" %>

<%@ Register Assembly="DevExpress.Web.v13.1, Version=13.1.8.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web.ASPxEditors" TagPrefix="dx" %>

<%@ Register Src="~/MOCA_UE.ascx" TagPrefix="uc1" TagName="MOCA_UE" %>

<asp:Content ID="cHeader" ContentPlaceHolderID="HeadContent" runat="Server">
</asp:Content>
<asp:Content ID="cBody" ContentPlaceHolderID="MainContent" runat="Server">
    <uc1:MOCA_UE runat="server" ID="MOCA_UE01" />
    <div>

        <asp:SqlDataSource ID="SqlDataSourceAnalisis" runat="server" ConnectionString="<%$ ConnectionStrings:SUEPPSConnectionString %>" SelectCommand="SELECT P.NombreProyecto, AI.IdAplicacionInstrumento, ME.DescripcionMomento, IE.NombreInstrumento, PE.ProcesoEvaluacion, I.DescripcionIndicador, VIP.FechaCalculo AS [Calculado En], VIP.ValorIndicador, D.DescripcionDepartamento, VD.Valor AS [Valor Departamento], M.DescripcionMunicipio, VM.Valor AS [Valor Municipio], S.DescripcionSexo, VS.Valor AS Sexo FROM AplicacionInstrumento AS AI INNER JOIN MomentosDeAplicacion AS ME ON AI.IdMomentoAplicacion = ME.IdMomentoDeAplicacion INNER JOIN InstrumentosDeEvaluacion AS IE ON AI.IdInstrumentoDeEvaluacion = IE.IdInstrumentoDeEvaluacion INNER JOIN ProcesosEvaluacion AS PE ON IE.IdProcesoEvaluacion = PE.IdProcesoEvaluacion INNER JOIN vProyectos AS P ON IE.IdPrograma = P.codigo_ficha INNER JOIN IndicadoresEvaluacionPorPrograma AS IEP ON IE.IdPrograma = IEP.IdPrograma INNER JOIN Indicadores AS I ON IEP.IdIndicador = I.IdIndicador LEFT OUTER JOIN ValoresIndicadorPorLevantamiento AS VIP ON AI.IdAplicacionInstrumento = VIP.IdAplicacionInstrumento AND IEP.IdIndicadoresEvaluacionPorPrograma = VIP.IdIndicadoresEvaluacionPorPrograma LEFT OUTER JOIN ValoresDepartamento AS VD ON AI.IdAplicacionInstrumento = VD.IdAplicacionInstrumento AND IEP.IdIndicadoresEvaluacionPorPrograma = VD.IdIndicadorEvaluacionPorPrograma LEFT OUTER JOIN vDepartamentos AS D ON VD.IdDepartamento = D.IdDepartamento LEFT OUTER JOIN ValoresMunicipio AS VM ON AI.IdAplicacionInstrumento = VM.IdAplicacionInstrumento AND IEP.IdIndicadoresEvaluacionPorPrograma = VM.IdIndicadorEvaluacionPorPrograma AND VM.IdDepartamento = VD.IdDepartamento LEFT OUTER JOIN vMunicipios AS M ON VM.IdMunicipio = M.IdMunicipio AND VM.IdDepartamento = M.IdDepartamento LEFT OUTER JOIN ValoresSexo AS VS ON AI.IdAplicacionInstrumento = VS.IdAplicacionInstrumento AND IEP.IdIndicadoresEvaluacionPorPrograma = VS.IdIndicadorEvaluacionPorPrograma LEFT OUTER JOIN vSexo AS S ON VS.IdSexo = S.IdSexo">
        </asp:SqlDataSource>
        <dx:ASPxPivotGridExporter ID="ASPxPivotGridExporter1" runat="server" ASPxPivotGridID="ASPxPivotGrid1">
        </dx:ASPxPivotGridExporter>
        <dx:ASPxButton ID="btnXlsExport" runat="server" Text="Exportar a Excel" UseSubmitBehavior="false" OnClick="btnXlsExport_Click" />
        <dx:ASPxPivotGrid ID="ASPxPivotGrid1" runat="server" ClientIDMode="AutoID" DataSourceID="SqlDataSourceAnalisis">
            <Fields>
                <dx:PivotGridField ID="fieldNombreProyecto" FieldName="NombreProyecto">
                </dx:PivotGridField>
                <dx:PivotGridField ID="fieldIdAplicacionInstrumento" FieldName="IdAplicacionInstrumento">
                </dx:PivotGridField>
                <dx:PivotGridField ID="fieldDescripcionMomento" FieldName="DescripcionMomento">
                </dx:PivotGridField>
                <dx:PivotGridField ID="fieldNombreInstrumento" FieldName="NombreInstrumento">
                </dx:PivotGridField>
                <dx:PivotGridField ID="fieldProcesoEvaluacion" FieldName="ProcesoEvaluacion">
                </dx:PivotGridField>
                <dx:PivotGridField ID="fieldDescripcionIndicador" FieldName="DescripcionIndicador">
                </dx:PivotGridField>
                <dx:PivotGridField ID="fieldCalculadoEn" FieldName="Calculado En">
                </dx:PivotGridField>
                <dx:PivotGridField ID="fieldValorIndicador" FieldName="ValorIndicador">
                </dx:PivotGridField>
                <dx:PivotGridField ID="fieldDescripcionDepartamento" FieldName="DescripcionDepartamento">
                </dx:PivotGridField>
                <dx:PivotGridField ID="fieldValorDepartamento" FieldName="Valor Departamento">
                </dx:PivotGridField>
                <dx:PivotGridField ID="fieldDescripcionMunicipio" FieldName="DescripcionMunicipio">
                </dx:PivotGridField>
                <dx:PivotGridField ID="fieldValorMunicipio" FieldName="Valor Municipio">
                </dx:PivotGridField>
                <dx:PivotGridField ID="fieldDescripcionSexo" FieldName="DescripcionSexo">
                </dx:PivotGridField>
                <dx:PivotGridField ID="fieldSexo" FieldName="Sexo">
                </dx:PivotGridField>
            </Fields>
        </dx:ASPxPivotGrid>

    </div>
</asp:Content>
