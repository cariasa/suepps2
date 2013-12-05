﻿<%@ Page Language="VB" AutoEventWireup="false" CodeFile="Plantillas.aspx.vb" Inherits="Cuantitativo_Plantilla" MasterPageFile="~/Site.master" %>

<%@ Register Assembly="DevExpress.Web.v13.1, Version=13.1.8.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a"
    Namespace="DevExpress.Web.ASPxEditors" TagPrefix="dx" %>

<%@ Register Assembly="DevExpress.Web.v13.1, Version=13.1.8.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a"
    Namespace="DevExpress.Web.ASPxGridView" TagPrefix="dx" %>

<%@ Register Src="~/MOCA_UE.ascx" TagPrefix="uc1" TagName="MOCA_UE" %>

<asp:Content ID="cHeader" ContentPlaceHolderID="HeadContent" Runat="Server">
</asp:Content>
<asp:Content ID="cBody" ContentPlaceHolderID="MainContent" Runat="Server">
    <uc1:MOCA_UE runat="server" ID="MOCA_UE01" />

    <div>
        
  

        <dx:ASPxGridView ID="ASPxGridView1" runat="server" AutoGenerateColumns="False"  Settings-ShowFilterRow="true" Settings-ShowFilterRowMenu="true"
            DataSourceID="SqlDataSource1" KeyFieldName="IdPlantilla">
            <Columns>
       
                <dx:GridViewDataTextColumn FieldName="IdPlantilla" Caption="Plantilla" ReadOnly="True" 
                    VisibleIndex="1" Visible="false">
                    <EditFormSettings Visible="False" />
                </dx:GridViewDataTextColumn>

                 <dx:GridViewDataComboBoxColumn VisibleIndex="2" FieldName="IdSector" 
                    Caption="Sector">
                    <EditFormSettings ColumnSpan="2" />
                        <PropertiesComboBox ValueType="System.String" 
                
                            DataSourceID="Sqlsector" 
                            ValueField="IdSectorIndicador" 
                            TextField="DescripcionSectorIndicador"/>
                         <Settings AllowAutoFilter="True" />
                                    <Settings AutoFilterCondition="Contains" />
                                    <Settings FilterMode="DisplayText" />     
                  </dx:GridViewDataComboBoxColumn>

                <dx:GridViewDataTextColumn FieldName="NombrePlantilla" Caption="Nombre" VisibleIndex="3">
                <EditFormSettings ColumnSpan="2" />
               
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="DescripcionPlantilla" Caption="Descripción" VisibleIndex="4">
                 <EditFormSettings ColumnSpan="2" />
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="CreadoPor" VisibleIndex="5" 
                    Visible="false">
                 <EditFormSettings Visible="False" />
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataDateColumn FieldName="FechaCreacion" VisibleIndex="6" 
                    Visible="false">
                 <EditFormSettings Visible="False" />
                </dx:GridViewDataDateColumn>
                <dx:GridViewDataTextColumn FieldName="ActualizadoPor" VisibleIndex="7" 
                    Visible="false">
                 <EditFormSettings Visible="False" />
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataDateColumn FieldName="FechaActualizacion" VisibleIndex="8" 
                    Visible="false">
                 <EditFormSettings Visible="False" />

                </dx:GridViewDataDateColumn>

                 <dx:GridViewDataDateColumn FieldName="Activo" VisibleIndex="9" 
                    Visible="false">
                </dx:GridViewDataDateColumn>

                <dx:GridViewCommandColumn VisibleIndex="9" HeaderStyle-HorizontalAlign="Center" Caption="Acción" CellStyle-HorizontalAlign="NotSet">
                    
                    <NewButton Visible="True">
                    </NewButton>
                    <EditButton Visible="True">
                    </EditButton>
                    <DeleteButton Visible="True">
                    </DeleteButton>
                    <HeaderStyle HorizontalAlign="Center"></HeaderStyle>
                </dx:GridViewCommandColumn>

                 <dx:GridViewDataTextColumn VisibleIndex="10" 
                    Caption="Planificar" UnboundType="String">
                                      <DataItemTemplate>
                                          <asp:LinkButton id="link1"  Text="Planificar Plantilla" runat="server" OnClick="send" /> 
                                      </DataItemTemplate>  
                                        <Settings AllowAutoFilter="False" />
                                        <EditFormSettings Visible="False" />
                 </dx:GridViewDataTextColumn>

               


            </Columns>
        <SettingsPager>
                <AllButton Visible="True" Text="Todos">
                </AllButton>
            </SettingsPager>

        <SettingsBehavior AllowFocusedRow="True" />

        
        

        </dx:ASPxGridView>

        <asp:SqlDataSource ID="SqlDataSource1" runat="server" 
            ConnectionString="<%$ ConnectionStrings:SUEPPSConnectionString %>" 
            SelectCommand="SELECT * FROM [Plantillas] WHERE [Activo]=1"
                UpdateCommand="UPDATE [Plantillas] SET [IdSector]=@IdSector, [NombrePlantilla]=@NombrePlantilla, [DescripcionPlantilla]=@DescripcionPlantilla,[ActualizadoPor]='PACO', [FechaActualizacion]=getDate() WHERE  [IdPlantilla] = @IdPlantilla"
                InsertCommand="INSERT INTO Plantillas (IdSector, NombrePlantilla, DescripcionPlantilla, CreadoPor, FechaCreacion, Activo) VALUES (@IdSector, @NombrePlantilla, @DescripcionPlantilla,'PACO',getDate(),1)"
                DeleteCommand="UPDATE [Plantillas] SET [Activo]=0 WHERE [IdPlantilla] = @IdPlantilla"
        ></asp:SqlDataSource>

        <asp:SqlDataSource ID="Sqlsector" runat="server" ConnectionString="<%$ ConnectionStrings:SUEPPSConnectionString %>" SelectCommand="SELECT [DescripcionSectorIndicador],[IdSectorIndicador] FROM [vROISectorIndicadores]"> </asp:SqlDataSource>

    </div>
 </asp:Content>
