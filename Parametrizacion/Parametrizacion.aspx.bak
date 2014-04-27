<%@ Page Language="VB" AutoEventWireup="false" CodeFile="Parametrizacion.aspx.vb" Inherits="Administracion_Parametrizacion"  MasterPageFile="~/Site.master"%>
<%@ Register Assembly="DevExpress.Web.v13.2, Version=13.2.7.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web.ASPxTabControl" TagPrefix="dx" %>
<%@ Register Assembly="DevExpress.Web.v13.2, Version=13.2.7.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web.ASPxPanel" TagPrefix="dx" %>
<%@ Register Assembly="DevExpress.Web.v13.2, Version=13.2.7.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web.ASPxGridView" TagPrefix="dx" %>
<%@ Register assembly="DevExpress.Web.v13.2, Version=13.2.7.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" namespace="DevExpress.Web.ASPxEditors" tagprefix="dx" %>
<%@ Register Assembly="DevExpress.Web.v13.2, Version=13.2.7.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web.ASPxClasses" TagPrefix="dx" %>
<%@ Register Assembly="DevExpress.Web.v13.2, Version=13.2.7.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web.ASPxMenu" TagPrefix="dx" %>


<%@ Register Src="~/MOCA_UE.ascx" TagPrefix="uc1" TagName="MOCA_UE" %>


<asp:Content ID="cHeader" ContentPlaceHolderID="HeadContent" Runat="Server">
</asp:Content>
<asp:Content ID="cBody" ContentPlaceHolderID="MainContent" Runat="Server">
    <uc1:MOCA_UE runat="server" ID="MOCA_UE01" />


<div>

    <script type="text/javascript">

        function click(e) {

            if (e.tab.index.toString() == "3") {
               
                ASPxGridViewPreguntas.PerformCallback();
             
            }
 
        }

        </script>



    <%--<dx:ASPxPageControl ID="carTabPage" runat="server" ActiveTabIndex="0" EnableHierarchyRecreation="True" Height="800%" Width="100%">--%>

    <dx:ASPxPageControl ID="carTabPage" runat="server" ActiveTabIndex="0" EnableHierarchyRecreation="True" >

        <ClientSideEvents ActiveTabChanged="function (s,e) {click(e);}" />
    
    <TabPages>
<%-- ######################################################################################################################################################################################### --%>
        <dx:TabPage Text="Tipos De Indicadores">
        <ContentCollection>
            <dx:ContentControl>
                <dx:ASPxGridView ID="ASPxGridViewTiposIndicadores" runat="server" DataSourceID="SqlDataSourceTiposIndicadores" AutoGenerateColumns="False" KeyFieldName="IdTipoDeIndicador" Width="100%" SettingsEditing-EditFormColumnCount="1">
                <Columns>
                <dx:GridViewDataTextColumn FieldName="IdTipoDeIndicador" ReadOnly="True" VisibleIndex="0" Visible="false">
                        <EditFormSettings Visible="False"></EditFormSettings>
                    </dx:GridViewDataTextColumn>
                    <dx:GridViewDataTextColumn FieldName="DescripcionTipoDeIndicador" VisibleIndex="1" Caption="Descripción Tipo Indicador"></dx:GridViewDataTextColumn>
                    <dx:GridViewDataTextColumn FieldName="NivelTipoDeIndicador" VisibleIndex="2"></dx:GridViewDataTextColumn>

                    <dx:GridViewDataTextColumn FieldName="CreadoPor" VisibleIndex="3" Visible="false"></dx:GridViewDataTextColumn>
                    <dx:GridViewDataDateColumn FieldName="FechaCreacion" VisibleIndex="4" Visible="false"></dx:GridViewDataDateColumn>
                    <dx:GridViewDataTextColumn FieldName="ActualizadoPor" VisibleIndex="5" Visible="false"></dx:GridViewDataTextColumn>
                    <dx:GridViewDataDateColumn FieldName="FechaActualizacion" VisibleIndex="6" Visible="false"></dx:GridViewDataDateColumn>

                    <dx:GridViewCommandColumn VisibleIndex="7" HeaderStyle-HorizontalAlign="Center" Caption="Acción" CellStyle-HorizontalAlign="NotSet">

                        <NewButton Visible="True" />
                        <EditButton Visible="true" />
                        <%-- No habrá botón de borrar, para no eliminar los Indicadores Creados en los que se apoya el sistema
                            Hay queries que cuentan con que la numeración de estos indicadores se mantenga como está:
                            1 Cobertura
                            2 Monitoreo
                            3 Efecto
                            4 Impacto
                        <DeleteButton Visible="true" />
                        --%>
