<%@ Page Language="VB" AutoEventWireup="false" CodeFile="Condiciones.aspx.vb" Inherits="Evaluacion_Condiciones"  MasterPageFile="~/Site.master"%>

<%@ Register Src="~/MOCA_UE.ascx" TagPrefix="uc1" TagName="MOCA_UE" %>

<asp:Content ID="cHeader" ContentPlaceHolderID="HeadContent" Runat="Server">
</asp:Content>
<asp:Content ID="cBody" ContentPlaceHolderID="MainContent" Runat="Server">
    <uc1:MOCA_UE runat="server" ID="MOCA_UE01" />

    <div>
        <table>
            <tr>
                <dx:ASPxLabel ID="ASPxLabelVariable" runat="server" ></dx:ASPxLabel>
            </tr>
            <tr>
                <td>
                    <dx:ASPxLabel ID="ASPxLabelTitulo" runat="server" Text="Asociación de Instrumento AVANZADO" ></dx:ASPxLabel>
                </td>
                <td>
                    <dx:ASPxLabel ID="espacio" runat="server" Text=" " Width="360"></dx:ASPxLabel>
                    <dx:ASPxHyperLink ID="ASPxHyperLinkRegresar" runat="server" Text="Atras" NavigateUrl="Parametros.aspx">
                    </dx:ASPxHyperLink>
                </td>
            </tr>
        
        </table>
        
        <dx:ASPxGridView ID="ASPxGridViewCondiciones" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSourceCondiciones" KeyFieldName="IdCondicion">
            <Columns>
                <dx:GridViewDataTextColumn FieldName="IdCondicion" ReadOnly="True" VisibleIndex="0" Caption="ID">
                    <EditFormSettings Visible="False"></EditFormSettings>
                </dx:GridViewDataTextColumn>
               
                <dx:GridViewDataComboBoxColumn VisibleIndex="1" FieldName="IdVariable" Caption="Variable" EditFormSettings-Visible="False">
                        <PropertiesComboBox ValueType="System.String" 
                
                            DataSourceID="SqlDataSourceVariable" 
                            ValueField="IdVariable" 
                            TextField="NombreVariable"/>
                         <Settings AllowAutoFilter="True" />
                                    <Settings AutoFilterCondition="Contains" />
                                    <Settings FilterMode="DisplayText" />
     
                    
                </dx:GridViewDataComboBoxColumn>
                            
                <dx:GridViewDataComboBoxColumn VisibleIndex="2" FieldName="IdTipoCondicion" Caption="Tipo Condicion" EditFormSettings-Visible="True">
                        <PropertiesComboBox ValueType="System.String" 
                
                            DataSourceID="SqlDataSourceTipoCondicion" 
                            ValueField="IdTipoCondicion" 
                            TextField="DescripcionTipoCondicion"/>
                         <Settings AllowAutoFilter="True" />
                                    <Settings AutoFilterCondition="Contains" />
                                    <Settings FilterMode="DisplayText" />
     
                    
                </dx:GridViewDataComboBoxColumn>
                
                
                <dx:GridViewDataTextColumn FieldName="NombreCondicion" VisibleIndex="3" Caption="Nombre"></dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="DescripcionCondicion" VisibleIndex="4" Caption="Descripción"></dx:GridViewDataTextColumn>
                <dx:GridViewDataCheckColumn FieldName="Raiz" VisibleIndex="5"></dx:GridViewDataCheckColumn>
                <dx:GridViewDataTextColumn FieldName="Operando1" VisibleIndex="6" Caption="Identificador"></dx:GridViewDataTextColumn>
                <%--<dx:GridViewDataTextColumn FieldName="Operador" VisibleIndex="7"></dx:GridViewDataTextColumn>--%>

                <dx:GridViewDataComboBoxColumn FieldName="Operador" VisibleIndex="7">
                    <PropertiesComboBox>
                        <Items>
                            <dx:ListEditItem Text="=" Value="=" />
                            <dx:ListEditItem Text="<" Value="<" />
                            <dx:ListEditItem Text="<=" Value="<=" />
                            <dx:ListEditItem Text=">" Value=">" />
                            <dx:ListEditItem Text=">=" Value=">=" />
                            <dx:ListEditItem Text="Contenido" Value=">" />
                            <dx:ListEditItem Text="AND" Value="AND" />
                            <dx:ListEditItem Text="OR" Value="OR" />
                        </Items>
                    </PropertiesComboBox>
                </dx:GridViewDataComboBoxColumn>
               
                <dx:GridViewDataTextColumn FieldName="Operando2" VisibleIndex="8" Caption="Identificador"></dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="CreadoPor" VisibleIndex="9" Visible="false"></dx:GridViewDataTextColumn>
                <dx:GridViewDataDateColumn FieldName="FechaCreacion" VisibleIndex="10" Visible="false"></dx:GridViewDataDateColumn>
                <dx:GridViewDataTextColumn FieldName="ActualizadoPor" VisibleIndex="11" Visible="false"></dx:GridViewDataTextColumn>
                <dx:GridViewDataDateColumn FieldName="FechaActualizacion" VisibleIndex="12" Visible="false"></dx:GridViewDataDateColumn>
                <dx:GridViewDataCheckColumn FieldName="Activo" VisibleIndex="13" Visible="false"></dx:GridViewDataCheckColumn>
                <dx:GridViewCommandColumn>
                    <NewButton Visible="true"></NewButton>
                    <EditButton Visible="true"></EditButton>
                    <DeleteButton Visible="true"></DeleteButton>
                </dx:GridViewCommandColumn>
            </Columns>
        </dx:ASPxGridView>
        <asp:SqlDataSource runat="server" ID="SqlDataSourceCondiciones" ConnectionString='<%$ ConnectionStrings:SUEPPSConnectionString %>' 
            SelectCommand="SELECT * FROM [Condiciones] WHERE [IdVariable]=@IdVariable AND [Activo]=1"
            InsertCommand="INSERT INTO [Condiciones] (IdVariable, IdTipoCondicion, NombreCondicion, DescripcionCondicion, Raiz, Operando1, Operador,  Operando2, CreadoPor, FechaCreacion) VALUES (@IdVariable, @IdTipoCondicion, @NombreCondicion, @DescripcionCondicion, @Raiz, @Operando1, @Operador,  @Operando2, 'SUEPPS', getDate())" 
            UpdateCommand="UPDATE [Condiciones] SET [IdTipoCondicion]=@IdTipoCondicion, NombreCondicion=@NombreCondicion, DescripcionCondicion=@DescripcionCondicion, Raiz=@Raiz, Operando1=@Operando1, Operador=@Operador, Operando2=@Operando2, ActualizadoPor='SUEPPS', FechaActualizacion=getDate() WHERE IdCondicion=@IdCondicion"
            DeleteCommand="UPDATE [Condiciones] SET [Activo]=0 WHERE IdCondicion=@IdCondicion">
            <SelectParameters>
               <asp:SessionParameter SessionField="IdVariable" Name="IdVariable" Type="Int32"></asp:SessionParameter>
             </SelectParameters>
            <InsertParameters>
                <asp:SessionParameter SessionField="IdVariable" Name="IdVariable" Type="Int32"></asp:SessionParameter>
                <asp:FormParameter Name="IdTipoCondicion" />
                <asp:FormParameter Name="NombreCondicion" />
                <asp:FormParameter Name="DescripcionCondicion" />
                <asp:FormParameter Name="Raiz" />
                <asp:FormParameter Name="Operando1" />
                <asp:FormParameter Name="Operador" />
                <asp:FormParameter Name="Operando2" />
            </InsertParameters>
        </asp:SqlDataSource>

        <asp:SqlDataSource runat="server" ID="SqlDataSourceTipoCondicion" ConnectionString='<%$ ConnectionStrings:SUEPPSConnectionString %>'
            SelectCommand="SELECT IdTipoCondicion, DescripcionTipoCondicion FROM [TiposCondiciones]">

        </asp:SqlDataSource>

        <asp:SqlDataSource runat="server" ID="SqlDataSourceVariable" ConnectionString='<%$ ConnectionStrings:SUEPPSConnectionString %>'
            SelectCommand="SELECT IdVariable, NombreVariable FROM [Variables]">

        </asp:SqlDataSource>
    </div>
 </asp:Content>