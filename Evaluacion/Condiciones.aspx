<%@ Page Title="Condiciones de Variables" Language="VB" AutoEventWireup="false" CodeFile="Condiciones.aspx.vb" Inherits="Evaluacion_Condiciones" MasterPageFile="~/Site.master" %>

<%@ Register Src="~/MOCA_UE.ascx" TagPrefix="uc1" TagName="MOCA_UE" %>

<asp:Content ID="cHeader" ContentPlaceHolderID="HeadContent" runat="Server">
</asp:Content>
<asp:Content ID="cBody" ContentPlaceHolderID="MainContent" runat="Server">
    <script type="text/javascript">
        var command;
        function OnBeginCallback(s, e) {
            command = e.command;
        }
        function OnEndCallback(s, e) {
            if (command == "STARTINSERT") {
                if (s.cpCancelInsert)
                    alert("Operando1 y Operando2 no pueden ser vacío ");
            }
        }
    </script>
    <uc1:MOCA_UE runat="server" ID="MOCA_UE01" />
    <div>
        <div>
            <table>                
                <tr>
                    <td>
                        <dx:ASPxLabel ID="ASPxLabelVariable" runat="server" Font-Size="Large"/>
                        <br />
                        <dx:ASPxLabel ID="ASPxLabelAvanzado" runat="server" Text="A V A N Z A D O" ForeColor="Red" />
                    </td>
                    <td>
                        <dx:ASPxLabel ID="espacio" runat="server" Text=" " Width="360"></dx:ASPxLabel>
                        <dx:ASPxHyperLink ID="ASPxHyperLinkRegresar" runat="server" Text="Regresar a Parámetros" NavigateUrl="Parametros.aspx" />
                    </td>
                </tr>

            </table>

        </div>

        <dx:ASPxGridView ID="ASPxGridViewCondiciones" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSourceCondiciones" KeyFieldName="IdCondicion" Settings-ShowFilterRow="true" >
            <Columns>
                <%--<dx:GridViewDataTextColumn FieldName="Operador" VisibleIndex="7"></dx:GridViewDataTextColumn>--%>

                <dx:GridViewDataTextColumn FieldName="IdCondicion" ReadOnly="True" VisibleIndex="0" Caption="ID">
                    <EditFormSettings Visible="False"></EditFormSettings>
                </dx:GridViewDataTextColumn>

                <dx:GridViewDataComboBoxColumn Caption="Variable" FieldName="IdVariable" VisibleIndex="1" Visible="false">
                    <PropertiesComboBox DataSourceID="SqlDataSourceVariable" TextField="NombreVariable" ValueField="IdVariable">
                    </PropertiesComboBox>
                    <Settings AllowAutoFilter="True" AutoFilterCondition="Contains" FilterMode="DisplayText" />
                    <EditFormSettings Visible="False" />
                </dx:GridViewDataComboBoxColumn>
                <dx:GridViewDataComboBoxColumn Caption="Tipo Condición" FieldName="IdTipoCondicion" VisibleIndex="2">
                    <PropertiesComboBox DataSourceID="SqlDataSourceTipoCondicion" TextField="DescripcionTipoCondicion" ValueField="IdTipoCondicion">
                    </PropertiesComboBox>
                    <Settings AllowAutoFilter="True" AutoFilterCondition="Contains" FilterMode="DisplayText" />
                    <EditFormSettings Visible="True" />
                </dx:GridViewDataComboBoxColumn>


                <dx:GridViewDataTextColumn FieldName="NombreCondicion" VisibleIndex="3" Caption="Nombre">
                    <Settings AutoFilterCondition="Contains" />
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="DescripcionCondicion" VisibleIndex="4" Caption="Descripción">
                    <Settings AutoFilterCondition="Contains" />
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataCheckColumn FieldName="Raiz" VisibleIndex="5"></dx:GridViewDataCheckColumn>
                <dx:GridViewDataCheckColumn FieldName="Total" VisibleIndex="6"></dx:GridViewDataCheckColumn>
                <dx:GridViewDataTextColumn FieldName="Operando1" VisibleIndex="7" Caption="Identificador"></dx:GridViewDataTextColumn>
                <dx:GridViewDataComboBoxColumn FieldName="Operador" VisibleIndex="8">
                    <PropertiesComboBox>
                        <Items>
                            <dx:ListEditItem Text="=" Value="=" />
                            <dx:ListEditItem Text="&lt;" Value="&lt;" />
                            <dx:ListEditItem Text="≤" Value="&lt;=" />
                            <dx:ListEditItem Text="&gt;" Value="&gt;" />
                            <dx:ListEditItem Text="≥" Value="&gt;=" />
                            <dx:ListEditItem Text="⊂" Value="Contenido" />
                            <dx:ListEditItem Text="AND" Value="AND" />
                            <dx:ListEditItem Text="OR" Value="OR" />
                        </Items>
                    </PropertiesComboBox>
                </dx:GridViewDataComboBoxColumn>

                <dx:GridViewDataTextColumn FieldName="Operando2" VisibleIndex="9" Caption="Identificador"></dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="CreadoPor" Visible="False" VisibleIndex="10">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataDateColumn FieldName="FechaCreacion" VisibleIndex="10" Visible="False"></dx:GridViewDataDateColumn>
                <dx:GridViewDataTextColumn FieldName="ActualizadoPor" Visible="False" VisibleIndex="11">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataDateColumn FieldName="FechaActualizacion" VisibleIndex="12" Visible="False"></dx:GridViewDataDateColumn>
                <dx:GridViewDataCheckColumn FieldName="Activo" VisibleIndex="13" Visible="False"></dx:GridViewDataCheckColumn>
                <dx:GridViewCommandColumn Caption="Acción" VisibleIndex="14">
                    <EditButton Visible="True">
                    </EditButton>
                    <NewButton Visible="True">
                    </NewButton>
                    <DeleteButton Visible="True">
                    </DeleteButton>
                </dx:GridViewCommandColumn>
            </Columns>
            <SettingsPager>
                <AllButton Visible="True" Text="Todos">
                </AllButton>
            </SettingsPager>

            <Settings ShowFilterRow="True"></Settings>
            <ClientSideEvents BeginCallback="OnBeginCallback" EndCallback="OnEndCallback" />
        </dx:ASPxGridView>
        <asp:SqlDataSource runat="server" ID="SqlDataSourceCondiciones" ConnectionString='<%$ ConnectionStrings:SUEPPSConnectionString %>' 
            SelectCommand="SELECT * FROM [Condiciones] WHERE [IdVariable]=@IdVariable AND [Activo]=1"
            >
            <SelectParameters>
                <asp:SessionParameter SessionField="IdVariable" Name="IdVariable" Type="Int32"></asp:SessionParameter>
            </SelectParameters>
            <InsertParameters>
                <asp:SessionParameter SessionField="IdVariable" Name="IdVariable" Type="Int32"></asp:SessionParameter>
                <asp:FormParameter Name="IdTipoCondicion" />
                <asp:FormParameter Name="NombreCondicion" />
                <asp:FormParameter Name="DescripcionCondicion" />
                <asp:FormParameter Name="Raiz" />
                <asp:FormParameter Name="Total" />
                <asp:FormParameter Name="Operando1" />
                <asp:FormParameter Name="Operador" />
                <asp:FormParameter Name="Operando2" />
            </InsertParameters>
            <UpdateParameters>
                <asp:FormParameter Name="IdTipoCondicion" />
                <asp:FormParameter Name="NombreCondicion" />
                <asp:FormParameter Name="DescripcionCondicion" />
                <asp:FormParameter Name="Raiz" />
                <asp:FormParameter Name="Total" />
                <asp:FormParameter Name="Operando1" />
                <asp:FormParameter Name="Operador" />
                <asp:FormParameter Name="Operando2" />
            </UpdateParameters>
        </asp:SqlDataSource>

        <asp:SqlDataSource runat="server" ID="SqlDataSourceTipoCondicion" ConnectionString='<%$ ConnectionStrings:SUEPPSConnectionString %>'
            SelectCommand="SELECT IdTipoCondicion, DescripcionTipoCondicion FROM [TiposCondiciones]"></asp:SqlDataSource>

        <asp:SqlDataSource runat="server" ID="SqlDataSourceVariable" ConnectionString='<%$ ConnectionStrings:SUEPPSConnectionString %>'
            SelectCommand="SELECT IdVariable, NombreVariable FROM [Variables]"></asp:SqlDataSource>
    </div>
</asp:Content>
