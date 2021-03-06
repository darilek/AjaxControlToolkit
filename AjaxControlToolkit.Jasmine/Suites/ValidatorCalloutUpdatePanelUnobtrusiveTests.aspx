﻿<%@ Page Title="" Language="C#" MasterPageFile="~/Suites/Suite.Master" AutoEventWireup="true" CodeBehind="ValidatorCalloutUpdatePanelUnobtrusiveTests.aspx.cs" Inherits="AjaxControlToolkit.Jasmine.Suites.ValidatorCalloutUpdatePanelUnobtrusiveTests" %>

<asp:Content ContentPlaceHolderID="TestSuiteName" runat="server">
    ValidatorCallout (unobtrusive validation)
</asp:Content>

<asp:Content ContentPlaceHolderID="TestSuite" runat="server">

    <asp:UpdatePanel
        ID="TestUpdatePanel"
        runat="server"
        UpdateMode="Conditional">
        <ContentTemplate>
            <asp:TextBox
                ID="txtUpdate"
                runat="server">
            </asp:TextBox>
            <asp:RequiredFieldValidator
                ID="UpdatePanelRequiredFieldValidator"
                runat="server"
                EnableClientScript="true"
                Display="None"
                SetFocusOnError="true"
                ErrorMessage="Test error message"
                ControlToValidate="txtUpdate"
                ValidationGroup="TestGroup">
            </asp:RequiredFieldValidator>
            <act:ValidatorCalloutExtender
                ID="UpdatePanelTargetExtender"
                HighlightCssClass="ValidatorCallout"
                TargetControlID="UpdatePanelRequiredFieldValidator"
                runat="server">
            </act:ValidatorCalloutExtender>
            <asp:Button ID="btnSaveUserForm" runat="server" Text="Save" ValidationGroup="TestGroup" />
            <asp:Button ID="btnPostback" runat="server" Text="Test Postback" Visible="true" OnClick="btnPostback_Click" />

        </ContentTemplate>
    </asp:UpdatePanel>


    <script>
        describe("ValidatorCallout", function() {

            var UPDATEPANEL_VALIDATOR_CALLOUT_EXTENDER_CLIENT_ID = "<%= UpdatePanelTargetExtender.ClientID %>";
            var SAVE_BUTTON_CLIENT_ID = "<%= btnSaveUserForm.ClientID %>";
            var POSTBACK_BUTTON_CLIENT_ID = "<%= btnPostback.ClientID %>";

            describe("Rendering", function() {

                it("validates inside UpdatePanel before postback", function(done) {
                    $("#" + SAVE_BUTTON_CLIENT_ID).click();

                    setTimeout(function() {
                        var $container = $("#" + UPDATEPANEL_VALIDATOR_CALLOUT_EXTENDER_CLIENT_ID + "_popupTable");
                        expect($container.is(":visible")).toBeTruthy();
                        done();
                    }, 200);
                });

                it("validates inside UpdatePanel after postback", function(done) {
                    $("#" + POSTBACK_BUTTON_CLIENT_ID).click();

                    setTimeout(function() {
                        $("#" + SAVE_BUTTON_CLIENT_ID).click();

                        setTimeout(function() {
                            var $container = $("#" + UPDATEPANEL_VALIDATOR_CALLOUT_EXTENDER_CLIENT_ID + "_popupTable");
                            expect($container.is(":visible")).toBeTruthy();
                            done();
                        }, 200);
                    }, 200);
                });

                it("validates inside UpdatePanel after 2 postbacks", function(done) {
                    $("#" + POSTBACK_BUTTON_CLIENT_ID).click();

                    setTimeout(function() {
                        $("#" + POSTBACK_BUTTON_CLIENT_ID).click();

                        setTimeout(function() {
                            $("#" + SAVE_BUTTON_CLIENT_ID).click();

                            setTimeout(function() {
                                var $container = $("#" + UPDATEPANEL_VALIDATOR_CALLOUT_EXTENDER_CLIENT_ID + "_popupTable");
                                expect($container.is(":visible")).toBeTruthy();
                                done();
                            }, 200);
                        }, 200);
                    }, 200);
                });

            });
        });
    </script>

</asp:Content>
