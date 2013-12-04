<%@ Page Language="VB" AutoEventWireup="false" CodeFile="MonitoreoMetasComponentes.aspx.vb" Inherits="Consultas_MonitoreoMetasComponentes"   MasterPageFile="~/Site.master"%>

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
                                    
        </tr>
        
        </table>
    
        <dx:ASPxGridView ID="ASPxGridViewMetasComponentes" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSourceMetasComponentes" 
                KeyFieldName="IdMetasDeComponente" IsDetailGrid="true"   
                Visible="true" Settings-ShowFooter="true"  SettingsBehavior-AllowFocusedRow="true"
                OnHtmlDataCellPrepared="ASPxGridViewMetasComponentes_HtmlDataCellPrepared"
                >
                <TotalSummary>
                        <dx:ASPxSummaryItem FieldName="Peso" SummaryType="Sum" Tag="Total"/>
                </TotalSummary>   
                <Columns>
                <dx:GridViewDataTextColumn FieldName="IdMetasDeComponente" ReadOnly="True" VisibleIndex="0" Visible="false">
                    <EditFormSettings Visible="False"></EditFormSettings>
                </dx:GridViewDataTextColumn>
                
                <dx:GridViewDataComboBoxColumn VisibleIndex="2" FieldName="IdComponentesDePolitica" Caption="Componentes De Politica">
                        <PropertiesComboBox ValueType="System.String" 
                
                            DataSourceID="SqlDataSourceComponentesPoliticasComboGrid" 
                            ValueField="IdComponentesDePolitica" 
                            TextField="Nombre"/>
     
                    
                </dx:GridViewDataComboBoxColumn>
                <dx:GridViewDataTextColumn FieldName="Nombre" VisibleIndex="1" Caption="Meta de Componente"></dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Descripcion" VisibleIndex="3"></dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Peso" VisibleIndex="4"></dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="PorcentajeEjecucion" VisibleIndex="5" PropertiesTextEdit-DisplayFormatString="P"></dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn Visible="true">
                    <DataItemTemplate>
                        <asp:LinkButton id="link1"  Text="VerDetalle" runat="server" Visible="true" OnClick="link1_Click"/>
                    </DataItemTemplate>
               </dx:GridViewDataTextColumn>
            </Columns>
            </dx:ASPxGridView>

             <asp:SqlDataSource runat="server" ID="SqlDataSourceComponentesPoliticasComboGrid" ConnectionString='<%$ ConnectionStrings:SUEPPSConnectionString %>' SelectCommand="SELECT [IdComponentesDePolitica], [Nombre] FROM [ComponentesDePolitica]"></asp:SqlDataSource>
    
             <asp:SqlDataSource runat="server" ID="SqlDataSourceMetasComponentes" ConnectionString='<%$ ConnectionStrings:SUEPPSConnectionString %>' >
            
                    <SelectParameters>
                    
                        <asp:SessionParameter SessionField="IdComponentesDePolitica" Name="IdComponentesDePolitica" Type="Int32"></asp:SessionParameter>
                
                    </SelectParameters>
            </asp:SqlDataSource>
    </div>
</asp:Content>
