<%@ Page Title="Levantamientos de Instrumentos de Evaluación" Language="VB" AutoEventWireup="false" CodeFile="AplicacionInstrumento.aspx.vb" Inherits="Cuantitativo_AplicacionInstrumento" MasterPageFile="~/Site.master" %>

<%@ Register Assembly="DevExpress.Web.v13.2, Version=13.2.9.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web.ASPxGridView" TagPrefix="dx" %>

<%@ Register assembly="DevExpress.Web.v13.2, Version=13.2.9.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" namespace="DevExpress.Web.ASPxEditors" tagprefix="dx" %>

<%@ Register Src="~/MOCA_UE.ascx" TagPrefix="uc1" TagName="MOCA_UE" %>

<asp:Content ID="cHeader" ContentPlaceHolderID="HeadContent" Runat="Server">
</asp:Content>
<asp:Content ID="cBody" ContentPlaceHolderID="MainContent" Runat="Server">
    <uc1:MOCA_UE runat="server" ID="MOCA_UE01" />
    <div>
        <div>
            <table>
                <colgroup>
                    <col span="1" style="width: 60%;" />
                    <col span="1" style="width: 40%;" />
                </colgroup>

                <tr>
                    <td><dx:ASPxLabel ID="ASPxLabelTitulo" runat="server" Font-Size="Large" /></td>
                    <td>
                        <dx:ASPxLabel ID="espacio" runat="server" Text=" " Width="50"></dx:ASPxLabel>
                        <dx:ASPxHyperLink ID="ASPxHyperLinkRegresar" runat="server" Text="Regresar a Instrumento" NavigateUrl="InstrumentosEvaluacion.aspx" />

                    </td>
                </tr>
            </table>
        </div>
        <dx:ASPxGridView ID="GridAplicacion" runat="server" AutoGenerateColumns="False" DataSourceID="SqlAplicacion" KeyFieldName="IdAplicacionInstrumento">
            <Columns>
                <dx:GridViewDataTextColumn FieldName="IdAplicacionInstrumento" ReadOnly="True" VisibleIndex="4" Visible="true" Caption="Código de Digitación">
                    <EditFormSettings Visible="False" />
                </dx:GridViewDataTextColumn>

                <dx:GridViewDataComboBoxColumn VisibleIndex="1" FieldName="IdMomentoAplicacion" 
                    Caption="Momento de Aplicación">
                    <EditFormSettings ColumnSpan="2" />
                        <PropertiesComboBox ValueType="System.String" 
                
                            DataSourceID="SqlMomento" 
                            ValueField="IdMomentoDeAplicacion" 
                            TextField="DescripcionMomento"/>
                         <Settings AllowAutoFilter="True" />
                                    <Settings AutoFilterCondition="Contains" />
                                    <Settings FilterMode="DisplayText" />     
                  </dx:GridViewDataComboBoxColumn>

                <dx:GridViewDataTextColumn FieldName="IdInstrumentoDeEvaluacion" VisibleIndex="2" Visible="false">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataDateColumn FieldName="FechaAplicacion" VisibleIndex="3" Caption="Fecha de Aplicación">
                </dx:GridViewDataDateColumn>

                <dx:GridViewDataCheckColumn FieldName="UsaFSU" VisibleIndex="5" Caption="Usa FSU">
                                    <PropertiesCheckEdit>
                                        <ClientSideEvents Init="function(s, e){s.SetChecked(false);}" />
                                    </PropertiesCheckEdit>

                </dx:GridViewDataCheckColumn>
                <dx:GridViewDataTextColumn FieldName="CreadoPor" VisibleIndex="6" Visible="false">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataDateColumn FieldName="FechaCreacion" VisibleIndex="7" Visible="false">
                </dx:GridViewDataDateColumn>
                <dx:GridViewDataTextColumn FieldName="ActualizadoPor" VisibleIndex="8" Visible="false">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataDateColumn FieldName="FechaActualizacion" VisibleIndex="9" Visible="false">
                </dx:GridViewDataDateColumn>
                <dx:GridViewDataCheckColumn FieldName="Activo" VisibleIndex="10" Visible="false">
                </dx:GridViewDataCheckColumn>
                <dx:GridViewCommandColumn VisibleIndex="11" HeaderStyle-HorizontalAlign="Center" Caption="Acción" CellStyle-HorizontalAlign="NotSet">

                                            <NewButton Visible="True" />
                                            <EditButton Visible="true" />
                                            <DeleteButton Visible="true" />

                                        </dx:GridViewCommandColumn>
                <dx:GridViewDataTextColumn VisibleIndex="12" Caption="Análisis Cualitativo" UnboundType="String">
                                      <DataItemTemplate>
                                          <asp:LinkButton id="link2"  Text="Análisis Cualitativo" runat="server" OnClick="link2_Click" /> 
                                      </DataItemTemplate>  
                                        <Settings AllowAutoFilter="False" />
                                        <EditFormSettings Visible="False" />
                 </dx:GridViewDataTextColumn>

                
            </Columns>

            <SettingsBehavior AllowFocusedRow="True" />

             <SettingsPager>
                 <AllButton Visible="True" Text="Todos">
                 </AllButton>
             </SettingsPager>

        </dx:ASPxGridView>


        <asp:SqlDataSource ID="SqlAplicacion" runat="server" ConnectionString="<%$ ConnectionStrings:SUEPPSConnectionString %>" 
            
            
            SelectCommand="SELECT * FROM [AplicacionInstrumento] where [IdInstrumentoDeEvaluacion]=@IdInstrumentoDeEvaluacion and [Activo]=1"
            InsertCommand="INSERT INTO [AplicacionInstrumento] ([IdMomentoAplicacion],[IdInstrumentoDeEvaluacion],[FechaAplicacion],[UsaFSU],[CreadoPor],[FechaCreacion],[Activo]) VALUES (@IdMomentoAplicacion,@IdInstrumentoDeEvaluacion,@FechaAplicacion,@UsaFSU,@Usuario, getDate(), 1)"
            UpdateCommand="UPDATE [AplicacionInstrumento] SET [IdMomentoAplicacion]=@IdMomentoAplicacion,[FechaAplicacion]=@FechaAplicacion,[UsaFSU]=@UsaFSU, [ActualizadoPor]=@Usuario, [FechaActualizacion]=getDate() WHERE [IdAplicacionInstrumento] = @IdAplicacionInstrumento"
            DeleteCommand="UPDATE [AplicacionInstrumento] SET [Activo]=0 WHERE [IdAplicacionInstrumento] = @IdAplicacionInstrumento"
                  
            >

             <SelectParameters>
                     <asp:SessionParameter Name="IdInstrumentoDeEvaluacion" />
                     
                </SelectParameters>

            <InsertParameters>

                <asp:FormParameter Name="IdMomentoAplicacion" />
                <asp:SessionParameter Name="IdInstrumentoDeEvaluacion" />
                <asp:FormParameter Name="FechaAplicacion" />
                <asp:FormParameter Name="UsaFSU" />
                <asp:SessionParameter Name="Usuario" />

            </InsertParameters>

            <UpdateParameters>
                <asp:FormParameter Name="IdMomentoAplicacion" />
                <asp:FormParameter Name="FechaAplicacion" />
                <asp:FormParameter Name="UsaFSU" />
                <asp:FormParameter Name="IdAplicacionInstrumento" />
                <asp:SessionParameter Name="Usuario" />
               

            </UpdateParameters>

            <DeleteParameters>
                <asp:FormParameter Name="IdAplicacionInstrumento" />
            </DeleteParameters>

        </asp:SqlDataSource>

        <asp:SqlDataSource ID="SqlMomento" runat="server" ConnectionString="<%$ ConnectionStrings:SUEPPSConnectionString %>" SelectCommand="SELECT * FROM [MomentosDeAplicacion] where [Activo]=1"> </asp:SqlDataSource>


    </div>
</asp:Content>
