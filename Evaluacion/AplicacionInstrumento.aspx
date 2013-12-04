<%@ Page Language="VB" AutoEventWireup="false" CodeFile="AplicacionInstrumento.aspx.vb" Inherits="Cuantitativo_AplicacionInstrumento" %>

<%@ Register Assembly="DevExpress.Web.v13.1, Version=13.1.8.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web.ASPxGridView" TagPrefix="dx" %>

<%@ Register assembly="DevExpress.Web.v13.1, Version=13.1.8.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" namespace="DevExpress.Web.ASPxEditors" tagprefix="dx" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title></title>
</head>
<body>
    <form id="form1" runat="server"  onload="form1_Load">
    <div>

        <dx:ASPxGridView ID="ASPxGridView1" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSource1" KeyFieldName="IdAplicacionInstrumento">
            <Columns>
                <dx:GridViewDataTextColumn FieldName="IdAplicacionInstrumento" ReadOnly="True" VisibleIndex="4" Visible="true" Caption="CodigoDeDigitacion">
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
                
            </Columns>
        </dx:ASPxGridView>


        <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:SUEPPSConnectionString %>" 
            
            
            SelectCommand="SELECT * FROM [AplicacionInstrumento] where [IdInstrumentoDeEvaluacion]=@IdInstrumentoDeEvaluacion and [Activo]=1"
            InsertCommand="INSERT INTO [AplicacionInstrumento] ([IdMomentoAplicacion],[IdInstrumentoDeEvaluacion],[FechaAplicacion],[UsaFSU],[CreadoPor],[FechaCreacion],[Activo]) VALUES (@IdMomentoAplicacion,@IdInstrumentoDeEvaluacion,@FechaAplicacion,@UsaFSU,'PACO', getDate(), 1)"
            UpdateCommand="UPDATE [AplicacionInstrumento] SET [IdMomentoAplicacion]=@IdMomentoAplicacion,[FechaAplicacion]=@FechaAplicacion,[UsaFSU]=@UsaFSU, [ActualizadoPor]='PACO', [FechaActualizacion]=getDate() WHERE [IdAplicacionInstrumento] = @IdAplicacionInstrumento"
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

            </InsertParameters>

            <UpdateParameters>
                <asp:FormParameter Name="IdMomentoAplicacion" />
                <asp:FormParameter Name="FechaAplicacion" />
                <asp:FormParameter Name="UsaFSU" />
                <asp:FormParameter Name="IdAplicacionInstrumento" />
               

            </UpdateParameters>

            <DeleteParameters>
                <asp:FormParameter Name="IdAplicacionInstrumento" />
            </DeleteParameters>

        </asp:SqlDataSource>

        <asp:SqlDataSource ID="SqlMomento" runat="server" ConnectionString="<%$ ConnectionStrings:SUEPPSConnectionString %>" SelectCommand="SELECT * FROM [MomentosDeAplicacion] where [Activo]=1"> </asp:SqlDataSource>


    </div>
    </form>
</body>
</html>
