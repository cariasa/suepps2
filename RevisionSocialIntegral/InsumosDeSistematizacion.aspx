<%@ Page Title="Insumos de Sistematización" Language="VB" AutoEventWireup="false" CodeFile="InsumosDeSistematizacion.aspx.vb" Inherits="RevisionSocial_InsumosDeSistematizacion" MasterPageFile="~/Site.master" %>

<%@ Register Assembly="DevExpress.Web.v13.2, Version=13.2.5.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web.ASPxMenu" TagPrefix="dx" %>

<%@ Register Assembly="DevExpress.Web.v13.2, Version=13.2.5.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web.ASPxPanel" TagPrefix="dx" %>

<%@ Register Assembly="DevExpress.Web.v13.2, Version=13.2.5.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web.ASPxPopupControl" TagPrefix="dx" %>

<%@ Register Assembly="DevExpress.Web.v13.2, Version=13.2.5.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web.ASPxObjectContainer" TagPrefix="dx" %>

<%@ Register Assembly="DevExpress.Web.v13.2, Version=13.2.5.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web.ASPxUploadControl" TagPrefix="dx" %>

<%@ Register Assembly="DevExpress.Web.v13.2, Version=13.2.5.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web.ASPxGridView" TagPrefix="dx" %>
<%@ Register Assembly="DevExpress.Web.v13.2, Version=13.2.5.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web.ASPxEditors" TagPrefix="dx" %>


<%@ Register Src="~/MOCA_UE.ascx" TagPrefix="uc1" TagName="MOCA_UE" %>


