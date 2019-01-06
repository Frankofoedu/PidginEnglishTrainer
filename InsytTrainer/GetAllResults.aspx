<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="GetAllResults.aspx.cs" Inherits="InsytTrainer.GetAllResults" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
   <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="false" EmptyDataText="No files available">
    <Columns>
        <asp:TemplateField>
            <ItemTemplate>
                <asp:CheckBox ID="chkSelect" runat="server" />
                <asp:Label ID="lblFilePath" runat="server" Text='<%# Eval("Value") %>' Visible="false"></asp:Label>
            </ItemTemplate>
        </asp:TemplateField>
        <asp:BoundField DataField="Text" HeaderText="File Name" />
    </Columns>
</asp:GridView>
<br />
    
<asp:Button ID="btnDownload" runat="server" Text="Download" OnClick="btnDownload_Click" />
<asp:Button ID="Button1" runat="server" Text="Delete File" OnClick="Button1_Click" />
     <asp:GridView ID="grdUsers" runat="server" AutoGenerateColumns="false" EmptyDataText="No user available">
    <Columns>
        <asp:TemplateField>
            <ItemTemplate>
                <asp:CheckBox ID="chkSelectUser" runat="server" />
                <asp:Label ID="lblUserName" runat="server" Text='<%# Eval("Value") %>' Visible="false"></asp:Label>
            </ItemTemplate>
        </asp:TemplateField>
        <asp:BoundField DataField="Text" HeaderText="Users" />
    </Columns>
</asp:GridView>
<br />
    <asp:Button ID="btnUsers" runat="server" OnClick="btnUsers_Click" Text="Delete Users" />
</asp:Content>
