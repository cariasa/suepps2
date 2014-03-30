<%@ Page Title="Análisis Cualitativo Evaluación" Language="VB" AutoEventWireup="false" CodeFile="Analisis.aspx.vb" Inherits="Evaluacion_Levantamientos" MasterPageFile="~/Site.master" %>

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
                        <dx:ASPxLabel ID="ASPxLabelTitulo" runat="server" Font-Size="Large" />
                    </td>
                    <td>
                        <dx:ASPxLabel ID="espacio" runat="server" Text=" " Width="50"></dx:ASPxLabel>
                        <dx:ASPxHyperLink ID="ASPxHyperLinkRegresar" runat="server" Text="Regresar a Levantamientos" NavigateUrl="AplicacionInstrumento.aspx" />

                    </td>
                </tr>
            </table>
        </div>
        <dx:ASPxGridView ID="GridPreguntas" runat="server" KeyFieldName="IdPreguntaPorInstrumento" Width="100%" DataSourceID="SqlPreguntas">

            <Columns>

                <dx:GridViewDataTextColumn FieldName="IdPreguntaPorInstrumento" ReadOnly="True" Visible="false"
                    VisibleIndex="0">
                    <EditFormSettings Visible="False" />
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="IdInstrumentoDeEvaluacion" VisibleIndex="1" Visible="false">
                </dx:GridViewDataTextColumn>

                <dx:GridViewDataTextColumn FieldName="PreguntaDeInstrumento" Caption="Pregunta" VisibleIndex="3">
                    <EditFormSettings ColumnSpan="2" />
                </dx:GridViewDataTextColumn>

                <dx:GridViewDataTextColumn FieldName="IdAmigable" Caption="Código" VisibleIndex="3">
                    <EditFormSettings ColumnSpan="3" />
                </dx:GridViewDataTextColumn>

                <dx:GridViewDataComboBoxColumn VisibleIndex="4" FieldName="IdTipoDePregunta" Caption="Tipo de Pregunta">
                    <EditFormSettings ColumnSpan="1" />
                    <PropertiesComboBox ValueType="System.String"
                        DataSourceID="SqlDataSourceTiposPreguntas"
                        ValueField="IdTipoDePregunta"
                        TextField="NombreTipoDePregunta" />

                </dx:GridViewDataComboBoxColumn>

                <dx:GridViewDataTextColumn FieldName="NombreSeccion" Caption="Sección" VisibleIndex="5">
                </dx:GridViewDataTextColumn>



                <dx:GridViewDataTextColumn FieldName="Orden" VisibleIndex="6">
                    <EditFormSettings ColumnSpan="1" />
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

                    <dx:ASPxGridView ID="GridRespuestas" runat="server" AutoGenerateColumns="False" DataSourceID="SqlRespuestas"
                        KeyFieldName="IdRespuestaInstrumento" OnBeforePerformDataSelect="GridRespuestas_BeforePerformDataSelect1" IsDetailGrid="true"
                        Settings-ShowFooter="true" SettingsDetail-AllowOnlyOneMasterRowExpanded="true">
                        <Columns>

                            <dx:GridViewDataTextColumn FieldName="IdRespuestaInstrumento" ReadOnly="True" Caption="#" VisibleIndex="0" Visible="true">
                                <EditFormSettings Visible="False"></EditFormSettings>
                            </dx:GridViewDataTextColumn>
                            <dx:GridViewDataTextColumn FieldName="RespuestaTexto" VisibleIndex="1" Caption="Respuesta "></dx:GridViewDataTextColumn>
                            <dx:GridViewDataTextColumn FieldName="RespuestaLikert" VisibleIndex="2" Caption="Respuesta Likert"></dx:GridViewDataTextColumn>

                        </Columns>
                        <SettingsPager>
                            <AllButton Visible="True" Text="Todos">
                            </AllButton>
                        </SettingsPager>

                        <SettingsBehavior AllowFocusedRow="True" />

                        <SettingsDetail ShowDetailRow="True" ExportMode="All" />
                        <Templates>
                            <DetailRow>
                                <dx:ASPxGridView ID="ASPxGridViewOpciones" ClientInstanceName="ASPxGridViewOpciones" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSourceOpciones" KeyFieldName="IdOpcionRespuestaInstrumento" IsDetailGrid="true" OnBeforePerformDataSelect="ASPxGridViewOpciones_BeforePerformDataSelect1" Visible="<%#IsGridOpcionesVisible3(Container.KeyValue)%>">
                                    <Columns>
                                        <dx:GridViewDataTextColumn FieldName="IdOpcionRespuestaInstrumento" ReadOnly="True" VisibleIndex="0" Visible="false" Caption="#">
                                            <EditFormSettings Visible="False" />
                                        </dx:GridViewDataTextColumn>
                                        <dx:GridViewDataTextColumn FieldName="Valor" VisibleIndex="1" Caption="Valor">
                                        </dx:GridViewDataTextColumn>

                                        <dx:GridViewDataTextColumn FieldName="Opcion" VisibleIndex="2" Caption="Respuesta de Opción">
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

                    <dx:ASPxGridView ID="GridCualitativo" runat="server" AutoGenerateColumns="False" DataSourceID="SqlAnalisisCualitativo"
                        KeyFieldName="IdAnalisisCualitativo" OnBeforePerformDataSelect="ASPxGridView1_BeforePerformDataSelect" IsDetailGrid="true" Width="100%">
                        <Columns>

                            <dx:GridViewDataTextColumn FieldName="IdAnalisisCualitativo" ReadOnly="True" Caption="#" VisibleIndex="0" Visible="true">
                                <EditFormSettings Visible="False"></EditFormSettings>
                            </dx:GridViewDataTextColumn>
                            <dx:GridViewDataTextColumn FieldName="IdPreguntaPorInstrumento" VisibleIndex="1" Visible="false">
                                <EditFormSettings Visible="False"></EditFormSettings>
                            </dx:GridViewDataTextColumn>
                            <dx:GridViewDataTextColumn FieldName="Comentario" VisibleIndex="2" Caption="Comentario">
                                <EditFormSettings Visible="True"></EditFormSettings>
                            </dx:GridViewDataTextColumn>
                            <dx:GridViewCommandColumn VisibleIndex="3" HeaderStyle-HorizontalAlign="Center" Caption="Acción" CellStyle-HorizontalAlign="NotSet">

                                <NewButton Visible="True">
                                </NewButton>
                                <EditButton Visible="True">
                                </EditButton>
                                <DeleteButton Visible="True">
                                </DeleteButton>
                                <HeaderStyle HorizontalAlign="Center"></HeaderStyle>
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

        <asp:SqlDataSource ID="SqlRespuestas" runat="server" ConnectionString="<%$ ConnectionStrings:SUEPPSConnectionString %>"
            SelectCommand="SELECT a.IdRespuestaInstrumento, a.RespuestaTexto, a.RespuestaLikert FROM [RespuestasInstrumento] a join [PreguntasPorInstrumento] b on a.IdPreguntaPorInstrumento=b.IdPreguntaPorInstrumento join [InstrumentosDeEvaluacion] c on c.IdInstrumentoDeEvaluacion=b.IdInstrumentoDeEvaluacion join [AplicacionInstrumento] d on d.IdInstrumentoDeEvaluacion=c.IdInstrumentoDeEvaluacion where a.[IdPreguntaPorInstrumento]=@IdPreguntaPorInstrumento and d.[IdAplicacionInstrumento]=@IdAplicacion">
            <SelectParameters>
                <asp:SessionParameter Name="IdPreguntaPorInstrumento" />
                <asp:SessionParameter Name="IdAplicacion" />
            </SelectParameters>
        </asp:SqlDataSource>

        <asp:SqlDataSource ID="SqlAnalisisCualitativo" runat="server" ConnectionString="<%$ ConnectionStrings:SUEPPSConnectionString %>"
            SelectCommand="SELECT * FROM [AnalisisCualitativo] where [IdPreguntaPorInstrumento]=@IdPreguntaPorInstrumento and Activo=1"
            UpdateCommand="UPDATE [AnalisisCualitativo] SET [Comentario]=@Comentario where IdAnalisisCualitativo=@IdAnalisisCualitativo"
            InsertCommand="INSERT INTO [AnalisisCualitativo] ([IdPreguntaPorInstrumento],[Comentario],[CreadoPor]) values (@IdPreguntaPorInstrumento,@Comentario,@Usuario)"
            DeleteCommand="UPDATE [AnalisisCualitativo] SET [Activo]=0 where IdAnalisisCualitativo=@IdAnalisisCualitativo">
            
            <SelectParameters>
                <asp:SessionParameter Name="IdPreguntaPorInstrumento" />
            </SelectParameters>
            <UpdateParameters>
                <asp:FormParameter Name="Comentario" />
                <asp:FormParameter Name="IdAnalisisCualitativo" />
            </UpdateParameters>
            <DeleteParameters>
                <asp:FormParameter Name="IdAnalisisCualitativo" />
            </DeleteParameters>
            <InsertParameters>
                <asp:SessionParameter Name="IdPreguntaPorInstrumento" />
                <asp:FormParameter Name="Comentario" />
                <asp:SessionParameter Name="Usuario" />
            </InsertParameters>



        </asp:SqlDataSource>




        <asp:SqlDataSource runat="server" ID="SqlDataSourceOpciones" ConnectionString='<%$ ConnectionStrings:SUEPPSConnectionString %>'
            SelectCommand="SELECT a.[IdOpcionRespuestaInstrumento],b.[Valor],b.[Opcion] FROM [OpcionesRespuestaInstrumento] a join [OpcionesPreguntaPorInstrumento] b on a.IdOpcionPreguntaPorInstrumento= b.IdOpcionPreguntaPorInstrumento  WHERE (a.[IdRespuestaInstrumento] = @IdRespuesta )">
            <SelectParameters>
                <asp:SessionParameter Name="IdRespuesta" />
            </SelectParameters>
        </asp:SqlDataSource>

        <asp:SqlDataSource runat="server" ID="SqlDataSourceTiposPreguntas" ConnectionString='<%$ ConnectionStrings:SUEPPSConnectionString %>' SelectCommand="SELECT [IdTipoDePregunta],[NombreTipoDePregunta] FROM [TiposDePreguntas] where Activo=1 "></asp:SqlDataSource>

        <asp:SqlDataSource runat="server" ID="SqlDataSourceCategoriasPregunta" ConnectionString='<%$ ConnectionStrings:SUEPPSConnectionString %>' SelectCommand="SELECT [IdCategoriaDePregunta], [DescripcionCategoriaDePregunta] FROM [CategoriasDePregunta] where Activo=1"></asp:SqlDataSource>


        <asp:SqlDataSource ID="SqlPreguntas" runat="server" ConnectionString="<%$ ConnectionStrings:SUEPPSConnectionString %>">

            <SelectParameters>
                <asp:SessionParameter Name="IdInstrumento" />

            </SelectParameters>

        </asp:SqlDataSource>




    </div>
</asp:Content>

