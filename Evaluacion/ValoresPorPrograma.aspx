<%@ Page Language="VB" AutoEventWireup="false" CodeFile="ValoresPorPrograma.aspx.vb" Inherits="Evaluacion_ValoresPorPrograma"  MasterPageFile="~/Site.master" %>

<%@ Register Src="~/MOCA_UE.ascx" TagPrefix="uc1" TagName="MOCA_UE" %>

<asp:Content ID="cHeader" ContentPlaceHolderID="HeadContent" Runat="Server">
</asp:Content>
<asp:Content ID="cBody" ContentPlaceHolderID="MainContent" Runat="Server">
    <uc1:MOCA_UE runat="server" ID="MOCA_UE01" />
    <div>
        <table>
                <tr>
                    <td>
                        <dx:ASPxLabel ID="ASPxLabelVariable" runat="server" Font-Size="Large"></dx:ASPxLabel>
                    </td>
                    <td>
                        <dx:ASPxLabel ID="espacio" runat="server" Text=" " Width="360"></dx:ASPxLabel>
                        <dx:ASPxHyperLink ID="ASPxHyperLinkRegresar" runat="server" Text="Regresar a Parámetros" NavigateUrl="Parametros.aspx" />
                    </td>
                </tr>
            </table>
        <dx:ASPxGridView ID="ASPxGridViewVariablesPrograma" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSourceVariablesPrograma" KeyFieldName="IdVariablePrograma" Settings-ShowFilterRow="true">
            <Columns>
                <dx:GridViewDataTextColumn FieldName="IdVariablePrograma" ReadOnly="True" VisibleIndex="0" Caption="ID">
                    <EditFormSettings Visible="False"></EditFormSettings>
                </dx:GridViewDataTextColumn>
                
                <dx:GridViewDataComboBoxColumn VisibleIndex="1" FieldName="IdVariable" Caption="Variable" EditFormSettings-Visible="False">
                    <PropertiesComboBox ValueType="System.String"
                        DataSourceID="SqlDataSourceVariable"
                        ValueField="IdVariable"
                        TextField="NombreVariable" />
                    <Settings AllowAutoFilter="True" />
                    <Settings AutoFilterCondition="Contains" />
                    <Settings FilterMode="DisplayText" />


                </dx:GridViewDataComboBoxColumn>

                <dx:GridViewDataTextColumn FieldName="Valor" VisibleIndex="2"></dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Fuente" VisibleIndex="3" Settings-AutoFilterCondition="Contains"></dx:GridViewDataTextColumn>
                <dx:GridViewDataDateColumn FieldName="Fecha" VisibleIndex="4"></dx:GridViewDataDateColumn>
                <dx:GridViewDataTextColumn FieldName="CreadoPor" VisibleIndex="5" Visible="false"></dx:GridViewDataTextColumn>
                <dx:GridViewDataDateColumn FieldName="FechaCreacion" VisibleIndex="6" Visible="false"></dx:GridViewDataDateColumn>
                <dx:GridViewDataTextColumn FieldName="ActualizadoPor" VisibleIndex="7" Visible="false"></dx:GridViewDataTextColumn>
                <dx:GridViewDataDateColumn FieldName="FechaActualizacion" VisibleIndex="8" Visible="false"></dx:GridViewDataDateColumn>
                <dx:GridViewDataCheckColumn FieldName="Activo" VisibleIndex="9" Visible="false"></dx:GridViewDataCheckColumn>
                 <dx:GridViewCommandColumn>
                                            <NewButton Visible="true"></NewButton>
                                            <EditButton Visible="true"></EditButton>
                                            <DeleteButton Visible="true"></DeleteButton>
                                        </dx:GridViewCommandColumn>
            </Columns>
            <SettingsPager>
                  <AllButton Visible="True" Text="Todos">
                  </AllButton>
            </SettingsPager>
            <SettingsDetail ShowDetailRow="true" ShowDetailButtons="true" />
            <Templates>
                <DetailRow>
                    <dx:ASPxGridView ID="ASPxGridViewDetalleVariablesPrograma" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSourceDetalleVariablesPrograma" KeyFieldName="IdDetalleVariablePrograma" Settings-ShowFilterRow="true" OnBeforePerformDataSelect="ASPxGridViewDetalleVariablesPrograma_BeforePerformDataSelect">
                        <Columns>
                            <dx:GridViewDataTextColumn FieldName="IdDetalleVariablePrograma" ReadOnly="True" VisibleIndex="0" Caption="ID">
                                <EditFormSettings Visible="False"></EditFormSettings>
                            </dx:GridViewDataTextColumn>
                            <dx:GridViewDataTextColumn FieldName="IdVariablePrograma" VisibleIndex="1" Visible="false" Caption="ID"></dx:GridViewDataTextColumn>
                            <dx:GridViewDataTextColumn FieldName="NombreDetalle" VisibleIndex="2" Settings-AutoFilterCondition="Contains"></dx:GridViewDataTextColumn>
                            <dx:GridViewDataTextColumn FieldName="CreadoPor" VisibleIndex="3" Visible="false"></dx:GridViewDataTextColumn>
                            <dx:GridViewDataDateColumn FieldName="FechaCreacion" VisibleIndex="4" Visible="false"></dx:GridViewDataDateColumn>
                            <dx:GridViewDataTextColumn FieldName="ActualizadoPor" VisibleIndex="5" Visible="false"></dx:GridViewDataTextColumn>
                            <dx:GridViewDataDateColumn FieldName="FechaActualizacion" VisibleIndex="6" Visible="false"></dx:GridViewDataDateColumn>
                            <dx:GridViewDataCheckColumn FieldName="Activo" VisibleIndex="7" Visible="false"></dx:GridViewDataCheckColumn>
                            <dx:GridViewCommandColumn>
                                <NewButton Visible="true"></NewButton>
                                <EditButton Visible="true"></EditButton>
                                <DeleteButton Visible="true"></DeleteButton>
                            </dx:GridViewCommandColumn>
                        </Columns>
                        <SettingsPager>
                            <AllButton Visible="True" Text="Todos">
                            </AllButton>
                        </SettingsPager>
                        <SettingsDetail ShowDetailRow="true" ShowDetailButtons="true" />
                        <Templates>
                            <DetailRow>
                                <dx:ASPxGridView ID="ASPxGridViewValoresDetallePrograma" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSourceValoresDetallePrograma" KeyFieldName="IdValorVariablePrograma" Settings-ShowFilterRow="true" OnBeforePerformDataSelect="ASPxGridViewValoresDetallePrograma_BeforePerformDataSelect">
                                    <Columns>
                                        <dx:GridViewDataTextColumn FieldName="IdValorVariablePrograma" ReadOnly="True" VisibleIndex="0" Caption="ID">
                                            <EditFormSettings Visible="False"></EditFormSettings>
                                        </dx:GridViewDataTextColumn>
                                        <dx:GridViewDataTextColumn FieldName="IdDetalleVariablePrograma" VisibleIndex="1" Visible="false" Caption="ID"></dx:GridViewDataTextColumn>
                                        <dx:GridViewDataTextColumn FieldName="NombreValor" VisibleIndex="2" Settings-AutoFilterCondition="Contains" ></dx:GridViewDataTextColumn>
                                        <dx:GridViewDataTextColumn FieldName="Valor" VisibleIndex="3"></dx:GridViewDataTextColumn>
                                        <dx:GridViewDataTextColumn FieldName="CreadoPor" VisibleIndex="4" Visible="false"></dx:GridViewDataTextColumn>
                                        <dx:GridViewDataDateColumn FieldName="FechaCreacion" VisibleIndex="5" Visible="false"></dx:GridViewDataDateColumn>
                                        <dx:GridViewDataTextColumn FieldName="ActualizadoPor" VisibleIndex="6" Visible="false"></dx:GridViewDataTextColumn>
                                        <dx:GridViewDataDateColumn FieldName="FechaActualizacion" VisibleIndex="7" Visible="false"></dx:GridViewDataDateColumn>
                                        <dx:GridViewDataCheckColumn FieldName="Activo" VisibleIndex="8" Visible="false"></dx:GridViewDataCheckColumn>
                                        <dx:GridViewCommandColumn>
                                            <NewButton Visible="true"></NewButton>
                                            <EditButton Visible="true"></EditButton>
                                            <DeleteButton Visible="true"></DeleteButton>
                                        </dx:GridViewCommandColumn>
                                    </Columns>
                                     <SettingsPager>
                                        <AllButton Visible="True" Text="Todos">
                                        </AllButton>
                                    </SettingsPager>
                                </dx:ASPxGridView>
                                
                            </DetailRow>
                        </Templates>
                    </dx:ASPxGridView>
                    
                </DetailRow>
            </Templates>
        </dx:ASPxGridView>
        <asp:SqlDataSource runat="server" ID="SqlDataSourceVariablesPrograma" ConnectionString='<%$ ConnectionStrings:SUEPPSConnectionString %>' 
            SelectCommand="SELECT * FROM [VariablesPrograma] WHERE [Activo]=1">

        </asp:SqlDataSource>
    
        <asp:SqlDataSource runat="server" ID="SqlDataSourceVariable" ConnectionString='<%$ ConnectionStrings:SUEPPSConnectionString %>'
            SelectCommand="SELECT IdVariable, NombreVariable FROM [Variables]"></asp:SqlDataSource>
        
        <asp:SqlDataSource runat="server" ID="SqlDataSourceDetalleVariablesPrograma" ConnectionString='<%$ ConnectionStrings:SUEPPSConnectionString %>' 
            SelectCommand="SELECT * FROM [DetallesVariablePrograma] WHERE [Activo] = 1 AND [IdVariablePrograma]=@IdVariablePrograma">
            <SelectParameters>
                <asp:SessionParameter SessionField="IdVariablePrograma" Name="IdVariablePrograma" Type="Int32" />
            </SelectParameters>
            <InsertParameters>
                <asp:SessionParameter SessionField="IdVariablePrograma" Name="IdVariablePrograma" Type="Int32" />
                <asp:FormParameter Name="NombreDetalle" />
            </InsertParameters>
        </asp:SqlDataSource>

        <asp:SqlDataSource runat="server" ID="SqlDataSourceValoresDetallePrograma" ConnectionString='<%$ ConnectionStrings:SUEPPSConnectionString %>' 
            SelectCommand="SELECT * FROM [ValoresDetallePrograma] WHERE [Activo] = 1 AND [IdDetalleVariablePrograma]=@IdDetalleVariablePrograma">
            <SelectParameters>
                <asp:SessionParameter SessionField="IdDetalleVariablePrograma" Name="IdDetalleVariablePrograma" Type="Int32" />
            </SelectParameters>
            <InsertParameters>
                <asp:SessionParameter SessionField="IdDetalleVariablePrograma" Name="IdDetalleVariablePrograma" Type="Int32" />
                <asp:FormParameter Name="NombreValor" />
                <asp:FormParameter Name="Valor" />
            </InsertParameters>
        </asp:SqlDataSource>
    </div>
</asp:Content>
