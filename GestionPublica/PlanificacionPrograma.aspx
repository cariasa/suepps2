<%@ Page Title="Planificación Programa" Language="VB" MasterPageFile="~/Site.master" AutoEventWireup="false" CodeFile="PlanificacionPrograma.aspx.vb" Inherits="GestionPublica_PlanificacionPrograma" %>

<%@ Register Src="~/MOCA_UE.ascx" TagPrefix="uc1" TagName="MOCA_UE" %>


<asp:Content ID="cHeader" ContentPlaceHolderID="HeadContent" Runat="Server">
</asp:Content>
<asp:Content ID="cBody" ContentPlaceHolderID="MainContent" Runat="Server">
    <uc1:MOCA_UE runat="server" ID="MOCA_UE01" />
                            <table>

                              <tr>
                             <td>
                             <dx:ASPxLabel runat="server" Text="Políticas:" ID="Políticas" AssociatedControlID="comboPolitica" />
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
                    
                            
                             <asp:SqlDataSource ID="SqlPolitica1" runat="server" ConnectionString="<%$ ConnectionStrings:SUEPPSConnectionString %>" 
                             SelectCommand="Select distinct([Politica]),IdPolitica from vProyectos " ></asp:SqlDataSource>
                                    


                            <div>
                                <p></p>

                            

                            </div>


                            <dx:ASPxGridView ID="GridPrograma" runat="server" ClientInstanceName="GridPrograma" OnLoad="GridPrograma_Load"  AutoGenerateColumns="False" DataSourceID="SqlPrograma"  OnCustomCallback="GridPrograma_CustomCallback" KeyFieldName="codigo_ficha" Width="100%" 
                            
                            Settings-ShowFilterRow="true" Settings-ShowFilterRowMenu="true">

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
                                    <dx:GridViewDataTextColumn FieldName="Acción" ShowInCustomizationForm="True" VisibleIndex="4" Caption="Acción" UnboundType="String">
                                      <DataItemTemplate>
                                          <asp:LinkButton id="link1"  Text="Planificar" runat="server" OnClick="send" /> 
                                          <asp:LinkButton id="LinkButton1"  Text="Asociar Usuario" runat="server" OnClick="LinkButton1_Click" /> 
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

                            <asp:SqlDataSource ID="SqlPrograma" runat="server" ConnectionString="<%$ ConnectionStrings:SUEPPSConnectionString %>" 
                                 >
                                 
                            
                            </asp:SqlDataSource>

</asp:Content>