<HeaderStyle HorizontalAlign="Center"></HeaderStyle>

                    </dx:GridViewCommandColumn>
                </Columns>

                <SettingsPager>
                                    <AllButton Visible="True" Text="Todos">
                                    </AllButton>
                                </SettingsPager>
                </dx:ASPxGridView>

                <asp:SqlDataSource runat="server" ID="SqlDataSourceTiposIndicadores" ConnectionString='<%$ ConnectionStrings:SUEPPSConnectionString %>' 
                        SelectCommand="SELECT * FROM [TiposDeIndicador] Where [Activo]=1 "
                        InsertCommand="INSERT INTO [TiposDeIndicador] ([DescripcionTipoDeIndicador], [NivelTipoDeIndicador], [CreadoPor], [FechaCreacion], [Activo]) VALUES (@DescripcionTipoDeIndicador, @NivelTipoDeIndicador, @Creado, getDate(), 1)"
                        UpdateCommand="UPDATE [TiposDeIndicador] SET [DescripcionTipoDeIndicador] = @DescripcionTipoDeIndicador, [NivelTipoDeIndicador] = @NivelTipoDeIndicador, [ActualizadoPor]=@Actualizado, [FechaActualizacion]=getDate() WHERE [IdTipoDeIndicador] = @IdTipoDeIndicador"
                        DeleteCommand="UPDATE [TiposDeIndicador] SET [Activo]=0 WHERE [IdTipoDeIndicador] = @IdTipoDeIndicador">

                    <InsertParameters>
                        <asp:SessionParameter Name="Creado" />
                        <asp:FormParameter Name="DescripcionTipoDeIndicador" />
                        <asp:FormParameter Name="NivelTipoDeIndicador" />
                    </InsertParameters>

                    <UpdateParameters>
                        <asp:SessionParameter Name="Actualizado" />
                        <asp:FormParameter Name="DescripcionTipoDeIndicador" />
                        <asp:FormParameter Name="NivelTipoDeIndicador" />
                        

                    </UpdateParameters>

                 </asp:SqlDataSource>                

            </dx:ContentControl>
        </ContentCollection>
        </dx:TabPage>
        
        
   <%-- ###################################################################################################################################################################################################### --%>     
        <dx:TabPage Text="Banco de Indicadores">
            <ContentCollection> 
            <dx:ContentControl>    
                <dx:ASPxGridView ID="ASPxGridViewIndicadores" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSourceIndicadores" KeyFieldName="IdIndicador" Width="100%" SettingsEditing-EditFormColumnCount="1" Settings-ShowFilterRow="true">
                <Columns>

                    <dx:GridViewDataTextColumn FieldName="IdIndicador" ReadOnly="True" VisibleIndex="0" Visible="false">
                        <EditFormSettings Visible="False"></EditFormSettings>
                    </dx:GridViewDataTextColumn>
                
                    <dx:GridViewDataComboBoxColumn VisibleIndex="2" FieldName="IdSectorIndicador" Caption="Sector del Indicador">
                        <PropertiesComboBox ValueType="System.String" 
                
                            DataSourceID="SqlDataSourceSectores" 
                            ValueField="IdSectorIndicador" 
                            TextField="DescripcionSectorIndicador"/>
                         <Settings AllowAutoFilter="True" />
                                    <Settings AutoFilterCondition="Contains" />
                                    <Settings FilterMode="DisplayText" />
     
                    
                    </dx:GridViewDataComboBoxColumn>

                    <dx:GridViewDataComboBoxColumn VisibleIndex="3" FieldName="IdTipoDeIndicador" Caption="Tipo Del Indicador">
                        <PropertiesComboBox ValueType="System.String" 
                
                            DataSourceID="SqlDataSourceTipo" 
                            ValueField="IdTipoDeIndicador" 
                            TextField="DescripcionTipoDeIndicador"/>
                         <Settings AllowAutoFilter="True" />
                                    <Settings AutoFilterCondition="Contains" />
                                    <Settings FilterMode="DisplayText" />
     
                    
                    </dx:GridViewDataComboBoxColumn>

                    <dx:GridViewDataTextColumn FieldName="DescripcionIndicador" VisibleIndex="1" Caption="Descripción Indicador">
                        <Settings AutoFilterCondition="Contains" />
                    </dx:GridViewDataTextColumn>
                    <dx:GridViewDataTextColumn FieldName="UnidadIndicador" VisibleIndex="4"></dx:GridViewDataTextColumn>

                
                
                    <dx:GridViewDataComboBoxColumn VisibleIndex="5" FieldName="IdFactorIndicador" Caption="Factor">
                        <PropertiesComboBox ValueType="System.String" 
                
                            DataSourceID="SqlDataSourceFactor" 
                            ValueField="IdFactorIndicador" 
                            TextField="DescripcionFactorIndicador"/>
                         <Settings AllowAutoFilter="True" />
                                    <Settings AutoFilterCondition="Contains" />
                                    <Settings FilterMode="DisplayText" />
     
                    
                    </dx:GridViewDataComboBoxColumn>

                    <dx:GridViewDataTextColumn FieldName="CreadoPor" VisibleIndex="7" Visible="false"></dx:GridViewDataTextColumn>
                    <dx:GridViewDataDateColumn FieldName="FechaCreacion" VisibleIndex="8" Visible="false"></dx:GridViewDataDateColumn>
                    <dx:GridViewDataTextColumn FieldName="ActualizadoPor" VisibleIndex="9" Visible="false"></dx:GridViewDataTextColumn>
                    <dx:GridViewDataDateColumn FieldName="FechaActualizacion" VisibleIndex="10" Visible="false"></dx:GridViewDataDateColumn>

                    <dx:GridViewCommandColumn VisibleIndex="11" HeaderStyle-HorizontalAlign="Center" Caption="Acción" CellStyle-HorizontalAlign="NotSet">

                            <NewButton Visible="True" />
                            <EditButton Visible="true" />
                            <DeleteButton Visible="true" />

