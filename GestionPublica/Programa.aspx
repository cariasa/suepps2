<%@ Page Title="Planificación de Programas" Language="VB" AutoEventWireup="false" CodeFile="Programa.aspx.vb" Inherits="GestionPublica_Programa" MasterPageFile="~/Site.master" %>

<%@ Register Assembly="DevExpress.Web.v13.2, Version=13.2.6.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web.ASPxGridView.Export" TagPrefix="dx" %>

<%@ Register Assembly="DevExpress.Web.v13.2, Version=13.2.6.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web.ASPxMenu" TagPrefix="dx" %>

<%@ Register Assembly="DevExpress.Web.v13.2, Version=13.2.6.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web.ASPxTabControl" TagPrefix="dx" %>

<%@ Register Assembly="DevExpress.Web.v13.2, Version=13.2.6.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web.ASPxPanel" TagPrefix="dx" %>
<%@ Register Assembly="DevExpress.Web.v13.2, Version=13.2.6.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web.ASPxGridView" TagPrefix="dx" %>

<%@ Register assembly="DevExpress.Web.v13.2, Version=13.2.6.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" namespace="DevExpress.Web.ASPxEditors" tagprefix="dx" %>

<%@ Register Assembly="DevExpress.Web.v13.2, Version=13.2.6.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web.ASPxClasses" TagPrefix="dx" %>

<%@ Register assembly="DevExpress.Web.v13.2, Version=13.2.6.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" namespace="DevExpress.Web.ASPxCallback" tagprefix="dx" %>

<%@ Register Assembly="DevExpress.Web.v13.2, Version=13.2.6.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web.ASPxPopupControl" TagPrefix="dx" %>

<%@ Register Assembly="DevExpress.Web.v13.2, Version=13.2.6.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web.ASPxObjectContainer" TagPrefix="dx" %>
<%@ Register Assembly="DevExpress.Web.v13.2, Version=13.2.6.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web.ASPxUploadControl" TagPrefix="dx" %>

<%@ Register Src="~/MOCA_UE.ascx" TagPrefix="uc1" TagName="MOCA_UE" %>


<asp:Content ID="cHeader" ContentPlaceHolderID="HeadContent" Runat="Server">
</asp:Content>
<asp:Content ID="cBody" ContentPlaceHolderID="MainContent" Runat="Server">
    <uc1:MOCA_UE runat="server" ID="MOCA_UE01" />
<script type="text/javascript">

    function clear() {
       ComboDepartamentos.PerformCallback();
       ComboMunicipios.PerformCallback();
       ComboAldeas.PerformCallback();
       ComboCaserio.PerformCallback();
       ComboBarrio.PerformCallback();

    }
         
                                                    
    function OnDepartamentosChanged(ComboDepartamentos) {

        //ComboMunicipios.PerformCallback(ComboDepartamentos.GetValue().toString());
        ComboMunicipios.PerformCallback();
        ComboAldeas.PerformCallback();
        ComboCaserio.PerformCallback();
        ComboBarrio.PerformCallback();

    }
    function OnMunicipiosChanged(ComboMunicipios) {
        ComboAldeas.PerformCallback();
        ComboCaserio.PerformCallback();
        ComboBarrio.PerformCallback();
  
    }
    function OnAldeasChanged(ComboAldeas) {
        ComboCaserio.PerformCallback();
        ComboBarrio.PerformCallback();

    }
    function OnCaseriosChanged(ComboCaserio) {
        ComboBarrio.PerformCallback();
    }
  
    function OnSectorChanged(Combosector) {
        GridIndicadores.PerformCallback();
    }


    function OnAñoChanged(ComboAño) {
        GridMetas.PerformCallback();
    }
        
    
    
     function OnUbicacionesChanged(ASPxComboBoxAreaUbicaciones) {
        ASPxGridViewUbicacionAreaDeInfluencia.PerformCallback();
       
    }

    function OnInserterAreaInfluencia() {
        ComboAreaInfluencia.PerformCallback();
    }


    function click(e) {


        if (e.tab.index.toString() == "2") {
            ASPxComboBoxAreaUbicaciones.PerformCallback();
            ComboDepartamentos.PerformCallback();
            ComboMunicipios.PerformCallback();
            ComboAldeas.PerformCallback();
            ComboCaserio.PerformCallback();
            ComboBarrio.PerformCallback();
            ASPxGridViewUbicacionAreaDeInfluencia.PerformCallback();
        }

        if (e.tab.index.toString() == "3") {
            combosector.PerformCallback();
            GridIndicadores.PerformCallback(1);
        }

        if (e.tab.index.toString() == "4") {
            ComboAreaInfluencia.PerformCallback();
            comboAño.PerformCallback();
            GridMetas.PerformCallback(1);
        }

        if (e.tab.index.toString() == "5") {
            ASPxComboBox1.PerformCallback();
            ASPxComboBox2.PerformCallback();
            cmbAnoC.PerformCallback();
            ASPxGridView1.PerformCallback();
        }
    }

    function Uploader_OnUploadStart() {
        btnUpload.SetEnabled(false);
    }
    function Uploader_OnFileUploadComplete(args) {
        var imgSrc = "";
        if (args.isValid) {
            var date = new Date();
            imgSrc = "Uploads/" + args.callbackData + "?dx=" + date.getTime();
        }

        alert("Archivo Subido");

        detailGrid.PerformCallback();
    }
    function Uploader_OnFilesUploadComplete(args) {
        UpdateUploadButton();
    }
    function UpdateUploadButton() {
        btnUpload.SetEnabled(uploader.GetText(0) != "");
    }
    function getPreviewImageElement() {
        return document.getElementById("previewImage");
    }


    function LoadIndicadores(ASPxComboBox1) {
        ASPxComboBox2.PerformCallback();
    }

    function LoadC(cmbAnoC) {
        ASPxGridView1.PerformCallback();
    }


    function LoadC2(ASPxComboBox2) {
        ASPxGridView1.PerformCallback();
    }
    
    

 
</script>

    <div>
    
        <div>
           
                           
                            <div>

                                <dx:ASPxLabel runat="server" Text="0" ID="CodPrograma"  Visible="false"/>
                                <p></p>
                                <dx:ASPxLabel runat="server" Text=" " ID="Programa" />
                                <p></p>
                            </div>
                             
                            <div>
                            <dx:ASPxPageControl ID="ASPxPageControl2" runat="server" ActiveTabIndex="0" EnableHierarchyRecreation ="True" Height="800%" Width="100%" >
                                <ClientSideEvents ActiveTabChanged="function (s,e) {click(e);}" />
                                <TabPages>

 <%-- ######################################################################################################################################################################################### --%>

                                    <dx:TabPage Text="Años">
                                        <ContentCollection>
                                            <dx:ContentControl>
                                                <dx:ASPxGridView ID="GridAno" runat="server" OnLoad="GridAno_Load" AutoGenerateColumns="False" DataSourceID="SqlAnoPrograma" KeyFieldName="IdAnoPrograma"  SettingsEditing-EditFormColumnCount="1"  >
                                                    <Columns>
                                                        <dx:GridViewDataTextColumn FieldName="IdAnoPrograma" ReadOnly="True" ShowInCustomizationForm="True" VisibleIndex="0" Visible="false">
                                                            <EditFormSettings Visible="False"/>
                                                        </dx:GridViewDataTextColumn>
                                                        <dx:GridViewDataTextColumn FieldName="IdPrograma" ShowInCustomizationForm="True" VisibleIndex="1" Visible="false">
                                                            <EditFormSettings Visible="False" />
                                                        </dx:GridViewDataTextColumn>
                                                        <dx:GridViewDataTextColumn FieldName="Ano" ShowInCustomizationForm="True" VisibleIndex="2" Caption="Año">
                                                        </dx:GridViewDataTextColumn>
                                                        <dx:GridViewCommandColumn Caption ="Acción">
                                                            <NewButton Visible="true">

                                                            </NewButton>

                                                            <DeleteButton Visible="true">

                                                            </DeleteButton>
                                                        </dx:GridViewCommandColumn>
                                                    </Columns>

                                                    <SettingsPager>
                                                        <AllButton Visible="True" Text="Todos">
                                                        </AllButton>
                                                    </SettingsPager>

