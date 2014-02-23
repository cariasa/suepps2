<%@ Page Title="Selección de Programa" Language="VB" AutoEventWireup="false" CodeFile="Instrumentos.aspx.vb" Inherits="Cuantitativo_Default" MasterPageFile="~/Site.master" %>

<%@ Register Assembly="DevExpress.Web.v13.2, Version=13.2.6.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web.ASPxGridView" TagPrefix="dx" %>

<%@ Register Assembly="DevExpress.Web.v13.2, Version=13.2.6.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web.ASPxEditors" TagPrefix="dx" %>

<%@ Register Src="~/MOCA_UE.ascx" TagPrefix="uc1" TagName="MOCA_UE" %>

<asp:Content ID="cHeader" ContentPlaceHolderID="HeadContent" Runat="Server">
</asp:Content>
<asp:Content ID="cBody" ContentPlaceHolderID="MainContent" Runat="Server">
    <uc1:MOCA_UE runat="server" ID="MOCA_UE01" />

    <div>
        <div>
            <table>
                <tr>
                    <td><dx:ASPxLabel ID="ASPxLabelTitulo" runat="server" Text="Selección de Programa para Instrumentos de Evaluación" Font-Size="Large" /></td>
                </tr>
            </table>
        </div>

        <dx:ASPxGridView ID="GridPolitica" runat="server" AutoGenerateColumns="False" DataSourceID="SqlPolitica" KeyFieldName="IdPolitica" SettingsDetail-ShowDetailRow="true" Settings-ShowFilterRow="true">
            <Columns>
                <dx:GridViewDataTextColumn FieldName="IdPolitica" ReadOnly="True" VisibleIndex="0" Visible="false">
                    <EditFormSettings Visible="False" />

                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Nombre" Caption="Política" VisibleIndex="1">
                    <Settings AllowAutoFilter="True" />
                                                    <Settings AutoFilterCondition="Contains" />
                                                    <Settings FilterMode="DisplayText" />
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="SujetosDeAtencion" Caption="Sujetos de Atención" VisibleIndex="2">
                    <Settings AllowAutoFilter="True" />
                                                    <Settings AutoFilterCondition="Contains" />
                                                    <Settings FilterMode="DisplayText" />
                </dx:GridViewDataTextColumn>
            </Columns>
             <SettingsBehavior AllowFocusedRow="True" />

             <SettingsPager>
                 <AllButton Visible="True" Text="Todos">
                 </AllButton>
             </SettingsPager>


             <SettingsDetail ShowDetailRow="True" />
                        <Templates>
                        <DetailRow>

                            <dx:ASPxGridView ID="GridPrograma" runat="server" KeyFieldName="codigo_ficha" IsDetailGrid="true" OnBeforePerformDataSelect="ASPxGridView2_BeforePerformDataSelect" Width="100%" DataSourceID="SqlPrograma" Settings-ShowFilterRow="true" >
                                <Columns>

                                     <dx:GridViewDataTextColumn FieldName="codigo_ficha" ReadOnly="True" VisibleIndex="0" Visible="false">
                                        <EditFormSettings Visible="False" />
                                     </dx:GridViewDataTextColumn>
                                    <dx:GridViewDataTextColumn FieldName="NombreProyecto" Caption="Programa" VisibleIndex="1">
                                        <Settings AllowAutoFilter="True" />
                                                    <Settings AutoFilterCondition="Contains" />
                                                    <Settings FilterMode="Value" />
                                    </dx:GridViewDataTextColumn>
                                     <dx:GridViewDataTextColumn FieldName="codigo_proyecto" Caption="Código del Programa" VisibleIndex="1" >
                                          <Settings AllowAutoFilter="False" />
                                    </dx:GridViewDataTextColumn>

                                    

                                    <dx:GridViewDataTextColumn VisibleIndex="2" Caption="Acción" UnboundType="String">
                                      <DataItemTemplate>
                                          <asp:LinkButton id="link1"  Text="Instrumentos" runat="server" OnClick="link1_Click" /> 
                                          <asp:LinkButton id="LinkButton1"  Text="Asociar Indicador" runat="server" OnClick="LinkButton1_Click" /> 
                                          <asp:LinkButton id="AsociarDocumento" Text="Documentos" runat="server" OnClick="Documento_Click" />
                                      </DataItemTemplate>  
                                        <Settings AllowAutoFilter="False" />
                                        <EditFormSettings Visible="False" />
                                       </dx:GridViewDataTextColumn>


                                </Columns>

                                <SettingsPager>
                <AllButton Visible="True" Text="Todos">
                </AllButton>
            </SettingsPager>

        <SettingsBehavior AllowFocusedRow="True" />


                            </dx:ASPxGridView>




                         </DetailRow>
                        </Templates>
            

        </dx:ASPxGridView>

 
        <asp:SqlDataSource ID="SqlPolitica" runat="server" ConnectionString="<%$ ConnectionStrings:SUEPPSConnectionString %>" 
            SelectCommand="SELECT * FROM [Politicas] where [Activo]=1 ">

        </asp:SqlDataSource>

        <asp:SqlDataSource ID="SqlPrograma" runat="server" ConnectionString="<%$ ConnectionStrings:SUEPPSConnectionString %>" >

            <SelectParameters>
                     <asp:SessionParameter Name="IdPolitica" />
                     
                </SelectParameters>

        </asp:SqlDataSource>

    </div>

   </asp:Content>
