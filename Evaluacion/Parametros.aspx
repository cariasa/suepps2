<%@ Page Language="VB" AutoEventWireup="false" CodeFile="Parametros.aspx.vb" Inherits="Evaluacion_Parametros" MasterPageFile="~/Site.master" %>


<%@ Register Src="~/MOCA_UE.ascx" TagPrefix="uc1" TagName="MOCA_UE" %>

<asp:Content ID="cHeader" ContentPlaceHolderID="HeadContent" Runat="Server">
</asp:Content>
<asp:Content ID="cBody" ContentPlaceHolderID="MainContent" Runat="Server">
    <uc1:MOCA_UE runat="server" ID="MOCA_UE01" />

    <div>
        <dx:ASPxPageControl ID="carTabPage" runat="server" ActiveTabIndex="0" EnableHierarchyRecreation="True" Height="250">

        <ClientSideEvents ActiveTabChanged="function (s,e) {click(e);}" />
    
    <TabPages>
<%-- ######################################################################################################################################################################################### --%>
        <dx:TabPage Text="Definir Variables">
        <ContentCollection>
            <dx:ContentControl>
                <dx:ASPxGridView ID="ASPxGridViewDefinicionVariables" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSourceSUEPPS" KeyFieldName="IdVariable" SettingsBehavior-AllowFocusedRow="true" Settings-ShowFilterRow="true"
                    >
                <Columns>
                    <dx:GridViewDataTextColumn FieldName="IdVariable" ReadOnly="True" VisibleIndex="0" Visible="false">
                        <EditFormSettings Visible="False"></EditFormSettings>
                    </dx:GridViewDataTextColumn>
                    <dx:GridViewDataTextColumn FieldName="NombreVariable" VisibleIndex="1" Caption="Nombre"><Settings AutoFilterCondition="Contains" /></dx:GridViewDataTextColumn>
                    <dx:GridViewDataTextColumn FieldName="Descripcion" VisibleIndex="2"><Settings AutoFilterCondition="Contains" /></dx:GridViewDataTextColumn>
                    <dx:GridViewDataTextColumn FieldName="Unidad" VisibleIndex="3"><Settings AutoFilterCondition="Contains" /></dx:GridViewDataTextColumn>
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
                    <dx:GridViewDataTextColumn FieldName="Acción" ShowInCustomizationForm="True" VisibleIndex="4" Caption="Acción" UnboundType="String" >
                        <DataItemTemplate>
                            <asp:LinkButton id="linkValoresMacro"  Text="Valores Oficiales" runat="server" OnClick="sendValoresMacro" /> <br />
                            <asp:LinkButton ID="linkCondiciones" Text="Condiciones" runat="server" OnClick="linkCondiciones_Click"></asp:LinkButton>
                        </DataItemTemplate>
                            <Settings AllowAutoFilter="False" /> 
                            <EditFormSettings Visible="False"></EditFormSettings> 
                    </dx:GridViewDataTextColumn>
                </Columns>
                    <SettingsPager>
                <AllButton Visible="True" Text="Todos">
                </AllButton>
            </SettingsPager>
            </dx:ASPxGridView>
            <asp:SqlDataSource runat="server" ID="SqlDataSourceSUEPPS" ConnectionString='<%$ ConnectionStrings:SUEPPSConnectionString %>' OnInserted="SqlDataSourceSUEPPS_Inserted" OnUpdated="SqlDataSourceSUEPPS_Updated" OnDeleted="SqlDataSourceSUEPPS_Deleted"
                SelectCommand="SELECT [IdVariable], [NombreVariable], [Descripcion], [Unidad], [CreadoPor], [FechaCreacion], [ActualizadoPor], [FechaActualizacion], [Activo] FROM [Variables] ORDER BY  [FechaCreacion]"
                InsertCommand="INSERT INTO [Variables] ([NombreVariable], [Descripcion], [Unidad], [CreadoPor], [FechaCreacion]) VALUES (@NombreVariable, @Descripcion, @Unidad, 'SUEPPS', getDate())"
                UpdateCommand="UPDATE [Variables] SET [NombreVariable]=@NombreVariable, [Descripcion]=@Descripcion, [Unidad]=@Unidad, [ActualizadoPor]='SUEPPS', [FechaActualizacion] =getDate() WHERE [IdVariable]=@IdVariable"
                DeleteCommand="UPDATE [Activo] = 0 WHERE [IdVariable]=IdVariable"
                >
            </asp:SqlDataSource>
                </dx:ContentControl>
            </ContentCollection>
        </dx:TabPage>

