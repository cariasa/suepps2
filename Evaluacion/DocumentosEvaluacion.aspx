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
                                                <td>
                                                    Nombre Documento
                                                </td>
                                                <td>
                                                    <dx:ASPxTextBox ID="TxtNombre" runat="server"/>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    Descripción
                                                </td>
                                                <td>
                                                    <dx:ASPxTextBox ID="TxtDescripcion" runat="server"/>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    Palabras Clave
                                                </td>
                                                <td>
                                                    <dx:ASPxTextBox ID="TxtPalabras" runat="server"/>
                                                </td>
                                            </tr>
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
    </div>
    <div>

        <dx:ASPxGridView ID="GridDocumentos" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSourceDocumentos" KeyFieldName="IdDocumentoEvaluacion">
            <Columns>
                
                <dx:GridViewDataTextColumn FieldName="IdDocumentoEvaluacion" ReadOnly="True" VisibleIndex="1" Visible="false">
                    <EditFormSettings Visible="False" />
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="IdPrograma" VisibleIndex="2" Visible="false">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Enlace" VisibleIndex="3">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Direccion" VisibleIndex="4" Visible="false">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="NombreDocumento" VisibleIndex="5">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="DescripcionDocumento" VisibleIndex="6">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="PalabrasClave" VisibleIndex="7">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="CreadoPor" VisibleIndex="8" Visible="false">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataDateColumn FieldName="FechaCreacion" VisibleIndex="9" Visible="false">
                </dx:GridViewDataDateColumn>
                <dx:GridViewDataTextColumn FieldName="ActualizadoPor" VisibleIndex="10" Visible="false">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataDateColumn FieldName="FechaActualizacion" VisibleIndex="11" Visible="false">
                </dx:GridViewDataDateColumn>
                <dx:GridViewDataCheckColumn FieldName="Activo" VisibleIndex="12" Visible="false">
                </dx:GridViewDataCheckColumn>
                <dx:GridViewCommandColumn VisibleIndex="13" Caption="Acción">
                    <EditButton Visible="True">
                    </EditButton>
                    <DeleteButton Visible="True">
                    </DeleteButton>
                    <ClearFilterButton Visible="True">
                    </ClearFilterButton>
                </dx:GridViewCommandColumn>
            </Columns>
            <Settings ShowFilterRow="True" />
        </dx:ASPxGridView>
        <asp:SqlDataSource ID="SqlDataSourceDocumentos" runat="server" ConnectionString="<%$ ConnectionStrings:SUEPPSConnectionString %>" 
            SelectCommand="SELECT [IdDocumentoEvaluacion], [IdPrograma], [Enlace], [Direccion], [NombreDocumento], [DescripcionDocumento], [PalabrasClave], [CreadoPor], [FechaCreacion], [ActualizadoPor], [FechaActualizacion], [Activo] FROM [DocumentosEvaluacion] WHERE [Activo]=1"
            InsertCommand="INSERT INTO [DocumentosEvaluacion] ([IdPrograma], [Enlace], [Direccion], [NombreDocumento], [DescripcionDocumento], [PalabrasClave], [CreadoPor]) VALUES (@IdPrograma, @Enlace, @Direccion, @NombreDocumento, @DescripcionDocumento, @PalabrasClave, @CreadoPor)"
            UpdateCommand="UPDATE [DocumentosEvaluacion] SET ([NombreDocumento]=@NombreDocumento, [DescripcionDocumento]=@DescripcionDocumento, [PalabrasClave]=@PalabrasClave)">
            
        </asp:SqlDataSource>

    </div>
</asp:Content>
