<%@ Page Title="Planificación de Monitoreo Cualitativo" Language="VB" AutoEventWireup="false" CodeFile="Planificacion.aspx.vb" Inherits="RevisionSocial_Planificacion" MasterPageFile="~/Site.master" %>


<%@ Register Assembly="DevExpress.Web.v13.1, Version=13.1.8.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web.ASPxMenu" TagPrefix="dx" %>

<%@ Register Assembly="DevExpress.Web.v13.1, Version=13.1.8.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web.ASPxTabControl" TagPrefix="dx" %>

<%@ Register Assembly="DevExpress.Web.v13.1, Version=13.1.8.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web.ASPxPanel" TagPrefix="dx" %>

<%@ Register Assembly="DevExpress.Web.v13.1, Version=13.1.8.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web.ASPxGridView" TagPrefix="dx" %>

<%@ Register assembly="DevExpress.Web.v13.1, Version=13.1.8.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" namespace="DevExpress.Web.ASPxEditors" tagprefix="dx" %>

<%@ Register Assembly="DevExpress.Web.v13.1, Version=13.1.8.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web.ASPxClasses" TagPrefix="dx" %>

<%@ Register Src="~/MOCA_UE.ascx" TagPrefix="uc1" TagName="MOCA_UE" %>


<asp:Content ID="cHeader" ContentPlaceHolderID="HeadContent" Runat="Server">
</asp:Content>
<asp:Content ID="cBody" ContentPlaceHolderID="MainContent" Runat="Server">
    <uc1:MOCA_UE runat="server" ID="MOCA_UE01" />
    <div>
    

        <script type="text/javascript">
            function OnTabClick(e) {

                

                if (e.tab.index.toString() == "2") {
                    comboTipoActor.PerformCallback();
                    GridPreguntas.PerformCallback();
                }

                
            }
         </script>


                                    <div>


                                <dx:ASPxLabel runat="server" Text="0" ID="CodTipoActor"  Visible="false"/>

                                <dx:ASPxLabel runat="server" Text="0" ID="CodPrograma"  Visible="false"/>
                                <p></p>
                                <dx:ASPxLabel runat="server" Text=" " ID="Programa" />
                                <p></p>
                            </div>

        <dx:ASPxPageControl ID="Tab" runat="server" ActiveTabIndex="0" EnableHierarchyRecreation="True"
            Height="60%" Width="100%">
            <ClientSideEvents ActiveTabChanged="function (s,e) {OnTabClick(e);}" />            
            <TabPages>
                <dx:TabPage Text="Actores"  >
                    <ContentCollection>     
                       
                        <dx:ContentControl>


                            
                            <dx:ASPxGridView ID="ASPxGridView1" runat="server" AutoGenerateColumns="False" DataSourceID="SqlActoresPorPrograma" KeyFieldName="IdActorPorPrograma"  Settings-ShowFilterRow="true" OnLoad="ASPxGridView1_Load" Settings-ShowFilterRowMenu="true">
                                <Columns>
                                    <dx:GridViewDataTextColumn FieldName="IdActorPorPrograma" Caption="#" ReadOnly="True" ShowInCustomizationForm="True" Visible="false" VisibleIndex="0">
                                        <EditFormSettings Visible="False" />
                                    </dx:GridViewDataTextColumn>
                                    <dx:GridViewDataTextColumn FieldName="Usuario"  Caption="Usuario" ShowInCustomizationForm="True" VisibleIndex="1">
                                    <Settings AutoFilterCondition="Contains" />
                                    </dx:GridViewDataTextColumn>
                                    <dx:GridViewDataComboBoxColumn VisibleIndex="2" FieldName="IdTipoDeActor" Caption="Tipo De Actor" PropertiesComboBox-IncrementalFilteringMode="Contains">
                                        <PropertiesComboBox ValueType="System.String" 
                
                                                DataSourceID="SqlActor" 
                                                ValueField="IdTipoDeActor" 
                                                TextField="NombreTipoDeActor"/>
                                        <Settings AllowAutoFilter="True" />
                                    <Settings AutoFilterCondition="Contains" />
                                    <Settings FilterMode="DisplayText" />
     
                    
                                    </dx:GridViewDataComboBoxColumn>

                                    <dx:GridViewDataTextColumn FieldName="IdPrograma" ShowInCustomizationForm="True" Visible="false" VisibleIndex="3">
                                    <EditFormSettings Visible="False" /> 
                                    </dx:GridViewDataTextColumn>
                                    <dx:GridViewDataTextColumn FieldName="CreadoPor" ShowInCustomizationForm="True" VisibleIndex="4" Visible="false">
                                    <EditFormSettings Visible="False" />
                                    </dx:GridViewDataTextColumn>
                                    <dx:GridViewDataDateColumn FieldName="FechaCreacion" ShowInCustomizationForm="True" VisibleIndex="5" Visible="false">
                                    <EditFormSettings Visible="False" />
                                    </dx:GridViewDataDateColumn>
                                    <dx:GridViewDataTextColumn FieldName="ActualizadoPor" ShowInCustomizationForm="True" VisibleIndex="6" Visible="false">
                                    <EditFormSettings Visible="False" />
                                    </dx:GridViewDataTextColumn>
                                    <dx:GridViewDataDateColumn FieldName="FechaActualizacion" ShowInCustomizationForm="True" VisibleIndex="7" Visible="false">
                                    <EditFormSettings Visible="False" />
                                    </dx:GridViewDataDateColumn>
                                    <dx:GridViewDataCheckColumn FieldName="Activo" ShowInCustomizationForm="True" VisibleIndex="8" Visible="false">
                                    <EditFormSettings Visible="False" />
                                    </dx:GridViewDataCheckColumn>
                                    <dx:GridViewCommandColumn Caption="Acción">
                                        <NewButton Visible="true"></NewButton>
                                        <UpdateButton Visible="true"></UpdateButton>
                                        <EditButton Visible="true"></EditButton>
                                        <DeleteButton Visible="true"></DeleteButton>
                                    </dx:GridViewCommandColumn>
                                </Columns>
                                 <SettingsPager>
                       <AllButton Visible="True" Text="Todos">
                       </AllButton>
                    </SettingsPager>
                            </dx:ASPxGridView>

                            <asp:SqlDataSource ID="SqlActoresPorPrograma" runat="server" OnInserted="SqlActoresPorPrograma_Inserted" ConnectionString="<%$ ConnectionStrings:SUEPPSConnectionString %>" 
                                
                                SelectCommand="SELECT * FROM [ActoresPorPrograma] where IdPrograma=@IdPrograma and Activo=1"
                                 UpdateCommand="UPDATE [ActoresPorPrograma] SET [Usuario]=@Usuario, [IdTipoDeActor]=@IdTipoDeActor, [ActualizadoPor]=@Actualizado, [FechaActualizacion]=getDate() WHERE [IdActorPorPrograma]=@IdActorPorPrograma"
                                 DeleteCommand ="UPDATE [ActoresPorPrograma] SET [Activo]=0 , [ActualizadoPor]=@Actualizado, [FechaActualizacion]=getDate() WHERE [IdActorPorPrograma]=@IdActorPorPrograma" 
                                >
                                 <SelectParameters>
                                    <asp:SessionParameter Name="IdPrograma" /> 
                                                                
                                </SelectParameters>

                                <InsertParameters>
                                    <asp:SessionParameter Name="Programa" />
                                    <asp:SessionParameter Name="Creado" />
                                    <asp:FormParameter Name="Usuario" />
                                    <asp:FormParameter Name="IdTipoDeActor" />
                                    <asp:SessionParameter Name="AP" />
                                    
                            
                                </InsertParameters>
                                <UpdateParameters>
                                    <asp:SessionParameter Name="Actualizado" />
                                    <asp:FormParameter Name="Usuario" />
                                    <asp:FormParameter Name="IdTipoDeActor" />
                                    <asp:FormParameter Name="IdActorPorPrograma" />
                                    
                                </UpdateParameters>
                                <DeleteParameters>
                                    <asp:FormParameter Name="IdActorPorPrograma" />
                                    <asp:SessionParameter Name="Actualizado" />
                                </DeleteParameters>

                            </asp:SqlDataSource>

                             <asp:SqlDataSource runat="server" ID="SqlActor" ConnectionString='<%$ ConnectionStrings:SUEPPSConnectionString %>' 
                               SelectCommand="SELECT [IdTipoDeActor], [NombreTipoDeActor] FROM [TiposDeActor] where Activo=1"></asp:SqlDataSource>
                               

                        </dx:ContentControl>
                        

                     </ContentCollection>
               </dx:TabPage>


                <%-- Preguntas Por Programa --%>
                <dx:TabPage Text="Preguntas Por Programa"  >
                    <ContentCollection>
                     <dx:ContentControl ID="ContentControl1" runat="server" SupportsDisabledAttribute="True">   
                        
                         <dx:ASPxGridView ID="ASPxGridViewPreguntasPorPrograma" runat="server" ClientInstanceName="GridPreguntasPorPrograma" AutoGenerateColumns="False"  Settings-ShowFilterRow="true"
                            DataSourceID ="SqlDataSourcePreguntasPorPrograma"  KeyFieldName="IdPreguntaDeMonitoreo" OnBeforePerformDataSelect="ASPxGridViewPreguntasPorPrograma_BeforePerformDataSelect"

                            ShowDetailRow="true" Width="100%" OnLoad="ASPxGridViewPreguntasPorPrograma_Load" Settings-ShowFilterRowMenu="true" SettingsEditing-EditFormColumnCount="1">
                        <Columns>
                                <dx:GridViewDataTextColumn FieldName="IdPreguntaDeMonitoreo" Caption="#" ReadOnly="True" VisibleIndex="0">
                                    <EditFormSettings Visible="False"></EditFormSettings>
                                    <Settings AllowAutoFilter="False" />
                                    
                                </dx:GridViewDataTextColumn>
                            
                                <dx:GridViewDataTextColumn FieldName="DescripcionPreguntaDeMonitoreo" VisibleIndex="1" Caption="Pregunta">
                                    <Settings AllowAutoFilter="True" />
                                    <Settings AutoFilterCondition="Contains" />
                                    <Settings FilterMode="DisplayText" />
                                </dx:GridViewDataTextColumn>

                                <dx:GridViewDataComboBoxColumn VisibleIndex="2" FieldName="IdTipoDePregunta" Caption="Tipo de Pregunta">
                                  
                                    <PropertiesComboBox ValueType="System.String" 
                
                                        DataSourceID="SqlDataSourceTiposPreguntas" 
                                        ValueField="IdTipoDePregunta" 
                                        TextField="NombreTipoDePregunta"/>

                                    <Settings AllowAutoFilter="True" />
                                   <Settings AutoFilterCondition="Contains" />
                                    <Settings FilterMode="DisplayText" />
     
                    
                                </dx:GridViewDataComboBoxColumn>
                                
                                <dx:GridViewDataTextColumn FieldName="IdTipoDeActor" VisibleIndex="3"  Visible="false"></dx:GridViewDataTextColumn>


                                <dx:GridViewDataComboBoxColumn VisibleIndex="5" FieldName="IdCategoriaDePregunta" Caption="Categoria de Pregunta">
                               
                                  
                                   <PropertiesComboBox ValueType="System.String" 
                
                                        DataSourceID="SqlDataSourceTiposDeCategoria" 
                                        ValueField="IdCategoriaDePregunta" 
                                        TextField="DescripcionCategoriaDePregunta"/>

                                    <Settings AllowAutoFilter="True" />
                                   <Settings AutoFilterCondition="Contains" />
                                    <Settings FilterMode="DisplayText" />
     
                    
                                </dx:GridViewDataComboBoxColumn>

                             
                                <dx:GridViewDataTextColumn FieldName="Orden" VisibleIndex="6" Caption="Orden De Pregunta">
                                    <Settings AllowAutoFilter="False" />
                                </dx:GridViewDataTextColumn>


                                <dx:GridViewCommandColumn VisibleIndex="7" HeaderStyle-HorizontalAlign="Center" Caption="Acción" CellStyle-HorizontalAlign="NotSet">

                                    <NewButton Visible="True" />
                                    <EditButton Visible="true" />
                                    <DeleteButton Visible="true" />

                            <HeaderStyle HorizontalAlign="Center"></HeaderStyle>

                            </dx:GridViewCommandColumn>
                            <dx:GridViewDataTextColumn FieldName="CreadoPor" Visible="false" VisibleIndex="7"></dx:GridViewDataTextColumn>
                            <dx:GridViewDataDateColumn FieldName="FechaCreacion" VisibleIndex="8" Visible="false"></dx:GridViewDataDateColumn>
                            <dx:GridViewDataTextColumn FieldName="ActualizadoPor" VisibleIndex="9" Visible="false"></dx:GridViewDataTextColumn>
                            <dx:GridViewDataDateColumn FieldName="FechaActualizacion" VisibleIndex="10" Visible="false"></dx:GridViewDataDateColumn>
                            <dx:GridViewDataDateColumn FieldName="Activo" VisibleIndex="11" Visible="false"></dx:GridViewDataDateColumn>
                        </Columns>

                             <SettingsPager>
                       <AllButton Visible="True" Text="Todos">
                       </AllButton>
                    </SettingsPager>
                        <SettingsBehavior AllowFocusedRow="True" />
                        <SettingsDetail ShowDetailRow="True" />
                        <Templates>
                        <DetailRow>
                            <dx:ASPxGridView ID="ASPxGridViewOpcionesPreguntasPorPrograma" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSourceOpcionesPreguntasPorPrograma" 
                              KeyFieldName="IdOpcionDePregunta" IsDetailGrid="true" OnBeforePerformDataSelect="ASPxGridViewOpcionesPreguntasPorPrograma_BeforePerformDataSelect1"  
                              Visible="<%#IsGridOpcionesVisible2(Container.KeyValue)%>">
                                <Columns>
                                    <dx:GridViewDataTextColumn FieldName="IdOpcionDePregunta" ReadOnly="True" VisibleIndex="0" Caption="#">
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
                                 <SettingsPager>
                       <AllButton Visible="True" Text="Todos">
                       </AllButton>
                    </SettingsPager>
                                </dx:ASPxGridView>
                            </DetailRow>
                        </Templates>
                    </dx:ASPxGridView>


                     <asp:SqlDataSource runat="server" ID="SqlDataSourceOpcionesPreguntasPorPrograma" ConnectionString='<%$ ConnectionStrings:SUEPPSConnectionString %>' 
                    SelectCommand="SELECT * FROM [OpcionesDePregunta] WHERE ([IdPreguntaDeMonitoreo] = @IdPreguntaDeMonitoreo AND [Activo]=1)"
                    InsertCommand="Insert INTO [OpcionesDePregunta] ([DescripcionOpcionDePregunta], [IdPreguntaDeMonitoreo], [CreadoPor], [FechaCreacion], [Activo]) VALUES (@DescripcionOpcionDePregunta, @IdPreguntaDeMonitoreo, 'suepps', getDate(), 1)"
                    UpdateCommand="Update [OpcionesDePregunta] SET [DescripcionOpcionDePregunta]=@DescripcionOpcionDePregunta, [ActualizadoPor]='suepps', [FechaActualizacion]=getDate() WHERE [IdOpcionDePregunta] = @IdOpcionDePregunta"
                    DeleteCommand="Update [OpcionesDePregunta] SET [Activo]=0 WHERE [IdOpcionDePregunta] = @IdOpcionDePregunta"
                    >
                        <SelectParameters>
                            <asp:SessionParameter SessionField="IdPreguntaDeMonitoreo" Name="IdPreguntaDeMonitoreo" Type="Int32"></asp:SessionParameter>
                
                        </SelectParameters>

                        <InsertParameters>
                            <asp:SessionParameter SessionField="IdPreguntaDeMonitoreo" Name="IdPreguntaDeMonitoreo" Type="Int32"></asp:SessionParameter>
                            <asp:FormParameter Name="DescripcionOpcionDePregunta" />
                            
                           
                        </InsertParameters>

                 </asp:SqlDataSource>


                 <asp:SqlDataSource runat="server" ID="SqlDataSourcePreguntasPorPrograma" OnInserted="SqlDataSourcePreguntasPorPrograma_Inserted" ConnectionString='<%$ ConnectionStrings:SUEPPSConnectionString %>' 
                    SelectCommand="SELECT  a.IdPreguntaDeMonitoreo,a.DescripcionPreguntaDeMonitoreo,a.IdTipoDePregunta, a.IdTipoDeActor, a.IdCategoriaDePregunta, a.Orden FROM [PreguntasDeMonitoreo] a join [CategoriasDePregunta] b on a.IdCategoriaDePregunta= b.IdCategoriaDePregunta   WHERE (a.[Activo]=1 and a.[IdPrograma]= @Programa and a.[EsGeneral]=2) order by b.Orden,a.Orden"
                    UpdateCommand="UPDATE PreguntasDeMonitoreo SET  DescripcionPreguntaDeMonitoreo=@DescripcionPreguntaDeMonitoreo,FechaActualizacion=getDate(), IdCategoriaDePregunta=@IdCategoriaDePregunta, Orden=@Orden, ActualizadoPor=@Actualizado WHERE [IdPreguntaDeMonitoreo] = @IdPreguntaDeMonitoreo "
                    InsertCommand="INSERT INTO PreguntasDeMonitoreo (IdTipoDePregunta,IdPrograma, IdCategoriaDePregunta, DescripcionPreguntaDeMonitoreo, Orden, EsGeneral, CreadoPor, Activo) VALUES(@IdTipoDePregunta,@Programa, @IdCategoriaDePregunta, @DescripcionPreguntaDeMonitoreo,@Orden, 2,@Creado,1)"
                    DeleteCommand="UPDATE [PreguntasDeMonitoreo] SET [Activo]=0 WHERE [IdPreguntaDeMonitoreo] = @IdPreguntaDeMonitoreo"
                        >
                             <SelectParameters>
                                    <asp:SessionParameter Name="Programa" /> 
                                    
                             </SelectParameters>

                            <InsertParameters>
                                  
                                  <asp:SessionParameter Name="Programa" />
                                  <asp:SessionParameter Name="Creado" />
                                  <asp:FormParameter Name="IdTipoDePregunta" />
                                  <asp:FormParameter Name="DescripcionPreguntaDeMonitoreo" />
                                  <asp:FormParameter Name="IdCategoriaDePregunta" />
                                  <asp:FormParameter Name="Orden" />
                                  
                            </InsertParameters>

                            <UpdateParameters>
                                <asp:SessionParameter Name="Actualizado" />
                                <asp:FormParameter Name="IdPreguntaDeMonitoreo" />
                                <asp:FormParameter Name="IdTipoDePregunta" />
                                <asp:FormParameter Name="DescripcionPreguntaDeMonitoreo" />
                                <asp:FormParameter Name="IdCategoriaDePregunta" />
                                <asp:FormParameter Name="Orden" />
                            </UpdateParameters>

                            <DeleteParameters>
                                <asp:FormParameter Name="IdPreguntaDeMonitoreo" />
                            </DeleteParameters>
                        </asp:SqlDataSource>

                    </dx:ContentControl>
                    </ContentCollection>
                </dx:TabPage>





               <%-- Preguntas Por Actor --%>
                 <dx:TabPage Text="Preguntas Por Actor"  >
                    <ContentCollection>     
                       
                    <dx:ContentControl runat="server" SupportsDisabledAttribute="True">

                        <div>
                            <dx:ASPxLabel Text ="Tipo de Actor:"  runat="server" AssociatedControlID="comboTipoActor"></dx:ASPxLabel>

                            <dx:ASPxComboBox ID="comboTipoActor" ClientInstanceName="comboTipoActor" runat="server" ValueField="IdTipoDeActor"
                               TextField="NombreTipoDeActor" ValueType="System.String" DataSourceID="SqlActores" 
                                EnableClientSideAPI="true" >

                                 <ClientSideEvents SelectedIndexChanged="function(s, e) {GridPreguntas.PerformCallback(s.GetValue()); }">
                                 </ClientSideEvents>
                        </dx:ASPxComboBox>
                        </div>

                        <p></p>
                        

                        <asp:SqlDataSource ID="SqlActores" runat="server" ConnectionString="<%$ ConnectionStrings:SUEPPSConnectionString %>" 
                            SelectCommand="Select distinct([NombreTipoDeActor]),IdTipoDeActor from TiposDeActor where Activo=1 " ></asp:SqlDataSource>



                        <dx:ASPxGridView ID="GridPreguntas" runat="server" ClientInstanceName="GridPreguntas" AutoGenerateColumns="False" DataSourceID="SqlDataSourcePreguntas"  OnCustomCallback="GridPreguntas_CustomCallback"  KeyFieldName="IdPreguntaDeMonitoreo" ShowDetailRow="true" Width="100%" OnLoad="GridPreguntas_Load" Settings-ShowFilterRow="true" Settings-ShowFilterRowMenu="true" SettingsEditing-EditFormColumnCount="1">
                    <Columns>
                        <dx:GridViewDataTextColumn FieldName="IdPreguntaDeMonitoreo"  ReadOnly="True" VisibleIndex="0" Caption="#">
                                <EditFormSettings Visible="False"></EditFormSettings>
                                <Settings AllowAutoFilter="False" />
                        </dx:GridViewDataTextColumn>
                            
                        <dx:GridViewDataTextColumn FieldName="DescripcionPreguntaDeMonitoreo" VisibleIndex="1" Caption="Pregunta">
                            <Settings AllowAutoFilter="True" />
                                    <Settings AutoFilterCondition="Contains" />
                                    <Settings FilterMode="DisplayText" />
                        </dx:GridViewDataTextColumn>

                        <dx:GridViewDataComboBoxColumn VisibleIndex="2" FieldName="IdTipoDePregunta" Caption="Tipo de Pregunta">
                                  
                                 <PropertiesComboBox ValueType="System.String" 
                
                                    DataSourceID="SqlDataSourceTiposPreguntas" 
                                    ValueField="IdTipoDePregunta" 
                                    TextField="NombreTipoDePregunta"/>

                            <Settings AllowAutoFilter="True" />
                                    <Settings AutoFilterCondition="Contains" />
                                    <Settings FilterMode="DisplayText" />
     
                    
                            </dx:GridViewDataComboBoxColumn>

                        <dx:GridViewDataTextColumn FieldName="IdTipoDeActor" VisibleIndex="3"  Visible="false"></dx:GridViewDataTextColumn>


                       <dx:GridViewDataComboBoxColumn VisibleIndex="5" FieldName="IdCategoriaDePregunta" Caption="Categoría">
                               
                                  
                                   <PropertiesComboBox ValueType="System.String" 
                
                                    DataSourceID="SqlDataSourceTiposDeCategoria" 
                                    ValueField="IdCategoriaDePregunta" 
                                    TextField="DescripcionCategoriaDePregunta"/>

                           <Settings AllowAutoFilter="True" />
                                    <Settings AutoFilterCondition="Contains" />
                                    <Settings FilterMode="DisplayText" />
     
                    
                            </dx:GridViewDataComboBoxColumn>

                             
                              <dx:GridViewDataTextColumn FieldName="Orden" VisibleIndex="6" Caption="Orden">
                                  <Settings AllowAutoFilter="False" />
                              </dx:GridViewDataTextColumn>




                            <dx:GridViewCommandColumn VisibleIndex="7" HeaderStyle-HorizontalAlign="Center" Caption="Acción" CellStyle-HorizontalAlign="NotSet">

                                    <NewButton Visible="True" />
                                    <EditButton Visible="true" />
                                    <DeleteButton Visible="true" />

                            <HeaderStyle HorizontalAlign="Center"></HeaderStyle>

                            </dx:GridViewCommandColumn>
                            <dx:GridViewDataTextColumn FieldName="CreadoPor" Visible="false" VisibleIndex="7"></dx:GridViewDataTextColumn>
                            <dx:GridViewDataDateColumn FieldName="FechaCreacion" VisibleIndex="8" Visible="false"></dx:GridViewDataDateColumn>
                            <dx:GridViewDataTextColumn FieldName="ActualizadoPor" VisibleIndex="9" Visible="false"></dx:GridViewDataTextColumn>
                            <dx:GridViewDataDateColumn FieldName="FechaActualizacion" VisibleIndex="10" Visible="false"></dx:GridViewDataDateColumn>
                            <dx:GridViewDataDateColumn FieldName="Activo" VisibleIndex="11" Visible="false"></dx:GridViewDataDateColumn>
                        </Columns>
                             <SettingsPager>
                       <AllButton Visible="True" Text="Todos">
                       </AllButton>
                    </SettingsPager>
                        <SettingsBehavior AllowFocusedRow="True" />
                        <SettingsDetail ShowDetailRow="True" />
                        <Templates>
                        <DetailRow>
                            <dx:ASPxGridView ID="ASPxGridViewOpciones" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSourceOpciones" KeyFieldName="IdOpcionDePregunta" IsDetailGrid="true" onbeforeperformdataselect="ASPxGridViewOpciones_BeforePerformDataSelect" Visible="<%#IsGridOpcionesVisible(Container.KeyValue)%>">
                                <Columns>
                                    <dx:GridViewDataTextColumn FieldName="IdOpcionDePregunta" ReadOnly="True" VisibleIndex="0" Caption="#">
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
                                 <SettingsPager>
                       <AllButton Visible="True" Text="Todos">
                       </AllButton>
                    </SettingsPager>
                                </dx:ASPxGridView>
                            </DetailRow>
                        </Templates>
                    </dx:ASPxGridView>

                        <asp:SqlDataSource runat="server" ID="SqlDataSourcePreguntas" ConnectionString='<%$ ConnectionStrings:SUEPPSConnectionString %>' 
                    SelectCommand="SELECT  a.IdPreguntaDeMonitoreo,a.DescripcionPreguntaDeMonitoreo,a.IdTipoDePregunta, a.IdTipoDeActor, a.IdCategoriaDePregunta, a.Orden FROM [PreguntasDeMonitoreo] a join [CategoriasDePregunta] b on a.IdCategoriaDePregunta= b.IdCategoriaDePregunta WHERE (a.[Activo]=1 and a.[IdPrograma]= @Programa and a.[IdTipoDeActor]= @Actor and a.[EsGeneral]=3) order by b.Orden,a.Orden"
                    UpdateCommand="UPDATE PreguntasDeMonitoreo SET  DescripcionPreguntaDeMonitoreo=@DescripcionPreguntaDeMonitoreo,FechaActualizacion=getDate(), IdCategoriaDePregunta=@IdCategoriaDePregunta, Orden=@Orden, ActualizadoPor= @Actualizado WHERE [IdPreguntaDeMonitoreo] = @IdPreguntaDeMonitoreo "
                    InsertCommand="INSERT INTO PreguntasDeMonitoreo (IdTipoDePregunta,IdTipoDeActor,IdPrograma,IdCategoriaDePregunta, DescripcionPreguntaDeMonitoreo, Orden, EsGeneral, CreadoPor, FechaCreacion, Activo) VALUES(@IdTipoDePregunta, @Actor,@Programa, @IdCategoriaDePregunta, @DescripcionPreguntaDeMonitoreo, @Orden, 3, @Creado, getDate(),1)"
                    DeleteCommand="UPDATE [PreguntasDeMonitoreo] SET [Activo]=0 WHERE [IdPreguntaDeMonitoreo] = @IdPreguntaDeMonitoreo"
                        >
                             <SelectParameters>
                                    <asp:SessionParameter Name="Programa" /> 
                                    <asp:SessionParameter Name="Actor" />   
                                                           
                             </SelectParameters>

                            <InsertParameters>
                                  <asp:SessionParameter Name="Actor" />
                                  <asp:SessionParameter Name="Programa" />
                                  <asp:SessionParameter Name="Creado" />
                                  <asp:FormParameter Name="IdTipoDePregunta" />
                                  <asp:FormParameter Name="DescripcionPreguntaDeMonitoreo" />
                                  <asp:FormParameter Name="IdCategoriaDePregunta" />
                                  <asp:FormParameter Name="Orden" />
                            </InsertParameters>

                            <UpdateParameters>
                                <asp:SessionParameter Name="Actualizado" />
                                <asp:FormParameter Name="IdPreguntaDeMonitoreo" />
                                <asp:FormParameter Name="IdTipoDePregunta" />
                                <asp:FormParameter Name="DescripcionPreguntaDeMonitoreo" />
                                <asp:FormParameter Name="IdCategoriaDePregunta" />
                                <asp:FormParameter Name="Orden" />
                            </UpdateParameters>

                            <DeleteParameters>
                                <asp:FormParameter Name="IdPreguntaDeMonitoreo" />
                            </DeleteParameters>
                        </asp:SqlDataSource>

                   
                        <asp:SqlDataSource runat="server" ID="SqlDataSourceTiposPreguntas" ConnectionString='<%$ ConnectionStrings:SUEPPSConnectionString %>' SelectCommand="SELECT [IdTipoDePregunta],[NombreTipoDePregunta] FROM [TiposDePreguntas] where Activo=1 "></asp:SqlDataSource>
                         <asp:SqlDataSource runat="server" ID="SqlDataSourceTiposDeCategoria" ConnectionString='<%$ ConnectionStrings:SUEPPSConnectionString %>' SelectCommand="SELECT [IdCategoriaDePregunta],[DescripcionCategoriaDePregunta] FROM [CategoriasDePregunta] where Activo=1 "></asp:SqlDataSource>
    
                     <asp:SqlDataSource runat="server" ID="SqlDataSourceOpciones" ConnectionString='<%$ ConnectionStrings:SUEPPSConnectionString %>' 
                    SelectCommand="SELECT * FROM [OpcionesDePregunta] WHERE ([IdPreguntaDeMonitoreo] = @IdPreguntaDeMonitoreo AND [Activo]=1)"
                    InsertCommand="Insert INTO [OpcionesDePregunta] ([DescripcionOpcionDePregunta], [IdPreguntaDeMonitoreo], [CreadoPor], [FechaCreacion], [Activo]) VALUES (@DescripcionOpcionDePregunta, @IdPreguntaDeMonitoreo, 'suepps', getDate(), 1)"
                    UpdateCommand="Update [OpcionesDePregunta] SET [DescripcionOpcionDePregunta]=@DescripcionOpcionDePregunta, [ActualizadoPor]='aaa', [FechaActualizacion]=getDate() WHERE [IdOpcionDePregunta] = @IdOpcionDePregunta"
                    DeleteCommand="Update [OpcionesDePregunta] SET [Activo]=0 WHERE [IdOpcionDePregunta] = @IdOpcionDePregunta"
                    >
                <SelectParameters>
                    <asp:SessionParameter SessionField="IdPreguntaDeMonitoreo" Name="IdPreguntaDeMonitoreo" Type="Int32"></asp:SessionParameter>
                
                </SelectParameters>

                <InsertParameters>
                    <asp:SessionParameter SessionField="IdPreguntaDeMonitoreo" Name="IdPreguntaDeMonitoreo" Type="Int32"></asp:SessionParameter>
                    <asp:Parameter Name="DescripcionOpcionDePregunta" />
                </InsertParameters>

                 </asp:SqlDataSource>


                    </dx:ContentControl>
                       
                        

                     </ContentCollection>
               </dx:TabPage>
               
                </TabPages>
                
                </dx:ASPxPageControl>


    </div>
</asp:Content>
