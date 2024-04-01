<%@ Page Title="" Language="C#" MasterPageFile="~/Customer.Master" AutoEventWireup="true" CodeBehind="property_list.aspx.cs" Inherits="StayScape.PPT.property_list" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="bg-white">
        <div class="container mx-auto max-w-7xl px-4 py-6 sm:px-6 sm:py-10 lg:px-8">
            <h1 class="text-3xl font-bold tracking-tight text-gray-900 mb-6 text-center">Property List</h1>
            <br />
            <div class="search-container mb-6 flex justify-center">
                <input type="text" id="searchInput" placeholder="Search by Property Name" class="mr-2 p-2 border border-gray-300 rounded-md">
                <select id="ddlBedrooms" class="mr-2 p-2 border border-gray-300 rounded-md">
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
                <select id="ddlBathrooms" class="mr-2 p-2 border border-gray-300 rounded-md">
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
               <button onclick="searchProperties()" class="inline-block p-3 bg-blue-500 text-white rounded-md hover:bg-blue-600 transition duration-300">Search</button>
                <br />
            </div>
            <br />
            <div class="grid grid-cols-1 gap-x-6 gap-y-10 sm:grid-cols-2 lg:grid-cols-4 xl:gap-x-8">
                <% foreach (var property in Properties)
                { %>
                <div class="property-card mb-6" data-bedrooms="<%= property.TotalBedroom %>" data-bathrooms="<%= property.TotalBathroom %>">
                    <div class="group relative">
                        <a href="property_details.aspx?propertyID=<%= property.PropertyID %>">
                            <div class="aspect-h-1 aspect-w-1 w-full overflow-hidden rounded-md bg-gray-200 lg:aspect-none group-hover:opacity-75 lg:h-80">
                                <img src="PropertyImg/1.jpg" alt="Property Image" class="h-full w-full object-cover object-center lg:h-full lg:w-full">
                            </div>
                        </a>
                        <div class="mt-4 flex justify-between">
                            <div>
                                <h3 class="text-sm text-gray-700">
                                    <a href="property_details.aspx?propertyID=<%= property.PropertyID %>">
                                        <span aria-hidden="true" class="absolute inset-0"></span>
                                        <%= property.PropertyName %>
                                    </a>
                                </h3>
                                <p class="mt-1 text-sm text-gray-500"><%= property.PropertyDesc %></p>
                            </div>
                            <p class="text-sm font-medium text-gray-900">$<%= property.PropertyPrice %></p>
                        </div>
                    </div>
                </div>
                <% } %>
            </div>
        </div>
    </div>

    <script>
        function searchProperties() {
            var input, filter, cards, card, name, i;
            input = document.getElementById("searchInput");
            filter = input.value.toUpperCase().trim();

            var bedroomsFilter = document.getElementById("ddlBedrooms").value;
            var bathroomsFilter = document.getElementById("ddlBathrooms").value;

            cards = document.querySelectorAll('.property-card');
            for (i = 0; i < cards.length; i++) {
                card = cards[i];
                name = card.querySelector('.property-name');

                var propertyName = name.innerText.toUpperCase().trim();
                var bedrooms = card.getAttribute("data-bedrooms");
                var bathrooms = card.getAttribute("data-bathrooms");

                if ((propertyName.includes(filter) || filter === '') &&
                    (bedroomsFilter === '' || bedrooms === bedroomsFilter) &&
                    (bathroomsFilter === '' || bathrooms === bathroomsFilter)) {
                    card.style.display = "flex";
                } else {
                    card.style.display = "none";
                }
            }
        }
    </script>
</asp:Content>


