<%@ Page Language="VB" AutoEventWireup="false" CodeFile="ReporteProgramas.aspx.vb" Inherits="Reportes_ReporteProgramas" MasterPageFile="~/Site.master"  %>

<%@ Register Src="~/MOCA_UE.ascx" TagPrefix="uc1" TagName="MOCA_UE" %>


<asp:Content ID="cHeader" ContentPlaceHolderID="HeadContent" Runat="Server">
</asp:Content>
<asp:Content ID="cBody" ContentPlaceHolderID="MainContent" Runat="Server">
    <uc1:MOCA_UE runat="server" ID="MOCA_UE01" />
    <div>
        <dx:ASPxGridView ID="ASPxGridViewProgramas" runat="server" DataSourceID="SqlDataSourceProgramas" SettingsBehavior-AllowFocusedRow="true" Settings-ShowFilterRow="true" KeyFieldName="codigo_ficha" Settings-ShowFilterRowMenu="true">
        <Columns>
            
            <dx:GridViewDataTextColumn FieldName="codigo_ficha" ReadOnly="True" VisibleIndex="0" Caption="#">
                        <EditFormSettings Visible="False"></EditFormSettings>
                <Settings AllowAutoFilter="False" />
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="NombreProyecto" ReadOnly="True" VisibleIndex="0" Caption="Proyecto">
                <EditFormSettings Visible="False"></EditFormSettings>
                <Settings AutoFilterCondition="Contains" />
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn>
            <DataItemTemplate>
                <dx:ASPxButton runat="server" ID="VerAno" OnClick="VerAno_Click" Text="Seleccionar" Cursor="pointer" EnableDefaultAppearance="false" Font-Underline="true"  ForeColor="Blue" OnInit="VerAno_Init" >

                </dx:ASPxButton>
            </DataItemTemplate>
            </dx:GridViewDataTextColumn>
        </Columns>

            <SettingsPager>
                                                        <AllButton Visible="True" Text="Todos">
                                                        </AllButton>
                                                    </SettingsPager>
        </dx:ASPxGridView>
        

        <table>
        <tr>
            <td>
                <dx:ASPxLabel ID="ASPxLabel1" Text="Año" AssociatedControlID="ASPxComboBoxAno" runat="server"></dx:ASPxLabel>
            </td>
        </tr>
        <tr>
            <td>
                <dx:ASPxCheckBox runat="server" Text="Ver Indicadores de Cobertura" ID="cobertura" Checked="true" ></dx:ASPxCheckBox>
            </td>
            <td>
                
                
                <dx:ASPxComboBox ID="ASPxComboBoxAno" runat="server" ValueType="System.String" DataSourceID="SqlDataSourceAnoPrograma" TextField="Ano" ValueField="Ano">
                </dx:ASPxComboBox>
            </td>
            <td>
                <dx:ASPxButton ID="ASPxButtonGraficar" runat="server" Text="Graficar" OnClick="ASPxButtonGraficar_Click"></dx:ASPxButton>

            </td>
        </tr>
        </table>        
                
                
           
        
        <dx:ASPxGridView ID="ASPxGridView1" runat="server" DataSourceID="SqlDataSourceProgramasGraficar" OnLoad="ASPxGridView1_Load">
            <SettingsPager>
                                                        <AllButton Visible="True" Text="Todos">
                                                        </AllButton>
                                                    </SettingsPager>
        </dx:ASPxGridView>
        
        
        <dx:WebChartControl ID="chart" runat="server" Height="387px" Width="1150px"></dx:WebChartControl>
        


        <asp:SqlDataSource ID="SqlDataSourceProgramas" runat="server" ConnectionString='<%$ ConnectionStrings:SUEPPSConnectionString %>' 
            SelectCommand="SELECT [codigo_ficha], [NombreProyecto] FROM [vProyectos]">
        </asp:SqlDataSource>

        <asp:SqlDataSource ID="SqlDataSourceAnoPrograma" runat="server" ConnectionString='<%$ ConnectionStrings:SUEPPSConnectionString %>' 
            SelectCommand="SELECT [IdPrograma], [Ano] FROM [AnoPrograma] WHERE [IdPrograma]=@IdPrograma and [Activo]=1">
            <SelectParameters>
                <asp:SessionParameter Name="IdPrograma" />
            </SelectParameters>
        </asp:SqlDataSource>

        <asp:SqlDataSource ID="SqlDataSourceProgramasGraficar" runat="server" ConnectionString='<%$ ConnectionStrings:SUEPPSConnectionString %>'>
            <SelectParameters>
                <asp:SessionParameter Name="Ano" />
                <asp:SessionParameter Name="IdPrograma" />
            </SelectParameters>
        </asp:SqlDataSource>
    </div>
</asp:Content>