<SettingsEditing EditFormColumnCount="1"></SettingsEditing>
                                                </dx:ASPxGridView>
                                                <asp:SqlDataSource ID="SqlAnoPrograma" runat="server" ConnectionString="<%$ ConnectionStrings:SUEPPSConnectionString %>" 
                                                    
                                                     DeleteCommand="UPDATE [AnoPrograma] SET [Activo] = 0 WHERE [IdAnoPrograma] = @IdAnoPrograma"
                                                     SelectCommand="SELECT * FROM [AnoPrograma] where [IdPrograma]=@p1 and [Activo]=1 order by Ano"
                                                     OnInserted="SqlAnoPrograma_Inserted">
                                                    <SelectParameters>
                                                        <asp:SessionParameter Name="p1" />
                                                    </SelectParameters>
                                                    <InsertParameters>
                                                        <asp:SessionParameter Name="p1" />
                                                        <asp:SessionParameter Name="Usuario" />
                                                        <asp:FormParameter Name="Ano" />
                                                        <asp:SessionParameter Name="AP" />
                                                    </InsertParameters>
                                                </asp:SqlDataSource>
                                            </dx:ContentControl>
                                        </ContentCollection>
                                        
                                    </dx:TabPage>

   <%-- ######################################################################################################################################################################################### --%>

                                     <dx:TabPage Text="Área de Influencia">

                                         <ContentCollection>
                                          <dx:ContentControl ID="ContentControl2" runat="server" SupportsDisabledAttribute="True">

                                              <dx:ASPxGridView ID="ASPxGridViewAreaDeInfluencia" runat="server" OnLoad="ASPxGridViewAreaDeInfluencia_Load" AutoGenerateColumns="False" DataSourceID="SqlDataSourceAreaDeInfluencia"  SettingsBehavior-AllowFocusedRow="true"
                                              KeyFieldName="IdAreaDeInfluencia" SettingsDetail-AllowOnlyOneMasterRowExpanded="true" SettingsEditing-EditFormColumnCount="1" Settings-ShowFilterRow="true" Settings-ShowFilterRowMenu="true" >
                                                  <Columns>

                                                      <dx:GridViewDataTextColumn FieldName="IdAreaDeInfluencia" Caption="#" ReadOnly="True" VisibleIndex="0" >
                                                          <EditFormSettings Visible="False"></EditFormSettings>
                                                          <Settings AllowAutoFilter="False" />
                                                      </dx:GridViewDataTextColumn>
                                                      <dx:GridViewDataTextColumn FieldName="IdPrograma" VisibleIndex="1" Visible="false"></dx:GridViewDataTextColumn>
                                                      <dx:GridViewDataTextColumn FieldName="DescripcionAreaDeInfluencia" Caption="Descripción" VisibleIndex="2">
                                                          <Settings AutoFilterCondition="Contains" />
                                                      </dx:GridViewDataTextColumn>
                                                      <dx:GridViewDataTextColumn FieldName="CreadoPor" VisibleIndex="3" Visible="false"></dx:GridViewDataTextColumn>
                                                      <dx:GridViewDataDateColumn FieldName="FechaCreacion" VisibleIndex="4" Visible="false"></dx:GridViewDataDateColumn>
                                                      <dx:GridViewDataTextColumn FieldName="ActualizadoPor" VisibleIndex="5" Visible="false"></dx:GridViewDataTextColumn>
                                                      <dx:GridViewDataDateColumn FieldName="FechaActualizacion" VisibleIndex="6" Visible="false"></dx:GridViewDataDateColumn>
                                                      <dx:GridViewDataCheckColumn FieldName="Activo" VisibleIndex="7" Visible="false"></dx:GridViewDataCheckColumn>
                                                      <dx:GridViewCommandColumn   VisibleIndex="8"  Caption="Acciones">
                                                        
                                                          <NewButton Visible="true"></NewButton>
                                                          <EditButton Visible="true"></EditButton>
                                                          <UpdateButton Visible="true"></UpdateButton>
                                                          <DeleteButton Visible="true"></DeleteButton>
                                                          
                                                      </dx:GridViewCommandColumn>
                                                     
                                                  </Columns>
                                                  <SettingsPager>
                                                        <AllButton Visible="True" Text="Todos">
                                                        </AllButton>
                                                    </SettingsPager>

<SettingsEditing EditFormColumnCount="1"></SettingsEditing>

<Settings ShowFilterRow="True"></Settings>

                                                  <SettingsDetail ShowDetailRow="True" />

                                                <Templates>
                                                <DetailRow>
                                                <%-- Ubicacion --%>
                                                  

                                                
                                                <dx:ASPxGridView ID="ASPxGridViewUbicacionAreaDeInfluencia2" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSourceUbicacionArea" ClientInstanceName="ASPxGridViewUbicacionAreaDeInfluencia"
                                              KeyFieldName="IdUbicacionPorAreaDeInfluencia" OnBeforePerformDataSelect="ASPxGridViewUbicacionAreaDeInfluencia_BeforePerformDataSelect" IsDetailGrid="true">
                                                    <Columns>
                                                                  <dx:GridViewDataTextColumn FieldName="IdUbicacionPorAreaDeInfluencia" Caption="#" ReadOnly="True" VisibleIndex="0">
                                                                      <EditFormSettings Visible="False"></EditFormSettings>
                                                                  </dx:GridViewDataTextColumn>
                                                                  <dx:GridViewDataTextColumn FieldName="IdAreaDeInfluencia" Visible="false" VisibleIndex="1" ></dx:GridViewDataTextColumn>
                                                      
                                                                  <dx:GridViewDataComboBoxColumn VisibleIndex="2" FieldName="IdDepartamento" Caption="Departamento">
                                                                    <PropertiesComboBox ValueType="System.String" 
                
                                                                        DataSourceID="SqlDataSourceDepartamentos" 
                                                                        ValueField="IdDepartamento" 
                                                                        TextField="DescripcionDepartamento"/>
     
                    
                                                                  </dx:GridViewDataComboBoxColumn>
                                                      <dx:GridViewDataCheckColumn FieldName="EsTodoDepartamento" Visible="false" VisibleIndex="3"></dx:GridViewDataCheckColumn>
                                                      
                                                       <dx:GridViewDataComboBoxColumn VisibleIndex="4" FieldName="IdMunicipio" Caption="Municipio">
                                                        <PropertiesComboBox ValueType="System.String" 
                
                                                            DataSourceID="SqlDataSourceMunicipios" 
                                                            ValueField="IdMunicipio" 
                                                            TextField="DescripcionMunicipio"/>
     
                    
                                                      </dx:GridViewDataComboBoxColumn>
                                                      <dx:GridViewDataCheckColumn FieldName="EsTodoMunicipio" Visible="false" VisibleIndex="5" ></dx:GridViewDataCheckColumn>
                                                     
                                                      <dx:GridViewDataComboBoxColumn VisibleIndex="6" FieldName="IdAldea" Caption="Aldea">
                                                        <PropertiesComboBox ValueType="System.String" 
                
                                                            DataSourceID="SqlDataSourceAldeas" 
                                                            ValueField="IdAldea" 
                                                            TextField="DescripcionAldea"/>
     
                    
                                                      </dx:GridViewDataComboBoxColumn>
                                                      <dx:GridViewDataCheckColumn FieldName="EsTodoAldea" Visible="false" VisibleIndex="7"></dx:GridViewDataCheckColumn>
                                                      
                                                      <dx:GridViewDataComboBoxColumn VisibleIndex="8" FieldName="IdCaserio" Caption="Caserío">
                                                        <PropertiesComboBox ValueType="System.String" 
                
                                                            DataSourceID="SqlDataSourceCaserios" 
                                                            ValueField="IdCaserio" 
                                                            TextField="DescripcionCaserio"/>
     
                    
                                                      </dx:GridViewDataComboBoxColumn>
                                                      <dx:GridViewDataCheckColumn FieldName="EsTodoCacerio" Visible="false" VisibleIndex="9"></dx:GridViewDataCheckColumn>
                                                      
                                                      <dx:GridViewDataComboBoxColumn VisibleIndex="10" FieldName="IdBarrio" Caption="Barrio">
                                                        <PropertiesComboBox ValueType="System.String" 
                
                                                            DataSourceID="SqlDataSourceBarrios" 
                                                            ValueField="IdBarrio" 
                                                            TextField="DescripcionBarrio"/>
     
                    
                                                      </dx:GridViewDataComboBoxColumn>

                                                     <dx:GridViewCommandColumn   VisibleIndex="11"  Caption="Acciones">
                                                        
                                                          <DeleteButton Visible="true"/>
                                                          
                                                    </dx:GridViewCommandColumn>
                                                   
                                                  </Columns>
                                              </dx:ASPxGridView>      
                                                </DetailRow>
                                                </Templates>
                                                </dx:ASPxGridView>
                                                   <asp:SqlDataSource runat="server" ID="SqlDataSourceUbicacionArea" ConnectionString='<%$ ConnectionStrings:SUEPPSConnectionString %>' OnInserted="SqlDataSourceUbicacionArea_Inserted"
                                                    SelectCommand="SELECT * FROM [UbicacionPorAreaDeInfluencia] WHERE [IdAreaDeInfluencia]=@IdAreaDeInfluencia AND [Activo]=1"
                                                    DeleteCommand="UPDATE [UbicacionPorAreaDeInfluencia] SET [Activo] = 0 WHERE [IdUbicacionPorAreaDeInfluencia] = @IdUbicacionPorAreaDeInfluencia"
                                                     >
                                                    <SelectParameters>
                    
                                                        <asp:SessionParameter SessionField="IdAreaDeInfluencia" Name="IdAreaDeInfluencia" Type="Int32"></asp:SessionParameter>
                
                                                    </SelectParameters>
                                                    
                                              </asp:SqlDataSource>

                                              <asp:SqlDataSource runat="server" ID="SqlDataSourceAreaDeInfluencia" OnInserted="SqlDataSourceAreaDeInfluencia_Inserted" ConnectionString='<%$ ConnectionStrings:SUEPPSConnectionString %>' 
                                                SelectCommand="SELECT * FROM [AreasDeInfluencia] WHERE [IdPrograma]=@IdPrograma AND [Activo]=1 "
                                                UpdateCommand="UPDATE [AreasDeInfluencia] SET  [DescripcionAreaDeInfluencia]=@DescripcionAreaDeInfluencia, [ActualizadoPor]=@Actualizado, [FechaActualizacion]=getDate()  WHERE [IdAreaDeInfluencia]=@IdAreaDeInfluencia"
                                                DeleteCommand="UPDATE [AreasDeInfluencia] SET  [Activo]=0 WHERE [IdAreaDeInfluencia]=@IdAreaDeInfluencia">
                                                
                                                <SelectParameters>
                    
                                                        <asp:SessionParameter SessionField="IdPrograma" Name="IdPrograma" Type="Int32"></asp:SessionParameter>
                                                        
                                                    </SelectParameters>
                                                <InsertParameters>
                    
                                                        <asp:SessionParameter SessionField="IdPrograma" Name="IdPrograma" Type="Int32"></asp:SessionParameter>
                                                        <asp:FormParameter Name="DescripcionAreaDeInfluencia" />
                                                        <asp:SessionParameter Name="Usuario" />
                                                    <asp:Parameter Direction="Output" Name="IdAreaDeInfluencia" Type="Int32" />
                                                    <asp:SessionParameter Name="AP" />
                                                    </InsertParameters>

                                                  <UpdateParameters>
                    
                                                        <asp:FormParameter Name="DescripcionAreaDeInfluencia" />
                                                        <asp:SessionParameter Name="Actualizado" />
                                                    </UpdateParameters>


                                              </asp:SqlDataSource>
                                                <asp:SqlDataSource ID="SqlDataSourceDepartamentos" runat="server" ConnectionString='<%$ ConnectionStrings:SUEPPSConnectionString %>' 
                                              SelectCommand="SELECT [IdDepartamento], [DescripcionDepartamento] FROM [vDepartamentos]"></asp:SqlDataSource>
                                          
                                              <asp:SqlDataSource ID="SqlDataSourceMunicipios" runat="server" ConnectionString='<%$ ConnectionStrings:SUEPPSConnectionString %>' 
                                                      SelectCommand="SELECT [IdMunicipio], [IdDepartamento], [DescripcionMunicipio] FROM [vMunicipios]">
                                                      
                                              </asp:SqlDataSource>

                                              
                                              <asp:SqlDataSource ID="SqlDataSourceAldeas" runat="server" ConnectionString='<%$ ConnectionStrings:SUEPPSConnectionString %>' 
                                                SelectCommand="SELECT [IdAldea], [DescripcionAldea], [IdMunicipio] FROM [vAldeas]">
                                                 
                                              </asp:SqlDataSource>

                                              <asp:SqlDataSource ID="SqlDataSourceCaserios" runat="server" ConnectionString='<%$ ConnectionStrings:SUEPPSConnectionString %>' 
                                              SelectCommand="SELECT [IdCaserio], [DescripcionCaserio], [IdAldea] FROM [vCaserios]">
                                                
                                              </asp:SqlDataSource>

                                              <asp:SqlDataSource ID="SqlDataSourceBarrios" runat="server" ConnectionString='<%$ ConnectionStrings:SUEPPSConnectionString %>' 
                                              SelectCommand="SELECT [IdBarrio], [DescripcionBarrio] FROM [vBarrios]">
                                                    
                                              </asp:SqlDataSource>

                                              <asp:SqlDataSource runat="server" ID="SqlDepartamentos" ConnectionString='<%$ ConnectionStrings:SUEPPSConnectionString %>' 
                                                         SelectCommand="SELECT [IdDepartamento], [DescripcionDepartamento] FROM [vDepartamentos]"></asp:SqlDataSource>
        
                                                      <asp:SqlDataSource ID="SqlMunicipio" runat="server" ConnectionString='<%$ ConnectionStrings:SUEPPSConnectionString %>'
                                                        SelectCommand="SELECT c.IdMunicipio,c.DescripcionMunicipio FROM [vMunicipios] c, [vDepartamentos] cr WHERE (c.IdDepartamento = cr.IdDepartamento) AND (cr.IdDepartamento = @p) order by c.DescripcionMunicipio">
                       
                                                         <SelectParameters>
                                                            <asp:sessionparameter Name="p" />
                                                         </SelectParameters>
        
        
                                                       </asp:SqlDataSource>

                                                       <asp:SqlDataSource ID="SqlAldeas" runat="server" ConnectionString='<%$ ConnectionStrings:SUEPPSConnectionString %>'
                                                        SelectCommand="SELECT a.IdAldea,a.DescripcionAldea FROM [vMunicipios] m, [vDepartamentos] d,[vAldeas] a  WHERE (m.IdDepartamento = d.IdDepartamento) AND (a.IdMunicipio= m.IdMunicipio) AND (m.IdMunicipio = @p) order by a.DescripcionAldea">
                       
                                                         <SelectParameters>
                                                            <asp:sessionparameter Name="p" />
                                                         </SelectParameters>
        
        
                                                       </asp:SqlDataSource>

                                              <asp:SqlDataSource runat="server" ID="SqlUbicacion" ConnectionString='<%$ ConnectionStrings:SUEPPSConnectionString %>' >
                                                  <InsertParameters>
                                                      <asp:SessionParameter Name="AP" />
                                                  </InsertParameters>
                                              </asp:SqlDataSource>
        
                                                       

                                                       <asp:SqlDataSource ID="SqlCaserio" runat="server" ConnectionString='<%$ ConnectionStrings:SUEPPSConnectionString %>'
                                                        SelectCommand="SELECT c.IdCaserio,c.DescripcionCaserio FROM [vMunicipios] m, [vDepartamentos] d,[vAldeas] a,[vCaserios] c  WHERE (m.IdDepartamento = d.IdDepartamento) AND (a.IdMunicipio= m.IdMunicipio) AND (c.IdAldea= a.IdAldea) AND (a.IdAldea = @p) order by c.DescripcionCaserio">
                       
                                                         <SelectParameters>
                                                            <asp:Parameter Name="p" />
                                                         </SelectParameters>
        
        
                                                       </asp:SqlDataSource>

                                              <asp:SqlDataSource ID="SqlBarrio" runat="server" ConnectionString='<%$ ConnectionStrings:SUEPPSConnectionString %>'
                                                        SelectCommand="SELECT b.IdBarrio,b.DescripcionBarrio FROM [vMunicipios] m, [vDepartamentos] d,[vAldeas] a,[vCaserios] c,[vBarrios] b  WHERE (m.IdDepartamento = d.IdDepartamento) AND (a.IdMunicipio= m.IdMunicipio) AND (c.IdAldea= a.IdAldea) AND (b.IdCaserio=c.IdCaserio) AND (c.IdCaserio = @p) order by b.DescripcionBarrio">
                       
                                                         <SelectParameters>
                                                            <asp:Parameter Name="p" />
                                                         </SelectParameters>                                                                      
                                            </asp:SqlDataSource>
                                          </dx:ContentControl>
                                          </ContentCollection>
                                            

                                     </dx:TabPage>

