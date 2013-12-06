<%@ Page Language="VB" AutoEventWireup="false" CodeFile="ValoresMacro.aspx.vb" Inherits="Evaluacion_ValoresMacro" MasterPageFile="~/Site.master" %>

<%@ Register Src="~/MOCA_UE.ascx" TagPrefix="uc1" TagName="MOCA_UE" %>

<asp:Content ID="cHeader" ContentPlaceHolderID="HeadContent" Runat="Server">
</asp:Content>
<asp:Content ID="cBody" ContentPlaceHolderID="MainContent" Runat="Server">
    <uc1:MOCA_UE runat="server" ID="MOCA_UE01" />
    <div>
        <table>
            <tr>
                <dx:ASPxLabel ID="ASPxLabelVariable" runat="server" ></dx:ASPxLabel>
            </tr>
            <tr>
                <td>
                    <dx:ASPxLabel ID="ASPxLabelTitulo" runat="server" Text="Asociación de Instrumento AVANZADO" ></dx:ASPxLabel>
                </td>
                <td>
                    <dx:ASPxLabel ID="espacio" runat="server" Text=" " Width="280"></dx:ASPxLabel>
                    <dx:ASPxHyperLink ID="ASPxHyperLinkRegresar" runat="server" Text="Atras" NavigateUrl="Parametros.aspx">
                    </dx:ASPxHyperLink>
                </td>
            </tr>
        </table>
        <dx:ASPxGridView ID="ASPxGridViewValoresMacro" runat="server" AutoGenerateColumns="False" SettingsEditing-EditFormColumnCount="1" SettingsEditing-Mode="EditFormAndDisplayRow" DataSourceID="SqlDataSourceVariablesMacro" KeyFieldName="IdVariableMacro">
            <Columns>
                <dx:GridViewDataTextColumn FieldName="IdVariableMacro" ReadOnly="True" VisibleIndex="0">
                    <EditFormSettings Visible="False"></EditFormSettings>
                </dx:GridViewDataTextColumn>
                
                <dx:GridViewDataComboBoxColumn VisibleIndex="1" FieldName="IdVariable" Caption="Variable" EditFormSettings-Visible="False">
                        <PropertiesComboBox ValueType="System.String" 
                
                            DataSourceID="SqlDataSourceVariable" 
                            ValueField="IdVariable" 
                            TextField="NombreVariable"/>
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
            <SettingsDetail ShowDetailRow="true" ShowDetailButtons="true"/>
            <Templates>
            <DetailRow>
                <dx:ASPxGridView ID="ASPxGridViewDetallesVariablesMacro" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSourceDetallesVariablesMacro" KeyFieldName="IdDetalleVariableMacro" OnBeforePerformDataSelect="ASPxGridViewDetallesVariablesMacro_BeforePerformDataSelect" >
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
                    <SettingsDetail  ShowDetailRow="true" ShowDetailButtons="true"/>
                    <Templates>
                        <DetailRow>
                            <%-- Grid para Valores Detalle Macro --%>
                            <dx:ASPxGridView ID="ASPxGridViewValoresDetalleMacro" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSourceValoresDetalleMacro" KeyFieldName="IdValorVariableMacro" OnBeforePerformDataSelect="ASPxGridViewValoresDetalleMacro_BeforePerformDataSelect" >
                                <Columns>
                                    <dx:GridViewDataTextColumn FieldName="IdValorVariableMacro" ReadOnly="True" VisibleIndex="0" Visible="false">
                                        <EditFormSettings Visible="False"></EditFormSettings>
                                    </dx:GridViewDataTextColumn>
                                    <dx:GridViewDataTextColumn FieldName="IdDetalleVariableMacro" VisibleIndex="1" Visible="false"></dx:GridViewDataTextColumn>
                                    <dx:GridViewDataTextColumn FieldName="NombreValor" VisibleIndex="2" Caption="NombreAgregado"></dx:GridViewDataTextColumn>
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
             InsertCommand="INSERT INTO [ValoresDetalleMacro] ([IdDetalleVariableMacro], [NombreValor], [Valor], [CreadoPor], [FechaCreacion]) VALUES (@IdDetalleVariableMacro, @NombreValor, @Valor, 'SUEPPS', getDate())" 
             UpdateCommand="UPDATE [ValoresDetalleMacro] SET [NombreValor]=@NombreValor, [Valor]=@Valor, [ActualizadoPor]='SUEPPS', [FechaActualizacion]=getDate() WHERE IdValorVariableMacro=@IdValorVariableMacro"
             DeleteCommand="UPDATE [ValoresDetalleMacro] SET [Activo]=0 WHERE IdValorVariableMacro=@IdValorVariableMacro">
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
            InsertCommand="INSERT INTO [DetallesVariableMacro] ([IdVariableMacro], [NombreDetalle], [CreadoPor], [FechaCreacion]) VALUES (@IdVariableMacro, @NombreDetalle, 'SUEPPS', getDate())"
            UpdateCommand="UPDATE [DetallesVariableMacro] SET [NombreDetalle]=@NombreDetalle, ActualizadoPor='SUEPPS', FechaActualizacion=getDate() WHERE IdDetalleVariableMacro=@IdDetalleVariableMacro"
            DeleteCommand="UPDATE [DetallesVariableMacro] SET [Activo]=0 WHERE IdDetalleVariableMacro=@IdDetalleVariableMacro"
            >
            <SelectParameters>
               <asp:SessionParameter SessionField="IdVariableMacro" Name="IdVariableMacro" Type="Int32"></asp:SessionParameter>
                
            </SelectParameters>
            <InsertParameters>
                <asp:SessionParameter SessionField="IdVariableMacro" Name="IdVariableMacro" Type="Int32"></asp:SessionParameter>
                <asp:FormParameter Name="NombreDetalle" />
            </InsertParameters>
        </asp:SqlDataSource>

        <asp:SqlDataSource runat="server" ID="SqlDataSourceVariablesMacro" ConnectionString='<%$ ConnectionStrings:SUEPPSConnectionString %>'  OnUpdated="SqlDataSourceVariablesMacro_Updated" OnDeleted="SqlDataSourceVariablesMacro_Deleted" 
            SelectCommand="SELECT * FROM [VariablesMacro] WHERE [Activo]=1"
            UpdateCommand="UPDATE [VariablesMacro] SET [Valor]=@Valor, [Fuente]=@Fuente, [Fecha]=@Fecha, [ActualizadoPor]='SUEPPS', FechaActualizacion=getDate() WHERE [IdVariableMacro]=@IdVariableMacro"
            DeleteCommand="UPDATE [VariablesMacro] SET [Activo]=0 WHERE [IdVariableMacro]=@IdVariableMacro"
        >
        </asp:SqlDataSource>

        <asp:SqlDataSource runat="server" ID="SqlDataSourceVariable" ConnectionString='<%$ ConnectionStrings:SUEPPSConnectionString %>'
            SelectCommand="SELECT IdVariable, NombreVariable FROM [Variables]">

        </asp:SqlDataSource>
    </div>
 </asp:Content>
