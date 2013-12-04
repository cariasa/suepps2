<%@ Page Language="VB" AutoEventWireup="false" CodeFile="Analizar.aspx.vb" Inherits="Consultas_Analizar"  MasterPageFile="~/Site.master"%>

<%@ Register Src="~/MOCA_UE.ascx" TagPrefix="uc1" TagName="MOCA_UE" %>


<asp:Content ID="cHeader" ContentPlaceHolderID="HeadContent" Runat="Server">
</asp:Content>
<asp:Content ID="cBody" ContentPlaceHolderID="MainContent" Runat="Server">
    <uc1:MOCA_UE runat="server" ID="MOCA_UE01" />

        <script type="text/javascript">
                                                    
            function Load(cmbAno) {
                GridIndicadores.PerformCallback();
            }

            function Load2(cmbAnoI) {
                GridIndicadoresI.PerformCallback();
            }

            function LoadP(cmbAnoP) {
                GridPresupuesto.PerformCallback();
            }

            function LoadC(cmbAnoC) {
                GridCobertura.PerformCallback();
            }




            function LoadCualitativo(cmbAnoCualitativo) {
                GridPreguntaRespuesta.PerformCallback();
            }
           

        </script>

    <div>

        <div>

       <dx:ASPxLabel runat="server" Text="0" ID="CodPrograma"  Visible="false"/>
        <p></p>
       <dx:ASPxLabel runat="server" Text=" " ID="Programa" />
        <p></p>
       </div>

        <dx:ASPxPageControl ID="ASPxPageControl1" runat="server" RenderMode="Lightweight" ActiveTabIndex="0" Width="100%">
            <TabPages>

<%-- ######################################################################################################################################################################################### --%>

                <dx:TabPage  Text="Características">
                    <ContentCollection>
                        <dx:ContentControl>
                            <div>
        

        <table>
        <tr>
            <td><dx:ASPxLabel ID="ASPxLabel2" runat="server" Text="Programa:" style="font-weight: 700"></dx:ASPxLabel></td>
            <td><dx:ASPxLabel ID="ASPxLabelPrograma" runat="server"></dx:ASPxLabel></td>
                
        </tr>
        <tr>
            <td><dx:ASPxLabel ID="ASPxLabel3" runat="server" Text="Objetivos del Programa:" style="font-weight: 700"></dx:ASPxLabel></td>
            <td><dx:ASPxLabel ID="ASPxLabelObjetivos" runat="server"></dx:ASPxLabel></td>

        </tr>
        <tr>
            <td><dx:ASPxLabel ID="ASPxLabel4" runat="server" Text="Beneficiarios:" style="font-weight: 700"></dx:ASPxLabel></td>
            <td><dx:ASPxLabel ID="ASPxLabelBeneficiarios" runat="server"></dx:ASPxLabel></td>

        </tr>

        </table>
        
        <%-- exporter --%>
        <dx:ASPxGridViewExporter ID="ASPxGridViewExporter3" runat="server"  ></dx:ASPxGridViewExporter>

        <dx:ASPxButton ID="ExportarCarateristica" runat="server" Text="Exportar" OnClick="ExportarCarateristica_Click"></dx:ASPxButton>
        <%-- exporter --%>

        <dx:ASPxGridView ID="ASPxGridViewCategoriasIndicadorCobertura" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSourceCategoriasIndicadoresCobertura"
         KeyFieldName="IdCategoriaIndicadorCobertura" Width="100%"  >
        
        

            <Columns>
                <dx:GridViewDataTextColumn FieldName="IdCategoriaIndicadorCobertura" ReadOnly="True" VisibleIndex="0" Visible="false">
                    <EditFormSettings Visible="False"></EditFormSettings>
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="CategoriaIndicadorCobertura" VisibleIndex="1" Caption="Categoría Indicador de Cobertura"></dx:GridViewDataTextColumn>
            </Columns>
            <SettingsDetail ShowDetailRow="True" ExportMode="All" />
            <Templates>
            <DetailRow>
                <dx:ASPxGridView ID="ASPxGridViewIndicadoresCobertura" runat="server" DataSourceID="SqlDataSourceIndicadoresCobertura" AutoGenerateColumns="False"
                IsDetailGrid="true" OnBeforePerformDataSelect="ASPxGridViewIndicadoresCobertura_BeforePerformDataSelect" KeyFieldName="IdIndicadoresPorPrograma">
                <Columns>
                    <dx:GridViewDataTextColumn FieldName="IdIndicadoresPorPrograma" ReadOnly="True" VisibleIndex="0" Visible="false">
                        <EditFormSettings Visible="False"></EditFormSettings>
                    </dx:GridViewDataTextColumn>
                    
                    <dx:GridViewDataComboBoxColumn VisibleIndex="1" FieldName="IdIndicador" Caption="Indicador">
                        <PropertiesComboBox ValueType="System.String"
                              DataSourceID="SqlDataSourceIndicadores"
                              ValueField="IdIndicador"
                              TextField="DescripcionIndicador" />


                    </dx:GridViewDataComboBoxColumn>

                    
                    <dx:GridViewDataComboBoxColumn VisibleIndex="2" FieldName="IdPrograma" Caption="Programa" Visible="false">
                        <PropertiesComboBox ValueType="System.String"
                              DataSourceID="SqlDataSourceProgramas"
                              ValueField="IdPrograma"
                              TextField="NombreProyecto" />


                    </dx:GridViewDataComboBoxColumn>

                    <dx:GridViewDataTextColumn FieldName="Activo" VisibleIndex="3" Visible="false"></dx:GridViewDataTextColumn>
                    <dx:GridViewDataTextColumn FieldName="IdCategoriaIndicadorCobertura" VisibleIndex="4" Visible="false"></dx:GridViewDataTextColumn>
                     <dx:GridViewDataTextColumn FieldName="suma" VisibleIndex="5" Visible="true"></dx:GridViewDataTextColumn>
                </Columns>
               
        </dx:ASPxGridView>


            </DetailRow>
            </Templates>
        </dx:ASPxGridView>

        

        <asp:SqlDataSource runat="server" ID="SqlDataSourceIndicadoresCobertura" ConnectionString='<%$ ConnectionStrings:SUEPPSConnectionString %>' >
            
            <SelectParameters>
                
                <asp:SessionParameter SessionField="IdCategoriaIndicadorCobertura" Name="IdCategoriaIndicadorCobertura" Type="Int32"></asp:SessionParameter>        
            </SelectParameters>
        </asp:SqlDataSource>
        
        <asp:SqlDataSource runat="server" ID="SqlDataSourceCategoriasIndicadoresCobertura" ConnectionString='<%$ ConnectionStrings:SUEPPSConnectionString %>' 
            SelectCommand="SELECT * FROM [CategoriaIndicadorCobertura]">
            

        </asp:SqlDataSource>

        <asp:SqlDataSource ID="SqlDataSourceIndicadores" runat="server" ConnectionString='<%$ ConnectionStrings:SUEPPSConnectionString %>' SelectCommand="SELECT [IdIndicador], [DescripcionIndicador] FROM [Indicadores]"></asp:SqlDataSource>
        <asp:SqlDataSource ID="SqlDataSourceProgramas" runat="server" ConnectionString='<%$ ConnectionStrings:SUEPPSConnectionString %>' SelectCommand="SELECT [IdPrograma], [NombreProyecto] FROM [vPrograma]"></asp:SqlDataSource>
    </div>
                        </dx:ContentControl>
                    </ContentCollection>
                </dx:TabPage>

