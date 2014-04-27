<%@ Page Language="VB" AutoEventWireup="false" CodeFile="MomentoAplicacion.aspx.vb" Inherits="Cuantitativo_MomentoAplicacion" %>

<%@ Register Assembly="DevExpress.Web.v13.2, Version=13.2.9.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web.ASPxGridView" TagPrefix="dx" %>

<%@ Register assembly="DevExpress.Web.v13.2, Version=13.2.9.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" namespace="DevExpress.Web.ASPxEditors" tagprefix="dx" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
    <div>

        <dx:ASPxGridView ID="ASPxGridViewMomento" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSourceMomento" KeyFieldName="IdMomentoAplicacion">
            <Columns>
                <dx:GridViewDataTextColumn FieldName="IdMomentoAplicacion" ReadOnly="True" VisibleIndex="0" Visible="false">
                    <EditFormSettings Visible="False" />
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="MomentoAplicacion" VisibleIndex="1">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="CreadoPor" VisibleIndex="2" Visible="false">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataDateColumn FieldName="FechaCreacion" VisibleIndex="3" Visible="false">
                </dx:GridViewDataDateColumn>
                <dx:GridViewDataTextColumn FieldName="ActualizadoPor" VisibleIndex="4" Visible="false">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataDateColumn FieldName="FechaActualizacion" VisibleIndex="5" Visible="false">
                </dx:GridViewDataDateColumn>
                <dx:GridViewDataCheckColumn FieldName="Activo" VisibleIndex="6" Visible="false">
                </dx:GridViewDataCheckColumn>
                 <dx:GridViewCommandColumn VisibleIndex="7" HeaderStyle-HorizontalAlign="Center" Caption="Acción" CellStyle-HorizontalAlign="NotSet">
                    
                    <NewButton Visible="True">
                    </NewButton>
                    <EditButton Visible="True">
                    </EditButton>
                    <DeleteButton Visible="True">
                    </DeleteButton>
                    <HeaderStyle HorizontalAlign="Center"></HeaderStyle>
                </dx:GridViewCommandColumn>
            </Columns>

             <SettingsPager>
                <AllButton Visible="True" Text="Todos">
                </AllButton>
            </SettingsPager>

        <SettingsBehavior AllowFocusedRow="True" />

        </dx:ASPxGridView>

        <asp:SqlDataSource ID="SqlDataSourceMomento" runat="server" ConnectionString="<%$ ConnectionStrings:SUEPPSConnectionString %>" 
            SelectCommand="SELECT * FROM [MomentosAplicacion] where [Activo]=1 "
            InsertCommand="Insert INTO [MomentosAplicacion] ([MomentoAplicacion],[CreadoPor], [FechaCreacion], [Activo]) VALUES (@MomentoAplicacion,'PACO', getDate(), 1)"
             UpdateCommand="Update [MomentosAplicacion] SET [MomentoAplicacion]=@MomentoAplicacion, [ActualizadoPor]='PACO', [FechaActualizacion]=getDate() WHERE [IdMomentoAplicacion] = @IdMomentoAplicacion"
             DeleteCommand="Update [MomentosAplicacion] SET [Activo]=0 WHERE [IdMomentoAplicacion] = @IdMomentoAplicacion"

            ></asp:SqlDataSource>

    </div>
    </form>
</body>
</html>
