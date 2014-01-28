<%@ Page Title="Monitoreo Cuantitativo" Language="VB" AutoEventWireup="false" CodeFile="MonitoreoCuantitativo.aspx.vb" Inherits="GestionPublica_MonitoreoCuantitativo" MasterPageFile="~/Site.master" %>

<%@ Register Assembly="DevExpress.Web.v13.2, Version=13.2.6.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web.ASPxGridView" TagPrefix="dx" %>
<%@ Register Assembly="DevExpress.Web.v13.2, Version=13.2.6.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web.ASPxEditors" TagPrefix="dx" %>
<%@ Register Assembly="DevExpress.Web.v13.2, Version=13.2.6.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web.ASPxMenu" TagPrefix="dx" %>
<%@ Register Src="~/MOCA_UE.ascx" TagPrefix="uc1" TagName="MOCA_UE" %>


<asp:Content ID="cHeader" ContentPlaceHolderID="HeadContent" Runat="Server">
</asp:Content>
<asp:Content ID="cBody" ContentPlaceHolderID="MainContent" Runat="Server">
    <uc1:MOCA_UE runat="server" ID="MOCA_UE01" />


    <div>
        <script type="text/javascript">
            function OnAreaChanged(cmbArea) {cmbAno.PerformCallback(cmbArea.GetValue().toString());}
  
        </script>
        <dx:aspxlabel runat="server" id="LabelProgramaTitulo" />
        <table >
        <tr>
            
            <td>
                <dx:aspxlabel runat="server" text="Área De Influencia:" id="ComponenteLabel" associatedcontrolid="CmbArea" />
            </td>
            <td>
                <dx:ASPxComboBox runat="server" ID="CmbArea" DropDownStyle="DropDownList" IncrementalFilteringMode="StartsWith"
                    DataSourceID="SqlDataSourceArea" TextField="DescripcionAreaDeInfluencia" ValueField="IdAreaDeInfluencia"
                    EnableSynchronization="False">
                    <ClientSideEvents SelectedIndexChanged="function(s, e) { OnAreaChanged(s); }" />
                </dx:ASPxComboBox>
                
            </td>
            <td class="LeftPadding">
                <dx:ASPxLabel runat="server" Text="Año:" ID="ASPxLabel1" AssociatedControlID="CmbAno" />
            </td>
            <td>

                <dx:ASPxComboBox runat="server" ID="CmbAno" ClientInstanceName="cmbAno" OnCallback="CmbAno_Callback"
                    DropDownStyle="DropDown" DataSourceID="SqlDataSourceMeta" TextField="Ano"
                    ValueField="Ano" IncrementalFilteringMode="StartsWith" EnableSynchronization="False">
                    <ClientSideEvents SelectedIndexChanged="function(s, e) { ASPxGridView1.PerformCallback(s.GetValue());}"> </ClientSideEvents>
                </dx:ASPxComboBox>

            </td>
        </tr>
    </table>

     <asp:SqlDataSource runat="server" ID="SqlDataSourceArea" ConnectionString='<%$ ConnectionStrings:SUEPPSConnectionString %>' 
            SelectCommand="SELECT [IdAreaDeInfluencia], [DescripcionAreaDeInfluencia] FROM [AreasDeInfluencia] WHERE [IdPrograma] = @p and Activo=1">
         <SelectParameters>
                <asp:Parameter Name="p" />
         </SelectParameters>
     </asp:SqlDataSource>
        
        <asp:SqlDataSource ID="SqlDataSourceMeta" runat="server" ConnectionString='<%$ ConnectionStrings:SUEPPSConnectionString %>'
            SelectCommand="SELECT Ano FROM AnoPrograma WHERE IdPrograma = @p and Activo=1">
                       
            <SelectParameters>
                <asp:Parameter Name="p" />
            </SelectParameters>
        </asp:SqlDataSource>

        <dx:ASPxGridView ID="ASPxGridView1" ClientInstanceName="ASPxGridView1" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSourceMonitoreo" KeyFieldName="IdMetaPorPeriodo" OnCustomCallback="ASPxGridView1_CustomCallback" SettingsEditing-Mode="EditForm" Settings-ShowFilterRow="true" Settings-ShowFilterRowMenu="true" OnLoad="ASPxGridView1_Load" Settings-HorizontalScrollBarMode="Visible" Settings-VerticalScrollBarMode=Visible Width="100%">


            <Columns>
                <dx:GridViewDataTextColumn FieldName="IdMetaPorPeriodo" ReadOnly="True" VisibleIndex="0" Caption="#">
                    <EditFormSettings Visible="False"></EditFormSettings>
                    <Settings AllowAutoFilter="False" />
                </dx:GridViewDataTextColumn>
                                
                
                
                <dx:GridViewDataTextColumn FieldName="DescripcionSectorIndicador" VisibleIndex="1" EditFormSettings-Visible="False" Caption="Sector" >
                    <Settings AutoFilterCondition="Contains" />
                </dx:GridViewDataTextColumn>
                
                <dx:GridViewDataComboBoxColumn VisibleIndex="2" FieldName="IdIndicadorPorPrograma" Caption="Indicador" EditFormSettings-Visible="False">
                        <PropertiesComboBox ValueType="System.String" 
                
                            DataSourceID="SqlDataSourceIndicador" 
                            ValueField="IdIndicadoresPorPrograma" 
                            TextField="DescripcionIndicador"/>

                        <Settings AutoFilterCondition="Contains" />
                        <Settings FilterMode="DisplayText" />

     
                    
                </dx:GridViewDataComboBoxColumn>

                <dx:GridViewDataTextColumn FieldName="DescripcionTipoDeIndicador" VisibleIndex="3" EditFormSettings-Visible="False" Caption="Tipo Indicador" >
                    <Settings AllowAutoFilter="True" AutoFilterCondition="Contains" FilterMode="DisplayText" />
                </dx:GridViewDataTextColumn>

                <dx:GridViewDataTextColumn FieldName="Ano" VisibleIndex="3" EditFormSettings-Visible="False" Caption="Año" >
                    <Settings AllowAutoFilter="False" />
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="ProyectadoQ1" VisibleIndex="4" EditFormSettings-Visible="False" Caption="P1">
                    <Settings AllowAutoFilter="False" />
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="ProyectadoQ2" VisibleIndex="5" EditFormSettings-Visible="False" Caption="P2">
                    <Settings AllowAutoFilter="False" />
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="S1"  VisibleIndex="6" EditFormSettings-Visible="False" Caption="S1">
                    <Settings AllowAutoFilter="False" />
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="ProyectadoQ3" VisibleIndex="7" EditFormSettings-Visible="False" Caption="P3">
                    <Settings AllowAutoFilter="False" />
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="ProyectadoQ4" VisibleIndex="8" EditFormSettings-Visible="False" Caption="P4">
                    <Settings AllowAutoFilter="False" />
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Total" VisibleIndex="9" EditFormSettings-Visible="False" Caption="Total Prog.">
                    <Settings AllowAutoFilter="False" />
                </dx:GridViewDataTextColumn> 
                <dx:GridViewDataTextColumn FieldName="EjecutadoQ1" VisibleIndex="10" Caption="E1">
                    <Settings AllowAutoFilter="False" />
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="EjecutadoQ2" VisibleIndex="11" Caption="E2">
                    <Settings AllowAutoFilter="False" />
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="S1E"  VisibleIndex="12" Caption="S1" EditFormSettings-Visible="False">
                    <Settings AllowAutoFilter="False" />
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="EjecutadoQ3" VisibleIndex="13" Caption="E3">
                    <Settings AllowAutoFilter="False" />
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="EjecutadoQ4" VisibleIndex="14" Caption="E4">
                    <Settings AllowAutoFilter="False" />
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="TotalE" VisibleIndex="15" Caption="Total Ejec." EditFormSettings-Visible="False">
                    <Settings AllowAutoFilter="False" />
                </dx:GridViewDataTextColumn> 
                <dx:GridViewDataTextColumn FieldName="Potenciales" VisibleIndex="16" EditFormSettings-Visible="False" Caption="Pot.">
                    <Settings AllowAutoFilter="False" />
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="CreadoPor" VisibleIndex="17" Visible="false" EditFormSettings-Visible="False"></dx:GridViewDataTextColumn>
                <dx:GridViewDataDateColumn FieldName="FechaCreacion" VisibleIndex="18" Visible="false" EditFormSettings-Visible="False"></dx:GridViewDataDateColumn>
                <dx:GridViewDataTextColumn FieldName="ActualizadoPor" VisibleIndex="19" Visible="false" EditFormSettings-Visible="False"></dx:GridViewDataTextColumn>
                <dx:GridViewDataDateColumn FieldName="FechaActualizacion" VisibleIndex="20" Visible="false" EditFormSettings-Visible="False"></dx:GridViewDataDateColumn>
                <dx:GridViewDataCheckColumn FieldName="Activo" VisibleIndex="21" Visible="false" EditFormSettings-Visible="False"></dx:GridViewDataCheckColumn>
                <dx:GridViewCommandColumn VisibleIndex="22" HeaderStyle-HorizontalAlign="Center" Caption="Acción" CellStyle-HorizontalAlign="NotSet">

                            <EditButton Visible="true" />
                            
                </dx:GridViewCommandColumn>
            </Columns>
        <SettingsPager>
                       <AllButton Visible="True" Text="Todos">
                       </AllButton>
                    </SettingsPager>

        </dx:ASPxGridView>
        <asp:SqlDataSource runat="server" ID="SqlDataSourceMonitoreo" ConnectionString='<%$ ConnectionStrings:SUEPPSConnectionString %>' 
            
            SelectCommand="SELECT m.[IdMetaPorPeriodo], m.[IdAreaDeInfluencia], ti.DescripcionTipoDeIndicador  ,m.[IdIndicadorPorPrograma], rsec.[DescripcionSectorIndicador], m.[Ano], isNull(m.[ProyectadoQ1],0) as ProyectadoQ1,isNull(m.[ProyectadoQ2],0)  as ProyectadoQ2,(m.ProyectadoQ1 + m.ProyectadoQ2) As S1, isNull(m.[ProyectadoQ3],0)  as ProyectadoQ3, isNull(m.[ProyectadoQ4],0)  as ProyectadoQ4, (m.ProyectadoQ1 + m.ProyectadoQ2+ m.ProyectadoQ3 + m.ProyectadoQ4) As Total, isNull(m.[EjecutadoQ1],0)  as EjecutadoQ1, isNull(m.[EjecutadoQ2],0)  as EjecutadoQ2, (m.EjecutadoQ1 + m.EjecutadoQ2) As S1E, isNull(m.[EjecutadoQ3],0)  as EjecutadoQ3, isNull(m.[EjecutadoQ4],0)  as EjecutadoQ4, (m.EjecutadoQ1 + m.EjecutadoQ2 + m.EjecutadoQ3 + m.EjecutadoQ4) As TotalE, isNull(m.[Potenciales],0)  as Potenciales, m.[CreadoPor], m.[FechaCreacion], m.[ActualizadoPor], m.[FechaActualizacion], m.[Activo] 
            FROM [SUEPPS-BD].[dbo].[MetaYMonitoreoPorPeriodo] m 
            JOIN [SUEPPS-BD].[dbo].[IndicadoresPorPrograma] i ON m.[IdIndicadorPorPrograma]=i.[IdIndicadoresPorPrograma]
            JOIN [SUEPPS-BD].[dbo].[Indicadores] ind ON i.[IdIndicador] = ind.[IdIndicador]
			JOIN [SUEPPS-BD].[dbo].TiposDeIndicador ti ON ti.IdTipoDeIndicador = ind.IdTipoDeIndicador
            JOIN [vROISectorIndicadores] as rsec ON ind.[IdSectorIndicador] = rsec.[IdSectorIndicador] 
            WHERE m.[Ano]=@A AND i.[IdPrograma]=@P AND m.[IdAreaDeInfluencia]=@IdAreaDeInfluencia and m.Activo=1 and i.Activo=1 and ind.Activo=1  
            ORDER BY rsec.[DescripcionSectorIndicador] ASC"
            UpdateCommand="UPDATE [MetaYMonitoreoPorPeriodo] SET EjecutadoQ1=@EjecutadoQ1, EjecutadoQ2=@EjecutadoQ2, EjecutadoQ3=@EjecutadoQ3, EjecutadoQ4=@EjecutadoQ4, ActualizadoPor=@Actualizado, FechaActualizacion=getDate() WHERE (IdMetaPorPeriodo=@IdMetaPorPeriodo) "
            OnUpdated="SqlDataSourceMonitoreo_Updated">
            <SelectParameters>
                  <asp:SessionParameter Name="A" />
                  <asp:SessionParameter Name="P" />
                  <asp:SessionParameter Name="IdAreaDeInfluencia" />
            </SelectParameters>

            <UpdateParameters>
                <asp:SessionParameter Name="Actualizado" />
                <asp:FormParameter Name="EjecutadoQ1" />
                <asp:FormParameter Name="EjecutadoQ2" />
                <asp:FormParameter Name="EjecutadoQ3" />
                <asp:FormParameter Name="EjecutadoQ4" />

            </UpdateParameters>

        </asp:SqlDataSource>

        <asp:SqlDataSource runat="server" ID="SqlDataSourceIndicador" ConnectionString='<%$ ConnectionStrings:SUEPPSConnectionString %>' 
            SelectCommand="SELECT i.[DescripcionIndicador], p.[IdIndicadoresPorPrograma] FROM [IndicadoresPorPrograma]  p JOIN  [Indicadores]  i  ON p.[IdIndicador]= i.[IdIndicador]"></asp:SqlDataSource>
        
        
        <asp:SqlDataSource ID="SqlDataSourceTipoIndicadorGrid" runat="server" ConnectionString='<%$ ConnectionStrings:SUEPPSConnectionString %>' 
         SelectCommand="SELECT ti.DescripcionTipoDeIndicador, p.[IdIndicadoresPorPrograma] FROM [IndicadoresPorPrograma]  p,  [Indicadores]  i, [TiposDeIndicador] ti  WHERE p.[IdIndicador]= i.[IdIndicador]"></asp:SqlDataSource>
    </div>
</asp:Content>