<%@ Page Title="" Language="C#" MasterPageFile="~/Main.Master" AutoEventWireup="true" CodeBehind="property_host.aspx.cs" Inherits="StayScape.property_host" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Property Host</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f2f2f2;
        }
        .container {
            max-width: 600px;
            margin: 0 auto;
        }
        .card-holder {
            display: flex;
            justify-content: space-between;
            margin-bottom: 20px;
        }
        .card {
            flex: 0 0 calc(33.33% - 10px);
            background-color: #fff;
            border-radius: 10px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            padding: 20px;
            text-align: center;
        }
        .button {
            display: block;
            width: 100%;
            padding: 10px 20px;
            margin-top: 10px;
            background-color: #007bff; 
            color: #fff;
            border: none;
            border-radius: 5px;
            font-size: 16px;
            text-decoration: none;
            cursor: pointer;
        }
        .button:hover {
            background-color: #0056b3; 
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="card-holder">
            <div class="card">
                <h2>Insert</h2>
                <a href="property_host_insert.aspx" class="button">Insert</a>
            </div>
            <div class="card">
                <h2>Update</h2>
                <a href="property_host_modify.aspx" class="button">Update</a>
            </div>
            <div class="card">
                <h2>Delete</h2>
                <a href="property_host_delete.aspx" class="button">Delete</a>
            </div>
        </div>
    </div>
</body>
</html>
</asp:Content>


