<%@ Page Language="VB" AutoEventWireup="false" CodeFile="MonitoreoPoliticasComponentes.aspx.vb" Inherits="Consultas_MonitoreoPoliticasComponentes"  MasterPageFile="~/Site.master" %>

<%@ Register Src="~/MOCA_UE.ascx" TagPrefix="uc1" TagName="MOCA_UE" %>


<asp:Content ID="cHeader" ContentPlaceHolderID="HeadContent" Runat="Server">
</asp:Content>
<asp:Content ID="cBody" ContentPlaceHolderID="MainContent" Runat="Server">
    <uc1:MOCA_UE runat="server" ID="MOCA_UE01" />
    <div>
        
        <table>
        <tr>
            <td>
                <dx:ASPxHyperLink ID="ASPxHyperLinkPolitica"  runat="server" NavigateUrl="MonitoreoPoliticas.aspx"  ></dx:ASPxHyperLink>
                <dx:ASPxLabel ID="ASPxLabelPorcentaje" runat="server" ></dx:ASPxLabel>
            </td>
                           
        </tr>
        </table>
        

        <dx:ASPxGridView ID="ASPxGridViewComponentesPoliticas" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSourceComponentesPoliticas" 
                KeyFieldName="IdComponentesDePolitica" IsDetailGrid="true" SettingsBehavior-AllowFocusedRow="true"
                Settings-ShowFooter="true" OnHtmlDataCellPrepared="ASPxGridViewPoliticas_HtmlDataCellPrepared" >
                <TotalSummary>
                        <dx:ASPxSummaryItem FieldName="Peso" SummaryType="Sum" Tag="Total"/>
                </TotalSummary>
                <Columns>
                <dx:GridViewDataTextColumn FieldName="IdComponentesDePolitica" ReadOnly="True" VisibleIndex="0" Visible="false">
                    <EditFormSettings Visible="False"></EditFormSettings>
                </dx:GridViewDataTextColumn>
                
                <dx:GridViewDataComboBoxColumn VisibleIndex="2" FieldName="IdPolitica" Caption="Política">
                        <PropertiesComboBox ValueType="System.String" 
                
                            DataSourceID="SqlDataSourcePoliticasComboGrid" 
                            ValueField="IdPolitica" 
                            TextField="Nombre"/>
     
                    
                </dx:GridViewDataComboBoxColumn>
                <dx:GridViewDataTextColumn FieldName="Nombre" VisibleIndex="1" Caption="Componente"></dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Descripcion" VisibleIndex="3"></dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Peso" VisibleIndex="4"></dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="PorcentajeEjecucion" VisibleIndex="4" PropertiesTextEdit-DisplayFormatString="P"></dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn Visible="true">
                    <DataItemTemplate>
                        <asp:LinkButton id="link1"  Text="VerDetalle" runat="server" Visible="true" OnClick="link1_Click"/>
                    </DataItemTemplate>
               </dx:GridViewDataTextColumn>
            </Columns>
        </dx:ASPxGridView>
        <asp:SqlDataSource runat="server" ID="SqlDataSourceComponentesPoliticas" ConnectionString='<%$ ConnectionStrings:SUEPPSConnectionString %>' 
        >
            <SelectParameters>
                    
                <asp:SessionParameter SessionField="IdPolitica" Name="IdPolitica" Type="Int32"></asp:SessionParameter>
                
            </SelectParameters>

        </asp:SqlDataSource>

        <asp:SqlDataSource runat="server" ID="SqlDataSourcePoliticasComboGrid" ConnectionString='<%$ ConnectionStrings:SUEPPSConnectionString %>' SelectCommand="SELECT [IdPolitica], [Nombre] FROM [Politicas]"></asp:SqlDataSource>
    </div>
</asp:Content>
