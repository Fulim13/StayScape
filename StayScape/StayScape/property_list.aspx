<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="property_list.aspx.cs" Inherits="StayScape.PPT.property_list" %>
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
            transition: box-shadow 0.3s ease;
        }
        .property-card:hover {
            box-shadow: 0 0 15px rgba(0, 0, 0, 0.2);
        }
        .property-image {
            width: 100%;
            max-width: 400px;
            border-radius: 5px;
            margin-bottom: 10px;
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
            display: flex;
            align-items: center;
        }
        .search-container input[type=text] {
            flex: 1;
            padding: 10px;
            border-radius: 5px;
            border: 1px solid #ccc;
            font-size: 16px;
            margin-right: 10px;
        }
        .search-container select {
            padding: 10px;
            border-radius: 5px;
            border: 1px solid #ccc;
            font-size: 16px;
            margin-right: 10px;
        }
        .search-container button {
            padding: 10px 15px;
            background-color: #007bff;
            color: #fff;
            border: none;
            border-radius: 5px;
            font-size: 16px;
            cursor: pointer;
            transition: background-color 0.3s ease;
        }
        .search-container button:hover {
            background-color: #0056b3;
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="search-container">
            <input type="text" id="searchInput" placeholder="Type a Property Name">
            <select id="ddlBedrooms">
                <option disabled selected>All Bedrooms</option>
                <option value="1">1 Bedroom</option>
                <option value="2">2 Bedrooms</option>
                <option value="3">3 Bedrooms</option>
                <option value="4">4 Bedrooms</option>
                <option value="5">5 Bedrooms</option>
                <option value="6">6 Bedrooms</option>
                <option value="7">7 Bedrooms</option>
                <option value="8">8 Bedrooms</option>
                <option value="9">9 Bedrooms</option>
                <option value="10">10 Bedrooms</option>
            </select>
            <select id="ddlBathrooms">
                <option disabled selected>All Bathrooms</option>
                <option value="1">1 Bathroom</option>
                <option value="2">2 Bathrooms</option>
                <option value="3">3 Bathrooms</option>
                <option value="4">4 Bathrooms</option>
                <option value="5">5 Bathrooms</option>
                <option value="6">6 Bathrooms</option>
                <option value="7">7 Bathrooms</option>
                <option value="8">8 Bathrooms</option>
                <option value="9">9 Bathrooms</option>
                <option value="10">10 Bathrooms</option>
            </select>
            <button onclick="searchProperties()">Search</button>
        </div>
        <% foreach (var property in Properties) { %>
            <div class="property-card" data-bedrooms="<%= property.TotalBedroom %>" data-bathrooms="<%= property.TotalBathroom %>">
                <img src="PropertyImg/1.jpg" alt="Property Image" class="property-image">
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
          filter = input.value.toUpperCase().trim(); 

          var bedroomsFilter = document.getElementById("ddlBedrooms").value;
          var bathroomsFilter = document.getElementById("ddlBathrooms").value;

          if (!filter) {
              alert("Please enter a property name!");
              return;
          }

          cards = document.getElementsByClassName("property-card");
          for (i = 0; i < cards.length; i++) {
              card = cards[i];
              name = card.getElementsByClassName("property-name")[0];
              var bedrooms = card.getAttribute("data-bedrooms");
              var bathrooms = card.getAttribute("data-bathrooms");

              var propertyName = name.innerText.toUpperCase().trim(); 

              if (propertyName.startsWith(filter) ||
                  (bedroomsFilter === "" || bedrooms === bedroomsFilter) &&
                  (bathroomsFilter === "" || bathrooms === bathroomsFilter)) {
                  card.style.display = "";
              } else {
                  card.style.display = "none";
              }
          }
      }
  </script>

</body>
</html>
