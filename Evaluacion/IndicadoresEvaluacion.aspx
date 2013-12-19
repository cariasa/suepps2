<%@ Page Language="VB" AutoEventWireup="false" CodeFile="IndicadoresEvaluacion.aspx.vb" Inherits="Cuantitativo_IndicadoresEvaluación" MasterPageFile="~/Site.master" %>

<%@ Register Assembly="DevExpress.Web.v13.1, Version=13.1.8.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web.ASPxGridView" TagPrefix="dx" %>

<%@ Register Assembly="DevExpress.Web.v13.1, Version=13.1.8.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web.ASPxEditors" TagPrefix="dx" %>

<%@ Register Src="~/MOCA_UE.ascx" TagPrefix="uc1" TagName="MOCA_UE" %>

<asp:Content ID="cHeader" ContentPlaceHolderID="HeadContent" runat="Server">
</asp:Content>
<asp:Content ID="cBody" ContentPlaceHolderID="MainContent" runat="Server">
    <uc1:MOCA_UE runat="server" ID="MOCA_UE01" />


    <script type="text/javascript">
        function OnSectorChanged(Combosector) {
            GridIndicadores.PerformCallback();
        }
    </script>
    <div>
        <table>
            <tr>
                <td>
                    <dx:ASPxLabel ID="ASPxLabelTitulo" runat="server" Font-Size="Large" />
                </td>
                <td>
                    <dx:ASPxLabel ID="espacio" runat="server" Text=" " Width="50"></dx:ASPxLabel>
                    <dx:ASPxHyperLink ID="ASPxHyperLinkRegresar" runat="server" Text="Regresar a Selección" NavigateUrl="Instrumentos.aspx" />

                </td>
            </tr>
        </table>
    </div>
    <div>

        <div>
            <table>
                <tr>
                    <td>

                        <dx:ASPxLabel ID="Sector" runat="server" Text="Sector:" AssociatedControlID="combosector" />


                        <dx:ASPxComboBox ID="combosector" ClientInstanceName="combosector" runat="server" ValueField="IdSectorIndicador"
                            TextField="DescripcionSectorIndicador" DataSourceID="Sqlcombosector" ClientSideEvents-SelectedIndexChanged="function(s, e) {OnSectorChanged(s); }">
                            <ClientSideEvents SelectedIndexChanged="function(s, e) {OnSectorChanged(s); }"></ClientSideEvents>
                        </dx:ASPxComboBox>

                        <asp:SqlDataSource ID="Sqlcombosector" runat="server" ConnectionString="<%$ ConnectionStrings:SUEPPSConnectionString %>" SelectCommand="SELECT [DescripcionSectorIndicador],[IdSectorIndicador] FROM [vROISectorIndicadores]"></asp:SqlDataSource>

                        <dx:ASPxGridView ID="GridIndicadores" ClientInstanceName="GridIndicadores" runat="server" AutoGenerateColumns="False" DataSourceID="SqlIndicadores" OnCustomCallback="GridIndicadores_CustomCallback" KeyFieldName="IdIndicador" PreviewFieldName="Descripcion" Enabled="true" OnLoad="GridIndicadores_Load" Settings-ShowFilterRow="true" Settings-ShowFilterRowMenu="true">


                            <Columns>
                                <dx:GridViewDataTextColumn FieldName="IdIndicador" Caption="#" ReadOnly="True" ShowInCustomizationForm="True" VisibleIndex="0">
                                    <EditFormSettings Visible="False" />
                                    <Settings AllowAutoFilter="False" />
                                </dx:GridViewDataTextColumn>

                                <dx:GridViewDataTextColumn FieldName="DescripcionIndicador" ShowInCustomizationForm="True" VisibleIndex="1" Caption="Indicador">
                                    <Settings AutoFilterCondition="Contains" />
                                </dx:GridViewDataTextColumn>



                                <dx:GridViewDataTextColumn FieldName="Acciones" Caption="Acción" ShowInCustomizationForm="True" VisibleIndex="2" UnboundType="String">
                                    <DataItemTemplate>
                                        <asp:LinkButton ID="link1" Text="Agregar" runat="server" OnClick="addIdentificador" />
                                    </DataItemTemplate>
                                    <Settings AllowAutoFilter="False" />
                                </dx:GridViewDataTextColumn>

                            </Columns>
                            <SettingsPager>
                                <AllButton Visible="True" Text="Todos">
                                </AllButton>
                            </SettingsPager>

                            <SettingsBehavior AllowFocusedRow="True" />

                            <Settings ShowFilterRow="True"></Settings>

                        </dx:ASPxGridView>

                    </td>
                    <td>
                        <dx:ASPxGridView ID="ASPxGridView1" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSourceIndicadoresEvaluacion" KeyFieldName="IdIndicadoresEvaluacionPorPrograma">
                            <Columns>
                                <dx:GridViewDataTextColumn FieldName="IdIndicadoresEvaluacionPorPrograma" ReadOnly="True" VisibleIndex="0" Visible="false">
                                    <EditFormSettings Visible="False" />
                                </dx:GridViewDataTextColumn>
                                <dx:GridViewDataTextColumn FieldName="IdIndicador" VisibleIndex="1" Visible="false">
                                </dx:GridViewDataTextColumn>
                                <dx:GridViewDataTextColumn FieldName="DescripcionSectorIndicador" Caption="Sector" VisibleIndex="2">
                                </dx:GridViewDataTextColumn>
                                <dx:GridViewDataTextColumn FieldName="DescripcionIndicador" Caption="Indicador" VisibleIndex="3">
                                </dx:GridViewDataTextColumn>
                                <dx:GridViewCommandColumn VisibleIndex="10" HeaderStyle-HorizontalAlign="Center" Caption="Acción" CellStyle-HorizontalAlign="NotSet">
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

                            <Settings ShowFilterRow="True"></Settings>

                        </dx:ASPxGridView>

                    </td>
                </tr>
            </table>
        </div>


        <asp:SqlDataSource ID="SqlDataSourceIndicadoresEvaluacion" runat="server" ConnectionString="<%$ ConnectionStrings:SUEPPSConnectionString %>"
            SelectCommand="SELECT a.IdIndicadoresEvaluacionPorPrograma,a.IdIndicador,b.DescripcionIndicador,c.DescripcionSectorIndicador FROM [IndicadoresEvaluacionPorPrograma] as a join [Indicadores] as b on a.IdIndicador=b.IdIndicador join [vROISectorIndicadores] as c on b.IdSectorIndicador=c.IdSectorIndicador where a.Activo=1 and a.IdPrograma=@IdPrograma"
            InsertCommand="INSERT INTO [IndicadoresEvaluacionPorPrograma]([IdIndicador] ,[IdPrograma],[Activo],[CreadoPor],[FechaCreacion]) VALUES (@IdIndicador, @IdPrograma,1,'PACO',getDate())"
            DeleteCommand="DELETE FROM [IndicadoresEvaluacionPorPrograma] where [IdIndicadoresEvaluacionPorPrograma]=@IdIndicadoresEvaluacionPorPrograma">



            <SelectParameters>
                <asp:SessionParameter Name="IdPrograma" />
            </SelectParameters>


            <InsertParameters>
                <asp:SessionParameter Name="IdIndicador" />
                <asp:SessionParameter Name="IdPrograma" />

            </InsertParameters>


        </asp:SqlDataSource>


        <asp:SqlDataSource ID="SqlIndicadores" runat="server" ConnectionString="<%$ ConnectionStrings:SUEPPSConnectionString %>"
            SelectCommand="SELECT I.IdIndicador,I.DescripcionIndicador FROM [Indicadores] I join TiposDeIndicador TI on I.IdTipoDeIndicador = TI.IdTipoDeIndicador WHERE ([IdSectorIndicador] = @p1) AND  I.Activo=1 AND TI.[NivelTipoDeIndicador] != 1 AND TI.[NivelTipoDeIndicador] != 0">
            <SelectParameters>
                <asp:SessionParameter Name="p1" />
            </SelectParameters>
        </asp:SqlDataSource>








    </div>

</asp:Content>