<asp:Content ID="cHeader" ContentPlaceHolderID="HeadContent" Runat="Server">
</asp:Content>
<asp:Content ID="cBody" ContentPlaceHolderID="MainContent" Runat="Server">
    <uc1:MOCA_UE runat="server" ID="MOCA_UE01" />
    <div>
        <div>

        <script type="text/javascript">
     
            function OnAnoChanged(cmbAno) {
                cmbTri.PerformCallback(cmbAno.GetValue().toString());
            }

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
            <div>
                      
        
            <dx:ASPxLabel ID="ASPxLabelPrograma" runat="server" Text="Prueba"></dx:ASPxLabel>
            </div>

    
    

    <table>
        <tr>
       
            <td class="LeftPadding">
                <dx:ASPxLabel runat="server" Text="Año:" ID="ASPxLabel1" AssociatedControlID="CmbAno" />
            </td>
            <td>

                <dx:ASPxComboBox runat="server" id="CmbAno" clientinstancename="cmbAno" DataSourceID="SqlAno"  ValueField="Ano"  TextField="Ano" 
                    dropdownstyle="DropDown" incrementalfilteringmode="StartsWith" enablesynchronization="False"> 
                    <ClientSideEvents SelectedIndexChanged="function(s, e) { OnAnoChanged(s); }" /> 
                </dx:ASPxComboBox>
             </td>



            <td class="LeftPadding">
                <dx:ASPxLabel runat="server" Text="Trimestre:" ID="ASPxLabel2" AssociatedControlID="CmbTri" />
            </td>

            <td>
                <dx:ASPxComboBox runat="server" id="CmbTri" clientinstancename="cmbTri" 
                    dropdownstyle="DropDown" incrementalfilteringmode="StartsWith" enablesynchronization="False"> 
                    <ClientSideEvents SelectedIndexChanged="function(s, e) { ASPxGridView1.PerformCallback(s.GetValue()); }"> </ClientSideEvents>
                </dx:ASPxComboBox>
              
            </td>
            
        </tr>
    </table>

          <asp:SqlDataSource ID="SqlAno" runat="server" ConnectionString="<%$ ConnectionStrings:SUEPPSConnectionString %>" SelectCommand="SELECT [Ano], [IdAnoPrograma], [IdPrograma] FROM [AnoPrograma] where [IdPrograma]=@Programa and [Activo]=1">
                                <SelectParameters>
                                    <asp:SessionParameter Name="Programa" />
                                </SelectParameters>
          </asp:SqlDataSource>

        <asp:SqlDataSource runat="server" ID="SqlDataSourceArea" ConnectionString='<%$ ConnectionStrings:SUEPPSConnectionString %>' 
            SelectCommand="SELECT [IdAreaDeInfluencia], [DescripcionAreaDeInfluencia] FROM [AreasDeInfluencia]"></asp:SqlDataSource>
       

        <asp:SqlDataSource ID="SqlDataSourceTri" runat="server" ConnectionString='<%$ ConnectionStrings:SUEPPSConnectionString %>'
            
            SelectCommand="SELECT DISTINCT s.Periodo FROM [SistematizacionDeMonitoreo] s, [MetaYMonitoreoPorPeriodo] m  WHERE (s.Ano = m.Ano) AND (s.Ano = @p)">
                       
            <SelectParameters>
                <asp:Parameter Name="p" />
            </SelectParameters>
        
        
        </asp:SqlDataSource>
    
            <dx:ASPxGridView ID="ASPxGridView1" ClientInstanceName="ASPxGridView1" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSourceSistematizacion" 
                KeyFieldName="IdSistematizacionMonitoreo" ShowDetailRow="true" OnCustomCallback="grid_custom" Width="1012px" style="margin-top: 0px"  OnLoad="ASPxGridView1_Load"
                >
                <Columns>
                    <dx:GridViewDataTextColumn FieldName="IdSistematizacionMonitoreo" ReadOnly="True" VisibleIndex="0" Caption="#">
                        <EditFormSettings Visible="False"></EditFormSettings>
                    </dx:GridViewDataTextColumn>
                    <dx:GridViewDataTextColumn FieldName="IdPrograma" VisibleIndex="1" ShowInCustomizationForm="false" EditFormSettings-Visible="False" Visible="false"> <EditFormSettings Visible="False"></EditFormSettings>
                    </dx:GridViewDataTextColumn>
                    <dx:GridViewDataDateColumn FieldName="Fecha" VisibleIndex="2" ShowInCustomizationForm="false" EditFormSettings-Visible="False"> <EditFormSettings Visible="False"></EditFormSettings>
                    </dx:GridViewDataDateColumn>
                    <dx:GridViewDataTextColumn FieldName="Comentario" VisibleIndex="3"></dx:GridViewDataTextColumn>
                    <dx:GridViewDataTextColumn FieldName="Usuario" VisibleIndex="4" ShowInCustomizationForm="false" EditFormSettings-Visible="False" >
                         <EditFormSettings Visible="False"></EditFormSettings>
                    </dx:GridViewDataTextColumn>
                    <dx:GridViewDataTextColumn FieldName="Ano" VisibleIndex="5" Caption="Año" ShowInCustomizationForm="false" EditFormSettings-Visible="False"> <EditFormSettings Visible="False"></EditFormSettings>
                    </dx:GridViewDataTextColumn>
                    <dx:GridViewDataTextColumn FieldName="Periodo" VisibleIndex="6" ShowInCustomizationForm="false" EditFormSettings-Visible="False" Caption="Período"> <EditFormSettings Visible="False"></EditFormSettings>
                    </dx:GridViewDataTextColumn>
                    <dx:GridViewDataTextColumn FieldName="CreadoPor" VisibleIndex="7" ShowInCustomizationForm="false" EditFormSettings-Visible="False" Visible="false"> <EditFormSettings Visible="False"></EditFormSettings>
                    </dx:GridViewDataTextColumn>
                    <dx:GridViewDataDateColumn FieldName="FechaCreacion" VisibleIndex="8" ShowInCustomizationForm="false" EditFormSettings-Visible="False" Visible="false"> <EditFormSettings Visible="False"></EditFormSettings>
                    </dx:GridViewDataDateColumn>
                    <dx:GridViewDataTextColumn FieldName="ActualizadoPor" VisibleIndex="9" ShowInCustomizationForm="false" EditFormSettings-Visible="False" Visible="false"> <EditFormSettings Visible="False"></EditFormSettings>
                    </dx:GridViewDataTextColumn>
                    <dx:GridViewDataDateColumn FieldName="FechaActualizacion" VisibleIndex="10" ShowInCustomizationForm="false" EditFormSettings-Visible="False" Visible="false"> <EditFormSettings Visible="False"></EditFormSettings>
                    </dx:GridViewDataDateColumn>
                    <dx:GridViewDataCheckColumn FieldName="Activo" VisibleIndex="11" Visible="false" ShowInCustomizationForm="false" EditFormSettings-Visible="False" > <EditFormSettings Visible="False"></EditFormSettings>
                    </dx:GridViewDataCheckColumn>
                    <dx:GridViewCommandColumn VisibleIndex="12" HeaderStyle-HorizontalAlign="Center" Caption="Acción" CellStyle-HorizontalAlign="NotSet">

                            <EditButton Visible="true" />
                            <NewButton Visible="true" />
                            <HeaderStyle HorizontalAlign="Center"></HeaderStyle>
                            
                    </dx:GridViewCommandColumn>
                </Columns>

                 <SettingsPager>
                       <AllButton Visible="True" Text="Todos">
                       </AllButton>
                    </SettingsPager>

                <SettingsDetail ShowDetailRow="True" AllowOnlyOneMasterRowExpanded="true"></SettingsDetail>
                <SettingsBehavior AllowFocusedRow="True" />
                <Templates>
                    <DetailRow>


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
           


                        <dx:ASPxGridView ClientInstanceName="detailGrid" ID="ASPxGridView2" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSourceRecursos" KeyFieldName="IdRecursosSistematizacionMonitoreo" IsDetailGrid="true" onbeforeperformdataselect="ASPxGridView2_BeforePerformDataSelect" Visible="True" >
                            <Columns>
                                <dx:GridViewDataTextColumn FieldName="IdRecursosSistematizacionMonitoreo" ReadOnly="True" Caption="#" VisibleIndex="0" Visible="true">
                                    <EditFormSettings Visible="False" />
                                </dx:GridViewDataTextColumn>
                                <dx:GridViewDataTextColumn FieldName="Enlace" VisibleIndex="1">
                                    <DataItemTemplate>
                                        <dx:ASPxHyperLink ID="ASPxHyperLink1" runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "Direccion")%>' NavigateUrl='<%# DataBinder.Eval(Container.DataItem, "Enlace")%>'> 
                                        </dx:ASPxHyperLink>
                                    
                                    </DataItemTemplate>
                                </dx:GridViewDataTextColumn>
                                
                                 <dx:GridViewCommandColumn VisibleIndex="8" HeaderStyle-HorizontalAlign="Center" Caption="Acción" CellStyle-HorizontalAlign="NotSet">
                                        
                                     
                                      
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



            <asp:SqlDataSource runat="server" ID="SqlDataSourceSistematizacion" ConnectionString='<%$ ConnectionStrings:SUEPPSConnectionString %>' OnInserted="SqlDataSourceSistematizacion_Inserted"  OnUpdated="SqlDataSourceSistematizacion_Inserted" OnDeleted="SqlDataSourceSistematizacion_Inserted"
                SelectCommand="SELECT * FROM [SistematizacionDeMonitoreo] WHERE ([Periodo] = @P AND [IdPrograma]=@Pro AND [Ano]=@A AND [Usuario]=@Usr)"
                UpdateCommand="UPDATE [SistematizacionDeMonitoreo] SET [Comentario]=@Comentario WHERE [IdSistematizacionMonitoreo]=@IdSistematizacionMonitoreo"
                InsertCommand="INSERT INTO [SistematizacionDeMonitoreo] (IdPrograma, Fecha, Comentario, Usuario, Ano, Periodo, CreadoPor, FechaCreacion, Activo) VALUES (@P, getDate(), @Comentario, @Usr, @A, @Pe, @Usr, getDate(), 1)"
                >
                <SelectParameters>
                    <asp:SessionParameter Name="P" />
                    <asp:SessionParameter Name="Pro" />
                    <asp:SessionParameter Name="A" />
                    <asp:Parameter Name="Usr" />
                </SelectParameters>
                <InsertParameters>
                    <asp:SessionParameter Name="P" />
                    <asp:SessionParameter Name="A" />
                    <asp:SessionParameter Name="Pe" />
                    <asp:Parameter Name="Usr" />
                    <asp:FormParameter Name="Comentario" />
                </InsertParameters>

               

            </asp:SqlDataSource>
        

            <%-- RECURSOS --%>

            <asp:SqlDataSource runat="server" ID="SqlDataSourceRecursos" ConnectionString='<%$ ConnectionStrings:SUEPPSConnectionString %>' OnInserted="SqlDataSourceRecursos_Inserted" 
                SelectCommand="SELECT IdRecursosSistematizacionMonitoreo, Enlace, Direccion FROM [RecursosDeSistematizacionDeMonitoreo] WHERE ([IdSistematizacionMonitoreo] = @IdSistematizacionMonitoreo) and Activo=1"
                InsertCommand="INSERT INTO  [RecursosDeSistematizacionDeMonitoreo] ([Enlace], [Direccion], [IdSistematizacionMonitoreo], [CreadoPor], [FechaCreacion], [Activo]) VALUES (@EnlaceP, @NombreP, @IdSistematizacionMonitoreo, @Usuario, getDate(), 1)"
                DeleteCommand="UPDATE [RecursosDeSistematizacionDeMonitoreo] SET ([Activo]=0) WHERE ([IdSistematizacionMonitoreo] = @IdSistematizacionMonitoreo) "
                >
                <SelectParameters>

                    <asp:SessionParameter Name="IdSistematizacionMonitoreo" />

                </SelectParameters>

                <InsertParameters>
                    <asp:SessionParameter SessionField="Enlace" Name="EnlaceP" Type="String"></asp:SessionParameter>
                    <asp:SessionParameter Name="IdSistematizacionMonitoreo" />
                    <asp:SessionParameter SessionField="Nombre" Name="NombreP" Type="String"></asp:SessionParameter>
                    <asp:SessionParameter Name="Usuario" />
                </InsertParameters>
            </asp:SqlDataSource>
        </div>
    </div>
        


</asp:Content>
