<%@ Page Title="Planificación de Política" Language="VB" AutoEventWireup="false" CodeFile="Politica.aspx.vb" Inherits="GestionPublica_Politica" MasterPageFile="~/Site.master" %>

<%@ Register Assembly="DevExpress.Web.v13.2, Version=13.2.9.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web.ASPxTabControl" TagPrefix="dx" %>
<%@ Register Assembly="DevExpress.Web.v13.2, Version=13.2.9.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web.ASPxPanel" TagPrefix="dx" %>
<%@ Register Assembly="DevExpress.Web.v13.2, Version=13.2.9.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web.ASPxGridView" TagPrefix="dx" %>
<%@ Register assembly="DevExpress.Web.v13.2, Version=13.2.9.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" namespace="DevExpress.Web.ASPxEditors" tagprefix="dx" %>
<%@ Register Assembly="DevExpress.Web.v13.2, Version=13.2.9.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web.ASPxClasses" TagPrefix="dx" %>
<%@ Register Assembly="DevExpress.Web.v13.2, Version=13.2.9.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web.ASPxMenu" TagPrefix="dx" %>

<%@ Register Src="~/MOCA_UE.ascx" TagPrefix="uc1" TagName="MOCA_UE" %>


<asp:Content ID="cHeader" ContentPlaceHolderID="HeadContent" Runat="Server">
</asp:Content>
<asp:Content ID="cBody" ContentPlaceHolderID="MainContent" Runat="Server">
    <uc1:MOCA_UE runat="server" ID="MOCA_UE01" />

    <div>
        <script type="text/javascript">

            function click(e) {


                if (e.tab.index.toString() == "1") {
                    //alert("METAS");
                    CmbComponente.PerformCallback();
                    ASPxGridViewMetas.PerformCallback(-1);
                }

                if (e.tab.index.toString() == "2") {
                    //alert("INDICADORES");
                    cmbComponenteI.PerformCallback();
                    cmbMetaComponente.PerformCallback();
                    ASPxGridViewIndicadoresDeMeta.PerformCallback();
                }

                if (e.tab.index.toString() == "3") {
                    //alert("PROGRAMAS");
                    cmbComponenteP.PerformCallback();
                    cmbMetaComponenteP.PerformCallback();
                    cmbIndicadoresP.PerformCallback();
                    ASPxGridView1.PerformCallback();
                }

                if (e.tab.index.toString() == "4") {
                    //alert("INSTITUCIONES");
                    cmbComponenteInstitucion.PerformCallback();
                    cmbMetaComponenteInstitucion.PerformCallback();
                    cmbIndicadoresInstitucion.PerformCallback();
                    GridInstitucionMeta.PerformCallback();
                }
  
            }

           
            function oncombocomponente(cmbcomponente) { ASPxGridViewMetas.PerformCallback();}

            function OncmbComponenteIChanged(cmbComponenteI) {cmbMetaComponente.PerformCallback(cmbComponenteI.GetValue().toString());}

            function OncmbNivelChanged(cmbNivel) {GridSectorNivelIndicador.PerformCallback(cmbNivel.GetValue().toString());}

            function OncmbMetaComponenteChanged(cmbMetaComponente) {ASPxGridViewIndicadoresDeMeta.PerformCallback(cmbMetaComponente.GetValue().toString());}

            function OncmbComponentePChanged(cmbComponenteP) {cmbMetaComponenteP.PerformCallback(cmbComponenteP.GetValue().toString());}

            function OncmbMetaComponentePChanged(cmbMetaComponenteP) {cmbIndicadoresP.PerformCallback(cmbMetaComponenteP.GetValue().toString());}

            function OncmbIndicadorPChanged(cmbIndicadoresP) {ASPxGridView1.PerformCallback(cmbIndicadoresP.GetValue().toString());}

            function OncmbComponenteInstitucionChanged(cmbComponenteInstitucion) {cmbMetaComponenteInstitucion.PerformCallback(cmbComponenteInstitucion.GetValue().toString());}

            function OncmbMetaComponenteInstitucionChanged(cmbMetaComponenteInstitucion) {cmbIndicadoresInstitucion.PerformCallback(cmbMetaComponenteInstitucion.GetValue().toString());}

            function OncmbIndicadorInstitucionChanged(cmbIndicadoresInstitucion) {GridInstitucionMeta.PerformCallback(cmbIndicadoresInstitucion.GetValue().toString());}
            
            function OnTabChanged(Tab) {
                cmbComponenteI.PerformCallback();
       
            }

        </script>


        

            <dx:ASPxLabel ID="ASPxLabelPolitica" runat="server"></dx:ASPxLabel>
        
            <dx:ASPxPageControl ID="carTabPage" ClientInstanceName="carTabPage" runat="server" ActiveTabIndex="0" EnableHierarchyRecreation="True" Height="800%" Width="100%" EnableViewState="false" >
           
             <ClientSideEvents ActiveTabChanged="function (s,e) {click(e);}" />
    <TabPages >
        
        <%-- ############################################################################################################################################################ --%>
        <dx:TabPage Text="Componentes o Ejes"   >

            <ContentCollection> 
            <dx:ContentControl> 
                
                <dx:ASPxButton ID="ASPxButtonRepartirComponentesPesos" runat="server" Text="Repartir Equitativamente" OnClick="ASPxButtonRepartirComponentesPesos_Click"></dx:ASPxButton>
                <br />

                <dx:ASPxGridView ID="ASPxGridViewComponentes" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSourceComponentes" 
                      KeyFieldName="IdComponentesDePolitica" Settings-ShowFooter="True" OnRowDeleted="ASPxGridViewComponentes_RowDeleted" OnRowInserted="ASPxGridViewComponentes_RowInserted" 
                      SettingsBehavior-AllowFocusedRow="True" ClientInstanceName="ASPxGridViewComponentes" OnRowUpdated="ASPxGridViewComponentes_RowUpdated" Width="100%" SettingsEditing-EditFormColumnCount="1" Settings-ShowFilterRow="true" OnLoad="ASPxGridViewComponentes_Load" Settings-ShowFilterRowMenu="true" >
                    <TotalSummary>
                        <dx:ASPxSummaryItem FieldName="Peso" SummaryType="Sum" Tag="Total"/>
                    </TotalSummary>
                    <Columns>
                        <dx:GridViewDataTextColumn FieldName="IdComponentesDePolitica" ReadOnly="True" VisibleIndex="0" Visible="false">
                            <EditFormSettings Visible="False"></EditFormSettings>
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn FieldName="IdPolitica" VisibleIndex="1" EditFormSettings-Visible="False" Visible="false">
                            <EditFormSettings Visible="False" />
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn FieldName="Nombre" VisibleIndex="2">
                            <Settings AutoFilterCondition="Contains" />
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn FieldName="Descripcion" VisibleIndex="3" Caption="Descripción">
                            <Settings AutoFilterCondition="Contains" />
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn FieldName="Peso" VisibleIndex="4">
                            <Settings AllowAutoFilter="False" />
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn FieldName="CreadoPor" VisibleIndex="5" Visible="false"></dx:GridViewDataTextColumn>
                        <dx:GridViewDataDateColumn FieldName="FechaCreacion" VisibleIndex="6" Visible="false"></dx:GridViewDataDateColumn>
                        <dx:GridViewDataTextColumn FieldName="ActualizadoPor" VisibleIndex="7" Visible="false"></dx:GridViewDataTextColumn>
                        <dx:GridViewDataDateColumn FieldName="FechaActualizacion" VisibleIndex="8" Visible="false"></dx:GridViewDataDateColumn>
                        <dx:GridViewDataCheckColumn FieldName="Activo" VisibleIndex="9" Visible="false"></dx:GridViewDataCheckColumn>
                        <dx:GridViewCommandColumn VisibleIndex="7" HeaderStyle-HorizontalAlign="Center" Caption="Acción" CellStyle-HorizontalAlign="NotSet">

                                <NewButton Visible="True" />
                                <EditButton Visible="true" />
                                <DeleteButton Visible="true" />

                                <HeaderStyle HorizontalAlign="Center" />

                        </dx:GridViewCommandColumn>
                    </Columns>
                    <SettingsPager>
                       <AllButton Visible="True" Text="Todos">
                       </AllButton>
                    </SettingsPager>


                    <ClientSideEvents EndCallback =" function(s,e) { if (s.cp_Arg == 'Not100') {s.cp_Arg='';} else {if (s.cp_Arg == 'Is100'){s.cp_Arg=''; }}} " />

                    <SettingsBehavior AllowFocusedRow="True"></SettingsBehavior>

                    <Settings ShowFooter="True"></Settings>
                </dx:ASPxGridView>

                <dx:ASPxLabel ID="ASPxLabelError" runat="server" ClientInstanceName="ASPxLabelError" Text="La suma de los pesos debería ser 100" Visible="false" ></dx:ASPxLabel>

                <asp:SqlDataSource runat="server" ID="SqlDataSourceComponentes" OnInserted="SqlDataSourceComponentes_Inserted" ConnectionString='<%$ ConnectionStrings:SUEPPSConnectionString %>'     
                    SelectCommand="SELECT * FROM [ComponentesDePolitica] WHERE [IdPolitica]=@IdPoliticaP AND [Activo]=1" 
                    InsertCommand="INSERT INTO [ComponentesDePolitica] ([IdPolitica], [Nombre], [Descripcion], [Peso], [CreadoPor], [FechaCreacion], [Activo]) VALUES(@IdPoliticaP, @Nombre, @Descripcion, @Peso, @Usuario, getDate(), 1)"
                    UpdateCommand="UPDATE [ComponentesDePolitica] SET [Nombre]=@Nombre, [Descripcion]=@Descripcion, [Peso]=@Peso, [ActualizadoPor]=@Actualizado, [FechaActualizacion]=getDate(), [Activo]=1 WHERE [IdComponentesDePolitica]=@IdCOmponentesDePolitica" 
                    DeleteCommand="UPDATE [ComponentesDePolitica] SET [Activo]=0 WHERE [IdComponentesDePolitica]=@IdCOmponentesDePolitica" 
                    >
                    <SelectParameters>
                        <asp:SessionParameter SessionField="IdPoliticaP" Name="IdPoliticaP" Type="Int32"></asp:SessionParameter>
                    </SelectParameters>

                    <InsertParameters>
                        <asp:FormParameter Name="Nombre" />
                        <asp:FormParameter Name="Descripcion" />
                        <asp:FormParameter Name="Peso" />
                        <asp:SessionParameter SessionField="IdPoliticaP" Name="IdPoliticaP" Type="Int32"></asp:SessionParameter>
                        <asp:SessionParameter Name="Usuario" />
                    </InsertParameters>

                    <UpdateParameters>
                        <asp:FormParameter Name="Nombre" />
                        <asp:FormParameter Name="Descripcion" />
                        <asp:FormParameter Name="Peso" />
                        <asp:SessionParameter Name="Actualizado" />
                    </UpdateParameters>
                    
                </asp:SqlDataSource>
                
                <asp:SqlDataSource ID="SqlDataSourceComponentesCambiarPesos" runat="server" ConnectionString='<%$ ConnectionStrings:SUEPPSConnectionString %>'>

                </asp:SqlDataSource>
            </dx:ContentControl>
            </ContentCollection>
        </dx:TabPage>

        <%-- ####################################################################################################################################################### --%>

        <dx:TabPage Text="Metas">
            <ContentCollection> 
            <dx:ContentControl>
             <table >
             <tr>   
                <td>
                    <dx:aspxlabel runat="server" text="Componente:" id="ComponenteLabel" associatedcontrolid="CmbComponente" />
                </td>
                <td>
                    <dx:ASPxComboBox ID="CmbComponente" runat="server" ValueField="IdComponentesDePolitica" OnCallback="CmbComponente_Callback"
                    TextField="Nombre" ValueType="System.String" DataSourceID="SqlDataSourceComponentes" EnableClientSideAPI="true" ClientInstanceName="CmbComponente">

                    <ClientSideEvents SelectedIndexChanged="function(s, e) { oncombocomponente(s); }"> </ClientSideEvents>
              </dx:ASPxComboBox>
                

                </td>
            </tr>
            </table>

                <br />

                <asp:SqlDataSource ID="SqlDataSourceMetasCambiarPesos" runat="server" ConnectionString='<%$ ConnectionStrings:SUEPPSConnectionString %>' SelectCommand="SELECT [IdMetasDeComponente], [Peso] FROM [MetasDeComponente]"></asp:SqlDataSource>

                <dx:ASPxButton ID="ASPxButtonRepartirPesosMetas" runat="server" Text="Repartir Equitativamente" OnClick="ASPxButtonRepartirPesosMetas_Click"></dx:ASPxButton>
                <br />

                <dx:ASPxGridView ID="ASPxGridViewMetas" runat="server" ClientInstanceName="ASPxGridViewMetas"  AutoGenerateColumns ="False" DataSourceID="SqlDataSourceMetas" 
                    KeyFieldName="IdMetasDeComponente" OnCustomCallback="grid_custom" Settings-ShowFooter="true" 
                    OnRowUpdated="ASPxGridViewMetas_RowUpdated" OnRowDeleted="ASPxGridViewMetas_RowDeleted" OnRowInserted="ASPxGridViewMetas_RowInserted" Width="100%" SettingsEditing-EditFormColumnCount="1" Settings-ShowFilterRow="true" OnLoad="ASPxGridViewMetas_Load" Settings-ShowFilterRowMenu="true">
                    <TotalSummary>
                        <dx:ASPxSummaryItem FieldName="Peso" SummaryType="Sum" Tag="Total"/>
                    </TotalSummary>
                    <Columns>
                        <dx:GridViewDataTextColumn FieldName="IdMetasDeComponente" ReadOnly="True" VisibleIndex="0" Visible="false">
                            <EditFormSettings Visible="False"></EditFormSettings>
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn FieldName="IdComponentesDePolitica" VisibleIndex="1" EditFormSettings-Visible="False" Visible="false">
                        <EditFormSettings Visible="False"></EditFormSettings>
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn FieldName="Nombre" VisibleIndex="2">
                            <Settings AutoFilterCondition="Contains" />
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn FieldName="Descripcion" VisibleIndex="3" Caption="Descripción">
                            <Settings AutoFilterCondition="Contains" />
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn FieldName="Peso" VisibleIndex="4">
                            <Settings AllowAutoFilter="False" />
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn FieldName="CreadoPor" VisibleIndex="5" Visible="false"></dx:GridViewDataTextColumn>
                        <dx:GridViewDataDateColumn FieldName="FechaCreacion" VisibleIndex="6" Visible="false"></dx:GridViewDataDateColumn>
                        <dx:GridViewDataTextColumn FieldName="ActualizadoPor" VisibleIndex="7" Visible="false"></dx:GridViewDataTextColumn>
                        <dx:GridViewDataDateColumn FieldName="FechaActualizacion" VisibleIndex="8" Visible="false"></dx:GridViewDataDateColumn>
                        <dx:GridViewDataCheckColumn FieldName="Activo" VisibleIndex="9" Visible="false"></dx:GridViewDataCheckColumn>
                        <dx:GridViewCommandColumn VisibleIndex="7" HeaderStyle-HorizontalAlign="Center" Caption="Acción" CellStyle-HorizontalAlign="NotSet">

                                <NewButton Visible="True" />
                                <EditButton Visible="true" />
                                <DeleteButton Visible="true" />

                        <HeaderStyle HorizontalAlign="Center"></HeaderStyle>

                        </dx:GridViewCommandColumn>
                    </Columns>
                    <SettingsPager>
                                                        <AllButton Visible="True" Text="Todos">
                                                        </AllButton>
                                                    </SettingsPager>
                    <ClientSideEvents EndCallback =" function(s,e) { if (s.cp_Arg == 'Not100') {s.cp_Arg='';} else {if (s.cp_Arg == 'Is100'){s.cp_Arg=''; }}} " />
                </dx:ASPxGridView>


                <asp:SqlDataSource runat="server" ID="SqlDataSourceMetas" ConnectionString='<%$ ConnectionStrings:SUEPPSConnectionString %>' 
                    SelectCommand="SELECT * FROM [MetasDeComponente] WHERE [Activo]=1 AND [IdComponentesDePolitica]=@IdComponenteP"
                    InsertCommand="INSERT INTO [MetasDeComponente] ([IdComponentesDePolitica], [Nombre], [Descripcion], [Peso], [CreadoPor], [FechaCreacion], [Activo]) VALUES (@IdComponenteP, @Nombre, @Descripcion, @Peso, @Usuario, getDate(), 1)  "
                    UpdateCommand="UPDATE [MetasDeComponente] SET [Nombre]=@Nombre, [Descripcion]=@Descripcion, [Peso]=@Peso, [ActualizadoPor]=@Actualizado, [FechaActualizacion]=getDate() WHERE [IdMetasDeComponente]=@IdMetasDeComponente"
                    DeleteCommand="UPDATE [MetasDeComponente] SET [Activo]=0 WHERE [IdMetasDeComponente]=@IdMetasDeComponente"
                    >
                    <SelectParameters>
                        <asp:SessionParameter SessionField="IdComponenteP" Name="IdComponenteP" Type="Int32"></asp:SessionParameter>
                    </SelectParameters>

                    <InsertParameters>
                        <asp:FormParameter Name="Nombre" />
                        <asp:FormParameter Name="Descripcion" />
                        <asp:FormParameter Name="Peso" />
                        <asp:SessionParameter SessionField="IdComponenteP" Name="IdComponenteP" Type="Int32"></asp:SessionParameter>
                        <asp:SessionParameter Name="Usuario" />
                    </InsertParameters>

                    <UpdateParameters>
                        <asp:FormParameter Name="Nombre" />
                        <asp:FormParameter Name="Descripcion" />
                        <asp:FormParameter Name="Peso" />
                        <asp:SessionParameter Name="Actualizado" />
                    </UpdateParameters>
    

                </asp:SqlDataSource>
            </dx:ContentControl>
            </ContentCollection>
        </dx:TabPage>

        <%-- ####################################################################################################################################################### --%>

        <dx:TabPage Text="Indicadores">
            <ContentCollection> 
            <dx:ContentControl>
                <table width="100%">

                <tr>
                     <td>
                            <dx:ASPxLabel runat="server" Text="Componente:" ID="lblComponente" AssociatedControlID="cmbComponenteI" />
                            <dx:ASPxComboBox runat="server" id="cmbComponenteI" ClientInstanceName="cmbComponenteI" dropdownstyle="DropDownList" incrementalfilteringmode="StartsWith"
                                           datasourceid="SqlComponente" textfield="Nombre" valuefield="IdComponentesDePolitica" Width="100%"
                                           enablesynchronization="False" OnCallback="cmbComponenteI_Callback" >
                              <ClientSideEvents SelectedIndexChanged="function(s, e) { OncmbComponenteIChanged(s); }" />    
                            </dx:ASPxComboBox>

                            <asp:SqlDataSource ID="SqlComponente" runat="server" ConnectionString="<%$ ConnectionStrings:SUEPPSConnectionString %>" 
                                           SelectCommand ="SELECT IdComponentesDePolitica,Nombre FROM [ComponentesDePolitica] WHERE ([IdPolitica] = @p1) AND Activo=1" >
                                 <SelectParameters>
                                      <asp:SessionParameter Name="p1"  />
                                 </SelectParameters>    
                            </asp:SqlDataSource>
                       </td>

                       <td>

                             <dx:ASPxLabel runat="server" Text="Meta:" ID="lblMeta" AssociatedControlID="cmbMetaComponente" />
                             
                           <dx:ASPxComboBox runat="server" id="cmbMetaComponente" clientinstancename="cmbMetaComponente"  OnCallback="cmbMetaComponente_Callback"
                                        dropdownstyle="DropDown" datasourceid="SqlMetaComponente" textfield="Nombre" Width="100%"
                                        valuefield="IdMetasDeComponente" incrementalfilteringmode="StartsWith" enablesynchronization="False"> 
                                <ClientSideEvents SelectedIndexChanged="function(s, e) { OncmbMetaComponenteChanged(s); }" />
                              </dx:ASPxComboBox>       
                              
                           <asp:SqlDataSource ID="SqlMetaComponente" runat="server" ConnectionString="<%$ ConnectionStrings:SUEPPSConnectionString %>" 
                                        SelectCommand="SELECT IdMetasDeComponente,Nombre FROM [MetasDeComponente] WHERE ([IdComponentesDePolitica]=@p1 AND Activo=1)" >
                                   <SelectParameters>
                                        <asp:SessionParameter Name="p1"  />
     
                                   </SelectParameters>    
                              </asp:SqlDataSource>
                         </td>

                  </tr>

                  </table>

                 <br />
                  <table>

                

                  <tr>
                       <td>
                            <dx:ASPxLabel runat="server" Text="Sector:" ID="lblSector" AssociatedControlID="cmbsector" />
							<dx:ASPxComboBox ID="cmbsector" ClientInstanceName="cmbsector" runat="server" ValueField="IdSectorIndicador"
                                             TextField="DescripcionSectorIndicador"  DataSourceID="SqlSectorP" >
                                                                      
                            </dx:ASPxComboBox>

                            <asp:SqlDataSource ID="SqlSectorP" runat="server" ConnectionString="<%$ ConnectionStrings:SUEPPSConnectionString %>" SelectCommand="SELECT distinct([DescripcionSectorIndicador]),[IdSectorIndicador] FROM [vROISectorIndicadores]"> </asp:SqlDataSource>
                     
							<dx:ASPxLabel runat="server" Text="Nivel:" ID="lblNivel" AssociatedControlID="cmbNivel" />
                           
                           <dx:ASPxComboBox ID="cmbNivel" ClientInstanceName="cmbNivel" TextField="DescripcionTipoDeIndicador" ValueField="NivelTipoDeIndicador" runat="server" DataSourceID="SqlDataSourceTiposIndicadores">

                               <ClientSideEvents SelectedIndexChanged="function(s, e) { OncmbNivelChanged(s); }" />
                           </dx:ASPxComboBox>


                           <asp:SqlDataSource runat="server" ID="SqlDataSourceTiposIndicadores" ConnectionString='<%$ ConnectionStrings:SUEPPSConnectionString %>' 
                               SelectCommand="SELECT [DescripcionTipoDeIndicador], [IdTipoDeIndicador], [NivelTipoDeIndicador] FROM [TiposDeIndicador] WHERE ([NivelTipoDeIndicador] = 2 OR [NivelTipoDeIndicador] = 3) and Activo=1"></asp:SqlDataSource>

                           <asp:SqlDataSource runat="server" ID="SqlDataSourceIndicadoresCombo" ConnectionString='<%$ ConnectionStrings:SUEPPSConnectionString %>' 
                               SelectCommand="SELECT * FROM [Indicadores] where Activo=1"></asp:SqlDataSource>
                           
                           <asp:SqlDataSource runat="server" ID="SqlDataSourceMetaCombo" ConnectionString='<%$ ConnectionStrings:SUEPPSConnectionString %>' 
                               SelectCommand="SELECT [IdMetasDeComponente], [Nombre] FROM [MetasDeComponente] where Activo=1"></asp:SqlDataSource>
                               

                       </td>


                        <td rowspan="2">
                                                        <%--GridGrande--%>
                            <asp:SqlDataSource ID="SqlDataSourceIndicadoresCambiarPesos" runat="server" ConnectionString='<%$ ConnectionStrings:SUEPPSConnectionString %>' 
                            SelectCommand="SELECT [IdIndicadorDeMeta], [Peso] FROM [IndicadoresDeMeta]"></asp:SqlDataSource>
                            
                            <dx:ASPxButton ID="ASPxButtonRepartirPesosIndicadores" runat="server" Text="Repartir Equitativamente" OnClick="ASPxButtonRepartirPesosIndicadores_Click"></dx:ASPxButton>
                            <br />

                            <dx:ASPxGridView ID="ASPxGridViewIndicadoresDeMeta" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSourceIndicadoresDeMeta" 
                            KeyFieldName="IdIndicadorDeMeta" OnCustomCallback="ASPxGridViewIndicadoresDeMeta_CustomCallback" ClientInstanceName="ASPxGridViewIndicadoresDeMeta" Settings-ShowFilterRow="true" OnLoad="ASPxGridViewIndicadoresDeMeta_Load" Settings-ShowFilterRowMenu="true"
                             Settings-ShowFooter="true" OnRowUpdated="ASPxGridViewIndicadoresDeMeta_RowUpdated">
                                <TotalSummary>
                                    <dx:ASPxSummaryItem FieldName="Peso" SummaryType="Sum" Tag="Total"/>
                                </TotalSummary>

                                <Columns>
                                    <dx:GridViewDataTextColumn FieldName="IdIndicadorDeMeta" ReadOnly="True" VisibleIndex="0" Visible="false">
                                        <EditFormSettings Visible="False"></EditFormSettings>
                                    </dx:GridViewDataTextColumn>
                                    
                                   
                                    <dx:GridViewDataComboBoxColumn VisibleIndex="1" FieldName="IdMetasDeComponente" Caption="Meta" Visible="false">
                                        <PropertiesComboBox ValueType="System.String" 
                
                                                DataSourceID="SqlDataSourceMetaCombo" 
                                                ValueField="IdMetasDeComponente" 
                                                TextField="Nombre"/>
     
                                        
                                    </dx:GridViewDataComboBoxColumn>

                                    

                                    <dx:GridViewDataTextColumn VisibleIndex="2" FieldName="IdIndicador" Caption="#" ReadOnly="true">
                                            <EditFormSettings Visible="False"></EditFormSettings>
                                        <Settings AllowAutoFilter="False" />
                                    </dx:GridViewDataTextColumn>

                                    <dx:GridViewDataComboBoxColumn VisibleIndex="2" FieldName="IdIndicador" Caption="Indicador">
                                                                    <PropertiesComboBox ValueType="System.String" 
                
                                                                        DataSourceID="SqlDataSourceIndicadoresComboGrid" 
                                                                        ValueField="IdIndicador" 
                                                                        TextField="DescripcionIndicador"/>

                                                                    <Settings AllowAutoFilter="True" />
                                    <Settings AutoFilterCondition="Contains" />
                                    <Settings FilterMode="DisplayText" />
     
                    
                                                                  </dx:GridViewDataComboBoxColumn>
                                    <dx:GridViewDataTextColumn FieldName="Peso" VisibleIndex="3" Visible="true">
                                        <Settings AllowAutoFilter="False" />
                                    </dx:GridViewDataTextColumn>
                                    <dx:GridViewDataTextColumn FieldName="CreadoPor" VisibleIndex="4" Visible="false"><EditFormSettings Visible="False" /></dx:GridViewDataTextColumn>
                                    <dx:GridViewDataDateColumn FieldName="FechaCreacion" VisibleIndex="5" Visible="false"><EditFormSettings Visible="False" /></dx:GridViewDataDateColumn>
                                    <dx:GridViewDataTextColumn FieldName="ActualizadoPor" VisibleIndex="6" Visible="false"><EditFormSettings Visible="False" /></dx:GridViewDataTextColumn>
                                    <dx:GridViewDataDateColumn FieldName="FechaActualizacion" VisibleIndex="7" Visible="false"><EditFormSettings Visible="False" /></dx:GridViewDataDateColumn>
                                    <dx:GridViewDataCheckColumn FieldName="Activo" VisibleIndex="8" Visible="false"><EditFormSettings Visible="False" /></dx:GridViewDataCheckColumn>
                                    <dx:GridViewCommandColumn Caption="Acción"  VisibleIndex="9">
                                        <EditButton Text="Editar" Visible="true">
                                        </EditButton>
                                        <UpdateButton Text="Actualizar" Visible="true"></UpdateButton>
                                        <DeleteButton Visible="True"></DeleteButton>
                                    </dx:GridViewCommandColumn>
                                </Columns>
                                <SettingsPager>
                                                        <AllButton Visible="True" Text="Todos">
                                                        </AllButton>
                                                    </SettingsPager>
                                <ClientSideEvents EndCallback =" function(s,e) { if (s.cp_Arg == 'Not100') {s.cp_Arg='';} else {if (s.cp_Arg == 'Is100'){s.cp_Arg=''; }}} " />
                            </dx:ASPxGridView>

                            <asp:SqlDataSource ID="SqlDataSourceIndicadoresComboGrid" runat="server" ConnectionString='<%$ ConnectionStrings:SUEPPSConnectionString %>'
                             SelectCommand="SELECT i.[IdIndicador], i.[DescripcionIndicador] FROM [Indicadores] i, [IndicadoresDeMeta] im WHERE i.[IdIndicador] = im.[IdIndicador]"> 
                                
                            </asp:SqlDataSource>

                            <asp:SqlDataSource runat="server" ID="SqlDataSourceIndicadoresDeMeta" ConnectionString='<%$ ConnectionStrings:SUEPPSConnectionString %>'  

                                SelectCommand="SELECT [IndicadoresDeMeta].*, DescripcionIndicador FROM [IndicadoresDeMeta] JOIN [Indicadores] ON [IndicadoresDeMeta].[IdIndicador]=[Indicadores].[IdIndicador] WHERE [IdMetasDeComponente]=@IdMetaP AND [IndicadoresDeMeta].[Activo]=1 AND [Indicadores].Activo=1"
                                UpdateCommand="UPDATE [IndicadoresDeMeta] SET [Peso]=@Peso, [ActualizadoPor]=@Actualizado, [FechaActualizacion]= getDate() WHERE [IdIndicadorDeMeta]=@IdIndicadorDeMeta" OnUpdated="SqlDataSourceIndicadoresDeMeta_Updated"
                                DeleteCommand="UPDATE [IndicadoresDeMeta] SET [Activo]=0 WHERE [IdIndicadorDeMeta]=@IdIndicadorDeMeta">


                                <SelectParameters>
                                    <asp:SessionParameter Name="IdMetaP" /> 
                                                                
                                </SelectParameters>

                                <UpdateParameters>
                                    <asp:FormParameter Name="Peso" />
                                    <asp:SessionParameter Name="Actualizado" />
                                </UpdateParameters>
                                                            

                            </asp:SqlDataSource>
                                                            
                        </td>

                </tr>

                <tr>
                    <td colspan="1">
                        <dx:ASPxGridView ID="GridSectorNivelIndicador" runat="server" ClientInstanceName="GridSectorNivelIndicador" OnCustomCallback="GridSectorNivelIndicador_CustomCallback" AutoGenerateColumns="False" DataSourceID="SqlSectorNivelIndicador" KeyFieldName="IdIndicador" Settings-ShowFilterRow="true" OnLoad="GridSectorNivelIndicador_Load" Settings-ShowFilterRowMenu="true">
                            <Columns>
                                <dx:GridViewDataTextColumn FieldName="IdIndicador" ReadOnly="True" ShowInCustomizationForm="True" Visible="false" VisibleIndex="0" Caption="Id">
                                    <EditFormSettings Visible="False" />
                                </dx:GridViewDataTextColumn>
                                <dx:GridViewDataTextColumn FieldName="IdSectorIndicador" ShowInCustomizationForm="True" Visible="false" VisibleIndex="1">
                                </dx:GridViewDataTextColumn>
                                <dx:GridViewDataTextColumn FieldName="DescripcionIndicador" ShowInCustomizationForm="True" Visible="true" VisibleIndex="2" Caption="Descripción">
                                <Settings AutoFilterCondition="Contains" />
                                </dx:GridViewDataTextColumn>
                                <dx:GridViewDataTextColumn FieldName="NivelTipoDeIndicador" ShowInCustomizationForm="True"  Visible="true" VisibleIndex="3" Caption="Nivel">
                                        <Settings AllowAutoFilter="False" />
                                
                                </dx:GridViewDataTextColumn>
                                    <dx:GridViewDataTextColumn FieldName="Acciones"  Caption="Acción"  ShowInCustomizationForm="True" VisibleIndex="4" UnboundType="String">
                                                        <DataItemTemplate>
                                                        <dx:ASPxHyperLink runat="server"></dx:ASPxHyperLink>

                                                        <asp:LinkButton id="link1"  Text="Agregar" runat="server" OnClick="link1_Click"></asp:LinkButton> 
                                                            </DataItemTemplate> 
                                        <Settings AllowAutoFilter="False" />

                                    </dx:GridViewDataTextColumn> 

                            </Columns>
                            <SettingsPager>
                                                        <AllButton Visible="True" Text="Todos">
                                                        </AllButton>
                                                    </SettingsPager>
                            <SettingsBehavior AllowFocusedRow="True" />
                        </dx:ASPxGridView>

                        <asp:SqlDataSource ID="SqlSectorNivelIndicador" runat="server" ConnectionString="<%$ ConnectionStrings:SUEPPSConnectionString %>" 
                            SelectCommand="SELECT I.[IdIndicador], I.[IdSectorIndicador], I.[DescripcionIndicador], TI.[NivelTipoDeIndicador] FROM [Indicadores] I join [TiposDeIndicador] TI on I.IdTipoDeIndicador = TI.IdTipoDeIndicador  where I.IdSectorIndicador=@p1 and TI.NivelTipoDeIndicador=@p2 and I.Activo=1 ">
                            <SelectParameters>
                                <asp:SessionParameter Name="p1"  />
                                <asp:SessionParameter Name="p2"  />
                                </SelectParameters>    
                            </asp:SqlDataSource>
                                                       

                    </td>
                </tr>
            </table>

            </dx:ContentControl>
            </ContentCollection>
        </dx:TabPage>
        <%-- ####################################################################################################################################################### --%>
        <dx:TabPage Text="Programas">
            <ContentCollection> 
            <dx:ContentControl>

                <dx:ASPxPanel runat="server" ScrollBars="Vertical" Width="100%">

                    <PanelCollection>
                        <dx:PanelContent>

                            <table width="100%">

                                <tr>
                                    <td>

                                       <dx:ASPxLabel runat="server" Text="Componente:" ID="lblComponenteP" AssociatedControlID="cmbComponenteP" />
                        <dx:ASPxComboBox runat="server" id="cmbComponenteP" ClientInstanceName="cmbComponenteP" dropdownstyle="DropDownList" incrementalfilteringmode="StartsWith"
                            datasourceid="SqlComponenteP" textfield="Nombre" OnCallback="cmbComponenteP_Callback" valuefield="IdComponentesDePolitica" Width="100%"
                            enablesynchronization="False">
                            <ClientSideEvents SelectedIndexChanged="function(s, e) { OncmbComponentePChanged(s); }" />    
                        </dx:ASPxComboBox>
                       <asp:SqlDataSource ID="SqlComponenteP" runat="server" ConnectionString="<%$ ConnectionStrings:SUEPPSConnectionString %>" 
                    SelectCommand ="SELECT IdComponentesDePolitica,Nombre FROM [ComponentesDePolitica] WHERE ([IdPolitica] = @p1) AND Activo=1" >
                        <SelectParameters>
                        <asp:SessionParameter Name="p1"  />
                        </SelectParameters>    
                    </asp:SqlDataSource>
                                    </td>
                                </tr>

                                <tr>
                                    <td>