<%-- ######################################################################################################################################################################################### --%>
        <dx:TabPage Text="Ubicaciones">

               <ContentCollection>
               <dx:ContentControl ID="ContentControl1" runat="server" SupportsDisabledAttribute="True">
                   <dx:ASPxLabel ID="ASPxLabel1" runat="server" Text="Área de Influencia"></dx:ASPxLabel>
                   <dx:ASPxComboBox runat="server" id="ASPxComboBoxAreaUbicaciones" ClientInstanceName="ASPxComboBoxAreaUbicaciones" datasourceid="SqlDataSourceAreasUbicaciones" textfield="DescripcionAreaDeInfluencia" valuefield="IdAreaDeInfluencia" OnCallback="ASPxComboBoxAreaUbicaciones_Callback"   >
                       <ClientSideEvents SelectedIndexChanged="function(s, e) {OnUbicacionesChanged(s); }" />
                   </dx:ASPxComboBox>
                                                        
                   <asp:SqlDataSource runat="server" ID="SqlDataSourceAreasUbicaciones" ConnectionString='<%$ ConnectionStrings:SUEPPSConnectionString %>' 
                        SelectCommand="SELECT * FROM [AreasDeInfluencia] where IdPrograma=@p1 and Activo=1">
                        <SelectParameters>
                              <asp:SessionParameter Name="p1"  />
                        </SelectParameters>
                   </asp:SqlDataSource>
                   <table>
                                                <tr><td>

                                                    
                                               
                                                        <dx:ASPxLabel ID="Departamento"  Text="Departamentos:" runat="server" AssociatedControlID="ComboDepartamentos"></dx:ASPxLabel> 
                                                    

                                                    
                                                        <dx:ASPxComboBox runat="server" id="ComboDepartamentos" ClientInstanceName="ComboDepartamentos" dropdownstyle="DropDownList" incrementalfilteringmode="StartsWith"
                                                            datasourceid="SqlDepartamentos" textfield="DescripcionDepartamento" valuefield="IdDepartamento"
                                                            enablesynchronization="False" >
                                                           <ClientSideEvents SelectedIndexChanged="function(s, e) { OnDepartamentosChanged(s); }" />    
                                                        </dx:ASPxComboBox>
                                                       
                                                    

                                                    
                                                        <dx:ASPxLabel ID="Municipio"  Text="Municipios:" runat="server" AssociatedControlID="ComboMunicipios"></dx:ASPxLabel> 
                                                    
                                                    
                                                        <dx:ASPxComboBox runat="server" id="ComboMunicipios" clientinstancename="ComboMunicipios" oncallback="ComboMunicipios_Callback"
                                                         dropdownstyle="DropDown" datasourceid="SqlMunicipio" textfield="DescripcionMunicipio"
                                                            valuefield="IdMunicipio" incrementalfilteringmode="StartsWith" enablesynchronization="False"> 
                                                           <ClientSideEvents SelectedIndexChanged="function(s, e) { OnMunicipiosChanged(s); }" />   
                                                         
                                                        </dx:ASPxComboBox>

                                                    
                                                    
                                                        <dx:ASPxLabel ID="Aldea"  Text="Aldeas:" runat="server" AssociatedControlID="ComboAldeas"></dx:ASPxLabel> 
                                                    
                                                    
                                                    
                                                        <dx:ASPxComboBox runat="server" id="ComboAldeas" clientinstancename="ComboAldeas" oncallback="ComboAldeas_Callback"
                                                         dropdownstyle="DropDown" datasourceid="SqlAldeas" textfield="DescripcionAldea"
                                                            valuefield="IdAldea" incrementalfilteringmode="StartsWith" enablesynchronization="False"> 
                                                     
                                                         <ClientSideEvents SelectedIndexChanged="function(s, e) { OnAldeasChanged(s); }" />  
                                                        </dx:ASPxComboBox>
                                                    
                                                    
                                                        <dx:ASPxLabel ID="Caserio"  Text="Caserios:" runat="server" AssociatedControlID="ComboCaserio"></dx:ASPxLabel> 
                                                    
                                                    
                                                        <dx:ASPxComboBox runat="server" id="ComboCaserio" clientinstancename="ComboCaserio" oncallback="ComboCaserio_Callback"
                                                         dropdownstyle="DropDown" datasourceid="SqlCaserio" textfield="DescripcionCaserio"
                                                            valuefield="IdCaserio" incrementalfilteringmode="StartsWith" enablesynchronization="False"> 
                                                          <ClientSideEvents SelectedIndexChanged="function(s, e) { OnCaseriosChanged(s); }" />
                                                         
                                                        </dx:ASPxComboBox>
                                                    
                                                    
                                                        <dx:ASPxLabel ID="Barrio"  Text="Barrios:" runat="server" AssociatedControlID="ComboBarrio"></dx:ASPxLabel> 
                                                    
                                                    
                                                       <dx:ASPxComboBox runat="server" id="ComboBarrio" clientinstancename="ComboBarrio" oncallback="ComboBarrio_Callback"
                                                         dropdownstyle="DropDown" datasourceid="SqlBarrio" textfield="DescripcionBarrio"
                                                            valuefield="IdBarrio" incrementalfilteringmode="StartsWith" enablesynchronization="False"> 
                                                     
                                                         
                                                        </dx:ASPxComboBox>
                                                       
                                                    

                                                    
                                                        <dx:ASPxButton ID="AgregarUbicacion" runat="server" Text="Agregar Ubicación" OnClick="AgregarUbicacion_Click">
                                                               <ClientSideEvents />
                                                        </dx:ASPxButton>


                                                    
                                                </td></tr>
                                            </table>

                                            <dx:ASPxGridView ID="ASPxGridViewUbicacionAreaDeInfluencia" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSourceAgregarUbicaciones" ClientInstanceName="ASPxGridViewUbicacionAreaDeInfluencia"
                                              KeyFieldName="IdUbicacionPorAreaDeInfluencia" OnCustomCallback="ASPxGridViewUbicacionAreaDeInfluencia_BeforePerformDataSelect1" >
                                                    <Columns>
                                                                  <dx:GridViewDataTextColumn FieldName="IdUbicacionPorAreaDeInfluencia" Caption="#" ReadOnly="True" VisibleIndex="0">
                                                                      <EditFormSettings Visible="False"></EditFormSettings>
                                                                  </dx:GridViewDataTextColumn>
                                                                  <dx:GridViewDataTextColumn FieldName="IdAreaDeInfluencia" Visible="false" VisibleIndex="1" ></dx:GridViewDataTextColumn>
                                                      
                                                                  <dx:GridViewDataComboBoxColumn VisibleIndex="2" FieldName="IdDepartamento" Caption="Departamento">
                                                                    <PropertiesComboBox ValueType="System.String" 
                
                                                                        DataSourceID="SqlDataSourceDepartamentos" 
                                                                        ValueField="IdDepartamento" 
                                                                        TextField="DescripcionDepartamento"/>
     
                    
                                                                  </dx:GridViewDataComboBoxColumn>
                                                      <dx:GridViewDataCheckColumn FieldName="EsTodoDepartamento" Visible="false" VisibleIndex="3"></dx:GridViewDataCheckColumn>
                                                      
                                                       <dx:GridViewDataComboBoxColumn VisibleIndex="4" FieldName="IdMunicipio" Caption="Municipio">
                                                        <PropertiesComboBox ValueType="System.String" 
                
                                                            DataSourceID="SqlDataSourceMunicipios" 
                                                            ValueField="IdMunicipio" 
                                                            TextField="DescripcionMunicipio"/>
     
                    
                                                      </dx:GridViewDataComboBoxColumn>
                                                      <dx:GridViewDataCheckColumn FieldName="EsTodoMunicipio" Visible="false" VisibleIndex="5" ></dx:GridViewDataCheckColumn>
                                                     
                                                      <dx:GridViewDataComboBoxColumn VisibleIndex="6" FieldName="IdAldea" Caption="Aldea">
                                                        <PropertiesComboBox ValueType="System.String" 
                
                                                            DataSourceID="SqlDataSourceAldeas" 
                                                            ValueField="IdAldea" 
                                                            TextField="DescripcionAldea"/>
     
                    
                                                      </dx:GridViewDataComboBoxColumn>
                                                      <dx:GridViewDataCheckColumn FieldName="EsTodoAldea" Visible="false" VisibleIndex="7"></dx:GridViewDataCheckColumn>
                                                      
                                                      <dx:GridViewDataComboBoxColumn VisibleIndex="8" FieldName="IdCaserio" Caption="Caserío">
                                                        <PropertiesComboBox ValueType="System.String" 
                
                                                            DataSourceID="SqlDataSourceCaserios" 
                                                            ValueField="IdCaserio" 
                                                            TextField="DescripcionCaserio"/>
     
                    
                                                      </dx:GridViewDataComboBoxColumn>
                                                      <dx:GridViewDataCheckColumn FieldName="EsTodoCacerio" Visible="false" VisibleIndex="9"></dx:GridViewDataCheckColumn>
                                                      
                                                      <dx:GridViewDataComboBoxColumn VisibleIndex="10" FieldName="IdBarrio" Caption="Barrio">
                                                        <PropertiesComboBox ValueType="System.String" 
                
                                                            DataSourceID="SqlDataSourceBarrios" 
                                                            ValueField="IdBarrio" 
                                                            TextField="DescripcionBarrio"/>
     
                    
                                                      </dx:GridViewDataComboBoxColumn>

                                                     <dx:GridViewCommandColumn   VisibleIndex="11"  Caption="Acciones">
                                                        
                                                          <DeleteButton Visible="true"/>
                                                          
                                                    </dx:GridViewCommandColumn>
                                                   
                                                  </Columns>
                                              </dx:ASPxGridView>


                                            
                                            <asp:SqlDataSource runat="server" ID="SqlDataSourceAgregarUbicaciones" ConnectionString='<%$ ConnectionStrings:SUEPPSConnectionString %>' OnInserted="SqlDataSourceUbicacionArea_Inserted"
                                                    SelectCommand="SELECT * FROM [UbicacionPorAreaDeInfluencia] WHERE [IdAreaDeInfluencia]=@Area AND [Activo]=1"
                                                    DeleteCommand="UPDATE [UbicacionPorAreaDeInfluencia] SET [Activo] = 0 WHERE [IdUbicacionPorAreaDeInfluencia] = @IdUbicacionPorAreaDeInfluencia"
                                                     >
                                                    <SelectParameters>
                    
                                                        <asp:SessionParameter  Name="Area" Type="Int32"></asp:SessionParameter>
                
                                                    </SelectParameters>
                                                    
                                              </asp:SqlDataSource>                        
               </dx:ContentControl>
               </ContentCollection>
                                            

          </dx:TabPage>
                                          