<%-- ######################################################################################################################################################################################### --%>

                <dx:TabPage  Text="Cobertura">
                    <ContentCollection>
                        <dx:ContentControl>
                            
                            <table>
                                <tr>
                                    <td>
                                         <dx:ASPxLabel ID="lblAnoC" runat="server" Text="Año:" AssociatedControlID="cmbAnoC"></dx:ASPxLabel>
                           
                                    </td>
                                    <td>
                                        <dx:ASPxComboBox ID="cmbAnoC"  ClientInstanceName="cmbAnoC" runat="server" ValueType="System.String" DataSourceID="SqlAno"  ValueField="Ano"  TextField="Ano">
                                          <ClientSideEvents SelectedIndexChanged="function(s, e) {LoadC(); }" />                 
                                        </dx:ASPxComboBox>
                                    </td>

                                   
                                    <td>
                                         <dx:ASPxButton ID="ExportarCobertura" runat="server" Text="Exportar" OnClick="ExportarCobertura_Click"  ></dx:ASPxButton>

                                    </td>
                                </tr>
                            </table>


                             <dx:ASPxGridView ID="GridCobertura" ClientInstanceName="GridCobertura" runat="server" AutoGenerateColumns="False" OnCustomCallback="GridCobertura_CustomCallback" DataSourceID="SqlCobertura" 
                                  ShowDetailRow="true" SettingsBehavior-AllowFocusedRow="true" SettingsDetail-AllowOnlyOneMasterRowExpanded="true" Width="100%" SettingsDetail-ExportMode="All" KeyFieldName="DescripcionIndicador" Settings-ShowFilterRow="true" OnLoad="GridCobertura_Load1" Settings-ShowFilterRowMenu="true"
                              >
                      
                                <Columns>
                                    
                                     <dx:GridViewDataTextColumn FieldName="CategoriaIndicadorCobertura" Caption="Categoría" ShowInCustomizationForm="True" VisibleIndex="0">
                                    </dx:GridViewDataTextColumn>


                                    <dx:GridViewDataTextColumn FieldName="DescripcionIndicador" Caption="Indicador" ShowInCustomizationForm="True" VisibleIndex="0">
                                    </dx:GridViewDataTextColumn>

                                    <dx:GridViewDataTextColumn FieldName="UnidadIndicador" Caption="Unidad" ShowInCustomizationForm="True" VisibleIndex="0">
                                    <Settings AllowAutoFilter="False" />
                                    </dx:GridViewDataTextColumn>

                                    <dx:GridViewBandColumn Caption="Población">
                                       <Columns>
                                   
                                            <dx:GridViewDataTextColumn  FieldName="Potenciales"  Caption="Potencial" ShowInCustomizationForm="True" VisibleIndex="2">
                                             <Settings AllowAutoFilter="False" />
                                            </dx:GridViewDataTextColumn>
                                       </Columns>
                                        <Columns>
                            
                                            <dx:GridViewDataTextColumn FieldName="Monto2"   Caption="Objetivo" ShowInCustomizationForm="True" VisibleIndex="4">
                                            <Settings AllowAutoFilter="False" /> 
                                            </dx:GridViewDataTextColumn>
                                       </Columns>
                                        <Columns>
                                  
                                            <dx:GridViewDataTextColumn  FieldName="Monto3"  Caption="Atendida" ShowInCustomizationForm="True" VisibleIndex="6">
                                            <Settings AllowAutoFilter="False" /> 
                                            </dx:GridViewDataTextColumn>
                                       </Columns>
                                    </dx:GridViewBandColumn>

                                    </Columns>

                            <SettingsPager>
                       <AllButton Visible="True" Text="Todos">
                       </AllButton>

                    </SettingsPager>
                                  <SettingsDetail ShowDetailRow="True" ExportMode="All" />

                                <Templates>
                                    <DetailRow>

                                         <dx:ASPxGridView ID="GridDetalleIndicadorcobertura" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSource3"  KeyFieldName="IdAreaDeInfluencia"
                IsDetailGrid="true"  OnBeforePerformDataSelect="GridDetalleIndicadorcobertura_BeforePerformDataSelect" Visible="true" OnLoad="GridDetalleIndicadorcobertura_Load"
                Settings-ShowFooter="true" SettingsDetail-AllowOnlyOneMasterRowExpanded="true"   >

       

                 <Columns>

                    <dx:GridViewDataTextColumn FieldName="IdAreaDeInfluencia"  Caption="#" ShowInCustomizationForm="True" VisibleIndex="0"> </dx:GridViewDataTextColumn>
  

                    <dx:GridViewDataTextColumn FieldName="DescripcionAreaDeInfluencia"  Caption="Area de Influencia" ShowInCustomizationForm="True" VisibleIndex="1"> </dx:GridViewDataTextColumn>
  
                </Columns>

                <SettingsPager>
                       <AllButton Visible="True" Text="Todos">
                       </AllButton>
                    </SettingsPager>

                 <SettingsDetail ShowDetailRow="True" ExportMode="All"/>
                                        <Templates>
                                        <DetailRow>
                                        
                                            <dx:ASPxGridView ID="ASPxGridViewUbicacionAreaDeInfluencia" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSourceUbicacionArea" ClientInstanceName="ASPxGridViewUbicacionAreaDeInfluencia"
                                              KeyFieldName="IdUbicacionPorAreaDeInfluencia" OnBeforePerformDataSelect="ASPxGridViewUbicacionAreaDeInfluencia_BeforePerformDataSelect" IsDetailGrid="true">
                                                    <Columns>
                                                                  <dx:GridViewDataTextColumn FieldName="IdUbicacionPorAreaDeInfluencia" Caption="#" ReadOnly="True" VisibleIndex="0">
                                                                      <EditFormSettings Visible="False"></EditFormSettings>
                                                                  </dx:GridViewDataTextColumn>
                                                                  <dx:GridViewDataTextColumn FieldName="IdAreaDeInfluencia" Visible="false" VisibleIndex="1" ></dx:GridViewDataTextColumn>
                                                      
                                                                  <dx:GridViewDataComboBoxColumn VisibleIndex="2" FieldName="IdDepartamento" Caption="Departamento">
                                                                    <PropertiesComboBox ValueType="System.String" 
                
                                                                        DataSourceID="SqlDataSourceDepartamentos" 
                                                                        ValueField="IdDepartamento" 
                                                                        TextField="DescripcionDepartamento"/>
     
                    
                                                                  </dx:GridViewDataComboBoxColumn>
                                                      <dx:GridViewDataCheckColumn FieldName="EsTodoDepartamento" Visible="false" VisibleIndex="3"></dx:GridViewDataCheckColumn>
                                                      
                                                       <dx:GridViewDataComboBoxColumn VisibleIndex="4" FieldName="IdMunicipio" Caption="Municipio">
                                                        <PropertiesComboBox ValueType="System.String" 
                
                                                            DataSourceID="SqlDataSourceMunicipios" 
                                                            ValueField="IdMunicipio" 
                                                            TextField="DescripcionMunicipio"/>
     
                    
                                                      </dx:GridViewDataComboBoxColumn>
                                                      <dx:GridViewDataCheckColumn FieldName="EsTodoMunicipio" Visible="false" VisibleIndex="5" ></dx:GridViewDataCheckColumn>
                                                     
                                                      <dx:GridViewDataComboBoxColumn VisibleIndex="6" FieldName="IdAldea" Caption="Aldea">
                                                        <PropertiesComboBox ValueType="System.String" 
                
                                                            DataSourceID="SqlDataSourceAldeas" 
                                                            ValueField="IdAldea" 
                                                            TextField="DescripcionAldea"/>
     
                    
                                                      </dx:GridViewDataComboBoxColumn>
                                                      <dx:GridViewDataCheckColumn FieldName="EsTodoAldea" Visible="false" VisibleIndex="7"></dx:GridViewDataCheckColumn>
                                                      
                                                      <dx:GridViewDataComboBoxColumn VisibleIndex="8" FieldName="IdCaserio" Caption="Caserío">
                                                        <PropertiesComboBox ValueType="System.String" 
                
                                                            DataSourceID="SqlDataSourceCaserios" 
                                                            ValueField="IdCaserio" 
                                                            TextField="DescripcionCaserio"/>
     
                    
                                                      </dx:GridViewDataComboBoxColumn>
                                                      <dx:GridViewDataCheckColumn FieldName="EsTodoCacerio" Visible="false" VisibleIndex="9"></dx:GridViewDataCheckColumn>
                                                      
                                                      <dx:GridViewDataComboBoxColumn VisibleIndex="10" FieldName="IdBarrio" Caption="Barrio">
                                                        <PropertiesComboBox ValueType="System.String" 
                
                                                            DataSourceID="SqlDataSourceBarrios" 
                                                            ValueField="IdBarrio" 
                                                            TextField="DescripcionBarrio"/>
     
                    
                                                      </dx:GridViewDataComboBoxColumn>

                                                     

                                                   
                                                  </Columns>
                                              </dx:ASPxGridView>

                                     </DetailRow>
                                 </Templates>
                
                


                 </dx:ASPxGridView>
                                    </DetailRow>
                                </Templates>

                                </dx:ASPxGridView>

                       
                                      
                             <dx:ASPxGridViewExporter ID="ASPxGridViewExporter2" runat="server" GridViewID="GridCobertura"></dx:ASPxGridViewExporter>





                            <asp:SqlDataSource ID="SqlCobertura" runat="server" ConnectionString="<%$ ConnectionStrings:SUEPPSConnectionString %>" >
                                 <SelectParameters>
                                    <asp:SessionParameter Name="Programa" />
                                    <asp:SessionParameter Name="Year" />
                                </SelectParameters>
                            </asp:SqlDataSource>

                            <asp:SqlDataSource ID="SqlDataSource3" runat="server" ConnectionString="<%$ ConnectionStrings:SUEPPSConnectionString %>" >
                                <SelectParameters>
                                    <asp:SessionParameter Name="Programa" />
                                    <asp:SessionParameter Name="Ano" />
                                    <asp:SessionParameter Name="Descripcion" />
                                </SelectParameters>

                            </asp:SqlDataSource>

                            <asp:SqlDataSource runat="server" ID="SqlDataSourceUbicacionArea" ConnectionString='<%$ ConnectionStrings:SUEPPSConnectionString %>' 
                                                    SelectCommand="SELECT * FROM [UbicacionPorAreaDeInfluencia] WHERE [IdAreaDeInfluencia]=@IdAreaDeInfluencia AND [Activo]=1"
                                                     >
                                                    <SelectParameters>
                    
                                                        <asp:SessionParameter name="IdAreaDeInfluencia" />
                
                                                    </SelectParameters>
                                                    
                                              </asp:SqlDataSource>

                                       
                                          
                                              <asp:SqlDataSource ID="SqlDataSourceDepartamentos" runat="server" ConnectionString='<%$ ConnectionStrings:SUEPPSConnectionString %>' 
                                              SelectCommand="SELECT [IdDepartamento], [DescripcionDepartamento] FROM [vDepartamentos]"></asp:SqlDataSource>
                                          
                                              <asp:SqlDataSource ID="SqlDataSourceMunicipios" runat="server" ConnectionString='<%$ ConnectionStrings:SUEPPSConnectionString %>' 
                                                      SelectCommand="SELECT [IdMunicipio], [IdDepartamento], [DescripcionMunicipio] FROM [vMunicipios]">
                                                      
                                              </asp:SqlDataSource>

                                              
                                              <asp:SqlDataSource ID="SqlDataSourceAldeas" runat="server" ConnectionString='<%$ ConnectionStrings:SUEPPSConnectionString %>' 
                                                SelectCommand="SELECT [IdAldea], [DescripcionAldea], [IdMunicipio] FROM [vAldeas]">
                                                 
                                              </asp:SqlDataSource>

                                              <asp:SqlDataSource ID="SqlDataSourceCaserios" runat="server" ConnectionString='<%$ ConnectionStrings:SUEPPSConnectionString %>' 
                                              SelectCommand="SELECT [IdCaserio], [DescripcionCaserio], [IdAldea] FROM [vCaserios]">
                                                
                                              </asp:SqlDataSource>

                                              <asp:SqlDataSource ID="SqlDataSourceBarrios" runat="server" ConnectionString='<%$ ConnectionStrings:SUEPPSConnectionString %>' 
                                              SelectCommand="SELECT [IdBarrio], [DescripcionBarrio] FROM [vBarrios]">
                                                    
                                              </asp:SqlDataSource>

                        </dx:ContentControl>
                    </ContentCollection>
                </dx:TabPage>

