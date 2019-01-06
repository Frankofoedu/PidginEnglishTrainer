<%@ Page Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Classifier.aspx.cs" Inherits="InsytTrainer.Classifier" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">

    <!DOCTYPE html>

    <html xmlns="http://www.w3.org/1999/xhtml">

    <head>
        <%--<link rel="stylesheet" type="text/css" href="Content/classifier.css" />--%>
        <link href="Content/bootstrap.css" rel="stylesheet" />
        <script src="Scripts/jquery-3.3.1.js"></script>
        <meta name="viewport" content="width=device-width, initial-scale=1" />
        <%--<script src="Scripts/classifier.js"></script>
    <script>  
        function GetData() {
            $.ajax({
                type: "POST",
                url: "Classifier.aspx/GetWords",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (json) {
                    alert('yes' + json.d);
                    console.log(json);
                },
                failure: function (response) {
                    alert(response.d);
                }
            });
        };

    </script>--%>
        <title></title>
    </head>
    <body>
        <%-- <div id="quiz">
        <h1 id="quiz-name"></h1>
        <button id="submit-button">Submit Answers</button>
        <button id="next-question-button">Next Question</button>
        <button id="prev-question-button">Previous</button>
        <button onclick="GetData();">Previous</button>
        

        <div id="quiz-results">

            <p id="quiz-results-message"></p>
            <p id="quiz-results-score"></p>
            <button id="quiz-retry-button">Retry</button>

        </div>
    </div>--%>
        <div class="container">
            <div class=" page-header clearfix">
                <nav>
                    <ul class="nav nav-pills pull-right">
                        <li role="presentation" class="active"><a href="#">Contact</a></li>
                    </ul>
                </nav>
                <h3 class="text-muted">Pidgin Set Classifier</h3>
            </div>

            <div class="jumbotron">
                <p class="lead">This a simple project to classify pidgin words.</p>
                <p class="lead" style="word-wrap: break-word">Read the words and their meaning, then select a number from -4 to +4 depending on what you feel. </p>
                <p class="lead">e.g Stupid is a -3 while blessed is a +2 (i.e according to me. Yours might be different).</p>
                <h3><span class="label label-danger">Please do take your time. dont rush it. we have means to know if you are doing it randomly</span></h3>
            </div>
            <asp:Panel ID="Panel1" CssClass="form-group row" runat="server">
                <div class="center-block">
                    <a href="#">Total Done:  <span class="badge"><asp:Literal ID="litCount" runat="server"></asp:Literal></span></a>
                    <h2>Word: 
                            <asp:Label ID="lblWord" CssClass="label label-default" runat="server" Text="Label"></asp:Label></h2>
                    <br />

                    <h2>Meaning: 
                            <asp:Label ID="lblMeaning" CssClass="label label-default" runat="server" Text="Label"></asp:Label></h2>
                    <br />

                    <h2>Example: 
                            <asp:Label ID="lblExample" CssClass="label label-default" runat="server" Text="Label"></asp:Label></h2>
                </div>
            </asp:Panel>

            <asp:Panel ID="Panel2" CssClass=" row" runat="server">

                <div class="form-group col-xs-12 col-md-3">
                    <asp:RadioButton ID="rad4Neg" GroupName="rb1" runat="server" Text="-4 (Extremely negative)" />
                </div>
                <div class="form-group col-xs-12 col-md-3">
                    <asp:RadioButton ID="rad3Neg" GroupName="rb1" runat="server" Text="-3 (Very negative)" />
                </div>
                <div class="form-group col-xs-12 col-md-3">
                    <asp:RadioButton ID="rad2Neg" GroupName="rb1"  runat="server" Text="-2 (Moderatley negative)" />
                </div>
                <div class="form-group col-xs-12 col-md-3">
                    <asp:RadioButton ID="rad1Neg" GroupName="rb1"  runat="server" Text="-1 (Slightly negative)" />
                </div>
                <div class="form-group col-xs-12 col-md-12" style="align-content:center">
                    <asp:RadioButton ID="rad0" GroupName="rb1"   runat="server" Text="0 (Neutral)" />
                </div>
                <div class="form-group col-xs-12 col-md-3">
                    <asp:RadioButton ID="rad1" GroupName="rb1"  runat="server" Text="+1 (Slightly positive)" />
                </div>
                <div class="form-group col-xs-12 col-md-3">
                    <asp:RadioButton ID="rad2" GroupName="rb1"  runat="server" Text="+2 (Moderatley positive)" />
                </div>
                <div class="form-group col-xs-12 col-md-3">
                    <asp:RadioButton ID="rad3" GroupName="rb1"  runat="server" Text="+3 (Very Positive)" />
                </div>
                <div class="form-group col-xs-12 col-md-3">
                    <asp:RadioButton ID="rad4" GroupName="rb1"  runat="server" Text="+4 (Extremely positive)" />
                </div>
            </asp:Panel>


            <asp:Panel ID="Panel3" CssClass="container-fluid " runat="server">

                <div class="col-xs-4">
                    <asp:Button ID="btnPrevious" OnClick="btnPrevious_Click" CssClass="btn btn-success " Text="Previous" runat="server" />
                </div>
                <div class="col-xs-4">
                    <asp:Button ID="btnNext" OnClick="btnNext_Click" Text="Next" CssClass="btn btn-info " runat="server" />
                </div>

                <div class="col-xs-4">
                    <asp:Button ID="btnLogout" Text="Logout" OnClick="btnLogout_Click" CssClass="btn btn-warning " runat="server" />

                </div>
            </asp:Panel>
        </div>
    </body>

    </html>
</asp:Content>
