<%@ Page Title="" Language="C#" MasterPageFile="~/Main.Master" AutoEventWireup="true" CodeBehind="Review.aspx.cs" Inherits="StayScape.Review" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <!-- Include flatpickr library -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/flatpickr/dist/flatpickr.min.css">
    <script src="https://cdn.jsdelivr.net/npm/flatpickr"></script>

    <!-- JavaScript code for initializing flatpickr with single date mode -->
    <script>
        document.addEventListener('DOMContentLoaded', function () {
            // Get the ASP.NET controls
            var txtDate = document.getElementById('<%= txtDate.ClientID %>');
            var imgCalendar = document.getElementById('<%= imgCalendar.ClientID %>');

            // Initialize Flatpickr
            flatpickr(txtDate, {
                mode: 'single', // You mentioned only one date is needed
                dateFormat: 'Y-m-d',
                onClose: function (selectedDates, dateStr, instance) {
                    // Hide the calendar when a date is selected
                    instance.close();
                }
            });

            // Add click event listener to the calendar icon
            imgCalendar.addEventListener('click', function () {
                // Open the Flatpickr calendar when the icon is clicked
                txtDate._flatpickr.open();
            });
        });

        function toggleRatingsAnalysis() {
            var ratingsAnalysis = document.getElementById('ratingsAnalysis');
            if (ratingsAnalysis.classList.contains('hidden')) {
                ratingsAnalysis.classList.remove('hidden');
            } else {
                ratingsAnalysis.classList.add('hidden');
            }
        }
    </script>

    <style>
        /* Tooltip text */
        .tooltip .tooltiptext {
          visibility: hidden;
          width: max-content;
          background-color: rgba(0, 0, 0, 0.75);
          color: #fff;
          text-align: center;
          border-radius: 0.25rem;
          padding: 0.5rem;
          position: absolute;
          z-index: 10;
          bottom: 125%;
          left: 50%;
          transform: translateX(-50%);
          opacity: 0;
          transition: opacity 0.3s;
        }

        label{
            cursor: pointer;
            display: inline-block;
            margin-right: 2rem;
            margin-bottom: 1rem;
            margin-left: .25rem;
        }

        /* Style for selected button */
        .rating-button.selected {
            background-color: rgb(71 85 105);
            color: #fff;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="flex flex-col flex-grow">
      <div class="px-3 py-3">
        <div class="py-2 px-2">
            <h3 class="font-manrope font-bold text-2xl text-black mb-2">Property Reviews</h3>
            <asp:Button 
                ID="btnShowAnalysis" 
                runat="server" 
                Text="Show Ratings Analysis" 
                OnClientClick="toggleRatingsAnalysis(); return false;" 
                CssClass="border-b border-indigo-600 text-indigo-600 mb-4 hover:cursor-pointer hover:text-indigo-800"
            />
            <div ID="ratingsAnalysis" class="hidden grid grid-cols-7 xl:grid-cols-7 gap-4 pb-11 border-b border-gray-100 max-xl:max-w-2xl max-xl:mx-auto">
                <div class="box flex flex-col w-full ">
                    <p class="mb-2 text-slate-500">Based on 3 reviews</p>
                    <p class="font-medium text-lg text-black text-center">4.3/5.0</p>
                    <div class="flex items-center my-3 mr-4"">
                        <svg class="w-6 h-6 text-yellow-300 ms-1" aria-hidden="true" xmlns="http://www.w3.org/2000/svg" fill="currentColor" viewBox="0 0 22 20">
                            <path d="M20.924 7.625a1.523 1.523 0 0 0-1.238-1.044l-5.051-.734-2.259-4.577a1.534 1.534 0 0 0-2.752 0L7.365 5.847l-5.051.734A1.535 1.535 0 0 0 1.463 9.2l3.656 3.563-.863 5.031a1.532 1.532 0 0 0 2.226 1.616L11 17.033l4.518 2.375a1.534 1.534 0 0 0 2.226-1.617l-.863-5.03L20.537 9.2a1.523 1.523 0 0 0 .387-1.575Z"/>
                        </svg>
                        <svg class="w-6 h-6 text-yellow-300 ms-1" aria-hidden="true" xmlns="http://www.w3.org/2000/svg" fill="currentColor" viewBox="0 0 22 20">
                            <path d="M20.924 7.625a1.523 1.523 0 0 0-1.238-1.044l-5.051-.734-2.259-4.577a1.534 1.534 0 0 0-2.752 0L7.365 5.847l-5.051.734A1.535 1.535 0 0 0 1.463 9.2l3.656 3.563-.863 5.031a1.532 1.532 0 0 0 2.226 1.616L11 17.033l4.518 2.375a1.534 1.534 0 0 0 2.226-1.617l-.863-5.03L20.537 9.2a1.523 1.523 0 0 0 .387-1.575Z"/>
                        </svg>
                        <svg class="w-6 h-6 text-yellow-300 ms-1" aria-hidden="true" xmlns="http://www.w3.org/2000/svg" fill="currentColor" viewBox="0 0 22 20">
                            <path d="M20.924 7.625a1.523 1.523 0 0 0-1.238-1.044l-5.051-.734-2.259-4.577a1.534 1.534 0 0 0-2.752 0L7.365 5.847l-5.051.734A1.535 1.535 0 0 0 1.463 9.2l3.656 3.563-.863 5.031a1.532 1.532 0 0 0 2.226 1.616L11 17.033l4.518 2.375a1.534 1.534 0 0 0 2.226-1.617l-.863-5.03L20.537 9.2a1.523 1.523 0 0 0 .387-1.575Z"/>
                        </svg>
                        <svg class="w-6 h-6 text-yellow-300 ms-1" aria-hidden="true" xmlns="http://www.w3.org/2000/svg" fill="currentColor" viewBox="0 0 22 20">
                            <path d="M20.924 7.625a1.523 1.523 0 0 0-1.238-1.044l-5.051-.734-2.259-4.577a1.534 1.534 0 0 0-2.752 0L7.365 5.847l-5.051.734A1.535 1.535 0 0 0 1.463 9.2l3.656 3.563-.863 5.031a1.532 1.532 0 0 0 2.226 1.616L11 17.033l4.518 2.375a1.534 1.534 0 0 0 2.226-1.617l-.863-5.03L20.537 9.2a1.523 1.523 0 0 0 .387-1.575Z"/>
                        </svg>
                        <svg class="w-6 h-6 text-gray-300 ms-1" aria-hidden="true" xmlns="http://www.w3.org/2000/svg" fill="currentColor" viewBox="0 0 22 20">
                            <path d="M20.924 7.625a1.523 1.523 0 0 0-1.238-1.044l-5.051-.734-2.259-4.577a1.534 1.534 0 0 0-2.752 0L7.365 5.847l-5.051.734A1.535 1.535 0 0 0 1.463 9.2l3.656 3.563-.863 5.031a1.532 1.532 0 0 0 2.226 1.616L11 17.033l4.518 2.375a1.534 1.534 0 0 0 2.226-1.617l-.863-5.03L20.537 9.2a1.523 1.523 0 0 0 .387-1.575Z"/>
                        </svg>
                    </div>
                    <div class="flex items-center w-full">
                        <p class="font-medium text-lg text-black mr-0.5">5</p>
                            <svg class="w-6 h-6 text-yellow-300 ms-1" aria-hidden="true" xmlns="http://www.w3.org/2000/svg" fill="currentColor" viewBox="0 0 22 20">
                                <path d="M20.924 7.625a1.523 1.523 0 0 0-1.238-1.044l-5.051-.734-2.259-4.577a1.534 1.534 0 0 0-2.752 0L7.365 5.847l-5.051.734A1.535 1.535 0 0 0 1.463 9.2l3.656 3.563-.863 5.031a1.532 1.532 0 0 0 2.226 1.616L11 17.033l4.518 2.375a1.534 1.534 0 0 0 2.226-1.617l-.863-5.03L20.537 9.2a1.523 1.523 0 0 0 .387-1.575Z"/>
                            </svg>
                        <p class="h-2 w-full rounded-3xl bg-indigo-50 ml-5 mr-3">
                            <span class="h-full w-[33%] rounded-3xl bg-indigo-400 flex"></span>
                        </p>
                        <p class="font-medium text-lg  text-black mr-0.5">1</p>
                    </div>
                    <div class="flex items-center w-full">
                        <p class="font-medium text-lg text-black mr-0.5">4</p>
                        <svg class="w-6 h-6 text-yellow-300 ms-1" aria-hidden="true" xmlns="http://www.w3.org/2000/svg" fill="currentColor" viewBox="0 0 22 20">
                            <path d="M20.924 7.625a1.523 1.523 0 0 0-1.238-1.044l-5.051-.734-2.259-4.577a1.534 1.534 0 0 0-2.752 0L7.365 5.847l-5.051.734A1.535 1.535 0 0 0 1.463 9.2l3.656 3.563-.863 5.031a1.532 1.532 0 0 0 2.226 1.616L11 17.033l4.518 2.375a1.534 1.534 0 0 0 2.226-1.617l-.863-5.03L20.537 9.2a1.523 1.523 0 0 0 .387-1.575Z"/>
                        </svg>
                        <p class="h-2 w-full rounded-3xl bg-indigo-50 ml-5 mr-3">
                            <span class="h-full w-[67%] rounded-3xl bg-indigo-400 flex"></span>
                        </p>
                        <p class="font-medium text-lg text-black mr-0.5">2</p>
                    </div>
                    <div class="flex items-center">
                        <p class="font-medium text-lg text-black mr-0.5">3</p>
                        <svg class="w-6 h-6 text-yellow-300 ms-1" aria-hidden="true" xmlns="http://www.w3.org/2000/svg" fill="currentColor" viewBox="0 0 22 20">
                            <path d="M20.924 7.625a1.523 1.523 0 0 0-1.238-1.044l-5.051-.734-2.259-4.577a1.534 1.534 0 0 0-2.752 0L7.365 5.847l-5.051.734A1.535 1.535 0 0 0 1.463 9.2l3.656 3.563-.863 5.031a1.532 1.532 0 0 0 2.226 1.616L11 17.033l4.518 2.375a1.534 1.534 0 0 0 2.226-1.617l-.863-5.03L20.537 9.2a1.523 1.523 0 0 0 .387-1.575Z"/>
                        </svg>
                        <p class="h-2 w-full rounded-3xl bg-indigo-50 ml-5 mr-3">
                            <span class="h-full w-[0%] rounded-3xl bg-indigo-400 flex"></span>
                        </p>
                        <p class="font-medium text-lg text-black mr-0.5">0</p>
                    </div>
                    <div class="flex items-center">
                        <p class="font-medium text-lg text-black mr-0.5">2</p>
                        <svg class="w-6 h-6 text-yellow-300 ms-1" aria-hidden="true" xmlns="http://www.w3.org/2000/svg" fill="currentColor" viewBox="0 0 22 20">
                            <path d="M20.924 7.625a1.523 1.523 0 0 0-1.238-1.044l-5.051-.734-2.259-4.577a1.534 1.534 0 0 0-2.752 0L7.365 5.847l-5.051.734A1.535 1.535 0 0 0 1.463 9.2l3.656 3.563-.863 5.031a1.532 1.532 0 0 0 2.226 1.616L11 17.033l4.518 2.375a1.534 1.534 0 0 0 2.226-1.617l-.863-5.03L20.537 9.2a1.523 1.523 0 0 0 .387-1.575Z"/>
                        </svg>
                        <p class="h-2 w-full rounded-3xl bg-indigo-50 ml-5 mr-3">
                            <span class="h-full w-[0%] rounded-3xl bg-indigo-400 flex"></span>
                        </p>
                        <p class="font-medium text-lg text-black mr-0.5">0</p>
                    </div>
                    <div class="flex items-center">
                        <p class="font-medium text-lg text-black mr-0.5">1</p>
                        <svg class="w-6 h-6 text-yellow-300 ms-1" aria-hidden="true" xmlns="http://www.w3.org/2000/svg" fill="currentColor" viewBox="0 0 22 20">
                            <path d="M20.924 7.625a1.523 1.523 0 0 0-1.238-1.044l-5.051-.734-2.259-4.577a1.534 1.534 0 0 0-2.752 0L7.365 5.847l-5.051.734A1.535 1.535 0 0 0 1.463 9.2l3.656 3.563-.863 5.031a1.532 1.532 0 0 0 2.226 1.616L11 17.033l4.518 2.375a1.534 1.534 0 0 0 2.226-1.617l-.863-5.03L20.537 9.2a1.523 1.523 0 0 0 .387-1.575Z"/>
                        </svg>
                        <p class="h-2 w-full rounded-3xl bg-indigo-50 ml-5 mr-3">
                            <span class="h-full w-[0%] rounded-3xl bg-indigo-400 flex"></span>
                        </p>
                        <p class="font-medium text-lg py-[1px] text-black mr-0.5">0</p>
                    </div>
        
                </div>
                <div class="flex flex-col items-center justify-center border-l border-gray">
                    <p class="font-medium text-xl leading-8 text-gray-900 text-center">Cleanliness</p>
                    <p class="py-4 font-medium text-lg text-black">4.9</p>
                    <img src="Images/water.svg" alt="Cleanliness" class="w-10 h-10"/>
                </div>
                <div class="flex flex-col items-center justify-center border-l border-gray">
                    <p class="font-medium text-xl leading-8 text-gray-900 text-center">Service</p>
                    <p class="py-4 font-medium text-lg text-black">4.9</p>
                    <img src="Images/nut.svg" alt="Service" class="w-10 h-10"/>
                </div>
                <div class="flex flex-col items-center justify-center border-l border-gray">
                    <p class="font-medium text-xl leading-8 text-gray-900 text-center">Comfort</p>
                    <p class="py-4 font-medium text-lg text-black">4.9</p>
                    <img src="Images/sun.svg" alt="Comfort" class="w-10 h-10"/>
                </div>
                <div class="flex flex-col items-center justify-center border-l border-gray">
                    <p class="font-medium text-xl leading-8 text-gray-900 text-center">Condition</p>
                    <p class="py-4 font-medium text-lg text-black">4.9</p>
                    <img src="Images/lamp.svg" alt="Condition" class="w-10 h-10"/>
                </div>
                <div class="flex flex-col items-center justify-center border-l border-gray">
                    <p class="font-medium text-xl leading-8 text-gray-900 text-center">Amenities</p>
                    <p class="py-4 font-medium text-lg text-black">4.9</p>
                    <img src="Images/tv.svg" alt="Amenities" class="w-10 h-10"/>
                </div>
                <div class="flex flex-col items-center justify-center border-l border-gray">
                    <p class="font-medium text-xl leading-8 text-gray-900 text-center">Location</p>
                    <p class="py-4 font-medium text-lg text-black">4.9</p>
                    <img src="Images/location.svg" alt="Location" class="w-10 h-10"/>
                </div>
            </div>
            <div class="pb-4 grid grid-rows-3 gap-4">
                <div>
                    <asp:Label 
                        ID="propertyNameLabel" 
                        runat="server" 
                        Text="Property Name: ">
                    </asp:Label>
                    <asp:TextBox 
                        ID="propertyNameTextBox" 
                        runat="server"
                        CssClass="py-2 px-2 border border-gray-300 text-md rounded-lg w-full mt-2">
                    </asp:TextBox>
                </div>
                <div>
                    <asp:Label 
                        ID="custNameLabel" 
                        runat="server" 
                        Text="Customer Name: ">
                    </asp:Label>
                    <asp:TextBox 
                        ID="custNameTextBox" 
                        runat="server"
                        CssClass="py-2 px-2 border border-gray-300 text-md rounded-lg w-full mt-2">
                    </asp:TextBox>
                </div>
                
                <div class="flex items-center">
                    <asp:Image 
                        ID="imgCalendar" 
                        runat="server" 
                        ImageUrl="Images/calendar.svg" 
                        CssClass="w-10 h-10 hover:cursor-pointer" 
                    />
                    <asp:TextBox 
                        ID="txtDate" 
                        runat="server" 
                        CssClass="form-input border border-gray-300 rounded-md py-2 px-4 placeholder-gray-400 ml-3" 
                        placeholder="Date">
                    </asp:TextBox>
                    <asp:Button 
                        ID="btnSearch" 
                        runat="server" 
                        CssClass="py-2 px-2 border border-transparent shadow-sm text-sm font-medium rounded-md text-white bg-indigo-600 hover:bg-indigo-700 ml-auto hover:cursor-pointer"
                        Text="Search" 
                        OnClick="btnSearch_Click"
                    />
                </div>
            </div>
            <div>
                <asp:RadioButtonList ID="FilterRadioButtonList" runat="server" CssClass="filter-radio-list" AutoPostBack="True" RepeatDirection="Horizontal" OnSelectedIndexChanged="RadioButtonList_SelectedIndexChanged">
                    <asp:ListItem Text="All" 
                        Value="all" 
                        Selected="True" 
                    />
                    <asp:ListItem 
                        Text="To Reply" 
                        Value="to-reply" 
                    />
                    <asp:ListItem 
                        Text="Replied" 
                        Value="replied" 
                    />
                </asp:RadioButtonList>
            </div>
            <div class="flex pb-4">
                <asp:Button 
                    ID="btnAll" 
                    runat="server" 
                    CssClass="rating-button py-2 px-4 mr-4 border border-slate-300 rounded-lg bg-slate-300 text-slate-500 cursor-pointer" 
                    Text="All" OnClick="RatingButton_Click" 
                />
                <asp:Button 
                    ID="btn5Star" 
                    runat="server" 
                    CssClass="rating-button py-2 px-4 mr-4 border border-slate-300 rounded-lg bg-slate-300 text-slate-500 cursor-pointer" 
                    Text="5 Star" 
                    OnClick="RatingButton_Click" 
                />
                <asp:Button 
                    ID="btn4Star" 
                    runat="server" 
                    CssClass="rating-button py-2 px-4 mr-4 border border-slate-300 rounded-lg bg-slate-300 text-slate-500 cursor-pointer" 
                    Text="4 Star" 
                    OnClick="RatingButton_Click" 
                />
                <asp:Button 
                    ID="btn3Star" 
                    runat="server" 
                    CssClass="rating-button py-2 px-4 mr-4 border border-slate-300 rounded-lg bg-slate-300 text-slate-500 cursor-pointer" 
                    Text="3 Star" 
                    OnClick="RatingButton_Click" 
                />
                <asp:Button 
                    ID="btn2Star" 
                    runat="server" 
                    CssClass="rating-button py-2 px-4 mr-4 border border-slate-300 rounded-lg bg-slate-300 text-slate-500 cursor-pointer" 
                    Text="2 Star" 
                    OnClick="RatingButton_Click" 
                />
                <asp:Button 
                    ID="btn1Star" 
                    runat="server" 
                    CssClass="rating-button py-2 px-4 mr-4 border border-slate-300 rounded-lg bg-slate-300 text-slate-500 cursor-pointer" 
                    Text="1 Star" 
                    OnClick="RatingButton_Click" 
                />
            </div>
            <asp:ListView ID="ListView1" runat="server" DataKeyNames="reviewID" DataSourceID="SqlDataSource1" OnItemCommand="ListView1_ItemCommand">
                <LayoutTemplate>
                    <table class="w-full divide-y divide-gray-200">
                        <thead>
                            <tr>
                                <th class="px-6 py-3 bg-gray-50 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Property Information</th>
                                <th class="px-6 py-3 bg-gray-50 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Customer Review</th>
                                <th class="px-6 py-3 bg-gray-50 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Action</th>
                            </tr>
                            
                        </thead>
                        <tbody id="itemPlaceholder" runat="server" class="divide-y divide-gray-200">
                        </tbody>
                    </table>
                </LayoutTemplate>

                <ItemTemplate>
                    <tbody class="divide-y divide-gray-200">
                        <tr class="bg-white divide-x divide-gray-200">
                            <td class="px-4 py-4">
                                <div class="flex flex-col">
                                    <asp:Label ID="propertyName" runat="server" CssClass="font-semibold text-lg leading-8 text-indigo-600" Text='<%# Eval("propertyName") %>' />
                                    <asp:Label ID="propertyAddress" runat="server" CssClass="text-slate-500" Text='<%# Eval("propertyAddress") %>' />
                                </div>
                            </td>
                            <td class="px-4 py-4">
                                <div class="flex flex-col">
                                    <asp:Label ID="customerName" runat="server" CssClass="font-semibold text-lg leading-8 underline underline-offset-4" Text='<%# Eval("customerName") %>' />
                                    <div class="flex items-center my-3 mr-4 space-x-1"> <!-- Flex layout with horizontal alignment and spacing -->
                                        <!-- Display star ratings -->
                                        <%# StarRatingHelper.GetStarRating((decimal)Eval("rating")) %>
                                        <asp:Label ID="createdAt" runat="server" CssClass="text-slate-500 ml-3" Text='<%# Eval("createdAt") %>' />
                                    </div>
                                    <div class="flex flex-col">
                                        <asp:Label ID="reviewDesc" runat="server" Text='<%# Eval("reviewDesc") %>' />
                                    </div>
                                    <div class="flex flex-col">
                                      <asp:TextBox 
                                          ID="replyTextBox" 
                                          runat="server" 
                                          CssClass="py-2 px-2 border border-gray-300 text-md rounded-lg w-full mt-2" 
                                          Visible="false" 
                                          Text='<%# Eval("replyText") %>' 
                                          TextMode="MultiLine">
                                      </asp:TextBox>
                                      <div class="flex justify-end">
                                          <asp:Button 
                                              ID="btnSubmitReply" 
                                              runat="server" 
                                              Text='<%# (Eval("replyID") != DBNull.Value) ? "Save" : "Submit" %>' 
                                              CssClass="mt-3 ml-3 inline-flex justify-center py-2 px-4 border border-transparent shadow-sm text-sm font-medium rounded-md text-white bg-indigo-600 hover:bg-indigo-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-indigo-500 hover:cursor-pointer" 
                                              Visible="false" 
                                              CommandName="SubmitReply" 
                                              CommandArgument='<%# Eval("reviewID") %>' 
                                            />
                                          <asp:Button 
                                              ID="btnCancel" 
                                              runat="server" 
                                              Text="Cancel" 
                                              CssClass="mt-3 ml-3 bg-white py-2 px-4 border border-gray-300 rounded-md shadow-sm text-sm font-medium text-gray-700 hover:bg-gray-50 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-indigo-500 hover:cursor-pointer" 
                                              Visible="false" 
                                              CommandName="CancelReply"
                                          />
                                      </div>
                                    </div>
                                </div>
                            </td>
                            <td class="px-4 py-4">
                                <asp:Button 
                                    ID="btnReply" 
                                    runat="server" 
                                    Text="Reply" 
                                    CssClass="inline-flex justify-center py-2 px-4 border border-transparent shadow-sm text-sm font-medium rounded-md text-white bg-gray-600 hover:bg-gray-800 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-gray-500 hover:cursor-pointer"
                                    CommandName="ShowReply" 
                                    Visible='<%# (Eval("replyID") == DBNull.Value) %>' 
                                />

                                <!-- If there's a reply, show the "Edit" button -->
                                <asp:Button 
                                    ID="btnEditReply" 
                                    runat="server" 
                                    Text="Edit" 
                                    CssClass="inline-flex justify-center py-2 px-4 border border-transparent shadow-sm text-sm font-medium rounded-md text-white bg-gray-600 hover:bg-gray-800 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-gray-500 hover:cursor-pointer"
                                    CommandName="ShowReply" 
                                    Visible='<%# (Eval("replyID") != DBNull.Value) %>' 
                                />
                            
                            </td>
                        </tr>
                    </tbody>
                </ItemTemplate>
            </asp:ListView>

            <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:LocalSqlServer %>">
            </asp:SqlDataSource>

            <asp:Panel ID="replyModal" runat="server" CssClass="hidden fixed z-10 inset-0 overflow-y-auto">
                <div class="flex items-end justify-center min-h-screen pt-4 px-4 pb-20 text-center sm:block sm:p-0">
                    <div class="fixed inset-0 bg-gray-500 bg-opacity-75 transition-opacity" aria-hidden="true"></div>
                    <span class="hidden sm:inline-block sm:align-middle sm:h-screen" aria-hidden="true">&#8203;</span>
                    <div class="inline-block align-bottom bg-white rounded-lg text-left overflow-hidden shadow-xl transform transition-all sm:my-8 sm:align-middle sm:max-w-lg sm:w-full" role="dialog" aria-modal="true" aria-labelledby="modal-headline">
                        <div class="bg-white px-4 pt-5 pb-4 sm:p-6 sm:pb-4">
                            <div class="flex items-center justify-center h-full py-4">
                                <div class="mx-auto flex-shrink-0 flex items-center justify-center h-20 w-20 rounded-full bg-green-100 sm:mx-0 sm:h-10 sm:w-10">
                                    <svg class="h-16 w-16 text-green-600" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke="currentColor" aria-hidden="true">
                                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M5 13l4 4L19 7"></path>
                                    </svg>
                                </div>
                            </div>
                            <div class="flex items-center justify-center h-full py-2">
                                <div class="sm:flex sm:items-start">                        
                                    <div class="mt-3 text-center sm:mt-0 sm:ml-4 sm:text-left">
                                        <h3 class="text-lg leading-6 font-medium text-gray-900 text-center" id="modal-title">
                                            You have replied this review.
                                        </h3>
                                        <div class="mt-2">
                                            <p class="text-sm text-gray-500 text-center">
                                                Your reply has been submitted successfully.
                                            </p>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="bg-gray-50 px-4 py-3 sm:px-6 flex justify-center">
                            <asp:Button 
                                ID="modalCloseButton" 
                                runat="server" 
                                Text="OK" 
                                CssClass="w-full inline-flex justify-center rounded-md border border-transparent shadow-sm px-4 py-2 bg-blue-500 text-base font-medium text-white hover:bg-blue-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-blue-500 sm:ml-3 sm:w-auto sm:text-sm" 
                                OnClick="ModalCloseButton_Click" 
                            />
                        </div>
                    </div>
                </div>
            </asp:Panel>
         </div>
      </div>
    </div>
</asp:Content>
