﻿<%@ Page Language="VB" AutoEventWireup="false" CodeFile="Levantamientos.aspx.vb" Inherits="Evaluacion_Levantamientos" MasterPageFile="~/Site.master" %>

<%@ Register Src="~/MOCA_UE.ascx" TagPrefix="uc1" TagName="MOCA_UE" %>

<asp:Content ID="cHeader" ContentPlaceHolderID="HeadContent" Runat="Server">
</asp:Content>
<asp:Content ID="cBody" ContentPlaceHolderID="MainContent" Runat="Server">
    <uc1:MOCA_UE runat="server" ID="MOCA_UE01" />
    
    <div>

        <dx:ASPxGridView ID="ASPxGridView1" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSource1" KeyFieldName="IdPolitica" SettingsDetail-ShowDetailRow="true">
            <Columns>
                <dx:GridViewDataTextColumn FieldName="IdPolitica" ReadOnly="True" VisibleIndex="0" Visible="false">
                    <EditFormSettings Visible="False" />
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Nombre" Caption="Política" VisibleIndex="1">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="SujetosDeAtencion" Caption="Sujetos de Atención" VisibleIndex="2">
                </dx:GridViewDataTextColumn>
            </Columns>
             <SettingsBehavior AllowFocusedRow="True" />

             <SettingsPager>
                 <AllButton Visible="True" Text="Todos">
                 </AllButton>
             </SettingsPager>


             <SettingsDetail ShowDetailRow="True" />
                        <Templates>
                        <DetailRow>

                            <dx:ASPxGridView ID="ASPxGridView2" runat="server" KeyFieldName="IdInstrumentoDeEvaluacion" IsDetailGrid="true" OnBeforePerformDataSelect="ASPxGridView2_BeforePerformDataSelect" Width="100%" DataSourceID="SqlDataSource2" >
                                <Columns>

                                     <dx:GridViewDataTextColumn FieldName="codigo_ficha" ReadOnly="True" VisibleIndex="0" Visible="false">
                                        <EditFormSettings Visible="False" />
                                     </dx:GridViewDataTextColumn>
                                    <dx:GridViewDataTextColumn FieldName="NombreProyecto" Caption="Programa" VisibleIndex="1">
                                    </dx:GridViewDataTextColumn>
                                     <dx:GridViewDataTextColumn FieldName="Ano" Caption="Año" VisibleIndex="2">
                                    </dx:GridViewDataTextColumn>
                                     <dx:GridViewDataTextColumn FieldName="NombreInstrumento" Caption="Instrumento" VisibleIndex="3">
                                    </dx:GridViewDataTextColumn>
                                     <dx:GridViewDataTextColumn FieldName="IdInstrumentoDeEvaluacion" Caption="IDInstrumento" VisibleIndex="4" Visible="false">
                                    </dx:GridViewDataTextColumn>

                                </Columns>

                                <SettingsBehavior AllowFocusedRow="True" />

                                <SettingsPager>
                <AllButton Visible="True" Text="Todos">
                </AllButton>
            </SettingsPager>

             <SettingsDetail ShowDetailRow="True" />
                        <Templates>
                        <DetailRow>

                            <dx:ASPxGridView ID="ASPxGridView3" runat="server" KeyFieldName="IdAplicacionInstrumento" IsDetailGrid="true" OnBeforePerformDataSelect="ASPxGridView3_BeforePerformDataSelect" Width="100%" DataSourceID="SqlDataSource3" OnHtmlDataCellPrepared="ASPxGridView3_HtmlDataCellPrepared" >

                                <Columns>

             
                                     <dx:GridViewDataTextColumn FieldName="IdAplicacionInstrumento" Caption="IdAplicacion" ReadOnly="True" VisibleIndex="0" Visible="false" >
                                     </dx:GridViewDataTextColumn>
                                    <dx:GridViewDataTextColumn FieldName="DescripcionMomento" Caption="Levantamiento" VisibleIndex="1">
                                    </dx:GridViewDataTextColumn>
                                     <dx:GridViewDataTextColumn FieldName="UsaFSU" Caption="Fuente" VisibleIndex="2" >
                                    </dx:GridViewDataTextColumn>
                                     <dx:GridViewDataTextColumn FieldName="FechaAplicacion" Caption="Fecha" VisibleIndex="3">
                                    </dx:GridViewDataTextColumn>
                                     <dx:GridViewDataTextColumn Caption="Calculado" VisibleIndex="4">
                                    </dx:GridViewDataTextColumn>
                                     <dx:GridViewDataTextColumn Caption="Fecha Cálculo" VisibleIndex="5">
                                    </dx:GridViewDataTextColumn>
                                     <dx:GridViewDataTextColumn  FieldName="IdInstrumentoDeEvaluacion" Caption="IdInstrumentoDeEvaluacion" VisibleIndex="6" Visible="false">
                                    </dx:GridViewDataTextColumn>


                                </Columns>

                                  <SettingsPager>
                <AllButton Visible="True" Text="Todos">
                </AllButton>
            </SettingsPager>
                                <SettingsBehavior AllowFocusedRow="True" />


                                
             <SettingsDetail ShowDetailRow="True" />
                        <Templates>
                        <DetailRow>

                            <dx:ASPxGridView ID="ASPxGridView4"  runat="server" IsDetailGrid="true" KeyFieldName="IdIndicador"  Width="100%" DataSourceID="SqlDataSource4" OnBeforePerformDataSelect="ASPxGridView4_BeforePerformDataSelect">


                                <Columns>
                                <dx:GridViewDataTextColumn FieldName="IdIndicador" Caption="IdIndicador" ReadOnly="True" VisibleIndex="0" Visible="false" >
                                     </dx:GridViewDataTextColumn>
                                <dx:GridViewDataTextColumn FieldName="DescripcionIndicador" Caption="Indicador" VisibleIndex="1" >
                                     </dx:GridViewDataTextColumn>

                                <dx:GridViewDataTextColumn Caption="Valor" VisibleIndex="2">
                                    </dx:GridViewDataTextColumn>

                                    <dx:GridViewDataTextColumn Caption="Oficial" VisibleIndex="3">
                                    </dx:GridViewDataTextColumn>


                                </Columns>

                                  <SettingsPager>
                <AllButton Visible="True" Text="Todos">
                </AllButton>
            </SettingsPager>

                            </dx:ASPxGridView>


                            </DetailRow>

                         </Templates>


                            </dx:ASPxGridView>



                        </DetailRow>

                         </Templates>


        <SettingsBehavior AllowFocusedRow="True" />


                            </dx:ASPxGridView>




                         </DetailRow>
                        </Templates>
            

        </dx:ASPxGridView>

 
        <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:SUEPPSConnectionString %>" 
            SelectCommand="SELECT * FROM [Politicas] where [Activo]=1 ">

        </asp:SqlDataSource>

        <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:SUEPPSConnectionString %>" >

            <SelectParameters>
                     <asp:SessionParameter Name="IdPolitica" />
                     
                </SelectParameters>

        </asp:SqlDataSource>

         <asp:SqlDataSource ID="SqlDataSource3" runat="server" ConnectionString="<%$ ConnectionStrings:SUEPPSConnectionString %>" >

            <SelectParameters>
                     <asp:SessionParameter Name="IdInstrumento" />
                     
                </SelectParameters>

        </asp:SqlDataSource>

        <asp:SqlDataSource ID="SqlDataSource4" runat="server" ConnectionString="<%$ ConnectionStrings:SUEPPSConnectionString %>" >

            <SelectParameters>
                     <asp:SessionParameter Name="IdPrograma" />
                     
                </SelectParameters>

        </asp:SqlDataSource>


    </div>
    </asp:Content>

