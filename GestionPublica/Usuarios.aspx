<%@ Page Language="VB" AutoEventWireup="false" CodeFile="Usuarios.aspx.vb" Inherits="GestionPublica_Usuarios" MasterPageFile="~/Site.master" %>

<%@ Register Src="~/MOCA_UE.ascx" TagPrefix="uc1" TagName="MOCA_UE" %>


<asp:Content ID="cHeader" ContentPlaceHolderID="HeadContent" Runat="Server">
</asp:Content>
<asp:Content ID="cBody" ContentPlaceHolderID="MainContent" Runat="Server">
    <uc1:MOCA_UE runat="server" ID="MOCA_UE01" />
    <div>


        <dx:ASPxLabel runat="server" Text=" " ID="Programa" />

        <br />

        <dx:ASPxGridView ID="ASPxGridView1" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSource1"  KeyFieldName="IdUsuarioPorPrograma" >
            <Columns>
                

                <dx:GridViewDataTextColumn FieldName="IdUsuarioPorPrograma" VisibleIndex="0" Visible="true" Caption="#">
                    <EditFormSettings Visible="False" />
                    
                </dx:GridViewDataTextColumn>

                <dx:GridViewDataTextColumn FieldName="IdPrograma" VisibleIndex="1" Visible="false">
                    <EditFormSettings Visible="False" />
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Usuario" VisibleIndex="2">
                </dx:GridViewDataTextColumn>
                <dx:GridViewCommandColumn Caption="Acciones">
                    <NewButton Visible="true"></NewButton>
                    <EditButton Visible="true"></EditButton>
                    <DeleteButton Visible="true"></DeleteButton>
                </dx:GridViewCommandColumn>
            </Columns>
        </dx:ASPxGridView>




        <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:SUEPPSConnectionString %>" 
            SelectCommand="SELECT [IdUsuarioPorPrograma], [IdPrograma], [Usuario] FROM [UsuariosPorPrograma] where [IdPrograma]=@Programa and [Activo]=1"
           InsertCommand="INSERT INTO [UsuariosPorPrograma] ([IdPrograma],[Usuario],[CreadoPor],[FechaCreacion],[Activo]) values (@Programa,@Usuario,@Creado,getDate(),1)"
            UpdateCommand="UPDATE [UsuariosPorPrograma] SET [Usuario]=@Usuario, [ActualizadoPor]=@Actualizado, [FechaActualizacion]=getDate() WHERE [IdUsuarioPorPrograma]= @IdUsuarioPorPrograma"
            DeleteCommand="UPDATE [UsuariosPorPrograma] SET [Activo]=0 WHERE [IdUsuarioPorPrograma]= @IdUsuarioPorPrograma"
            >
        <SelectParameters>
            <asp:SessionParameter Name="Programa" />
        </SelectParameters>

        <InsertParameters>
            <asp:SessionParameter Name="Programa" />
            <asp:SessionParameter Name="Creado" />
            <asp:FormParameter Name="Usuario" />
            <asp:SessionParameter Name="AP" />
        </InsertParameters>

            
        <UpdateParameters>
                <asp:SessionParameter Name="Actualizado" />
                <asp:FormParameter Name="Usuario" />
                <asp:SessionParameter Name="IdUsuarioPorPrograma" />
            
        </UpdateParameters>


        </asp:SqlDataSource>




    </div>
</asp:Content>
