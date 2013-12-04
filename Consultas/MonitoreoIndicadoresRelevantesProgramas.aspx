<%@ Page Language="VB" AutoEventWireup="false" CodeFile="MonitoreoIndicadoresRelevantesProgramas.aspx.vb" Inherits="Consultas_MonitoreoIndicadoresRelevantesPrograma"   MasterPageFile="~/Site.master"%>

<%@ Register Src="~/MOCA_UE.ascx" TagPrefix="uc1" TagName="MOCA_UE" %>


<asp:Content ID="cHeader" ContentPlaceHolderID="HeadContent" Runat="Server">
</asp:Content>
<asp:Content ID="cBody" ContentPlaceHolderID="MainContent" Runat="Server">
    <uc1:MOCA_UE runat="server" ID="MOCA_UE01" />
    <div>
        
        

        <table>
        <tr>
            <td>
                <dx:ASPxHyperLink ID="ASPxHyperLinkPolitica" runat="server"></dx:ASPxHyperLink>
                <dx:ASPxLabel ID="ASPxLabelPorcentaje" runat="server" ></dx:ASPxLabel>
            </td>
            <td>
                <dx:ASPxHyperLink ID="ASPxHyperLinkComponente" runat="server"></dx:ASPxHyperLink>
                <dx:ASPxLabel ID="ASPxLabelPorcentajeC" runat="server"></dx:ASPxLabel>
            </td>
            <td>
                <dx:ASPxHyperLink ID="ASPxHyperLinkMeta" runat="server"></dx:ASPxHyperLink>
                <dx:ASPxLabel ID="ASPxLabelPorcentajeM" runat="server"></dx:ASPxLabel>
            </td>
            <td>
                <dx:ASPxHyperLink ID="ASPxHyperLinkIndicador" runat="server"></dx:ASPxHyperLink>
                <dx:ASPxLabel ID="ASPxLabelPorcentajeI" runat="server"></dx:ASPxLabel>
            </td>
            <td>
                <dx:ASPxHyperLink ID="ASPxHyperLinkPrograma" runat="server"></dx:ASPxHyperLink>
                <dx:ASPxLabel ID="ASPxLabelPorcentajeP" runat="server"></dx:ASPxLabel>
            </td>
        </tr>
        
        </table>
        
        
        
        
        <dx:ASPxGridView ID="ASPxGridViewIndicadoresRelevantes" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSourceIndicadoresRelevantes"
             KeyFieldName="IdIndicadoresRelevantesDePrograma" Settings-ShowFooter="true" OnHtmlDataCellPrepared="ASPxGridViewIndicadoresRelevantes_HtmlDataCellPrepared"  >
             <TotalSummary>
                   <dx:ASPxSummaryItem FieldName="Peso" SummaryType="Sum" Tag="Total" />
             </TotalSummary>
             <Columns>
                   <dx:GridViewDataTextColumn FieldName="IdIndicadoresRelevantesDePrograma" ReadOnly="True" VisibleIndex="0" Visible="false">
                        <EditFormSettings Visible="False"></EditFormSettings>
                   </dx:GridViewDataTextColumn>

                   <dx:GridViewDataComboBoxColumn VisibleIndex="2" FieldName="IdProgramaPorIndicadorDeMeta" Caption="Programa">
                          <PropertiesComboBox ValueType="System.String"
                                  DataSourceID="SqlDataSourceProgramaPorIndicadorDeMetaComboGrid"
                                  ValueField="IdProgramasPorIndicadorDeMeta"
                                  TextField="NombreProyecto" />


                   </dx:GridViewDataComboBoxColumn>


                   <dx:GridViewDataComboBoxColumn VisibleIndex="1" FieldName="IdIndicadoresPorPrograma" Caption="Indicador">
                          <PropertiesComboBox ValueType="System.String"
                                   DataSourceID="SqlDataSourceIndicadoresPorProgramaComboGrid"
                                   ValueField="IdIndicadoresPorPrograma"
                                   TextField="DescripcionIndicador" />


                   </dx:GridViewDataComboBoxColumn>

                   <dx:GridViewDataTextColumn FieldName="Peso" VisibleIndex="3"></dx:GridViewDataTextColumn>
                   <dx:GridViewDataTextColumn FieldName="PorcentajeEjecucion" VisibleIndex="4" PropertiesTextEdit-DisplayFormatString="P"></dx:GridViewDataTextColumn>
                </Columns>
         </dx:ASPxGridView>

         <asp:SqlDataSource runat="server" ID="SqlDataSourceIndicadoresRelevantes" ConnectionString='<%$ ConnectionStrings:SUEPPSConnectionString %>'  >
                            
            <SelectParameters>
                    
                <asp:SessionParameter SessionField="IdProgramaPorIndicadorDeMeta" Name="IdProgramaPorIndicadorDeMeta" Type="Int32"></asp:SessionParameter>
                
            </SelectParameters>
        </asp:SqlDataSource>

        <asp:SqlDataSource ID="SqlDataSourceIndicadoresPorProgramaComboGrid" runat="server" ConnectionString='<%$ ConnectionStrings:SUEPPSConnectionString %>' SelectCommand="SELECT m.[IdIndicadoresPorPrograma], i.[DescripcionIndicador]  FROM [Indicadores] i, [IndicadoresPorPrograma] m WHERE i.[IdIndicador]=m.[IdIndicador]"></asp:SqlDataSource>

        <asp:SqlDataSource ID="SqlDataSourceProgramaPorIndicadorDeMetaComboGrid" runat="server" ConnectionString='<%$ ConnectionStrings:SUEPPSConnectionString %>' SelectCommand="SELECT m.[IdProgramasPorIndicadorDeMeta], i.[NombreProyecto]  FROM [vProyectos] i, [ProgramasPorIndicadorDeMeta] m WHERE i.[codigo_ficha]=m.[IdPrograma]"></asp:SqlDataSource>

        
    </div>
</asp:Content>
