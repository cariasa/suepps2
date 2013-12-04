<%@ Page Title="Prueba de MOCA" Language="VB" MasterPageFile="~/Site.master" AutoEventWireup="false" CodeFile="Default.aspx.vb" Inherits="Demo_Default" %>

<%@ Register src="../MOCA_UE.ascx" tagname="MOCA_UE" tagprefix="uc1" %>

<asp:Content ID="cHeader" ContentPlaceHolderID="HeadContent" Runat="Server">
</asp:Content>
<asp:Content ID="cBody" ContentPlaceHolderID="MainContent" Runat="Server">
    Control de Unidades Ejecutoras a las que el usuario tiene Acceso se muestran con el siguiente componente:
    <div class="Panel">
        <uc1:MOCA_UE ID="MOCA_UE1" runat="server" />
    </div> 
    <br />
    <hr />
    Botones para acciones Especificas tambien se pueden controlar a traves del MOCA<br />
    En cada pagina se pueden evaluar 10 acceiones diferentes, las tres primeras son estaticas que corresponden a: Agregar, Modificar y Eliminar, y las 7 restantes a acciones especificas de la WebForm.

<dx:ASPxButton ID="ASPxButton1" runat="server" Text="Agregar">
</dx:ASPxButton>
<dx:ASPxButton ID="ASPxButton2" runat="server" Text="Modificar">
</dx:ASPxButton>
<dx:ASPxButton ID="ASPxButton3" runat="server" Text="Eliminar">
</dx:ASPxButton>
<dx:ASPxButton ID="ASPxButton4" runat="server" Text="Accion Personalizada 1">
</dx:ASPxButton>
<br />
<dx:ASPxGridView ID="ASPxGridView1" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSource1">
    <Columns>
        <dx:GridViewCommandColumn Caption="Acciones" VisibleIndex="21">
            <EditButton Visible="True">
            </EditButton>
            <NewButton Visible="True">
            </NewButton>
            <DeleteButton Visible="True">
            </DeleteButton>
            <ClearFilterButton Visible="True">
            </ClearFilterButton>
        </dx:GridViewCommandColumn>
        <dx:GridViewDataTextColumn FieldName="codigo_ficha" VisibleIndex="0">
        </dx:GridViewDataTextColumn>
        <dx:GridViewDataDateColumn FieldName="fecha_inicio" VisibleIndex="2">
        </dx:GridViewDataDateColumn>
        <dx:GridViewDataDateColumn FieldName="fecha_cierre" VisibleIndex="4">
        </dx:GridViewDataDateColumn>
        <dx:GridViewDataTextColumn FieldName="EstadoFicha" VisibleIndex="5">
        </dx:GridViewDataTextColumn>
        <dx:GridViewDataTextColumn FieldName="NombreProyecto" VisibleIndex="1">
        </dx:GridViewDataTextColumn>
        <dx:GridViewDataTextColumn FieldName="codigo_proyecto" VisibleIndex="7">
        </dx:GridViewDataTextColumn>
        <dx:GridViewDataTextColumn FieldName="TotalFinanciamientoML" VisibleIndex="19">
            <PropertiesTextEdit DisplayFormatString="N2">
            </PropertiesTextEdit>
            <CellStyle HorizontalAlign="Right">
            </CellStyle>
        </dx:GridViewDataTextColumn>
    </Columns>
    <Settings ShowFilterRow="True" />
</dx:ASPxGridView>
<asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT codigo_ficha, codigo_swap, ley, fecha_inicio, fecha_cierre, IdEstadoFicha, EstadoFicha, beneficiarios, estado_descripcion, NombreProyecto, decreto, resolucion, fecha_firma, fecha_efectividad, fecha_cierre_amp, codigo_proyecto, IdEstadoDigitacion, EstadoDigitacion, IdPolitica, Politica, politicas, TotalFinanciamientoML FROM Proyectos"></asp:SqlDataSource>
</asp:Content>