<HeaderStyle HorizontalAlign="Center"></HeaderStyle>

                    </dx:GridViewCommandColumn>

            </Columns>
            <SettingsPager>
                <AllButton Visible="True" Text="Todos">
                </AllButton>
            </SettingsPager>
            </dx:ASPxGridView>


            <asp:SqlDataSource runat="server" ID="SqlDataSourceIndicadores" ConnectionString='<%$ ConnectionStrings:SUEPPSConnectionString %>' 
                SelectCommand="SELECT * FROM [Indicadores] WHERE [Activo]=1"
                UpdateCommand="UPDATE Indicadores SET IdSectorIndicador=@IdSectorIndicador, IdTipoDeIndicador=@IdTipoDeIndicador, DescripcionIndicador=@DescripcionIndicador, UnidadIndicador=@UnidadIndicador, IdFactorIndicador=@IdFactorIndicador, ActualizadoPor=@Actualizado, FechaActualizacion=getDate() WHERE IdIndicador=@IdIndicador"
                InsertCommand="INSERT INTO Indicadores (IdSectorIndicador, IdTipoDeIndicador, DescripcionIndicador, UnidadIndicador, IdFactorIndicador, CreadoPor, FechaCreacion, Activo) VALUES (@IdSectorIndicador, @IdTipoDeIndicador, @DescripcionIndicador, @UnidadIndicador, @IdFactorIndicador,@Creado,getDate(),1)"
                DeleteCommand="UPDATE [Indicadores] SET [Activo]=0 WHERE [IdIndicador] = @IdIndicador">
           

                <InsertParameters>
                    <asp:SessionParameter Name="Creado" />
                    <asp:FormParameter Name="IdSectorIndicador" />
                    <asp:FormParameter Name="IdTipoDeIndicador" />
                    <asp:FormParameter Name="DescripcionIndicador" />
                    <asp:FormParameter Name="UnidadIndicador" />
                    <asp:FormParameter Name="IdFactorIndicador" />
                </InsertParameters>

                 <UpdateParameters>
                     
                     <asp:SessionParameter Name="Actualizado" />
                    <asp:FormParameter Name="IdSectorIndicador" />
                    <asp:FormParameter Name="IdTipoDeIndicador" />
                    <asp:FormParameter Name="DescripcionIndicador" />
                    <asp:FormParameter Name="UnidadIndicador" />
                    <asp:FormParameter Name="IdFactorIndicador" />
                        

                 </UpdateParameters>

            </asp:SqlDataSource>
            <asp:SqlDataSource runat="server" ID="SqlDataSuorceTiposDeIndicador" ConnectionString='<%$ ConnectionStrings:SUEPPSConnectionString %>' SelectCommand="SELECT * FROM [TiposDeIndicadores] where Activo=1"></asp:SqlDataSource>
            <asp:SqlDataSource runat="server" ID="SqlDataSourceSectores" ConnectionString='<%$ ConnectionStrings:SUEPPSConnectionString %>' SelectCommand="SELECT IdSectorIndicador,DescripcionSectorIndicador FROM [vROISectorIndicadores]"></asp:SqlDataSource>
            <asp:SqlDataSource runat="server" ID="SqlDataSourceTipo" ConnectionString='<%$ ConnectionStrings:SUEPPSConnectionString %>' SelectCommand="SELECT * FROM [TiposDeIndicador] where Activo=1"></asp:SqlDataSource>
            <asp:SqlDataSource runat="server" ID="SqlDataSourceFactor" ConnectionString='<%$ ConnectionStrings:SUEPPSConnectionString %>' SelectCommand="SELECT * FROM [FactorIndicador] where Activo=1"></asp:SqlDataSource>

        
        
            </dx:ContentControl>
            </ContentCollection>
        </dx:TabPage>

 <%-- ################################################################################################################################################################################################################## --%>


        <dx:TabPage Text="Secciones De Encuesta">
            <ContentCollection> 
            <dx:ContentControl>

    <dx:ASPxGridView ID="ASPxGridViewCategorias" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSourceCategorias" KeyFieldName="IdCategoriaDePregunta" Width="100%" SettingsEditing-EditFormColumnCount="1">
        <Columns>
            <dx:GridViewDataTextColumn FieldName="IdCategoriaDePregunta" ReadOnly="True" VisibleIndex="0" Caption="#">
                <EditFormSettings Visible="False"></EditFormSettings>
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="DescripcionCategoriaDePregunta" VisibleIndex="1" Caption="Descripción Categoría"></dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="Orden" VisibleIndex="2"></dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="CreadoPor" VisibleIndex="3" Visible="false"></dx:GridViewDataTextColumn>
            <dx:GridViewDataDateColumn FieldName="FechaCreacion" VisibleIndex="4" Visible="false"></dx:GridViewDataDateColumn>
            <dx:GridViewDataTextColumn FieldName="ActualizadoPor" VisibleIndex="5" Visible="false"></dx:GridViewDataTextColumn>
            <dx:GridViewDataDateColumn FieldName="FechaActualizacion" VisibleIndex="6" Visible="false"></dx:GridViewDataDateColumn>
            <dx:GridViewDataCheckColumn FieldName="Activo" VisibleIndex="7" Visible="false"></dx:GridViewDataCheckColumn>
            <dx:GridViewCommandColumn VisibleIndex="8" HeaderStyle-HorizontalAlign="Center" Caption="Acción" CellStyle-HorizontalAlign="NotSet">

                        <NewButton Visible="True" />
                        <EditButton Visible="true" />
                        <DeleteButton Visible="true" />

