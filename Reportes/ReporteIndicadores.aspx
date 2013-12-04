<%@ Page Language="VB" AutoEventWireup="false" CodeFile="ReporteIndicadores.aspx.vb" Inherits="Reportes_ReporteIndicadores" MasterPageFile="~/Site.master" %>

<%@ Register Src="~/MOCA_UE.ascx" TagPrefix="uc1" TagName="MOCA_UE" %>


<asp:Content ID="cHeader" ContentPlaceHolderID="HeadContent" Runat="Server">
</asp:Content>
<asp:Content ID="cBody" ContentPlaceHolderID="MainContent" Runat="Server">
    <uc1:MOCA_UE runat="server" ID="MOCA_UE01" />
<script type="text/javascript">
    // <![CDATA[
    function AddSelectedItems() {
        MoveSelectedItems(lbAvailable, lbChoosen);
        UpdateButtonState();
    }
    function AddAllItems() {
        MoveAllItems(lbAvailable, lbChoosen);
        UpdateButtonState();
    }
    function RemoveSelectedItems() {
        MoveSelectedItems(lbChoosen, lbAvailable);
        UpdateButtonState();
    }
    function RemoveAllItems() {
        MoveAllItems(lbChoosen, lbAvailable);
        UpdateButtonState();
    }
    function MoveSelectedItems(srcListBox, dstListBox) {
        srcListBox.BeginUpdate();
        dstListBox.BeginUpdate();
        var items = srcListBox.GetSelectedItems();
        for (var i = items.length - 1; i >= 0; i = i - 1) {
            dstListBox.AddItem(items[i].text, items[i].value);
            srcListBox.RemoveItem(items[i].index);
        }
        srcListBox.EndUpdate();
        dstListBox.EndUpdate();
        lbChoosen.SelectAll();
    }
    function MoveAllItems(srcListBox, dstListBox) {
        srcListBox.BeginUpdate();
        var count = srcListBox.GetItemCount();
        for (var i = 0; i < count; i++) {
            var item = srcListBox.GetItem(i);
            dstListBox.AddItem(item.text, item.value);
        }
        srcListBox.EndUpdate();
        srcListBox.ClearItems();
        lbChoosen.SelectAll();
    }
    function UpdateButtonState() {
        btnMoveAllItemsToRight.SetEnabled(lbAvailable.GetItemCount() > 0);
        btnMoveAllItemsToLeft.SetEnabled(lbChoosen.GetItemCount() > 0);
        btnMoveSelectedItemsToRight.SetEnabled(lbAvailable.GetSelectedItems().length > 0);
        btnMoveSelectedItemsToLeft.SetEnabled(lbChoosen.GetSelectedItems().length > 0);
       
    }

    //Combos
    function OncmbPoliticaChanged(cmbPolitica) {
        
        cmbComponente.PerformCallback(cmbPolitica.GetValue().toString());
    }

    function OncmbComponenteChanged(cmbComponente) {
        
        cmbMetas.PerformCallback(cmbComponente.GetValue().toString());
    }

    function OncmbMetaChanged(cmbMetas) {
        lbAvailable.PerformCallback(cmbMetas.GetValue().toString());
        
    }

    // ]]> 
    </script>

    <div>
        <%-- Combos --%>
        <table>

                <tr>
                    <td>
                        <dx:ASPxLabel runat="server" Text="Año:" ID="ASPxLabelAno" AssociatedControlID="ASPxComboBoxAno" />
                        <dx:ASPxComboBox ID="ASPxComboBoxAno" runat="server" ValueType="System.String"></dx:ASPxComboBox>
                    </td>
                    <td>
                        <dx:ASPxLabel runat="server" Text="Politica:" ID="lblPolitica" AssociatedControlID="cmbPolitica" />
                        <dx:ASPxComboBox runat="server" id="cmbPolitica" dropdownstyle="DropDownList" incrementalfilteringmode="StartsWith"
                            datasourceid="SqlDataSourcePoliticas" textfield="Nombre" valuefield="IdPolitica"
                            enablesynchronization="False" ClientInstanceName="cmbPolitica">
                            <ClientSideEvents SelectedIndexChanged="function(s, e) { OncmbPoliticaChanged(s); }" />    
                        </dx:ASPxComboBox>
                        <asp:SqlDataSource ID="SqlDataSourcePoliticas" runat="server" ConnectionString='<%$ ConnectionStrings:SUEPPSConnectionString %>' 
                             SelectCommand="SELECT [IdPolitica], [Nombre] FROM [Politicas] WHERE Activo = 1">
                        </asp:SqlDataSource>


                    </td>

                                     

                    <td>

                        <dx:ASPxLabel runat="server" Text="Componente:" ID="lblComponente" AssociatedControlID="cmbComponente" />
                        <dx:ASPxComboBox runat="server" id="cmbComponente" clientinstancename="cmbComponente"  OnCallback="cmbComponente_Callback"
                            dropdownstyle="DropDown" datasourceid="SqlDataSourceComponentes" textfield="Nombre"
                            valuefield="IdComponentesDePolitica" incrementalfilteringmode="StartsWith" enablesynchronization="False"> 
                                <ClientSideEvents SelectedIndexChanged="function(s, e) { OncmbComponenteChanged(s); }" />
                        </dx:ASPxComboBox>  
                         
                        <asp:SqlDataSource ID="SqlDataSourceComponentes" runat="server" ConnectionString='<%$ ConnectionStrings:SUEPPSConnectionString %>' 
                          SelectCommand="SELECT [IdComponentesDePolitica], [IdPolitica], [Nombre] FROM [ComponentesDePolitica] WHERE [IdPolitica]=@IdPolitica AND Activo=1">
                          <SelectParameters>
                            <asp:SessionParameter Name="IdPolitica" />
                          </SelectParameters>
                        </asp:SqlDataSource>
                                                 
                    </td>

                    <td>

                        <dx:ASPxLabel runat="server" Text="Metas:" ID="lblMetas" AssociatedControlID="cmbMetas" />
                        <dx:ASPxComboBox runat="server" id="cmbMetas" clientinstancename="cmbMetas"  OnCallback="cmbMetas_Callback"
                            dropdownstyle="DropDown" datasourceid="SqlDataSourceMetas" textfield="Nombre"
                            valuefield="IdMetasDeComponente" incrementalfilteringmode="StartsWith" enablesynchronization="False"> 
                                <ClientSideEvents SelectedIndexChanged="function(s, e) { OncmbMetaChanged(s); }" />
                        </dx:ASPxComboBox>    
                           
                        <asp:SqlDataSource ID="SqlDataSourceMetas" runat="server" ConnectionString='<%$ ConnectionStrings:SUEPPSConnectionString %>' 
                          SelectCommand="SELECT [IdMetasDeComponente], [IdComponentesDePolitica], [Nombre] FROM [MetasDeComponente] WHERE [IdComponentesDePolitica]=@IdComponentesDePolitica AND Activo=1">
                          <SelectParameters>
                            <asp:SessionParameter Name="IdComponentesDePolitica" />
                          </SelectParameters>
                        </asp:SqlDataSource>
                    </td>

                </tr>


                </table>

        <%-- Dual ListBox --%>
        <table>
        <tr>
            <td>
                <%--  --%>
                <dx:ASPxListBox ID="lbAvailable" runat="server" ClientInstanceName="lbAvailable" DataSourceID="SqlDataSourceIndicadoresDeMeta" TextField="DescripcionIndicador" 
                     ValueField="IdIndicador" SelectionMode="CheckColumn" OnInit="lbAvailable_Init"  OnCallback="lbAvailable_Callback">
                    <ClientSideEvents SelectedIndexChanged="function(s, e) { UpdateButtonState(); }" />
                    
                </dx:ASPxListBox>
                               
                <asp:SqlDataSource ID="SqlDataSourceIndicadoresDeMeta" runat="server" ConnectionString='<%$ ConnectionStrings:SUEPPSConnectionString %>'>
                    <SelectParameters>
                        <asp:SessionParameter Name="IdMetasDeComponente" />
                    </SelectParameters>
                </asp:SqlDataSource>
                <asp:SqlDataSource runat="server" ID="SqlDataSourcePoliticasComboGrid" ConnectionString='<%$ ConnectionStrings:SUEPPSConnectionString %>' 
                SelectCommand="SELECT [IdPolitica], [Nombre] FROM [Politicas]"></asp:SqlDataSource>
           
            </td>


            <td>
                <dx:ASPxButton ID="btnMoveSelectedItemsToRight" runat="server" ClientInstanceName="btnMoveSelectedItemsToRight"
                        AutoPostBack="False" Text=">" Width="130px" Height="23px" ClientEnabled="False"
                        ToolTip="Add selected items">
                        <ClientSideEvents Click="function(s, e) { AddSelectedItems(); }" />
                </dx:ASPxButton>


                <dx:ASPxButton ID="btnMoveAllItemsToRight" runat="server" ClientInstanceName="btnMoveAllItemsToRight"
                        AutoPostBack="False" Text=">>" Width="130px" Height="23px" ToolTip="Add all items">
                        <ClientSideEvents Click="function(s, e) { AddAllItems(); }" />
                </dx:ASPxButton>

                <dx:ASPxButton ID="btnMoveSelectedItemsToLeft" runat="server" ClientInstanceName="btnMoveSelectedItemsToLeft"
                        AutoPostBack="False" Text="<" Width="130px" Height="23px" ClientEnabled="False"
                        ToolTip="Remove selected items">
                        <ClientSideEvents Click="function(s, e) { RemoveSelectedItems(); }" />
                </dx:ASPxButton>

                <dx:ASPxButton ID="btnMoveAllItemsToLeft" runat="server" ClientInstanceName="btnMoveAllItemsToLeft"
                        AutoPostBack="False" Text="<<" Width="130px" Height="23px" ClientEnabled="False"
                        ToolTip="Remove all items">
                        <ClientSideEvents Click="function(s, e) { RemoveAllItems(); }" />
                </dx:ASPxButton>
            </td>


            <td>
                <dx:ASPxListBox ID="lbChoosen" runat="server" ClientInstanceName="lbChoosen" 
                    SelectionMode="CheckColumn">
                    <ClientSideEvents SelectedIndexChanged="function(s, e) { UpdateButtonState(); }">
                    </ClientSideEvents>
                </dx:ASPxListBox>

            </td>

        </tr>
        <tr>
            <dx:ASPxButton ID="ASPxButtonGraficar" runat="server" Text="Graficar" OnClick="ASPxButtonGraficar_Click"></dx:ASPxButton>
            
            <dx:WebChartControl ID="chart" runat="server" Width="500" Height="300"></dx:WebChartControl>

            <dx:ASPxGridView ID="ASPxGridViewIndicadoresGraficar" runat="server" DataSourceID="SqlDataSourceIndicadoresMetasGraficar" Visible="false"></dx:ASPxGridView>

            <asp:SqlDataSource ID="SqlDataSourceIndicadoresMetasGraficar" runat="server" ConnectionString='<%$ ConnectionStrings:SUEPPSConnectionString %>'>
                <SelectParameters>
                    <asp:SessionParameter Name="IdMetasDeComponente" />
                    <asp:SessionParameter Name="Ano" />
                    <asp:SessionParameter Name="IdIndicador" />
                </SelectParameters>
            </asp:SqlDataSource>

        </tr>
        </table>
    </div>
</asp:Content>