<%-- ######################################################################################################################################################################################### --%>

                 <dx:TabPage  Text="Indicadores">
                 <ContentCollection>
                        <dx:ContentControl>

                            <table>
                                <tr>
                                    <td>
                                         <dx:ASPxLabel ID="LblAnoI" runat="server" Text="Año:" AssociatedControlID="cmbAno"></dx:ASPxLabel>
                           
                                    </td>
                                    <td>
                                        <dx:ASPxComboBox ID="cmbAnoI"  ClientInstanceName="cmbAnoI" runat="server" ValueType="System.String" DataSourceID="SqlAno"  ValueField="Ano"  TextField="Ano">              
                                         <ClientSideEvents SelectedIndexChanged="function(s, e) {Load2(); }" /> 
                                        </dx:ASPxComboBox>
                                    </td>

                                    <td>
                     
                                        <dx:ASPxButton ID="ExportarIndicador" runat="server" Text="Exportar Excel" OnClick="ExportarIndicador_Click"></dx:ASPxButton>
                                    </td>

                         
                                   </tr>
                             </table>
                                    <dx:ASPxGridViewExporter ID="ASPxGridViewExporter4" runat="server" GridViewID="GridIndicadoresI"></dx:ASPxGridViewExporter>


                                 <dx:ASPxGridView ID="GridIndicadoresI" ClientInstanceName="GridIndicadoresI" runat="server" AutoGenerateColumns="False" OnCustomCallback="GridIndicadoresI_CustomCallback" DataSourceID="SqlMetaIndicadores" OnHtmlDataCellPrepared="GridIndicadoresI_HtmlDataCellPrepared" 
                                  ShowDetailRow="true" SettingsBehavior-AllowFocusedRow="true" SettingsDetail-AllowOnlyOneMasterRowExpanded="true" Width="100%" SettingsDetail-ExportMode="All" KeyFieldName="DescripcionIndicador" Settings-ShowFilterRow="true" OnLoad="GridIndicadoresI_Load" Settings-ShowFilterRowMenu="true"
                                   Settings-HorizontalScrollBarMode="Visible" Settings-VerticalScrollBarMode="Visible" Settings-VerticalScrollableHeight="200"  >
                      
                                <Columns>

                                 
                                    <dx:GridViewDataTextColumn FieldName="DescripcionIndicador" Caption="Indicador" ShowInCustomizationForm="True" VisibleIndex="0">
                                    <Settings AutoFilterCondition="Contains" />
                                    </dx:GridViewDataTextColumn>

                                    <dx:GridViewBandColumn Caption="Trimestre I">
                                       <Columns>
                                           <dx:GridViewDataTextColumn FieldName="ProyectadoQ1" Caption="P" ShowInCustomizationForm="True" VisibleIndex="2">
                                           <Settings AllowAutoFilter="False" />
                                           </dx:GridViewDataTextColumn>
                                            <dx:GridViewDataTextColumn FieldName="EjecutadoQ1"  Caption="E" ShowInCustomizationForm="True" VisibleIndex="3">
                                            <Settings AllowAutoFilter="False" /> 
                                            </dx:GridViewDataTextColumn>
                                           <dx:GridViewDataTextColumn FieldName="P1"  Caption="%" ShowInCustomizationForm="True" VisibleIndex="4" PropertiesTextEdit-DisplayFormatString="P">
                                           <Settings AllowAutoFilter="False" />  
                                           </dx:GridViewDataTextColumn>
                                           <dx:GridViewDataTextColumn Caption="S"  Name="S1" ShowInCustomizationForm="True" VisibleIndex="5">
                                           <Settings AllowAutoFilter="False" />  
                                           </dx:GridViewDataTextColumn>
                            
                                       </Columns>
                                    </dx:GridViewBandColumn>

                                     <dx:GridViewBandColumn Caption="Trimestre II">
                                       <Columns>
                                           <dx:GridViewDataTextColumn FieldName="ProyectadoQ2" Caption="P" ShowInCustomizationForm="True" VisibleIndex="6">
                                           <Settings AllowAutoFilter="False" />
                                           </dx:GridViewDataTextColumn>
                                            <dx:GridViewDataTextColumn FieldName="EjecutadoQ2"  Caption="E" ShowInCustomizationForm="True" VisibleIndex="7">
                                            <Settings AllowAutoFilter="False" />
                                            </dx:GridViewDataTextColumn>
                                           <dx:GridViewDataTextColumn FieldName="P2" Caption="%" ShowInCustomizationForm="True" VisibleIndex="8" PropertiesTextEdit-DisplayFormatString="P">
                                           <Settings AllowAutoFilter="False" />  
                                           </dx:GridViewDataTextColumn>
                                           <dx:GridViewDataTextColumn Caption="S"  Name="S2" ShowInCustomizationForm="True" VisibleIndex="9">
                                           <Settings AllowAutoFilter="False" />  
                                           </dx:GridViewDataTextColumn>
                                   
                                    
                                       </Columns>
                                    </dx:GridViewBandColumn>

                                     <dx:GridViewBandColumn Caption="Trimestre III">
                                       <Columns>
                                           <dx:GridViewDataTextColumn FieldName="ProyectadoQ3" Caption="P" ShowInCustomizationForm="True" VisibleIndex="10">
                                          <Settings AllowAutoFilter="False" />
                                                </dx:GridViewDataTextColumn>
                                            <dx:GridViewDataTextColumn FieldName="EjecutadoQ3" Caption="E" ShowInCustomizationForm="True" VisibleIndex="11">
                                            <Settings AllowAutoFilter="False" /> 
                                            </dx:GridViewDataTextColumn>
                                           <dx:GridViewDataTextColumn FieldName="P3" Caption="%" ShowInCustomizationForm="True" VisibleIndex="12" PropertiesTextEdit-DisplayFormatString="P">
                                           <Settings AllowAutoFilter="False" />  
                                           </dx:GridViewDataTextColumn>
                                           <dx:GridViewDataTextColumn  Caption="S" Name="S3" ShowInCustomizationForm="True" VisibleIndex="13">
                                           <Settings AllowAutoFilter="False" />  
                                           </dx:GridViewDataTextColumn>
                                   
                                    
                                       </Columns>
                                    </dx:GridViewBandColumn>

                                     <dx:GridViewBandColumn Caption="Trimestre IV">
                                       <Columns>
                                           <dx:GridViewDataTextColumn FieldName="ProyectadoQ4"  Caption="P" ShowInCustomizationForm="True" VisibleIndex="14">
                                           <Settings AllowAutoFilter="False" />
                                           </dx:GridViewDataTextColumn>
                                            <dx:GridViewDataTextColumn FieldName="EjecutadoQ4" Caption="E" ShowInCustomizationForm="True" VisibleIndex="15">
                                            <Settings AllowAutoFilter="False" /> 
                                            </dx:GridViewDataTextColumn>
                                           <dx:GridViewDataTextColumn FieldName="P4" Caption="%" ShowInCustomizationForm="True" VisibleIndex="16" PropertiesTextEdit-DisplayFormatString="P">
                                            <Settings AllowAutoFilter="False" />
                                                </dx:GridViewDataTextColumn>
                                           <dx:GridViewDataTextColumn   Caption="S" Name="S4" ShowInCustomizationForm="True" VisibleIndex="17">
                                           <Settings AllowAutoFilter="False" />  
                                           </dx:GridViewDataTextColumn>
                                   
                                    
                                       </Columns>
                                    </dx:GridViewBandColumn>

                                    <dx:GridViewBandColumn Caption="Acumulado">
                                       <Columns>
                                           <dx:GridViewDataTextColumn FieldName="PA"  Caption="P" ShowInCustomizationForm="True" VisibleIndex="18">
                                           <Settings AllowAutoFilter="False" />
                                           </dx:GridViewDataTextColumn>
                                            <dx:GridViewDataTextColumn FieldName="EA" Caption="E" ShowInCustomizationForm="True" VisibleIndex="19">
                                            <Settings AllowAutoFilter="False" /> 
                                            </dx:GridViewDataTextColumn>
                                           <dx:GridViewDataTextColumn FieldName="PAA" Caption="%" ShowInCustomizationForm="True" VisibleIndex="20" PropertiesTextEdit-DisplayFormatString="P">
                                           <Settings AllowAutoFilter="False" />  
                                           </dx:GridViewDataTextColumn>
                                           <dx:GridViewDataTextColumn   Caption="S" Name="SA" ShowInCustomizationForm="True" VisibleIndex="21">
                                           <Settings AllowAutoFilter="False" />  
                                           </dx:GridViewDataTextColumn>
                                   
                                    
                                       </Columns>

                                    </dx:GridViewBandColumn>

                                </Columns>

                                     <SettingsPager>
                       <AllButton Visible="True" Text="Todos">
                       </AllButton>
                    </SettingsPager>






                              
                                         <SettingsDetail ShowDetailRow="True" ExportMode="All" />
         <Templates>
               <DetailRow>
 
            <dx:ASPxGridView ID="GridDetalleIndicador" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSource1" 
                IsDetailGrid="true"  OnBeforePerformDataSelect="GridDetalleIndicador_BeforePerformDataSelect"
                Settings-ShowFooter="true" SettingsDetail-AllowOnlyOneMasterRowExpanded="true"   >

                <Columns>

                    <dx:GridViewDataTextColumn FieldName="DescripcionAreaDeInfluencia"  Caption="Area de Influencia" ShowInCustomizationForm="True" VisibleIndex="0"> </dx:GridViewDataTextColumn>
                    <dx:GridViewDataTextColumn FieldName="ProyectadoQ1"  Caption="Q1" ShowInCustomizationForm="True" VisibleIndex="1"> </dx:GridViewDataTextColumn>
                    <dx:GridViewDataTextColumn FieldName="ProyectadoQ2"  Caption="Q2" ShowInCustomizationForm="True" VisibleIndex="2"> </dx:GridViewDataTextColumn>
                    <dx:GridViewDataTextColumn FieldName="ProyectadoQ3"  Caption="Q3" ShowInCustomizationForm="True" VisibleIndex="3"> </dx:GridViewDataTextColumn>
                    <dx:GridViewDataTextColumn FieldName="ProyectadoQ4"  Caption="Q4" ShowInCustomizationForm="True" VisibleIndex="4"> </dx:GridViewDataTextColumn>
                     <dx:GridViewDataTextColumn FieldName="EjecutadoQ1"  Caption="E1" ShowInCustomizationForm="True" VisibleIndex="5"> </dx:GridViewDataTextColumn>
                     <dx:GridViewDataTextColumn FieldName="EjecutadoQ2"  Caption="E2" ShowInCustomizationForm="True" VisibleIndex="6"> </dx:GridViewDataTextColumn>
                     <dx:GridViewDataTextColumn FieldName="EjecutadoQ3"  Caption="E3" ShowInCustomizationForm="True" VisibleIndex="7"> </dx:GridViewDataTextColumn>
                     <dx:GridViewDataTextColumn FieldName="EjecutadoQ4"  Caption="E4" ShowInCustomizationForm="True" VisibleIndex="8"> </dx:GridViewDataTextColumn>
                </Columns>
                
                <SettingsPager>
                       <AllButton Visible="True" Text="Todos">
                       </AllButton>
                    </SettingsPager>

                 </dx:ASPxGridView>
              
                </DetailRow>

            </Templates>
                    
                   
            </dx:ASPxGridView>


                            <asp:SqlDataSource ID="SqlMetaIndicadores" runat="server" ConnectionString="<%$ ConnectionStrings:SUEPPSConnectionString %>" >
                                <SelectParameters>
                                    <asp:SessionParameter Name="Programa" />
                                    <asp:SessionParameter Name="Year" />
                                </SelectParameters>

                            </asp:SqlDataSource>


                                    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:SUEPPSConnectionString %>" >
                                <SelectParameters>
                                    <asp:SessionParameter Name="Programa" />
                                    <asp:SessionParameter Name="Ano" />
                                    <asp:SessionParameter Name="Descripcion" />
                                </SelectParameters>

                            </asp:SqlDataSource>



                            </dx:ContentControl>
                 </ContentCollection>
                </dx:TabPage>

