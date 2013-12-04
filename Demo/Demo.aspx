<%@ Page Title="DEMO 2" Language="VB" MasterPageFile="~/Site.master" AutoEventWireup="false" CodeFile="Demo.aspx.vb" Inherits="Demo_Demo" %>

<asp:Content ID="cHeader" ContentPlaceHolderID="HeadContent" Runat="Server">
</asp:Content>
<asp:Content ID="cBody" ContentPlaceHolderID="MainContent" Runat="Server">
        <table>
        <tr>
            <td>
                <h3>
                    Usuarios</h3>
                <asp:Label ID="lblNoUserOnline" runat="server"></asp:Label>
            </td>
        </tr>
        <tr>
            <td>
                <asp:HyperLink ID="hlNuevo" runat="server" NavigateUrl="Detail.aspx?cmd=1">Nuevo</asp:HyperLink>
            </td>
        </tr>
        <tr>
            <td>
                <dx:ASPxGridView ID="gvUsuariosEnLinea" runat="server" AutoGenerateColumns="False"
                    Width="100%">
                    <Columns>
                        <dx:GridViewCommandColumn Caption="Acción" VisibleIndex="6">
                            <EditButton Visible="True">
                            </EditButton>
                            <NewButton Visible="True">
                            </NewButton>
                            <DeleteButton Visible="True">
                            </DeleteButton>
                        </dx:GridViewCommandColumn>
                        <dx:GridViewDataTextColumn Caption="Usuario" FieldName="UserName" VisibleIndex="0">
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn Caption="Descripción" FieldName="Comment" VisibleIndex="1">
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn Caption="Correo" FieldName="Email" VisibleIndex="2">
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn Caption="Ultima Conexión" FieldName="LastActivityDate"
                            VisibleIndex="3">
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataCheckColumn Caption="Conectado" FieldName="IsOnline" SortIndex="0"
                            SortOrder="Descending" VisibleIndex="4">
                        </dx:GridViewDataCheckColumn>
                    </Columns>
                    <SettingsPager ShowSeparators="True">
                        <PageSizeItemSettings ShowAllItem="True" Visible="True">
                        </PageSizeItemSettings>
                    </SettingsPager>
                    <Settings ShowFilterRow="True" />
                </dx:ASPxGridView>
            </td>
        </tr>
    </table>

</asp:Content>

