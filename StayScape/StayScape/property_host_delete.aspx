<%@ Page Title="" Language="C#" MasterPageFile="~/Main.Master" AutoEventWireup="true" CodeBehind="property_host_delete.aspx.cs" Inherits="StayScape.property_host_delete" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <!DOCTYPE html>
    <html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Delete Property</title>
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
            <h2>Delete Property</h2>
            <div class="form-group">
                <label>Select Property:</label>
                <asp:DropDownList ID="ddlProperty" runat="server" CssClass="form-control" AutoPostBack="true" OnSelectedIndexChanged="ddlProperty_SelectedIndexChanged">
                    <asp:ListItem Text="--Select Property--" Value="" />
                </asp:DropDownList>
            </div>
            <asp:Panel ID="PanelPropertyDetails" runat="server" Visible="false">
                <div class="property-details">
                    <p>
                        <strong>Price:</strong>
                        <asp:Label ID="lblPrice" runat="server"></asp:Label>
                    </p>
                    <p>
                        <strong>Description:</strong>
                        <asp:Label ID="lblDescription" runat="server"></asp:Label>
                    </p>
                    <p>
                        <strong>Address:</strong>
                        <asp:Label ID="lblAddress" runat="server"></asp:Label>
                    </p>
                    <p> <asp:Label ID="lblSuccess" runat="server"></asp:Label></p>
                </div>
                <asp:Button ID="btnDelete" runat="server" Text="Confirm Delete" CssClass="button" OnClientClick="return confirm('Are you sure you want to delete this property?');" OnClick="btnDelete_Click" />
            </asp:Panel>
        </div>

    </body>
    </html>
</asp:Content>
