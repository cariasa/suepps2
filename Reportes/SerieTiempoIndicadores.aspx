<%@ Page Language="VB" AutoEventWireup="false" CodeFile="SerieTiempoIndicadores.aspx.vb" Inherits="Reportes_SerieTiempoIndicadores"  MasterPageFile="~/Site.master" %>

<%@ Register Src="~/MOCA_UE.ascx" TagPrefix="uc1" TagName="MOCA_UE" %>

<asp:Content ID="cHeader" ContentPlaceHolderID="HeadContent" Runat="Server">
</asp:Content>
<asp:Content ID="cBody" ContentPlaceHolderID="MainContent" Runat="Server">
    <uc1:MOCA_UE runat="server" ID="MOCA_UE01" />
    <div>

        <table>
            <tr>
            <td>
                <dx:ASPxGridView ID="ASPxGridViewProyectos" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSourceProyectos" KeyFieldName="codigo_ficha" SettingsBehavior-AllowFocusedRow="true" Settings-ShowFilterRow="true">
                    <Columns>
                        <dx:GridViewDataTextColumn FieldName="codigo_ficha" ReadOnly="True" VisibleIndex="0" Visible="false"></dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn FieldName="NombreProyecto" VisibleIndex="1"><Settings AutoFilterCondition="Contains" /></dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn FieldName="Acción" ShowInCustomizationForm="True" VisibleIndex="4" Caption="Acción" UnboundType="String">
                              <DataItemTemplate>
                                    <asp:LinkButton ID="linkElegirP" Text="Elegir" runat="server" OnClick="linkElegirP_Click" />
                                    <br />

                              </DataItemTemplate>
                              <Settings AllowAutoFilter="False" />
                        </dx:GridViewDataTextColumn>
                    </Columns>
                </dx:ASPxGridView>
                <asp:SqlDataSource runat="server" ID="SqlDataSourceProyectos" ConnectionString='<%$ ConnectionStrings:SUEPPSConnectionString %>' SelectCommand="SELECT [codigo_ficha], [NombreProyecto] FROM [vProyectos]"></asp:SqlDataSource>
            </td>

                <td>
                    <dx:ASPxGridView ID="ASPxGridViewIndicadoresPrograma" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSourceIndicadoresPrograma" SettingsBehavior-AllowFocusedRow="true" Settings-ShowFilterRow="true" KeyFieldName="IdIndicador">
                        <Columns>
                            <dx:GridViewDataTextColumn FieldName="IdIndicador" VisibleIndex="0" Visible="true"></dx:GridViewDataTextColumn>
                            <dx:GridViewDataTextColumn FieldName="IdPrograma" VisibleIndex="1" Visible="false"></dx:GridViewDataTextColumn>
                            <dx:GridViewDataTextColumn FieldName="DescripcionIndicador" VisibleIndex="2"><Settings AutoFilterCondition="Contains" /></dx:GridViewDataTextColumn>
                            <dx:GridViewDataTextColumn FieldName="Acción" ShowInCustomizationForm="True" VisibleIndex="4" Caption="Acción" UnboundType="String">
                              <DataItemTemplate>
                                    <asp:LinkButton ID="linkElegirI" Text="Elegir" runat="server" OnClick="linkElegirI_Click" />
                                    <br />

                              </DataItemTemplate>
                              <Settings AllowAutoFilter="False" />
                        </dx:GridViewDataTextColumn>
                        </Columns>
                    </dx:ASPxGridView>

                    <asp:SqlDataSource runat="server" ID="SqlDataSourceIndicadoresPrograma" ConnectionString='<%$ ConnectionStrings:SUEPPSConnectionString %>' SelectCommand="SELECT ipp.[IdIndicador],[IdPrograma],i.DescripcionIndicador FROM [IndicadoresPorPrograma] ipp inner join Indicadores  i ON ipp.IdIndicador = i.IdIndicador
  where IdPrograma=@IdPrograma">
                        <SelectParameters>
                            <asp:SessionParameter Name="IdPrograma" Type="Int32"/>
                        </SelectParameters>
                    </asp:SqlDataSource>
                </td>
            </tr>
        </table>

        <dx:ASPxGridView ID="ASPxGridViewIndicadores" runat="server" Visible="false" DataSourceID="SqlDataSourceIndicadores" KeyFieldName="IdIndicador">
            <Columns>
                <dx:GridViewDataTextColumn FieldName="IdIndicador" ReadOnly="True" VisibleIndex="0">
                    <EditFormSettings Visible="False"></EditFormSettings>
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="DescripcionIndicador" VisibleIndex="1"></dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Ano" VisibleIndex="2"></dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="PAA" ReadOnly="True" VisibleIndex="3"></dx:GridViewDataTextColumn>
            </Columns>
        </dx:ASPxGridView>

        <asp:SqlDataSource runat="server" ID="SqlDataSourceIndicadores" ConnectionString='<%$ ConnectionStrings:SUEPPSConnectionString %>' 
            SelectCommand="SELECT c.IdIndicador, c.DescripcionIndicador, a.Ano, (COALESCE((SUM(a.[EjecutadoQ1]+a.[EjecutadoQ2]+a.[EjecutadoQ3]+a.[EjecutadoQ4]))/ NULLIF((SUM(a.ProyectadoQ1+a.ProyectadoQ2+a.ProyectadoQ3+a.ProyectadoQ4)),0),0))*100 As PAA FROM [MetaYMonitoreoPorPeriodo] a join [IndicadoresPorPrograma] b on b.IdIndicadoresPorPrograma= a.IdIndicadorPorPrograma join [Indicadores] c on b.IdIndicador= c.IdIndicador join [TiposDeIndicador] d on c.IdTipoDeIndicador=d.IdTipoDeIndicador where b.IdPrograma = @IdPrograma And c.IdIndicador = @IdIndicador And c.IdTipoDeIndicador = 1 And a.Activo=1 And b.Activo=1 and c.Activo=1 and (a.ProyectadoQ1 <> 0 Or a.ProyectadoQ2 <> 0 OR a.ProyectadoQ3 <> 0 OR a.ProyectadoQ4 <> 0) GROUP BY c.IdIndicador,c.DescripcionIndicador, a.Ano">
            <SelectParameters>
                <asp:SessionParameter Name="IdPrograma" Type="Int32"/>
                <asp:SessionParameter Name="IdIndicador" Type="Int32" />
            </SelectParameters>
        </asp:SqlDataSource>
        <dx:WebChartControl id="WebChartControlIndicadores" runat="server" height="400px" width="700px" cssclass="AlignCenter TopLargeMargin"
            datasourceid="AccessDataSource1" clientinstancename="chart" >
            
       
         </dx:WebChartControl>

        <asp:SqlDataSource ID="AccessDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:SUEPPSConnectionString %>">
            <SelectParameters>
                <asp:SessionParameter Name="IdIndicador" Type="Int32" />
                <asp:SessionParameter Name="IdPrograma" Type="Int32" />
            </SelectParameters>
        </asp:SqlDataSource>
    </div>
</asp:Content>