<HeaderStyle HorizontalAlign="Center"></HeaderStyle>

                        </dx:GridViewCommandColumn>
        </Columns>
        <SettingsPager>
                                    <AllButton Visible="True" Text="Todos">
                                    </AllButton>
                                </SettingsPager>
    </dx:ASPxGridView>


    <asp:SqlDataSource runat="server" ID="SqlDataSourceCategorias" ConnectionString='<%$ ConnectionStrings:SUEPPSConnectionString %>' 
        SelectCommand="SELECT * FROM [CategoriasDePregunta] WHERE [Activo]=1"
        InsertCommand="INSERT INTO [CategoriasDePregunta] (DescripcionCategoriaDePregunta, Orden,  CreadoPor, FechaCreacion, Activo) VALUES (@DescripcionCategoriaDePregunta, @Orden,@Usuario, getDate(), 1) "
        UpdateCommand="UPDATE [CategoriasDePregunta] SET DescripcionCategoriaDePregunta=@DescripcionCategoriaDePregunta, Orden=@Orden, ActualizadoPor=@Actualizado, FechaActualizacion=getDate() WHERE IdCategoriaDePregunta=@IdCategoriaDePregunta" 
        DeleteCommand="UPDATE [CategoriasDePregunta] SET Activo=0 WHERE IdCategoriaDePregunta=@IdCategoriaDePregunta" 
        >
        <InsertParameters>
            <asp:SessionParameter Name="Usuario" />
            <asp:FormParameter Name="DescripcionCategoriaDePregunta" />
            <asp:FormParameter Name="Orden" />
        </InsertParameters>

        <UpdateParameters>
            <asp:SessionParameter Name="Actualizado" />
            <asp:FormParameter Name="DescripcionCategoriaDePregunta" />
            <asp:FormParameter Name="Orden" />
        </UpdateParameters>


    </asp:SqlDataSource>
