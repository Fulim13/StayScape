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
            margin: 0;
            padding: 20px;
        }
        .container {
            max-width: 600px;
            margin: 0 auto;
        }
        .form-group {
            margin-bottom: 20px;
        }
        label {
            display: block;
            font-weight: bold;
            margin-bottom: 5px;
        }
        input[type="text"], input[type="number"] {
            width: 100%;
            padding: 10px;
            font-size: 16px;
            border: 1px solid #ccc;
            border-radius: 5px;
            box-sizing: border-box;
        }
        .button {
            background-color: #007bff; 
            color: #fff; 
            border: none;
            border-radius: 5px;
            padding: 10px 20px;
            font-size: 16px;
            cursor: pointer;
        }
        .button:hover {
            background-color: #0056b3;
        }
    </style>
</head>
<body>
    <div class="container">
        <h2>Insert Property</h2>
            <div class="form-group">
                <label for="propertyID">Property ID:</label>
                <input type="number" id="propertyID" name="propertyID" required>
            </div>
            <div class="form-group">
                <label for="propertyName">Property Name:</label>
                <input type="text" id="propertyName" name="propertyName" required>
            </div>
            <div class="form-group">
                <label for="propertyPrice">Property Price:</label>
                <input type="number" id="propertyPrice" name="propertyPrice" required>
            </div>
            <div class="form-group">
                <label for="propertyDesc">Property Description:</label>
                <textarea id="propertyDesc" name="propertyDesc" required></textarea>
            </div>
            <div class="form-group">
                <label for="propertyAddress">Property Address:</label>
                <input type="text" id="propertyAddress" name="propertyAddress" required>
            </div>
            <div class="form-group">
                <label for="totalBedroom">Total Bedrooms:</label>
                <input type="number" id="totalBedroom" name="totalBedroom" required>
            </div>
            <div class="form-group">
                <label for="totalBathroom">Total Bathrooms:</label>
                <input type="number" id="totalBathroom" name="totalBathroom" required>
            </div>
            <button type="submit" class="button">Upload Property</button>
    </div>
   
</body>
</html>
</asp:Content>

