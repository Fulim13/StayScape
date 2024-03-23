<%@ Page Title="" Language="C#" MasterPageFile="~/Main.Master" AutoEventWireup="true" CodeBehind="Review.aspx.cs" Inherits="StayScape.Review" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="ratingsCSS.css" rel="stylesheet" />
    <link href="~/Content/bootstrap.min.css" rel="stylesheet" />
    <script src="~/Scripts/bootstrap.bundle.min.js"></script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="flex flex-col flex-grow">
      <div class="bg-indigo-300 review-box">
        <div class="py-2 px-2">3 ratings</div>
         <hr />
         <div class="review-border px-2 py-2">
            <div class="flex py-2">
                <div class="flex py-2 mr-4">
                <img class="h-8 w-8 rounded-full" src="Images/WorldviewGrandHotel.jpg" alt="">
                </div>
                <div class="flex flex-col">
                    <p>Worldview Grand Hotel</p>
                    <p>29-35, Jalan 10/23a, Medan Makmur, 53300 Kuala Lumpur, Wilayah Persekutuan Kuala Lumpur</p>
                </div>
            </div>
            <div class="flex">
                <div class="flex py-1 mr-4"">
                    <span class="">&#9733;</span>
                    <span class="">&#9733;</span>
                    <span class="">&#9733;</span>
                    <span class="">&#9733;</span>
                    <span class="">&#9734;</span>
                </div>
                    <div class="flex py-1">8 months ago</div>
                  
            </div>
            <div class="relative">
                <p>The room and the bathroom were comfortable and clean!</p>
                <div class="px-2 absolute inset-y-0 right-0 w-16">
                    <asp:Button ID="deleteButton" runat="server" Text="Delete" style="background-color: #3381f0; border-radius: 5px; color: white; width: 60px;" />
                </div>
            </div>
           </div>
          <hr />
          <div class="review-border px-2 py-2">
            <div class="flex py-2">
                <div class="flex py-2 mr-4">
                  <img class="h-8 w-8 rounded-full" src="Images/WorldviewGrandHotel.jpg" alt="">
                </div>
                <div class="flex flex-col">
                    <div>Worldview Grand Hotel</div>
                    <div>29-35, Jalan 10/23a, Medan Makmur, 53300 Kuala Lumpur, Wilayah Persekutuan Kuala Lumpur</div>
                </div>
            </div>
            <div class="flex">
                <div class="flex py-1 mr-4"">
                    <span class="">&#9733;</span>
                    <span class="">&#9733;</span>
                    <span class="">&#9733;</span>
                    <span class="">&#9733;</span>
                    <span class="">&#9734;</span>
                </div>
                <div class="flex py-1">8 months ago</div>
            </div>
            <div class="relative">
                <p>The room and the bathroom were comfortable and clean!</p>
                <div class="px-2 absolute inset-y-0 right-0 w-16">
                    <asp:Button ID="Button1" runat="server" Text="Delete" style="background-color: #3381f0; border-radius: 5px; color: white; width: 60px;" />
                </div>
            </div>
          </div>
          <hr />
          <div class="review-border px-2 py-2">
            <div class="flex py-2">
                <div class="flex py-2 mr-4">
                  <img class="h-8 w-8 rounded-full" src="Images/WorldviewGrandHotel.jpg" alt="">
                </div>
                <div class="flex flex-col">
                    <div>Worldview Grand Hotel</div>
                    <div>29-35, Jalan 10/23a, Medan Makmur, 53300 Kuala Lumpur, Wilayah Persekutuan Kuala Lumpur</div>
                </div>
            </div>
            <div class="flex">
                <div class="flex py-1 mr-4"">
                    <span class="">&#9733;</span>
                    <span class="">&#9733;</span>
                    <span class="">&#9733;</span>
                    <span class="">&#9733;</span>
                    <span class="">&#9734;</span>
                </div>
                <div class="flex py-1">8 months ago</div>
            </div>
            <div class="relative">
                <p>The room and the bathroom were comfortable and clean!</p>
                <div class="px-2 absolute inset-y-0 right-0 w-16">
                    <asp:Button ID="Button2" runat="server" Text="Delete" style="background-color: #3381f0; border-radius: 5px; color: white; width: 60px;" />
                </div>
            </div>
          </div>
      </div>
    </div>
</asp:Content>
