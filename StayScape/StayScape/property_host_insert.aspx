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
            <asp:RangeValidator
                ID="rvTotalBedrooms"
                runat="server"
                ControlToValidate="txtTotalBedrooms"
                Type="Integer"
                MinimumValue="1"
                MaximumValue="10"
                ErrorMessage="Total Bedrooms must be greater than 0 and not more than 10"
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
            <asp:RangeValidator
                ID="rvTotalBathrooms"
                runat="server"
                ControlToValidate="txtTotalBathrooms"
                Type="Integer"
                MinimumValue="1"
                MaximumValue="10"
                ErrorMessage="Total Bathrooms must be greater than 0 and not more than 10"
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
        <asp:Button ID="btnSubmit" runat="server" Text="Add Property" CssClass="button" OnClientClick="return validateForm();" OnClick="UploadProperty" />
        </asp:Panel>
        </div>
    </body>
    </html>
    <script>
        function validateForm() {
            var propertyName = document.getElementById('<%= txtPropertyName.ClientID %>').value;
            var propertyPrice = document.getElementById('<%= txtPropertyPrice.ClientID %>').value;
            var propertyDesc = document.getElementById('<%= txtPropertyDesc.ClientID %>').value;
            var propertyAddress = document.getElementById('<%= txtPropertyAddress.ClientID %>').value;
            var city = document.getElementById('<%= txtCity.ClientID %>').value;
            var state = document.getElementById('<%= txtState.ClientID %>').value;
            var totalBedrooms = document.getElementById('<%= txtTotalBedrooms.ClientID %>').value;
            var totalBathrooms = document.getElementById('<%= txtTotalBathrooms.ClientID %>').value;
            var propertyImage = document.getElementById('<%= fuPropertyImage.ClientID %>').files;

            if (propertyName.trim() === '' ||
                propertyPrice.trim() === '' ||
                propertyDesc.trim() === '' ||
                propertyAddress.trim() === '' ||
                city.trim() === '' ||
                state.trim() === '' ||
                totalBedrooms.trim() === '' ||
                totalBathrooms.trim() === '' ||
                propertyImage.length === 0) {
                alert('Please fill in all required fields.');
                return false;
            }
            return true;
        }
    </script>

</asp:Content>
