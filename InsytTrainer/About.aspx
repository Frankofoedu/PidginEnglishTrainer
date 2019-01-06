<%@ Page Title="About" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="About.aspx.cs" Inherits="InsytTrainer.About" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <h2><%: Title %>.</h2>
    <h3>A website for classification of pidgin words.</h3>
    <p>Words are classified according to there perceived sentiments. Words that have a negative feel about them can have a value between -1 to -4 while positive words range between 1 to 4. Neutral words have values of 0.</p>

    <p> These values are gotten from a wide range of human testers and are then averaged to get a mean value per word</p>
</asp:Content>