<dx:ASPxLabel runat="server" Text="Meta:" ID="lblMetaP" AssociatedControlID="cmbMetaComponenteP" />
                        <dx:ASPxComboBox runat="server" id="cmbMetaComponenteP" clientinstancename="cmbMetaComponenteP"  OnCallback="cmbMetaComponenteP_Callback"
                            dropdownstyle="DropDown" datasourceid="SqlMetaComponenteP" textfield="Nombre" Width="100%"
                            valuefield="IdMetasDeComponente" incrementalfilteringmode="StartsWith" enablesynchronization="False"> 
                                <ClientSideEvents SelectedIndexChanged="function(s, e) { OncmbMetaComponentePChanged(s); }" />
                        </dx:ASPxComboBox> 
                       <asp:SqlDataSource ID="SqlMetaComponenteP" runat="server" ConnectionString="<%$ ConnectionStrings:SUEPPSConnectionString %>" 
                                 SelectCommand="SELECT IdMetasDeComponente,Nombre FROM [MetasDeComponente] WHERE ([IdComponentesDePolitica]=@p1 AND Activo=1)" >
                                <SelectParameters>
                                <asp:SessionParameter Name="p1"  />
     
                                </SelectParameters>    
                        </asp:SqlDataSource>
                                    </td>
                                </tr>

                                <tr>
                                    <td>
                                        <dx:ASPxLabel runat="server" Text="Indicadores:" ID="lblIndicadores" AssociatedControlID="cmbIndicadoresP" />

                        <dx:ASPxComboBox runat="server" id="cmbIndicadoresP" clientinstancename="cmbIndicadoresP"  OnCallback="cmbIndicadoresP_Callback"
                            dropdownstyle="DropDown" datasourceid="SqlIndicadoresP" textfield="DescripcionIndicador" Width="100%"
                            valuefield="IdIndicadorDeMeta" incrementalfilteringmode="StartsWith" enablesynchronization="False"> 
                                <ClientSideEvents SelectedIndexChanged="function(s, e) { OncmbIndicadorPChanged(s); }" />
                        </dx:ASPxComboBox>  
                    
                    <asp:SqlDataSource ID="SqlIndicadoresP" runat="server" ConnectionString="<%$ ConnectionStrings:SUEPPSConnectionString %>" SelectCommand="SELECT IM.[IdIndicadorDeMeta], I.[DescripcionIndicador] FROM [MetasDeComponente] MC join [IndicadoresDeMeta] IM on MC.IdMetasDeComponente = IM.IdMetasDeComponente join [Indicadores] I on IM.IdIndicador=I.IdIndicador join [TiposDeIndicador] TI on I.IdTipoDeIndicador=TI.IdTipoDeIndicador Where MC.IdMetasDeComponente=@p1 and (TI.NivelTipoDeIndicador=2 or TI.NivelTipoDeIndicador=3) and IM.Activo=1 and MC.Activo=1 and I.Activo= 1"   >
                            <SelectParameters>
                                <asp:SessionParameter Name="p1"  />
                            </SelectParameters>    
                        </asp:SqlDataSource>
                                    </td>
                                </tr>

                    </table>

                <br />


                <table>

                <tr>
                <td>
                                               <%-- pequeño --%>               
                    <dx:ASPxGridView ID="ASPxGridViewPrograma"  ClientInstanceName="ASPxGridViewPrograma"  runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSourceProgramas" KeyFieldName="codigo_ficha" Settings-ShowFilterRow="true" Settings-ShowFilterRowMenu="true">
                        <Columns>
                            <dx:GridViewDataTextColumn FieldName="NombreProyecto" ShowInCustomizationForm="True" VisibleIndex="0" Caption="Nombre del Proyecto/Programa">
                            <Settings AutoFilterCondition="Contains" />
                            </dx:GridViewDataTextColumn>
                            <dx:GridViewDataTextColumn FieldName="codigo_ficha" ShowInCustomizationForm="True" VisibleIndex="1" Visible ="false">
                            </dx:GridViewDataTextColumn>
                                                                
                            <dx:GridViewDataTextColumn>
                                <DataItemTemplate>

                                <asp:LinkButton ID="AgregarPrograma" Text="Agregar Programa" OnClick="AgregarPrograma_Click" runat="server"></asp:LinkButton>
                                </DataItemTemplate>
                            </dx:GridViewDataTextColumn>
                                                                    
                                                                
                        </Columns>
                         <SettingsPager>
                                                        <AllButton Visible="True" Text="Todos">
                                                        </AllButton>
                                                    </SettingsPager>
                            <SettingsBehavior AllowFocusedRow="True" />
                        <SettingsBehavior AllowFocusedRow="True" />
                    </dx:ASPxGridView>
          
                    <asp:SqlDataSource ID="SqlDataSourceProgramas" runat="server" ConnectionString="<%$ ConnectionStrings:SUEPPSConnectionString %>" SelectCommand="SELECT [NombreProyecto], [codigo_ficha] FROM [vProyectos]"></asp:SqlDataSource>
          
                        <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:SUEPPSConnectionString %>" OnInserted="SqlDataSource1_Inserted">
                            <InsertParameters>
                                <asp:Parameter Direction="Output" Name="IdProgramaIndicadorMeta" Type="Int32" />
                            </InsertParameters>
                                                             

                        </asp:SqlDataSource>

                        <asp:SqlDataSource ID="SqlIndicadoresRelevantes" runat="server" ConnectionString="<%$ ConnectionStrings:SUEPPSConnectionString %>" ></asp:SqlDataSource>

                </td>

                         <asp:SqlDataSource ID="SqlDataSourceProyectosCombo" runat="server" ConnectionString="<%$ ConnectionStrings:SUEPPSConnectionString %>" 
                             SelectCommand ="SELECT [codigo_ficha], [NombreProyecto] from vProyectos"
                             ></asp:SqlDataSource>

                        <asp:SqlDataSource ID="SqlDataSourceIndicadorMetaCombo" runat="server" ConnectionString="<%$ ConnectionStrings:SUEPPSConnectionString %>" 
                             SelectCommand ="SELECT m.[IdIndicadorDeMeta], i.[DescripcionIndicador] from [Indicadores] i, [IndicadoresDeMeta] m WHERE i.[IdIndicador] = m.[IdIndicador] and i.Activo=1"
                             ></asp:SqlDataSource>
                <td rowspan="2">
                    <%--GridGrande--%>

                    <asp:SqlDataSource ID="SqlDataSourceProgramasCambiarPesos" runat="server" ConnectionString='<%$ ConnectionStrings:SUEPPSConnectionString %>' 
                        SelectCommand="SELECT [IdProgramasPorIndicadorDeMeta], [Peso] FROM [ProgramasPorIndicadorDeMeta]"></asp:SqlDataSource>
                    
                    <dx:ASPxButton ID="ASPxButtonRepartirProgramas" runat="server" Text="Repartir Equitativamente" OnClick="ASPxButtonRepartirProgramas_Click"></dx:ASPxButton>
                    
                    <br />

                    <dx:ASPxGridView ID="ASPxGridView1" ClientInstanceName="ASPxGridView1"  runat="server" AutoGenerateColumns="False" Settings-ShowFilterRowMenu="true"
                        DataSourceID="SqlDataSourceProgramasGrid" KeyFieldName="IdProgramasPorIndicadorDeMeta" SettingsDetail-ShowDetailRow="true" OnRowInserted="ASPxGridView1_RowInserted"  OnRowUpdated="ASPxGridView1_RowUpdated" Settings-ShowFilterRow="true" OnLoad="ASPxGridView1_Load"
                        OnCustomCallback="ASPxGridView1_CustomCallback" Settings-ShowFooter="true">
                        <TotalSummary>
                            <dx:ASPxSummaryItem FieldName="Peso" SummaryType="Sum" />
                        </TotalSummary>
                        <Columns>
                            <dx:GridViewDataTextColumn FieldName="IdProgramasPorIndicadorDeMeta" ReadOnly="True" VisibleIndex="0" Caption="#">
                                <EditFormSettings Visible="False"></EditFormSettings>
                                        <Settings AllowAutoFilter="False" />

                            </dx:GridViewDataTextColumn>
                          
                            <dx:GridViewDataComboBoxColumn VisibleIndex="1" FieldName="IdPrograma" Caption="Proyecto">
                                        <PropertiesComboBox ValueType="System.String" 
                
                                                DataSourceID="SqlDataSourceProyectosCombo" 
                                                ValueField="codigo_ficha" 
                                                TextField="NombreProyecto"/>
                                <Settings AllowAutoFilter="True" />
                                    <Settings AutoFilterCondition="Contains" />
                                    <Settings FilterMode="DisplayText" />
     
                    
                             </dx:GridViewDataComboBoxColumn>

                           
                             <dx:GridViewDataComboBoxColumn VisibleIndex="1" FieldName="IdIndicadorDeMeta" Caption="Indicador" Visible="false">
                                        <PropertiesComboBox ValueType="System.String" 
                
                                                DataSourceID="SqlDataSourceIndicadorMetaCombo" 
                                                ValueField="IdIndicadorDeMeta" 
                                                TextField="DescripcionIndicador"/>
     
                    
                             </dx:GridViewDataComboBoxColumn>

                            <dx:GridViewDataTextColumn FieldName="Peso" VisibleIndex="3">
                                        <Settings AllowAutoFilter="False" />

                            </dx:GridViewDataTextColumn>
                            <dx:GridViewDataTextColumn FieldName="CreadoPor" VisibleIndex="4" Visible="false"></dx:GridViewDataTextColumn>
                            <dx:GridViewDataDateColumn FieldName="FechaCreacion" VisibleIndex="5" Visible="false"></dx:GridViewDataDateColumn>
                            <dx:GridViewDataTextColumn FieldName="ActualizadoPor" VisibleIndex="6" Visible="false"></dx:GridViewDataTextColumn>
                            <dx:GridViewDataDateColumn FieldName="FechaActualizacion" VisibleIndex="7" Visible="false"></dx:GridViewDataDateColumn>
                            <dx:GridViewDataCheckColumn FieldName="Activo" VisibleIndex="8" Visible="false"></dx:GridViewDataCheckColumn>
                            <dx:GridViewCommandColumn Caption ="Acción" VisibleIndex="9">
                                                            <EditButton Visible="true"></EditButton>
                                                            <DeleteButton Visible="true"></DeleteButton>
                                                           
                            </dx:GridViewCommandColumn>
                            </Columns>
                         <SettingsPager>
                                                        <AllButton Visible="True" Text="Todos">
                                                        </AllButton>
                                                    </SettingsPager>
                            <SettingsBehavior AllowFocusedRow="True" />
                            <ClientSideEvents EndCallback =" function(s,e) { if (s.cp_Arg == 'Not100') {s.cp_Arg='';} else {if (s.cp_Arg == 'Is100'){s.cp_Arg=''; }}} " />
                        <Settings ShowFooter="True"></Settings>

                        <SettingsDetail ShowDetailRow="true" AllowOnlyOneMasterRowExpanded="true" />
                        <SettingsBehavior AllowFocusedRow="true" />
                        <Templates>
                            <DetailRow >
                                
                                <dx:ASPxGridView ID="ASPxGridView2" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSourceRelevantesGrid"
                                 KeyFieldName="IdIndicadoresRelevantesDePrograma" Visible="true" OnBeforePerformDataSelect="ASPxGridView2_BeforePerformDataSelect" 
                                 Settings-ShowFooter="true" OnRowUpdated="ASPxGridView2_RowUpdated" Settings-ShowFilterRow="true" Settings-ShowFilterRowMenu="true"
