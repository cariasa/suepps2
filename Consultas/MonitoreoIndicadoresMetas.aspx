<%@ Page Language="VB" AutoEventWireup="false" CodeFile="MonitoreoIndicadoresMetas.aspx.vb" Inherits="Consultas_MonitoreoIndicadoresMetas"   MasterPageFile="~/Site.master"%>

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
                        
        </tr>
        
        </table>
        
        <dx:ASPxGridView ID="ASPxGridViewindicadoresMetas" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSourceIndicadoresMetas" 
                            KeyFieldName="IdIndicadorDeMeta" IsDetailGrid="true"
                            Visible="true" Settings-ShowFooter="true"  SettingsBehavior-AllowFocusedRow="true"
                            OnHtmlDataCellPrepared="ASPxGridViewProgramasIndicadoresMetas_HtmlDataCellPrepared">
                        <TotalSummary>
                            <dx:ASPxSummaryItem FieldName="Peso" SummaryType="Sum" Tag="Total"/>
                        </TotalSummary>
                        <Columns>
                            <dx:GridViewDataTextColumn FieldName="IdIndicadorDeMeta" ReadOnly="True" VisibleIndex="0" Visible="false">
                                <EditFormSettings Visible="False"></EditFormSettings>
                            </dx:GridViewDataTextColumn>
                
                            <dx:GridViewDataComboBoxColumn VisibleIndex="2" FieldName="IdMetasDeComponente" Caption="Metas de Componente">
                                    <PropertiesComboBox ValueType="System.String" 
                
                                        DataSourceID="SqlDataSourceMetasDeComponenteComboGrid" 
                                        ValueField="IdMetasDeComponente" 
                                        TextField="Nombre"/>
     
                    
                            </dx:GridViewDataComboBoxColumn>
                
                            <dx:GridViewDataComboBoxColumn VisibleIndex="1" FieldName="IdIndicador" Caption="Indicador">
                                    <PropertiesComboBox ValueType="System.String" 
                
                                        DataSourceID="SqlDataSourceIndicadoresComboGrid" 
                                        ValueField="IdIndicador" 
                                        TextField="DescripcionIndicador"/>
     
                    
                            </dx:GridViewDataComboBoxColumn>
                            <dx:GridViewDataTextColumn FieldName="Peso" VisibleIndex="3"></dx:GridViewDataTextColumn>
                            <dx:GridViewDataTextColumn FieldName="PorcentajeEjecucion" VisibleIndex="3" PropertiesTextEdit-DisplayFormatString="P"></dx:GridViewDataTextColumn>
                            <dx:GridViewDataTextColumn Visible="true">
                                <DataItemTemplate>
                                    <asp:LinkButton id="link1"  Text="VerDetalle" runat="server" Visible="true" OnClick="link1_Click"/>
                                </DataItemTemplate>
                            </dx:GridViewDataTextColumn>
                            </Columns>
        </dx:ASPxGridView>
        <asp:SqlDataSource ID="SqlDataSourceProgramasComboGrid" runat="server" ConnectionString='<%$ ConnectionStrings:SUEPPSConnectionString %>' SelectCommand="SELECT [codigo_ficha], [NombreProyecto] FROM [vProyectos]"></asp:SqlDataSource>
        <asp:SqlDataSource ID="SqlDataSourceIndicadoresDeIndicadorDeMetaComboGrid" runat="server" ConnectionString='<%$ ConnectionStrings:SUEPPSConnectionString %>' SelectCommand="SELECT m.[IdIndicadorDeMeta], i.[DescripcionIndicador]  FROM [Indicadores] i, [IndicadoresDeMeta] m WHERE i.[IdIndicador]=m.[IdIndicador]"></asp:SqlDataSource>
        <asp:SqlDataSource runat="server" ID="SqlDataSourceIndicadoresComboGrid" ConnectionString='<%$ ConnectionStrings:SUEPPSConnectionString %>' SelectCommand="SELECT [IdIndicador], [DescripcionIndicador] FROM [Indicadores]"></asp:SqlDataSource>
         <asp:SqlDataSource runat="server" ID="SqlDataSourceMetasDeComponenteComboGrid" ConnectionString='<%$ ConnectionStrings:SUEPPSConnectionString %>' SelectCommand="SELECT [IdMetasDeComponente], [Nombre] FROM [MetasDeComponente]"></asp:SqlDataSource>
         <asp:SqlDataSource runat="server" ID="SqlDataSourceIndicadoresMetas" ConnectionString='<%$ ConnectionStrings:SUEPPSConnectionString %>' >

            <SelectParameters>
                    
                <asp:SessionParameter SessionField="IdMetasDeComponente" Name="IdMetasDeComponente" Type="Int32"></asp:SessionParameter>
                
            </SelectParameters>
        </asp:SqlDataSource>

    </div>
</asp:Content>