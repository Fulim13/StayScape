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
                background-color: #0056b3;
            }
        </style>
    </head>
    <body>
        <div class="container">
            <h2>Update Current Property</h2>
            <div class="form-group">
                <label for="propertyName">Select Property Name:</label>
                <select id="propertyName" name="propertyName" required>
                    <option value="property1">Property 1</option>
                    <option value="property2">Property 2</option>
                    <option value="property3">Property 3</option>
                </select>
            </div>
            <div class="form-group">
                <label for="propertyPrice">Enter Updated Property Price:</label>
                <input type="number" id="propertyPrice" name="propertyPrice" required>
            </div>
            <button type="submit" class="button" onclick="confirmUpdate()">Confirm Update</button>
        </div>

        <script>
            function confirmUpdate() {
                if (confirm("Are you sure you want to update the property price?")) {
                    ///Will add the function to make changes in database
                    alert("Property price updated successfully for property: ");
                }
            }
        </script>
    </body>
    </html>
</asp:Content>
