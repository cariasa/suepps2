<%@ Page Language="VB" AutoEventWireup="false" CodeFile="InstrumentosEvaluacion.aspx.vb" Inherits="Cuantitativo_InstrumentosEvaluacion" %>

<%@ Register Assembly="DevExpress.Web.v13.1, Version=13.1.8.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web.ASPxGridView" TagPrefix="dx" %>

<%@ Register assembly="DevExpress.Web.v13.1, Version=13.1.8.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" namespace="DevExpress.Web.ASPxEditors" tagprefix="dx" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title></title>
</head>
<body>
    <form id="form1" runat="server" onload="form1_Load">
    <div>

        <div>

        <dx:ASPxLabel runat="server" Text=" " ID="Programa" />

        </div>
        
        <br />

        <dx:ASPxGridView ID="ASPxGridView1" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSource1" KeyFieldName="IdInstrumentoDeEvaluacion">
            <Columns>
                <dx:GridViewDataTextColumn FieldName="IdInstrumentoDeEvaluacion" ReadOnly="True" VisibleIndex="0" Visible="false">
                    <EditFormSettings Visible="False" />
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="IdPrograma" VisibleIndex="1" Visible="false">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="NombreInstrumento" Caption="Nombre" VisibleIndex="2">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="DescripcionInstrumento" Caption="Descripción" VisibleIndex="3">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Ano" Caption="Año" VisibleIndex="4">
                </dx:GridViewDataTextColumn>
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
                    Caption="Crear Levantamiento" UnboundType="String">
                                      <DataItemTemplate>
                                          <asp:LinkButton id="link2"  Text="Crear Levantamiento" runat="server" OnClick="link2_Click" /> 
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

      

        <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:SUEPPSConnectionString %>" >

             <SelectParameters>
                     <asp:SessionParameter Name="IdPrograma" />
                     
                </SelectParameters>

            <InsertParameters>
                <asp:SessionParameter Name="IdPrograma" />
                <asp:FormParameter Name="NombreInstrumento" />
                <asp:FormParameter Name="DescripcionInstrumento" />
                <asp:FormParameter Name="Ano" />
            </InsertParameters>

            <UpdateParameters>
                <asp:FormParameter Name="IdInstrumentoDeEvaluacion" />
                <asp:FormParameter Name="NombreInstrumento" />
                <asp:FormParameter Name="DescripcionInstrumento" />
                <asp:FormParameter Name="Ano" />
            </UpdateParameters>

            <DeleteParameters>
                <asp:FormParameter Name="IdInstrumentoDeEvaluacion" />
            </DeleteParameters>



        </asp:SqlDataSource>

       


    </div>
    </form>
</body>
</html>