>                                       <TotalSummary>
                                            <dx:ASPxSummaryItem FieldName="Peso" SummaryType="Sum" />
                                        </TotalSummary>
                                    <Columns>
                                        <dx:GridViewDataTextColumn FieldName="IdIndicadoresRelevantesDePrograma" ReadOnly="True" ShowInCustomizationForm="True" VisibleIndex="0" Visible="false">
                                            <EditFormSettings Visible="False" />
                                        </dx:GridViewDataTextColumn>
                                        <dx:GridViewDataTextColumn FieldName="DescripcionIndicador" ShowInCustomizationForm="True" VisibleIndex="1" Caption="Indicador">
                                        </dx:GridViewDataTextColumn>
                                        <dx:GridViewDataTextColumn FieldName="IdProgramaPorIndicadorDeMeta" ShowInCustomizationForm="True" VisibleIndex="2" Visible="false">
                                        </dx:GridViewDataTextColumn>
                                        <dx:GridViewDataTextColumn FieldName="IdIndicadoresPorPrograma" ShowInCustomizationForm="True" VisibleIndex="3" Visible="false">
                                        </dx:GridViewDataTextColumn>
                                        <dx:GridViewDataTextColumn FieldName="Peso" ShowInCustomizationForm="True" VisibleIndex="4">
                                        </dx:GridViewDataTextColumn>
                                        <dx:GridViewDataTextColumn FieldName="CreadoPor" ShowInCustomizationForm="True" VisibleIndex="5" Visible="false">
                                        </dx:GridViewDataTextColumn>
                                        <dx:GridViewDataDateColumn FieldName="FechaCreacion" ShowInCustomizationForm="True" VisibleIndex="6" Visible="false">
                                        </dx:GridViewDataDateColumn>
                                        <dx:GridViewDataTextColumn FieldName="ActualizadoPor" ShowInCustomizationForm="True" VisibleIndex="7" Visible="false">
                                        </dx:GridViewDataTextColumn>
                                        <dx:GridViewDataDateColumn FieldName="FechaActualizacion" ShowInCustomizationForm="True" VisibleIndex="8" Visible="false">
                                        </dx:GridViewDataDateColumn>
                                        <dx:GridViewDataCheckColumn FieldName="Activo" ShowInCustomizationForm="True" VisibleIndex="9" Visible="false">
                                        </dx:GridViewDataCheckColumn>
                                        <dx:GridViewCommandColumn Caption ="Acción" VisibleIndex="9">
                                                            <EditButton Visible="true"></EditButton>

                                                           
                                        </dx:GridViewCommandColumn>
                                    </Columns>
                                     <SettingsPager>
                                                        <AllButton Visible="True" Text="Todos">
                                                        </AllButton>
                                                    </SettingsPager>
                            <SettingsBehavior AllowFocusedRow="True" />
                                    <ClientSideEvents EndCallback =" function(s,e) { if (s.cp_Arg == 'Not100') {s.cp_Arg='';} else {if (s.cp_Arg == 'Is100'){s.cp_Arg=''; }}} " />
                                </dx:ASPxGridView>
                            </DetailRow>
                        </Templates>
                    </dx:ASPxGridView>


                    <asp:SqlDataSource runat="server" ID="SqlDataSourceRelevantesGrid" ConnectionString='<%$ ConnectionStrings:SUEPPSConnectionString %>' 
                        SelectCommand="SELECT * FROM [IndicadoresRelevantesDePrograma] JOIN [IndicadoresPorPrograma] ON [IndicadoresPorPrograma].[IdIndicadoresPorPrograma]=[IndicadoresRelevantesDePrograma].[IdIndicadoresPorPrograma] JOIN [Indicadores] ON [IndicadoresPorPrograma].[IdIndicador]=[Indicadores].[IdIndicador] WHERE ([IdProgramaPorIndicadorDeMeta] = @IdProgramaPorIndicadorDeMeta and [IndicadoresRelevantesDePrograma].[Activo]=1 and [IndicadoresPorPrograma].Activo=1 and [Indicadores].Activo=1)"
                        UpdateCommand="UPDATE [IndicadoresRelevantesDePrograma] SET Peso=@Peso WHERE IdIndicadoresRelevantesDePrograma=@IdIndicadoresRelevantesDePrograma">
                        <SelectParameters>
                            <asp:SessionParameter SessionField="IdProgramasPorIndicadorDeMeta" Name="IdProgramaPorIndicadorDeMeta" Type="Int32"></asp:SessionParameter>
                        </SelectParameters>
                    </asp:SqlDataSource>

                    <asp:SqlDataSource ID="SqlDataSourceRelevantesCambiarPeso" runat="server" ConnectionString='<%$ ConnectionStrings:SUEPPSConnectionString %>' 
                     SelectCommand="SELECT [IdIndicadoresRelevantesDePrograma], [Peso] FROM [IndicadoresRelevantesDePrograma] where Activo=1"></asp:SqlDataSource>

                    <asp:SqlDataSource runat="server" ID="SqlDataSourceProgramasGrid" ConnectionString='<%$ ConnectionStrings:SUEPPSConnectionString %>'  OnUpdated="SqlDataSourceProgramasGrid_Updated" 
                        SelectCommand="SELECT * FROM [ProgramasPorIndicadorDeMeta] PIM join [IndicadoresDeMeta] IM on PIM.IdIndicadorDeMeta = IM.IdIndicadorDeMeta WHERE  PIM.[IdIndicadorDeMeta]=@IdProMetaP AND PIM.[Activo] = 1"
                        UpdateCommand="UPDATE [ProgramasPorIndicadorDeMeta] SET Peso=@Peso WHERE IdProgramasPorIndicadorDeMeta=@IdProgramasPorIndicadorDeMeta" 
                        DeleteCommand="UPDATE [ProgramasPorIndicadorDeMeta] SET Activo = 0 WHERE IdProgramasPorIndicadorDeMeta=@IdProgramasPorIndicadorDeMeta"
                        >
                        <SelectParameters>
                            <asp:SessionParameter Name="IdProMetaP" SessionField="IdProMetaP" />
                        </SelectParameters>

                    </asp:SqlDataSource>
                                                    
                                                    
                </td>
            </tr>
            </table>

                        </dx:PanelContent>
                    </PanelCollection>

                </dx:ASPxPanel>
             
                

                    


                     
                   

                       
                         
                     
                                                 
                  

                           

                        
   
               

                
                   
            </dx:ContentControl>
            </ContentCollection>
        </dx:TabPage>
        <%-- ####################################################################################################################################################### --%>
        <dx:TabPage Text="Instituciones">
            <ContentCollection> 
            <dx:ContentControl>

                <dx:ASPxPanel runat="server" ScrollBars="Vertical" Width="100%">

                    <PanelCollection>
                        <dx:PanelContent>

                            <table width="100%">
                                <tr>
                                    <td>
                                        <dx:ASPxLabel runat="server" Text="Componente:" ID="ComponenteInstitucion" AssociatedControlID="cmbComponenteInstitucion" />
                        <dx:ASPxComboBox runat="server" id="cmbComponenteInstitucion" ClientInstanceName="cmbComponenteInstitucion" dropdownstyle="DropDownList" incrementalfilteringmode="StartsWith"
                            datasourceid="SqlComponenteInstitucion" textfield="Nombre" valuefield="IdComponentesDePolitica" OnCallback="cmbComponenteInstitucion_Callback"
                            enablesynchronization="False" Width="100%" >
                            <ClientSideEvents SelectedIndexChanged="function(s, e) { OncmbComponenteInstitucionChanged(s); }" />    
                        </dx:ASPxComboBox>
                        <asp:SqlDataSource ID="SqlComponenteInstitucion" runat="server" ConnectionString="<%$ ConnectionStrings:SUEPPSConnectionString %>" 
                    SelectCommand ="SELECT IdComponentesDePolitica,Nombre FROM [ComponentesDePolitica] WHERE ([IdPolitica] = @p1) AND Activo=1" >
                        <SelectParameters>
                        <asp:SessionParameter Name="p1"  />
                        </SelectParameters>    
                    </asp:SqlDataSource>
                                    </td>
                                </tr>

                                <tr>
                                    <td>

                        <dx:ASPxLabel runat="server" Text="Meta:" ID="MetaInstitucion" AssociatedControlID="cmbMetaComponenteInstitucion" />
                        <dx:ASPxComboBox runat="server" id="cmbMetaComponenteInstitucion" clientinstancename="cmbMetaComponenteInstitucion"  OnCallback="cmbMetaComponenteInstitucion_Callback"
                            dropdownstyle="DropDown" datasourceid="SqlMetaComponenteInstitucion" textfield="Nombre" Width="100%"
                            valuefield="IdMetasDeComponente" incrementalfilteringmode="StartsWith" enablesynchronization="False"> 
                                <ClientSideEvents SelectedIndexChanged="function(s, e) { OncmbMetaComponenteInstitucionChanged(s); }" />
                        </dx:ASPxComboBox>  
                         
                        <asp:SqlDataSource ID="SqlMetaComponenteInstitucion" runat="server" ConnectionString="<%$ ConnectionStrings:SUEPPSConnectionString %>" 
                                 SelectCommand="SELECT IdMetasDeComponente,Nombre FROM [MetasDeComponente] WHERE ([IdComponentesDePolitica]=@p1 AND Activo=1)" >
                                <SelectParameters>
                                <asp:SessionParameter Name="p1"  />
     
                                </SelectParameters>    
                        </asp:SqlDataSource>    
                                                 
                    </td>
                                </tr>

                                <tr>
                                     <td>

                        <dx:ASPxLabel runat="server" Text="Indicadores:" ID="IndicadoresInstitucion" AssociatedControlID="cmbIndicadoresInstitucion" />
                        <dx:ASPxComboBox runat="server" id="cmbIndicadoresInstitucion" clientinstancename="cmbIndicadoresInstitucion"  OnCallback="cmbIndicadoresInstitucion_Callback"
                            dropdownstyle="DropDown" datasourceid="SqlIndicadoresInstitucion" textfield="DescripcionIndicador" Width="100%"
                            valuefield="IdIndicadorDeMeta" incrementalfilteringmode="StartsWith" enablesynchronization="False"> 
                                <ClientSideEvents SelectedIndexChanged="function(s, e) { OncmbIndicadorInstitucionChanged(s); }" />
                        </dx:ASPxComboBox>       
                        <asp:SqlDataSource ID="SqlIndicadoresInstitucion" runat="server" ConnectionString="<%$ ConnectionStrings:SUEPPSConnectionString %>" SelectCommand="SELECT IM.[IdIndicadorDeMeta], I.[DescripcionIndicador] FROM [MetasDeComponente] MC join [IndicadoresDeMeta] IM on MC.IdMetasDeComponente = IM.IdMetasDeComponente join [Indicadores] I on IM.IdIndicador=I.IdIndicador join [TiposDeIndicador] TI on I.IdTipoDeIndicador=TI.IdTipoDeIndicador Where MC.IdMetasDeComponente=@p1 and (TI.NivelTipoDeIndicador=2 or TI.NivelTipoDeIndicador=3 ) AND I.Activo=1 and IM.Activo=1 and MC.Activo=1"   >
                            <SelectParameters>
                                <asp:SessionParameter Name="p1"  />
                            </SelectParameters>    
                        </asp:SqlDataSource>
                    </td>
                                </tr>

                            </table>

                       
                
  
                <table>

                <tr>
                <td>
            
                    <dx:ASPxGridView ID="ASPxGridViewInstitucion"  ClientInstanceName="ASPxGridViewInstitucion"  runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSourceInstitucion" KeyFieldName="IdInstitucion" Settings-ShowFilterRow="true" Settings-ShowFilterRowMenu="true" >
                        <Columns>
                            <dx:GridViewDataTextColumn FieldName="IdInstitucion" ShowInCustomizationForm="True" VisibleIndex="0" Visible="false">
                            </dx:GridViewDataTextColumn>
                            <dx:GridViewDataTextColumn FieldName="NombreInstitucion" ShowInCustomizationForm="True" VisibleIndex="1" Caption="Institución">
                            <Settings AutoFilterCondition="Contains" />
                            </dx:GridViewDataTextColumn>
                                                                
                            <dx:GridViewDataTextColumn>
                                <DataItemTemplate>

                                <asp:LinkButton ID="AgregarInstitucion" Text="Agregar Institución" OnClick="AgregarInstitucion_Click" runat="server"></asp:LinkButton>
                                </DataItemTemplate>
                            </dx:GridViewDataTextColumn>
                                                                    
                                                                
                        </Columns>
                         <SettingsPager>
                                                        <AllButton Visible="True" Text="Todos">
                                                        </AllButton>
                                                    </SettingsPager>
                        <SettingsBehavior AllowFocusedRow="True" />
                    </dx:ASPxGridView>
          
                    <asp:SqlDataSource ID="SqlDataSourceInstitucion" runat="server" ConnectionString="<%$ ConnectionStrings:SUEPPSConnectionString %>" SelectCommand="SELECT [IdInstitucion], [NombreInstitucion] FROM [vInstituciones]"></asp:SqlDataSource>
          
                    <asp:SqlDataSource ID="SqlDataSource6" runat="server" ConnectionString="<%$ ConnectionStrings:SUEPPSConnectionString %>" OnInserted="SqlDataSource6_Inserted">
                            
                   </asp:SqlDataSource>

                </td>


                <td rowspan="2">
                    <%--GridGrande--%>


                    <dx:ASPxGridView ID="GridInstitucionMeta" ClientInstanceName="GridInstitucionMeta"  DataSourceID="SqlInstitucionMeta" runat="server" KeyFieldName="IdInstitucionesPorIndicadorDeMeta" OnCustomCallback="GridInstitucionMeta_CustomCallback" Settings-ShowFilterRow="true" OnLoad="GridInstitucionMeta_Load" Settings-ShowFilterRowMenu="true" SettingsBehavior-AllowFocusedRow="true">
                        <Columns>
                             <dx:GridViewDataTextColumn FieldName="IdInstitucionesPorIndicadorDeMeta" ShowInCustomizationForm="True" VisibleIndex="0" Caption="#">
                            <Settings AllowAutoFilter="False" />
                             </dx:GridViewDataTextColumn>
                    
                            <dx:GridViewDataComboBoxColumn VisibleIndex="1" FieldName="IdInstitucion" Caption="Institución">
                                        <PropertiesComboBox ValueType="System.String" 
                
                                                DataSourceID="SqlDataSourceInstitucionCombo" 
                                                ValueField="IdInstitucion" 
                                                TextField="NombreInstitucion"/>
                                <Settings AllowAutoFilter="True" />
                                    <Settings AutoFilterCondition="Contains" />
                                    <Settings FilterMode="DisplayText" />
     
                    
                                    </dx:GridViewDataComboBoxColumn>
                            <dx:GridViewCommandColumn>
                                <DeleteButton Visible="true"></DeleteButton>
                            </dx:GridViewCommandColumn>

                        </Columns>

                         <SettingsPager>
                                                        <AllButton Visible="True" Text="Todos">
                                                        </AllButton>
                         </SettingsPager>

                    </dx:ASPxGridView>

                    <asp:SqlDataSource runat="server" ID="SqlDataSourceInstitucionCombo" ConnectionString='<%$ ConnectionStrings:SUEPPSConnectionString %>' 
                        SelectCommand="SELECT [IdInstitucion], [NombreInstitucion] FROM [vInstituciones] ">
                        
                    </asp:SqlDataSource>



                    <asp:SqlDataSource runat="server" ID="SqlInstitucionMeta" ConnectionString='<%$ ConnectionStrings:SUEPPSConnectionString %>' 
                        SelectCommand="SELECT * FROM [InstitucionesPorIndicadorDeMeta] WHERE ([IdIndicadorDeMeta] = @IdIndicadorDeMeta AND Activo=1)"
                        DeleteCommand="UPDATE [InstitucionesPorIndicadorDeMeta] SET [Activo] = 0 WHERE [IdInstitucionesPorIndicadorDeMeta]=@IdInstitucionesPorIndicadorDeMeta">
                        <SelectParameters>
                            <asp:SessionParameter SessionField="IdIndicadorDeMeta" Name="IdIndicadorDeMeta" Type="Int32"></asp:SessionParameter>
                        </SelectParameters>
                    </asp:SqlDataSource>                                                    
                </td>
            </tr>
            </table>

                             </dx:PanelContent>
                    </PanelCollection>
                    
                </dx:ASPxPanel>


            </dx:ContentControl>
            </ContentCollection>
        </dx:TabPage>


    </TabPages>
    </dx:ASPxPageControl>





    </div>
</asp:Content>
