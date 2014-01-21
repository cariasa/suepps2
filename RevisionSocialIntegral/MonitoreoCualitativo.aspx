<%@ Page Title="Monitoreo Cualitativo" Language="VB" AutoEventWireup="false" CodeFile="MonitoreoCualitativo.aspx.vb" Inherits="RevisionSocial_MonitoreoCualitativo"  MasterPageFile="~/Site.master" %>

<%@ Register Assembly="DevExpress.Web.v13.2, Version=13.2.6.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web.ASPxPanel" TagPrefix="dx" %>

<%@ Register Assembly="DevExpress.Web.v13.2, Version=13.2.6.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web.ASPxCallback" TagPrefix="dx" %>

<%@ Register Assembly="DevExpress.Web.v13.2, Version=13.2.6.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web.ASPxGridView" TagPrefix="dx" %>

<%@ Register Assembly="DevExpress.Web.v13.2, Version=13.2.6.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web.ASPxEditors" TagPrefix="dx" %>

<%@ Register Src="~/MOCA_UE.ascx" TagPrefix="uc1" TagName="MOCA_UE" %>


<asp:Content ID="cHeader" ContentPlaceHolderID="HeadContent" Runat="Server">
</asp:Content>
<asp:Content ID="cBody" ContentPlaceHolderID="MainContent" Runat="Server">
    <uc1:MOCA_UE runat="server" ID="MOCA_UE01" />
     <script type="text/javascript">    

         function OnTrimestreChanged(cmbTrimestre) {
             callback.PerformCallback(cmbTrimestre.GetValue().toString());

  
         }
 
    </script>

        <dx:ASPxPanel ID="Panel" runat="server" Width="100%" Height="600%" Border-BorderColor="Gold" Visible="true"  Scrollbars="Vertical" >
            <PanelCollection>
                <dx:PanelContent>



                      <dx:ASPxLabel runat="server" Text="0" ID="CodPrograma"  Visible="false"/>
                                <p></p>
       <dx:ASPxLabel runat="server" Text=" " ID="Programa" />
             
                         <br />
        <dx:ASPxGridView ID="ASPxGridView2" runat="server" AutoGenerateColumns="False" DataSourceID="SqlMoniEncuesta">
                    <Columns>
  
                        <dx:GridViewDataTextColumn FieldName="Usuario" ShowInCustomizationForm="True" VisibleIndex="0">
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataDateColumn FieldName="Fecha" ShowInCustomizationForm="True" VisibleIndex="1">
                        </dx:GridViewDataDateColumn>
                    </Columns>
                      </dx:ASPxGridView>
         <br />

        <table>

        <tr>
          <td>
              
          </td>
        </tr>
        <tr>
        <td>
        <dx:ASPxLabel ID="LblAno" runat="server" Text="Año: " AssociatedControlID="cmbAno"></dx:ASPxLabel>

        </td>

        <td>
        <dx:ASPxComboBox ID="cmbAno" runat="server" DataSourceID="SqlAnoPrograma" TextField="Ano"  ValueField="Ano"></dx:ASPxComboBox>
        
        </td>
        <td>
         <dx:ASPxLabel ID="LblTrimestre" runat="server" Text="Trimestre:" AssociatedControlID="cmbTrimestre"></dx:ASPxLabel>
         </td>
        <td>
        <dx:ASPxComboBox ID="cmbTrimestre" runat="server" ValueType="System.String" >
         <ClientSideEvents SelectedIndexChanged="function(s, e) {OnTrimestreChanged(s); }" />
        </dx:ASPxComboBox>
         </td>
   
         <td>
                 <dx:ASPxButton ID="Btnsalvar" ClientInstanceName="Btnsalvar" runat="server" Text="Salvar Encuesta"  OnClick="ASPxButton1_Click" >
                 </dx:ASPxButton>
         </td>

        </tr>

        </table>

        <br />
         <p>La Escala Likert es una escala que nos permite evaluar los criterios de la siguiente manera:</p>
        <p>0. Sin comentario</p>
        <p>1. Totalmente en desacuerdo</p>
        <p>2. En desacuerdo</p>
        <p>3. Ni de acuerdo ni en desacuerdo</p>
        <p>4. De acuerdo</p>
        <p>5. Totalmente de acuerdo</p>
                   
        <asp:SqlDataSource ID="SqlAnoPrograma" runat="server" ConnectionString="<%$ ConnectionStrings:SUEPPSConnectionString %>" SelectCommand="SELECT * FROM [AnoPrograma] where IdPrograma= @Programa and Activo=1">
            <SelectParameters>
                <asp:SessionParameter Name="Programa" />
            </SelectParameters>
        </asp:SqlDataSource>

         <asp:SqlDataSource ID="SqlMoniEncuesta" runat="server" ConnectionString="<%$ ConnectionStrings:SUEPPSConnectionString %>" 
                         SelectCommand="SELECT [Usuario], [Fecha] FROM [MonitoreoCualitativo] where IdPrograma=@Programa and Usuario=@Usuario">
                         <SelectParameters>
                             <asp:SessionParameter Name="Programa" />
                             <asp:SessionParameter Name="Usuario" />

                         </SelectParameters>
                     </asp:SqlDataSource>
         
            <dx:ASPxCallback ID="callback" ClientInstanceName="callback" runat="server" OnCallback="callback_Callback">
                
            </dx:ASPxCallback>
   
             <asp:SqlDataSource ID="SqlMonitoreoCualitavivo" runat="server" ConnectionString="<%$ ConnectionStrings:SUEPPSConnectionString %>" 
             
                 InsertCommand="INSERT INTO [MonitoreoCualitativo]([IdPrograma],[Usuario],[Fecha],[Ano],[Trimestre],[CreadoPor],[FechaCreacion],[Activo]) VALUES (@Programa,@Usuario, getDate(), @Ano, @Trimestre,@Usuario, getDate(),1) 
                                SELECT @IdMonitoreoCualitativo = SCOPE_IDENTITY() "
                 OnInserted="SqladdIndicador_Inserted" >
                
                 <InsertParameters>
                      <asp:Parameter Name="Programa" />
                      <asp:Parameter Name="Ano" />
                     <asp:Parameter Name="Trimestre" />
                     <asp:Parameter Name="Usuario" />
                      <asp:Parameter Direction="Output" Name="IdMonitoreoCualitativo" Type="Int32" />
                 </InsertParameters>
          </asp:SqlDataSource>


            <asp:SqlDataSource ID="SqlRespuestas" runat="server" ConnectionString="<%$ ConnectionStrings:SUEPPSConnectionString %>" 
             
                 InsertCommand="INSERT INTO [RespuestasDeMonitoreoCualitativo] ([IdMonitoreoCualitativo],[IdPreguntaDeMonitoreo],[RespuestaAbierta],[RespuestaLikert],[Activo],[CreadoPor],[FechaCreacion]) VALUES (@Monitoreo, @Pregunta, @RespuestaA, @RespuestaL, 1, @Usuario, getDate()) 
                                SELECT @IdRespuestaDeMonitoreCualitativo = SCOPE_IDENTITY() "
                 OnInserted="SqlRespuestas_Inserted" >
                
                 <InsertParameters>
                      <asp:Parameter Name="Monitoreo" />
                      <asp:Parameter Name="Pregunta" />
                     <asp:Parameter Name="RespuestaA" />
                     <asp:Parameter Name="RespuestaL" />
                      <asp:Parameter Direction="Output" Name="IdRespuestaDeMonitoreCualitativo" Type="Int32" />
                     <asp:SessionParameter Name="Usuario" />
                 </InsertParameters>
          </asp:SqlDataSource>


             <asp:SqlDataSource ID="SqlRespuestasOpciones" runat="server" ConnectionString="<%$ ConnectionStrings:SUEPPSConnectionString %>" ></asp:SqlDataSource>

         
        <dx:ASPxGridView ID="GridPreguntasGenerales" runat="server" AutoGenerateColumns="False" Visible="false" DataSourceID="SqlPreguntasGenerales" KeyFieldName="IdPreguntaDeMonitoreo">
            <Columns>
                <dx:GridViewDataTextColumn FieldName="IdPreguntaDeMonitoreo" ReadOnly="True" VisibleIndex="0">
                    <EditFormSettings Visible="False" />
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="IdTipoDePregunta" VisibleIndex="1">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="IdTipoDeActor" VisibleIndex="2">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="DescripcionPreguntaDeMonitoreo" VisibleIndex="4">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="EsGeneral" VisibleIndex="5">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="IdCategoriaDePregunta" VisibleIndex="6">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Orden" VisibleIndex="7">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="DescripcionCategoriaDePregunta" VisibleIndex="8">
                </dx:GridViewDataTextColumn>
            </Columns>
        </dx:ASPxGridView>   
                    
          <asp:SqlDataSource ID="SqlPreguntasGenerales" runat="server" ConnectionString="<%$ ConnectionStrings:SUEPPSConnectionString %>" SelectCommand="SELECT a.IdPreguntaDeMonitoreo,a.IdTipoDePregunta,a.IdTipoDeActor,a.EsGeneral,a.IdCategoriaDePregunta,a.Orden,a.DescripcionPreguntaDeMonitoreo,b.DescripcionCategoriaDePregunta FROM [PreguntasDeMonitoreo] a join [CategoriasDePregunta] b on a.IdCategoriaDePregunta=b.IdCategoriaDePregunta  where a.EsGeneral= 1 and a.Activo=1 order by a.EsGeneral,b.Orden, a.Orden">
        </asp:SqlDataSource>                


        <dx:ASPxGridView ID="GridPreguntas" runat="server" AutoGenerateColumns="False" Visible="false" DataSourceID="SqlPreguntas" KeyFieldName="IdPreguntaDeMonitoreo">
            <Columns>
                <dx:GridViewDataTextColumn FieldName="IdPreguntaDeMonitoreo" ReadOnly="True" VisibleIndex="0">
                    <EditFormSettings Visible="False" />
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="IdTipoDePregunta" VisibleIndex="1">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="IdTipoDeActor" VisibleIndex="2">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="DescripcionPreguntaDeMonitoreo" VisibleIndex="4">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="EsGeneral" VisibleIndex="5">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="IdCategoriaDePregunta" VisibleIndex="6">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Orden" VisibleIndex="7">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="DescripcionCategoriaDePregunta" VisibleIndex="8">
                </dx:GridViewDataTextColumn>
            </Columns>
        </dx:ASPxGridView>

  



        <dx:ASPxGridView ID="GridPreguntasActor" runat="server" AutoGenerateColumns="False" Visible="false" DataSourceID="SqlPreguntasActor" KeyFieldName="IdPreguntaDeMonitoreo">
            <Columns>
                <dx:GridViewDataTextColumn FieldName="IdPreguntaDeMonitoreo" ReadOnly="True" VisibleIndex="0">
                    <EditFormSettings Visible="False" />
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="IdTipoDePregunta" VisibleIndex="1">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="IdTipoDeActor" VisibleIndex="2">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="DescripcionPreguntaDeMonitoreo" VisibleIndex="4">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="EsGeneral" VisibleIndex="5">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="IdCategoriaDePregunta" VisibleIndex="6">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Orden" VisibleIndex="7">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="DescripcionCategoriaDePregunta" VisibleIndex="8">
                </dx:GridViewDataTextColumn>
            </Columns>
        </dx:ASPxGridView>

 <asp:SqlDataSource ID="SqlPreguntasActor" runat="server" ConnectionString="<%$ ConnectionStrings:SUEPPSConnectionString %>" SelectCommand="SELECT a.IdPreguntaDeMonitoreo,a.IdTipoDePregunta,a.IdTipoDeActor,a.EsGeneral,a.IdCategoriaDePregunta,a.Orden,a.DescripcionPreguntaDeMonitoreo,b.DescripcionCategoriaDePregunta FROM [PreguntasDeMonitoreo] a join [CategoriasDePregunta] b on a.IdCategoriaDePregunta=b.IdCategoriaDePregunta   where a.IdPrograma= @Programa and a.EsGeneral=3  and a.Activo=1 and a.IdTipoDeActor= @Actor order by a.EsGeneral,b.Orden, a.Orden">

           <SelectParameters>

               <asp:SessionParameter  Name="Programa" />
               <asp:SessionParameter  Name="Actor" />

               

            </SelectParameters>

        </asp:SqlDataSource>


        <asp:SqlDataSource ID="SqlPreguntas" runat="server" ConnectionString="<%$ ConnectionStrings:SUEPPSConnectionString %>" SelectCommand="SELECT a.IdPreguntaDeMonitoreo,a.IdTipoDePregunta,a.IdTipoDeActor,a.EsGeneral,a.IdCategoriaDePregunta,a.Orden,a.DescripcionPreguntaDeMonitoreo,b.DescripcionCategoriaDePregunta FROM [PreguntasDeMonitoreo] a join [CategoriasDePregunta] b on a.IdCategoriaDePregunta=b.IdCategoriaDePregunta  where a.IdPrograma= @Programa and a.EsGeneral=2  and a.Activo=1 order by a.EsGeneral,b.Orden, a.Orden">

           <SelectParameters>

               <asp:SessionParameter  Name="Programa" />
               

            </SelectParameters>

        </asp:SqlDataSource>


        <dx:ASPxGridView ID="GridOpciones" runat="server" AutoGenerateColumns="False" Visible="false" DataSourceID="SqlOpcionesPreguntas" KeyFieldName="IdOpcionDePregunta">
            <Columns>
                <dx:GridViewDataTextColumn FieldName="DescripcionOpcionDePregunta" VisibleIndex="0">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="IdOpcionDePregunta" ReadOnly="True" VisibleIndex="1">
                    <EditFormSettings Visible="False" />
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="IdPreguntaDeMonitoreo" VisibleIndex="2">
                </dx:GridViewDataTextColumn>
            </Columns>
        </dx:ASPxGridView>


        <asp:SqlDataSource ID="SqlOpcionesPreguntas" runat="server" ConnectionString="<%$ ConnectionStrings:SUEPPSConnectionString %>" SelectCommand="SELECT [DescripcionOpcionDePregunta], [IdOpcionDePregunta], [IdPreguntaDeMonitoreo] FROM [OpcionesDePregunta] where IdPreguntaDeMonitoreo=@Pregunta and Activo=1">

            <SelectParameters>

               <asp:SessionParameter  Name="Pregunta" />
               

            </SelectParameters>

        </asp:SqlDataSource>

    
                </dx:PanelContent>
            </PanelCollection>

<Border BorderColor="Gold"></Border>

        </dx:ASPxPanel>

    <dx:ASPxGridView ID="ASPxGridView1" runat="server" AutoGenerateColumns="False" Visible="false" DataSourceID="SqlTipoActor">
        <Columns>
            <dx:GridViewDataTextColumn FieldName="Usuario" VisibleIndex="0">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="IdTipoDeActor" VisibleIndex="1">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="IdPrograma" VisibleIndex="2">
            </dx:GridViewDataTextColumn>
        </Columns>
    </dx:ASPxGridView>


    <asp:SqlDataSource ID="SqlTipoActor" runat="server" ConnectionString="<%$ ConnectionStrings:SUEPPSConnectionString %>" SelectCommand="SELECT [Usuario], [IdTipoDeActor], [IdPrograma] FROM [ActoresPorPrograma] where [Usuario]=@Usuario and [IdPrograma]=@Programa and [Activo]=1">
        <SelectParameters>
            <asp:SessionParameter Name="Usuario"/>
            <asp:SessionParameter Name="Programa"/>
        </SelectParameters>
    </asp:SqlDataSource>


</asp:Content>