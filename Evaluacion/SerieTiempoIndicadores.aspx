<%@ Page Title="Serie de Tiempo Indicadore" Language="VB" AutoEventWireup="false" CodeFile="SerieTiempoIndicadores.aspx.vb" Inherits="Reportes_SerieTiempoIndicadores"  MasterPageFile="~/Site.master" %>

<%@ Register Src="~/MOCA_UE.ascx" TagPrefix="uc1" TagName="MOCA_UE" %>

<asp:Content ID="cHeader" ContentPlaceHolderID="HeadContent" Runat="Server">
</asp:Content>
<asp:Content ID="cBody" ContentPlaceHolderID="MainContent" Runat="Server">
    <uc1:MOCA_UE runat="server" ID="MOCA_UE01" />
    <div>

        <table>
            <tr>
            <td>
                <dx:ASPxGridView ID="ASPxGridViewProyectos" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSourceProyectos" KeyFieldName="codigo_ficha" SettingsBehavior-AllowFocusedRow="true" Settings-ShowFilterRow="true">
                    <Columns>
                        <dx:GridViewDataTextColumn FieldName="codigo_ficha" ReadOnly="True" VisibleIndex="0" Visible="false"></dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn FieldName="NombreProyecto" VisibleIndex="1"><Settings AutoFilterCondition="Contains" /></dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn FieldName="Acción" ShowInCustomizationForm="True" VisibleIndex="4" Caption="Acción" UnboundType="String">
                              <DataItemTemplate>
                                    <asp:LinkButton ID="linkElegirP" Text="Elegir" runat="server" OnClick="linkElegirP_Click" />
                                    <br />

                              </DataItemTemplate>
                              <Settings AllowAutoFilter="False" />
                        </dx:GridViewDataTextColumn>
                    </Columns>
                </dx:ASPxGridView>
                <asp:SqlDataSource runat="server" ID="SqlDataSourceProyectos" ConnectionString='<%$ ConnectionStrings:SUEPPSConnectionString %>'></asp:SqlDataSource>
            </td>

                <td>
                    <dx:ASPxGridView ID="ASPxGridViewIndicadoresPrograma" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSourceIndicadoresPrograma" SettingsBehavior-AllowFocusedRow="true" Settings-ShowFilterRow="true" KeyFieldName="IdIndicador">
                        <Columns>
                            <dx:GridViewDataTextColumn FieldName="IdIndicador" VisibleIndex="0" Visible="true"></dx:GridViewDataTextColumn>
                            
                            <dx:GridViewDataTextColumn FieldName="DescripcionIndicador" VisibleIndex="2"><Settings AutoFilterCondition="Contains" /></dx:GridViewDataTextColumn>
                            <dx:GridViewDataTextColumn FieldName="Acción" ShowInCustomizationForm="True" VisibleIndex="4" Caption="Acción" UnboundType="String">
                              <DataItemTemplate>
                                    <asp:LinkButton ID="linkElegirI" Text="Agregar" runat="server" OnClick="linkElegirI_Click" />
                              </DataItemTemplate>
                              <Settings AllowAutoFilter="False" />
                        </dx:GridViewDataTextColumn>
                        </Columns>
                    </dx:ASPxGridView>

                    <asp:SqlDataSource runat="server" ID="SqlDataSourceIndicadoresPrograma" ConnectionString='<%$ ConnectionStrings:SUEPPSConnectionString %>' >
                        <SelectParameters>
                            <asp:SessionParameter Name="IdPrograma" SessionField="IdPrograma" Type="Int32"/>
                        </SelectParameters>
                    </asp:SqlDataSource>
                </td>
            </tr>
            <tr>
                <td>
                    <dx:ASPxButton runat="server" ID="CmdClearSeries" Text="Limpiar Series" OnClick="CmdClearSeries_Click"></dx:ASPxButton>
                </td>
            </tr>
        </table>

        

        <asp:SqlDataSource runat="server" ID="SqlDataSourceIndicadores" ConnectionString='<%$ ConnectionStrings:SUEPPSConnectionString %>'>
            <SelectParameters>
                <asp:SessionParameter Name="IdPrograma" SessionField="IdPrograma" Type="Int32" />
                <asp:SessionParameter Name="IdIndicador" SessionField="IdIndicador" Type="Int32" />
            </SelectParameters>
        </asp:SqlDataSource>

        <dx:ASPxGridView ID="ChartData" DataSourceID="SqlDataSourceIndicadores" runat="server" AutoGenerateColumns="False" Visible="false">
            <Columns>
                <dx:GridViewDataTextColumn VisibleIndex="1" FieldName="FechaAplicacion"></dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn VisibleIndex="2" FieldName="DescripcionMomento"></dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn VisibleIndex="3" FieldName="ValorIndicador"></dx:GridViewDataTextColumn>
            </Columns>
            <SettingsDataSecurity AllowEdit="False" AllowInsert="False" AllowDelete="False"></SettingsDataSecurity>
        </dx:ASPxGridView>

        <dx:WebChartControl id="WebChartControlIndicadores" runat="server" height="400px" width="700px" cssclass="AlignCenter TopLargeMargin"
            datasourceid="SqlDataSourceIndicadores" clientinstancename="chart" CrosshairEnabled="True" >
         </dx:WebChartControl>

        
    </div>
</asp:Content>

