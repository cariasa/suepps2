<%@ Page Title="Monitoreo" Language="VB" AutoEventWireup="false" CodeFile="Monitoreo.aspx.vb" Inherits="GestionPublica_Monitoreo"  MasterPageFile="~/Site.master" %>
<%@ Register Assembly="DevExpress.Web.v13.2, Version=13.2.5.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web.ASPxGridView" TagPrefix="dx" %>
<%@ Register TagPrefix="dx" Namespace="DevExpress.Web.ASPxEditors" Assembly="DevExpress.Web.v13.2, Version=13.2.5.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" %>
<%@ Register Assembly="DevExpress.Web.v13.2, Version=13.2.5.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web.ASPxMenu" TagPrefix="dx" %>

<%@ Register Src="~/MOCA_UE.ascx" TagPrefix="uc1" TagName="MOCA_UE" %>


<asp:Content ID="cHeader" ContentPlaceHolderID="HeadContent" Runat="Server">
</asp:Content>
<asp:Content ID="cBody" ContentPlaceHolderID="MainContent" Runat="Server">
    <uc1:MOCA_UE runat="server" ID="MOCA_UE01" />
    <%-- prueba --%>
      
        <div>
              <dx:ASPxLabel runat="server" Text="Políticas:" ID="Políticas" AssociatedControlID="comboPolitica" />
              <dx:ASPxComboBox ID="comboPolitica" runat="server" ValueField="IdPolitica"
                    TextField="Politica" ValueType="System.String" DataSourceID="SqlDataSourcepoliticas" EnableClientSideAPI="true" Height="16px" Width="801px" >

                    <ClientSideEvents SelectedIndexChanged="function(s, e) { grid.PerformCallback(s.GetValue()); }"> </ClientSideEvents>
              </dx:ASPxComboBox>
                             

        </div>

 <div>
     <dx:ASPxGridView runat="server" ID="grid" ClientInstanceName="grid"  AutoGenerateColumns="False" DataSourceID="SqlDataSourceProyectos"  OnCustomCallback="grid_custom" KeyFieldName="codigo_ficha" Width="100%" Settings-ShowFilterRow="true" OnLoad="grid_Load" Settings-ShowFilterRowMenu="true">


       
        <Columns>

            <dx:GridViewDataTextColumn FieldName="codigo_ficha" ShowInCustomizationForm="True" VisibleIndex="0" Caption="Id" Visible="false">        </dx:GridViewDataTextColumn>
            
            <dx:GridViewDataTextColumn FieldName="NombreProyecto" ShowInCustomizationForm="True" VisibleIndex="1" Caption="Nombre">  
                <Settings AutoFilterCondition="Contains" />
            </dx:GridViewDataTextColumn>
            
            <dx:GridViewDataTextColumn FieldName="codigo_proyecto" ShowInCustomizationForm="True" VisibleIndex="2" Caption="Código Proyecto">      
                <Settings AutoFilterCondition="Contains" />
            </dx:GridViewDataTextColumn>
                                    
            <dx:GridViewDataTextColumn FieldName="Enfoque" ShowInCustomizationForm="True" VisibleIndex="3" Caption="Enfoque" UnboundType="String" Visible="false">                                 </dx:GridViewDataTextColumn>
            
            <dx:GridViewDataTextColumn FieldName="Acción" ShowInCustomizationForm="True" VisibleIndex="4" Caption="Acción" UnboundType="String">
            <DataItemTemplate>
                <asp:LinkButton id="linkMonitoreo"  Text="Monitoreo Cuantitativo" runat="server" OnClick="send" /> <br />
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

       <asp:SqlDataSource ID="SqlDataSourceProyectos" runat="server" ConnectionString="<%$ ConnectionStrings:SUEPPSConnectionString %>" >
             
                            
        </asp:SqlDataSource>

       <asp:SqlDataSource ID="SqlDataSourcePoliticas" runat="server" ConnectionString="<%$ ConnectionStrings:SUEPPSConnectionString %>" 
           SelectCommand="SELECT distinct([Politica]),[IdPolitica] FROM [vProyectos]">
       </asp:SqlDataSource>

    </div>
</asp:Content>
