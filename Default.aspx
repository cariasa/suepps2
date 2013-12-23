<%@ Page Title ="Sistema Único de Evaluación de Políticas Públicas" Language="VB" AutoEventWireup="false" CodeFile="Default.aspx.vb" Inherits="Buscar"  MasterPageFile="~/Site.Master" %>

<%@ Register Assembly="DevExpress.Web.v13.2, Version=13.2.5.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web.ASPxGridView" TagPrefix="dx" %>

<%@ Register Assembly="DevExpress.Web.v13.2, Version=13.2.5.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web.ASPxEditors" TagPrefix="dx" %>

<%@ Register Src="~/MOCA_UE.ascx" TagPrefix="uc1" TagName="MOCA_UE" %>


<asp:Content ID="cHeader" ContentPlaceHolderID="HeadContent" Runat="Server">
</asp:Content>
<asp:Content ID="cBody" ContentPlaceHolderID="MainContent" Runat="Server">
    <uc1:MOCA_UE runat="server" ID="MOCA_UE01" />
    <div>

        
        
        <table>

            <tr>

                <td>
                    <dx:ASPxLabel ID="lblBusqueda" runat="server" Text="Búsqueda" AssociatedControlID="txtbuscar"></dx:ASPxLabel>
                </td>
                <td>
        <dx:ASPxTextBox ID="txtbuscar" runat="server" Width="400 px"></dx:ASPxTextBox>

        </td>
                <td>

               

         <dx:ASPxButton ID="btbuscar" runat="server" Text="Buscar" OnClick="btbuscar_Click"></dx:ASPxButton>
 </td>
                </tr>
         </table>
        <dx:ASPxLabel ID="lblPoliticas" runat="server" Text="Políticas"></dx:ASPxLabel>

        <dx:ASPxGridView ID="ASPxGridView1" runat="server" AutoGenerateColumns="False" DataSourceID="SqlPolitica" KeyFieldName="IdPolitica">
            <Columns>
                <dx:GridViewDataTextColumn FieldName="IdPolitica" ReadOnly="True" VisibleIndex="0"  Caption="Cod. Politica">
                    <EditFormSettings Visible="False" />
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Nombre" VisibleIndex="1" Caption="Nombre de la Política">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="SujetosDeAtencion" VisibleIndex="4" Caption="Sujetos De Atención">
                </dx:GridViewDataTextColumn>
                
            </Columns>
        </dx:ASPxGridView>

        <dx:ASPxLabel ID="lblProyecto" runat="server" Text="Programas"></dx:ASPxLabel>

        <dx:ASPxGridView ID="ASPxGridView2" runat="server" AutoGenerateColumns="False" DataSourceID="SqlProgramas">
            <Columns>
                <dx:GridViewDataTextColumn FieldName="codigo_ficha" Caption="Cod. Programa" VisibleIndex="0" Visible="false">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="ley" Caption="Ley" VisibleIndex="1">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="NombreProyecto" Caption="Nombre del Programa" VisibleIndex="2">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="decreto"  Caption="Decreto" VisibleIndex="3">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="codigo_proyecto" Caption="Cod.Programa" VisibleIndex="4">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="TotalFinanciamientoML" Caption="Total Financiamiento ML" VisibleIndex="5">
                </dx:GridViewDataTextColumn>
            </Columns>
        </dx:ASPxGridView>


        <dx:ASPxLabel ID="IS" runat="server" Text="Insumos De Sistematización"></dx:ASPxLabel>

        <dx:ASPxGridView ID="ASPxGridView3" runat="server" AutoGenerateColumns="False" DataSourceID="SqlInsumos" KeyFieldName="IdSistematizacionMonitoreo">
            <Columns>
                <dx:GridViewDataTextColumn FieldName="Comentario" VisibleIndex="0">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataDateColumn FieldName="Fecha" VisibleIndex="1">
                </dx:GridViewDataDateColumn>
                <dx:GridViewDataTextColumn FieldName="NombreProyecto" VisibleIndex="2">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Usuario" VisibleIndex="3">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Ano" VisibleIndex="4" Caption="Año">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Periodo" VisibleIndex="5" Caption="Período">
                </dx:GridViewDataTextColumn>
        
            </Columns>
        </dx:ASPxGridView>

       
        <asp:SqlDataSource ID="SqlInsumos" runat="server" ConnectionString="<%$ ConnectionStrings:SUEPPSConnectionString %>" ></asp:SqlDataSource>

       
        <asp:SqlDataSource ID="SqlProgramas" runat="server" ConnectionString="<%$ ConnectionStrings:SUEPPSConnectionString %>"></asp:SqlDataSource>

       
        <asp:SqlDataSource ID="SqlPolitica" runat="server" ConnectionString="<%$ ConnectionStrings:SUEPPSConnectionString %>" ></asp:SqlDataSource>


       
    </div>
</asp:Content>
