<%@ Page Language="VB" AutoEventWireup="false"  MasterPageFile="~/Site.master" CodeFile  ="Mapa.aspx.vb" Inherits="Consultas_MapTest" %>

<asp:Content ID="CssContent" ContentPlaceHolderID="HeadContent" runat="server">
    <script type="text/javascript">
        // <![CDATA[
        document.write('<scr' + 'ipt charset="UTF-8" type="text/javascript" src="' +
            'http://ecn.dev.virtualearth.net/mapcontrol/mapcontrol.ashx?v=6.2&mkt=en-us' + '"></scr' + 'ipt>');
        // ]]> 
    </script>
</asp:Content>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="Server">

    <script type="text/javascript">
                                                    
        function Load(cmbAno) {
            GridIndicadores.PerformCallback();
        }

        </script>

    


    <dx:ASPxPageControl ID="ASPxPageControl1" runat="server" ActiveTabIndex="0" Width="100%" ClientSideEvents-TabClick="function(s, e) { DataGrid.GetSelectedFieldValues('Latitud;Longitud;DescripcionMunicipio;PorcentajeEjecucion;DescripcionAreaDeInfluencia', OnGetSelectedFieldValues); }">
        <TabPages>
            <dx:TabPage Name="Mapa" Text="Datos Tabulares">
                <ContentCollection>
                    <dx:ContentControl ID="ContentControl1" runat="server">

                        <dx:ASPxLabel ID="ASPxLabel1" runat="server" Text="Año:" AssociatedControlID="cmbAnoCualitativo"></dx:ASPxLabel>
                           

                        <dx:ASPxComboBox ID="cmbAno"  ClientInstanceName="cmbAno" runat="server" ValueType="System.String" DataSourceID="SqlAno"  ValueField="Ano"  TextField="Ano">
                                          <ClientSideEvents SelectedIndexChanged="function(s, e) {Load(); }" />                 
                        </dx:ASPxComboBox>

                       <br />

                        <asp:SqlDataSource ID="SqlAno" runat="server" ConnectionString="<%$ ConnectionStrings:SUEPPSConnectionString %>" SelectCommand="SELECT [Ano], [IdAnoPrograma], [IdPrograma] FROM [AnoPrograma] where [IdPrograma]=@Programa and Activo=1">
                                <SelectParameters>
                                    <asp:SessionParameter Name="Programa" />
                                </SelectParameters>
                            </asp:SqlDataSource>


                        
                        <dx:ASPxGridView ID="GridIndicadores" ClientInstanceName="GridIndicadores" runat="server" AutoGenerateColumns="False" OnCustomCallback="GridIndicadores_CustomCallback" DataSourceID="SqlMetaIndicadores" OnHtmlDataCellPrepared="GridIndicadores_HtmlDataCellPrepared"
                                  ShowDetailRow="true" SettingsBehavior-AllowFocusedRow="true" SettingsDetail-AllowOnlyOneMasterRowExpanded="true" Width="100%" SettingsDetail-ExportMode="All" KeyFieldName="DescripcionIndicador" Settings-ShowFilterRow="true" OnLoad="GridIndicadores_Load" >
                      
                                <Columns>

                                     <dx:GridViewDataTextColumn FieldName="IdIndicador" Caption="#" ShowInCustomizationForm="False" VisibleIndex="0">
                                    <Settings AllowAutoFilter="False" />
                                     </dx:GridViewDataTextColumn>
                                 
                                    <dx:GridViewDataTextColumn FieldName="DescripcionIndicador" Caption="Indicador" ShowInCustomizationForm="True" VisibleIndex="1">
                                    
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


                                    <dx:GridViewDataTextColumn FieldName="Acciones"  Caption="Acción"  ShowInCustomizationForm="True" VisibleIndex="22" UnboundType="String">
                                                                                        <DataItemTemplate>
                                                                                        <asp:LinkButton id="link1"  Text="Ver Ubicaciones" runat="server"  OnClick="link1_Click" /> 
                                                                                         </DataItemTemplate> 
                                        <Settings AllowAutoFilter="False" />
                                                                                        </dx:GridViewDataTextColumn> 

                                   

                                </Columns>

                            </dx:ASPxGridView>


                        <asp:SqlDataSource ID="SqlMetaIndicadores" runat="server" ConnectionString="<%$ ConnectionStrings:SUEPPSConnectionString %>" >
                                <SelectParameters>
                                    <asp:SessionParameter Name="Programa" />
                                    <asp:SessionParameter Name="Year" />
                                </SelectParameters>

                            </asp:SqlDataSource>



                        <br />
                        <br />


                        <dx:ASPxGridView ID="DataGrid" ClientInstanceName="DataGrid" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSourceCabeceras" KeyFieldName="Latitud;Longitud;DescripcionMunicipio;PorcentajeEjecucion"  OnCustomCallback="DataGrid_CustomCallback"  OnLoad="DataGrid_Load">
                            <Columns>
                                <dx:GridViewCommandColumn ShowInCustomizationForm="True" ShowSelectCheckbox="True" VisibleIndex="0">
                                </dx:GridViewCommandColumn>
                                <dx:GridViewDataTextColumn FieldName="DescripcionAreaDeInfluencia" VisibleIndex="1"></dx:GridViewDataTextColumn>
                                <dx:GridViewDataTextColumn FieldName="DescripcionDepartamento" VisibleIndex="2"></dx:GridViewDataTextColumn>
                                <dx:GridViewDataTextColumn FieldName="DescripcionMunicipio" VisibleIndex="3"></dx:GridViewDataTextColumn>
                                <dx:GridViewDataTextColumn FieldName="Latitud" VisibleIndex="4">
                                    <Settings AllowAutoFilter="False" />
                                </dx:GridViewDataTextColumn>
                                <dx:GridViewDataTextColumn FieldName="Longitud" ShowInCustomizationForm="True" VisibleIndex="5">
                                    <Settings AllowAutoFilter="False" />
                                </dx:GridViewDataTextColumn>
                                <dx:GridViewDataTextColumn FieldName="PorcentajeEjecucion" ReadOnly="True" ShowInCustomizationForm="True" VisibleIndex="6">
                                <Settings AllowAutoFilter="False" />
                                </dx:GridViewDataTextColumn>
                            </Columns>
                            <SettingsPager>
                                                                                     <AllButton Visible="True" Text="Todos">
                                                                                      </AllButton>
                                                                                     </SettingsPager>

                                                                                        <SettingsBehavior AllowFocusedRow="True" />

                            <Settings ShowFilterRow="True"></Settings>
                        </dx:ASPxGridView>
                        <asp:SqlDataSource ID="SqlDataSourceCabeceras" runat="server" ConnectionString="<%$ ConnectionStrings:SUEPPSConnectionString %>" OnSelected="SqlDataSourceCabeceras_Selected" >
                            <SelectParameters>
                                <asp:SessionParameter Name="Programa" />
                                <asp:SessionParameter Name="Ano" />
                                <asp:SessionParameter Name="Indicador" />
                            </SelectParameters>
                        </asp:SqlDataSource>
                        
                    </dx:ContentControl>
                </ContentCollection>
            </dx:TabPage>



            <dx:TabPage Name="tabMap" Text="Mapa">
                <ContentCollection>
                    <dx:ContentControl ID="ContentControl2" runat="server">
                        <dx:ASPxLoadingPanel ID="loadingPanel1" ClientInstanceName="loadingPanel1" runat="server" />
                        <div id="myMap" style="position: relative; width: 830px; height: 400px;"></div>
                    </dx:ContentControl>
                </ContentCollection>
            </dx:TabPage>
        </TabPages>
    
    </dx:ASPxPageControl>
    <script type="text/javascript">
        function OnGetSelectedFieldValues(selectedValues) {
            if (selectedValues.length == 0) return;
            var shape = null;
            //Este sirve para que salga el "cargando".. habría que hacer el evento para que desaparezca, no lo logré yo
            loadingPanel1.ShowInElement(document.getElementById('myMap'));
            var map = null;
            map = new VEMap('myMap');
            map.LoadMap();
            var layer = new VEShapeLayer();
            map.AddShapeLayer(layer);
            layer._owner = this;
            var evaluacion;
            var Area;
            var Municipio;
            var color;
            var semaforo;
            if (selectedValues.length > 0) {
                //Centra el mapa en la primera coordenada, y coloca el zoomlevel en 6, queda para que se vea toda Honduras
                map.SetCenterAndZoom(new VELatLong(selectedValues[0][0], selectedValues[0][1]), 6);
            }
            //Por cada municipio seleccionado, hacer un pin, y colocarle la descripción que viene en selectedValues
            for (i = 0; i < selectedValues.length; i++) {

                Area = selectedValues[i][4];
                Municipio = selectedValues[i][2];
                evaluacion = parseFloat(selectedValues[i][3])* 100;
                shape = new VEShape(VEShapeType.Pushpin, new VELatLong(selectedValues[i][0], selectedValues[i][1]));
                shape.SetTitle("ÁREA DE INFLUENCIA: " + selectedValues[i][4]);
                //shape.SetDescription(selectedValues[i][2] + ' Evaluación: ' + selectedValues[i][3] + '%');
                
                if (evaluacion >= 80) {
                    semaforo = "<div style='font-family:Arial; font-size:x-small;" +
                               "color:Black; background-color:White' >" +
                               "<img src='../Imagenes/sem-green.png'/> <br /> Municipio: " + Municipio + " <br /> Porcentaje Ejecución: " + evaluacion + " % </div>";
                } else if (evaluacion > 50){
                    semaforo = "<div style='font-family:Arial; font-size:x-small;" +
                               "color:Black; background-color:White' >" +
                               "<img src='../Imagenes/sem-yellow.png'/> <br /> Municipio: " + Municipio + " <br /> Porcentaje Ejecución: " + evaluacion + " % </div>";
                } else {
                    semaforo = "<div style='font-family:Arial; font-size:x-small;" +
                               "color:Black; background-color:White'>" +
                               "<img src='../Imagenes/sem-red.png'/> <br /> Municipio: " + Municipio + " <br /> Porcentaje Ejecución: " + evaluacion + " % </div>";
                }
                shape.SetDescription(semaforo);
                
                layer.AddShape(HacerPoligono(selectedValues[i][0], selectedValues[i][1], evaluacion));
                layer.AddShape(shape);
                
            }
            loadingPanel1.Hide();
            loadingPanel1 = null;
        }
        function HacerPoligono(latitud, longitud, evaluacion) {
            var LENGTH = 0.025;
            var polygon = new VEShape(VEShapeType.Polygon,
                [
                    new VELatLong(latitud - LENGTH, longitud - LENGTH),
                    new VELatLong(latitud + LENGTH, longitud - LENGTH),
                    new VELatLong(latitud + LENGTH, longitud + LENGTH),
                    new VELatLong(latitud - LENGTH, longitud + LENGTH)
                ]);
            var color;
            
            if (evaluacion >= 80) {
                color = new VEColor(0, 255, 0, 0.5);
            } else if (evaluacion > 50) {
                color = new VEColor(255, 255, 0, 0.5);
            } else {
                color = new VEColor(255, 0, 0, 0.5);
            }
            polygon.SetFillColor(color);
            polygon.SetLineWidth(1);
            return polygon;
        }
    </script>
</asp:Content>