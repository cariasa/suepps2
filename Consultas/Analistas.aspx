<%@ Page Title="Analistas" Language="VB" AutoEventWireup="false" CodeFile="Analistas.aspx.vb" Inherits="Consultas_suepps_analiprograma" MasterPageFile="~/Site.master" %>

<%@ Register Assembly="DevExpress.Web.v13.2, Version=13.2.9.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web.ASPxGridView" TagPrefix="dx" %>

<%@ Register Assembly="DevExpress.Web.v13.2, Version=13.2.9.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web.ASPxEditors" TagPrefix="dx" %>


<%@ Register Src="~/MOCA_UE.ascx" TagPrefix="uc1" TagName="MOCA_UE" %>


<asp:Content ID="cHeader" ContentPlaceHolderID="HeadContent" Runat="Server">
</asp:Content>
<asp:Content ID="cBody" ContentPlaceHolderID="MainContent" Runat="Server">
    <uc1:MOCA_UE runat="server" ID="MOCA_UE01" />
    <div>
    
         <table>

                            <tr>
                             <td>
                             <dx:ASPxLabel runat="server" Text="Politicas:" ID="Politicas" AssociatedControlID="comboPolitica" />
                             </td>
                             <td>
                             <dx:ASPxComboBox ID="comboPolitica" runat="server" ValueField="Politica"
                               TextField="Politica" ValueType="System.String" DataSourceID="SqlPolitica1"
                                EnableClientSideAPI="true" Width="826px" >

                                 <ClientSideEvents SelectedIndexChanged="function(s, e) { GridPrograma.PerformCallback(s.GetValue()); }">
                                 </ClientSideEvents>
                              </dx:ASPxComboBox>
                             </td>
                             </tr>

                            </table>
                    
                            
                             <asp:SqlDataSource ID="SqlPolitica1" runat="server" ConnectionString="<%$ ConnectionStrings:SUEPPSConnectionString %>" SelectCommand="Select distinct([Politica]),IdPolitica from vProyectos " ></asp:SqlDataSource>
                                    


                           <br />
                            <br />

                            <dx:ASPxGridView ID="GridPrograma" runat="server" ClientInstanceName="GridPrograma"  AutoGenerateColumns="False" DataSourceID="SqlPrograma"  OnCustomCallback="GridPrograma_CustomCallback" KeyFieldName="codigo_ficha" Width="100%" Settings-ShowFilterRow="true" OnLoad="GridPrograma_Load" Settings-ShowFilterRowMenu="true">
                                <Columns>
                                    <dx:GridViewDataTextColumn FieldName="codigo_ficha" ShowInCustomizationForm="True" VisibleIndex="0" Caption="Id" Visible="false">
                                    
                                    </dx:GridViewDataTextColumn>
                                    <dx:GridViewDataTextColumn FieldName="NombreProyecto" ShowInCustomizationForm="True" VisibleIndex="1" Caption="Nombre">
                                    <Settings AutoFilterCondition="Contains" />
                                    </dx:GridViewDataTextColumn>
                                    <dx:GridViewDataTextColumn FieldName="codigo_proyecto" ShowInCustomizationForm="True" VisibleIndex="2" Caption="Código Proyecto">
                                    <Settings AutoFilterCondition="Contains" />
                                    </dx:GridViewDataTextColumn>
                                    <dx:GridViewDataTextColumn FieldName="Enfoque" ShowInCustomizationForm="True" VisibleIndex="3" Caption="Enfoque" UnboundType="String" Visible="false">
                                    </dx:GridViewDataTextColumn>
                                    <dx:GridViewDataTextColumn FieldName="Acción" ShowInCustomizationForm="True" VisibleIndex="4" Caption="Acciones" UnboundType="String">
                                      <DataItemTemplate>
                                          <asp:LinkButton id="link1"  Text="Analizar" runat="server" OnClick="send" /> 
                                      </DataItemTemplate> 
                                        <Settings AllowAutoFilter="False" /> 
                                    </dx:GridViewDataTextColumn>
                                </Columns>   
                               <SettingsBehavior AllowFocusedRow="True" />
                                <SettingsPager>
                                    <AllButton Visible="True" Text="Todos">
                                     </AllButton>
                                </SettingsPager>
                                </dx:ASPxGridView>

                            <asp:SqlDataSource ID="SqlPrograma" runat="server" ConnectionString="<%$ ConnectionStrings:SUEPPSConnectionString %>" >
                                
                            
                            </asp:SqlDataSource>


    </div>
</asp:Content>
