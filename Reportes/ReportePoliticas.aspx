<%@ Page Language="VB" AutoEventWireup="false" CodeFile="ReportePoliticas.aspx.vb" Inherits="Reportes_ReportePoliticas"  MasterPageFile="~/Site.master" %>

<%@ Register Assembly="DevExpress.Web.ASPxGauges.v13.2, Version=13.2.7.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web.ASPxGauges" TagPrefix="dx" %>

<%@ Register assembly="DevExpress.Web.ASPxGauges.v13.2, Version=13.2.7.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" namespace="DevExpress.Web.ASPxGauges.Gauges" tagprefix="dx" %>
<%@ Register assembly="DevExpress.Web.ASPxGauges.v13.2, Version=13.2.7.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" namespace="DevExpress.Web.ASPxGauges.Gauges.Linear" tagprefix="dx" %>
<%@ Register assembly="DevExpress.Web.ASPxGauges.v13.2, Version=13.2.7.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" namespace="DevExpress.Web.ASPxGauges.Gauges.Circular" tagprefix="dx" %>
<%@ Register assembly="DevExpress.Web.ASPxGauges.v13.2, Version=13.2.7.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" namespace="DevExpress.Web.ASPxGauges.Gauges.State" tagprefix="dx" %>
<%@ Register assembly="DevExpress.Web.ASPxGauges.v13.2, Version=13.2.7.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" namespace="DevExpress.Web.ASPxGauges.Gauges.Digital" tagprefix="dx" %>

<%@ Register Src="~/MOCA_UE.ascx" TagPrefix="uc1" TagName="MOCA_UE" %>


<asp:Content ID="cHeader" ContentPlaceHolderID="HeadContent" Runat="Server">
</asp:Content>
<asp:Content ID="cBody" ContentPlaceHolderID="MainContent" Runat="Server">
    <uc1:MOCA_UE runat="server" ID="MOCA_UE01" />
<script type="text/javascript">
    function OnAnoChanged(Combosector) {
        ASPxGridViewPoliticas.PerformCallback();
    }