<%-- ######################################################################################################################################################################################### --%>
    <dx:TabPage Text="Fórmula Indicadores">
        <ContentCollection>
            <dx:ContentControl>
                <table>
                <tr>
                    <td>
                        <%-- Grid Indicadores --%>
                        <dx:ASPxGridView ID="ASPxGridViewIndicadores" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSourceIndicadores" KeyFieldName="IdIndicador" SettingsBehavior-AllowFocusedRow="true" Settings-ShowFilterRow="true">
                            <Columns>
                                <dx:GridViewDataTextColumn FieldName="IdIndicador" ReadOnly="True" VisibleIndex="0" Visible="false">
                                    <EditFormSettings Visible="False"></EditFormSettings>
                                </dx:GridViewDataTextColumn>
                                <dx:GridViewDataTextColumn FieldName="IdSectorIndicador" VisibleIndex="1" Caption="Sector"></dx:GridViewDataTextColumn>
                                

                                <dx:GridViewDataComboBoxColumn VisibleIndex="2" FieldName="IdTipoDeIndicador" Caption="Tipo Indicador">
                                    <PropertiesComboBox ValueType="System.String" 
                
                                        DataSourceID="SqlDataSourceTipoIndicadores" 
                                        ValueField="IdTipoDeIndicador" 
                                        TextField="DescripcionTipoDeIndicador"/>
                                     <Settings AllowAutoFilter="True" />
                                                <Settings AutoFilterCondition="Contains" />
                                                <Settings FilterMode="DisplayText" />
     
                    
                                </dx:GridViewDataComboBoxColumn>

                                <dx:GridViewDataTextColumn FieldName="DescripcionIndicador" VisibleIndex="3" Caption="Indicador"><Settings AutoFilterCondition="Contains" /></dx:GridViewDataTextColumn>
                                <dx:GridViewDataTextColumn FieldName="Acción" ShowInCustomizationForm="True" VisibleIndex="4" Caption="Acción" UnboundType="String">
                                    <DataItemTemplate>
                                        <asp:LinkButton ID="linkElegir" Text="Elegir" runat="server" OnClick="linkElegir_Click" />
                                        <br />

                                    </DataItemTemplate>
                                    <Settings AllowAutoFilter="False" />
                                </dx:GridViewDataTextColumn>
                            </Columns>
                        </dx:ASPxGridView>

                        <asp:SqlDataSource runat="server" ID="SqlDataSourceIndicadores" ConnectionString='<%$ ConnectionStrings:SUEPPSConnectionString %>' SelectCommand="SELECT [IdIndicador], [IdSectorIndicador], [IdTipoDeIndicador], [DescripcionIndicador] FROM [Indicadores] WHERE IdTipoDeIndicador <> 1 AND IdTipoDeIndicador <> 2"></asp:SqlDataSource>
                    </td>
                    <td>
                        <dx:ASPxLabel Text="Posición" runat="server"></dx:ASPxLabel>
                        <dx:ASPxComboBox ID="ASPxComboBoxPosicion" runat="server" ValueType="System.String">
                            <Items>
                                <dx:ListEditItem Text="Numerador" Value="0" />
                                <dx:ListEditItem Text="Denominador" Value="1" />
                            </Items>
                        </dx:ASPxComboBox>
                    </td>
                    <td>
                        <dx:ASPxGridView ID="ASPxGridViewVariables" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSourceVariables" KeyFieldName="IdVariable" SettingsBehavior-AllowFocusedRow="true" Settings-ShowFilterRow="true">
                            <Columns>
                                <dx:GridViewDataTextColumn FieldName="IdVariable" ReadOnly="True" VisibleIndex="0" Caption="ID">
                                    <EditFormSettings Visible="False"></EditFormSettings>
                                </dx:GridViewDataTextColumn>
                                <dx:GridViewDataTextColumn FieldName="NombreVariable" VisibleIndex="1" Caption="Nombre"><Settings AutoFilterCondition="Contains" /></dx:GridViewDataTextColumn>
                                <dx:GridViewDataTextColumn FieldName="Descripcion" VisibleIndex="2"><Settings AutoFilterCondition="Contains" /></dx:GridViewDataTextColumn>
                                <dx:GridViewDataTextColumn FieldName="Acción" ShowInCustomizationForm="True" VisibleIndex="4" Caption="Acción" UnboundType="String">
                                    <DataItemTemplate>
                                        <asp:LinkButton ID="linkElegirVariable" Text="Elegir" runat="server" OnClick="linkElegirVariable_Click" />
                                        <br />

                                    </DataItemTemplate>
                                    <Settings AllowAutoFilter="False" />
                                </dx:GridViewDataTextColumn>
                            </Columns>
                        </dx:ASPxGridView>
                        <asp:SqlDataSource runat="server" ID="SqlDataSourceVariables" ConnectionString='<%$ ConnectionStrings:SUEPPSConnectionString %>' SelectCommand="SELECT [IdVariable], [NombreVariable], [Descripcion] FROM [Variables]"></asp:SqlDataSource>
                    </td>
                </tr>
                </table>
            <div style="border:double">
            <table >
                <tr>
                    <td>
                    <dx:ASPxTextBox ID="ASPxTextBoxIndicador" runat="server" Width="370px" ReadOnly="true"></dx:ASPxTextBox></td>
                    <td><dx:ASPxLabel ID="ASPxLabelIgual" runat="server" Text="=" ></dx:ASPxLabel></td>
                    <td><dx:ASPxTextBox ID="ASPxTextBoxNumerador" runat="server" Width="170px" ReadOnly="true"></dx:ASPxTextBox></td>
                    <td><dx:ASPxLabel ID="ASPxLabelPor" runat="server" Text="X"></dx:ASPxLabel></td>
                    <td><dx:ASPxTextBox ID="ASPxTextBoxFactor" runat="server" Width="170px"></dx:ASPxTextBox></td>
                    <td><dx:ASPxCheckBox ID="ASPxCheckBoxUsarVMacroN" runat="server" Text="Usar V.Macro"></dx:ASPxCheckBox></td>

                </tr>
                <tr>
                    <td><dx:ASPxTextBox ID="ASPxTextBox1" runat="server" Width="170px" Visible="false"></dx:ASPxTextBox></td>
                    <td><dx:ASPxLabel ID="ASPxLabel1" runat="server" Text="ASPxLabel" Visible="false"></dx:ASPxLabel></td>
                    <td><dx:ASPxTextBox ID="ASPxTextBoxDenominador" runat="server" Width="170px" ReadOnly="true"></dx:ASPxTextBox></td>
                    <td>
                        <dx:ASPxLabel ID="ASPxLabel2" runat="server" Text="ASPxLabel" Visible="false"></dx:ASPxLabel>
                    </td>
                    <td>
                        <dx:ASPxTextBox ID="ASPxTextBox2" runat="server" Width="170px" Visible="false"></dx:ASPxTextBox>
                    </td>
                    <td>
                        <dx:ASPxCheckBox ID="ASPxCheckBoxUsarVMacroD" runat="server" Text="Usar V.Macro"></dx:ASPxCheckBox>
                    </td>
                </tr>
                
            </table>
            <table>
                <tr>
                    <td><dx:ASPxLabel ID="ASPxLabelDescripcion" runat="server" Text="Descripción"></dx:ASPxLabel></td>
                    <td><dx:ASPxTextBox ID="ASPxTextBoxDes" runat="server" Width="370px" ></dx:ASPxTextBox></td>
                    <td>
                        <dx:ASPxButton ID="ASPxButtonGuardar" runat="server" Text="Guardar" OnClick="ASPxButtonGuardar_Click"></dx:ASPxButton>
                        <dx:ASPxButton ID="ASPxButtonGuardarEditar" runat="server" Text="Guardar" OnClick="ASPxButtonGuardarEditar_Click" Visible="false"></dx:ASPxButton>
                    </td>
                </tr>
            </table>
            </div>
            <dx:ASPxGridView ID="ASPxGridViewFormulas" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSourceFormulas" KeyFieldName="IdFormulaIndicador" SettingsBehavior-AllowFocusedRow="true" Settings-ShowFilterRow="true" >
                <Columns>
                    <dx:GridViewDataTextColumn FieldName="IdFormulaIndicador" ReadOnly="True" VisibleIndex="0" Caption="ID">
                        <EditFormSettings Visible="False"></EditFormSettings>
                    </dx:GridViewDataTextColumn>
                    
                    <dx:GridViewDataComboBoxColumn VisibleIndex="1" FieldName="IdIndicador" Caption="Indicador">
                                    <PropertiesComboBox ValueType="System.String" 
                
                                        DataSourceID="SqlDataSourceIndicadoresCombo" 
                                        ValueField="IdIndicador" 
                                        TextField="DescripcionIndicador"/>
                                     <Settings AllowAutoFilter="True" />
                                                <Settings AutoFilterCondition="Contains" />
                                                <Settings FilterMode="DisplayText" />
     
                    
                    </dx:GridViewDataComboBoxColumn>

                    <dx:GridViewDataComboBoxColumn VisibleIndex="2" FieldName="IdVariableNumerador" Caption="Numerador">
                                    <PropertiesComboBox ValueType="System.String" 
                
                                        DataSourceID="SqlDataSourceVariablesCombo" 
                                        ValueField="IdVariable" 
                                        TextField="NombreVariable"/>
                                     <Settings AllowAutoFilter="True" />
                                                <Settings AutoFilterCondition="Contains" />
                                                <Settings FilterMode="DisplayText" />
     
                    
                     </dx:GridViewDataComboBoxColumn>


                    <dx:GridViewDataCheckColumn FieldName="UsaVariableMacroNumerador" VisibleIndex="3" Caption="Usa V. Macro"></dx:GridViewDataCheckColumn>
                    

                    <dx:GridViewDataComboBoxColumn VisibleIndex="4" FieldName="IdVariableDenominador" Caption="Denominador">
                                    <PropertiesComboBox ValueType="System.String" 
                
                                        DataSourceID="SqlDataSourceVariablesCombo" 
                                        ValueField="IdVariable" 
                                        TextField="NombreVariable"/>
                                     <Settings AllowAutoFilter="True" />
                                                <Settings AutoFilterCondition="Contains" />
                                                <Settings FilterMode="DisplayText" />
     
                    
                     </dx:GridViewDataComboBoxColumn>
                    <dx:GridViewDataCheckColumn FieldName="UsaVariableMacroDenominador" VisibleIndex="5" Caption="Usa V. Macro"></dx:GridViewDataCheckColumn>
                    <dx:GridViewDataTextColumn FieldName="Factor" VisibleIndex="6"></dx:GridViewDataTextColumn>
                    <dx:GridViewDataTextColumn FieldName="DescripcionFormula" VisibleIndex="7" Caption="Descripción"><Settings AutoFilterCondition="Contains" /></dx:GridViewDataTextColumn>
                    <dx:GridViewDataTextColumn FieldName="CreadoPor" VisibleIndex="8" Visible="false"></dx:GridViewDataTextColumn>
                    <dx:GridViewDataDateColumn FieldName="FechaCreacion" VisibleIndex="9" Visible="false"></dx:GridViewDataDateColumn>
                    <dx:GridViewDataTextColumn FieldName="ActualizadoPor" VisibleIndex="10" Visible="false"></dx:GridViewDataTextColumn>
                    <dx:GridViewDataDateColumn FieldName="FechaActualizacion" VisibleIndex="11" Visible="false"></dx:GridViewDataDateColumn>
                    <dx:GridViewDataCheckColumn FieldName="Activo" VisibleIndex="12" Visible="false"></dx:GridViewDataCheckColumn>
                    <dx:GridViewDataTextColumn FieldName="Acción" ShowInCustomizationForm="True" VisibleIndex="13" Caption="Acción" UnboundType="String">
                    <DataItemTemplate>
                        <asp:LinkButton ID="linkEditarFormula" runat="server" Text="Editar" OnClick="linkEditarFormula_Click"></asp:LinkButton>
                        <asp:LinkButton ID="linkEliminarFormula" runat="server" Text="Eliminar" OnClick="linkEliminarFormula_Click"></asp:LinkButton>
                    </DataItemTemplate>
                        <Settings AllowAutoFilter="False" />  
                </dx:GridViewDataTextColumn>
                </Columns>
                <SettingsPager>
                <AllButton Visible="True" Text="Todos">
                </AllButton>
            </SettingsPager>
            </dx:ASPxGridView>
            <asp:SqlDataSource runat="server" ID="SqlDataSourceFormulas" ConnectionString='<%$ ConnectionStrings:SUEPPSConnectionString %>' 
                SelectCommand="SELECT * FROM [FormulaIndicador] WHERE [Activo]=1">

            </asp:SqlDataSource>

            <asp:SqlDataSource runat="server" ID="SqlDataSourceTipoIndicadores" ConnectionString='<%$ ConnectionStrings:SUEPPSConnectionString %>' 
                SelectCommand="SELECT IdTipoDeIndicador, DescripcionTipoDeIndicador FROM [TiposDeIndicador]"></asp:SqlDataSource>

            <asp:SqlDataSource runat="server" ID="SqlDataSourceIndicadoresCombo" ConnectionString='<%$ ConnectionStrings:SUEPPSConnectionString %>' 
                SelectCommand="SELECT IdIndicador, DescripcionIndicador FROM [Indicadores]"></asp:SqlDataSource>

             <asp:SqlDataSource runat="server" ID="SqlDataSourceVariablesCombo" ConnectionString='<%$ ConnectionStrings:SUEPPSConnectionString %>' 
                SelectCommand="SELECT IdVariable, NombreVariable FROM [Variables]"></asp:SqlDataSource>

            </dx:ContentControl>
        </ContentCollection>
        </dx:TabPage>
<%-- ######################################################################################################################################################################################### --%>
    
    </TabPages>
    </dx:ASPxPageControl>
    </div>
 
    </asp:Content>