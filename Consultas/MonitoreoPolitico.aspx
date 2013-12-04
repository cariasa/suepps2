<%@ Page Title="Monitoreo de Políticas" Language="VB" MasterPageFile="~/Site.master" AutoEventWireup="false" CodeFile="MonitoreoPolitico.aspx.vb" Inherits="Consultas_MonitoreoPolitico" %>

<%@ Register Src="~/MOCA_UE.ascx" TagPrefix="uc1" TagName="MOCA_UE" %>


<asp:Content ID="cHeader" ContentPlaceHolderID="HeadContent" runat="Server">
</asp:Content>
<asp:Content ID="cBody" ContentPlaceHolderID="MainContent" runat="Server">
    <uc1:MOCA_UE runat="server" ID="MOCA_UE01" />
    <%-- ASPxGridViewPoliticas --%>
    <dx:ASPxGridView ID="ASPxGridViewPoliticas" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSourcePoliticas" KeyFieldName="IdPolitica"
        ShowDetailRow="true" SettingsBehavior-AllowFocusedRow="true" SettingsDetail-AllowOnlyOneMasterRowExpanded="true" OnHtmlRowPrepared="ASPxGridViewPoliticas_HtmlRowPrepared" Settings-ShowFilterRow="true">
        <Columns>
            <dx:GridViewDataTextColumn FieldName="IdPolitica" ReadOnly="True" VisibleIndex="0" Visible="false">
                <EditFormSettings Visible="False"></EditFormSettings>
            </dx:GridViewDataTextColumn>

            <dx:GridViewDataTextColumn FieldName="Nombre" VisibleIndex="1" Caption="Política">
                <Settings AutoFilterCondition="Contains" />
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="SujetosDeAtencion" VisibleIndex="4" Caption="Sujetos de Atención">
                <Settings AutoFilterCondition="Contains" />
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="PorcentajeEjecucion" VisibleIndex="4" PropertiesTextEdit-DisplayFormatString="P" Caption="Porcentaje de Ejecución">
                <Settings AllowAutoFilter="False" />
            </dx:GridViewDataTextColumn>
        </Columns>
        <SettingsPager>
            <AllButton Visible="True" Text="Todos">
            </AllButton>
        </SettingsPager>
        <SettingsDetail ShowDetailRow="True" />
        <Templates>
            <DetailRow>
                <%-- ASPxGridViewComponentesPoliticas --%>
                <dx:ASPxGridView ID="ASPxGridViewComponentesPoliticas" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSourceComponentesPoliticas"
                    KeyFieldName="IdComponentesDePolitica" IsDetailGrid="true" OnBeforePerformDataSelect="ASPxGridViewComponentesPoliticas_BeforePerformDataSelect"
                    Settings-ShowFooter="true" SettingsDetail-AllowOnlyOneMasterRowExpanded="true" OnHtmlRowPrepared="ASPxGridViewComponentesPoliticas_HtmlRowPrepared">
                    <TotalSummary>
                        <dx:ASPxSummaryItem FieldName="Peso" SummaryType="Sum" Tag="Total" />
                    </TotalSummary>
                    <Columns>
                        <dx:GridViewDataTextColumn FieldName="IdComponentesDePolitica" ReadOnly="True" VisibleIndex="0" Visible="false">
                            <EditFormSettings Visible="False"></EditFormSettings>
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataComboBoxColumn VisibleIndex="2" FieldName="IdPolitica" Caption="Política">
                            <PropertiesComboBox ValueType="System.String"
                                DataSourceID="SqlDataSourcePoliticasComboGrid"
                                ValueField="IdPolitica"
                                TextField="Nombre" />
                        </dx:GridViewDataComboBoxColumn>
                        <dx:GridViewDataTextColumn FieldName="Nombre" VisibleIndex="1" Caption="Componente"></dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn FieldName="Descripcion" VisibleIndex="3" Caption="Descripción"></dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn FieldName="Peso" VisibleIndex="4"></dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn FieldName="PorcentajeEjecucion" VisibleIndex="4" PropertiesTextEdit-DisplayFormatString="P" Caption="Porcenta de Ejecución"></dx:GridViewDataTextColumn>
                    </Columns>
                    <SettingsPager>
                        <AllButton Visible="True" Text="Todos">
                        </AllButton>
                    </SettingsPager>
                    <SettingsDetail ShowDetailRow="True" />
                    <Templates>
                        <DetailRow>
                            <%-- Metas de Componentes --%>
                            <dx:ASPxGridView ID="ASPxGridViewMetasComponentes" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSourceMetasComponentes"
                                KeyFieldName="IdMetasDeComponente" IsDetailGrid="true"
                                Visible="true" Settings-ShowFooter="true" SettingsDetail-AllowOnlyOneMasterRowExpanded="true"
                                OnBeforePerformDataSelect="ASPxGridViewMetasComponentes_BeforePerformDataSelect" OnHtmlRowPrepared="ASPxGridViewMetasComponentes_HtmlRowPrepared">
                                <TotalSummary>
                                    <dx:ASPxSummaryItem FieldName="Peso" SummaryType="Sum" Tag="Total" />
                                </TotalSummary>
                                <Columns>
                                    <dx:GridViewDataTextColumn FieldName="IdMetasDeComponente" ReadOnly="True" VisibleIndex="0" Visible="false">
                                        <EditFormSettings Visible="False"></EditFormSettings>
                                    </dx:GridViewDataTextColumn>

                                    <dx:GridViewDataComboBoxColumn VisibleIndex="2" FieldName="IdComponentesDePolitica" Caption="Componente">
                                        <PropertiesComboBox ValueType="System.String"
                                            DataSourceID="SqlDataSourceComponentesPoliticasComboGrid"
                                            ValueField="IdComponentesDePolitica"
                                            TextField="Nombre" />


                                    </dx:GridViewDataComboBoxColumn>
                                    <dx:GridViewDataTextColumn FieldName="Nombre" VisibleIndex="1" Caption="Meta"></dx:GridViewDataTextColumn>
                                    <dx:GridViewDataTextColumn FieldName="Descripcion" VisibleIndex="3" Caption="Descripción"></dx:GridViewDataTextColumn>
                                    <dx:GridViewDataTextColumn FieldName="Peso" VisibleIndex="4"></dx:GridViewDataTextColumn>
                                    <dx:GridViewDataTextColumn FieldName="PorcentajeEjecucion" VisibleIndex="4" PropertiesTextEdit-DisplayFormatString="P" Caption="Porcentaje de Ejecución"></dx:GridViewDataTextColumn>
                                </Columns>
                                <SettingsPager>
                                    <AllButton Visible="True" Text="Todos">
                                    </AllButton>
                                </SettingsPager>
                                <SettingsDetail ShowDetailRow="True" />
                                <Templates>
                                    <DetailRow>
                                        <%-- Indicadores de Metas --%>
                                        <dx:ASPxGridView ID="ASPxGridViewindicadoresMetas" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSourceIndicadoresMetas"
                                            KeyFieldName="IdIndicadorDeMeta" IsDetailGrid="true" OnBeforePerformDataSelect="ASPxGridViewindicadoresMetas_BeforePerformDataSelect"
                                            Visible="true" Settings-ShowFooter="true" SettingsDetail-AllowOnlyOneMasterRowExpanded="true"
                                            OnHtmlRowPrepared="ASPxGridViewindicadoresMetas_HtmlRowPrepared">
                                            <TotalSummary>
                                                <dx:ASPxSummaryItem FieldName="Peso" SummaryType="Sum" Tag="Total" />
                                            </TotalSummary>
                                            <Columns>
                                                <dx:GridViewDataTextColumn FieldName="IdIndicadorDeMeta" ReadOnly="True" VisibleIndex="0" Visible="false">
                                                    <EditFormSettings Visible="False"></EditFormSettings>
                                                </dx:GridViewDataTextColumn>

                                                <dx:GridViewDataComboBoxColumn VisibleIndex="2" FieldName="IdMetasDeComponente" Caption="Meta">
                                                    <PropertiesComboBox ValueType="System.String"
                                                        DataSourceID="SqlDataSourceMetasDeComponenteComboGrid"
                                                        ValueField="IdMetasDeComponente"
                                                        TextField="Nombre" />


                                                </dx:GridViewDataComboBoxColumn>

                                                <dx:GridViewDataComboBoxColumn VisibleIndex="1" FieldName="IdIndicador" Caption="Indicador">
                                                    <PropertiesComboBox ValueType="System.String"
                                                        DataSourceID="SqlDataSourceIndicadoresComboGrid"
                                                        ValueField="IdIndicador"
                                                        TextField="DescripcionIndicador" />


                                                </dx:GridViewDataComboBoxColumn>
                                                <dx:GridViewDataTextColumn FieldName="Peso" VisibleIndex="3"></dx:GridViewDataTextColumn>
                                                <dx:GridViewDataTextColumn FieldName="PorcentajeEjecucion" VisibleIndex="3" PropertiesTextEdit-DisplayFormatString="P" Caption="Porcentaje de Ejecución"></dx:GridViewDataTextColumn>
                                            </Columns>
                                            <SettingsPager>
                                                <AllButton Visible="True" Text="Todos">
                                                </AllButton>
                                            </SettingsPager>
                                            <SettingsDetail ShowDetailRow="True" />
                                            <Templates>
                                                <DetailRow>
                                                    <%-- Programas Indicadores Metas --%>
                                                    <dx:ASPxGridView ID="ASPxGridViewProgramasIndicadoresMetas" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSourceProgramasIndicadoresMetas"
                                                        KeyFieldName="IdProgramasPorIndicadorDeMeta" IsDetailGrid="true" OnBeforePerformDataSelect="ASPxGridViewProgramasIndicadoresMetas_BeforePerformDataSelect"
                                                        Visible="true" Settings-ShowFooter="true" SettingsDetail-AllowOnlyOneMasterRowExpanded="true" OnHtmlRowPrepared="ASPxGridViewProgramasIndicadoresMetas_HtmlRowPrepared">
                                                        <TotalSummary>
                                                            <dx:ASPxSummaryItem FieldName="Peso" SummaryType="Sum" Tag="Total" />
                                                        </TotalSummary>
                                                        <Columns>
                                                            <dx:GridViewDataTextColumn FieldName="IdProgramasPorIndicadorDeMeta" ReadOnly="True" VisibleIndex="0" Visible="false">
                                                                <EditFormSettings Visible="False"></EditFormSettings>
                                                            </dx:GridViewDataTextColumn>
                                                            <dx:GridViewDataComboBoxColumn VisibleIndex="1" FieldName="IdPrograma" Caption="Programa/Proyecto">
                                                                <PropertiesComboBox ValueType="System.String"
                                                                    DataSourceID="SqlDataSourceProgramasComboGrid"
                                                                    ValueField="codigo_ficha"
                                                                    TextField="NombreProyecto" />
                                                            </dx:GridViewDataComboBoxColumn>
                                                            <dx:GridViewDataComboBoxColumn VisibleIndex="1" FieldName="IdIndicadorDeMeta" Caption="Indicador">
                                                                <PropertiesComboBox ValueType="System.String"
                                                                    DataSourceID="SqlDataSourceIndicadoresDeIndicadorDeMetaComboGrid"
                                                                    ValueField="IdIndicadorDeMeta"
                                                                    TextField="DescripcionIndicador" />
                                                            </dx:GridViewDataComboBoxColumn>
                                                            <dx:GridViewDataTextColumn FieldName="Peso" VisibleIndex="3"></dx:GridViewDataTextColumn>
                                                            <dx:GridViewDataTextColumn FieldName="PorcentajeEjecucion" VisibleIndex="4" PropertiesTextEdit-DisplayFormatString="P" Caption="Porcentaje Ejecución"></dx:GridViewDataTextColumn>
                                                        </Columns>
                                                        <SettingsDetail ShowDetailRow="True" />
                                                        <Templates>
                                                            <DetailRow>
                                                                <dx:ASPxGridView ID="ASPxGridViewIndicadoresRelevantes" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSourceIndicadoresRelevantes"
                                                                    KeyFieldName="IdIndicadoresRelevantesDePrograma" IsDetailGrid="true" OnBeforePerformDataSelect="ASPxGridViewIndicadoresRelevantes_BeforePerformDataSelect" Settings-ShowFooter="true" OnHtmlRowPrepared="ASPxGridViewIndicadoresRelevantes_HtmlRowPrepared">
                                                                    <TotalSummary>
                                                                        <dx:ASPxSummaryItem FieldName="Peso" SummaryType="Sum" Tag="Total" />
                                                                    </TotalSummary>
                                                                    <Columns>
                                                                        <dx:GridViewDataTextColumn FieldName="IdIndicadoresRelevantesDePrograma" ReadOnly="True" VisibleIndex="0" Visible="false">
                                                                            <EditFormSettings Visible="False"></EditFormSettings>
                                                                        </dx:GridViewDataTextColumn>
                                                                        <dx:GridViewDataComboBoxColumn VisibleIndex="2" FieldName="IdProgramaPorIndicadorDeMeta" Caption="Programa">
                                                                            <PropertiesComboBox ValueType="System.String"
                                                                                DataSourceID="SqlDataSourceProgramaPorIndicadorDeMetaComboGrid"
                                                                                ValueField="IdProgramasPorIndicadorDeMeta"
                                                                                TextField="NombreProyecto" />
                                                                        </dx:GridViewDataComboBoxColumn>
                                                                        <dx:GridViewDataComboBoxColumn VisibleIndex="1" FieldName="IdIndicadoresPorPrograma" Caption="Indicador">
                                                                            <PropertiesComboBox ValueType="System.String"
                                                                                DataSourceID="SqlDataSourceIndicadoresPorProgramaComboGrid"
                                                                                ValueField="IdIndicadoresPorPrograma"
                                                                                TextField="DescripcionIndicador" />
                                                                        </dx:GridViewDataComboBoxColumn>
                                                                        <dx:GridViewDataTextColumn FieldName="Peso" VisibleIndex="3"></dx:GridViewDataTextColumn>
                                                                        <dx:GridViewDataTextColumn FieldName="PorcentajeEjecucion" VisibleIndex="4" PropertiesTextEdit-DisplayFormatString="P" Caption="Porcentaje Ejecución"></dx:GridViewDataTextColumn>
                                                                    </Columns>
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
                </dx:ASPxGridView>

            </DetailRow>
        </Templates>
    </dx:ASPxGridView>

    <asp:SqlDataSource runat="server" ID="SqlDataSourcePoliticas" ConnectionString='<%$ ConnectionStrings:SUEPPSConnectionString %>'></asp:SqlDataSource>
    <asp:SqlDataSource runat="server" ID="SqlDataSourceIndicadoresRelevantes" ConnectionString='<%$ ConnectionStrings:SUEPPSConnectionString %>'>
        <SelectParameters>
            <asp:SessionParameter SessionField="IdProgramaPorIndicadorDeMeta" Name="IdProgramaPorIndicadorDeMeta" Type="Int32"></asp:SessionParameter>
        </SelectParameters>
    </asp:SqlDataSource>

    <%-- SelectCommand="SELECT [IdProgramaPorIndicadorDeMeta], [IdPrograma], [IdIndicadorDeMeta], [Peso] FROM [ProgramasPorIndicadorDeMeta] WHERE [Peso] <>0 AND [IdIndicadorDeMeta]=@IdIndicadorDeMeta" --%>
    <asp:SqlDataSource runat="server" ID="SqlDataSourceProgramasIndicadoresMetas" ConnectionString='<%$ ConnectionStrings:SUEPPSConnectionString %>'>
        <SelectParameters>
            <asp:SessionParameter SessionField="IdIndicadorDeMeta" Name="IdIndicadorDeMeta" Type="Int32"></asp:SessionParameter>
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource runat="server" ID="SqlDataSourceIndicadoresMetas" ConnectionString='<%$ ConnectionStrings:SUEPPSConnectionString %>'>
        <SelectParameters>
            <asp:SessionParameter SessionField="IdMetasDeComponente" Name="IdMetasDeComponente" Type="Int32"></asp:SessionParameter>
        </SelectParameters>
    </asp:SqlDataSource>



    <asp:SqlDataSource runat="server" ID="SqlDataSourceMetasComponentes" ConnectionString='<%$ ConnectionStrings:SUEPPSConnectionString %>'>

        <SelectParameters>

            <asp:SessionParameter SessionField="IdComponentesDePolitica" Name="IdComponentesDePolitica" Type="Int32"></asp:SessionParameter>

        </SelectParameters>
    </asp:SqlDataSource>

    <%-- aqui voy SELECT [IdComponentesDePolitica], [IdPolitica], [Nombre], [Descripcion], [Peso] FROM [ComponentesDePolitica] WHERE [IdPolitica]=@IdPolitica AND [Peso]<>0--%>
    <asp:SqlDataSource runat="server" ID="SqlDataSourceComponentesPoliticas" ConnectionString='<%$ ConnectionStrings:SUEPPSConnectionString %>'>
        <SelectParameters>
            <asp:SessionParameter SessionField="IdPolitica" Name="IdPolitica" Type="Int32"></asp:SessionParameter>
        </SelectParameters>
    </asp:SqlDataSource>

    <%-- SelectCommand="SELECT [IdPolitica], [Nombre], [ObjetivosEstrategicos], [ObjetivosEspecificos], [SujetosDeAtencion] FROM [Politicas]" --%>

    <asp:SqlDataSource runat="server" ID="SqlDataSourcePoliticasComboGrid" ConnectionString='<%$ ConnectionStrings:SUEPPSConnectionString %>' SelectCommand="SELECT [IdPolitica], [Nombre] FROM [Politicas]"></asp:SqlDataSource>
    <asp:SqlDataSource runat="server" ID="SqlDataSourceComponentesPoliticasComboGrid" ConnectionString='<%$ ConnectionStrings:SUEPPSConnectionString %>' SelectCommand="SELECT [IdComponentesDePolitica], [Nombre] FROM [ComponentesDePolitica]"></asp:SqlDataSource>
    <asp:SqlDataSource runat="server" ID="SqlDataSourceMetasDeComponenteComboGrid" ConnectionString='<%$ ConnectionStrings:SUEPPSConnectionString %>' SelectCommand="SELECT [IdMetasDeComponente], [Nombre] FROM [MetasDeComponente]"></asp:SqlDataSource>
    <asp:SqlDataSource runat="server" ID="SqlDataSourceIndicadoresComboGrid" ConnectionString='<%$ ConnectionStrings:SUEPPSConnectionString %>' SelectCommand="SELECT [IdIndicador], [DescripcionIndicador] FROM [Indicadores]"></asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSourceProgramasComboGrid" runat="server" ConnectionString='<%$ ConnectionStrings:SUEPPSConnectionString %>' SelectCommand="SELECT [codigo_ficha], [NombreProyecto] FROM [vProyectos]"></asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSourceIndicadoresDeIndicadorDeMetaComboGrid" runat="server" ConnectionString='<%$ ConnectionStrings:SUEPPSConnectionString %>' SelectCommand="SELECT m.[IdIndicadorDeMeta], i.[DescripcionIndicador]  FROM [Indicadores] i, [IndicadoresDeMeta] m WHERE i.[IdIndicador]=m.[IdIndicador]"></asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSourceProgramaPorIndicadorDeMetaComboGrid" runat="server" ConnectionString='<%$ ConnectionStrings:SUEPPSConnectionString %>' SelectCommand="SELECT m.[IdProgramasPorIndicadorDeMeta], i.[NombreProyecto]  FROM [vProyectos] i, [ProgramasPorIndicadorDeMeta] m WHERE i.[codigo_ficha]=m.[IdPrograma]"></asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSourceIndicadoresPorProgramaComboGrid" runat="server" ConnectionString='<%$ ConnectionStrings:SUEPPSConnectionString %>' SelectCommand="SELECT m.[IdIndicadoresPorPrograma], i.[DescripcionIndicador]  FROM [Indicadores] i, [IndicadoresPorPrograma] m WHERE i.[IdIndicador]=m.[IdIndicador]"></asp:SqlDataSource>
</asp:Content>