</dx:ContentControl>
            </ContentCollection>
        </dx:TabPage>
<%-- ################################################################################################################################################################################################################## --%>
        <dx:TabPage Text="Preguntas Básicas">
            <ContentCollection> 
            <dx:ContentControl>
                    <dx:ASPxGridView ID="ASPxGridViewPreguntas" ClientInstanceName="ASPxGridViewPreguntas" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSourcePreguntas" KeyFieldName="IdPreguntaDeMonitoreo" ShowDetailRow="true" Width="100%" SettingsEditing-EditFormColumnCount="1" SettingsEditing-Mode="EditFormAndDisplayRow">
                    <Columns>
                            <dx:GridViewDataTextColumn FieldName="IdPreguntaDeMonitoreo" ReadOnly="True" VisibleIndex="0" Visible="false">
                                <EditFormSettings Visible="False"></EditFormSettings>
                            </dx:GridViewDataTextColumn>

                            <dx:GridViewDataComboBoxColumn VisibleIndex="2" FieldName="IdTipoDePregunta" Caption="Tipo de Pregunta">
                                <PropertiesComboBox ValueType="System.String" 
                
                                    DataSourceID="SqlDataSourceTiposPreguntas" 
                                    ValueField="IdTipoDePregunta" 
                                    TextField="NombreTipoDePregunta"/>
     
                    
                            </dx:GridViewDataComboBoxColumn>
                
                            <dx:GridViewDataTextColumn FieldName="DescripcionPreguntaDeMonitoreo" VisibleIndex="1" Caption="Pregunta"></dx:GridViewDataTextColumn>
                            <%--<dx:GridViewDataTextColumn FieldName="IdCategoriaDePregunta" VisibleIndex="3" Caption="Categorìa"></dx:GridViewDataTextColumn>--%>
                            <dx:GridViewDataComboBoxColumn VisibleIndex="3" FieldName="IdCategoriaDePregunta" Caption="Categoría">
                                <PropertiesComboBox ValueType="System.String" 
                
                                    DataSourceID="SqlDataSourceCategoriasPregunta" 
                                    ValueField="IdCategoriaDePregunta" 
                                    TextField="DescripcionCategoriaDePregunta"/>
     
                    
                            </dx:GridViewDataComboBoxColumn>

                            <dx:GridViewDataTextColumn FieldName="Orden" VisibleIndex="4"></dx:GridViewDataTextColumn>

                            <dx:GridViewDataCheckColumn FieldName="EsGeneral" VisibleIndex="5" Visible="false"></dx:GridViewDataCheckColumn>
                            <dx:GridViewCommandColumn VisibleIndex="6" HeaderStyle-HorizontalAlign="Center" Caption="Acción" CellStyle-HorizontalAlign="NotSet">

                                    <NewButton Visible="True" />
                                    <EditButton Visible="true" />
                                    <DeleteButton Visible="true" />

                            <HeaderStyle HorizontalAlign="Center"></HeaderStyle>

                            </dx:GridViewCommandColumn>
                            <dx:GridViewDataTextColumn FieldName="CreadoPor" VisibleIndex="7" Visible="false"></dx:GridViewDataTextColumn>
                            <dx:GridViewDataDateColumn FieldName="FechaCreacion" VisibleIndex="8" Visible="false"></dx:GridViewDataDateColumn>
                            <dx:GridViewDataTextColumn FieldName="ActualizadoPor" VisibleIndex="9" Visible="false"></dx:GridViewDataTextColumn>
                            <dx:GridViewDataDateColumn FieldName="FechaActualizacion" VisibleIndex="10" Visible="false"></dx:GridViewDataDateColumn>
                            <dx:GridViewDataDateColumn FieldName="Activo" VisibleIndex="11" Visible="false"></dx:GridViewDataDateColumn>
                        </Columns>
                        <SettingsPager>
                                    <AllButton Visible="True" Text="Todos">
                                    </AllButton>
                                </SettingsPager>


                        <SettingsDetail ShowDetailRow="True" />
                        <Templates>
                        <DetailRow>
                            <dx:ASPxGridView ID="ASPxGridViewOpciones" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSourceOpciones" KeyFieldName="IdOpcionDePregunta" IsDetailGrid="true" onbeforeperformdataselect="ASPxGridView2_BeforePerformDataSelect" Visible="<%#IsGridOpcionesVisible(Container.KeyValue)%>" Width="100%" SettingsEditing-EditFormColumnCount="1">
                                <Columns>
                                    <dx:GridViewDataTextColumn FieldName="IdOpcionDePregunta" ReadOnly="True" VisibleIndex="0" Visible="false">
                                        <EditFormSettings Visible="False" />
                                    </dx:GridViewDataTextColumn>
                                    <dx:GridViewDataTextColumn FieldName="DescripcionOpcionDePregunta" VisibleIndex="1" Caption="Opción">
                                    </dx:GridViewDataTextColumn>
                                    <dx:GridViewDataTextColumn FieldName="IdPreguntaDeMonitoreo" VisibleIndex="2" Visible="false">
                                    </dx:GridViewDataTextColumn>
                                    <dx:GridViewCommandColumn VisibleIndex="3" HeaderStyle-HorizontalAlign="Center" Caption="Acción" CellStyle-HorizontalAlign="NotSet">

                                            <NewButton Visible="True" />
                                            <EditButton Visible="true" />
                                            <DeleteButton Visible="true" />

                                        </dx:GridViewCommandColumn>
                                    </Columns>
                                </dx:ASPxGridView>
                            </DetailRow>
                        </Templates>

                    </dx:ASPxGridView>

                 <asp:SqlDataSource runat="server" ID="SqlDataSourcePreguntas" ConnectionString='<%$ ConnectionStrings:SUEPPSConnectionString %>' 
                    SelectCommand="SELECT p.IdPreguntaDeMonitoreo, p.IdTipoDePregunta, p.IdTipoDeActor, p.IdPrograma, p.DescripcionPreguntaDeMonitoreo, p.Orden, p.EsGeneral, p.CreadoPor, p.FechaCreacion, p.CreadoPor, p.FechaActualizacion, p.Activo, p.IdCategoriaDePregunta  FROM [PreguntasDeMonitoreo] p, CategoriasDePregunta cp WHERE p.[Activo]=1 and p.[EsGeneral]= 1 and cp.IdCategoriaDePregunta = p.IdCategoriaDePregunta order by cp.Orden, p.Orden "
                    UpdateCommand="UPDATE PreguntasDeMonitoreo SET IdTipoDePregunta=@IdTipoDePregunta, DescripcionPreguntaDeMonitoreo=@DescripcionPreguntaDeMonitoreo, IdCategoriaDePregunta=@IdCategoriaDePregunta, Orden=@Orden, ActualizadoPor=@Actualizado, FechaActualizacion=getDate() WHERE [IdPreguntaDeMonitoreo] = @IdPreguntaDeMonitoreo "
                    InsertCommand="INSERT INTO PreguntasDeMonitoreo (IdTipoDePregunta, DescripcionPreguntaDeMonitoreo, IdCategoriaDePregunta, Orden,  EsGeneral, CreadoPor, FechaCreacion, Activo) VALUES(@IdTipoDePregunta, @DescripcionPreguntaDeMonitoreo, @IdCategoriaDePregunta, @Orden,  1, @Usuario, getDate(), 1)"
                    DeleteCommand="UPDATE [PreguntasDeMonitoreo] SET [Activo]=0 WHERE [IdPreguntaDeMonitoreo] = @IdPreguntaDeMonitoreo"
                 >
                        <DeleteParameters>
                            <asp:Parameter Name="IdPreguntaDeMonitoreo"></asp:Parameter>
                        </DeleteParameters>
                        <InsertParameters>
                            <asp:SessionParameter Name="Usuario" />
                            <asp:FormParameter Name="IdTipoDePregunta"></asp:FormParameter>
                            <asp:FormParameter Name="DescripcionPreguntaDeMonitoreo"></asp:FormParameter>
                            <asp:FormParameter Name="IdCategoriaDePregunta"></asp:FormParameter>
                            <asp:FormParameter Name="Orden"></asp:FormParameter>
                        </InsertParameters>

                        <UpdateParameters>
                            <asp:SessionParameter Name="Actualizado" />
                            <asp:FormParameter Name="IdTipoDePregunta"></asp:FormParameter>
                            <asp:FormParameter Name="DescripcionPreguntaDeMonitoreo"></asp:FormParameter>
                            <asp:FormParameter Name="IdCategoriaDePregunta"></asp:FormParameter>
                            <asp:FormParameter Name="Orden"></asp:FormParameter>
                            <asp:FormParameter Name="IdPreguntaDeMonitoreo"></asp:FormParameter>
                        </UpdateParameters>
                </asp:SqlDataSource>

                <asp:SqlDataSource runat="server" ID="SqlDataSourceTiposPreguntas" ConnectionString='<%$ ConnectionStrings:SUEPPSConnectionString %>' SelectCommand="SELECT [IdTipoDePregunta],[NombreTipoDePregunta] FROM [TiposDePreguntas] where Activo=1 "></asp:SqlDataSource>
                
                <asp:SqlDataSource runat="server" ID="SqlDataSourceCategoriasPregunta" ConnectionString='<%$ ConnectionStrings:SUEPPSConnectionString %>' SelectCommand="SELECT [IdCategoriaDePregunta], [DescripcionCategoriaDePregunta] FROM [CategoriasDePregunta] where Activo=1"></asp:SqlDataSource>



            <asp:SqlDataSource runat="server" ID="SqlDataSourceOpciones" ConnectionString='<%$ ConnectionStrings:SUEPPSConnectionString %>' 
                    SelectCommand="SELECT * FROM [OpcionesDePregunta] WHERE ([IdPreguntaDeMonitoreo] = @IdPreguntaDeMonitoreo AND [Activo]=1)"
                    InsertCommand="Insert INTO [OpcionesDePregunta] ([DescripcionOpcionDePregunta], [IdPreguntaDeMonitoreo], [CreadoPor], [FechaCreacion], [Activo]) VALUES (@DescripcionOpcionDePregunta, @IdPreguntaDeMonitoreo, @Usuario, getDate(), 1)"
                    UpdateCommand="Update [OpcionesDePregunta] SET [DescripcionOpcionDePregunta]=@DescripcionOpcionDePregunta, [ActualizadoPor]=@Actualizado, [FechaActualizacion]=getDate() WHERE [IdOpcionDePregunta] = @IdOpcionDePregunta"
                    DeleteCommand="Update [OpcionesDePregunta] SET [Activo]=0 WHERE [IdOpcionDePregunta] = @IdOpcionDePregunta"
                    >
                <SelectParameters>
                    <asp:SessionParameter SessionField="IdPreguntaDeMonitoreo" Name="IdPreguntaDeMonitoreo" Type="Int32"></asp:SessionParameter>
                
                </SelectParameters>

                <InsertParameters>
                    <asp:SessionParameter SessionField="IdPreguntaDeMonitoreo" Name="IdPreguntaDeMonitoreo" Type="Int32"></asp:SessionParameter>
                    <asp:FormParameter Name="DescripcionOpcionDePregunta" />
                    <asp:SessionParameter Name="Usuario" />
                </InsertParameters>

                <UpdateParameters>
                    <asp:SessionParameter SessionField="IdPreguntaDeMonitoreo" Name="IdPreguntaDeMonitoreo" Type="Int32"></asp:SessionParameter>
                    <asp:FormParameter Name="DescripcionOpcionDePregunta" />
                    <asp:SessionParameter Name="Actualizado" />
                </UpdateParameters>
        
          
            </asp:SqlDataSource>
            </dx:ContentControl>
            </ContentCollection>
        </dx:TabPage>
