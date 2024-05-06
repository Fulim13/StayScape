<%@ Page Title="" Language="C#" MasterPageFile="~/Main.Master" AutoEventWireup="true" CodeBehind="property_host_disp.aspx.cs" Inherits="StayScape.property_host_disp" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <style>
        .container {
            max-width: 1200px;
            margin: auto;
            padding: 20px;
            text-align: center;
        }

        .properties-list {
            display: flex;
            flex-wrap: wrap;
            justify-content: space-around;
        }

        .property-card {
            box-shadow: 0 2px 5px rgba(0,0,0,0.1);
            margin: 10px;
            width: 300px;
            padding: 20px;
            background-color: #fff;
            border-radius: 8px;
        }

            .property-card img {
                width: 100%;
                height: 200px;
                object-fit: cover;
                border-radius: 8px;
            }

            .property-card h3 {
                color: #333;
                font-size: 20px;
            }

            .property-card p {
                color: #666;
                font-size: 16px;
                margin: 5px 0;
            }
    </style>

    <div class="container">
        <h1 class="heading">All Properties</h1>
        <div>
            <input type="text" id="searchBox" onkeyup="filterProperties()" placeholder="Search by Property Name..." style="padding: 10px; width: 300px; margin-bottom: 20px;">
        </div>
        <div class="properties-list">
            <asp:Repeater ID="PropertiesRepeater" runat="server">
                <ItemTemplate>
                    <div class="property-card">
                        <h3><%# Eval("PropertyName") %></h3>
                        <div style="text-align: center; width: 100%; height: 100px; display: flex; align-items: center; justify-content: center;">
                            <img src='<%# Eval("PropertyImages") != DBNull.Value && Eval("PropertyImages") != null ? "data:image/jpeg;base64," + Convert.ToBase64String((byte[])Eval("PropertyImages")) : "path/to/default-image.jpg" %>' alt="Property Image" style="max-width: 100px; max-height: 100px;" />
                        </div>
                        <p>Description: <%# Eval("PropertyDesc") %></p>
                        <p>Price: RM <%# Eval("PropertyPrice") %></p>
                        <p>Location: <%# Eval("PropertyAddress_State") %></p>
                        <p>Bedrooms: <%# Eval("TotalBedroom") %> | Bathrooms: <%# Eval("TotalBathroom") %></p>
                        <p>Status: <%# Convert.ToBoolean(Eval("IsActive")) ? "Active" : "Inactive" %></p>
                    </div>
                </ItemTemplate>
            </asp:Repeater>
        </div>
    </div>

    <script>
        function filterProperties() {
            var input = document.getElementById("searchBox");
            var filter = input.value.toUpperCase();
            var cards = document.getElementsByClassName("property-card");
            var names;

            for (var i = 0; i < cards.length; i++) {
                names = cards[i].getElementsByTagName("h3")[0];
                if (names.innerHTML.toUpperCase().startsWith(filter)) {
                    cards[i].style.display = "";
                } else {
                    cards[i].style.display = "none";
                }
            }
        }
    </script>

</asp:Content>

