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
    <%--<asp:Button ID="Button1" runat="server" OnClick="Button1_Click" Text="Button" />--%>
</asp:Content>
