<%@ Page Title="Levantamientos por Programa" Language="VB" AutoEventWireup="false" CodeFile="Levantamientos.aspx.vb" Inherits="Evaluacion_Levantamientos" MasterPageFile="~/Site.master" %>

<%@ Register Src="~/MOCA_UE.ascx" TagPrefix="uc1" TagName="MOCA_UE" %>

<asp:Content ID="cHeader" ContentPlaceHolderID="HeadContent" runat="Server">
</asp:Content>
<asp:Content ID="cBody" ContentPlaceHolderID="MainContent" runat="Server">
    <uc1:MOCA_UE runat="server" ID="MOCA_UE01" />
    <div>
        <table>
            <tr>
                <td>
                    <dx:ASPxLabel ID="ASPxLabelTitulo" runat="server" Font-Size="Large" Text="Consultar Levantamientos por Programa" />
                </td>
            </tr>
        </table>
    </div>
    <div>

        <dx:ASPxGridView ID="ASPxGridViewPoliticas" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSourcePoliticas" KeyFieldName="IdPolitica" SettingsDetail-ShowDetailRow="true">
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

                    <dx:ASPxGridView ID="ASPxGridViewProyectos" runat="server" KeyFieldName="codigo_ficha" IsDetailGrid="true" OnBeforePerformDataSelect="ASPxGridViewProyectos_BeforePerformDataSelect" Width="100%" DataSourceID="SqlDataSourceProyectos">
                        <Columns>
                            <dx:GridViewDataTextColumn FieldName="codigo_ficha" ReadOnly="True" VisibleIndex="0" Visible="false">
                                <EditFormSettings Visible="False" />
                            </dx:GridViewDataTextColumn>
                            <dx:GridViewDataTextColumn FieldName="NombreProyecto" Caption="Programa" VisibleIndex="1">
                            </dx:GridViewDataTextColumn>
                            <dx:GridViewDataTextColumn FieldName="codigo_proyecto" Caption="Código Programa" VisibleIndex="2">
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

                                <dx:ASPxGridView ID="ASPxGridViewInstrumentos" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSourceInstrumentos" KeyFieldName="IdInstrumentoDeEvaluacion" IsDetailGrid="true" OnBeforePerformDataSelect="ASPxGridViewInstrumentos_BeforePerformDataSelect" Width="100%" SettingsDetail-AllowOnlyOneMasterRowExpanded="true">
                                    <Columns>
                                        <dx:GridViewDataTextColumn FieldName="IdInstrumentoDeEvaluacion" ReadOnly="True" VisibleIndex="0" Visible="false">
                                            <EditFormSettings Visible="False"></EditFormSettings>
                                        </dx:GridViewDataTextColumn>
                                        <dx:GridViewDataTextColumn FieldName="TipoDeInstrumento" VisibleIndex="2"></dx:GridViewDataTextColumn>
                                        <dx:GridViewDataTextColumn FieldName="IdPrograma" VisibleIndex="2" Visible="false"></dx:GridViewDataTextColumn>
                                        <dx:GridViewDataTextColumn FieldName="NombreInstrumento" VisibleIndex="1"></dx:GridViewDataTextColumn>
                                        <dx:GridViewDataTextColumn FieldName="Ano" VisibleIndex="4"></dx:GridViewDataTextColumn>
                                    </Columns>
                                    <SettingsBehavior AllowFocusedRow="True" />

                                    <SettingsPager>
                                        <AllButton Visible="True" Text="Todos">
                                        </AllButton>
                                    </SettingsPager>

                                    <SettingsDetail ShowDetailRow="True" />
                                    <Templates>
                                        <DetailRow>

                                            <dx:ASPxGridView ID="ASPxGridViewLevantamientos" runat="server" KeyFieldName="IdAplicacionInstrumento" IsDetailGrid="true" OnBeforePerformDataSelect="ASPxGridViewLevantamientos_BeforePerformDataSelect" OnHtmlDataCellPrepared="ASPxGridViewLevantamientos_HtmlDataCellPrepared" Width="100%" DataSourceID="SqlDataSourceLevantamientos">

                                                <Columns>

                                                    <dx:GridViewDataTextColumn FieldName="IdAplicacionInstrumento" Caption="IdAplicacion" ReadOnly="True" VisibleIndex="0" Visible="false">
                                                    </dx:GridViewDataTextColumn>
                                                    <dx:GridViewDataTextColumn FieldName="DescripcionMomento" Caption="Levantamiento" VisibleIndex="1">
                                                    </dx:GridViewDataTextColumn>
                                                    <dx:GridViewDataTextColumn FieldName="ProcesoEvaluacion" Caption="Fuente" VisibleIndex="2">
                                                    </dx:GridViewDataTextColumn>
                                                    <dx:GridViewDataTextColumn FieldName="FechaAplicacion" Caption="Fecha" VisibleIndex="3">
                                                    </dx:GridViewDataTextColumn>
                                                    <dx:GridViewDataTextColumn FieldName="FechaCalculo" Caption="Fecha Cálculo" VisibleIndex="5">
                                                    </dx:GridViewDataTextColumn>
                                                    <dx:GridViewDataTextColumn Name="Calculado" Caption="Calculado" VisibleIndex="4">
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

                                                        <dx:ASPxGridView ID="ASPxGridViewIndicadores" runat="server" IsDetailGrid="true" KeyFieldName="IdIndicador" Width="100%" DataSourceID="SqlDataSourceIndicadores" OnBeforePerformDataSelect="ASPxGridViewIndicadores_BeforePerformDataSelect">


                                                            <Columns>
                                                                <dx:GridViewDataTextColumn FieldName="IdIndicador" Caption="IdIndicador" ReadOnly="True" VisibleIndex="0" Visible="false">
                                                                </dx:GridViewDataTextColumn>
                                                                <dx:GridViewDataTextColumn FieldName="Indicador" Caption="Indicador" VisibleIndex="1">
                                                                </dx:GridViewDataTextColumn>

                                                                <dx:GridViewDataTextColumn FieldName="ValorCalculado" Caption="Valor" VisibleIndex="2">
                                                                </dx:GridViewDataTextColumn>

                                                                <dx:GridViewDataTextColumn FieldName="ValorPrograma" Caption="Valor Programa" VisibleIndex="3">
                                                                </dx:GridViewDataTextColumn>

                                                                <dx:GridViewDataTextColumn FieldName="ValorOficial" Caption="Valor Oficial" VisibleIndex="3">
                                                                </dx:GridViewDataTextColumn>


                                                            </Columns>

                                                            <SettingsPager>
                                                                <AllButton Visible="True" Text="Todos">
                                                                </AllButton>
                                                            </SettingsPager>

                                                            <SettingsDetail ShowDetailRow="True" />
                                                            <Templates>
                                                                <DetailRow>

                                                                    <dx:ASPxGridView ID="ASPxGridViewSexo" runat="server" IsDetailGrid="true" KeyFieldName="IdIndicadoresEvaluacionPorPrograma" Width="100%" DataSourceID="SqlDataSourceSexo" OnBeforePerformDataSelect="ASPxGridViewSexo_BeforePerformDataSelect">

                                                                        <Columns>
                                                                            <dx:GridViewDataTextColumn FieldName="IdIndicadoresEvaluacionPorPrograma" Caption="#" ReadOnly="True" VisibleIndex="0" Visible="false">
                                                                            </dx:GridViewDataTextColumn>
                                                                            <dx:GridViewDataTextColumn FieldName="DescripcionSexo" Caption="Sexo" VisibleIndex="1">
                                                                            </dx:GridViewDataTextColumn>
                                                                            <dx:GridViewDataTextColumn FieldName="Valor" Caption="Valor" VisibleIndex="3">
                                                                            </dx:GridViewDataTextColumn>

                                                                        </Columns>

                                                                        <SettingsPager>
                                                                            <AllButton Visible="True" Text="Todos">
                                                                            </AllButton>
                                                                        </SettingsPager>


                                                                    </dx:ASPxGridView>

                                                                    <br />

                                                                    <dx:ASPxGridView ID="ASPxGridViewDepartamentos" runat="server" IsDetailGrid="true" KeyFieldName="IdIndicadoresEvaluacionPorPrograma" Width="100%" DataSourceID="SqlDataSourceDepartamentos" OnBeforePerformDataSelect="ASPxGridViewDepartamentos_BeforePerformDataSelect">

                                                                        <Columns>
                                                                            <dx:GridViewDataTextColumn FieldName="IdIndicadoresEvaluacionPorPrograma" Caption="#" ReadOnly="True" VisibleIndex="0" Visible="false">
                                                                            </dx:GridViewDataTextColumn>
                                                                            <dx:GridViewDataTextColumn FieldName="DescripcionDepartamento" Caption="Departamento" VisibleIndex="1">
                                                                            </dx:GridViewDataTextColumn>
                                                                            <dx:GridViewDataTextColumn FieldName="Valor" Caption="Valor" VisibleIndex="2">
                                                                            </dx:GridViewDataTextColumn>

                                                                        </Columns>

                                                                        <SettingsPager>
                                                                            <AllButton Visible="True" Text="Todos">
                                                                            </AllButton>
                                                                        </SettingsPager>
                                                                    </dx:ASPxGridView>

                                                                    <br />

                                                                    <dx:ASPxGridView ID="ASPxGridViewMunicipios" runat="server" IsDetailGrid="true" KeyFieldName="IdIndicadoresEvaluacionPorPrograma" Width="100%" DataSourceID="SqlDataSourceMunicipios" OnBeforePerformDataSelect="ASPxGridViewMunicipios_BeforePerformDataSelect">

                                                                        <Columns>
                                                                            <dx:GridViewDataTextColumn FieldName="IdIndicadoresEvaluacionPorPrograma" Caption="#" ReadOnly="True" VisibleIndex="0" Visible="false">
                                                                            </dx:GridViewDataTextColumn>
                                                                            <dx:GridViewDataTextColumn FieldName="DescripcionDepartamento" Caption="Departamento" VisibleIndex="1">
                                                                            </dx:GridViewDataTextColumn>
                                                                            <dx:GridViewDataTextColumn FieldName="DescripcionMunicipio" Caption="Municipio" VisibleIndex="2">
                                                                            </dx:GridViewDataTextColumn>
                                                                            <dx:GridViewDataTextColumn FieldName="Valor" Caption="Valor" VisibleIndex="3">
                                                                            </dx:GridViewDataTextColumn>

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


        <asp:SqlDataSource ID="SqlDataSourcePoliticas" runat="server" ConnectionString="<%$ ConnectionStrings:SUEPPSConnectionString %>"
            SelectCommand="SELECT * FROM [Politicas] where [Activo]=1 "></asp:SqlDataSource>

        <asp:SqlDataSource ID="SqlDataSourceProyectos" runat="server" ConnectionString="<%$ ConnectionStrings:SUEPPSConnectionString %>">

            <SelectParameters>
                <asp:SessionParameter Name="IdPolitica" />

            </SelectParameters>

        </asp:SqlDataSource>

        <asp:SqlDataSource ID="SqlDataSourceLevantamientos" runat="server" ConnectionString="<%$ ConnectionStrings:SUEPPSConnectionString %>">

            <SelectParameters>
                <asp:SessionParameter Name="IdInstrumento" />

            </SelectParameters>

        </asp:SqlDataSource>

        <asp:SqlDataSource ID="SqlDataSourceIndicadores" runat="server" ConnectionString="<%$ ConnectionStrings:SUEPPSConnectionString %>">

            <SelectParameters>
                <asp:SessionParameter Name="IdAplicacion" />

            </SelectParameters>

        </asp:SqlDataSource>

        <asp:SqlDataSource ID="SqlDataSourceDepartamentos" runat="server" ConnectionString="<%$ ConnectionStrings:SUEPPSConnectionString %>">

            <SelectParameters>
                <asp:SessionParameter Name="IdAplicacion" />
                <asp:SessionParameter Name="IdIndicador" />

            </SelectParameters>

        </asp:SqlDataSource>

        <asp:SqlDataSource ID="SqlDataSourceMunicipios" runat="server" ConnectionString="<%$ ConnectionStrings:SUEPPSConnectionString %>">

            <SelectParameters>
                <asp:SessionParameter Name="IdAplicacion" />
                <asp:SessionParameter Name="IdIndicador" />

            </SelectParameters>

        </asp:SqlDataSource>

        <asp:SqlDataSource ID="SqlDataSourceSexo" runat="server" ConnectionString="<%$ ConnectionStrings:SUEPPSConnectionString %>">

            <SelectParameters>
                <asp:SessionParameter Name="IdAplicacion" />
                <asp:SessionParameter Name="IdIndicador" />

            </SelectParameters>

        </asp:SqlDataSource>


        <asp:SqlDataSource runat="server" ID="SqlDataSourceInstrumentos" ConnectionString='<%$ ConnectionStrings:SUEPPSConnectionString %>' >

            <SelectParameters>
                <asp:SessionParameter Name="IdPrograma" SessionField="IdPrograma"/>
            </SelectParameters>

        </asp:SqlDataSource>


    </div>
</asp:Content>