<%-- ######################################################################################################################################################################################### --%>


                <dx:TabPage  Text="Indicadores Por Area De Influencia ">
                    <ContentCollection>
                        <dx:ContentControl>


                            <table>
                                <tr>
                                    <td>
                                         <dx:ASPxLabel ID="LblAno" runat="server" Text="Año:" AssociatedControlID="cmbAno"></dx:ASPxLabel>
                           
                                    </td>
                                    <td>
                                        <dx:ASPxComboBox ID="cmbAno"  ClientInstanceName="cmbAno" runat="server" ValueType="System.String" DataSourceID="SqlAno"  ValueField="Ano"  TextField="Ano">              
                                         <ClientSideEvents SelectedIndexChanged="function(s, e) {Load(); }" /> 
                                        </dx:ASPxComboBox>
                                    </td>
                                     <td>
                                         <dx:ASPxLabel ID="LblArea" runat="server" Text="Area de Influencia:" AssociatedControlID="cmbArea"></dx:ASPxLabel>
                           
                                    </td>
                                    <td>
                                        <dx:ASPxComboBox ID="cmbArea"  ClientInstanceName="cmbArea" runat="server" ValueType="System.String" DataSourceID="SqlArea"  ValueField="IdAreaDeInfluencia"  TextField="DescripcionAreaDeInfluencia">
                                          <ClientSideEvents SelectedIndexChanged="function(s, e) {Load(); }" />                 
                                        </dx:ASPxComboBox>
                                    </td>
                                    <td>
                                         <dx:ASPxButton ID="ExportarIndicadorArea" runat="server" Text="Exportar" OnClick="ExportarIndicadorArea_Click"  ></dx:ASPxButton>

                                    </td>
                                </tr>
                            </table>

                            
                            

                           
                             <dx:ASPxGridViewExporter ID="gridExport" runat="server" GridViewID="GridIndicadores"></dx:ASPxGridViewExporter>


                            <asp:SqlDataSource ID="SqlAno" runat="server" ConnectionString="<%$ ConnectionStrings:SUEPPSConnectionString %>" SelectCommand="SELECT [Ano], [IdAnoPrograma], [IdPrograma] FROM [AnoPrograma] where [IdPrograma]=@Programa and [Activo]=1">
                                <SelectParameters>
                                    <asp:SessionParameter Name="Programa" />
                                </SelectParameters>
                            </asp:SqlDataSource>

                            <asp:SqlDataSource ID="SqlArea" runat="server" ConnectionString="<%$ ConnectionStrings:SUEPPSConnectionString %>" 
                            SelectCommand="SELECT * FROM [AreasDeInfluencia] where [IdPrograma]=@Programa and [Activo]=1">
                                <SelectParameters>
                                    <asp:SessionParameter Name="Programa" />
                                </SelectParameters>
                            </asp:SqlDataSource>

                            <dx:ASPxGridView ID="GridIndicadores" ClientInstanceName="GridIndicadores" runat="server" AutoGenerateColumns="False" DataSourceID="SqlMetaMonitoreo"  OnCustomCallback="GridIndicadores_CustomCallback"  OnHtmlDataCellPrepared="GridIndicadores_HtmlDataCellPrepared" Settings-ShowFilterRow="true" OnLoad="GridIndicadores_Load" Settings-ShowFilterRowMenu="true" Settings-HorizontalScrollBarMode="Visible" Width="100%" Settings-VerticalScrollBarMode="Visible" Settings-VerticalScrollableHeight="200"  >

                                <Columns>
                                    <dx:GridViewDataTextColumn FieldName="DescripcionIndicador" Caption="Indicador" ShowInCustomizationForm="True" VisibleIndex="0">
                                    <Settings AutoFilterCondition="Contains" />
                                    </dx:GridViewDataTextColumn>

                                    <dx:GridViewBandColumn Caption="Trimestre I">
                                       <Columns>
                                           <dx:GridViewDataTextColumn FieldName="ProyectadoQ1" Caption="P" ShowInCustomizationForm="True" VisibleIndex="1">
                                           <Settings AllowAutoFilter="False" />
                                           </dx:GridViewDataTextColumn>
                                            <dx:GridViewDataTextColumn FieldName="EjecutadoQ1"  Caption="E" ShowInCustomizationForm="True" VisibleIndex="2">
                                            <Settings AllowAutoFilter="False" /> 
                                            </dx:GridViewDataTextColumn>
                                           <dx:GridViewDataTextColumn FieldName="P1"  Caption="%" ShowInCustomizationForm="True" VisibleIndex="3" PropertiesTextEdit-DisplayFormatString="P">
                                            <Settings AllowAutoFilter="False" />
                                            </dx:GridViewDataTextColumn>
                                           <dx:GridViewDataTextColumn Caption="S"  Name="S1" ShowInCustomizationForm="True" VisibleIndex="4">
                                           <Settings AllowAutoFilter="False" />  
                                           </dx:GridViewDataTextColumn>
                                   
                                    
                                       </Columns>
                                    </dx:GridViewBandColumn>

                                     <dx:GridViewBandColumn Caption="Trimestre II">
                                       <Columns>
                                           <dx:GridViewDataTextColumn FieldName="ProyectadoQ2" Caption="P" ShowInCustomizationForm="True" VisibleIndex="5">
                                           <Settings AllowAutoFilter="False" />
                                           </dx:GridViewDataTextColumn>
                                            <dx:GridViewDataTextColumn FieldName="EjecutadoQ2"  Caption="E" ShowInCustomizationForm="True" VisibleIndex="6">
                                            <Settings AllowAutoFilter="False" /> 
                                            </dx:GridViewDataTextColumn>
                                           <dx:GridViewDataTextColumn FieldName="P2" Caption="%" ShowInCustomizationForm="True" VisibleIndex="7" PropertiesTextEdit-DisplayFormatString="P">
                                           <Settings AllowAutoFilter="False" />  
                                           </dx:GridViewDataTextColumn>
                                           <dx:GridViewDataTextColumn Caption="S"  Name="S2" ShowInCustomizationForm="True" VisibleIndex="8">
                                            <Settings AllowAutoFilter="False" />
                                            </dx:GridViewDataTextColumn>
                                   
                                    
                                       </Columns>
                                    </dx:GridViewBandColumn>

                                     <dx:GridViewBandColumn Caption="Trimestre III">
                                       <Columns>
                                           <dx:GridViewDataTextColumn FieldName="ProyectadoQ3" Caption="P" ShowInCustomizationForm="True" VisibleIndex="9">
                                           <Settings AllowAutoFilter="False" />
                                           </dx:GridViewDataTextColumn>
                                            <dx:GridViewDataTextColumn FieldName="EjecutadoQ3" Caption="E" ShowInCustomizationForm="True" VisibleIndex="10">
                                            <Settings AllowAutoFilter="False" />
                                                 </dx:GridViewDataTextColumn>
                                           <dx:GridViewDataTextColumn FieldName="P3" Caption="%" ShowInCustomizationForm="True" VisibleIndex="11" PropertiesTextEdit-DisplayFormatString="P">
                                            <Settings AllowAutoFilter="False" />
                                                </dx:GridViewDataTextColumn>
                                           <dx:GridViewDataTextColumn  Caption="S" Name="S3" ShowInCustomizationForm="True" VisibleIndex="12">
                                            <Settings AllowAutoFilter="False" />
                                                </dx:GridViewDataTextColumn>
                                   
                                    
                                       </Columns>
                                    </dx:GridViewBandColumn>

                                     <dx:GridViewBandColumn Caption="Trimestre IV">
                                       <Columns>
                                           <dx:GridViewDataTextColumn FieldName="ProyectadoQ4"  Caption="P" ShowInCustomizationForm="True" VisibleIndex="13">
                                          <Settings AllowAutoFilter="False" />
                                                </dx:GridViewDataTextColumn>
                                            <dx:GridViewDataTextColumn FieldName="EjecutadoQ4" Caption="E" ShowInCustomizationForm="True" VisibleIndex="14">
                                            <Settings AllowAutoFilter="False" />
                                                 </dx:GridViewDataTextColumn>
                                           <dx:GridViewDataTextColumn FieldName="P4" Caption="%" ShowInCustomizationForm="True" VisibleIndex="15" PropertiesTextEdit-DisplayFormatString="P">
                                           <Settings AllowAutoFilter="False" />  
                                           </dx:GridViewDataTextColumn>
                                           <dx:GridViewDataTextColumn   Caption="S" Name="S4" ShowInCustomizationForm="True" VisibleIndex="16">
                                            <Settings AllowAutoFilter="False" />
                                                </dx:GridViewDataTextColumn>
                                   
                                    
                                       </Columns>
                                    </dx:GridViewBandColumn>

                                    <dx:GridViewBandColumn Caption="Acumulado">
                                       <Columns>
                                           <dx:GridViewDataTextColumn FieldName="PA"  Caption="P" ShowInCustomizationForm="True" VisibleIndex="13">
                                           <Settings AllowAutoFilter="False" />
                                           </dx:GridViewDataTextColumn>
                                            <dx:GridViewDataTextColumn FieldName="EA" Caption="E" ShowInCustomizationForm="True" VisibleIndex="14">
                                            <Settings AllowAutoFilter="False" /> 
                                            </dx:GridViewDataTextColumn>
                                           <dx:GridViewDataTextColumn FieldName="PAA" Caption="%" ShowInCustomizationForm="True" VisibleIndex="15" PropertiesTextEdit-DisplayFormatString="P">
                                            <Settings AllowAutoFilter="False" />
                                                </dx:GridViewDataTextColumn>
                                           <dx:GridViewDataTextColumn   Caption="S" Name="SA" ShowInCustomizationForm="True" VisibleIndex="16">
                                            <Settings AllowAutoFilter="False" />
                                                </dx:GridViewDataTextColumn>
                                   
                                    
                                       </Columns>
                                    </dx:GridViewBandColumn>

                                </Columns>

                                <SettingsPager>
                       <AllButton Visible="True" Text="Todos">
                       </AllButton>
                    </SettingsPager>
                            </dx:ASPxGridView>


                            <asp:SqlDataSource ID="SqlMetaMonitoreo" runat="server" ConnectionString="<%$ ConnectionStrings:SUEPPSConnectionString %>" >
                                <SelectParameters>
                                    <asp:SessionParameter Name="Programa" />
                                    <asp:SessionParameter Name="Year" />
                                    <asp:SessionParameter Name="Area" />
                                </SelectParameters>

                            </asp:SqlDataSource>


                        </dx:ContentControl>
                    </ContentCollection>
                </dx:TabPage>


               
