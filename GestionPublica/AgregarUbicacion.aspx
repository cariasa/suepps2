<%@ Page Language="VB" AutoEventWireup="false" CodeFile="AgregarUbicacion.aspx.vb" Inherits="GestionPublica_AgregarUbicacion" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title></title>
</head>
<script type="text/javascript">

    function clear() {
        ComboDepartamentos.PerformCallback();
        ComboMunicipios.PerformCallback();
        ComboAldeas.PerformCallback();
        ComboCaserio.PerformCallback();
        ComboBarrio.PerformCallback();

    }


    function OnDepartamentosChanged(ComboDepartamentos) {

        ComboMunicipios.PerformCallback(ComboDepartamentos.GetValue().toString());
    }
    function OnMunicipiosChanged(ComboMunicipios) {
        ComboAldeas.PerformCallback(ComboMunicipios.GetValue().toString());
    }
    function OnAldeasChanged(ComboAldeas) {
        ComboCaserio.PerformCallback(ComboAldeas.GetValue().toString());
    }
    function OnCaseriosChanged(ComboCaserio) {
        ComboBarrio.PerformCallback(ComboCaserio.GetValue().toString());
    }

    function OnSectorChanged(Combosector) {
        GridIndicadores.PerformCallback();
    }


    function OnAñoChanged(ComboAño) {
        GridMetas.PerformCallback();
    }

    function OnInserterAreaInfluencia() {
        ComboAreaInfluencia.PerformCallback();
    }


    function click(e) {


        if (e.tab.index.toString() == "2") {
            combosector.PerformCallback();
            GridIndicadores.PerformCallback(1);
        }

        if (e.tab.index.toString() == "3") {
            ComboAreaInfluencia.PerformCallback();
            comboAño.PerformCallback();
            GridMetas.PerformCallback(1);
        }
    }



    function Uploader_OnUploadStart() {
        btnUpload.SetEnabled(false);
    }

    function Uploader_OnFileUploadComplete(args) {
        pcLogin.Hide();
        detailGrid.Refresh();
        btnUpload.SetEnabled(true);

    }

    function Uploader_OnFilesUploadComplete(args) {

        UpdateUploadButton();

    }

    function UpdateUploadButton() {
        btnUpload.SetEnabled(uploader.GetText(0) != "");
    }

    
    function guid() {
        function _p8(s) {
            var p = (Math.random().toString(16) + "000000000").substr(2, 8);
            return s ? "-" + p.substr(0, 4) + "-" + p.substr(4, 4) : p;
        }
        return _p8() + _p8(true) + _p8(true) + _p8();
    }


</script>
<body>
    <form id="form1" runat="server">
    <div>
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

                                            <dx:ASPxGridView ID="ASPxGridViewUbicacionAreaDeInfluencia" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSourceUbicacionArea" ClientInstanceName="ASPxGridViewUbicacionAreaDeInfluencia"
                                              KeyFieldName="IdUbicacionPorAreaDeInfluencia" >
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

                                            <asp:SqlDataSource runat="server" ID="SqlDataSourceUbicacionArea" ConnectionString='<%$ ConnectionStrings:SUEPPSConnectionString %>' OnInserted="SqlDataSourceUbicacionArea_Inserted"
                                                    SelectCommand="SELECT * FROM [UbicacionPorAreaDeInfluencia] WHERE [IdAreaDeInfluencia]=@IdAreaDeInfluencia AND [Activo]=1"
                                                    DeleteCommand="UPDATE [UbicacionPorAreaDeInfluencia] SET [Activo] = 0 WHERE [IdUbicacionPorAreaDeInfluencia] = @IdUbicacionPorAreaDeInfluencia"
                                                     >
                                                    <SelectParameters>
                    
                                                        <asp:SessionParameter SessionField="IdAreaDeInfluencia" Name="IdAreaDeInfluencia" Type="Int32"></asp:SessionParameter>
                
                                                    </SelectParameters>
                                                    
                                              </asp:SqlDataSource>



    </div>
    </form>
</body>
</html>
