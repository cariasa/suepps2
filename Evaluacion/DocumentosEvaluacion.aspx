<%@ Page Language="VB" AutoEventWireup="false" CodeFile="DocumentosEvaluacion.aspx.vb" Inherits="Evaluacion_DocumentosEvaluacion" MasterPageFile="~/Site.master" %>

<%@ Register Assembly="DevExpress.Web.v13.1, Version=13.1.8.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web.ASPxGridView" TagPrefix="dx" %>

<%@ Register Assembly="DevExpress.Web.v13.1, Version=13.1.8.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web.ASPxEditors" TagPrefix="dx" %>

<%@ Register Src="~/MOCA_UE.ascx" TagPrefix="uc1" TagName="MOCA_UE" %>

<asp:Content ID="cHeader" ContentPlaceHolderID="HeadContent" runat="Server">
</asp:Content>
<asp:Content ID="cBody" ContentPlaceHolderID="MainContent" runat="Server">
    <uc1:MOCA_UE runat="server" ID="MOCA_UE01" />
    <script type="text/javascript">


        function Uploader_OnUploadStart() {
            btnUpload.SetEnabled(false);
        }
        function Uploader_OnFileUploadComplete(args) {
            var imgSrc = "";
            if (args.isValid) {
                var date = new Date();
                imgSrc = "Uploads/Evaluacion/" + args.callbackData + "?dx=" + date.getTime();
            }

            alert("Archivo Subido");
            ASPxGridViewDocumentosEvaluacion.PerformCallback();
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
        <table>
            <tr>
                <td><dx:ASPxLabel ID="ASPxLabelTitulo" runat="server" Font-Size="Large" /></td>
                <td>
                        <dx:ASPxLabel ID="espacio" runat="server" Text=" " Width="50"></dx:ASPxLabel>
                        <dx:ASPxHyperLink ID="ASPxHyperLinkRegresar" runat="server" Text="Regresar a Selección" NavigateUrl="Instrumentos.aspx" />

                </td>
            </tr>
        </table>
    </div>
    <div>

        <dx:ASPxGridView ClientInstanceName="ASPxGridViewDocumentosEvaluacion" ID="ASPxGridViewDocumentosEvaluacion" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSourceDocumentosEvaluacion" KeyFieldName="IdDocumentoEvaluacion" OnCustomCallback="grid_custom" OnLoad="ASPxGridViewDocumentosEvaluacion_Load">
            <Columns>
                <dx:GridViewDataTextColumn FieldName="IdDocumentoEvaluacion" ReadOnly="True" VisibleIndex="0">
                    <EditFormSettings Visible="False"></EditFormSettings>
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="IdPrograma" VisibleIndex="1" Visible="false"></dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="DescripcionDocumento" VisibleIndex="2"></dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="PalabrasClave" VisibleIndex="3"></dx:GridViewDataTextColumn>
                <dx:GridViewDataDateColumn FieldName="FechaDocumento" VisibleIndex="4"></dx:GridViewDataDateColumn>
                <dx:GridViewDataTextColumn FieldName="CreadoPor" VisibleIndex="5" Visible="false"></dx:GridViewDataTextColumn>
                <dx:GridViewDataDateColumn FieldName="FechaCreacion" VisibleIndex="6" Visible="false"></dx:GridViewDataDateColumn>
                <dx:GridViewDataTextColumn FieldName="ActualizadoPor" VisibleIndex="7" Visible="false"></dx:GridViewDataTextColumn>
                <dx:GridViewDataDateColumn FieldName="FechaActualizacion" VisibleIndex="8" Visible="false"></dx:GridViewDataDateColumn>
                <dx:GridViewDataCheckColumn FieldName="Activo" VisibleIndex="9" Visible="false"></dx:GridViewDataCheckColumn>
                <dx:GridViewCommandColumn VisibleIndex="10" HeaderStyle-HorizontalAlign="Center" Caption="Acción" CellStyle-HorizontalAlign="NotSet">

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
                    <dx:ASPxPanel ID="Panel1" runat="server">

                        <PanelCollection>
                            <dx:PanelContent>



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
                                                                        <ValidationSettings MaxFileSize="4194304">
                                                                        </ValidationSettings>
                                                                    </dx:ASPxUploadControl>
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td></td>
                                                                <td class="note">
                                                                    <dx:ASPxLabel ID="lblAllowebMimeType" runat="server" Text="Subir Archivos de Evaluación"
                                                                        Font-Size="8pt">
                                                                    </dx:ASPxLabel>
                                                                    <br />
                                                                    <dx:ASPxLabel ID="ASPxLabel2" runat="server" Text="Tamaño Máximo de Archivos: 4Mb" Font-Size="8pt">
                                                                    </dx:ASPxLabel>
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td colspan="2" class="buttonCell">
                                                                    <dx:ASPxButton ID="ASPxButton1" runat="server" AutoPostBack="False" Text="Registrar" ClientInstanceName="btnUpload"
                                                                        Width="80px" ClientEnabled="False" Style="margin: 0 auto;">
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



                    <dx:ASPxGridView ID="ASPxGridViewDetalleDocumentosEvaluacion" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSourceDetalleDocumentosEvaluacion" IsDetailGrid="true" OnBeforePerformDataSelect="ASPxGridViewDetalleDocumentosEvaluacion_BeforePerformDataSelect">
                        <Columns>
                            <dx:GridViewDataTextColumn FieldName="IdDetalleDocumentoEvaluacion" ReadOnly="True" VisibleIndex="0">
                                <EditFormSettings Visible="False"></EditFormSettings>
                            </dx:GridViewDataTextColumn>
                            <dx:GridViewDataTextColumn FieldName="IdDocumentoEvaluacion" VisibleIndex="1"></dx:GridViewDataTextColumn>
                            <%--<dx:GridViewDataTextColumn FieldName="Enlace" VisibleIndex="2"></dx:GridViewDataTextColumn>--%>
                            <dx:GridViewDataTextColumn FieldName="Enlace" VisibleIndex="2">
                                <DataItemTemplate>
                                    <dx:ASPxHyperLink ID="ASPxHyperLink1" runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "NombreDocumento")%>' NavigateUrl='<%# DataBinder.Eval(Container.DataItem, "Enlace")%>'>
                                    </dx:ASPxHyperLink>

                                </DataItemTemplate>
                            </dx:GridViewDataTextColumn>

                            <dx:GridViewDataTextColumn FieldName="NombreDocumento" VisibleIndex="3" Visible="false"></dx:GridViewDataTextColumn>
                            <dx:GridViewDataTextColumn FieldName="CreadoPor" VisibleIndex="4" Visible="false"></dx:GridViewDataTextColumn>
                            <dx:GridViewDataDateColumn FieldName="FechaCreacion" VisibleIndex="5" Visible="false"></dx:GridViewDataDateColumn>
                            <dx:GridViewDataTextColumn FieldName="ActualizadoPor" VisibleIndex="6" Visible="false"></dx:GridViewDataTextColumn>
                            <dx:GridViewDataDateColumn FieldName="FechaActualizacion" VisibleIndex="7" Visible="false"></dx:GridViewDataDateColumn>
                            <dx:GridViewDataCheckColumn FieldName="Activo" VisibleIndex="8" Visible="false"></dx:GridViewDataCheckColumn>
                            <dx:GridViewCommandColumn VisibleIndex="10" HeaderStyle-HorizontalAlign="Center" Caption="Acción" CellStyle-HorizontalAlign="NotSet">

                                <DeleteButton Visible="true"></DeleteButton>
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











        <asp:SqlDataSource runat="server" ID="SqlDataSourceDetalleDocumentosEvaluacion" ConnectionString='<%$ ConnectionStrings:SUEPPSConnectionString %>' OnInserted="SqlDataSourceDetalleDocumentosEvaluacion_Inserted" 
            SelectCommand="SELECT * FROM [DetalleDocumentosEvaluacion] WHERE IdDocumentoEvaluacion = @IdDocumentoEvaluacion AND [Activo]=1"
            DeleteCommand="UPDATE [DetalleDocumentosEvaluacion] SET [Activo] = 0 WHERE IdDocumentoEvaluacion = @IdDocumentoEvaluacion ">
            <SelectParameters>
                <asp:SessionParameter Name="IdDocumentoEvaluacion" />
            </SelectParameters>
            <DeleteParameters>
                <asp:SessionParameter Name="IdDocumentoEvaluacion" />
            </DeleteParameters>
        </asp:SqlDataSource>
        <asp:SqlDataSource runat="server" ID="SqlDataSourceDocumentosEvaluacion" ConnectionString='<%$ ConnectionStrings:SUEPPSConnectionString %>'
            SelectCommand="SELECT * FROM [DocumentosEvaluacion] WHERE IdPrograma = @IdPrograma and Activo = 1"
            InsertCommand="INSERT INTO [DocumentosEvaluacion] (IdPrograma, DescripcionDocumento, PalabrasClave, FechaDocumento, CreadoPor, FechaCreacion) VALUES (@IdPrograma, @DescripcionDocumento, @PalabrasClave, @FechaDocumento, 'suepps', getDate())">
            <SelectParameters>
                <asp:SessionParameter Name="IdPrograma" />
            </SelectParameters>
            <InsertParameters>
                <asp:SessionParameter Name="IdPrograma" />
                <asp:FormParameter Name="DescripcionDocumento" />
                <asp:FormParameter Name="PalabrasClave" />
                <asp:FormParameter Name="FechaDocumento" />
            </InsertParameters>
        </asp:SqlDataSource>


    </div>
</asp:Content>
