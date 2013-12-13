<%@ Page Language="VB" AutoEventWireup="false" CodeFile="PreguntasPlantilla.aspx.vb" Inherits="Cuantitativo_PreguntasPlantilla"  MasterPageFile="~/Site.master"  %>

<%@ Register Assembly="DevExpress.Web.v13.1, Version=13.1.8.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web.ASPxEditors" TagPrefix="dx" %>

<%@ Register Assembly="DevExpress.Web.v13.1, Version=13.1.8.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a"
    Namespace="DevExpress.Web.ASPxGridView" TagPrefix="dx" %>

<%@ Register Src="~/MOCA_UE.ascx" TagPrefix="uc1" TagName="MOCA_UE" %>

<asp:Content ID="cHeader" ContentPlaceHolderID="HeadContent" Runat="Server">
</asp:Content>
<asp:Content ID="cBody" ContentPlaceHolderID="MainContent" Runat="Server">
    <uc1:MOCA_UE runat="server" ID="MOCA_UE01" />

        <div>


           
        <dx:ASPxGridView ID="ASPxGridView1" runat="server" AutoGenerateColumns="False" 
            DataSourceID="SqlDataSource1" KeyFieldName="IdPreguntaPorPlantilla">
            <Columns>
                <dx:GridViewDataTextColumn FieldName="IdPreguntaPorPlantilla" ReadOnly="True" Visible="false"
                    VisibleIndex="0">
                    <EditFormSettings Visible="False" />
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="IdPlantilla" VisibleIndex="1" Visible="false">
                </dx:GridViewDataTextColumn>

                <dx:GridViewDataTextColumn FieldName="PreguntaDePlantilla" Caption="Pregunta" VisibleIndex="2">
                <EditFormSettings ColumnSpan="2" />
                </dx:GridViewDataTextColumn>

                <dx:GridViewDataTextColumn FieldName="IdAmigable" Caption="Código" VisibleIndex="3">
                <EditFormSettings ColumnSpan="1" />
                </dx:GridViewDataTextColumn>

                <dx:GridViewDataComboBoxColumn VisibleIndex="4" FieldName="IdTipoDePregunta" Caption="Tipo Pregunta">
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

                
                <dx:GridViewDataTextColumn FieldName="Orden" Caption="Orden" VisibleIndex="6">
                <EditFormSettings ColumnSpan="1" />
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataCheckColumn FieldName="Requerida" Caption="Requerida" VisibleIndex="7">
                <EditFormSettings ColumnSpan="1" />
                </dx:GridViewDataCheckColumn>
                <dx:GridViewDataComboBoxColumn FieldName="IdTipoDeRespuesta" Caption="Tipo Respuesta" VisibleIndex="8">
                <EditFormSettings ColumnSpan="1" />
                <PropertiesComboBox ValueType="System.String" 
                
                                    DataSourceID="SqlDataSourceTipoRespuesta" 
                                    ValueField="IdTipoDeRespuesta" 
                                    TextField="TipoDeRespuesta"/>
                </dx:GridViewDataComboBoxColumn>
                <dx:GridViewDataTextColumn FieldName="CreadoPor" VisibleIndex="8" Visible="false">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataDateColumn FieldName="FechaCreacion" VisibleIndex="9" Visible="false" >
                </dx:GridViewDataDateColumn>
                <dx:GridViewDataTextColumn FieldName="ActualizadoPor" VisibleIndex="10" Visible="false">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataDateColumn FieldName="FechaActualización" VisibleIndex="11" Visible="false">
                </dx:GridViewDataDateColumn>
                <dx:GridViewDataCheckColumn FieldName="Activo" VisibleIndex="12" Visible="false">
                </dx:GridViewDataCheckColumn>

                 <dx:GridViewCommandColumn VisibleIndex="13" HeaderStyle-HorizontalAlign="Center" Caption="Acción" CellStyle-HorizontalAlign="NotSet">
                    
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
                            <dx:ASPxGridView ID="ASPxGridViewOpciones" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSourceOpciones" KeyFieldName="IdOpcionPreguntaPorPlantilla" IsDetailGrid="true" onbeforeperformdataselect="ASPxGridViewOpciones_BeforePerformDataSelect" Visible="<%#IsGridOpcionesVisible(Container.KeyValue)%>" Width="100%" SettingsEditing-EditFormColumnCount="1">
                                <Columns>
                                    <dx:GridViewDataTextColumn FieldName="IdOpcionPreguntaPorPlantilla" ReadOnly="True" VisibleIndex="0" Visible="false">
                                        <EditFormSettings Visible="False" />
                                    </dx:GridViewDataTextColumn>
                                    <dx:GridViewDataTextColumn FieldName="Opcion" VisibleIndex="1" Caption="Opción">
                                    </dx:GridViewDataTextColumn>
                                    <dx:GridViewDataTextColumn FieldName="Valor" VisibleIndex="2" Caption="Valor">
                                    </dx:GridViewDataTextColumn>
                                    <dx:GridViewDataTextColumn FieldName="SaltaACodigo" VisibleIndex="3" Caption="Salta a Pregunta">
                                    </dx:GridViewDataTextColumn>
                                    <dx:GridViewDataTextColumn FieldName="IdPreguntaPorPlantilla" VisibleIndex="4" Visible="false">
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

        <asp:SqlDataSource ID="SqlDataSource1" runat="server"  OnInserted="SqlDataSource1_Inserted"
            ConnectionString="<%$ ConnectionStrings:SUEPPSConnectionString %>" 
            SelectCommand="SELECT * FROM [PreguntasPorPlantilla] a join [SeccionesFSU] b on a.IdSeccionFSU= b.IdSeccionFSU WHERE a.[Activo]=1 and a.[IdPlantilla]= @IdPlantilla Order By b.NombreSeccion,a.Orden"
            InsertCommand="Insert INTO [PreguntasPorPlantilla] ([IdPlantilla], [IdTipoDePregunta],[IdSeccionFSU],[PreguntaDePlantilla],[Orden],[Requerida],[IdTipoDeRespuesta],[CreadoPor], [FechaCreacion], [Activo],[IdAmigable]) VALUES (@IdPlantilla, @IdTipoDePregunta,@IdSeccionFSU,@PreguntaDePlantilla,@Orden,@Requerida,@IdTipoDeRespuesta,'PACO', getDate(), 1,@IdAmigable) SELECT @IdPreguntaPorPlantilla = SCOPE_IDENTITY()"
            UpdateCommand="Update [PreguntasPorPlantilla] SET [IdTipoDePregunta]=@IdTipoDePregunta, [IdSeccionFSU]=@IdSeccionFSU,[PreguntaDePlantilla]=@PreguntaDePlantilla,[Orden]=@Orden,[Requerida]=@Requerida,[IdTipoDeRespuesta]=@IdTipoDeRespuesta,[ActualizadoPor]='PACO', [FechaActualizacion]=getDate(), [IdAmigable]=@IdAmigable WHERE [IdPreguntaPorPlantilla] = @IdPreguntaPorPlantilla"
            DeleteCommand="Update [PreguntasPorPlantilla] SET [Activo]=0 WHERE [IdPreguntaPorPlantilla] = @IdPreguntaPorPlantilla"
            >

             <SelectParameters>
                     <asp:SessionParameter Name="IdPlantilla" />
                     
                </SelectParameters>

            <InsertParameters>
                <asp:SessionParameter Name="IdPlantilla" />
                <asp:FormParameter Name="IdTipoDePregunta"/>
                <asp:FormParameter Name="IdSeccionFSU" />
                <asp:FormParameter Name="PreguntaDePlantilla" />
                <asp:FormParameter Name="Orden" />
                <asp:FormParameter Name="Requerida" />
                <asp:FormParameter Name="IdTipoDeRespuesta" />
                <asp:FormParameter Name="IdAmigable" />
                <asp:Parameter Name="IdPreguntaPorPlantilla" Direction="Output"  type="Int32" />
                

            </InsertParameters>

            <UpdateParameters>
                <asp:FormParameter Name="IdTipoDePregunta" />
                <asp:FormParameter Name="IdSeccionFSU" />
                <asp:FormParameter Name="PreguntaDePlantilla" />
                <asp:FormParameter Name="Orden" />
                <asp:FormParameter Name="Requerida" />
                <asp:FormParameter Name="IdTipoDeRespuesta" />
                <asp:FormParameter Name="IdPreguntaPorPlantilla" />
                <asp:FormParameter Name="IdAmigable" />
         
            </UpdateParameters>

            <DeleteParameters>
                 <asp:FormParameter Name="IdPreguntaPorPlantilla" />
            </DeleteParameters>


        </asp:SqlDataSource>

        
       <asp:SqlDataSource runat="server" ID="SqlDataSourceTiposPreguntas" ConnectionString='<%$ ConnectionStrings:SUEPPSConnectionString %>' SelectCommand="SELECT * FROM [TiposDePreguntas] where Activo=1 "></asp:SqlDataSource>
     
       <asp:SqlDataSource runat="server" ID="SqlDataSourceTipoRespuesta" ConnectionString='<%$ ConnectionStrings:SUEPPSConnectionString %>' SelectCommand="SELECT * FROM [TiposDeRespuesta] where Activo=1"></asp:SqlDataSource>


       <asp:SqlDataSource runat="server" ID="SqlDataSourceOpciones" ConnectionString='<%$ ConnectionStrings:SUEPPSConnectionString %>' 
                    SelectCommand="SELECT * FROM [OpcionesPreguntaPorPlantilla] WHERE ([IdPreguntaPorPlantilla] = @IdPreguntaPorPlantilla AND [Activo]=1)"
                    InsertCommand="Insert INTO [OpcionesPreguntaPorPlantilla] ([Opcion], [IdPreguntaPorPlantilla], [CreadoPor], [FechaCreacion], [Activo],[Valor],[SaltaACodigo]) VALUES (@Opcion, @IdPreguntaPorPlantilla, 'PACO', getDate(), 1,@Valor,@SaltaACodigo)"
                    UpdateCommand="Update [OpcionesPreguntaPorPlantilla] SET [Opcion]=@Opcion, [ActualizadoPor]='PACO', [FechaActualizacion]=getDate(),[Valor]=@Valor,[SaltaACodigo]=@SaltaACodigo WHERE [IdOpcionPreguntaPorPlantilla] = @IdOpcionPreguntaPorPlantilla"
                    DeleteCommand="Update [OpcionesPreguntaPorPlantilla] SET [Activo]=0 WHERE [IdOpcionPreguntaPorPlantilla] = @IdOpcionPreguntaPorPlantilla"
                    >
                <SelectParameters>
                    <asp:SessionParameter SessionField="IdPreguntaPorPlantilla" Name="IdPreguntaPorPlantilla" Type="Int32"></asp:SessionParameter>
                
                </SelectParameters>

                <InsertParameters>
                    <asp:SessionParameter SessionField="IdPreguntaPorPlantilla" Name="IdPreguntaPorPlantilla" Type="Int32"></asp:SessionParameter>
                    <asp:FormParameter Name="Opcion" />
                    <asp:FormParameter Name="Valor" />
                    <asp:FormParameter Name="SaltaACodigo" />
                </InsertParameters>

                <UpdateParameters>
                    <asp:SessionParameter SessionField="IdPreguntaPorPlantilla" Name="IdPreguntaPorPlantilla" Type="Int32"></asp:SessionParameter>
                    <asp:FormParameter Name="Opcion" />
                    <asp:FormParameter Name="Valor" />
                     <asp:FormParameter Name="SaltaACodigo" />
                </UpdateParameters>
 
            </asp:SqlDataSource>


           <asp:SqlDataSource runat="server" ID="SqlDataSourceSeccionFSU" ConnectionString='<%$ ConnectionStrings:SUEPPSConnectionString %>' SelectCommand="SELECT * FROM [SeccionesFSU] where Activo=1"></asp:SqlDataSource>



    </div>
  </asp:Content>