<%-- ######################################################################################################################################################################################### --%>


                <dx:TabPage  Text="Análisis Presupuestario">
                    <ContentCollection>
                        <dx:ContentControl>

                            <table>
                                <tr>
                                    <td>
                                         <dx:ASPxLabel ID="Lblan" runat="server" Text="Año:" AssociatedControlID="cmbAno"></dx:ASPxLabel>
                           
                                    </td>
                                    <td>
                                        <dx:ASPxComboBox ID="cmbAnoP"  ClientInstanceName="cmbAnoP" runat="server" ValueType="System.String" DataSourceID="SqlAnoP"  ValueField="periodo"  TextField="periodo">
                                          <ClientSideEvents SelectedIndexChanged="function(s, e) {LoadP(); }" />                 
                                        </dx:ASPxComboBox>
                                    </td>
                                    <td>
                                         <dx:ASPxButton ID="ExportarPresupuesto" runat="server" Text="Exportar" OnClick="ExportarPresupuesto_Click"  ></dx:ASPxButton>

                                    </td>
                                </tr>
                            </table>

                            <dx:ASPxGridView ID="GridPresupuesto" ClientInstanceName="GridPresupuesto" runat="server" AutoGenerateColumns="False" DataSourceID="SqlPresupuestoMeta" OnCustomCallback="GridPresupuesto_CustomCallback" Settings-HorizontalScrollBarMode="Visible" Width="100%" Settings-VerticalScrollBarMode="Visible" Settings-VerticalScrollableHeight="200" OnLoad="GridPresupuesto_Load" KeyFieldName="codigo_ficha" >
                                <Columns>

                                    <dx:GridViewBandColumn Caption="Presupuesto">

                                        <Columns>
                                        <dx:GridViewDataTextColumn FieldName="financiamiento" Caption="Financiamiento" ShowInCustomizationForm="True" VisibleIndex="0">
                                           </dx:GridViewDataTextColumn>
                                        <dx:GridViewDataTextColumn FieldName="contraparte" Caption="ContraParte" ShowInCustomizationForm="True" VisibleIndex="1">
                                           </dx:GridViewDataTextColumn>
                                            <dx:GridViewDataTextColumn FieldName="total" Caption="Total" ShowInCustomizationForm="True" VisibleIndex="2">
                                           </dx:GridViewDataTextColumn>
                                            <dx:GridViewDataTextColumn FieldName="vigente_fe" Caption="Vigente FE" ShowInCustomizationForm="True" VisibleIndex="3">
                                           </dx:GridViewDataTextColumn>
                                            <dx:GridViewDataTextColumn FieldName="vigente_cp" Caption="Vigente CP" ShowInCustomizationForm="True" VisibleIndex="4">
                                           </dx:GridViewDataTextColumn>
                                            <dx:GridViewDataTextColumn FieldName="vigente_total" Caption="Vigente Total" ShowInCustomizationForm="True" VisibleIndex="5">
                                           </dx:GridViewDataTextColumn>
                                            <dx:GridViewDataTextColumn FieldName="ejecucion_fe" Caption="Ejecución FE" ShowInCustomizationForm="True" VisibleIndex="6">
                                           </dx:GridViewDataTextColumn>
                                            <dx:GridViewDataTextColumn FieldName="ejecucion_cp" Caption="Ejecución CP" ShowInCustomizationForm="True" VisibleIndex="7">
                                           </dx:GridViewDataTextColumn>
                                            <dx:GridViewDataTextColumn FieldName="ejecucion_total" Caption="Ejecución Total" ShowInCustomizationForm="True" VisibleIndex="8">
                                           </dx:GridViewDataTextColumn>
                                            <dx:GridViewDataTextColumn FieldName="porcentaje" Caption="%" ShowInCustomizationForm="True" VisibleIndex="9" PropertiesTextEdit-DisplayFormatString="P">
                                           </dx:GridViewDataTextColumn>
                                        </Columns>

                                    </dx:GridViewBandColumn>

                                    </Columns>
                                    <SettingsPager>
                       <AllButton Visible="True" Text="Todos">
                       </AllButton>
                    </SettingsPager>
                           
                                   
                                     <SettingsDetail ShowDetailRow="True" ExportMode="All" />
                                    <Templates>
                                    <DetailRow>

                                        <dx:ASPxGridView ID="GridEjecutadoPresupuesto" ClientInstanceName="GridEjecutadoPresupuesto" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSource2" Settings-HorizontalScrollBarMode="Visible" Width="100%" Settings-VerticalScrollBarMode="Visible" Settings-VerticalScrollableHeight="200" OnBeforePerformDataSelect="GridEjecutadoPresupuesto_BeforePerformDataSelect" >
                                        <Columns>
                                             <dx:GridViewBandColumn Caption="Trimestre I">
                                       <Columns>
                                           <dx:GridViewDataTextColumn FieldName="pt1" Caption="Plan." ShowInCustomizationForm="True" VisibleIndex="10">
                                           </dx:GridViewDataTextColumn>
                                            <dx:GridViewDataTextColumn FieldName="et1"  Caption="Ejec." ShowInCustomizationForm="True" VisibleIndex="11">
                                             </dx:GridViewDataTextColumn>
                        
                                       </Columns>
                                    </dx:GridViewBandColumn>

                                    <dx:GridViewBandColumn Caption="Trimestre II">
                                       <Columns>
                                           <dx:GridViewDataTextColumn FieldName="pt2" Caption="Plan." ShowInCustomizationForm="True" VisibleIndex="12">
                                           </dx:GridViewDataTextColumn>
                                            <dx:GridViewDataTextColumn FieldName="et2"  Caption="Ejec." ShowInCustomizationForm="True" VisibleIndex="13">
                                             </dx:GridViewDataTextColumn>
                        
                                       </Columns>
                                    </dx:GridViewBandColumn>

                                    <dx:GridViewBandColumn Caption="Trimestre III">
                                       <Columns>
                                           <dx:GridViewDataTextColumn FieldName="pt3" Caption="Plan." ShowInCustomizationForm="True" VisibleIndex="14">
                                           </dx:GridViewDataTextColumn>
                                            <dx:GridViewDataTextColumn FieldName="et3"  Caption="Ejec." ShowInCustomizationForm="True" VisibleIndex="15">
                                             </dx:GridViewDataTextColumn>
                        
                                       </Columns>
                                    </dx:GridViewBandColumn>

                                    <dx:GridViewBandColumn Caption="Trimestre IV">
                                       <Columns>
                                           <dx:GridViewDataTextColumn FieldName="pt4" Caption="Plan." ShowInCustomizationForm="True" VisibleIndex="16">
                                           </dx:GridViewDataTextColumn>
                                            <dx:GridViewDataTextColumn FieldName="et4"  Caption="Ejec." ShowInCustomizationForm="True" VisibleIndex="17">
                                             </dx:GridViewDataTextColumn>
                        
                                       </Columns>
                                    </dx:GridViewBandColumn>

                                    <dx:GridViewBandColumn Caption="Acumulado">
                                       <Columns>
                                           <dx:GridViewDataTextColumn FieldName="ap" Caption="Plan." ShowInCustomizationForm="True" VisibleIndex="18">
                                           </dx:GridViewDataTextColumn>
                                            <dx:GridViewDataTextColumn FieldName="ae"  Caption="Ejec." ShowInCustomizationForm="True" VisibleIndex="19">
                                             </dx:GridViewDataTextColumn>
                        
                                       </Columns>
                                    </dx:GridViewBandColumn>
                                         </Columns>
                                         </dx:ASPxGridView>
                                        


                                     </DetailRow>
                                     </Templates>
                                    

                             </dx:ASPxGridView>
                                    

                             <asp:SqlDataSource ID="SqlPresupuestoMeta" runat="server" ConnectionString="<%$ ConnectionStrings:SUEPPSConnectionString %>" 
                             SelectCommand="SELECT b.codigo_ficha,b.financiamiento, b.contraparte, b.total , b.vigente_fe, b.vigente_cp, b.vigente_total, b.ejecucion_fe, b.ejecucion_cp, b.ejecucion_total, b.porcentaje / 100 as porcentaje FROM [vProgramacionPorPrograma] b where b.[codigo_ficha]=@Programa and b.[codigo_periodo]=@Ano ">
                                 <SelectParameters>
                                     <asp:SessionParameter Name="Programa" />
                                     <asp:SessionParameter Name="Ano" />
                                 </SelectParameters>
                             </asp:SqlDataSource>

                             <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:SUEPPSConnectionString %>" 
                             SelectCommand="SELECT ISNULL(pt1,0) as pt1 ,ISNULL(pt2,0) as pt2,ISNULL(pt3,0) as pt3, ISNULL(pt4,0) as pt4,ISNULL(et1,0) as et1,ISNULL(et2,0) as et2, ISNULL(et3,0) as et3,ISNULL(et4,0) as et4, (ISNULL(pt1,0) +ISNULL(pt2,0)+ISNULL(pt3,0)+ISNULL(pt4,0)) As ap,(ISNULL(et1,0) + ISNULL(et2,0) + ISNULL(et3,0)+ISNULL(et4,0)) As ae FROM [vPresupuestoMetaPrograma] where [codigo_ficha]=@Programa and [periodo]=@Ano ">
                                 <SelectParameters>
                                     <asp:SessionParameter Name="Programa" />
                                     <asp:SessionParameter Name="Ano" />
                                 </SelectParameters>
                             </asp:SqlDataSource>
                            

                           
                             <dx:ASPxGridViewExporter ID="ASPxGridViewExporter1" runat="server" GridViewID="GridPresupuesto"></dx:ASPxGridViewExporter>


                            <asp:SqlDataSource ID="SqlAnoP" runat="server" ConnectionString="<%$ ConnectionStrings:SUEPPSConnectionString %>" SelectCommand="SELECT distinct([periodo]) FROM [vPresupuestoMetaPrograma] where [codigo_ficha]=@Programa">
                                <SelectParameters>
                                    <asp:SessionParameter Name="Programa" />
                                </SelectParameters>
                            </asp:SqlDataSource>

                            
                        </dx:ContentControl>
                    </ContentCollection>
                </dx:TabPage>

