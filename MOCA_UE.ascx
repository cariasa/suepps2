<%@ Control Language="VB" AutoEventWireup="false" CodeFile="MOCA_UE.ascx.vb" Inherits="MOCA_UE" %>
<table border="0" cellpadding="2" cellspacing="0" >
    <tr>
        <td>
            Entidad
        </td>
        <td>
            <asp:Label ID="lblEntidad" runat="server" Text="Sin Asignar" Visible="False"></asp:Label>
            <asp:DropDownList ID="ddlEntidades" runat="server" AutoPostBack="True"
                DataTextField="EnterpriseName" DataValueField="EnterpriseId">
            </asp:DropDownList>
        </td>
    </tr>
    <tr>
        <td>
            Unidad Ejecutora
        </td>
        <td>
            <asp:Label ID="lblUnidadEjecutora" runat="server" Text="Sin Asignar" Visible="False"></asp:Label>
            <asp:DropDownList ID="ddlUnidadesEjecutoras" runat="server"
                DataTextField="BranchOfficeName" DataValueField="BranchOfficeId" 
                AutoPostBack="True">
            </asp:DropDownList>
        </td>
    </tr>
</table>