<%-- ####################################################################################################################################################################################################### --%>
        <dx:TabPage Text="Tipos de Actores">
            <ContentCollection> 
            <dx:ContentControl>
                <dx:ASPxGridView ID="ASPxGridView3" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSourceTiposDeActor" KeyFieldName="IdTipoDeActor" Width="100%" SettingsEditing-EditFormColumnCount="1">
                    <Columns>
                        <dx:GridViewDataTextColumn FieldName="IdTipoDeActor" ReadOnly="True" VisibleIndex="0" Visible="false">
                            <EditFormSettings Visible="False"></EditFormSettings>
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn FieldName="NombreTipoDeActor" VisibleIndex="1" Width="35%" ></dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn FieldName="DescripcionTipoDeActor" VisibleIndex="2" Caption="Descripción Tipo Actor" Width="45%"></dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn FieldName="CreadoPor" VisibleIndex="3" Visible="false"></dx:GridViewDataTextColumn>
                        <dx:GridViewDataDateColumn FieldName="FechaCreacion" VisibleIndex="4" Visible="false"></dx:GridViewDataDateColumn>
                        <dx:GridViewDataTextColumn FieldName="ActualizadoPor" VisibleIndex="5" Visible="false"></dx:GridViewDataTextColumn>
                        <dx:GridViewDataDateColumn FieldName="FechaActualizacion" VisibleIndex="6" Visible="false"></dx:GridViewDataDateColumn>
                        <dx:GridViewCommandColumn VisibleIndex="7" HeaderStyle-HorizontalAlign="Center" Caption="Acción" CellStyle-HorizontalAlign="NotSet">

                        <NewButton Visible="True" />
                        <EditButton Visible="true" />
                        <DeleteButton Visible="true" />