<%-- ######################################################################################################################################################################################### --%>

                <dx:TabPage  Text="Análisis Cualitativo">
                    <ContentCollection>
                        <dx:ContentControl>
                            
                            <table>
                                <tr>
                                    <td>
                                         <dx:ASPxLabel ID="ASPxLabel1" runat="server" Text="Año:" AssociatedControlID="cmbAnoCualitativo"></dx:ASPxLabel>
                           
                                    </td>
                                    <td>
                                        <dx:ASPxComboBox ID="cmbAnoCualitativo"  ClientInstanceName="cmbAnoCualitativo" runat="server" ValueType="System.String" DataSourceID="SqlAno"  ValueField="Ano"  TextField="Ano">
                                          <ClientSideEvents SelectedIndexChanged="function(s, e) {LoadCualitativo(); }" />                 
                                        </dx:ASPxComboBox>
                                    </td>

                                    <td>
                                        <dx:ASPxButton ID="ExportarEncuesta" runat="server" Text="Exportar" OnClick="ExportarEncuesta_Click"></dx:ASPxButton>

                                    </td>
                                  
                                </tr>

                            </table>
                            <dx:ASPxGridViewExporter ID="exporter" runat="server" GridViewID="GridPreguntaRespuesta"></dx:ASPxGridViewExporter>
                            
                            <br/>
                            <br/>

                            <dx:ASPxGridView ID="GridPreguntaRespuesta" ClientInstanceName="GridPreguntaRespuesta" runat="server" AutoGenerateColumns="False" OnCustomCallback="GridPreguntaRespuesta_CustomCallback" DataSourceID="SqlPreguntaRespuesta" 
                                  KeyFieldName="IdPreguntaDeMonitoreo"  ShowDetailRow="true" SettingsBehavior-AllowFocusedRow="true" SettingsDetail-AllowOnlyOneMasterRowExpanded="true" Width="100%" SettingsDetail-ExportMode="All" Settings-ShowFilterRow="true" OnLoad="GridPreguntaRespuesta_Load" Settings-ShowFilterRowMenu="true"  >

                                <Columns>
                                    
                                   <dx:GridViewDataTextColumn FieldName="IdPreguntaDeMonitoreo" Caption="#" Visible="false" ReadOnly="True" VisibleIndex="0">
                                        <EditFormSettings Visible="False" />
                                   </dx:GridViewDataTextColumn>
                                   <dx:GridViewDataTextColumn FieldName="IdTipoDePregunta" Visible="false" VisibleIndex="1">
                                   </dx:GridViewDataTextColumn>
                                   <dx:GridViewDataTextColumn FieldName="DescripcionPreguntaDeMonitoreo" Caption="Pregunta" VisibleIndex="2">
                                   <Settings AutoFilterCondition="Contains" />
                                   </dx:GridViewDataTextColumn>
                                   <dx:GridViewDataTextColumn FieldName="NombreTipoDePregunta" Caption="Tipo de Pregunta" Visible="true" VisibleIndex="3">
                                   <Settings AutoFilterCondition="Contains" />
                                   </dx:GridViewDataTextColumn>
                                   <dx:GridViewDataTextColumn FieldName="IdCategoriaDePregunta" Visible="false" VisibleIndex="4">
                                   </dx:GridViewDataTextColumn>
                                   <dx:GridViewDataTextColumn FieldName="DescripcionCategoriaDePregunta" Caption="Categoria" VisibleIndex="5">
                                   <Settings AutoFilterCondition="Contains" />
                                   </dx:GridViewDataTextColumn>
                                   <dx:GridViewDataTextColumn FieldName="Orden" Caption="Orden" VisibleIndex="6">
                                   <Settings AllowAutoFilter="False" />
                                   </dx:GridViewDataTextColumn>
                                
                                </Columns>

                                <SettingsPager>
                       <AllButton Visible="True" Text="Todos">
                       </AllButton>
                    </SettingsPager>

                                <SettingsBehavior AllowFocusedRow="True"></SettingsBehavior>

                            
                                <SettingsDetail ShowDetailRow="True" />
                               <Templates>
                                 <DetailRow>
 
                                    <dx:ASPxGridView ID="GridRespuestas" runat="server" AutoGenerateColumns="False" DataSourceID="SqlRespuestas" 
                                     KeyFieldName="IdRespuestaDeMonitoreoCualitativo" OnBeforePerformDataSelect="GridRespuestas_BeforePerformDataSelect" IsDetailGrid="true" 
                                     Settings-ShowFooter="true" SettingsDetail-AllowOnlyOneMasterRowExpanded="true" Visible="<%#IsGridOpcionesVisible2(Container.KeyValue)%>" >
                                    <Columns>

                                        <dx:GridViewDataTextColumn FieldName="IdRespuestaDeMonitoreoCualitativo" ReadOnly="True" Caption="#" VisibleIndex="0" Visible="true">
                                            <EditFormSettings Visible="False"></EditFormSettings>
                                        </dx:GridViewDataTextColumn>
                    
                                         <dx:GridViewDataTextColumn FieldName="NombreTipoDePregunta" VisibleIndex="1" Caption="Tipo de Pregunta"></dx:GridViewDataTextColumn>
               
                                        <dx:GridViewDataTextColumn FieldName="RespuestaAbierta" VisibleIndex="2" Caption="Respuesta Abierta"></dx:GridViewDataTextColumn>
                                        <dx:GridViewDataTextColumn FieldName="RespuestaLikert" VisibleIndex="3"  Caption="Respuesta Likert" ></dx:GridViewDataTextColumn>  
                                        <dx:GridViewDataTextColumn FieldName="NombreTipoDeActor" VisibleIndex="4"  Caption="Tipo de Actor" ></dx:GridViewDataTextColumn>  
                                      
                                        

                                    </Columns>

                                    <SettingsDetail ShowDetailRow="True" ExportMode="All"/>
                                        <Templates>
                                        <DetailRow>
                                         <dx:ASPxGridView ID="ASPxGridViewOpciones" ClientInstanceName="ASPxGridViewOpciones" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSourceOpciones" KeyFieldName="IdOpcionesDeRespuesta" IsDetailGrid="true" onbeforeperformdataselect="ASPxGridViewOpciones_BeforePerformDataSelect" Visible="<%#IsGridOpcionesVisible3(Container.KeyValue)%>" >
                                            <Columns>
                                            <dx:GridViewDataTextColumn FieldName="IdOpcionesDeRespuesta" ReadOnly="True" VisibleIndex="0" Visible="true" Caption="#" >
                                             <EditFormSettings Visible="False" />
                                             </dx:GridViewDataTextColumn>
                                             <dx:GridViewDataTextColumn FieldName="DescripcionOpcionDePregunta" VisibleIndex="1" Caption="Respuesta">
                                             </dx:GridViewDataTextColumn>
                                    
                                             </Columns>
                                          </dx:ASPxGridView>
                                     </DetailRow>
                                 </Templates>

                            </dx:ASPxGridView>


                                     <br />
                                     <br />


                            <dx:ASPxGridView ID="GridComentarios" runat="server" DataSourceID="SqlComentarios" KeyFieldName="IdComentarioDePregunta" IsDetailGrid="true" OnBeforePerformDataSelect="GridComentarios_BeforePerformDataSelect"   Width="100%" SettingsEditing-EditFormColumnCount="1" Visible="true" >
                     <Columns>
                         <dx:GridViewDataTextColumn FieldName="IdComentarioDePregunta" Caption="#" VisibleIndex="0">
                              <EditFormSettings Visible="False" />
                         </dx:GridViewDataTextColumn>
                         <dx:GridViewDataTextColumn FieldName="DescripcionDeComentario" Caption="Comentario" VisibleIndex="1"></dx:GridViewDataTextColumn>
                         <dx:GridViewCommandColumn Caption="Acciones">
                             <NewButton Visible="true"></NewButton>
                             <UpdateButton Visible="true"></UpdateButton>
                             <EditButton Visible="true"></EditButton>
                             <DeleteButton Visible="true"></DeleteButton>
                         </dx:GridViewCommandColumn>
                     </Columns>
                 </dx:ASPxGridView>

            </DetailRow>
            </Templates>

            </dx:ASPxGridView>


                            <asp:SqlDataSource ID="SqlPreguntaRespuesta" runat="server" ConnectionString="<%$ ConnectionStrings:SUEPPSConnectionString %>" 
                   
                                SelectCommand="SELECT a.IdPreguntaDeMonitoreo,a.IdTipoDePregunta,a.EsGeneral,a.IdCategoriaDePregunta,a.Orden,a.DescripcionPreguntaDeMonitoreo,b.DescripcionCategoriaDePregunta, c.NombreTipoDePregunta FROM [PreguntasDeMonitoreo] a join [CategoriasDePregunta] b on a.IdCategoriaDePregunta=b.IdCategoriaDePregunta join [TiposDePreguntas] c on c.IdTipoDePregunta=a.IdTipoDePregunta where (a.EsGeneral=1 or ((a.EsGeneral=2 and  a.IdPrograma = @Programa) or (a.EsGeneral=3 and  a.IdPrograma = @Programa))) and a.Activo=1 order by a.EsGeneral,b.Orden,a.Orden" >
                                <SelectParameters>
                                    <asp:SessionParameter Name="Programa" />
                                </SelectParameters>

                            </asp:SqlDataSource>


                             <asp:SqlDataSource ID="SqlRespuestas" runat="server" ConnectionString="<%$ ConnectionStrings:SUEPPSConnectionString %>" 
                                SelectCommand="SELECT distinct RM.IdRespuestaDeMonitoreoCualitativo, TP.NombreTipoDePregunta, RM.RespuestaAbierta, RM.RespuestaLikert, TA.NombreTipoDeActor FROM [RespuestasDeMonitoreoCualitativo] RM join [PreguntasDeMonitoreo] PM on RM.[IdPreguntaDeMonitoreo]=PM.[IdPreguntaDeMonitoreo] join TiposDePreguntas TP on PM.IdTipoDePregunta= TP.IdTipoDePregunta join [MonitoreoCualitativo] MC on RM.IdMonitoreoCualitativo= MC.IdMonitoreoCualitativo join [ActoresPorPrograma] AP on (MC.Usuario= AP.Usuario and MC.IdPrograma=AP.IdPrograma) join TiposDeActor TA on TA.IdTipoDeActor= AP.IdTipoDeActor where RM.[IdPreguntaDeMonitoreo]=@IdPreguntaDeMonitoreo and MC.[Ano]=@Year and MC.IdPrograma= @Programa and AP.Activo=1 and RM.Activo=1"
                                 >
                                <SelectParameters>
                                    <asp:SessionParameter Name="IdPreguntaDeMonitoreo" />
                                    <asp:SessionParameter Name="Year" />
                                    <asp:SessionParameter Name="Programa" />

                                </SelectParameters>
                            </asp:SqlDataSource>


                            <asp:SqlDataSource runat="server" ID="SqlDataSourceOpciones" ConnectionString='<%$ ConnectionStrings:SUEPPSConnectionString %>' 
                    SelectCommand="SELECT a.[IdOpcionesDeRespuesta], b.[DescripcionOpcionDePregunta] FROM [OpcionesDeRespuesta] a join [OpcionesDePregunta] b on a.idOpcionDePregunta= b.IdOpcionDePregunta  WHERE ([IdRespuestaDeMonitoreoCualitativo] = @IdRespuesta )">
                               <SelectParameters>
                                   <asp:SessionParameter Name="IdRespuesta" />
                               </SelectParameters>
                            </asp:SqlDataSource>


                <asp:SqlDataSource runat="server" ID="SqlComentarios" ConnectionString='<%$ ConnectionStrings:SUEPPSConnectionString %>' 
                SelectCommand="SELECT * FROM [ComentariosDePreguntas] WHERE ([IdPreguntaDeMonitoreo] = @IdPreguntaDeMonitoreo and [Activo]=1)"
                InsertCommand="INSERT INTO  [ComentariosDePreguntas] ([DescripcionDeComentario], [IdPreguntaDeMonitoreo], [CreadoPor], [FechaCreacion], [Activo]) VALUES (@DescripcionDeComentario, @IdPreguntaDeMonitoreo, @Usuario, getDate(), 1)"
                UpdateCommand="UPDATE [ComentariosDePreguntas] SET [DescripcionDeComentario]=@DescripcionDeComentario,[ActualizadoPor]=@Usuario,[FechaActualizacion]=getDate() WHERE [IdComentarioDePregunta]= @IdComentarioDePregunta" 
                DeleteCommand="UPDATE [ComentariosDePreguntas] SET [Activo]=0 WHERE ([IdComentarioDePregunta] = @IdComentarioDePregunta) "
                >
                <SelectParameters>
                    <asp:SessionParameter Name="IdPreguntaDeMonitoreo" ></asp:SessionParameter>
                </SelectParameters>

                <InsertParameters>
                    
                    <asp:FormParameter Name="DescripcionDeComentario" />
                    <asp:SessionParameter Name="IdPreguntaDeMonitoreo" />
                    <asp:SessionParameter Name="Usuario" />

                </InsertParameters>

             <UpdateParameters>
                 <asp:SessionParameter Name="Usuario" />
                 <asp:FormParameter Name="DescripcionDeComentario" />        
             </UpdateParameters>


            </asp:SqlDataSource>
                            


                           

                        </dx:ContentControl>
                    </ContentCollection>
                </dx:TabPage>
            </TabPages>
        </dx:ASPxPageControl>


    </div>
</asp:Content>
