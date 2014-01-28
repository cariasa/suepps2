<%@ Page Title="Definición Valores Oficiales" Language="VB" AutoEventWireup="false" CodeFile="ValoresMacro.aspx.vb" Inherits="Evaluacion_ValoresMacro" MasterPageFile="~/Site.master" %>

<%@ Register Src="~/MOCA_UE.ascx" TagPrefix="uc1" TagName="MOCA_UE" %>

<asp:Content ID="cHeader" ContentPlaceHolderID="HeadContent" runat="Server">
</asp:Content>
<asp:Content ID="cBody" ContentPlaceHolderID="MainContent" runat="Server">
    <uc1:MOCA_UE runat="server" ID="MOCA_UE01" />
    <div>
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
        </div>

        <dx:ASPxGridView ID="ASPxGridViewValoresMacro" runat="server" AutoGenerateColumns="False" SettingsEditing-EditFormColumnCount="1" SettingsEditing-Mode="EditFormAndDisplayRow" DataSourceID="SqlDataSourceVariablesMacro" KeyFieldName="IdVariableMacro" Settings-ShowFilterRow="true">
            <Columns>
                <dx:GridViewDataTextColumn FieldName="IdVariableMacro" ReadOnly="True" VisibleIndex="0" Caption="ID">
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
                <dx:GridViewDataTextColumn FieldName="Fuente" VisibleIndex="3"></dx:GridViewDataTextColumn>
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
                    <dx:ASPxGridView ID="ASPxGridViewDetallesVariablesMacro" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSourceDetallesVariablesMacro" KeyFieldName="IdDetalleVariableMacro" OnBeforePerformDataSelect="ASPxGridViewDetallesVariablesMacro_BeforePerformDataSelect" Settings-ShowFilterRow="true">
                        <Columns>
                            <dx:GridViewDataTextColumn FieldName="IdDetalleVariableMacro" ReadOnly="True" VisibleIndex="0" Visible="false">
                                <EditFormSettings Visible="False"></EditFormSettings>
                            </dx:GridViewDataTextColumn>
                            <dx:GridViewDataTextColumn FieldName="IdVariableMacro" VisibleIndex="1" Visible="false"></dx:GridViewDataTextColumn>
                            <dx:GridViewDataTextColumn FieldName="NombreDetalle" VisibleIndex="2" Caption="Detalle"></dx:GridViewDataTextColumn>
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
                                <%-- Grid para Valores Detalle Macro --%>
                                <dx:ASPxGridView ID="ASPxGridViewValoresDetalleMacro" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSourceValoresDetalleMacro" KeyFieldName="IdValorVariableMacro" OnBeforePerformDataSelect="ASPxGridViewValoresDetalleMacro_BeforePerformDataSelect" Settings-ShowFilterRow="true">
                                    <Columns>
                                        <dx:GridViewDataTextColumn FieldName="IdValorVariableMacro" ReadOnly="True" VisibleIndex="0" Visible="false">
                                            <EditFormSettings Visible="False"></EditFormSettings>
                                        </dx:GridViewDataTextColumn>
                                        <dx:GridViewDataTextColumn FieldName="IdDetalleVariableMacro" VisibleIndex="1" Visible="false"></dx:GridViewDataTextColumn>
                                        <dx:GridViewDataTextColumn FieldName="NombreValor" VisibleIndex="2" Caption="Nombre Agregado"></dx:GridViewDataTextColumn>
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
                                <%-- Fin Valores Detalle Macro --%>
                            </DetailRow>
                        </Templates>

                    </dx:ASPxGridView>

                </DetailRow>
            </Templates>


        </dx:ASPxGridView>

        <asp:SqlDataSource runat="server" ID="SqlDataSourceValoresDetalleMacro" ConnectionString='<%$ ConnectionStrings:SUEPPSConnectionString %>'
            SelectCommand="SELECT * FROM [ValoresDetalleMacro] WHERE [IdDetalleVariableMacro]=@IdDetalleVariableMacro AND [Activo]=1"
            
            
            >
            <SelectParameters>
                <asp:SessionParameter SessionField="IdDetalleVariableMacro" Name="IdDetalleVariableMacro" Type="Int32"></asp:SessionParameter>
            </SelectParameters>
            <InsertParameters>
                <asp:SessionParameter SessionField="IdDetalleVariableMacro" Name="IdDetalleVariableMacro" Type="Int32"></asp:SessionParameter>
                <asp:FormParameter Name="NombreValor" />
                <asp:FormParameter Name="Valor" />
            </InsertParameters>
        </asp:SqlDataSource>

        <asp:SqlDataSource runat="server" ID="SqlDataSourceDetallesVariablesMacro" ConnectionString='<%$ ConnectionStrings:SUEPPSConnectionString %>'
            SelectCommand="SELECT * FROM [DetallesVariableMacro] WHERE [IdVariableMacro]=@IdVariableMacro AND [Activo]=1"
            >
            <SelectParameters>
                <asp:SessionParameter SessionField="IdVariableMacro" Name="IdVariableMacro" Type="Int32"></asp:SessionParameter>

            </SelectParameters>
            <InsertParameters>
                <asp:SessionParameter SessionField="IdVariableMacro" Name="IdVariableMacro" Type="Int32"></asp:SessionParameter>
                <asp:FormParameter Name="NombreDetalle" />
            </InsertParameters>
        </asp:SqlDataSource>

        <asp:SqlDataSource runat="server" ID="SqlDataSourceVariablesMacro" ConnectionString='<%$ ConnectionStrings:SUEPPSConnectionString %>' OnUpdated="SqlDataSourceVariablesMacro_Updated" OnDeleted="SqlDataSourceVariablesMacro_Deleted"
            
            ></asp:SqlDataSource>

        <asp:SqlDataSource runat="server" ID="SqlDataSourceVariable" ConnectionString='<%$ ConnectionStrings:SUEPPSConnectionString %>'
            SelectCommand="SELECT IdVariable, NombreVariable FROM [Variables]"></asp:SqlDataSource>
    </div>
</asp:Content>
