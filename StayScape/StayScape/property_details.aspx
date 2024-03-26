<%@ Page Title="" Language="C#" MasterPageFile="~/Main.Master" AutoEventWireup="true" CodeBehind="property_details.aspx.cs" Inherits="StayScape.PPT.property_details" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Property Details</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f2f2f2;
            margin: 0;
            padding: 0;
        }
        .container {
            max-width: 800px;
            margin: 20px auto;
            background-color: #fff;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }
        h1 {
            color: #333;
        }
        .property-image {
            max-width: 100%;
            height: auto;
            margin-bottom: 20px;
        }
        .property-info {
            margin-bottom: 20px;
        }
        .property-info p {
            margin: 5px 0;
        }
        .reserve-button {
            background-color: #007bff;
            color: #fff;
            border: none;
            padding: 10px 20px;
            font-size: 16px;
            border-radius: 5px;
            cursor: pointer;
        }
          #btnGoBack {
            top: 10px;
            right: 10px;
            background-color: #007bff;
            color: #fff;
            border: none;
            padding: 10px 20px;
            font-size: 16px;
            border-radius: 5px;
            cursor: pointer;
  }
        .reserve-button:hover {
            background-color: #0056b3;
        }
         #btnGoBack:hover {
            background-color: #0056b3;
 }
    </style>
</head>
<body>
    <div class="container">
        <h1>Property Details(Example)</h1>
        <img class="property-image" src="property_image.jpg" alt="Property Image">
        <div class="property-info">
            <p><strong>Property Name:</strong> Villa Sunshine</p>
            <p><strong>Property Price:</strong> $500,000</p>
            <p><strong>Property Description:</strong> Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed eget metus id velit dignissim accumsan.</p>
            <p><strong>Property Address:</strong> 123 Main Street, Cityville</p>
            <p><strong>Total Bedrooms:</strong> 4</p>
            <p><strong>Total Bathrooms:</strong> 3</p>
            <p><strong>Created At:</strong> January 1, 2024 10:00 AM</p>
            <p><strong>Last Update:</strong> March 20, 2024 3:30 PM</p>
        </div>
        <button class="reserve-button">Reserve</button>
       <asp:Button ID="btnGoBack" runat="server" Text="Back" OnClick="btnGoBack_Click" />
    </div>
</body>
</html>
</asp:Content>
