<%@ Control Language="VB" AutoEventWireup="false" CodeFile="MOCA_MenuControl.ascx.vb"
    Inherits="MOCA_MenuControl" %>
<div class="clear hideSkiplink">
    <dx:ASPxMenu ID="mMainMenu" runat="server" EnableViewState="False" 
        SkinID="Office2010Black" AutoSeparators="RootOnly" 
        CssFilePath="~/App_Themes/Office2010Blue/{0}/styles.css" 
        CssPostfix="Office2010Blue" ShowPopOutImages="True" 
        SpriteCssFilePath="~/App_Themes/Office2010Blue/{0}/sprite.css" >
        <Items>
            <dx:MenuItem NavigateUrl="~/Default.aspx" Text="Inicio" ToolTip="Ir a la Pagina Principal">
            </dx:MenuItem>
        </Items>
        <LoadingPanelImage Url="~/App_Themes/Office2010Blue/Web/Loading.gif">
        </LoadingPanelImage>
        <ItemSubMenuOffset FirstItemX="2" LastItemX="2" X="2" />
        <ItemStyle DropDownButtonSpacing="10px" PopOutImageSpacing="10px" />
        <LoadingPanelStyle ImageSpacing="5px">
        </LoadingPanelStyle>
        <SubMenuStyle GutterImageSpacing="9px" GutterWidth="13px" />
    </dx:ASPxMenu>
</div>
