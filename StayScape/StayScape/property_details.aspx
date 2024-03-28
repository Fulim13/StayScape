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
        .button {
            background-color: #007bff;
            color: #fff;
            border: none;
            border-radius: 5px;
            padding: 10px 20px;
            margin-top: 20px;
            cursor: pointer;
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

            <!-- Reserve button -->
           <button class="button">Reserve</button>

            <!-- Back button -->
            <button class="button" onclick="goBack()">Back</button>

            <script>
                function goBack() {
                    window.history.back();
                }
            </script>
        </div>
    </div>
</body>
</html>