<HeaderStyle HorizontalAlign="Center"></HeaderStyle>

                        </dx:GridViewCommandColumn>
                    </Columns>
                <SettingsPager>
                                    <AllButton Visible="True" Text="Todos">
                                    </AllButton>
                                </SettingsPager>
                </dx:ASPxGridView>
                <asp:SqlDataSource runat="server" ID="SqlDataSourceTiposDeActor" ConnectionString='<%$ ConnectionStrings:SUEPPSConnectionString %>' 
                    SelectCommand="SELECT * FROM [TiposDeActor] Where [Activo]=1"
                    InsertCommand="INSERT INTO [TiposDeActor] ([NombreTipoDeActor], [DescripcionTipoDeActor], [CreadoPor], [FechaCreacion], [Activo]) VALUES (@NombreTipoDeActor, @DescripcionTipoDeActor, @Usuario, getDate(),1)"
                    UpdateCommand="UPDATE [TiposDeActor] SET [NombreTipoDeActor] = @NombreTipoDeActor, [DescripcionTipoDeActor] = @DescripcionTipoDeActor, [ActualizadoPor]=@Actualizado, [FechaActualizacion]=getDate() WHERE [IdTipoDeActor] = @IdTipoDeActor"
                    DeleteCommand="UPDATE [TiposDeActor] SET [Activo]=0 WHERE [IdTipoDeActor] = @IdTipoDeActor">
                
                    <InsertParameters>
                        <asp:SessionParameter Name="Usuario" />
                        <asp:FormParameter Name="NombreTipoDeActor" />
                        <asp:FormParameter Name="DescripcionTipoDeActor" />
                    </InsertParameters>

                    <UpdateParameters>
                        <asp:SessionParameter Name="Actualizado" />
                        <asp:FormParameter Name="NombreTipoDeActor" />
                        <asp:FormParameter Name="DescripcionTipoDeActor" />
                    </UpdateParameters>
                
                </asp:SqlDataSource>

                

            </dx:ContentControl>
            </ContentCollection>
        </dx:TabPage>
        <%-- ########################################################################################################################################################################################################################################################## --%>
        

    </TabPages>
    </dx:ASPxPageControl>
           </div>
</asp:Content>