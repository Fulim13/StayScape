<%@ Page Title="" Language="C#" MasterPageFile="~/Main.Master" AutoEventWireup="true" CodeBehind="property_list.aspx.cs" Inherits="StayScape.PPT.property_list" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Property List</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f2f2f2;
            margin: 0;
            padding: 0;
        }
        .container {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(300px, 1fr));
            gap: 20px;
        }
        .property-card {
            background-color: #fff;
            border-radius: 10px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            overflow: hidden;
        }
        .property-card1 {
            background-color: #fff;
            border-radius: 10px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            overflow: hidden;
        }

        .property-card img {
            width: 100%;
            height: auto;
            cursor: pointer;
        }
        .property-info {
            padding: 20px;
        }
        h2, p {
            margin: 5px 0;
        }
        .property-info p {
            color: #555;
        }
        .property-info p:first-child {
            font-weight: bold;
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="property-card">
            <img src="property1.jpg" alt="Property 1" onclick="window.location.href='property_details.aspx';">
            <div class="property-info">
                <h2>Property Name 1(Example)</h2>
                <p><strong>Price:</strong> $500,000</p>
                <p><strong>Description:</strong> Lorem ipsum dolor sit amet, consectetur adipiscing elit.</p>
                <p><strong>Address:</strong> 123 Main Street, Cityville</p>
                <p><strong>Bedrooms:</strong> 4</p>
                <p><strong>Bathrooms:</strong> 3</p>
                <p><strong>Created At:</strong> January 1, 2024 10:00 AM</p>
                <p><strong>Last Update:</strong> March 20, 2024 3:30 PM</p>
            </div>
        </div>
        <div class="property-card1">
            <img src="property2.jpg" alt="Property 1" onclick="window.location.href='property_details.aspx';">
            <div class="property-info">
                <h2>Property Name 2(Example)</h2>
                <p><strong>Price:</strong> $500,000</p>
                <p><strong>Description:</strong> Lorem ipsum dolor sit amet, consectetur adipiscing elit.</p>
                <p><strong>Address:</strong> 123 Main Street, Cityville</p>
                <p><strong>Bedrooms:</strong> 4</p>
                <p><strong>Bathrooms:</strong> 3</p>
                <p><strong>Created At:</strong> January 1, 2024 10:00 AM</p>
                <p><strong>Last Update:</strong> March 20, 2024 3:30 PM</p>
        </div>
    </div>
    </div>
</body>
</html>

</asp:Content>
