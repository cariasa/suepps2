<%@ Page Title="Instrumentos de Evaluación" Language="VB" AutoEventWireup="false" CodeFile="InstrumentosEvaluacion.aspx.vb" Inherits="Cuantitativo_InstrumentosEvaluacion" MasterPageFile="~/Site.master" %>

<%@ Register Assembly="DevExpress.Web.v13.2, Version=13.2.7.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web.ASPxGridView" TagPrefix="dx" %>

<%@ Register assembly="DevExpress.Web.v13.2, Version=13.2.7.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" namespace="DevExpress.Web.ASPxEditors" tagprefix="dx" %>



<%@ Register Src="~/MOCA_UE.ascx" TagPrefix="uc1" TagName="MOCA_UE" %>

<asp:Content ID="cHeader" ContentPlaceHolderID="HeadContent" Runat="Server">
</asp:Content>
<asp:Content ID="cBody" ContentPlaceHolderID="MainContent" Runat="Server">
    <uc1:MOCA_UE runat="server" ID="MOCA_UE01" />


    <div>

        <div>
            <table>
                <tr>
                    <td><dx:ASPxLabel runat="server" Text=" " ID="ASPxLabelTitulo" Font-Size="Large" /></td>
                    <td>
                        <dx:ASPxLabel ID="espacio" runat="server" Text=" " Width="50"></dx:ASPxLabel>
                        <dx:ASPxHyperLink ID="ASPxHyperLinkRegresar" runat="server" Text="Regresar a Selección" NavigateUrl="Instrumentos.aspx" />

                    </td>
                </tr>
            </table>
        

        </div>
        
        <br />

        <dx:ASPxGridView ID="GridInstrumentos" runat="server" AutoGenerateColumns="False" DataSourceID="SqlInstrumento" KeyFieldName="IdInstrumentoDeEvaluacion">
            <Columns>
                <dx:GridViewDataTextColumn FieldName="IdInstrumentoDeEvaluacion" ReadOnly="True" VisibleIndex="0" Visible="false">
                    <EditFormSettings Visible="False" />
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="IdPrograma" VisibleIndex="1" Visible="false">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="NombreInstrumento" Caption="Nombre" VisibleIndex="2">
                    <EditFormSettings ColumnSpan="2" />
                </dx:GridViewDataTextColumn>
                
                <dx:GridViewDataTextColumn FieldName="DescripcionInstrumento" Caption="Descripción" VisibleIndex="3">
                <EditFormSettings ColumnSpan="2" />
                </dx:GridViewDataTextColumn>

                <dx:GridViewDataComboBoxColumn VisibleIndex="4" FieldName="IdTipoDeInstrumento" 
                    Caption="Tipo de Instrumento">
                    <EditFormSettings ColumnSpan="1" />
                        <PropertiesComboBox ValueType="System.String" 
                
                            DataSourceID="SqlTipoInstrumento" 
                            ValueField="IdTipoDeInstrumento" 
                            TextField="TipoDeInstrumento"/>
                         <Settings AllowAutoFilter="True" />
                                    <Settings AutoFilterCondition="Contains" />
                                    <Settings FilterMode="DisplayText" />     
                  </dx:GridViewDataComboBoxColumn>


                <dx:GridViewDataTextColumn FieldName="Ano" Caption="Año" VisibleIndex="5">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataComboBoxColumn VisibleIndex="6" FieldName="IdProcesoEvaluacion" 
                    Caption="Proceso">
                    <EditFormSettings ColumnSpan="2" />
                        <PropertiesComboBox ValueType="System.String" 
                
                            DataSourceID="SqlProceso" 
                            ValueField="IdProcesoEvaluacion" 
                            TextField="ProcesoEvaluacion"/>
                         <Settings AllowAutoFilter="True" />
                                    <Settings AutoFilterCondition="Contains" />
                                    <Settings FilterMode="DisplayText" />     
                  </dx:GridViewDataComboBoxColumn>

                <dx:GridViewDataTextColumn FieldName="CreadoPor" VisibleIndex="5" Visible="false">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataDateColumn FieldName="FechaCreacion" VisibleIndex="6" Visible="false">
                </dx:GridViewDataDateColumn>
                <dx:GridViewDataTextColumn FieldName="ActualizadoPor" VisibleIndex="7" Visible="false">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataDateColumn FieldName="FechaActualizacion" VisibleIndex="8" Visible="false">
                </dx:GridViewDataDateColumn>
                <dx:GridViewDataCheckColumn FieldName="Activo" VisibleIndex="9" Visible="false">
                </dx:GridViewDataCheckColumn>
                <dx:GridViewCommandColumn VisibleIndex="10" HeaderStyle-HorizontalAlign="Center" Caption="Acción" CellStyle-HorizontalAlign="NotSet">
                    
                    <NewButton Visible="True">
                    </NewButton>
                    <EditButton Visible="True">
                    </EditButton>
                    <DeleteButton Visible="True">
                    </DeleteButton>
                    <HeaderStyle HorizontalAlign="Center"></HeaderStyle>
                </dx:GridViewCommandColumn>

                <dx:GridViewDataTextColumn VisibleIndex="11" 
                    Caption="Planificar Preguntas" UnboundType="String">
                                      <DataItemTemplate>
                                          <asp:LinkButton id="link1"  Text="Agregar Preguntas" runat="server" OnClick="link1_Click" /> 
                                      </DataItemTemplate>  
                                        <Settings AllowAutoFilter="False" />
                                        <EditFormSettings Visible="False" />
                 </dx:GridViewDataTextColumn>

                <dx:GridViewDataTextColumn VisibleIndex="12" 
                    Caption="Levantamientos" UnboundType="String">
                                      <DataItemTemplate>
                                          <asp:LinkButton id="link2"  Text="Levantamientos" runat="server" OnClick="link2_Click" /> 
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

      

        <asp:SqlDataSource ID="SqlInstrumento" runat="server" ConnectionString="<%$ ConnectionStrings:SUEPPSConnectionString %>" >

             <SelectParameters>
                     <asp:SessionParameter Name="IdPrograma" />
                     
                </SelectParameters>

            <InsertParameters>
                <asp:SessionParameter Name="IdPrograma" />
                <asp:FormParameter Name="NombreInstrumento" />
                <asp:FormParameter Name="DescripcionInstrumento" />
                <asp:FormParameter Name="Ano" />
                <asp:FormParameter Name="IdProcesoEvaluacion" />
                <asp:SessionParameter Name="Usuario" />
                <asp:FormParameter Name="IdTipoDeInstrumento" />
                <asp:SessionParameter Name="AP" />
                
            </InsertParameters>

            <UpdateParameters>
                <asp:FormParameter Name="IdInstrumentoDeEvaluacion" />
                <asp:FormParameter Name="NombreInstrumento" />
                <asp:FormParameter Name="DescripcionInstrumento" />
                <asp:FormParameter Name="Ano" />
                <asp:FormParameter Name="IdProcesoEvaluacion" />
                <asp:SessionParameter Name="Usuario" />
                <asp:FormParameter Name="IdTipoDeInstrumento" />
                <asp:SessionParameter Name="AP" />
            </UpdateParameters>

            <DeleteParameters>
                <asp:FormParameter Name="IdInstrumentoDeEvaluacion" />
            </DeleteParameters>

        </asp:SqlDataSource>
        
        <asp:SqlDataSource ID="SqlProceso" runat="server" ConnectionString="<%$ ConnectionStrings:SUEPPSConnectionString %>" SelectCommand="SELECT * FROM [ProcesosEvaluacion] Where [Activo]=1"> </asp:SqlDataSource>

        <asp:SqlDataSource ID="SqlTipoInstrumento" runat="server" ConnectionString="<%$ ConnectionStrings:SUEPPSConnectionString %>" SelectCommand="SELECT * FROM [TiposDeInstrumento] Where [Activo]=1"> </asp:SqlDataSource>


    </div>
  
  </asp:Content>
