<%@ Page Title="Revisión Social Integral" Language="VB" AutoEventWireup="false" CodeFile="RevisionSocialIntegral.aspx.vb" Inherits="RevisionSocialIntegral" MasterPageFile="~/Site.master" %>

<%@ Register Assembly="DevExpress.Web.v13.1, Version=13.1.8.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web.ASPxMenu" TagPrefix="dx" %>

<%@ Register Assembly="DevExpress.Web.v13.1, Version=13.1.8.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web.ASPxTabControl" TagPrefix="dx" %>


<%@ Register Assembly="DevExpress.Web.v13.1, Version=13.1.8.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web.ASPxPanel" TagPrefix="dx" %>

<%@ Register Assembly="DevExpress.Web.v13.1, Version=13.1.8.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web.ASPxGridView" TagPrefix="dx" %>

<%@ Register assembly="DevExpress.Web.v13.1, Version=13.1.8.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" namespace="DevExpress.Web.ASPxEditors" tagprefix="dx" %>

<%@ Register Assembly="DevExpress.Web.v13.1, Version=13.1.8.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web.ASPxClasses" TagPrefix="dx" %>

<%@ Register Assembly="DevExpress.Web.v13.1, Version=13.1.8.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web.ASPxPopupControl" TagPrefix="dx" %>

<%@ Register Assembly="DevExpress.Web.v13.1, Version=13.1.8.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web.ASPxObjectContainer" TagPrefix="dx" %>

<%@ Register Assembly="DevExpress.Web.v13.1, Version=13.1.8.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web.ASPxUploadControl" TagPrefix="dx" %>

<%@ Register Src="~/MOCA_UE.ascx" TagPrefix="uc1" TagName="MOCA_UE" %>


<asp:Content ID="cHeader" ContentPlaceHolderID="HeadContent" Runat="Server">
</asp:Content>
<asp:Content ID="cBody" ContentPlaceHolderID="MainContent" Runat="Server">
    <uc1:MOCA_UE runat="server" ID="MOCA_UE01" />
    <div>
         <table>

                              <tr>
                             <td>
                             <dx:ASPxLabel runat="server" Text="Políticas:" ID="Políticas" AssociatedControlID="comboPolitica" />
                             </td>
                             <td>
                             <dx:ASPxComboBox ID="comboPolitica" runat="server" ValueField="Politica"
                               TextField="Politica" ValueType="System.String" DataSourceID="SqlPolitica1"
                                EnableClientSideAPI="true" Height="16px" Width="650px" >

                                 <ClientSideEvents SelectedIndexChanged="function(s, e) { GridPrograma.PerformCallback(s.GetValue()); }">
                                 </ClientSideEvents>
                              </dx:ASPxComboBox>
                             </td>
                             </tr>

                            </table>
                    
                            
                             <asp:SqlDataSource ID="SqlPolitica1" runat="server" ConnectionString="<%$ ConnectionStrings:SUEPPSConnectionString %>" SelectCommand="Select distinct([Politica]),IdPolitica from vProyectos " ></asp:SqlDataSource>
                                    


                            <div>
                                <p></p>

                            

                            </div>

                            <dx:ASPxGridView ID="GridPrograma" runat="server" ClientInstanceName="GridPrograma"  AutoGenerateColumns="False" DataSourceID="SqlPrograma"  OnCustomCallback="GridPrograma_CustomCallback" KeyFieldName="codigo_ficha" Width="100%" Settings-ShowFilterRow="true" OnLoad="GridPrograma_Load" Settings-ShowFilterRowMenu="true">

                                <Columns>
                                    <dx:GridViewDataTextColumn FieldName="codigo_ficha" ShowInCustomizationForm="True" VisibleIndex="0" Caption="Id" Visible="false">
                                    </dx:GridViewDataTextColumn>
                                    <dx:GridViewDataTextColumn FieldName="NombreProyecto" ShowInCustomizationForm="True" VisibleIndex="1" Caption="Nombre">
                                    <Settings AutoFilterCondition="Contains" />
                                    </dx:GridViewDataTextColumn>
                                    <dx:GridViewDataTextColumn FieldName="codigo_proyecto" ShowInCustomizationForm="True" VisibleIndex="2" Caption="Código de Proyecto">
                                    <Settings AutoFilterCondition="Contains" />
                                    </dx:GridViewDataTextColumn>
                                    <dx:GridViewDataTextColumn FieldName="Enfoque" ShowInCustomizationForm="True" VisibleIndex="3"  Visible="false" Caption="Enfoque" UnboundType="String">
                                    </dx:GridViewDataTextColumn>
                                    <dx:GridViewDataTextColumn FieldName="Acciones" ShowInCustomizationForm="True" VisibleIndex="4" Caption="Acción" UnboundType="String">
                                      <DataItemTemplate>
                                          <asp:LinkButton id="link1"  Text="Planificación" runat="server" Visible="true" OnClick="send" /> <br />
                                          <asp:LinkButton id="link2"  Text="Monitoreo Cualitativo" runat="server" Visible="true" OnClick="send2" /><br />
                                          <asp:LinkButton id="link3"  Text="Insumos de Sistematización" runat="server" Visible="true" OnClick="link3_Click" /> 
                                      </DataItemTemplate>
                                        <Settings AllowAutoFilter="False" />
                                    </dx:GridViewDataTextColumn>
                                </Columns>   
                                 <SettingsPager>
                       <AllButton Visible="True" Text="Todos">
                       </AllButton>
                    </SettingsPager>
                               <SettingsBehavior AllowFocusedRow="True" />
                                </dx:ASPxGridView>

                            <asp:SqlDataSource ID="SqlPrograma" runat="server" ConnectionString="<%$ ConnectionStrings:SUEPPSConnectionString %>" >
                                
                            
                            </asp:SqlDataSource>
    </div>
</asp:Content>