<%-- ######################################################################################################################################################################################### --%>
                                     <dx:TabPage Text="Indicadores">
                                         <ContentCollection>
                                             <dx:ContentControl>
                                                  <dx:ASPxButton ID="ASPxButtonAgregarIndicadoresDeCobertura" runat="server" Text="Agregar Indicadores de Cobertura" 
                                                    OnClick="ASPxButtonAgregarIndicadoresDeCobertura_Click">
                                                        <ClientSideEvents Click="function(s, e){e.processOnServer = confirm('Desea agregar los Indicadores de Cobertura?'); }"/>
                                                  </dx:ASPxButton>
                                                 <table>
                                                 
                                                     
                                                 
                                                <tr>
                                                    <td>
                                                        <dx:ASPxLabel runat="server" Text="Sector:" ID="Sector" AssociatedControlID="combosector" />


                                                        <dx:ASPxComboBox ID="combosector" ClientInstanceName="combosector" runat="server" ValueField="IdSectorIndicador" OnCallback="combosector_Callback"
                                                            TextField="DescripcionSectorIndicador"  DataSourceID="Sqlcombosector" ClientSideEvents-SelectedIndexChanged="function(s, e) {OnSectorChanged(s); }"
                                                                      >
                                                            <ClientSideEvents SelectedIndexChanged="function(s, e) {OnSectorChanged(s); }"></ClientSideEvents>
                                                        </dx:ASPxComboBox>

                                                        <asp:SqlDataSource ID="Sqlcombosector" runat="server" ConnectionString="<%$ ConnectionStrings:SUEPPSConnectionString %>" SelectCommand="SELECT [DescripcionSectorIndicador],[IdSectorIndicador] FROM [vROISectorIndicadores]"> </asp:SqlDataSource>
                                                                  
                                                    </td>


                                                    <td rowspan="2">
                                                        <dx:ASPxGridViewExporter ID="ASPxGridViewExporterIndicadoresPorPrograma" runat="server" GridViewID="GridIndicadoresPorPrograma"></dx:ASPxGridViewExporter>
                                                        
                                                        <dx:ASPxButton ID="ASPxButtonExportarIndicadoresPorPrograma" runat="server" Text="Exportar" OnClick="ASPxButtonExportarIndicadoresPorPrograma_Click"></dx:ASPxButton>

                                                        <dx:ASPxGridView ID="GridIndicadoresPorPrograma" ClientInstanceName="GridIndicadoresPorPrograma" runat="server" AutoGenerateColumns="False"  OnLoad="GridIndicadoresPorPrograma_Load"
                                                         DataSourceID="SqlIndicadoresPorPrograma" KeyFieldName="IdIndicadoresPorPrograma" OnCustomCallback="GridIndicadoresPorPrograma_CustomCallback" Settings-ShowFilterRow="true" Settings-ShowFilterRowMenu="true">

                                                                 <Columns>

                                                                    <dx:GridViewDataTextColumn FieldName="IdIndicadoresPorPrograma"  Caption="IdIndicadoresPorPrograma" ReadOnly="True" ShowInCustomizationForm="True" Visible="false" VisibleIndex="0" >
                                                                                            <EditFormSettings Visible="False" />
                                                                                            
                                                                      </dx:GridViewDataTextColumn>
                                                                     
                                                                     <dx:GridViewDataTextColumn FieldName="IdIndicador"  Caption="#" ReadOnly="True" ShowInCustomizationForm="True" VisibleIndex="1" Visible="false">
                                                                                            <EditFormSettings Visible="False" />
                                                                      </dx:GridViewDataTextColumn>

                                                                      <dx:GridViewDataComboBoxColumn VisibleIndex="2" FieldName="IdIndicador" Caption="Indicador"  PropertiesComboBox-IncrementalFilteringMode="Contains">
                                                                            <PropertiesComboBox ValueType="System.String" 
                
                                                                                    DataSourceID="SqlDataSourceIndicadorComboGridIndicadoresPorPrograma" 
                                                                                    ValueField="IdIndicador" 
                                                                                    TextField="DescripcionIndicador"/>
                                                                             <Settings AllowAutoFilter="True" />
                                    <Settings AutoFilterCondition="Contains" />
                                    <Settings FilterMode="DisplayText" />
     
                                        
                                                                        </dx:GridViewDataComboBoxColumn>

                                                                        <dx:GridViewDataComboBoxColumn VisibleIndex="3" FieldName="IdIndicador" Caption="Sector" PropertiesComboBox-IncrementalFilteringMode="Contains" >
                                                                            <PropertiesComboBox ValueType="System.String" 
                
                                                                                    DataSourceID="SqlDataSourceSectorIndicadorComboGridIndicadoresPorPrograma" 
                                                                                    ValueField="IdIndicador" 
                                                                                    TextField="DescripcionSectorIndicador"/>
                                                                             <Settings AllowAutoFilter="True" />

                                    <Settings AutoFilterCondition="Contains" />
                                    <Settings FilterMode="DisplayText" />
     
                                        
                                                                        </dx:GridViewDataComboBoxColumn>

                                                                        <dx:GridViewDataComboBoxColumn VisibleIndex="4" FieldName="IdIndicadoresPorPrograma" Caption="Meta" PropertiesComboBox-IncrementalFilteringMode="Contains" >
                                                                            <PropertiesComboBox ValueType="System.String" 
                
                                                                                    DataSourceID="SqlDataSourceMetaIndicadorComboGridIndicadoresPorPrograma" 
                                                                                    ValueField="IdIndicadorPorPrograma" 
                                                                                    TextField="Meta"/>
                                                                            <Settings AllowAutoFilter="False" />
                                                                         <Settings AllowAutoFilter="False" />
                                   <Settings AutoFilterCondition="Contains" />
                                    <Settings FilterMode="DisplayText" />
     
                                        
                                                                        </dx:GridViewDataComboBoxColumn>

                                                                     <dx:GridViewDataTextColumn FieldName="IdPrograma"  Caption="IdPrograma" ReadOnly="True" ShowInCustomizationForm="True" VisibleIndex="5" Visible="false">
                                                                                            <EditFormSettings Visible="False" />
                                                                      </dx:GridViewDataTextColumn>

                                                                      <dx:GridViewDataComboBoxColumn VisibleIndex="6" FieldName="IdPrograma" Caption="Programa" Visible="false" >
                                                                            <PropertiesComboBox ValueType="System.String" 
                
                                                                                    DataSourceID="SqlDataSourceProgramaComboGridIndicadoresPorPrograma" 
                                                                                    ValueField="codigo_ficha" 
                                                                                    TextField="NombreProyecto"/>
                                                                           <Settings AllowAutoFilter="True" />
                                    <Settings AutoFilterCondition="Like" />
                                    <Settings FilterMode="DisplayText" />
     
                                        
                                                                        </dx:GridViewDataComboBoxColumn>
                                                                                   
                                                                        

                                                                        <dx:GridViewDataTextColumn FieldName="DescripcionTipoDeIndicador"  Caption="Tipo" ReadOnly="True" ShowInCustomizationForm="True" VisibleIndex="7" Visible="true" Settings-AutoFilterCondition="Contains" >
                                                                                            <EditFormSettings Visible="False" />
                                                                      </dx:GridViewDataTextColumn>         
                                                                                                                                          
                                                                    <dx:GridViewCommandColumn Caption="Acción">
                                                                        <DeleteButton Visible="true"></DeleteButton>
                                                                    </dx:GridViewCommandColumn>
                                                                                  
                                                                 </Columns>
                                                            <SettingsPager>
                                                        <AllButton Visible="True" Text="Todos">
                                                        </AllButton>
                                                    </SettingsPager>
                                                                   <SettingsBehavior AllowFocusedRow="True" />

