<%@ Page Title="" Language="C#" MasterPageFile="~/Customer.Master" AutoEventWireup="true" CodeBehind="property_list.aspx.cs" Inherits="StayScape.PPT.property_list" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="bg-white">
        <div class="container mx-auto max-w-7xl px-4 py-6 sm:px-6 sm:py-10 lg:px-8">
            <h1 class="text-3xl font-bold tracking-tight text-gray-900 mb-6 text-center">Property List</h1>
            <br />
            <div class="search-container mb-6 flex justify-center">
                <input type="text" id="searchInput" placeholder="Search by Property Name" class="w-full mr-2 p-2 border border-gray-300 rounded-md" onkeyup="filterCards()">
            </div>

            <div>
                <select id="ddlState" class="mr-2 py-2 pl-4 pr-8 border border-gray-300 rounded-md" onchange="filterProperties()">
                    <option disabled selected>All States</option>
                    <option value="Johor">Johor</option>
                    <option value="Kedah">Kedah</option>
                    <option value="Kelantan">Kelantan</option>
                    <option value="Malacca">Malacca</option>
                    <option value="Negeri Sembilan">Negeri Sembilan</option>
                    <option value="Pahang">Pahang</option>
                    <option value="Perak">Perak</option>
                    <option value="Perlis">Perlis</option>
                    <option value="Penang">Penang</option>
                    <option value="Sabah">Sabah</option>
                    <option value="Sarawak">Sarawak</option>
                    <option value="Selangor">Selangor</option>
                    <option value="Terengganu">Terengganu</option>
                    <option value="Kuala Lumpur">Kuala Lumpur</option>
                    <option value="Labuan">Labuan</option>
                    <option value="Putrajaya">Putrajaya</option>
                </select>
                <select id="ddlBedrooms" class="mr-2 py-2 pl-4 pr-8 border border-gray-300 rounded-md" onchange="filterProperties()">
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
                <select id="ddlBathrooms" class="mr-2 py-2 pl-4 pr-8 border border-gray-300 rounded-md" onchange="filterProperties()">
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
            </div>
            <br />
            <div class="grid grid-cols-1 gap-x-6 gap-y-10 sm:grid-cols-2 lg:grid-cols-4 xl:gap-x-8">
                <% foreach (var property in Properties)
                    { %>
                <div class="property-card mb-6" data-bedrooms="<%= property.TotalBedroom %>" data-bathrooms="<%= property.TotalBathroom %>" data-state="<%= property.PropertyAddress_State %>">
                    <div class="group relative">
                        <a href="property_details.aspx?propertyID=<%= property.PropertyID %>">
                            <div class="aspect-h-1 aspect-w-1 w-full overflow-hidden rounded-md bg-gray-200 lg:aspect-none group-hover:opacity-75 lg:h-80">
                                <% if (property.PropertyImages != null && property.PropertyImages.Count > 0)
                                    { %>
                                <img src="data:image/jpeg;base64,<%= Convert.ToBase64String(property.PropertyImages[0]) %>" alt="Property Image" class="h-full w-full object-cover object-center lg:h-full lg:w-full" />
                                <% }
                                    else
                                    { %>
                                <p>No image available.</p>
                                <% } %>
                            </div>
                        </a>
                        <div class="mt-4 flex justify-between">
                            <div>
                                <h3 class="text-sm text-gray-700 property-name">
                                    <a href="property_details.aspx?propertyID=<%= property.PropertyID %>">
                                        <span aria-hidden="true" class="absolute inset-0"></span>
                                        <%= property.PropertyName %>
                                    </a>
                                </h3>
                                <p class="mt-1 text-sm text-gray-500"><%= property.PropertyDesc %></p>
                            </div>
                            <p class="text-sm font-medium text-gray-900">RM <%= property.PropertyPrice %></p>
                        </div>
                    </div>
                </div>
                <% } %>
            </div>
        </div>
    </div>
    <script>
        function filterProperties() {
            filterCards();
        }

        function filterCards() {
            var filter = document.getElementById("searchInput").value.trim().toUpperCase();
            var bedroomsFilter = document.getElementById("ddlBedrooms").value;
            var bathroomsFilter = document.getElementById("ddlBathrooms").value;
            var stateFilter = document.getElementById("ddlState").value.toUpperCase();

            var cards = document.querySelectorAll('.property-card');
            cards.forEach(function (card) {
                var name = card.querySelector('.property-name a').textContent.toUpperCase().trim();
                var bedrooms = card.getAttribute("data-bedrooms");
                var bathrooms = card.getAttribute("data-bathrooms");
                var state = card.getAttribute("data-state").toUpperCase();

                var matchesFilter = (filter === '' || name.startsWith(filter)) &&
                    (bedroomsFilter === "All Bedrooms" || bedrooms === bedroomsFilter) &&
                    (bathroomsFilter === "All Bathrooms" || bathrooms === bathroomsFilter) &&
                    (stateFilter === "ALL STATES" || state === stateFilter);

                card.style.display = matchesFilter ? "" : "none";
            });
        }
    </script>

</asp:Content>
