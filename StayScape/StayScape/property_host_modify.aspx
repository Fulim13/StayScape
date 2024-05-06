<%@ Page Title="" Language="C#" MasterPageFile="~/Main.Master" AutoEventWireup="true" CodeBehind="property_host_modify.aspx.cs" Inherits="StayScape.property_host_modify" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <!DOCTYPE html>
    <html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Modify Property</title>
        <style>
            body {
                font-family: Arial, sans-serif;
                background-color: #f2f2f2;
            }

            .container {
                max-width: 600px;
                margin: 0 auto;
                background-color: #fff;
                border-radius: 10px;
                box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
                padding: 20px;
            }

            h2 {
                font-size: 24px;
                color: #4338ca;
                margin-bottom: 20px;
                text-align: center;
            }

            .form-group {
                margin-bottom: 20px;
            }

            label {
                display: block;
                font-weight: bold;
                margin-bottom: 5px;
            }

            input[type="text"], input[type="number"], select {
                width: 100%;
                padding: 10px;
                font-size: 16px;
                border: 1px solid #ccc;
                border-radius: 5px;
                box-sizing: border-box;
            }

            .button {
                display: block;
                width: 100%;
                padding: 10px 20px;
                background-color: #4338ca;
                color: #fff;
                border: none;
                border-radius: 5px;
                font-size: 16px;
                text-align: center;
                cursor: pointer;
                transition: background-color 0.3s ease;
            }

                .button:hover {
                    background-color: #4338ca;
                }
        </style>
    </head>
    <body>
        <div class="container">
            <h2>Update Property Details</h2>
            <div class="form-group">
                <label>Select Property:</label>
                <asp:DropDownList ID="ddlProperty" runat="server" AutoPostBack="true" OnSelectedIndexChanged="ddlProperty_SelectedIndexChanged">
                    <asp:ListItem Text="--Select Property--" Value="" />
                </asp:DropDownList>
            </div>
            <div class="form-group">
                <label>Property Name:</label>
                <asp:TextBox ID="txtPropertyName" runat="server" />
                <asp:RequiredFieldValidator
                    ID="rfvPropertyName"
                    runat="server"
                    ControlToValidate="txtPropertyName"
                    ErrorMessage="Property Name is required"
                    ForeColor="Red"
                    Display="Dynamic" />
            </div>

            <div class="form-group">
                <label>Property Price:</label>
                <asp:TextBox ID="txtPropertyPrice" runat="server" TextMode="Number" />
                <asp:RequiredFieldValidator
                    ID="rfvPropertyPrice"
                    runat="server"
                    ControlToValidate="txtPropertyPrice"
                    ErrorMessage="Property Price is required"
                    ForeColor="Red"
                    Display="Dynamic" />
                <asp:RangeValidator
                    ID="rvPropertyPrice"
                    runat="server"
                    ControlToValidate="txtPropertyPrice"
                    Type="Integer"
                    MinimumValue="1"
                    MaximumValue="99999"
                    ErrorMessage="Property Price must be greater than 0"
                    ForeColor="Red"
                    Display="Dynamic" />
            </div>

            <div class="form-group">
                <label>Property Description:</label>
                <asp:TextBox ID="txtPropertyDesc" runat="server" TextMode="MultiLine" Rows="3" />
                <asp:RequiredFieldValidator
                    ID="rfvPropertyDesc"
                    runat="server"
                    ControlToValidate="txtPropertyDesc"
                    ErrorMessage="Property Description is required"
                    ForeColor="Red"
                    Display="Dynamic" />
            </div>

            <div class="form-group">
                <label>Address:</label>
                <asp:TextBox ID="txtPropertyAddress" runat="server" />
                <asp:RequiredFieldValidator
                    ID="rfvPropertyAddress"
                    runat="server"
                    ControlToValidate="txtPropertyAddress"
                    ErrorMessage="Address is required"
                    ForeColor="Red"
                    Display="Dynamic" />
            </div>

            <div class="form-group">
                <label>City:</label>
                <asp:TextBox ID="txtCity" runat="server" />
                <asp:RequiredFieldValidator
                    ID="rfvCity"
                    runat="server"
                    ControlToValidate="txtCity"
                    ErrorMessage="City is required"
                    ForeColor="Red"
                    Display="Dynamic" />
            </div>

            <div class="form-group">
                <label>State:</label>
                <asp:TextBox ID="txtState" runat="server" />
                <asp:RequiredFieldValidator
                    ID="rfvState"
                    runat="server"
                    ControlToValidate="txtState"
                    ErrorMessage="State is required"
                    ForeColor="Red"
                    Display="Dynamic" />
            </div>

            <div class="form-group">
                <label>Total Bedrooms:</label>
                <asp:TextBox ID="txtTotalBedrooms" runat="server" TextMode="Number" />
                <asp:RequiredFieldValidator
                    ID="rfvTotalBedrooms"
                    runat="server"
                    ControlToValidate="txtTotalBedrooms"
                    ErrorMessage="Total Bedrooms is required"
                    ForeColor="Red"
                    Display="Dynamic" />
                <asp:RangeValidator
                    ID="rvTotalBedrooms"
                    runat="server"
                    ControlToValidate="txtTotalBedrooms"
                    Type="Integer"
                    MinimumValue="1"
                    MaximumValue="10"
                    ErrorMessage="Total Bedrooms must be greater than 0"
                    ForeColor="Red"
                    Display="Dynamic" />
            </div>

            <div class="form-group">
                <label>Total Bathrooms:</label>
                <asp:TextBox ID="txtTotalBathrooms" runat="server" TextMode="Number" />
                <asp:RequiredFieldValidator
                    ID="rfvTotalBathrooms"
                    runat="server"
                    ControlToValidate="txtTotalBathrooms"
                    ErrorMessage="Total Bathrooms is required"
                    ForeColor="Red"
                    Display="Dynamic" />
                <asp:RangeValidator
                    ID="rvTotalBathrooms"
                    runat="server"
                    ControlToValidate="txtTotalBathrooms"
                    Type="Integer"
                    MinimumValue="1"
                    MaximumValue="10"
                    ErrorMessage="Total Bathrooms must be greater than 0"
                    ForeColor="Red"
                    Display="Dynamic" />
            </div>

            <asp:Button ID="btnUpdate" runat="server" Text="Update Property" OnClick="btnUpdate_Click" CssClass="button" />
        </div>
    </body>
    </html>
</asp:Content>
