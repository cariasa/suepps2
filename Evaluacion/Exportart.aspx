<%@ Page Language="VB" AutoEventWireup="false" CodeFile="Exportart.aspx.vb" Inherits="Evaluacion_Exportart" MasterPageFile="~/Site.master"%>

<%@ Register Src="~/MOCA_UE.ascx" TagPrefix="uc1" TagName="MOCA_UE" %>

<asp:Content ID="cHeader" ContentPlaceHolderID="HeadContent" runat="Server">
</asp:Content>
<asp:Content ID="cBody" ContentPlaceHolderID="MainContent" runat="Server">
    <uc1:MOCA_UE runat="server" ID="MOCA_UE01" />
    <div>

        <dx:ASPxButton ID="ASPxButtonExportarPreguntas" runat="server" Text="Exportar" OnClick="ASPxButtonExportarPreguntas_Click"></dx:ASPxButton>
        <dx:ASPxGridViewExporter ID="exporter" runat="server" />
        <dx:ASPxGridView ID="ASPxGridViewPreguntas" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSourcePreguntas" KeyFieldName="IdPreguntaDeMonitoreo">
            <Columns>
                <dx:GridViewDataTextColumn FieldName="IdPreguntaDeMonitoreo" ReadOnly="True" VisibleIndex="0" Caption="ID">
                    <EditFormSettings Visible="False"></EditFormSettings>
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="DescripcionPreguntaDeMonitoreo" VisibleIndex="1"></dx:GridViewDataTextColumn>
            </Columns>
            <SettingsPager>
                  <AllButton Visible="True" Text="Todos">
                  </AllButton>
            </SettingsPager>
            <SettingsDetail ShowDetailRow="true" ShowDetailButtons="true" />
            <Templates>
                <DetailRow>
                    <dx:ASPxGridView ID="ASPxGridViewOpcionesDePregunta" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSourceOpcionesDePregunta" KeyFieldName="IdOpcionDePregunta" OnBeforePerformDataSelect="ASPxGridViewOpcionesDePregunta_BeforePerformDataSelect">
                        <Columns>
                            <dx:GridViewDataTextColumn FieldName="IdOpcionDePregunta" ReadOnly="True" VisibleIndex="0" Caption="ID">
                                <EditFormSettings Visible="False"></EditFormSettings>
                            </dx:GridViewDataTextColumn>
                            <dx:GridViewDataTextColumn FieldName="IdPreguntaDeMonitoreo" VisibleIndex="1" Visible="false"></dx:GridViewDataTextColumn>
                            <dx:GridViewDataTextColumn FieldName="DescripcionOpcionDePregunta" VisibleIndex="2"></dx:GridViewDataTextColumn>
                        </Columns>
                    </dx:ASPxGridView>
                    <asp:SqlDataSource runat="server" ID="SqlDataSourceOpcionesDePregunta" ConnectionString='<%$ ConnectionStrings:SUEPPSConnectionString %>' 
                        SelectCommand="SELECT [IdOpcionDePregunta], [IdPreguntaDeMonitoreo], [DescripcionOpcionDePregunta] FROM [OpcionesDePregunta] WHERE [IdPreguntaDeMonitoreo]=@IdPreguntaDeMonitoreo">
                        <SelectParameters>
                            <asp:SessionParameter SessionField="IdPreguntaDeMonitoreo" Name="IdPreguntaDeMonitoreo" Type="Int32" />
                        </SelectParameters>
                    </asp:SqlDataSource>
                </DetailRow>
            </Templates>
        </dx:ASPxGridView>

        




        
        <asp:SqlDataSource runat="server" ID="SqlDataSourcePreguntas" ConnectionString='<%$ ConnectionStrings:SUEPPSConnectionString %>' 
            SelectCommand="SELECT [IdPreguntaDeMonitoreo], [DescripcionPreguntaDeMonitoreo] FROM [PreguntasDeMonitoreo]">
            
        </asp:SqlDataSource>
    </div>
 </asp:Content>
