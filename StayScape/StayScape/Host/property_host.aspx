<%@ Page Title="" Language="C#" MasterPageFile="Main.Master" AutoEventWireup="true" CodeBehind="property_host.aspx.cs" Inherits="StayScape.property_host" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <!DOCTYPE html>
    <html>
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Property Host</title>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
        <link href="./dist/output.css" rel="stylesheet" />
        <style>
            body {
                font-family: Arial, sans-serif;
                background-color: #f2f2f2;
            }

            .container {
                max-width: 1200px;
                margin: 20px auto;
                text-align: center;
            }

            .heading {
                font-size: 36px;
                font-weight: bold;
                margin-bottom: 40px;
                color: #333;
            }

            .card-holder {
                display: flex;
                justify-content: center;
                flex-wrap: wrap;
            }

            .large-icon {
                font-size: 48px;
                color: #4338ca;
                padding: 5px;
            }

            .card {
                flex: 0 0 calc(33.33% - 40px);
                background-color: #fff;
                border-radius: 10px;
                box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
                padding: 30px;
                margin: 20px;
                transition: all 0.3s ease;
            }

                .card:hover {
                    box-shadow: 0 0 20px rgba(0, 0, 0, 0.2);
                    transform: translateY(-5px);
                }

                .card h2 {
                    font-size: 24px;
                    margin-bottom: 20px;
                    color: #333;
                }

            .button {
                display: inline-block;
                padding: 12px 24px;
                background-color: #4338ca;
                color: #fff;
                border: none;
                border-radius: 5px;
                font-size: 18px;
                text-decoration: none;
                cursor: pointer;
                transition: background-color 0.3s ease;
            }

                .button:hover {
                    background-color: #4338ca;
                }

            .icon {
                font-size: 40px;
                margin-bottom: 20px;
                color: #4338ca;
            }
        </style>
    </head>
    <body>
        <div class="container">
            <h1 class="heading">Manage Your Properties</h1>
            <div class="card-holder">
                <div class="card">
                    <i class="fas fa-plus-circle icon"></i>
                    <h2>Create New Property</h2>
                    <a href="property_host_insert.aspx" class="button">Insert</a>
                </div>
                <div class="card">
                    <i class="fas fa-edit icon"></i>
                    <h2>Update Current Property</h2>
                    <a href="property_host_modify.aspx" class="button">Update</a>
                </div>
                <div class="card">
                    <i class="fas fa-sync-alt large-icon"></i>
                    <h2>Toggle Activation Property</h2>
                    <a href="property_host_delete.aspx" class="button">Toggle</a>
                </div>
                <div class="card">
                    <i class="fas fa-list large-icon"></i>
                    <h2>Display All Properties</h2>
                    <a href="property_host_disp.aspx" class="button">Display All</a>
                </div>
            </div>
        </div>

    </body>
    </html>
</asp:Content>
