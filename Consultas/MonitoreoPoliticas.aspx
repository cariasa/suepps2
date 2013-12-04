<%@ Page Language="VB" AutoEventWireup="false" CodeFile="MonitoreoPoliticas.aspx.vb" Inherits="Consultas_MonitoreoPoliticas"  MasterPageFile="~/Site.master" %>

<%@ Register Src="~/MOCA_UE.ascx" TagPrefix="uc1" TagName="MOCA_UE" %>


<asp:Content ID="cHeader" ContentPlaceHolderID="HeadContent" Runat="Server">
</asp:Content>
<asp:Content ID="cBody" ContentPlaceHolderID="MainContent" Runat="Server">
    <uc1:MOCA_UE runat="server" ID="MOCA_UE01" />
    <div>
        <%-- OnHtmlRowPrepared="ASPxGridViewPoliticas_HtmlRowPrepared" --%>
        <dx:ASPxGridView ID="ASPxGridViewPoliticas" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSourcePoliticas" KeyFieldName="IdPolitica" 
        ShowDetailRow="true" SettingsBehavior-AllowFocusedRow="true"
        OnHtmlDataCellPrepared="ASPxGridViewPoliticas_HtmlDataCellPrepared" >
            <Columns>
                <dx:GridViewDataTextColumn FieldName="IdPolitica" ReadOnly="True" VisibleIndex="0" Visible="false">
                    <EditFormSettings Visible="False"></EditFormSettings>
                </dx:GridViewDataTextColumn>
                
                <dx:GridViewDataTextColumn FieldName="Nombre" VisibleIndex="1" Caption="Politica"></dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="SujetosDeAtencion" VisibleIndex="4"></dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="PorcentajeEjecucion" VisibleIndex="5" PropertiesTextEdit-DisplayFormatString="P"></dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn Visible="true">
                    <DataItemTemplate>
                        <asp:LinkButton id="link1"  Text="VerDetalle" runat="server" Visible="true" OnClick="link1_Click" />
                    </DataItemTemplate>
               </dx:GridViewDataTextColumn>
            </Columns>
        </dx:ASPxGridView>

        <asp:SqlDataSource runat="server" ID="SqlDataSourcePoliticas" ConnectionString='<%$ ConnectionStrings:SUEPPSConnectionString %>' 
            >

        </asp:SqlDataSource>

    </div>
</asp:Content>
