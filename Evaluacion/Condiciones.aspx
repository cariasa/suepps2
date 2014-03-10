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
                <colgroup>
                    <col span="1" style="width: 60%;"/>
                    <col span="1" style="width: 40%;"/>
                </colgroup>
                
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

                <dx:GridViewDataComboBoxColumn VisibleIndex="1" FieldName="IdVariable" Caption="Variable" EditFormSettings-Visible="False" Visible="false">
                    <PropertiesComboBox ValueType="System.String"
                        DataSourceID="SqlDataSourceVariable"
                        ValueField="IdVariable"
                        TextField="NombreVariable" />
                    <Settings AllowAutoFilter="True" />
                    <Settings AutoFilterCondition="Contains" />
                    <Settings FilterMode="DisplayText" />


                    <EditFormSettings Visible="False"></EditFormSettings>


                </dx:GridViewDataComboBoxColumn>

                <dx:GridViewDataComboBoxColumn VisibleIndex="2" FieldName="IdTipoCondicion" Caption="Tipo Condición" EditFormSettings-Visible="True">
                    <PropertiesComboBox ValueType="System.String"
                        DataSourceID="SqlDataSourceTipoCondicion"
                        ValueField="IdTipoCondicion"
                        TextField="DescripcionTipoCondicion" />
                    <Settings AllowAutoFilter="True" />
                    <Settings AutoFilterCondition="Contains" />
                    <Settings FilterMode="DisplayText" />


                    <EditFormSettings Visible="True"></EditFormSettings>


                </dx:GridViewDataComboBoxColumn>


                <dx:GridViewDataTextColumn FieldName="NombreCondicion" VisibleIndex="3" Caption="Nombre">
                    <Settings AutoFilterCondition="Contains" />
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="DescripcionCondicion" VisibleIndex="4" Caption="Descripción">
                    <Settings AutoFilterCondition="Contains" />
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataCheckColumn FieldName="Raiz" Caption="Raíz" VisibleIndex="5"></dx:GridViewDataCheckColumn>
                <dx:GridViewDataCheckColumn FieldName="Total" VisibleIndex="6"></dx:GridViewDataCheckColumn>
                <dx:GridViewDataTextColumn FieldName="Operando1" VisibleIndex="7" Caption="Identificador"></dx:GridViewDataTextColumn>
                <%--<dx:GridViewDataTextColumn FieldName="Operador" VisibleIndex="7"></dx:GridViewDataTextColumn>--%>

                <dx:GridViewDataComboBoxColumn FieldName="Operador" VisibleIndex="8">
                    <PropertiesComboBox>
                        <Items>
                            <dx:ListEditItem Text="=" Value="=" />
                            <dx:ListEditItem Text="<" Value="<" />
                            <dx:ListEditItem Text="&le;" Value="<=" />
                            <dx:ListEditItem Text=">" Value=">" />
                            <dx:ListEditItem Text="&ge;" Value=">=" />
                            <dx:ListEditItem Text="&sub;" Value="Contenido" />
                            <dx:ListEditItem Text="AND" Value="AND" />
                            <dx:ListEditItem Text="OR" Value="OR" />
                        </Items>
                    </PropertiesComboBox>
                </dx:GridViewDataComboBoxColumn>

                <dx:GridViewDataTextColumn FieldName="Operando2" VisibleIndex="9" Caption="Identificador"></dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="CreadoPor" VisibleIndex="10" Visible="false"></dx:GridViewDataTextColumn>
                <dx:GridViewDataDateColumn FieldName="FechaCreacion" VisibleIndex="10" Visible="false"></dx:GridViewDataDateColumn>
                <dx:GridViewDataTextColumn FieldName="ActualizadoPor" VisibleIndex="11" Visible="false"></dx:GridViewDataTextColumn>
                <dx:GridViewDataDateColumn FieldName="FechaActualizacion" VisibleIndex="12" Visible="false"></dx:GridViewDataDateColumn>
                <dx:GridViewDataCheckColumn FieldName="Activo" VisibleIndex="13" Visible="false"></dx:GridViewDataCheckColumn>
                <dx:GridViewCommandColumn Caption="Acción">
                    <NewButton Visible="true"></NewButton>
                    <EditButton Visible="true"></EditButton>
                    <DeleteButton Visible="true"></DeleteButton>
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