<Settings ShowFilterRow="True"></Settings>
                                                                 </dx:ASPxGridView>

                                                             <asp:SqlDataSource ID="SqlIndicadoresPorPrograma" runat="server" ConnectionString="<%$ ConnectionStrings:SUEPPSConnectionString %>" 
                                                                 SelectCommand = "SELECT ip.IdPrograma, ip.IdIndicadoresPorPrograma, ip.IdIndicador, ip.FechaCreacion, ip.FechaActualizacion, ip.CreadoPor, ip.ActualizadoPor, ip.Activo, ti.DescripcionTipoDeIndicador FROM [IndicadoresPorPrograma] ip, [TiposDeIndicador] ti, [Indicadores] i WHERE ip.[Activo]=1 AND ip.[IdPrograma] = @p1 AND i.[Activo]= 1 AND i.IdIndicador = ip.IdIndicador AND i.IdTipoDeIndicador = ti.IdTipoDeIndicador"
                                                                 DeleteCommand ="UPDATE [IndicadoresPorPrograma] SET [Activo]=0 WHERE [IdIndicadoresPorPrograma]=@IdIndicadoresPorPrograma"

                                                                  >                                            
                                                                  <SelectParameters>
                                                                 <asp:SessionParameter Name="p1" DbType="Int32" SessionField="p1" />
                                                             </SelectParameters>

                                                             </asp:SqlDataSource>

                                                            
                                                        <asp:SqlDataSource ID="SqlDeleteIndicador" runat="server"  ConnectionString='<%$ ConnectionStrings:SUEPPSConnectionString %>' SelectCommand="SELECT * FROM [Indicadores]"></asp:SqlDataSource>

                                                        <asp:SqlDataSource ID="SqlDataSourceIndicadorComboGridIndicadoresPorPrograma" runat="server" ConnectionString='<%$ ConnectionStrings:SUEPPSConnectionString %>'
                                                         SelectCommand="SELECT  IdIndicador, DescripcionIndicador FROM Indicadores">

                                                        </asp:SqlDataSource>
                                                        <asp:SqlDataSource ID="SqlDataSourceProgramaComboGridIndicadoresPorPrograma"  ConnectionString='<%$ ConnectionStrings:SUEPPSConnectionString %>' runat="server"
                                                         SelectCommand="SELECT [codigo_ficha], [NombreProyecto] FROM vProyectos"></asp:SqlDataSource>

                                                        <asp:SqlDataSource ID="SqlDataSourceSectorIndicadorComboGridIndicadoresPorPrograma" ConnectionString='<%$ ConnectionStrings:SUEPPSConnectionString %>' runat="server"
                                                         SelectCommand="SELECT i.IdIndicador, sec.DescripcionSectorIndicador, i.IdSectorIndicador FROM vROISectorIndicadores sec, Indicadores i WHERE sec.IdSectorIndicador = i.IdSectorIndicador">

                                                        </asp:SqlDataSource>

                                                        <asp:SqlDataSource ID="SqlDataSourceMetaIndicadorComboGridIndicadoresPorPrograma" ConnectionString='<%$ ConnectionStrings:SUEPPSConnectionString %>' runat="server"
                                                            SelectCommand=
                                                                "SELECT 
                                                                    m.IdIndicadorPorPrograma, 
                                                                    sum(m.ProyectadoQ1 + m.ProyectadoQ2 + m.ProyectadoQ3 + m.ProyectadoQ4) as Meta 
                                                                FROM 
                                                                    MetaYMonitoreoPorPeriodo m 
                                                                    JOIN AreasDeInfluencia a ON m.IdAreaDeInfluencia = a.IdAreaDeInfluencia
                                                                WHERE 
                                                                    a.Activo=1
                                                                    
                                                                GROUP BY IdIndicadorPorPrograma" >
                                                        </asp:SqlDataSource>
                                                    </td>
                                                    
                                                </tr>

                                                <tr>
                                                    <td colspan="1">
                                                        <dx:ASPxGridView ID="GridIndicadores" ClientInstanceName="GridIndicadores" runat="server" AutoGenerateColumns="False" DataSourceID="SqlIndicadores"  OnCustomCallback="GridIndicadores_CustomCallback" KeyFieldName="IdIndicador" PreviewFieldName ="Descripcion" Enabled="true" OnLoad="GridIndicadores_Load" Settings-ShowFilterRow="true" Settings-ShowFilterRowMenu="true">
                              
                                
                                                                                    <Columns>
                                                                                        <dx:GridViewDataTextColumn FieldName="IdIndicador"  Caption="#" ReadOnly="True" ShowInCustomizationForm="True" VisibleIndex="0">
                                                                                            <EditFormSettings Visible="False" />
                                                                                            <Settings AllowAutoFilter="False" />
                                                                                        </dx:GridViewDataTextColumn>
                                                                                        
                                                                                        <dx:GridViewDataTextColumn FieldName="DescripcionIndicador" ShowInCustomizationForm="True" VisibleIndex="1" Caption="Indicador">
                                                                                        <Settings AutoFilterCondition="Contains" />
                                                                                        </dx:GridViewDataTextColumn>



                                                                                        <dx:GridViewDataTextColumn FieldName="Acciones"  Caption="Acción"  ShowInCustomizationForm="True" VisibleIndex="2" UnboundType="String">
                                                                                        <DataItemTemplate>
                                                                                        <asp:LinkButton id="link1"  Text="Agregar" runat="server"  OnClick="addIdentificador" /> 
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
                                                                                 <asp:SqlDataSource ID="SqlIndicadores" runat="server" ConnectionString="<%$ ConnectionStrings:SUEPPSConnectionString %>" 
                                                                                     SelectCommand="SELECT I.IdIndicador,I.DescripcionIndicador FROM [Indicadores] I join TiposDeIndicador TI on I.IdTipoDeIndicador = TI.IdTipoDeIndicador WHERE ([IdSectorIndicador] = @p1) AND  I.Activo=1 AND TI.[NivelTipoDeIndicador] = 1" >
                                                                                     <SelectParameters>
                                                                                         <asp:SessionParameter Name="p1"  />
                                                                                     </SelectParameters>    
                                                                                 </asp:SqlDataSource>

                                                                                <asp:SqlDataSource ID="SqladdIndicador" runat="server" ConnectionString="<%$ ConnectionStrings:SUEPPSConnectionString %>" 
                                                                                    InsertCommand="INSERT INTO [IndicadoresPorPrograma]([IdIndicador] ,[IdPrograma],[Activo],[CreadoPor],[FechaCreacion]) VALUES (@IdIndicador, @IdPrograma,1,@Usuario,getDate())
                                                                                                    SELECT @IdIndicadoresPorPrograma = SCOPE_IDENTITY()"
                                                                                     OnInserted="SqladdIndicador_Inserted">
                                                                                    <InsertParameters>
                                                                                        <asp:Parameter Name="IdIndicador" />
                                                                                        <asp:Parameter Name="IdPrograma" />
                                                                                        <asp:Parameter Direction="Output" Name="IdIndicadoresPorPrograma" Type="Int32" />
                                                                                        <asp:SessionParameter Name="Usuario" />
                                                                                    </InsertParameters>
                                                                                </asp:SqlDataSource>

                                                    </td>
                                                </tr>
                                                </table>
                                             </dx:ContentControl>


                                         </ContentCollection>
                                     </dx:TabPage>

  <%-- ######################################################################################################################################################################################### --%>

                                     <dx:TabPage Text="Programación por Área de Influencia" >
                                         <ContentCollection >

                                            
                                            <dx:ContentControl runat="server" SupportsDisabledAttribute="True">



                                                <table>
                                                    <tr>
                                                        <td>
                                                            <dx:ASPxLabel runat="server" Text="Área de Influencia"></dx:ASPxLabel>
                                                        </td>
                                                        <td>
                                                       

                                                        <dx:ASPxComboBox runat="server" id="ComboAreaInfluencia" ClientInstanceName="ComboAreaInfluencia" datasourceid="SqlAreaInfluenciac" textfield="DescripcionAreaDeInfluencia" valuefield="IdAreaDeInfluencia" OnCallback="ComboAreaInfluencia_Callback"  >
                                                        <ClientSideEvents SelectedIndexChanged="function(s, e) {OnAñoChanged(s); }" />
                                                        </dx:ASPxComboBox>
                                                        
                                                         <asp:SqlDataSource runat="server" ID="SqlAreaInfluenciac" ConnectionString='<%$ ConnectionStrings:SUEPPSConnectionString %>' 
                                                         SelectCommand="SELECT * FROM [AreasDeInfluencia] where IdPrograma=@p1 and Activo=1">
                                                             <SelectParameters>
                                                                 <asp:SessionParameter Name="p1"  />
                                                             </SelectParameters>
                                                         </asp:SqlDataSource>
                                                        
                                                        </td>
                                                        <td>
                                                            <dx:ASPxLabel runat="server" Text="Año"></dx:ASPxLabel>
                                                        </td>
                                                        <td>
                                                            <dx:ASPxComboBox runat="server" id="comboAño" clientinstancename="comboAño" datasourceid="sqlDataSourceComboAno" TextField="Ano" 
                                                               ValueField="Ano" OnCallback="comboAño_Callback"> 
                                                                    <ClientSideEvents SelectedIndexChanged="function(s, e) {OnAñoChanged(s); }" />   
                                                            </dx:ASPxComboBox>
                                                            <asp:SqlDataSource runat="server" ID="sqlDataSourceComboAno" ConnectionString='<%$ ConnectionStrings:SUEPPSConnectionString %>' 
                                                            SelectCommand="SELECT Ano FROM [AnoPrograma] where IdPrograma=@p1 and Activo=1 ">
                                                             <SelectParameters>
                                                                 <asp:SessionParameter Name="p1"  />
                                                             </SelectParameters>
                                                         </asp:SqlDataSource>
                                                         

                                                        </td>



                                                        
                                                    </tr>
                                                </table>

                                                <dx:ASPxButton ID="ASPxButtonExportarIndicadoresm" runat="server" Text="Exportar" OnClick="ASPxButtonExportarIndicadoresm_Click"></dx:ASPxButton>
                                                <dx:ASPxGridViewExporter ID="ASPxGridViewExporterExportarIndicadoresm" runat="server" GridViewID="GridMetas"></dx:ASPxGridViewExporter>
                                                <dx:ASPxGridView ID="GridIndicadoresm" runat="server" AutoGenerateColumns="False" DataSourceID="SqlIndicadoresm"  Visible="false" >

                                                    <Columns>
                                                        <dx:GridViewDataTextColumn  FieldName="IdIndicadoresPorPrograma" ReadOnly="True" ShowInCustomizationForm="True" VisibleIndex="0">
                                                      </dx:GridViewDataTextColumn>
                                                        <dx:GridViewDataTextColumn  FieldName="IdIndicador" ReadOnly="True" ShowInCustomizationForm="True" VisibleIndex="1">
                                                      </dx:GridViewDataTextColumn>
                                                        <dx:GridViewDataTextColumn  FieldName="IdPrograma" ReadOnly="True" ShowInCustomizationForm="True" VisibleIndex="2">
                                                      </dx:GridViewDataTextColumn>
                                                        </Columns>
                                              </dx:ASPxGridView>

                                                <asp:SqlDataSource ID="SqlIndicadoresm" runat="server" ConnectionString="<%$ ConnectionStrings:SUEPPSConnectionString %>" ></asp:SqlDataSource>

                                               

                                               <dx:ASPxGridView ID="GridMetasconIndicador" runat="server" AutoGenerateColumns="False" DataSourceID="SqlMetasIndicador" Visible="false" enabled="true">

                                                    <Columns>
                                                        <dx:GridViewDataTextColumn  FieldName="IdAreaDeInfluencia" ReadOnly="True" ShowInCustomizationForm="True" VisibleIndex="0">
                                                      </dx:GridViewDataTextColumn>
                                                        <dx:GridViewDataTextColumn  FieldName="IdIndicadorPorPrograma" ReadOnly="True" ShowInCustomizationForm="True" VisibleIndex="1">
                                                      </dx:GridViewDataTextColumn>
                                                        <dx:GridViewDataTextColumn  FieldName="Ano" ReadOnly="True" ShowInCustomizationForm="True" VisibleIndex="2">
                                                      </dx:GridViewDataTextColumn>
                                                        </Columns>
                                              </dx:ASPxGridView>

                                                    <asp:SqlDataSource ID="SqlMetasIndicador" runat="server" ConnectionString="<%$ ConnectionStrings:SUEPPSConnectionString %>" ></asp:SqlDataSource>

                                               


                                                <dx:ASPxGridView ID="GridMetas"  ClientInstanceName="GridMetas" runat="server" DataSourceID="SqlMetas"  OnCustomCallback="GridMeta_CustomCallback" 
                                                 KeyFieldName="IdMetaPorPeriodo" OnLoad="GridMetas_Load" Settings-ShowFilterRow="true" Settings-ShowFilterRowMenu="true" >

                                                    <Columns>
                                                        <dx:GridViewDataColumn Caption="#" FieldName="IdMetaPorPeriodo" ReadOnly="True"  VisibleIndex="0" >
                                                            <EditFormSettings Visible="False" />
                                                            <Settings AllowAutoFilter="False" />
                                                        </dx:GridViewDataColumn>
                                                        <dx:GridViewDataTextColumn   Caption="Sector" FieldName="DescripcionSectorIndicador" ReadOnly="True"  VisibleIndex="1">
                                                          <EditFormSettings Visible="False" />
                                                            <Settings AutoFilterCondition="Contains" />
                                                      </dx:GridViewDataTextColumn>
                                                         <dx:GridViewDataTextColumn  Caption="Indicador" FieldName="DescripcionIndicador" ReadOnly="True"  VisibleIndex="2">
                                                          <EditFormSettings Visible="False" />
                                                             <Settings AutoFilterCondition="Contains" />
                                                      </dx:GridViewDataTextColumn>
                                                        <dx:GridViewDataTextColumn  Caption="Tipo de Indicador" FieldName="DescripcionTipoDeIndicador" ReadOnly="True"  VisibleIndex="3">
                                                          <EditFormSettings Visible="False" />
                                                             <Settings AutoFilterCondition="Contains" />
                                                      </dx:GridViewDataTextColumn>
                                                        <dx:GridViewDataTextColumn FieldName="Potenciales" Caption="Pot." ReadOnly="False"  VisibleIndex="4">
                                                          <EditFormSettings Visible="True" />
                                                            <Settings AllowAutoFilter="False" />
                                                      </dx:GridViewDataTextColumn>
                                                        <dx:GridViewDataTextColumn  Caption="P1" FieldName="ProyectadoQ1"   VisibleIndex="5">
                                                          <EditFormSettings Visible="True" />
                                                            <Settings AllowAutoFilter="False" />
                                                      </dx:GridViewDataTextColumn>
                                                        
                                                        <dx:GridViewDataTextColumn  Caption="P2" FieldName="ProyectadoQ2"  VisibleIndex="6">
                                                         <EditFormSettings Visible="True" />
                                                            <Settings AllowAutoFilter="False" />
                                                      </dx:GridViewDataTextColumn>
                                                        <dx:GridViewDataTextColumn FieldName="S1" ReadOnly="True" ShowInCustomizationForm="True" VisibleIndex="7">
                                                          <EditFormSettings Visible="False" />
                                                            <Settings AllowAutoFilter="False" />
                                                      </dx:GridViewDataTextColumn>
                                                        <dx:GridViewDataTextColumn  Caption="P3" FieldName="ProyectadoQ3" VisibleIndex="8">
                                                          <EditFormSettings Visible="True" />
                                                            <Settings AllowAutoFilter="False" />
                                                      </dx:GridViewDataTextColumn>
      
                                                        <dx:GridViewDataTextColumn Caption="P4" FieldName="ProyectadoQ4"   VisibleIndex="9">
                                                          <EditFormSettings Visible="True" />
                                                            <Settings AllowAutoFilter="False" />
                                                      </dx:GridViewDataTextColumn>
                                                        
                                                        <dx:GridViewDataTextColumn FieldName="Total" ReadOnly="True"  VisibleIndex="10">
                                                          <EditFormSettings Visible="False" />
                                                            <Settings AllowAutoFilter="False" />
                                                      </dx:GridViewDataTextColumn>
                                                        <dx:GridViewCommandColumn   VisibleIndex="11"  Caption="Acción">
                                                            <UpdateButton Visible="true"></UpdateButton>
                                                            <EditButton Visible="true"></EditButton>
                                                      </dx:GridViewCommandColumn>

                                                        
                                                    </Columns>

                                                    <SettingsPager>
                                                        <AllButton Visible="True" Text="Todos">
                                                        </AllButton>
                                                    </SettingsPager>

