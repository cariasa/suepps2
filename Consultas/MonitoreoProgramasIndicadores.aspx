<%@ Page Language="VB" AutoEventWireup="false" CodeFile="MonitoreoProgramasIndicadores.aspx.vb" Inherits="Consultas_MonitoreoProgramasIndicadores"   MasterPageFile="~/Site.master"%>

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
            
        </tr>
        
        </table>
        
        
        
        <dx:ASPxGridView ID="ASPxGridViewProgramasIndicadoresMetas" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSourceProgramasIndicadoresMetas" 
             KeyFieldName="IdProgramasPorIndicadorDeMeta" IsDetailGrid="true" SettingsBehavior-AllowFocusedRow="true" OnHtmlDataCellPrepared="ASPxGridViewProgramasIndicadoresMetas_HtmlDataCellPrepared"
             Visible="true" Settings-ShowFooter="true">
             <TotalSummary>
                   <dx:ASPxSummaryItem FieldName="Peso" SummaryType="Sum" Tag="Total"/>
             </TotalSummary>
             <Columns>
             <dx:GridViewDataTextColumn FieldName="IdProgramasPorIndicadorDeMeta" ReadOnly="True" VisibleIndex="0" Visible="false">
                  <EditFormSettings Visible="False"></EditFormSettings>
             </dx:GridViewDataTextColumn>
                
             <dx:GridViewDataComboBoxColumn VisibleIndex="1" FieldName="IdPrograma" Caption="Programa">
                  <PropertiesComboBox ValueType="System.String" 
                
                          DataSourceID="SqlDataSourceProgramasComboGrid" 
                          ValueField="codigo_ficha" 
                          TextField="NombreProyecto"/>
     
                    
              </dx:GridViewDataComboBoxColumn>

                
              <dx:GridViewDataComboBoxColumn VisibleIndex="1" FieldName="IdIndicadorDeMeta" Caption="Indicador">
                   <PropertiesComboBox ValueType="System.String" 
                
                           DataSourceID="SqlDataSourceIndicadoresDeIndicadorDeMetaComboGrid" 
                           ValueField="IdIndicadorDeMeta" 
                           TextField="DescripcionIndicador"/>
     
                    
                    </dx:GridViewDataComboBoxColumn>
               <dx:GridViewDataTextColumn FieldName="Peso" VisibleIndex="3"></dx:GridViewDataTextColumn>
               <dx:GridViewDataTextColumn FieldName="PorcentajeEjecucion" VisibleIndex="4" PropertiesTextEdit-DisplayFormatString="P"></dx:GridViewDataTextColumn>
               <dx:GridViewDataTextColumn Visible="true" VisibleIndex="5">
                     <DataItemTemplate>
                          <asp:LinkButton id="link1"  Text="Ver Detalle" runat="server" Visible="true" OnClick="link1_Click"/>
                     </DataItemTemplate>
               </dx:GridViewDataTextColumn>
            </Columns>
     </dx:ASPxGridView>

                <asp:SqlDataSource ID="SqlDataSourceProgramasComboGrid" runat="server" ConnectionString='<%$ ConnectionStrings:SUEPPSConnectionString %>' SelectCommand="SELECT [codigo_ficha], [NombreProyecto] FROM [vProyectos]"></asp:SqlDataSource>


        <asp:SqlDataSource runat="server" ID="SqlDataSourceProgramasIndicadoresMetas" ConnectionString='<%$ ConnectionStrings:SUEPPSConnectionString %>' 
            >
            
            <SelectParameters>
                    
                <asp:SessionParameter SessionField="IdIndicadorDeMeta" Name="IdIndicadorDeMeta" Type="Int32"></asp:SessionParameter>
                
            </SelectParameters>
            
        </asp:SqlDataSource>

        <asp:SqlDataSource ID="SqlDataSourceIndicadoresDeIndicadorDeMetaComboGrid" runat="server" ConnectionString='<%$ ConnectionStrings:SUEPPSConnectionString %>' SelectCommand="SELECT m.[IdIndicadorDeMeta], i.[DescripcionIndicador]  FROM [Indicadores] i, [IndicadoresDeMeta] m WHERE i.[IdIndicador]=m.[IdIndicador]"></asp:SqlDataSource>

        


    </div>
</asp:Content>