<%@ Page Title="Planificación" Language="VB" MasterPageFile="~/Site.master" AutoEventWireup="false" CodeFile="PlanificacionPolitica.aspx.vb" Inherits="GestionPublica_PlanificacionPolitica" %>

<%@ Register Src="~/MOCA_UE.ascx" TagPrefix="uc1" TagName="MOCA_UE" %>


<%@ Register Assembly="DevExpress.Web.v13.2, Version=13.2.5.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web.ASPxFormLayout" TagPrefix="dx" %>
<%@ Register Assembly="DevExpress.Web.v13.2, Version=13.2.5.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web.ASPxEditors" TagPrefix="dx" %>

<asp:Content ID="cHeader" ContentPlaceHolderID="HeadContent" Runat="Server">
</asp:Content>
<asp:Content ID="cBody" ContentPlaceHolderID="MainContent" Runat="Server">
    <uc1:MOCA_UE runat="server" ID="MOCA_UE01" />
            <script type="text/javascript">


                function Uploader_OnUploadStart() {
                    btnUpload.SetEnabled(false);
                }
                function Uploader_OnFileUploadComplete(args) {
                    var imgSrc = "";
                    if (args.isValid) {
                        var date = new Date();
                        imgSrc = "Uploads/" + args.callbackData + "?dx=" + date.getTime();
                    }

                    alert("Archivo Subido");

                    detailGrid.PerformCallback();
                }
                function Uploader_OnFilesUploadComplete(args) {
                    UpdateUploadButton();
                }
                function UpdateUploadButton() {
                    btnUpload.SetEnabled(uploader.GetText(0) != "");
                }
                function getPreviewImageElement() {
                    return document.getElementById("previewImage");
                }



        </script>

         <asp:SqlDataSource runat="server" ID="SqlObjetivosEstrategicos" ConnectionString='<%$ ConnectionStrings:SUEPPSConnectionString %>' 
                SelectCommand="SELECT * FROM [ObjetivosEstrategicosPorPolitica] WHERE ([IdPolitica] = @IdPolitica and [Activo]=1)"
                InsertCommand="INSERT INTO  [ObjetivosEstrategicosPorPolitica] ([NombreObjetivoEstrategico], [IdPolitica], [CreadoPor], [FechaCreacion], [Activo]) VALUES (@NombreObjetivoEstrategico, @IdPolitica, @Usuario, getDate(), 1)"
                UpdateCommand="UPDATE [ObjetivosEstrategicosPorPolitica] SET [NombreObjetivoEstrategico]=@NombreObjetivoEstrategico,[ActualizadoPor]=@Usuario,[FechaActualizacion]=getDate() WHERE [IdObjetivoEstrategicoPorPolitica] = @IdObjetivoEstrategicoPorPolitica" 
                DeleteCommand="UPDATE [ObjetivosEstrategicosPorPolitica] SET [Activo]=0 WHERE ([IdObjetivoEstrategicoPorPolitica] = @IdObjetivoEstrategicoPorPolitica) "
                >
                <SelectParameters>
                    <asp:SessionParameter Name="IdPolitica" ></asp:SessionParameter>
                </SelectParameters>

                <InsertParameters>
                    <asp:FormParameter Name="NombreObjetivoEstrategico" />
                    <asp:SessionParameter Name="IdPolitica" />
                    <asp:SessionParameter Name="Usuario" />

                </InsertParameters>

             <UpdateParameters>
                 <asp:SessionParameter Name="Usuario" />
                 <asp:FormParameter Name="NombreObjetivoEstrategico" />
            
             </UpdateParameters>
            </asp:SqlDataSource>


    <asp:SqlDataSource runat="server" ID="SqlObjetivosEspecificos" ConnectionString='<%$ ConnectionStrings:SUEPPSConnectionString %>' 
                SelectCommand="SELECT * FROM [ObjetivosEspecificosPorPolitica] WHERE ([IdPolitica] = @IdPolitica and [Activo]=1)"
                InsertCommand="INSERT INTO  [ObjetivosEspecificosPorPolitica] ([NombreObjetivoEspecifico], [IdPolitica], [CreadoPor], [FechaCreacion], [Activo]) VALUES (@NombreObjetivoEspecifico, @IdPolitica, @Usuario, getDate(), 1)"
                UpdateCommand="UPDATE [ObjetivosEspecificosPorPolitica] SET [NombreObjetivoEspecifico] = @NombreObjetivoEspecifico, [ActualizadoPor ]= @Usuario, [FechaActualizacion]=getDate() WHERE [IdObjetivoEspecificoPorPolitica]= @IdObjetivoEspecificoPorPolitica" 
                DeleteCommand="UPDATE [ObjetivosEspecificosPorPolitica] SET [Activo]=0 WHERE ([IdObjetivoEspecificoPorPolitica] = @IdObjetivoEspecificoPorPolitica) "
                >
                <SelectParameters>
                    <asp:SessionParameter Name="IdPolitica" ></asp:SessionParameter>
                </SelectParameters>

                <InsertParameters>
                    
                    <asp:FormParameter Name="NombreObjetivoEspecifico" />
                    <asp:SessionParameter Name="IdPolitica" />
                    <asp:SessionParameter Name="Usuario" />

                </InsertParameters>

         <UpdateParameters>
                 <asp:SessionParameter Name="Usuario" />
                 <asp:FormParameter Name="NombreObjetivoEspecifico" />
             
             </UpdateParameters>
         </asp:SqlDataSource>
        



                           <dx:ASPxGridView ID="GridPoliticas" runat="server" AutoGenerateColumns="False" DataSourceID="SqlPolitica" KeyFieldName="IdPolitica" Width="100%" SettingsEditing-EditFormColumnCount="1" Settings-ShowFilterRow="true" Settings-ShowFilterRowMenu="true" >
                                    <Columns>
                                        <dx:GridViewDataTextColumn FieldName="IdPolitica" Caption="#" ReadOnly="True" ShowInCustomizationForm="True" VisibleIndex="0" Width="20px">
                                            <EditFormSettings Visible="False" />
                                            <Settings AllowAutoFilter="False" />
                                        </dx:GridViewDataTextColumn>
                                        <dx:GridViewDataTextColumn FieldName="Nombre" ShowInCustomizationForm="True" VisibleIndex="1">
                                            <Settings AutoFilterCondition="Contains" />
                                        </dx:GridViewDataTextColumn>
                                        
                                        <dx:GridViewDataTextColumn FieldName="SujetosDeAtencion"  Caption="Sujetos de Atención" ShowInCustomizationForm="True" VisibleIndex="2">
                                        <Settings AutoFilterCondition="Contains" />
                                        </dx:GridViewDataTextColumn>
                                       
                                         <dx:GridViewCommandColumn   VisibleIndex="3"  Caption="Acción">
                                                        
                                                          <NewButton Visible="true"></NewButton>
                                                          <EditButton Visible="true"></EditButton>
                                                          <UpdateButton Visible="true"></UpdateButton>
                                                          <DeleteButton Visible="true"></DeleteButton>
                                                          
                                         </dx:GridViewCommandColumn>
                                        
                                        <dx:GridViewDataTextColumn FieldName="Planificar" ShowInCustomizationForm="True"  Visible="true" VisibleIndex="12">
                                            <DataItemTemplate>
                                                <asp:LinkButton id="link1"  Text="Planificar Política" runat="server" OnClick="send2" /> 
                                            </DataItemTemplate>
                                             <EditFormSettings Visible="False" />
                                            <Settings AllowAutoFilter="False" />
                                        </dx:GridViewDataTextColumn>
                                    </Columns>

                                     <SettingsPager>
                                         <AllButton Visible="True" Text="Todos">
                                         </AllButton>
                                     </SettingsPager>

                                    <SettingsDetail ShowDetailRow="True" AllowOnlyOneMasterRowExpanded="true"></SettingsDetail>
                <SettingsBehavior AllowFocusedRow="True" />
                <Templates>

                    <DetailRow>

                        <dx:ASPxGridView ID="GridObjetivosEstrategicos" runat="server" DataSourceID="SqlObjetivosEstrategicos" KeyFieldName="IdObjetivoEstrategicoPorPolitica" IsDetailGrid="true" onbeforeperformdataselect="GridObjetivosEstrategicos_BeforePerformDataSelect" Width="100%" SettingsEditing-EditFormColumnCount="1" Visible="true" Settings-ShowFilterRow="true" Settings-ShowFilterRowMenu="true" >
                     <Columns>
                         <dx:GridViewDataTextColumn FieldName="IdObjetivoEstrategicoPorPolitica" Caption="#" VisibleIndex="0" Width="20px">
                              <EditFormSettings Visible="False" />
                              <Settings AllowAutoFilter="False" />
                         </dx:GridViewDataTextColumn>
                         <dx:GridViewDataTextColumn FieldName="NombreObjetivoEstrategico" Caption="Objetivos Estratégicos" VisibleIndex="1" Width="75%">
                             <Settings AutoFilterCondition="Contains" />
                         </dx:GridViewDataTextColumn>
                         <dx:GridViewCommandColumn Caption="Acción" Width="20%">

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




                        <br>




                        </br>
                        <br>
                        </br>


                    <dx:ASPxGridView ID="GridObjetivosEspecificos" runat="server" DataSourceID="SqlObjetivosEspecificos" KeyFieldName="IdObjetivoEspecificoPorPolitica" IsDetailGrid="true" onbeforeperformdataselect="GridObjetivosEspecificos_BeforePerformDataSelect" Width="100%" SettingsEditing-EditFormColumnCount="1" Visible="true" Settings-ShowFilterRow="true" Settings-ShowFilterRowMenu="true" >
                     <Columns>
                         <dx:GridViewDataTextColumn FieldName="IdObjetivoEspecificoPorPolitica" Caption="#" VisibleIndex="0" Width="20px">
                              <EditFormSettings Visible="False" />
                             <Settings AllowAutoFilter="False" />
                         </dx:GridViewDataTextColumn>
                         <dx:GridViewDataTextColumn FieldName="NombreObjetivoEspecifico" Caption="Objetivos Específicos" VisibleIndex="1" Width="75%"></dx:GridViewDataTextColumn>
                         <dx:GridViewCommandColumn Caption="Acción" Width="20%">
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


                        <br />
                        <br />


                        <dx:ASPxPanel ID="Panel1" runat="server" >
                    <PanelCollection>
                        <dx:PanelContent >



        <table id="Table1">
        <tr>
            <td class="content">
                <table>
                    <tr>
                        <td style="padding-right: 20px; vertical-align: top;">
                            <table>
                                <tr>
                                    <td class="caption">
                                        <dx:ASPxLabel ID="ASPxLabel1" runat="server" Text="Documento:">
                                        </dx:ASPxLabel>
                                    </td>
                                    <td>
                                        <dx:ASPxUploadControl ID="ASPxUploadControl1" runat="server" ClientInstanceName="uploader" ShowProgressPanel="false"
                                            NullText="Seleccionar archivo..." Size="35" OnFileUploadComplete="uplImage_FileUploadComplete">
                                            <ClientSideEvents FileUploadComplete="function(s, e) { Uploader_OnFileUploadComplete(e); }"
                                                FilesUploadComplete="function(s, e) { Uploader_OnFilesUploadComplete(e); }"
                                                FileUploadStart="function(s, e) { Uploader_OnUploadStart(); }"
                                                TextChanged="function(s, e) { UpdateUploadButton(); }"></ClientSideEvents>
                                            <ValidationSettings MaxFileSize="4194304" >
                                            </ValidationSettings>
                                        </dx:ASPxUploadControl>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                    </td>
                                    <td class="note">
                                        <dx:ASPxLabel ID="lblAllowebMimeType" runat="server" Text="Subir Archivos de Planificación"
                                            Font-Size="8pt">
                                        </dx:ASPxLabel>
                                        <br />
                                        <dx:ASPxLabel ID="ASPxLabel2" runat="server" Text="Tamaño Máximo de Archivos: 4Mb" Font-Size="8pt">
                                        </dx:ASPxLabel>
                                    </td>
                                </tr>
                                <tr>
                                    <td colspan="2" class="buttonCell">
                                        <dx:ASPxButton ID="ASPxButton1" runat="server" AutoPostBack="False" Text="Subir" ClientInstanceName="btnUpload"
                                            Width="80px" ClientEnabled="False" style="margin: 0 auto;">
                                            <ClientSideEvents Click="function(s, e) { uploader.Upload(); }" />
                                        </dx:ASPxButton>
                                    </td>
                                </tr>
                            </table>
                        </td>
                        
                    </tr>
                </table>
            </td>
        </tr>
    </table>    


                        </dx:PanelContent>
                    </PanelCollection>
                
            </dx:ASPxPanel>
           

                        <br />
                        <br />




                        <dx:ASPxGridView ClientInstanceName="detailGrid" ID="ASPxGridView2" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSourceRecursos" KeyFieldName="IdRecursosDePolitica" IsDetailGrid="true" onbeforeperformdataselect="ASPxGridView2_BeforePerformDataSelect" Visible="True" Width="100%" OnLoad="ASPxGridView2_Load" >
                            <Columns>
                                <dx:GridViewDataTextColumn FieldName="IdRecursosDePolitica" ReadOnly="True" VisibleIndex="0" Caption="#">
                                    <EditFormSettings Visible="False" />
                                </dx:GridViewDataTextColumn>
                                <dx:GridViewDataTextColumn FieldName="Enlace" VisibleIndex="1">
                                    <DataItemTemplate>
                                        <dx:ASPxHyperLink ID="ASPxHyperLink1" runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "Direccion")%>' NavigateUrl='<%# DataBinder.Eval(Container.DataItem, "Enlace")%>'> 
                                        </dx:ASPxHyperLink>
                                    
                                    </DataItemTemplate>
                                </dx:GridViewDataTextColumn>
                                <dx:GridViewDataTextColumn FieldName="IdPolitica" VisibleIndex="2"  Visible="false">
                                </dx:GridViewDataTextColumn>
                                <dx:GridViewDataTextColumn FieldName="CreadoPor" VisibleIndex="3" Visible="false">
                                </dx:GridViewDataTextColumn>
                                <dx:GridViewDataDateColumn FieldName="FechaCreacion" VisibleIndex="4" Visible="false">
                                </dx:GridViewDataDateColumn>
                                <dx:GridViewDataTextColumn FieldName="ActualizadoPor" VisibleIndex="5" Visible="false">
                                </dx:GridViewDataTextColumn>
                                <dx:GridViewDataDateColumn FieldName="FechaActualizacion" VisibleIndex="6" Visible="false">
                                </dx:GridViewDataDateColumn>
                                <dx:GridViewDataCheckColumn FieldName="Activo" VisibleIndex="7" Visible="false">
                                </dx:GridViewDataCheckColumn>
                                 <dx:GridViewCommandColumn VisibleIndex="8" HeaderStyle-HorizontalAlign="Center" Caption="Acción" CellStyle-HorizontalAlign="NotSet">
                                        
                                        <%--<NewButton Visible="true" />--%>
                                      
                                        <DeleteButton Visible="true"/>
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



                                <asp:SqlDataSource ID="SqlPolitica" runat="server" ConnectionString="<%$ ConnectionStrings:SUEPPSConnectionString %>" 
                                    
                                     UpdateCommand="UPDATE [Politicas] SET [Nombre]=@Nombre,[SujetosDeAtencion]=@SujetosDeAtencion, [ActualizadoPor]=@Actualizado, [FechaActualizacion]= getDate()  WHERE [IdPolitica]= @IdPolitica "        
                                     SelectCommand="SELECT * FROM [Politicas] where [Activo]=1" 
                                     InsertCommand="INSERT INTO [Politicas] ([Nombre], [SujetosDeAtencion],[CreadoPor],[FechaCreacion],[Activo]) VALUES (@Nombre, @SujetosDeAtencion,@Usuario,getDate(),1)"
                                     Deletecommand="UPDATE [Politicas] SET [Activo]=0 WHERE [IdPolitica]= @IdPolitica"
                                    >
                                    
                                    <InsertParameters>
                                        <asp:SessionParameter Name="Usuario" />
                                        <asp:FormParameter Name="Nombre" />
                                         <asp:FormParameter Name="SujetosDeAtencion" />

                                    </InsertParameters>  

                                     <UpdateParameters>
                                        <asp:SessionParameter Name="Actualizado" />
                                        <asp:FormParameter Name="Nombre" />
                                         <asp:FormParameter Name="SujetosDeAtencion" />

                                    </UpdateParameters>
                                    
                                                       
                                </asp:SqlDataSource>


                                            <%-- RECURSOS --%>

            <asp:SqlDataSource runat="server" ID="SqlDataSourceRecursos" ConnectionString='<%$ ConnectionStrings:SUEPPSConnectionString %>' 
                SelectCommand="SELECT * FROM [RecursosDePolitica] WHERE ([IdPolitica] = @IdPolitica)"
                InsertCommand="INSERT INTO  [RecursosDePolitica] ([Enlace], [Direccion], [IdPolitica], [CreadoPor], [FechaCreacion], [Activo]) VALUES (@EnlaceP, @NombreP, @IdPoliticaP, 'funciona', getDate(), 1)"
                UpdateCommand="UPDATE [RecursosDePolitica] SET ([Enlace]=@Enlace, [IdPolitica]=@IdPolitica, [CreadoPor]='hola', [FechaCreacion]=getDate(), [Activo]=1) WHERE ([IdPolitica] = @IdPolitica)" 
                DeleteCommand="UPDATE [RecursosDePolitica] SET ([Activo]=0) WHERE ([IdPolitica] = @IdPolitica) "
                >
                <SelectParameters>
                    <asp:SessionParameter SessionField="IdPolitica" Name="IdPolitica" Type="Int32"></asp:SessionParameter>
                </SelectParameters>

                <InsertParameters>
                    <asp:SessionParameter SessionField="Enlace" Name="EnlaceP" Type="String"></asp:SessionParameter>
                    <asp:SessionParameter SessionField="IdIdPoliticaP" Name="IdPoliticaP" Type="String"></asp:SessionParameter>
                    <asp:SessionParameter SessionField="Nombre" Name="NombreP" Type="String"></asp:SessionParameter>
                </InsertParameters>
            </asp:SqlDataSource>
      
   

        

</asp:Content>

