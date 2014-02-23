<%@ Page Language="VB" AutoEventWireup="false" CodeFile="SeccionFSU.aspx.vb" Inherits="Cuantitativo_SeccionFSU" %>

<%@ Register Assembly="DevExpress.Web.v13.2, Version=13.2.7.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web.ASPxGridView" TagPrefix="dx" %>

<%@ Register assembly="DevExpress.Web.v13.2, Version=13.2.7.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" namespace="DevExpress.Web.ASPxEditors" tagprefix="dx" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
    <div>

        <dx:ASPxGridView ID="ASPxGridView1" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSource1" KeyFieldName="IdSeccionFSU">
            <Columns>
                <dx:GridViewDataTextColumn FieldName="IdSeccionFSU" ReadOnly="True" VisibleIndex="0" Visible="false">
                    <EditFormSettings Visible="False" />
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="NombreSeccion" Caption="Nombre" VisibleIndex="1">
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
        </dx:ASPxGridView>

        <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:SUEPPSConnectionString %>" 
            SelectCommand="SELECT * FROM [SeccionesFSU] where [Activo]=1"
            InsertCommand="INSERT INTO SeccionesFSU (NombreSeccion,CreadoPor,FechaCreacion,Activo) values (@NombreSeccion,'PACO',getDate(),1) "
            UpdateCommand="UPDATE [SeccionesFSU] SET [NombreSeccion]=@NombreSeccion where [IdSeccionFSU]=@IdSeccionFSU"
            DeleteCommand="UPDATE [SeccionesFSU] SET [Activo]=0 where [IdSeccionFSU]=@IdSeccionFSU"
            
         >




        </asp:SqlDataSource>

    </div>
    </form>
</body>
</html>
