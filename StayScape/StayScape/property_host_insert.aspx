<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="property_host_insert.aspx.cs" Inherits="StayScape.property_host_insert" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Property Host</title>
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
            background-color: #fff;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }
        h1 {
            color: #333;
        }
        label {
            display: block;
            margin-bottom: 10px;
        }
        input[type="text"],
        input[type="number"],
        textarea {
            width: 100%;
            padding: 10px;
            margin-bottom: 20px;
            border: 1px solid #ccc;
            border-radius: 5px;
            box-sizing: border-box;
        }
        input[type="file"] {
            margin-bottom: 20px;
        }
        input[type="submit"] {
            background-color: #007bff;
            color: #fff;
            border: none;
            padding: 10px 20px;
            font-size: 16px;
            border-radius: 5px;
            cursor: pointer;
        }
        input[type="submit"]:hover {
            background-color: #0056b3;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>Property Host</h1>
        <asp:Label ID="lblMessage" runat="server" ForeColor="Green"></asp:Label>
        <form id="propertyForm" runat="server" enctype="multipart/form-data">
           

            <label for="propertyName">Property Name:</label>
            <input type="text" id="propertyName" name="propertyName" runat="server" required>

            <label for="propertyPrice">Property Price:</label>
            <input type="number" id="propertyPrice" name="propertyPrice" runat="server" required>

            <label for="propertyDescription">Property Description:</label>
            <textarea id="propertyDescription" name="propertyDescription" rows="5" runat="server" required></textarea>

            <label for="propertyAddress">Property Address:</label>
            <input type="text" id="propertyAddress" name="propertyAddress" runat="server" required>

            <label for="totalBedrooms">Total Bedrooms:</label>
            <input type="number" id="totalBedrooms" name="totalBedrooms" runat="server" required>

            <label for="totalBathrooms">Total Bathrooms:</label>
            <input type="number" id="totalBathrooms" name="totalBathrooms" runat="server" required>

            <input type="submit" value="Upload Property" OnServerClick="UploadProperty_Click">
        </form>
    </div>
</body>
</html>