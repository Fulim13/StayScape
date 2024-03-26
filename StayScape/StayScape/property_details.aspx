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
      
        .property-name {
            font-size: 24px;
            color: #007bff;
            margin-bottom: 10px;
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="property-details">
            <% if (Property != null) { %>
                <h2 class="property-name"><%= Property.PropertyName %></h2>
                <p><strong>Price:</strong> $<%= Property.PropertyPrice %></p>
                <p><strong>Description:</strong> <%= Property.PropertyDesc %></p>
                <p><strong>Address:</strong> <%= Property.PropertyAddress %></p>
                <p><strong>Total Bedrooms:</strong> <%= Property.TotalBedroom %></p>
                <p><strong>Total Bathrooms:</strong> <%= Property.TotalBathroom %></p>
                <p><strong>Created At:</strong> <%= Property.CreatedAt.ToString("yyyy-MM-dd HH:mm:ss") %></p>
                <p><strong>Last Update:</strong> <%= Property.LastUpdate.ToString("yyyy-MM-dd HH:mm:ss") %></p>
            <% } else { %>
                <p>No property details available.</p>
            <% } %>
        </div>
    </div>
</body>
</html>
</asp:Content>