</script>
    <div>
        <table>
        <tr>
            <td>
                <dx:ASPxLabel ID="ASPxLabelPeriodo" runat="server" Text="Período: "  AssociatedControlID="ASPxComboBoxPeriodo"></dx:ASPxLabel>
                <dx:ASPxComboBox ID="ASPxComboBoxPeriodo" runat="server" ValueType="System.String"></dx:ASPxComboBox>
            </td>
            <td>
                <dx:ASPxLabel ID="ASPxLabelAno" runat="server" Text="Año: " AssociatedControlID="ASPxComboBoxAno"></dx:ASPxLabel>
                <dx:ASPxComboBox ID="ASPxComboBoxAno" runat="server" ValueType="System.String">
                    <ClientSideEvents SelectedIndexChanged="function(s, e) {OnAnoChanged(s); }"></ClientSideEvents>
                </dx:ASPxComboBox>
            </td>
        </tr>
       
        </table>
                <dx:ASPxLabel ID="ASPxLabel1" runat="server" Text="Politicas: " AssociatedControlID="ASPxGridViewPoliticas"></dx:ASPxLabel>
                <dx:ASPxGridView ID="ASPxGridViewPoliticas" ClientInstanceName="ASPxGridViewPoliticas" runat="server" DataSourceID="SqlDataSourcePoliticas" AutoGenerateColumns="False"  KeyFieldName="IdPolitica"
                    OnCustomCallback="ASPxGridViewPoliticas_CustomCallback" SettingsBehavior-AllowFocusedRow="true" OnHtmlRowPrepared="ASPxGridViewPoliticas_HtmlRowPrepared">
                    <Columns>
                        <dx:GridViewDataTextColumn FieldName="IdPolitica" ReadOnly="True" VisibleIndex="0" Caption="#"></dx:GridViewDataTextColumn> 
                        <dx:GridViewDataTextColumn FieldName="NombrePolitica" ReadOnly="True" VisibleIndex="0" ></dx:GridViewDataTextColumn> 
                        <dx:GridViewDataTextColumn FieldName="SujetosDeAtencion" ReadOnly="True" VisibleIndex="0" Visible="false"></dx:GridViewDataTextColumn> 
                        <dx:GridViewDataTextColumn FieldName="PorcentajeEjecucionQ1" ReadOnly="True" VisibleIndex="0" Visible="false"></dx:GridViewDataTextColumn> 
                        <dx:GridViewDataTextColumn FieldName="PorcentajeEjecucionQ2" ReadOnly="True" VisibleIndex="0" Visible="false"></dx:GridViewDataTextColumn> 
                        <dx:GridViewDataTextColumn FieldName="PorcentajeEjecucionQ3" ReadOnly="True" VisibleIndex="0" Visible="false"></dx:GridViewDataTextColumn> 
                        <dx:GridViewDataTextColumn FieldName="PorcentajeEjecucionQ4" ReadOnly="True" VisibleIndex="0" Visible="false"></dx:GridViewDataTextColumn> 
                        <dx:GridViewDataTextColumn FieldName="PorcentajeEjecucion" ReadOnly="True" VisibleIndex="0" PropertiesTextEdit-DisplayFormatString="P"></dx:GridViewDataTextColumn> 
                        <dx:GridViewDataTextColumn>
                            <DataItemTemplate>
                                 <asp:LinkButton id="link1"  Text="Ver Gráfico" runat="server" OnClick="link1_Click" /> 
                                 </DataItemTemplate>
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn>
                            <DataItemTemplate>
                                 <asp:LinkButton id="linkVerComponentes"  Text="Ver Componentes" runat="server" OnClick="linkVerComponentes_Click" /> 
                                 </DataItemTemplate>
                        </dx:GridViewDataTextColumn>
                    </Columns>
                    
                </dx:ASPxGridView>

                <dx:ASPxLabel ID="ASPxLabel2" runat="server" Text="Componentes de Politicas: " AssociatedControlID="ASPxGridViewComponentesPoliticas"></dx:ASPxLabel>
                <dx:ASPxGridView ID="ASPxGridViewComponentesPoliticas" runat="server" AutoGenerateColumns="False"
                   DataSourceID="SqlDataSourceComponente" SettingsBehavior-AllowFocusedRow="true"
                   Settings-ShowFooter="true" KeyFieldName="IdComponentesDePolitica" OnHtmlRowPrepared="ASPxGridViewComponentesPoliticas_HtmlRowPrepared" Width="450px"> 
                                
                   <Columns>
                       <dx:GridViewDataTextColumn FieldName="IdComponentesDePolitica" ReadOnly="True" VisibleIndex="0" Visible="true" Caption="#">
                           <EditFormSettings Visible="False"></EditFormSettings>
                       </dx:GridViewDataTextColumn>
                
                       <dx:GridViewDataComboBoxColumn VisibleIndex="1" FieldName="IdPolitica" Caption="IdPolítica" Visible="false"></dx:GridViewDataComboBoxColumn>
                       <dx:GridViewDataTextColumn FieldName="Componente" VisibleIndex="2" Caption="Componente" Visible="false"></dx:GridViewDataTextColumn>
                       <dx:GridViewDataTextColumn FieldName="DescripcionComponente" VisibleIndex="3" Caption="Descripción" ></dx:GridViewDataTextColumn>
                       <dx:GridViewDataTextColumn FieldName="PorcentajeEjecucionQ1" ReadOnly="True" VisibleIndex="4" Visible="false"></dx:GridViewDataTextColumn> 
                       <dx:GridViewDataTextColumn FieldName="PorcentajeEjecucionQ2" ReadOnly="True" VisibleIndex="5" Visible="false"></dx:GridViewDataTextColumn> 
                       <dx:GridViewDataTextColumn FieldName="PorcentajeEjecucionQ3" ReadOnly="True" VisibleIndex="6" Visible="false"></dx:GridViewDataTextColumn> 
                       <dx:GridViewDataTextColumn FieldName="PorcentajeEjecucionQ4" ReadOnly="True" VisibleIndex="7" Visible="false"></dx:GridViewDataTextColumn> 
                       <dx:GridViewDataTextColumn FieldName="PorcentajeEjecucion" VisibleIndex="8" PropertiesTextEdit-DisplayFormatString="P" Caption="Porcenta de Ejecución"></dx:GridViewDataTextColumn>
                       <dx:GridViewDataTextColumn>
                       <DataItemTemplate>
                            <asp:LinkButton id="linkGraficoComponente"  Text="Ver Gráfico" runat="server" OnClick="linkGraficoComponente_Click">
                                               
                            </asp:LinkButton>
                       </DataItemTemplate>
                       </dx:GridViewDataTextColumn> 
                       <dx:GridViewDataTextColumn>
                       <DataItemTemplate>
                            <asp:LinkButton id="linkVerMetas"  Text="Ver Metas" runat="server"  OnClick="linkVerMetas_Click">
                                               
                            </asp:LinkButton>
                       </DataItemTemplate>
                       </dx:GridViewDataTextColumn>
                    </Columns>
                </dx:ASPxGridView>

                <dx:ASPxLabel ID="ASPxLabel3" runat="server" Text="Metas de Componentes: " AssociatedControlID="ASPxGridViewMetasComponentes"></dx:ASPxLabel>
                <dx:ASPxGridView ID="ASPxGridViewMetasComponentes" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSourceMetas" 
                    KeyFieldName="IdMetasDeComponente" IsDetailGrid="true" 
                    Visible="true" Settings-ShowFooter="true" SettingsBehavior-AllowFocusedRow="true"
                    OnHtmlRowPrepared="ASPxGridViewMetasComponentes_HtmlRowPrepared" Width="449px">
                 
                <Columns>
                    <dx:GridViewDataTextColumn FieldName="IdMetasDeComponente" ReadOnly="True" VisibleIndex="0" Visible="false" Caption="#">
                        <EditFormSettings Visible="False"></EditFormSettings>
                    </dx:GridViewDataTextColumn>
                
                    <dx:GridViewDataComboBoxColumn VisibleIndex="2" FieldName="IdComponentesDePolitica" Caption="Componente" Visible="false">
                            
                    </dx:GridViewDataComboBoxColumn>
                    <dx:GridViewDataTextColumn FieldName="Meta" VisibleIndex="1" Caption="Meta" Visible="false"></dx:GridViewDataTextColumn>
                    <dx:GridViewDataTextColumn FieldName="DescripcionMeta" VisibleIndex="3" Caption="Descripción" ></dx:GridViewDataTextColumn>
                    <dx:GridViewDataTextColumn FieldName="PorcentajeEjecucionQ1" ReadOnly="True" VisibleIndex="4" Visible="false"></dx:GridViewDataTextColumn> 
                    <dx:GridViewDataTextColumn FieldName="PorcentajeEjecucionQ2" ReadOnly="True" VisibleIndex="5" Visible="false"></dx:GridViewDataTextColumn> 
                    <dx:GridViewDataTextColumn FieldName="PorcentajeEjecucionQ3" ReadOnly="True" VisibleIndex="6" Visible="false"></dx:GridViewDataTextColumn> 
                    <dx:GridViewDataTextColumn FieldName="PorcentajeEjecucionQ4" ReadOnly="True" VisibleIndex="7" Visible="false"></dx:GridViewDataTextColumn> 
                    <dx:GridViewDataTextColumn FieldName="PorcentajeEjecucion" VisibleIndex="8" PropertiesTextEdit-DisplayFormatString="P" Caption="Porcentaje de Ejecución"></dx:GridViewDataTextColumn>
                    <dx:GridViewDataTextColumn>
                       <DataItemTemplate>
                            <asp:LinkButton id="linkVerGraficoMetas"  Text="Ver Grafico" runat="server" OnClick="linkVerGraficoMetas_Click">
                                               
                            </asp:LinkButton>
                       </DataItemTemplate>
                       </dx:GridViewDataTextColumn>
                    <dx:GridViewDataTextColumn>
                       <DataItemTemplate>
                            <asp:LinkButton id="linkVerIndicadoresMetas"  Text="Ver Indicadores" runat="server"  OnClick="linkVerIndicadoresMetas_Click">
                                               
                            </asp:LinkButton>
                       </DataItemTemplate>
                    </dx:GridViewDataTextColumn>
                </Columns>
                </dx:ASPxGridView>

        <asp:SqlDataSource runat="server" ID="SqlDataSourcePoliticas" ConnectionString='<%$ ConnectionStrings:SUEPPSConnectionString %>' >
            <SelectParameters>
                <asp:SessionParameter Name="Ano" />
            </SelectParameters>
        </asp:SqlDataSource>

        <dx:ASPxLabel ID="ASPxLabel4" runat="server" Text="Indicadores de Metas: " AssociatedControlID="ASPxGridViewindicadoresMetas"></dx:ASPxLabel>
        <dx:ASPxGridView ID="ASPxGridViewindicadoresMetas" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSourceIndicadoresMetas" 
                            KeyFieldName="IdIndicadorDeMeta"  
                            Visible="true" SettingsBehavior-AllowFocusedRow="true"
                            OnHtmlRowPrepared="ASPxGridViewindicadoresMetas_HtmlRowPrepared" Width="450px">
                        
                        <Columns>
                            <dx:GridViewDataTextColumn FieldName="IdIndicadorDeMeta" ReadOnly="True" VisibleIndex="0" Visible="false" Caption="#">
                                <EditFormSettings Visible="False"></EditFormSettings>
                            </dx:GridViewDataTextColumn>
                
                            <dx:GridViewDataComboBoxColumn VisibleIndex="2" FieldName="IdMetasDeComponente" Caption="Meta" Visible="false">
                                    
                            </dx:GridViewDataComboBoxColumn>
                
                            <dx:GridViewDataComboBoxColumn VisibleIndex="1" FieldName="DescripcionIndicador" Caption="Indicador">
                                    
                            </dx:GridViewDataComboBoxColumn>
                            <dx:GridViewDataTextColumn FieldName="PorcentajeEjecucionQ1" ReadOnly="True" VisibleIndex="4" Visible="false"></dx:GridViewDataTextColumn> 
                            <dx:GridViewDataTextColumn FieldName="PorcentajeEjecucionQ2" ReadOnly="True" VisibleIndex="5" Visible="false"></dx:GridViewDataTextColumn> 
                            <dx:GridViewDataTextColumn FieldName="PorcentajeEjecucionQ3" ReadOnly="True" VisibleIndex="6" Visible="false"></dx:GridViewDataTextColumn> 
                            <dx:GridViewDataTextColumn FieldName="PorcentajeEjecucionQ4" ReadOnly="True" VisibleIndex="7" Visible="false"></dx:GridViewDataTextColumn>
                            <dx:GridViewDataTextColumn FieldName="PorcentajeEjecucion" VisibleIndex="8" PropertiesTextEdit-DisplayFormatString="P" Caption="Porcentaje de Ejecución"></dx:GridViewDataTextColumn>
                            <dx:GridViewDataTextColumn VisibleIndex="9">
                       <DataItemTemplate>
                            <asp:LinkButton id="linkVerGraficoIndicadores"  Text="Ver Grafico" runat="server"  OnClick="linkVerGraficoIndicadores_Click" >
                                               
                            </asp:LinkButton>
                       </DataItemTemplate>
                       </dx:GridViewDataTextColumn>
                    <dx:GridViewDataTextColumn VisibleIndex="10">
                       <DataItemTemplate>
                            <asp:LinkButton id="linkVerProgramas"  Text="Ver Programas" runat="server" OnClick="linkVerProgramas_Click">
                                               
                            </asp:LinkButton>
                       </DataItemTemplate>
                    </dx:GridViewDataTextColumn>
                        </Columns>
        </dx:ASPxGridView>

        <dx:ASPxLabel ID="ASPxLabel5" runat="server" Text="Programas por Indicador de Metas: " AssociatedControlID="ASPxGridViewProgramasIndicadoresMetas"></dx:ASPxLabel>
        <dx:ASPxGridView ID="ASPxGridViewProgramasIndicadoresMetas" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSourceProgramasIndicadoresMetas" 
            KeyFieldName="IdProgramasPorIndicadorDeMeta" Visible="true" Settings-ShowFooter="true" OnHtmlRowPrepared="ASPxGridViewProgramasIndicadoresMetas_HtmlRowPrepared"
            SettingsBehavior-AllowFocusedRow="true" Width="449px" >
                                            
            <Columns>
                <dx:GridViewDataTextColumn FieldName="IdProgramasPorIndicadorDeMeta" ReadOnly="True" VisibleIndex="0" Visible="false" Caption="#">
                     <EditFormSettings Visible="False"></EditFormSettings>
                </dx:GridViewDataTextColumn>
                
                <dx:GridViewDataComboBoxColumn VisibleIndex="1" FieldName="IdProyecto" Caption="idPrograma/Proyecto" Visible="false">
                </dx:GridViewDataComboBoxColumn>

                <dx:GridViewDataComboBoxColumn VisibleIndex="2" FieldName="NombreProyecto" Caption="Programa/Proyecto" >
                </dx:GridViewDataComboBoxColumn>
                                
                <dx:GridViewDataComboBoxColumn VisibleIndex="3" FieldName="IdIndicadorDeMeta" Caption="Indicador" Visible="false">
                                        
                </dx:GridViewDataComboBoxColumn>

                <dx:GridViewDataTextColumn FieldName="PorcentajeEjecucionQ1" ReadOnly="True" VisibleIndex="4" Visible="false"></dx:GridViewDataTextColumn> 
                <dx:GridViewDataTextColumn FieldName="PorcentajeEjecucionQ2" ReadOnly="True" VisibleIndex="5" Visible="false"></dx:GridViewDataTextColumn> 
                <dx:GridViewDataTextColumn FieldName="PorcentajeEjecucionQ3" ReadOnly="True" VisibleIndex="6" Visible="false"></dx:GridViewDataTextColumn> 
                <dx:GridViewDataTextColumn FieldName="PorcentajeEjecucionQ4" ReadOnly="True" VisibleIndex="7" Visible="false"></dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="PorcentajeEjecucion" VisibleIndex="8" PropertiesTextEdit-DisplayFormatString="P" Caption="Porcentaje Ejecución"></dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn VisibleIndex="9">
                       <DataItemTemplate>
                            <asp:LinkButton id="linkVerGraficoprogramas"  Text="Ver Grafico" runat="server" OnClick="linkVerGraficoprogramas_Click" >
                                               
                            </asp:LinkButton>
                       </DataItemTemplate>
                       </dx:GridViewDataTextColumn>
                    <dx:GridViewDataTextColumn VisibleIndex="10">
                       <DataItemTemplate>
                            <asp:LinkButton id="linkVerIndicadoresRelevantes"  Text="Ver Indicadores Relevantes" runat="server"  OnClick="linkVerIndicadoresRelevantes_Click">
                                               
                            </asp:LinkButton>
                       </DataItemTemplate>
                    </dx:GridViewDataTextColumn>
            
            </Columns>
        </dx:ASPxGridView>

        <dx:ASPxLabel ID="ASPxLabel6" runat="server" Text="Indicadores Relevantes de Programa" AssociatedControlID="ASPxGridViewIndicadoresRelevantes"></dx:ASPxLabel>
        <dx:ASPxGridView ID="ASPxGridViewIndicadoresRelevantes" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSourceIndicadoresRelevantes"
            KeyFieldName="IdIndicadoresRelevantesDePrograma" OnHtmlRowPrepared="ASPxGridViewIndicadoresRelevantes_HtmlRowPrepared" SettingsBehavior-AllowFocusedRow="true" Width="448px">
            <Columns>
                     <dx:GridViewDataTextColumn FieldName="IdIndicadoresRelevantesDePrograma" ReadOnly="True" VisibleIndex="0" Visible="false" Caption="#">
                              <EditFormSettings Visible="False"></EditFormSettings>
                     </dx:GridViewDataTextColumn>

                     <dx:GridViewDataComboBoxColumn VisibleIndex="2" FieldName="IdProgramaPorIndicadorDeMeta" Caption="Programa" Visible="false">
                                                    
                     </dx:GridViewDataComboBoxColumn>


                     <dx:GridViewDataComboBoxColumn VisibleIndex="1" FieldName="IdIndicadoresPorPrograma" Caption="Indicador" Visible="false">
                                                    
                     </dx:GridViewDataComboBoxColumn>

                     <dx:GridViewDataTextColumn FieldName="DescripcionIndicador" VisibleIndex="3" ></dx:GridViewDataTextColumn>

                     <dx:GridViewDataTextColumn FieldName="IdPrograma" VisibleIndex="3" Visible="false"></dx:GridViewDataTextColumn>

                     <dx:GridViewDataTextColumn FieldName="NombreProyecto" VisibleIndex="3" Visible="false"></dx:GridViewDataTextColumn>

                     <dx:GridViewDataTextColumn FieldName="PorcentajeEjecucionQ1" ReadOnly="True" VisibleIndex="4" Visible="false"></dx:GridViewDataTextColumn> 
                     <dx:GridViewDataTextColumn FieldName="PorcentajeEjecucionQ2" ReadOnly="True" VisibleIndex="5" Visible="false"></dx:GridViewDataTextColumn> 
                     <dx:GridViewDataTextColumn FieldName="PorcentajeEjecucionQ3" ReadOnly="True" VisibleIndex="6" Visible="false"></dx:GridViewDataTextColumn> 
                     <dx:GridViewDataTextColumn FieldName="PorcentajeEjecucionQ4" ReadOnly="True" VisibleIndex="7" Visible="false"></dx:GridViewDataTextColumn>
                     <dx:GridViewDataTextColumn FieldName="PorcentajeEjecucion" VisibleIndex="4" PropertiesTextEdit-DisplayFormatString="P" Caption="Porcentaje Ejecución"></dx:GridViewDataTextColumn>
                     <dx:GridViewDataTextColumn VisibleIndex="9">
                       <DataItemTemplate>
                            <asp:LinkButton id="linkVerGraficoIndicadoresRelevantes"  Text="Ver Grafico" runat="server" OnClick="linkVerGraficoIndicadoresRelevantes_Click" >
                                               
                            </asp:LinkButton>
                       </DataItemTemplate>
                     </dx:GridViewDataTextColumn>                        
                </Columns>
        </dx:ASPxGridView>



        <asp:SqlDataSource ID="SqlDataSourceComponente" runat="server"  ConnectionString='<%$ ConnectionStrings:SUEPPSConnectionString %>'>
             <SelectParameters>
                   <asp:SessionParameter Name="IdPolitica" />
                   <asp:SessionParameter Name="Ano" />
             </SelectParameters>
        </asp:SqlDataSource>

        <asp:SqlDataSource ID="SqlDataSourceMetas" runat="server" ConnectionString='<%$ ConnectionStrings:SUEPPSConnectionString %>'>
            <SelectParameters>
                <asp:SessionParameter Name="IdComponentesDePolitica" />
                <asp:SessionParameter Name="Ano" />
            </SelectParameters>
        </asp:SqlDataSource>

        <asp:SqlDataSource ID="SqlDataSourceIndicadoresMetas" runat="server" ConnectionString='<%$ ConnectionStrings:SUEPPSConnectionString %>'>
            <SelectParameters>
                <asp:SessionParameter Name="IdMetasDeComponente" />
                <asp:SessionParameter Name="Ano" />
            </SelectParameters>
        </asp:SqlDataSource>

        <asp:SqlDataSource ID="SqlDataSourceProgramasIndicadoresMetas" runat="server" ConnectionString='<%$ ConnectionStrings:SUEPPSConnectionString %>'>
            <SelectParameters>
                <asp:SessionParameter Name="IdIndicadorDeMeta" />
                <asp:SessionParameter Name="Ano" />
            </SelectParameters>
        </asp:SqlDataSource>


        <asp:SqlDataSource ID="SqlDataSourceIndicadoresRelevantes" runat="server" ConnectionString='<%$ ConnectionStrings:SUEPPSConnectionString %>'>
            <SelectParameters>
                <asp:SessionParameter Name="IdProgramaPorIndicadorDeMeta" />
                <asp:SessionParameter Name="Ano" />
            </SelectParameters>
        </asp:SqlDataSource>
    </div>
</asp:Content>
