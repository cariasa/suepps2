<%@ Page Language="VB" AutoEventWireup="false" CodeFile="PreguntasInstrumento.aspx.vb" Inherits="Cuantitativo_PreguntasInstrumento" MasterPageFile="~/Site.master"  %>

<%@ Register Assembly="DevExpress.Web.v13.1, Version=13.1.8.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web.ASPxGridView" TagPrefix="dx" %>

<%@ Register assembly="DevExpress.Web.v13.1, Version=13.1.8.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" namespace="DevExpress.Web.ASPxEditors" tagprefix="dx" %>

<%@ Register Src="~/MOCA_UE.ascx" TagPrefix="uc1" TagName="MOCA_UE" %>

<asp:Content ID="cHeader" ContentPlaceHolderID="HeadContent" Runat="Server">
</asp:Content>
<asp:Content ID="cBody" ContentPlaceHolderID="MainContent" Runat="Server">
    <uc1:MOCA_UE runat="server" ID="MOCA_UE01" />
    <div>
        <div>
            <table>
                <tr>
                    <td><dx:ASPxLabel ID="ASPxLabelTitulo" runat="server" Font-Size="Large" /></td>
                    <td>
                        <dx:ASPxLabel ID="espacio" runat="server" Text=" " Width="50"></dx:ASPxLabel>
                        <dx:ASPxHyperLink ID="ASPxHyperLinkRegresar" runat="server" Text="Regresar a Instrumento" NavigateUrl="InstrumentosEvaluacion.aspx" />

                    </td>
                </tr>
            </table>
        </div>
        <div>
            <table>
            <tr>
                <td>

                    <dx:ASPxLabel ID="ASPxLabel1" runat="server" Text="Plantillas" Font-Size="Medium"></dx:ASPxLabel>

                    <dx:ASPxGridView ID="ASPxGridView4" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSource6" KeyFieldName="IdPlantilla">
                        <Columns>
                            <dx:GridViewDataTextColumn FieldName="IdPlantilla" ReadOnly="True" VisibleIndex="0" Visible="false">
                                <EditFormSettings Visible="False" />
                            </dx:GridViewDataTextColumn>
                             <dx:GridViewDataComboBoxColumn VisibleIndex="1" FieldName="IdSector" 
                    Caption="Sector">
                    <EditFormSettings ColumnSpan="2" />
                        <PropertiesComboBox ValueType="System.String" 
                
                            DataSourceID="Sqlsector" 
                            ValueField="IdSectorIndicador" 
                            TextField="DescripcionSectorIndicador"/>
                         <Settings AllowAutoFilter="True" />
                                    <Settings AutoFilterCondition="Contains" />
                                    <Settings FilterMode="DisplayText" />     
                  </dx:GridViewDataComboBoxColumn>
                            <dx:GridViewDataTextColumn FieldName="NombrePlantilla" Caption="Nombre" VisibleIndex="2">
                            </dx:GridViewDataTextColumn>

                            <dx:GridViewDataTextColumn VisibleIndex="3" 
                    Caption="Acción" UnboundType="String">
                                      <DataItemTemplate>
                                          <asp:LinkButton id="link1"  Text="Agregar" runat="server" OnClick="AsociarPlantilla" /> 
                                      </DataItemTemplate>  
                                        <Settings AllowAutoFilter="False" />
                                        <EditFormSettings Visible="False" />
                 </dx:GridViewDataTextColumn>

                        </Columns>


                        <SettingsBehavior AllowFocusedRow="True" />

                         <SettingsPager>
                         <AllButton Visible="True" Text="Todos">
                         </AllButton>
                         </SettingsPager>

                    </dx:ASPxGridView>
                     


                
                 
                
                </td>
                <td>

                    <dx:ASPxLabel ID="ASPxLabel2" runat="server" Text="Preguntas" Font-Size="Medium"></dx:ASPxLabel>

         <dx:ASPxGridView ID="ASPxGridView1" runat="server" AutoGenerateColumns="False" 
            DataSourceID="SqlDataSource1" KeyFieldName="IdPreguntaPorInstrumento">
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
                                    TextField="NombreTipoDePregunta"/>
    
                 </dx:GridViewDataComboBoxColumn>

               <dx:GridViewDataComboBoxColumn VisibleIndex="5" FieldName="IdSeccionFSU" Caption="Sección">
                               <EditFormSettings ColumnSpan="1" />
                                <PropertiesComboBox ValueType="System.String" 
                
                                    DataSourceID="SqlDataSourceSeccionFSU" 
                                    ValueField="IdSeccionFSU" 
                                    TextField="NombreSeccion"/>
     
                    
                 </dx:GridViewDataComboBoxColumn>


                
                <dx:GridViewDataTextColumn FieldName="Orden" VisibleIndex="6">
                <EditFormSettings ColumnSpan="1" />
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataCheckColumn FieldName="Requerida" VisibleIndex="7">
                <EditFormSettings ColumnSpan="1" />
                </dx:GridViewDataCheckColumn>
                <dx:GridViewDataComboBoxColumn FieldName="IdTipoDeRespuesta" Caption="Tipo de Respuesta" VisibleIndex="8">
                <EditFormSettings ColumnSpan="1" />
                <PropertiesComboBox ValueType="System.String" 
                
                                    DataSourceID="SqlDataSourceTipoRespuesta" 
                                    ValueField="IdTipoDeRespuesta" 
                                    TextField="TipoDeRespuesta"/>
                </dx:GridViewDataComboBoxColumn>
                <dx:GridViewDataTextColumn FieldName="CreadoPor" VisibleIndex="9" Visible="false">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataDateColumn FieldName="FechaCreacion" VisibleIndex="10" Visible="false" >
                </dx:GridViewDataDateColumn>
                <dx:GridViewDataTextColumn FieldName="ActualizadoPor" VisibleIndex="11" Visible="false">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataDateColumn FieldName="FechaActualización" VisibleIndex="12" Visible="false">
                </dx:GridViewDataDateColumn>
                <dx:GridViewDataCheckColumn FieldName="Activo" VisibleIndex="13" Visible="false">
                </dx:GridViewDataCheckColumn>

                 <dx:GridViewCommandColumn VisibleIndex="14" HeaderStyle-HorizontalAlign="Center" Caption="Acción" CellStyle-HorizontalAlign="NotSet">
                    
                    <NewButton Visible="True">
                    </NewButton>
                    <EditButton Visible="True">
                    </EditButton>
                    <DeleteButton Visible="True">
                    </DeleteButton>
                    <HeaderStyle HorizontalAlign="Center"></HeaderStyle>
                </dx:GridViewCommandColumn>

            </Columns>

            <SettingsBehavior AllowFocusedRow="True" />

             <SettingsPager>
                 <AllButton Visible="True" Text="Todos">
                 </AllButton>
             </SettingsPager>

             <SettingsDetail ShowDetailRow="True" />
                        <Templates>
                        <DetailRow>
                            <dx:ASPxGridView ID="ASPxGridViewOpciones" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSourceOpciones" KeyFieldName="IdOpcionPreguntaPorInstrumento" IsDetailGrid="true" onbeforeperformdataselect="ASPxGridViewOpciones_BeforePerformDataSelect" Visible="<%#IsGridOpcionesVisible(Container.KeyValue)%>" Width="100%" SettingsEditing-EditFormColumnCount="1">
                                <Columns>
                                    <dx:GridViewDataTextColumn FieldName="IdOpcionPreguntaPorInstrumento" ReadOnly="True" VisibleIndex="0" Visible="false">
                                        <EditFormSettings Visible="False" />
                                    </dx:GridViewDataTextColumn>
                                    <dx:GridViewDataTextColumn FieldName="Opcion" VisibleIndex="1" Caption="Opción">
                                    </dx:GridViewDataTextColumn>
                                    <dx:GridViewDataTextColumn FieldName="IdPreguntaPorInstrumento" VisibleIndex="2" Visible="false">
                                    </dx:GridViewDataTextColumn>
                                    <dx:GridViewDataTextColumn FieldName="Valor" VisibleIndex="3" >
                                    </dx:GridViewDataTextColumn>
                                    <dx:GridViewDataTextColumn FieldName="SaltaACodigo" VisibleIndex="4" >
                                    </dx:GridViewDataTextColumn>

                                    <dx:GridViewCommandColumn VisibleIndex="5" HeaderStyle-HorizontalAlign="Center" Caption="Acción" CellStyle-HorizontalAlign="NotSet">

                                            <NewButton Visible="True" />
                                            <EditButton Visible="true" />
                                            <DeleteButton Visible="true" />

                                        </dx:GridViewCommandColumn>
                                    </Columns>
                                </dx:ASPxGridView>
                            </DetailRow>
                        </Templates>


                       
        </dx:ASPxGridView>


                </td>
            </tr>
           
            </table>

        </div>


         <dx:ASPxGridView ID="ASPxGridView2" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSource2" KeyFieldName="IdPreguntaPorPlantilla" Visible="false">
            <Columns>
                <dx:GridViewDataTextColumn FieldName="IdPreguntaPorPlantilla" ReadOnly="True" VisibleIndex="0">
                    <EditFormSettings Visible="False" />
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="IdPlantilla" VisibleIndex="1">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="IdTipoDePregunta" VisibleIndex="2">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="IdSeccionFSU" VisibleIndex="3">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="PreguntaDePlantilla" VisibleIndex="4">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Orden" VisibleIndex="5">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataCheckColumn FieldName="Requerida" VisibleIndex="6">
                </dx:GridViewDataCheckColumn>
                <dx:GridViewDataTextColumn FieldName="IdTipoDeRespuesta" VisibleIndex="7">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="CreadoPor" VisibleIndex="8">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataDateColumn FieldName="FechaCreacion" VisibleIndex="9">
                </dx:GridViewDataDateColumn>
                <dx:GridViewDataTextColumn FieldName="ActualizadoPor" VisibleIndex="10">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataDateColumn FieldName="FechaActualizacion" VisibleIndex="11">
                </dx:GridViewDataDateColumn>
                <dx:GridViewDataCheckColumn FieldName="Activo" VisibleIndex="12">
                </dx:GridViewDataCheckColumn>
            </Columns>
         </dx:ASPxGridView>

        <dx:ASPxGridView ID="ASPxGridView3" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSource4" KeyFieldName="IdOpcionPreguntaPorPlantilla" Visible="false">
            <Columns>
                <dx:GridViewDataTextColumn FieldName="IdOpcionPreguntaPorPlantilla" ReadOnly="True" VisibleIndex="0">
                    <EditFormSettings Visible="False" />
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="IdPreguntaPorPlantilla" VisibleIndex="1">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Opcion" VisibleIndex="2">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="CreadoPor" VisibleIndex="3">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataDateColumn FieldName="FechaCreacion" VisibleIndex="4">
                </dx:GridViewDataDateColumn>
                <dx:GridViewDataTextColumn FieldName="ActualizadoPor" VisibleIndex="5">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataDateColumn FieldName="FechaActualizacion" VisibleIndex="6">
                </dx:GridViewDataDateColumn>
                <dx:GridViewDataCheckColumn FieldName="Activo" VisibleIndex="7">
                </dx:GridViewDataCheckColumn>
                 <dx:GridViewDataTextColumn FieldName="Valor" VisibleIndex="8">
                </dx:GridViewDataTextColumn>
                 



            </Columns>
         </dx:ASPxGridView>



        <asp:SqlDataSource ID="SqlDataSource1" runat="server" OnInserted="SqlDataSource1_Inserted"
            ConnectionString="<%$ ConnectionStrings:SUEPPSConnectionString %>" 
            SelectCommand="SELECT * FROM [PreguntasPorInstrumento] a join [SeccionesFSU] b on a.IdSeccionFSU=b.IdSeccionFSU WHERE a.[Activo]=1 and a.[IdInstrumentoDeEvaluacion]= @IdInstrumentoDeEvaluacion Order by b.NombreSeccion,a.Orden"
            InsertCommand="Insert INTO [PreguntasPorInstrumento] ([IdInstrumentoDeEvaluacion], [IdTipoDePregunta],[IdSeccionFSU],[PreguntaDeInstrumento],[Orden],[Requerida],[IdTipoDeRespuesta],[CreadoPor], [FechaCreacion], [Activo],[IdAmigable]) VALUES (@IdInstrumentoDeEvaluacion, @IdTipoDePregunta,@IdSeccionFSU,@PreguntaDeInstrumento,@Orden,@Requerida,@IdTipoDeRespuesta,'PACO', getDate(), 1,@IdAmigable)  SELECT @IdPreguntaPorInstrumento = SCOPE_IDENTITY()"
            UpdateCommand="Update [PreguntasPorInstrumento] SET [IdTipoDePregunta]=@IdTipoDePregunta,[IdSeccionFSU]=@IdSeccionFSU,[PreguntaDeInstrumento]=@PreguntaDeInstrumento,[Orden]=@Orden,[Requerida]=@Requerida,[IdTipoDeRespuesta]=@IdTipoDeRespuesta,[ActualizadoPor]='PACO', [FechaActualizacion]=getDate(),[IdAmigable]=@IdAmigable WHERE [IdPreguntaPorInstrumento] = @IdPreguntaPorInstrumento"
            DeleteCommand="Update [PreguntasPorInstrumento] SET [Activo]=0 WHERE [IdPreguntaPorInstrumento] = @IdPreguntaPorInstrumento"
            >

             <SelectParameters>
                     <asp:SessionParameter Name="IdInstrumentoDeEvaluacion" />
                     
                </SelectParameters>

            <InsertParameters>
                <asp:SessionParameter Name="IdInstrumentoDeEvaluacion" />
                <asp:FormParameter Name="IdTipoDePregunta" />
                <asp:FormParameter Name="IdSeccionFSU" />
                <asp:FormParameter Name="PreguntaDeInstrumento" />
                <asp:FormParameter Name="Orden" />
                <asp:FormParameter Name="Requerida" />
                <asp:FormParameter Name="IdTipoDeRespuesta" />
                <asp:FormParameter Name="IdAmigable" />
                <asp:Parameter Name="IdPreguntaPorInstrumento" Direction="Output"  type="Int32" />

            </InsertParameters>

            <UpdateParameters>
                <asp:FormParameter Name="IdTipoDePregunta" />
                <asp:FormParameter Name="IdSeccionFSU" />
                <asp:FormParameter Name="PreguntaDeInstrumento" />
                <asp:FormParameter Name="Orden" />
                <asp:FormParameter Name="Requerida" />
                <asp:FormParameter Name="IdTipoDeRespuesta" />
                <asp:FormParameter Name="IdPreguntaPorInstrumento" />
                <asp:FormParameter Name="IdAmigable" />
            </UpdateParameters>

            <DeleteParameters>
                 <asp:FormParameter Name="IdPreguntaPorInstrumento" />
            </DeleteParameters>


        </asp:SqlDataSource>

        
       <asp:SqlDataSource runat="server" ID="SqlDataSourceTiposPreguntas" ConnectionString='<%$ ConnectionStrings:SUEPPSConnectionString %>' SelectCommand="SELECT [IdTipoDePregunta],[NombreTipoDePregunta] FROM [TiposDePreguntas] where Activo=1 "></asp:SqlDataSource>
        
       <asp:SqlDataSource runat="server" ID="SqlDataSourceCategoriasPregunta" ConnectionString='<%$ ConnectionStrings:SUEPPSConnectionString %>' SelectCommand="SELECT [IdCategoriaDePregunta], [DescripcionCategoriaDePregunta] FROM [CategoriasDePregunta] where Activo=1"></asp:SqlDataSource>

       <asp:SqlDataSource runat="server" ID="SqlDataSourceTipoRespuesta" ConnectionString='<%$ ConnectionStrings:SUEPPSConnectionString %>' SelectCommand="SELECT [IdTipoDeRespuesta], [TipoDeRespuesta] FROM [TiposDeRespuesta] where Activo=1"></asp:SqlDataSource>


       <asp:SqlDataSource runat="server" ID="SqlDataSourceOpciones" ConnectionString='<%$ ConnectionStrings:SUEPPSConnectionString %>' 
                    SelectCommand="SELECT * FROM [OpcionesPreguntaPorInstrumento] WHERE ([IdPreguntaPorInstrumento] = @IdPreguntaPorInstrumento AND [Activo]=1)"
                    InsertCommand="Insert INTO [OpcionesPreguntaPorInstrumento] ([Opcion], [IdPreguntaPorInstrumento], [CreadoPor], [FechaCreacion], [Activo],[Valor],[SaltaACodigo]) VALUES (@Opcion, @IdPreguntaPorInstrumento, 'PACO', getDate(), 1, @Valor,@SaltaACodigo)"
                    UpdateCommand="Update [OpcionesPreguntaPorInstrumento] SET [Opcion]=@Opcion, [ActualizadoPor]='PACO', [FechaActualizacion]=getDate(), [Valor]=@Valor,[SaltaACodigo]=@SaltaACodigo WHERE [IdOpcionPreguntaPorInstrumento] = @IdOpcionPreguntaPorInstrumento"
                    DeleteCommand="Update [OpcionesPreguntaPorInstrumento] SET [Activo]=0 WHERE [IdOpcionPreguntaPorInstrumento] = @IdOpcionPreguntaPorInstrumento"
                    >
                <SelectParameters>
                    <asp:SessionParameter SessionField="IdPreguntaPorInstrumento" Name="IdPreguntaPorInstrumento" Type="Int32"></asp:SessionParameter>
                
                </SelectParameters>

                <InsertParameters>
                    <asp:SessionParameter SessionField="IdPreguntaPorInstrumento" Name="IdPreguntaPorInstrumento" Type="Int32"></asp:SessionParameter>
                    <asp:FormParameter Name="Opcion" />
                     <asp:FormParameter Name="Valor" />
                    <asp:FormParameter Name="SaltaACodigo" />


                </InsertParameters>

                <UpdateParameters>
                    <asp:SessionParameter SessionField="IdPreguntaPorInstrumento" Name="IdPreguntaPorInstrumento" Type="Int32"></asp:SessionParameter>
                    <asp:FormParameter Name="Opcion" />
                    <asp:FormParameter Name="Valor" />
                    <asp:FormParameter Name="SaltaACodigo" />
                </UpdateParameters>
        
          
            </asp:SqlDataSource>

         

         <asp:SqlDataSource ID="SqlDataSource4" runat="server" ConnectionString="<%$ ConnectionStrings:SUEPPSConnectionString %>" SelectCommand="SELECT * FROM [OpcionesPreguntaPorPlantilla] where [IdPreguntaPorPlantilla]=@IdPreguntaPorPlantilla and [Activo]=1">

             <SelectParameters>
                     <asp:SessionParameter Name="IdPreguntaPorPlantilla" />  
                </SelectParameters>

         </asp:SqlDataSource>


         <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:SUEPPSConnectionString %>" SelectCommand="SELECT * FROM [PreguntasPorPlantilla] WHERE [IdPlantilla]=@IdPlantilla and [Activo]=1 ">

             <SelectParameters>
                     <asp:SessionParameter Name="IdPlantilla" />  
                </SelectParameters>


         </asp:SqlDataSource>

          <asp:SqlDataSource ID="SqlDataSource3" runat="server" OnInserted="SqlDataSource3_Inserted"
            ConnectionString="<%$ ConnectionStrings:SUEPPSConnectionString %>" 
            InsertCommand="Insert INTO [PreguntasPorInstrumento] ([IdInstrumentoDeEvaluacion], [IdTipoDePregunta],[IdSeccionFSU],[PreguntaDeInstrumento],[Orden],[Requerida],[IdTipoDeRespuesta],[CreadoPor], [FechaCreacion], [Activo],[IdAmigable]) VALUES (@IdInstrumentoDeEvaluacion, @IdTipoDePregunta,@IdSeccionFSU,@PreguntaDeInstrumento,@Orden,@Requerida,@IdTipoDeRespuesta,'PACO', getDate(), 1,@IdAmigable) SELECT @IdPreguntaPorInstrumento = SCOPE_IDENTITY()"
           >

            <InsertParameters>
                <asp:SessionParameter Name="IdInstrumentoDeEvaluacion" />
                <asp:SessionParameter Name="IdTipoDePregunta" />
                <asp:SessionParameter Name="IdSeccionFSU" />
                <asp:SessionParameter Name="PreguntaDeInstrumento" />
                <asp:SessionParameter Name="Orden" />
                <asp:SessionParameter Name="Requerida" />
                <asp:SessionParameter Name="IdTipoDeRespuesta" />
                <asp:SessionParameter Name="IdAmigable" />
                <asp:Parameter Direction="Output" Name="IdPreguntaPorInstrumento" Type="Int32" />

            </InsertParameters>


        </asp:SqlDataSource>

         <asp:SqlDataSource ID="SqlDataSource6" runat="server" ConnectionString="<%$ ConnectionStrings:SUEPPSConnectionString %>" SelectCommand="SELECT * FROM [Plantillas] where [Activo]=1"></asp:SqlDataSource>
                     
         <asp:SqlDataSource ID="Sqlsector" runat="server" ConnectionString="<%$ ConnectionStrings:SUEPPSConnectionString %>" SelectCommand="SELECT [DescripcionSectorIndicador],[IdSectorIndicador] FROM [vROISectorIndicadores]"> </asp:SqlDataSource>

         <asp:SqlDataSource runat="server" ID="SqlDataSourceSeccionFSU" ConnectionString='<%$ ConnectionStrings:SUEPPSConnectionString %>' SelectCommand="SELECT * FROM [SeccionesFSU] where Activo=1"></asp:SqlDataSource>



    </div>
</asp:Content>
