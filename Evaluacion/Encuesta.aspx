<%@ Page Title="Análisis Cualitativo" Language="VB" AutoEventWireup="false" CodeFile="Encuesta.aspx.vb" Inherits="RevisionSocial_MonitoreoCualitativo" MasterPageFile="~/Site.master" %>

<%@ Register Assembly="DevExpress.Web.v13.2, Version=13.2.6.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web.ASPxPanel" TagPrefix="dx" %>

<%@ Register Assembly="DevExpress.Web.v13.2, Version=13.2.6.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web.ASPxCallback" TagPrefix="dx" %>

<%@ Register Assembly="DevExpress.Web.v13.2, Version=13.2.6.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web.ASPxGridView" TagPrefix="dx" %>

<%@ Register Assembly="DevExpress.Web.v13.2, Version=13.2.6.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web.ASPxEditors" TagPrefix="dx" %>

<%@ Register Src="~/MOCA_UE.ascx" TagPrefix="uc1" TagName="MOCA_UE" %>


<asp:Content ID="cHeader" ContentPlaceHolderID="HeadContent" runat="Server">
</asp:Content>
<asp:Content ID="cBody" ContentPlaceHolderID="MainContent" runat="Server">
    <uc1:MOCA_UE runat="server" ID="MOCA_UE01" />
    <div>
        <dx:ASPxLabel ID="ASPxLabelTitulo" runat="server" Font-Size="Large" Text="Digitación de Instrumento de Evaluación" />
    </div>
    <dx:ASPxPanel ID="Panel" runat="server" Width="100%" Height="600%" Border-BorderColor="Gold" Visible="true" ScrollBars="Vertical">
        <PanelCollection>
            <dx:PanelContent>

                <br />


                <br />





                <dx:ASPxGridView ID="GridAplicacion" runat="server" AutoGenerateColumns="True" Visible="false" DataSourceID="SqlAplicacion"></dx:ASPxGridView>

                <asp:SqlDataSource ID="SqlAplicacion" runat="server" ConnectionString="<%$ ConnectionStrings:SUEPPSConnectionString %>" SelectCommand="SELECT * FROM [AplicacionInstrumento] where IdAplicacionInstrumento= @IdAplicacionInstrumento and Activo=1">

                    <SelectParameters>

                        <asp:SessionParameter Name="IdAplicacionInstrumento" />


                    </SelectParameters>

                </asp:SqlDataSource>


                <dx:ASPxGridView ID="GridPreguntas" runat="server" AutoGenerateColumns="False" Visible="false" DataSourceID="SqlPreguntas" KeyFieldName="IdPreguntaPorInstrumento">
                    <Columns>
                        <dx:GridViewDataTextColumn FieldName="IdPreguntaPorInstrumento" ReadOnly="True" VisibleIndex="0">
                            <EditFormSettings Visible="False" />
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn FieldName="IdInstrumentoDeEvaluacion" VisibleIndex="1">
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn FieldName="IdTipoDePregunta" VisibleIndex="2">
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn FieldName="NombreSeccion" VisibleIndex="3">
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn FieldName="IdTipoDeRespuesta" VisibleIndex="4">
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn FieldName="IdAmigable" VisibleIndex="5">
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn FieldName="PreguntaDeInstrumento" VisibleIndex="6">
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn FieldName="Orden" VisibleIndex="7">
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn FieldName="Requerida" VisibleIndex="8">
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn FieldName="IdSeccionFSU" VisibleIndex="9">
                        </dx:GridViewDataTextColumn>


                    </Columns>
                </dx:ASPxGridView>

                <asp:SqlDataSource ID="SqlPreguntas" runat="server" ConnectionString="<%$ ConnectionStrings:SUEPPSConnectionString %>" SelectCommand="SELECT a.IdPreguntaPorInstrumento,a.IdInstrumentoDeEvaluacion,a.IdTipoDePregunta,b.NombreSeccion,a.IdTipoDeRespuesta,a.IdAmigable,a.PreguntaDeInstrumento,a.Orden,a.Requerida,a.IdSeccionFSU FROM [PreguntasPorInstrumento] a join [SeccionesFSU] b on a.IdSeccionFSU=b.IdSeccionFSU  where a.IdInstrumentoDeEvaluacion= @IdInstrumentoDeEvaluacion and a.Activo=1 order by b.NombreSeccion, a.Orden">

                    <SelectParameters>

                        <asp:SessionParameter Name="IdInstrumentoDeEvaluacion" />


                    </SelectParameters>

                </asp:SqlDataSource>

                <dx:ASPxGridView ID="GridOpciones" runat="server" AutoGenerateColumns="False" Visible="false" DataSourceID="SqlOpcionesPreguntas" KeyFieldName="IdOpcionPreguntaPorInstrumento">
                    <Columns>
                        <dx:GridViewDataTextColumn FieldName="Opcion" VisibleIndex="0">
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn FieldName="IdOpcionPreguntaPorInstrumento" ReadOnly="True" VisibleIndex="1">
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn FieldName="IdPreguntaPorInstrumento" VisibleIndex="2">
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn FieldName="Valor" VisibleIndex="3">
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn FieldName="SaltaACodigo" VisibleIndex="4">
                        </dx:GridViewDataTextColumn>
                    </Columns>
                </dx:ASPxGridView>


                <asp:SqlDataSource ID="SqlOpcionesPreguntas" runat="server" ConnectionString="<%$ ConnectionStrings:SUEPPSConnectionString %>" SelectCommand="SELECT * FROM [OpcionesPreguntaPorInstrumento] where IdPreguntaPorInstrumento=@Pregunta and Activo=1 Order By Valor">

                    <SelectParameters>

                        <asp:SessionParameter Name="Pregunta" />


                    </SelectParameters>

                </asp:SqlDataSource>


                <asp:SqlDataSource ID="SqlDataSourceEncabezado" runat="server" ConnectionString="<%$ ConnectionStrings:SUEPPSConnectionString %>"
                    InsertCommand="INSERT INTO [EncabezadoRespuesta] ([CodigoFSU],[CodigoDigitador],[IdAplicacionInstrumento],[CreadoPor],[FechaCreacion],[Activo],[IdVivienda],[IdHogar],[IdMiembro]) VALUES (@CodigoFSU, @CodigoDigitador, @IdAplicacionInstrumento, @Usuario,getDate(),1,@IdVivienda,@IdHogar,@IdMiembro) 
                                SELECT @IdEncabezadoRespuesta = SCOPE_IDENTITY() "
                    OnInserted="SqlDataSourceEncabezado_Inserted">

                    <InsertParameters>
                        <asp:SessionParameter Name="CodigoFSU" />
                        <asp:SessionParameter Name="CodigoDigitador" />
                        <asp:SessionParameter Name="IdAplicacionInstrumento" />
                        <asp:SessionParameter Name="Usuario" />
                        <asp:SessionParameter Name="IdVivienda" />
                        <asp:SessionParameter Name="IdHogar" />
                        <asp:SessionParameter Name="IdMiembro" />
                        <asp:Parameter Direction="Output" Name="IdEncabezadoRespuesta" Type="Int32" />
                    </InsertParameters>
                </asp:SqlDataSource>






                <asp:SqlDataSource ID="SqlRespuestas" runat="server" ConnectionString="<%$ ConnectionStrings:SUEPPSConnectionString %>"
                   
                    OnInserted="SqlRespuestas_Inserted">

                    <InsertParameters>
                        <asp:SessionParameter Name="IdPreguntaPorInstrumento" />
                        <asp:SessionParameter Name="IdEncabezadoRespuesta" />
                        <asp:SessionParameter Name="Respuesta" />
                        <asp:SessionParameter Name="Usuario" />
                        <asp:Parameter Direction="Output" Name="IdRespuestaInstrumento" Type="Int32" />

                    </InsertParameters>
                </asp:SqlDataSource>


                <asp:SqlDataSource ID="SqlRespuestasOpciones" runat="server" ConnectionString="<%$ ConnectionStrings:SUEPPSConnectionString %>"></asp:SqlDataSource>







            </dx:PanelContent>
        </PanelCollection>

        <Border BorderColor="Gold"></Border>

    </dx:ASPxPanel>
    <dx:ASPxButton ID="ASPxButton1" runat="server" Text="Salvar Encuesta" OnClick="ASPxButton1_Click"></dx:ASPxButton>
</asp:Content>
