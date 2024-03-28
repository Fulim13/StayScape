﻿<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="property_list.aspx.cs" Inherits="StayScape.PPT.property_list" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Property List</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f2f2f2;
            margin: 0;
            padding: 20px;
        }
        .container {
            max-width: 800px;
            margin: 0 auto;
        }
        .property-card {
            background-color: #fff;
            border-radius: 10px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            margin-bottom: 20px;
            padding: 20px;
        }
        .property-name {
            font-size: 24px;
            color: #007bff;
            margin-bottom: 10px;
        }
        .property-price {
            font-size: 18px;
            color: #333;
            margin-bottom: 10px;
        }
        .property-description {
            color: #555;
            margin-bottom: 10px;
        }

        .property-dates {
            margin-bottom: 5px;
        }
        .property-dates {
            color: #777;
        }
        .view-details-link {
        color: #007bff; 
        text-decoration: none;
    }

    .view-details-link:hover {
        color: #0056b3; 
    }

       .search-container {
            margin-bottom: 20px;
        }

        .search-container input[type=text] {
            padding: 10px;
            width: 300px;
        }

        .search-container button {
            padding: 10px 15px;
            background-color: #007bff;
            color: #fff;
            border: none;
            cursor: pointer;
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="search-container">
            <input type="text" id="searchInput" placeholder="Type a Property Name">
            <button onclick="searchProperties()">Search</button>
        </div>
        <% foreach (var property in Properties) { %>
            <div class="property-card">
                <h2 class="property-name"><%= property.PropertyName %></h2>
                <p class="property-price">Price: $<%= property.PropertyPrice %></p>
                <p class="property-description">Description: <%= property.PropertyDesc %></p>
                <p class="property-dates">
                    Created At: <%= property.CreatedAt.ToString("yyyy-MM-dd HH:mm:ss") %><br>
                    Last Update: <%= property.LastUpdate.ToString("yyyy-MM-dd HH:mm:ss") %>
                </p>
               <a href="property_details.aspx?propertyID=<%= property.PropertyID %>" class="view-details-link">View Details</a>
            </div>
        <% } %>
    </div>

     <script>
         function searchProperties() {
             var input, filter, cards, card, name, i;
             input = document.getElementById("searchInput");
             filter = input.value.toUpperCase();

             // Validate search query
             if (!filter.trim()) {
                 alert("Please enter a property name!");
                 return;
             }

             cards = document.getElementsByClassName("property-card");
             for (i = 0; i < cards.length; i++) {
                 card = cards[i];
                 name = card.getElementsByClassName("property-name")[0];
                 if (name.innerText.toUpperCase().indexOf(filter) > -1) {
                     card.style.display = "";
                 } else {
                     card.style.display = "none";
                 }
             }
         }
     </script>

</body>
</html>
