<%@ Page Title="" Language="C#" MasterPageFile="~/Main.Master" AutoEventWireup="true" CodeBehind="property_host_insert.aspx.cs" Inherits="StayScape.property_host_insert" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <!DOCTYPE html>
    <html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Insert Property</title>
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

            input[type="text"], input[type="number"], textarea, input[type="file"] {
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

            .success-message {
                color: green;
                background-color: #CCFFCC;
                border: 1px solid green;
                padding: 10px;
                margin-top: 10px;
                display: none;
            }
        </style>
    </head>
    <body>
        <div class="container">
            <h2>Add a New Property</h2>
            <asp:Panel ID="Panel1" runat="server" DefaultButton="btnSubmit">
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
                </div>
                <div class="form-group">
                    <label>Property Description:</label>
                    <asp:TextBox ID="txtPropertyDesc" runat="server" TextMode="MultiLine" />
                    <asp:RequiredFieldValidator
                        ID="rfvPropertyDesc"
                        runat="server"
                        ControlToValidate="txtPropertyDesc"
                        ErrorMessage="Property Description is required"
                        ForeColor="Red"
                        Display="Dynamic" />
                </div>
                <div class="form-group">
                    <label>Property Address:</label>
                    <asp:TextBox ID="txtPropertyAddress" runat="server" />
                    <asp:RequiredFieldValidator
                        ID="rfvPropertyAddress"
                        runat="server"
                        ControlToValidate="txtPropertyAddress"
                        ErrorMessage="Property Address is required"
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
                        ID="rfvTtlBedroom"
                        runat="server"
                        ControlToValidate="txtTotalBedrooms"
                        ErrorMessage="Number of Bedrooms is required"
                        ForeColor="Red"
                        Display="Dynamic" />
                </div>
                <div class="form-group">
                    <label>Total Bathrooms:</label>
                    <asp:TextBox ID="txtTotalBathrooms" runat="server" TextMode="Number" />
                    <asp:RequiredFieldValidator
                        ID="rfvTtlBathrooms"
                        runat="server"
                        ControlToValidate="txtTotalBathrooms"
                        ErrorMessage="Number of Bathrooms is required"
                        ForeColor="Red"
                        Display="Dynamic" />
                </div>
                <div class="form-group">
                    <label>Property Image:</label>
                    <asp:FileUpload ID="fuPropertyImage" runat="server" AllowMultiple="true" />
                    <asp:RequiredFieldValidator
                        ID="rfvPropertyImage"
                        runat="server"
                        ControlToValidate="fuPropertyImage"
                        ErrorMessage="Image is required"
                        ForeColor="Red"
                        Display="Dynamic" />
                </div>
                <asp:Button ID="btnSubmit" runat="server" Text="Add Property" CssClass="button" OnClientClick="return confirm('Are you sure you want to add this property?');" OnClick="UploadProperty" />
                <asp:Label ID="lblSuccessMessage" runat="server" CssClass="success-message"></asp:Label>

            </asp:Panel>
        </div>
    </body>
    </html>

</asp:Content>