<Settings ShowFilterRow="True"></Settings>

                                                </dx:ASPxGridView>
                                                  <asp:SqlDataSource ID="SqlMetas" runat="server" ConnectionString="<%$ ConnectionStrings:SUEPPSConnectionString %>" 
                                                       
                                                      OnUpdated="SqlMetas_Updated"
                                                      UpdateCommand="UPDATE [MetaYMonitoreoPorPeriodo] SET [Potenciales]=@Potenciales, [ProyectadoQ1]=@ProyectadoQ1, [ProyectadoQ2]=@ProyectadoQ2,[ProyectadoQ3]=@ProyectadoQ3 , [ProyectadoQ4]=@ProyectadoQ4 WHERE [IdMetaPorPeriodo]= @IdMetaPorPeriodo " 
                                                      SelectCommand="select MM.IdMetaPorPeriodo,I.IdIndicador,SI.DescripcionSectorIndicador, I.DescripcionIndicador,TI.DescripcionTipoDeIndicador,MM.Potenciales, MM.ProyectadoQ1,MM.ProyectadoQ2,(MM.ProyectadoQ1+MM.ProyectadoQ2) As S1,MM.ProyectadoQ3,MM.ProyectadoQ4,(MM.ProyectadoQ1 + MM.ProyectadoQ2 + MM.ProyectadoQ3 + MM.ProyectadoQ4) as Total from Indicadores I join IndicadoresPorPrograma IP on I.IdIndicador = IP.IdIndicador join vROISectorIndicadores SI on SI.IdSectorIndicador = I.IdSectorIndicador join MetaYMonitoreoPorPeriodo MM on MM.IdIndicadorPorPrograma = IP.IdIndicadoresPorPrograma join  TiposDeIndicador TI on I.IdTipoDeIndicador = TI.IdTipoDeIndicador  where I.Activo=1 and IP.Activo=1 and IP.IdPrograma = @p1 and MM.IdAreaDeInfluencia= @p2 and MM.Ano= @p3 AND MM.Activo=1 and (TI.NivelTipoDeIndicador = 1 OR TI.NivelTipoDeIndicador = 0) group by I.IdIndicador, SI.DescripcionSectorIndicador, I.DescripcionIndicador,TI.DescripcionTipoDeIndicador,IP.IdIndicadoresPorPrograma,MM.Potenciales,MM.ProyectadoQ1,MM.ProyectadoQ2,MM.ProyectadoQ3,MM.ProyectadoQ4,MM.IdMetaPorPeriodo">

                                                      
                                                      <SelectParameters>
                                                            <asp:SessionParameter Name="p1"   />
                                                            <asp:SessionParameter Name="p2" />
                                                            <asp:SessionParameter Name="p3" /> 
                                                     </SelectParameters> 
                                                                       
                                                   </asp:SqlDataSource>

                                                    


                                                <br />

                                               

                                            </dx:ContentControl>
                                        </ContentCollection>


                                     </dx:TabPage>

