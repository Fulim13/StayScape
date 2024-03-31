<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="property_details.aspx.cs" Inherits="StayScape.PPT.property_details" %>
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
        }
        .container {
            max-width: 800px;
            margin: 0 auto;
            background-color: #fff;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }
        .property-details {
            margin-bottom: 20px;
        }
        .property-image {
            width: 100%;
            max-width: 400px;
            border-radius: 5px;
            margin-bottom: 20px;
        }
        .property-name {
            font-size: 24px;
            color: #007bff;
            margin-bottom: 10px;
        }
        .property-info {
            margin-bottom: 10px;
        }
        .property-info strong {
            margin-right: 5px;
        }
        .button-container {
            text-align: center;
        }
        .button {
            background-color: #007bff;
            color: #fff;
            border: none;
            border-radius: 5px;
            padding: 10px 20px;
            margin: 0 10px;
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
        <div class="property-details">
            <% if (Property != null) { %>
                <img src="PropertyImg/1.jpg" alt="Property Image" class="property-image">
                <h2 class="property-name"><%= Property.PropertyName %></h2>
                <div class="property-info">
                    <strong>Price:</strong> $<%= Property.PropertyPrice %><br>
                    <strong>Description:</strong> <%= Property.PropertyDesc %><br>
                    <strong>Address:</strong> <%= Property.PropertyAddress %><br>
                    <strong>Total Bedrooms:</strong> <%= Property.TotalBedroom %><br>
                    <strong>Total Bathrooms:</strong> <%= Property.TotalBathroom %><br>
                    <strong>Created At:</strong> <%= Property.CreatedAt.ToString("yyyy-MM-dd HH:mm:ss") %><br>
                    <strong>Last Update:</strong> <%= Property.LastUpdate.ToString("yyyy-MM-dd HH:mm:ss") %><br>
                </div>
            <% } else { %>
                <p>No property details available.</p>
            <% } %>
        </div>
        <div class="button-container">
            <button class="button">Reserve</button>
            <button class="button" onclick="goBack()">Back</button>
        </div>
    </div>

    <script>
        function goBack() {
            window.history.back();
        }
    </script>
</body>
</html>
