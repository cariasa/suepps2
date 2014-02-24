<%@ Page Language="VB" AutoEventWireup="false"  MasterPageFile="~/Site.master" CodeFile  ="MapaEvaluacion.aspx.vb" Inherits="Consultas_MapTest" %>

<asp:Content ID="CssContent" ContentPlaceHolderID="HeadContent" runat="server">
    <script type="text/javascript">
        // <![CDATA[
        document.write('<scr' + 'ipt charset="UTF-8" type="text/javascript" src="' +
            'http://ecn.dev.virtualearth.net/mapcontrol/mapcontrol.ashx?v=6.2&mkt=en-us' + '"></scr' + 'ipt>');
        // ]]> 
    </script>
</asp:Content>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="Server">



    <dx:ASPxPageControl ID="ASPxPageControl1" runat="server" ActiveTabIndex="0" Width="100%" ClientSideEvents-TabClick="function(s, e) { DataGrid.GetSelectedFieldValues('Latitud;Longitud;DescripcionMunicipio;Valor;DescripcionIndicador', OnGetSelectedFieldValues); }">
        <TabPages>
            <dx:TabPage Name="Mapa" Text="Datos Tabulares">
                <ContentCollection>
                    <dx:ContentControl ID="ContentControl1" runat="server">

         <dx:ASPxGridView ID="GridPolitica" runat="server" AutoGenerateColumns="False" DataSourceID="SqlPolitica" KeyFieldName="IdPolitica" SettingsDetail-ShowDetailRow="true">
            <Columns>
                <dx:GridViewDataTextColumn FieldName="IdPolitica" ReadOnly="True" VisibleIndex="0" Visible="false">
                    <EditFormSettings Visible="False" />
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Nombre" Caption="Política" VisibleIndex="1">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="SujetosDeAtencion" Caption="Sujetos de Atención" VisibleIndex="2">
                </dx:GridViewDataTextColumn>
            </Columns>
             <SettingsBehavior AllowFocusedRow="True" />

             <SettingsPager>
                 <AllButton Visible="True" Text="Todos">
                 </AllButton>
             </SettingsPager>


             <SettingsDetail ShowDetailRow="True" />
                        <Templates>
                        <DetailRow>

                            <dx:ASPxGridView ID="GridPrograma" runat="server" KeyFieldName="codigo_ficha" IsDetailGrid="true" OnBeforePerformDataSelect="ASPxGridView2_BeforePerformDataSelect" Width="100%" DataSourceID="SqlPrograma" >
                                <Columns>

                                     <dx:GridViewDataTextColumn FieldName="codigo_ficha" ReadOnly="True" VisibleIndex="0" Visible="false">
                                        <EditFormSettings Visible="False" />
                                     </dx:GridViewDataTextColumn>
                                    <dx:GridViewDataTextColumn FieldName="NombreProyecto" Caption="Programa" VisibleIndex="1">
                                    </dx:GridViewDataTextColumn>

                                </Columns>

                                <SettingsBehavior AllowFocusedRow="True" />

                                <SettingsPager>
                <AllButton Visible="True" Text="Todos">
                </AllButton>
            </SettingsPager>

           

                       <SettingsDetail ShowDetailRow="True" />
                        <Templates>
                        <DetailRow>

                            <dx:ASPxGridView ID="GridInstrumentos" runat="server" KeyFieldName="IdInstrumentoDeEvaluacion" IsDetailGrid="true" OnBeforePerformDataSelect="GridInstrumentos_BeforePerformDataSelect" Width="100%" DataSourceID="SqlInstrumentos" >
                                <Columns>

                                     <dx:GridViewDataTextColumn FieldName="IdInstrumentoDeEvaluacion" ReadOnly="True" VisibleIndex="0" Visible="false">
                                        <EditFormSettings Visible="False" />
                                     </dx:GridViewDataTextColumn>
                                    <dx:GridViewDataTextColumn FieldName="NombreInstrumento" Caption="Intrumento de Evaluación" VisibleIndex="1">
                                    </dx:GridViewDataTextColumn>
                                     <dx:GridViewDataTextColumn FieldName="Ano" Caption="Año" VisibleIndex="2">
                                    </dx:GridViewDataTextColumn>

                                </Columns>

                                <SettingsBehavior AllowFocusedRow="True" />

                                <SettingsPager>
                                    <AllButton Visible="True" Text="Todos">
                                    </AllButton>
                                 </SettingsPager>


                          <SettingsDetail ShowDetailRow="True" />
                        <Templates>
                        <DetailRow>


                            <dx:ASPxGridView ID="GridAplicacion" runat="server" KeyFieldName="IdAplicacionInstrumento" IsDetailGrid="true" OnBeforePerformDataSelect="ASPxGridView3_BeforePerformDataSelect" Width="100%" DataSourceID="SqlAplicacion"  >

                                <Columns>
             
                                     <dx:GridViewDataTextColumn FieldName="IdAplicacionInstrumento" Caption="IdAplicacion" ReadOnly="True" VisibleIndex="0" Visible="false" >
                                     </dx:GridViewDataTextColumn>
                                    <dx:GridViewDataTextColumn FieldName="DescripcionMomento" Caption="Levantamiento" VisibleIndex="1">
                                    </dx:GridViewDataTextColumn>
                                     <dx:GridViewDataTextColumn FieldName="FechaAplicacion" Caption="Fecha" VisibleIndex="2">
                                    </dx:GridViewDataTextColumn>
                                     <dx:GridViewDataTextColumn  FieldName="IdInstrumentoDeEvaluacion" Caption="IdInstrumentoDeEvaluacion" VisibleIndex="3" Visible="false">
                                    </dx:GridViewDataTextColumn>

                                </Columns>

                                  <SettingsPager>
                                    <AllButton Visible="True" Text="Todos">
                                    </AllButton>
                                  </SettingsPager>
                                <SettingsBehavior AllowFocusedRow="True" />

                            <SettingsDetail ShowDetailRow="True" />
                             <Templates>
                             <DetailRow>

                                  <dx:ASPxGridView ID="GridIndicadores" runat="server" KeyFieldName="IdIndicador" IsDetailGrid="true" OnBeforePerformDataSelect="GridIndicadores_BeforePerformDataSelect" Width="100%" DataSourceID="SqlIndicadores"  >

                                <Columns>
             
                                     <dx:GridViewDataTextColumn FieldName="IdIndicador" Caption="IdIndicador" ReadOnly="True" VisibleIndex="0" Visible="false" >
                                     </dx:GridViewDataTextColumn>
                                    <dx:GridViewDataTextColumn FieldName="DescripcionIndicador" Caption="Indicador" VisibleIndex="1">
                                    </dx:GridViewDataTextColumn>
                                    
                                     <dx:GridViewDataTextColumn FieldName="Acciones"  Caption="Acción"  ShowInCustomizationForm="True" VisibleIndex="4" UnboundType="String">
                                                                                        <DataItemTemplate>
                                                                                        <asp:LinkButton id="link1"  Text="Ver Ubicaciones" runat="server"  OnClick="link1_Click" /> 
                                                                                         </DataItemTemplate> 
                                        <Settings AllowAutoFilter="False" />
                                    </dx:GridViewDataTextColumn> 

                                </Columns>

                                  <SettingsPager>
                                    <AllButton Visible="True" Text="Todos">
                                    </AllButton>
                                  </SettingsPager>
                                <SettingsBehavior AllowFocusedRow="True" />

                      

                                      </dx:ASPxGridView>


                            </DetailRow>
                             </Templates>

                            


                            </dx:ASPxGridView>
                        </DetailRow>

                         </Templates>


        <SettingsBehavior AllowFocusedRow="True" />


                            </dx:ASPxGridView>
                         </DetailRow>
                        </Templates>
            
        </dx:ASPxGridView>
                         </DetailRow>
                        </Templates>
            
        </dx:ASPxGridView>

 
        <asp:SqlDataSource ID="SqlPolitica" runat="server" ConnectionString="<%$ ConnectionStrings:SUEPPSConnectionString %>" 
            SelectCommand="SELECT * FROM [Politicas] where [Activo]=1 ">

        </asp:SqlDataSource>

        <asp:SqlDataSource ID="SqlPrograma" runat="server" ConnectionString="<%$ ConnectionStrings:SUEPPSConnectionString %>" >

            <SelectParameters>
                     <asp:SessionParameter Name="IdPolitica" />
                     
                </SelectParameters>

        </asp:SqlDataSource>
        <asp:SqlDataSource ID="SqlInstrumentos" runat="server" ConnectionString="<%$ ConnectionStrings:SUEPPSConnectionString %>" >

            <SelectParameters>
                     <asp:SessionParameter Name="IdPrograma" />
                     
                </SelectParameters>

        </asp:SqlDataSource>

         <asp:SqlDataSource ID="SqlAplicacion" runat="server" ConnectionString="<%$ ConnectionStrings:SUEPPSConnectionString %>" >

            <SelectParameters>
                     <asp:SessionParameter Name="IdInstrumento" />
                     
                </SelectParameters>

        </asp:SqlDataSource>

        <asp:SqlDataSource ID="SqlIndicadores" runat="server" ConnectionString="<%$ ConnectionStrings:SUEPPSConnectionString %>" >

            <SelectParameters>
                     <asp:SessionParameter Name="IdAplicacionInstrumento" />
                     
                </SelectParameters>

        </asp:SqlDataSource>


                        <br />
                        <br />


                        <dx:ASPxGridView ID="DataGrid" ClientInstanceName="DataGrid" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSourceCabeceras" KeyFieldName="Latitud;Longitud;DescripcionMunicipio;Valor"  OnCustomCallback="DataGrid_CustomCallback"  OnLoad="DataGrid_Load" OnHtmlDataCellPrepared="GridIndicadores_HtmlDataCellPrepared" >
                            <Columns>
                                <dx:GridViewCommandColumn ShowInCustomizationForm="True" ShowSelectCheckbox="True"     VisibleIndex="0">
                                </dx:GridViewCommandColumn>
                                <dx:GridViewDataTextColumn FieldName="DescripcionIndicador" Caption="Indicador" VisibleIndex="1"></dx:GridViewDataTextColumn>
                                <dx:GridViewDataTextColumn FieldName="DescripcionDepartamento" Caption="Departamento" VisibleIndex="2"></dx:GridViewDataTextColumn>
                                <dx:GridViewDataTextColumn FieldName="DescripcionMunicipio" Caption="Municipio" VisibleIndex="3"></dx:GridViewDataTextColumn>
                                <dx:GridViewDataTextColumn FieldName="Latitud" Caption="Latitud" VisibleIndex="4">
                                    <Settings AllowAutoFilter="False" />
                                </dx:GridViewDataTextColumn>
                                <dx:GridViewDataTextColumn FieldName="Longitud" ShowInCustomizationForm="True" Caption="Longitud" VisibleIndex="5">
                                    <Settings AllowAutoFilter="False" />
                                </dx:GridViewDataTextColumn>
                                <dx:GridViewDataTextColumn FieldName="Valor" ReadOnly="True" Caption="Valor" ShowInCustomizationForm="True" VisibleIndex="6">
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
                        <asp:SqlDataSource ID="SqlDataSourceCabeceras" runat="server" ConnectionString="<%$ ConnectionStrings:SUEPPSConnectionString %>" >
                            <SelectParameters>
                                <asp:SessionParameter Name="IdAplicacionInstrumento" />
                                <asp:SessionParameter Name="IdIndicador" />
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
            var Indicador;
            var Municipio;
            var color;
            var semaforo;
            if (selectedValues.length > 0) {
                //Centra el mapa en la primera coordenada, y coloca el zoomlevel en 6, queda para que se vea toda Honduras
                map.SetCenterAndZoom(new VELatLong(selectedValues[0][0], selectedValues[0][1]), 6);
            }
            //Por cada municipio seleccionado, hacer un pin, y colocarle la descripción que viene en selectedValues
            for (i = 0; i < selectedValues.length; i++) {

                Indicador = selectedValues[i][4];
                Municipio = selectedValues[i][2];
                evaluacion = parseFloat(selectedValues[i][3])* 100;
                shape = new VEShape(VEShapeType.Pushpin, new VELatLong(selectedValues[i][0], selectedValues[i][1]));
                shape.SetTitle("INDICADOR: " + selectedValues[i][4]);
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