<%-- ######################################################################################################################################################################################### --%>

                                    
                                     <dx:TabPage Text="Programación por Indicador" >
                                         <ContentCollection >

                                            
                                            <dx:ContentControl ID="ContentControl6" runat="server" SupportsDisabledAttribute="True">


                                                <table width="100%">
                                                    <tr>
                                                        <td>
                                                            <dx:ASPxLabel runat="server" Text="Tipo de Indicador" AssociatedControlID="ASPxComboBox1"></dx:ASPxLabel>
                                                            <dx:ASPxComboBox ID="ASPxComboBox1" ClientInstanceName="ASPxComboBox1" runat="server"  ValueField="IdTipoDeIndicador" TextField="DescripcionTipoDeIndicador" DataSourceID="SqlDataSource1">
                                                            <ClientSideEvents SelectedIndexChanged="function(s, e) {LoadIndicadores(); }" />
                                                           </dx:ASPxComboBox>


                                                                <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:SUEPPSConnectionString %>" SelectCommand="SELECT [IdTipoDeIndicador], [DescripcionTipoDeIndicador], [NivelTipoDeIndicador] FROM [TiposDeIndicador] WHERE ([NivelTipoDeIndicador]=1 or [NivelTipoDeIndicador]=0) and [Activo]=1 "></asp:SqlDataSource>

                                                        </td>
                                                    </tr>

                                                    <tr>
                                                        <td>




                                               <dx:ASPxLabel ID="ASPxLabel3" runat="server" Text="Indicador" AssociatedControlID="ASPxComboBox2" Width="100%"></dx:ASPxLabel>
                                                           

                                                <dx:ASPxComboBox ID="ASPxComboBox2" ClientInstanceName="ASPxComboBox2" runat="server"  TextField="DescripcionIndicador" ValueField="IdIndicadoresPorPrograma" DataSourceID="SqlDataSource2"  OnCallback="ASPxComboBox2_Callback" Width="100%">
                                                    <ClientSideEvents SelectedIndexChanged="function(s, e) {LoadC2(); }" />
                                                           
                                                </dx:ASPxComboBox>

                                                <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:SUEPPSConnectionString %>" SelectCommand="SELECT a.IdIndicadoresPorPrograma, b.DescripcionIndicador FROM [IndicadoresPorPrograma] a join [Indicadores] b on a.IdIndicador=b.IdIndicador join [TiposDeIndicador] c on b.IdTipoDeIndicador= c.IdTipoDeIndicador WHERE b.IdTipoDeIndicador= @TipoIndicador and a.IdPrograma= @Programa and a.Activo=1 and b.Activo=1  ">
                                                    <SelectParameters>
                                                        <asp:SessionParameter Name="TipoIndicador" />
                                                        <asp:SessionParameter Name="Programa" />
                                                    </SelectParameters>
                                                </asp:SqlDataSource>
                                                        </td>
                                                    </tr>

                                                    <tr>
                                                        <td>
                                                        <dx:ASPxLabel ID="lblAnoC" runat="server" Text="Año:" AssociatedControlID="cmbAnoC"></dx:ASPxLabel>
   
                                        <dx:ASPxComboBox ID="cmbAnoC"  ClientInstanceName="cmbAnoC" runat="server" ValueType="System.String" DataSourceID="SqlAno"  ValueField="Ano"  TextField="Ano">
                                          <ClientSideEvents SelectedIndexChanged="function(s, e) {LoadC(); }" />                 
                                        </dx:ASPxComboBox>
                                                            

                                                        <asp:SqlDataSource ID="SqlAno" runat="server" ConnectionString="<%$ ConnectionStrings:SUEPPSConnectionString %>" SelectCommand="SELECT [Ano], [IdAnoPrograma], [IdPrograma] FROM [AnoPrograma] where [IdPrograma]=@Programa and [Activo]=1">
                                <SelectParameters>
                                    <asp:SessionParameter Name="Programa" />
                                </SelectParameters>
                            </asp:SqlDataSource>

                                                    </td>

                                                    </tr>

                                                </table>


                                                <br />

                                                 <dx:ASPxGridView ID="ASPxGridView1"  ClientInstanceName="ASPxGridView1" runat="server" DataSourceID="SqlDataSource3"  OnCustomCallback="ASPxGridView1_CustomCallback"
                                                 KeyFieldName="IdMetaPorPeriodo" OnLoad="ASPxGridView1_Load" Settings-ShowFilterRow="true" Settings-ShowFilterRowMenu="true" >

                                                    <Columns>
                                                        <dx:GridViewDataColumn Caption="#" FieldName="IdMetaPorPeriodo" ReadOnly="True"  VisibleIndex="0" >
                                                            <EditFormSettings Visible="False" />
                                                            <Settings AllowAutoFilter="False" />
                                                        </dx:GridViewDataColumn>
                                                   
                                                         <dx:GridViewDataTextColumn  Caption="Área de Influencia" FieldName="DescripcionAreaDeInfluencia" ReadOnly="True"  VisibleIndex="2">
                                                          <EditFormSettings Visible="False" />
                                                             <Settings AutoFilterCondition="Contains" />
                                                      </dx:GridViewDataTextColumn>
                                                        <dx:GridViewDataTextColumn FieldName="Potenciales" Caption="Pot." ReadOnly="False"  VisibleIndex="3">
                                                          <EditFormSettings Visible="True" />
                                                            <Settings AllowAutoFilter="False" />
                                                      </dx:GridViewDataTextColumn>
                                                        <dx:GridViewDataTextColumn  Caption="P1" FieldName="ProyectadoQ1"   VisibleIndex="4">
                                                          <EditFormSettings Visible="True" />
                                                            <Settings AllowAutoFilter="False" />
                                                      </dx:GridViewDataTextColumn>
                                                        
                                                        <dx:GridViewDataTextColumn  Caption="P2" FieldName="ProyectadoQ2"  VisibleIndex="5">
                                                         <EditFormSettings Visible="True" />
                                                            <Settings AllowAutoFilter="False" />
                                                      </dx:GridViewDataTextColumn>
                                                        <dx:GridViewDataTextColumn FieldName="S1" ReadOnly="True" ShowInCustomizationForm="True" VisibleIndex="6">
                                                          <EditFormSettings Visible="False" />
                                                            <Settings AllowAutoFilter="False" />
                                                      </dx:GridViewDataTextColumn>
                                                        <dx:GridViewDataTextColumn  Caption="P3" FieldName="ProyectadoQ3" VisibleIndex="7">
                                                          <EditFormSettings Visible="True" />
                                                            <Settings AllowAutoFilter="False" />
                                                      </dx:GridViewDataTextColumn>
      
                                                        <dx:GridViewDataTextColumn Caption="P4" FieldName="ProyectadoQ4"   VisibleIndex="8">
                                                          <EditFormSettings Visible="True" />
                                                            <Settings AllowAutoFilter="False" />
                                                      </dx:GridViewDataTextColumn>
                                                        
                                                        <dx:GridViewDataTextColumn FieldName="Total" ReadOnly="True"  VisibleIndex="9">
                                                          <EditFormSettings Visible="False" />
                                                            <Settings AllowAutoFilter="False" />
                                                      </dx:GridViewDataTextColumn>
                                                        <dx:GridViewCommandColumn   VisibleIndex="10"  Caption="Acción">
                                                            <UpdateButton Visible="true"></UpdateButton>
                                                            <EditButton Visible="true"></EditButton>
                                                      </dx:GridViewCommandColumn>

                                                        
                                                    </Columns>

                                                    <SettingsPager>
                                                        <AllButton Visible="True" Text="Todos">
                                                        </AllButton>
                                                    </SettingsPager>

<Settings ShowFilterRow="True"></Settings>

                                                </dx:ASPxGridView>
                                                  <asp:SqlDataSource ID="SqlDataSource3" runat="server" ConnectionString="<%$ ConnectionStrings:SUEPPSConnectionString %>"     
                                                      UpdateCommand="UPDATE [MetaYMonitoreoPorPeriodo] SET [Potenciales]=@Potenciales, [ProyectadoQ1]=@ProyectadoQ1, [ProyectadoQ2]=@ProyectadoQ2,[ProyectadoQ3]=@ProyectadoQ3 , [ProyectadoQ4]=@ProyectadoQ4 WHERE [IdMetaPorPeriodo]= @IdMetaPorPeriodo " 
                                                      SelectCommand="select MM.IdMetaPorPeriodo,AI.DescripcionAreaDeInfluencia,MM.Potenciales, MM.ProyectadoQ1,MM.ProyectadoQ2,(MM.ProyectadoQ1+MM.ProyectadoQ2) As S1,MM.ProyectadoQ3,MM.ProyectadoQ4,(MM.ProyectadoQ1 + MM.ProyectadoQ2 + MM.ProyectadoQ3 + MM.ProyectadoQ4) as Total from MetaYMonitoreoPorPeriodo MM join IndicadoresPorPrograma IP on IP.IdIndicadoresPorPrograma= MM.IdIndicadorPorPrograma join dbo.[AreasDeInfluencia] AI on MM.IdAreaDeInfluencia = AI.IdAreaDeInfluencia  where MM.IdIndicadorPorPrograma = @Indicador and MM.Ano= @Ano and MM.Activo=1 and AI.Activo=1 and IP.Activo=1 group by AI.DescripcionAreaDeInfluencia,MM.Potenciales,MM.ProyectadoQ1,MM.ProyectadoQ2,MM.ProyectadoQ3,MM.ProyectadoQ4,MM.IdMetaPorPeriodo">
                                                      <SelectParameters>
                                                            <asp:SessionParameter Name="Indicador"   />
                                                            <asp:SessionParameter Name="Ano" />
                                                     </SelectParameters> 
                                                                       
                                                   </asp:SqlDataSource>
                                                

                                               

                                             </dx:ContentControl>
                                             
                                         </ContentCollection>
                                         
                                     </dx:TabPage>



<%-- ######################################################################################################################################################################################### --%>


                                     <dx:TabPage Text="Doc. Planificación">

                                         <ContentCollection>
                                            <dx:ContentControl runat="server" SupportsDisabledAttribute="True">

                         <dx:ASPxPanel ID="Panel1" runat="server" >
                    <PanelCollection>
                        <dx:PanelContent >



        <table id="Table1">
        <tr>
            <td class="content">
                <table>
                    <tr>
                        <td style="padding-right: 20px; vertical-align: top;">
                            <table>
                                <tr>
                                    <td class="caption">
                                        <dx:ASPxLabel ID="ASPxLabel2" runat="server" Text="Documento:">
                                        </dx:ASPxLabel>
                                    </td>
                                    <td>
                                        <dx:ASPxUploadControl ID="ASPxUploadControl1" runat="server" ClientInstanceName="uploader" ShowProgressPanel="false"
                                            NullText="Seleccionar archivo..." Size="35" OnFileUploadComplete="uplImage_FileUploadComplete">
                                            <ClientSideEvents FileUploadComplete="function(s, e) { Uploader_OnFileUploadComplete(e); }"
                                                FilesUploadComplete="function(s, e) { Uploader_OnFilesUploadComplete(e); }"
                                                FileUploadStart="function(s, e) { Uploader_OnUploadStart(); }"
                                                TextChanged="function(s, e) { UpdateUploadButton(); }"></ClientSideEvents>
                                            <ValidationSettings MaxFileSize="4194304" >
                                            </ValidationSettings>
                                        </dx:ASPxUploadControl>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                    </td>
                                    <td class="note">
                                        <dx:ASPxLabel ID="lblAllowebMimeType" runat="server" Text="Subir Archivos de Planificación"
                                            Font-Size="8pt">
                                        </dx:ASPxLabel>
                                        <br />
                                        <dx:ASPxLabel ID="ASPxLabel5" runat="server" Text="Tamaño Máximo de Archivos: 4Mb" Font-Size="8pt">
                                        </dx:ASPxLabel>
                                    </td>
                                </tr>
                                <tr>
                                    <td colspan="2" class="buttonCell">
                                        <dx:ASPxButton ID="ASPxButton1" runat="server" AutoPostBack="False" Text="Subir" ClientInstanceName="btnUpload"
                                            Width="80px" ClientEnabled="False" style="margin: 0 auto;">
                                            <ClientSideEvents Click="function(s, e) { uploader.Upload(); }" />
                                        </dx:ASPxButton>
                                    </td>
                                </tr>
                            </table>
                        </td>
                        
                    </tr>
                </table>
            </td>
        </tr>
    </table>    


                        </dx:PanelContent>
                    </PanelCollection>
                
            </dx:ASPxPanel>
           

                        <dx:ASPxGridView ClientInstanceName="detailGrid" ID="ASPxGridView2" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSourceRecursos" KeyFieldName="IdDocumentoPrograma" IsDetailGrid="true" onbeforeperformdataselect="ASPxGridView2_BeforePerformDataSelect" Visible="True" SettingsEditing-EditFormColumnCount="1" OnLoad="ASPxGridView2_Load">
                            <Columns>
                                <dx:GridViewDataTextColumn FieldName="IdDocumentoPrograma" ReadOnly="True" VisibleIndex="0" Caption="#">
                                    <EditFormSettings Visible="False" />
                                </dx:GridViewDataTextColumn>
                                <dx:GridViewDataTextColumn FieldName="Enlace" VisibleIndex="1">
                                    <DataItemTemplate>
                                        <dx:ASPxHyperLink ID="ASPxHyperLink1" runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "Direccion")%>' NavigateUrl='<%# DataBinder.Eval(Container.DataItem, "Enlace")%>'> 
                                        </dx:ASPxHyperLink>
                                    
                                    </DataItemTemplate>
                                </dx:GridViewDataTextColumn>
                                <dx:GridViewDataTextColumn FieldName="IdPrograma" VisibleIndex="2" Visible="false">
                                </dx:GridViewDataTextColumn>
                                <dx:GridViewDataTextColumn FieldName="CreadoPor" VisibleIndex="3" Visible="false">
                                </dx:GridViewDataTextColumn>
                                <dx:GridViewDataDateColumn FieldName="FechaCreacion" VisibleIndex="4" Visible="false">
                                </dx:GridViewDataDateColumn>
                                <dx:GridViewDataTextColumn FieldName="ActualizadoPor" VisibleIndex="5" Visible="false">
                                </dx:GridViewDataTextColumn>
                                <dx:GridViewDataDateColumn FieldName="FechaActualizacion" VisibleIndex="6" Visible="false">
                                </dx:GridViewDataDateColumn>
                                <dx:GridViewDataCheckColumn FieldName="Activo" VisibleIndex="7" Visible="false">
                                </dx:GridViewDataCheckColumn>
                                 <dx:GridViewCommandColumn VisibleIndex="8" HeaderStyle-HorizontalAlign="Center" Caption="Acción" CellStyle-HorizontalAlign="NotSet">
                                        
                                        <%--<NewButton Visible="true" />--%>
                              
                                        <DeleteButton Visible="true"/>
                                        <HeaderStyle HorizontalAlign="Center"></HeaderStyle>
                            
                                </dx:GridViewCommandColumn>


                                
                            </Columns>

<SettingsEditing EditFormColumnCount="1"></SettingsEditing>
                            <SettingsPager>
                                                        <AllButton Visible="True" Text="Todos">
                                                        </AllButton>
                                                    </SettingsPager>
                        </dx:ASPxGridView>
                        

            <asp:SqlDataSource runat="server" ID="SqlDataSourceRecursos" ConnectionString='<%$ ConnectionStrings:SUEPPSConnectionString %>' OnInserted="SqlDataSourceRecursos_Inserted"
                SelectCommand="SELECT * FROM [DocumentosPorPrograma] WHERE ([IdPrograma] = @IdPrograma)"
                InsertCommand="INSERT INTO  [DocumentosPorPrograma] ([Enlace], [Direccion], [IdPrograma], [CreadoPor], [FechaCreacion], [Activo]) VALUES (@EnlaceP, @NombreP, @IdProgramaP, @Usuario, getDate(), 1)"
                UpdateCommand="UPDATE [DocumentosPorPrograma] SET ([Enlace]=@Enlace, [IdPrograma]=@IdPrograma, [CreadoPor]='hola', [FechaCreacion]=getDate(), [Activo]=1) WHERE ([IdPrograma] = @IdPrograma)" 
                DeleteCommand="UPDATE [DocumentosPorPrograma] SET ([Activo]=0) WHERE ([IdPrograma] = @IdPrograma) "
                >
                <SelectParameters>
                    <asp:SessionParameter SessionField="IdPrograma" Name="IdPrograma" Type="Int32"></asp:SessionParameter>
                </SelectParameters>

                <InsertParameters>
                    <asp:SessionParameter SessionField="Enlace" Name="EnlaceP" Type="String"></asp:SessionParameter>
                    <asp:SessionParameter SessionField="IdProgramaP" Name="IdProgramaP" Type="String"></asp:SessionParameter>
                    <asp:SessionParameter SessionField="Nombre" Name="NombreP" Type="String"></asp:SessionParameter>
                    <asp:SessionParameter Name="Usuario" />
                </InsertParameters>
            </asp:SqlDataSource>
      

       

                                            </dx:ContentControl>
                                            
                                         
                                         </ContentCollection>

                                     </dx:TabPage>

                                 </TabPages>
                            </dx:ASPxPageControl>
                            </div>
                           

    </div>



    </div>
</asp:Content>

