<%@ Page Title="" Language="C#" MasterPageFile="~/Customer.Master" AutoEventWireup="true" CodeBehind="property_details.aspx.cs" Inherits="StayScape.PPT.property_details" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="bg-white">
        <div class="pt-6">

            <% if (Property != null)
                { %>
            <!-- Image gallery -->
            <div class="mx-auto mt-6 max-w-2xl sm:px-6 lg:grid lg:max-w-7xl lg:grid-cols-3 lg:gap-x-8 lg:px-8">
                <div class="aspect-h-4 aspect-w-3 hidden overflow-hidden rounded-lg lg:block">
                    <img src="PropertyImg/1.jpg" alt="Property Image" class="h-full w-full object-cover object-center property-image">
                </div>
                <div class="hidden lg:grid lg:grid-cols-1 lg:gap-y-8">
                    <div class="aspect-h-2 aspect-w-3 overflow-hidden rounded-lg">
                        <img src="PropertyImg/2.jpg" alt="Property Image" class="h-full w-full object-cover object-center property-image">
                    </div>
                    <div class="aspect-h-2 aspect-w-3 overflow-hidden rounded-lg">
                        <img src="PropertyImg/3.jpg" alt="Property Image" class="h-full w-full object-cover object-center property-image">
                    </div>
                </div>
                <div class="aspect-h-5 aspect-w-4 lg:aspect-h-4 lg:aspect-w-3 sm:overflow-hidden sm:rounded-lg">
                    <img src="PropertyImg/4.jpg" alt="Property Image" class="h-full w-full object-cover object-center property-image">
                </div>
            </div>

            <!-- Product info -->
            <div class="mx-auto max-w-2xl px-4 pb-4 pt-10 sm:px-6 lg:grid lg:max-w-7xl lg:grid-cols-3 lg:grid-rows-[auto,auto,1fr] lg:gap-x-8 lg:px-8 lg:pb-4 lg:pt-16">
                <div class="lg:col-span-2 lg:border-r lg:border-gray-200 lg:pr-8">
                    <h2 class="text-2xl font-bold tracking-tight text-gray-900 sm:text-3xl property-name"><%= Property.PropertyName %></h2>
                </div>

                <!-- Options -->
                <div class="mt-4 lg:row-span-3 lg:mt-0 lg:text-right">
                    <h2 class="sr-only">Product information</h2>
                    <p class="text-3xl tracking-tight text-gray-900">RM <%= Property.PropertyPrice %></p>
                </div>


                <div class="py-10 lg:col-span-2 lg:col-start-1 lg:border-r lg:border-gray-200 lg:pb-16 lg:pr-8 lg:pt-6">
                    <!-- Description and details -->
                    <div>
                        <h3 class="sr-only">Description</h3>

                        <div class="space-y-6">
                            <strong>Description:</strong> <%= Property.PropertyDesc %><br />
                            <strong>Address:</strong> <%= Property.PropertyAddress %><br>
                            <strong>Total Bedrooms:</strong> <%= Property.TotalBedroom %><br>
                            <strong>Total Bathrooms:</strong> <%= Property.TotalBathroom %><br>
                            <strong>Created At:</strong> <%= Property.CreatedAt.ToString("yyyy-MM-dd HH:mm:ss") %><br>
                            <strong>Last Update:</strong> <%= Property.LastUpdate.ToString("yyyy-MM-dd HH:mm:ss") %><br>
                        </div>
                    </div>

                    <div class="mt-10">
                        <h3 class="text-sm font-medium text-gray-900">Highlights</h3>

                        <div class="mt-4">
                            <ul role="list" class="list-disc space-y-2 pl-4 text-sm">
                                <li class="text-gray-400"><span class="text-gray-600">Hand cut and sewn locally</span></li>
                                <li class="text-gray-400"><span class="text-gray-600">Dyed with our proprietary colors</span></li>
                                <li class="text-gray-400"><span class="text-gray-600">Pre-washed &amp; pre-shrunk</span></li>
                                <li class="text-gray-400"><span class="text-gray-600">Ultra-soft 100% cotton</span></li>
                            </ul>
                        </div>
                    </div>

                    <div class="mt-10">
                        <h2 class="text-sm font-medium text-gray-900">Details</h2>

                        <div class="mt-4 space-y-6">
                            <p class="text-sm text-gray-600">The 6-Pack includes two black, two white, and two heather gray Basic Tees. Sign up for our subscription service and be the first to get new, exciting colors, like our upcoming &quot;Charcoal Gray&quot; limited release.</p>
                        </div>
                    </div>
                </div>
            </div>

            <div class="button-container flex justify-center space-x-4">
                <asp:Button CssClass="mt-5 flex items-center justify-center rounded-md border border-transparent bg-indigo-600 px-8 py-3 text-base font-medium text-white hover:bg-indigo-700 focus:outline-none focus:ring-2 focus:ring-indigo-500 focus:ring-offset-2 button" ID="btnPlace" runat="server" Text="Reserve" OnClick="btnPlace_Click" />
                <button class="mt-5 flex items-center justify-center rounded-md border border-transparent bg-indigo-600 px-8 py-3 text-base font-medium text-white hover:bg-indigo-700 focus:outline-none focus:ring-2 focus:ring-indigo-500 focus:ring-offset-2 button secondary" onclick="goBack()">Back</button>
            </div>

            <% }
                else
                { %>
            <p>No property details available.</p>
            <% } %>
        </div>
    </div>
    <section class="py-24 relative">
    <div class="w-full max-w-7xl px-4 md:px-5 lg-6 mx-auto">
        <div class="w-full">
            <h3 class="font-manrope font-bold text-2xl text-black mb-8 text-center">Our customer reviews
            </h3>
            <div class="grid grid-cols-7 xl:grid-cols-7 gap-4 pb-11 border-b border-gray-100 max-xl:max-w-2xl max-xl:mx-auto">
                <div class="box flex flex-col w-full ">
                    <asp:Label ID="lblTotalReviews" runat="server" Text="Based on 0 review" class="mb-2 text-slate-500 mx-auto" />
                    <%--<p class="mb-2 text-slate-500">Based on 3 reviews</p>--%>
                    <asp:Label ID="lblAverageRating" runat="server" Text="" class="font-medium text-lg text-black mx-auto" />
                    <%--<p class="font-medium text-lg text-black text-center">4.3/5.0</p>--%>
                    <div class="flex items-center my-3 mr-4 mx-auto">
                        <asp:Literal ID="lblStars" runat="server" Text="-"></asp:Literal>
                    </div>
                    <%--TODO:Count the rating of each star--%>
<%--                    <div class="flex items-center w-full">
                        <p class="font-medium text-lg text-black mr-0.5">5</p>
                        <svg class="w-6 h-6 text-yellow-300 ms-1" aria-hidden="true" xmlns="http://www.w3.org/2000/svg" fill="currentColor" viewBox="0 0 22 20">
                            <path d="M20.924 7.625a1.523 1.523 0 0 0-1.238-1.044l-5.051-.734-2.259-4.577a1.534 1.534 0 0 0-2.752 0L7.365 5.847l-5.051.734A1.535 1.535 0 0 0 1.463 9.2l3.656 3.563-.863 5.031a1.532 1.532 0 0 0 2.226 1.616L11 17.033l4.518 2.375a1.534 1.534 0 0 0 2.226-1.617l-.863-5.03L20.537 9.2a1.523 1.523 0 0 0 .387-1.575Z"/>
                        </svg>
                        <p class="h-2 w-full rounded-3xl bg-indigo-50 ml-5 mr-3">
                        <asp:Literal ID="lbl5StarRating" runat="server" Text="Loading..."/>
                        </p>
                        <p class="font-medium text-lg text-black mr-0.5">0</p>
                    </div>
                    <div class="flex items-center w-full">
                        <p class="font-medium text-lg text-black mr-0.5">4</p>
                        <svg class="w-6 h-6 text-yellow-300 ms-1" aria-hidden="true" xmlns="http://www.w3.org/2000/svg" fill="currentColor" viewBox="0 0 22 20">
                            <path d="M20.924 7.625a1.523 1.523 0 0 0-1.238-1.044l-5.051-.734-2.259-4.577a1.534 1.534 0 0 0-2.752 0L7.365 5.847l-5.051.a1.535 1.535 0 0 0 1.463 9.2L11 17.033 2.375a1.523 1.523 0 0 0 .387-1.575Z"/>
                        </svg>
                        <p class="h-2 w-full rounded-3xl bg-indigo-50 ml-5 mr-3">
                            <asp:Literal ID="lbl4StarRating" runat="server" Text="Loading..."/>
                        </p>
                        <p class="font-medium text-lg text-black mr-0.5">0</p>
                    </div>
                    <div class="flex items-center w-full">
                        <p class="font-medium text-lg text-black mr-0.5">3</p>
                        <svg class="w-6 h-6 text-yellow-300 ms-1" aria-hidden="true" xmlns="http://www.w3.org/2000/svg" fill="currentColor" viewBox="0 0 22 20">
                            <path d="M20.924 7.625a1.523 1.523 0 0 0-1.238-1.044l-5.051-.734-2.259-4.577a1.534 1.534 0 0 0-2.752 0L7.365 5.847l-5.051.a1.535 1.535 0 0 0 1.463 9.2L11 17.033 2.375a1.523 1.523 0 0 0 .387-1.575Z"/>
                        </svg>
                        <p class="h-2 w-full rounded-3xl bg-indigo-50 ml-5 mr-3">
                            <asp:Literal ID="lbl3StarRating" runat="server" Text="Loading..."/>
                        </p>
                        <p class="font-medium text-lg text-black mr-0.5">0</p>
                    </div>
                    <div class="flex items-center w-full">
                        <p class="font-medium text-lg text-black mr-0.5">2</p>
                        <svg class="w-6 h-6 text-yellow-300 ms-1" aria-hidden="true" xmlns="http://www.w3.org/2000/svg" fill="currentColor" viewBox="0 0 22 20">
                            <path d="M20.924 7.625a1.523 1.523 0 0 0-1.238-1.044l-5.051-.734-2.259-4.577a1.534 1.534 0 0 0-2.752 0L7.365 5.847l-5.051.a1.535 1.535 0 0 0 1.463 9.2L11 17.033 2.375a1.523 1.523 0 0 0 .387-1.575Z"/>
                        </svg>
                        <p class="h-2 w-full rounded-3xl bg-indigo-50 ml-5 mr-3">
                            <asp:Literal ID="lbl2StarRating" runat="server" Text="Loading..."/>
                        </p>
                        <p class="font-medium text-lg text-black mr-0.5">0</p>
                    </div>
                    <div class="flex items-center w-full">
                        <p class="font-medium text-lg text-black mr-0.5">1</p>
                        <svg class="w-6 h-6 text-yellow-300 ms-1" aria-hidden="true" xmlns="http://www.w3.org/2000/svg" fill="currentColor" viewBox="0 0 22 20">
                            <path d="M20.924 7.625a1.523 1.523 0 0 0-1.238-1.044l-5.051-.734-2.259-4.577a1.534 1.534 0 0 0-2.752 0L7.365 5.847l-5.051.a1.535 1.535 0 0 0 1.463 9.2L11 17.033 2.375a1.523 1.523 0 0 0 .387-1.575Z"/>
                        </svg>
                        <p class="h-2 w-full rounded-3xl bg-indigo-50 ml-5 mr-3">
                            <asp:Literal ID="lbl1StarRating" runat="server" Text="Loading..."/>
                        </p>
                        <p class="font-medium text-lg text-black mr-0.5">0</p>
                    </div>--%>               
                </div>
                <div class="flex flex-col items-center justify-center border-l border-gray">
                    <p class="font-medium text-xl leading-8 text-gray-900 text-center">Cleanliness</p>
                    <asp:Label ID="lblCleanliness" runat="server" Text="-" class="py-4 font-medium text-lg text-black" />
                    <asp:Image ID="imgCleanliness" runat="server" ImageUrl="~/Images/water.svg" CssClass="w-10 h-10"/>
                    <%--<p class="py-4 font-medium text-lg text-black">4.9</p>
                    <img src="Images/water.svg" alt="Cleanliness" class="w-10 h-10"/>--%>
                </div>
                <div class="flex flex-col items-center justify-center border-l border-gray">
                    <p class="font-medium text-xl leading-8 text-gray-900 text-center">Service</p>
                    <asp:Label ID="lblService" runat="server" Text="-" class="py-4 font-medium text-lg text-black" />
                    <asp:Image ID="imgService" runat="server" ImageUrl="~/Images/nut.svg" CssClass="w-10 h-10"/>
                    <%--<p class="py-4 font-medium text-lg text-black">4.9</p>
                    <img src="Images/nut.svg" alt="Service" class="w-10 h-10"/>--%>
                </div>
                <div class="flex flex-col items-center justify-center border-l border-gray">
                    <p class="font-medium text-xl leading-8 text-gray-900 text-center">Comfort</p>
                    <asp:Label ID="lblComfort" runat="server" Text="-" class="py-4 font-medium text-lg text-black" />
                    <asp:Image ID="imgComfort" runat="server" ImageUrl="~/Images/sun.svg" CssClass="w-10 h-10"/>
                    <%--<p class="py-4 font-medium text-lg text-black">4.9</p>
                    <img src="Images/sun.svg" alt="Comfort" class="w-10 h-10"/>--%>
                </div>
                <div class="flex flex-col items-center justify-center border-l border-gray">
                    <p class="font-medium text-xl leading-8 text-gray-900 text-center">Condition</p>
                    <asp:Label ID="lblCondition" runat="server" Text="-" class="py-4 font-medium text-lg text-black" />
                    <asp:Image ID="imgCondition" runat="server" ImageUrl="~/Images/lamp.svg" CssClass="w-10 h-10"/>
                    <%--<p class="py-4 font-medium text-lg text-black">4.9</p>
                    <img src="Images/lamp.svg" alt="Condition" class="w-10 h-10"/>--%>
                </div>
                <div class="flex flex-col items-center justify-center border-l border-gray">
                    <p class="font-medium text-xl leading-8 text-gray-900 text-center">Amenities</p>
                    <asp:Label ID="lblAmenities" runat="server" Text="-" class="py-4 font-medium text-lg text-black" />
                    <asp:Image ID="imgAmenities" runat="server" ImageUrl="~/Images/tv.svg" CssClass="w-10 h-10"/>
                    <%--<p class="py-4 font-medium text-lg text-black">4.9</p>
                    <img src="Images/tv.svg" alt="Amenities" class="w-10 h-10"/>--%>
                </div>
                <div class="flex flex-col items-center justify-center border-l border-gray">
                    <p class="font-medium text-xl leading-8 text-gray-900 text-center">Location</p>
                    <asp:Label ID="lblLocation" runat="server" Text="-" class="py-4 font-medium text-lg text-black" />
                    <asp:Image ID="imgLocation" runat="server" ImageUrl="~/Images/location.svg" CssClass="w-10 h-10"/>
                    <%--<p class="py-4 font-medium text-lg text-black">4.9</p>
                    <img src="Images/location.svg" alt="Location" class="w-10 h-10"/>--%>
                </div>
            </div>
            <div class="mt-4 grid grid-cols-2 gap-4">
                <asp:ListView ID="ListViewReview" runat="server" OnItemDataBound="ListViewReview_ItemDataBound">

                    <ItemTemplate>
                        <div class="p-4 shadow-md rounded-lg border-gray-400">
                            <div class="flex py-2">
                                <div class="flex items-center py-2 mr-4">
                                    <asp:Image 
                                        ID="imgCustomer" 
                                        runat="server" 
                                        CssClass="h-8 w-8 rounded-full" 
                                        AlternateText="Reviewer Image" 
                                    />
                                <%--<img class="h-8 w-8 rounded-full" src="https://images.unsplash.com/photo-1550525811-e5869dd03032?ixlib=rb-1.2.1&auto=format&fit=facearea&facepad=2&w=256&h=256&q=80" alt=""/>--%>
                                </div>
                                <div class="flex items-center">
                                    <asp:Label ID="customerName" runat="server" CssClass="font-semibold text-lg leading-8 text-indigo-600" Text='<%# Eval("customerName") %>' />
                                    <%--<p class="font-semibold text-lg leading-8 text-indigo-600 ">Amira</p>--%>
                                </div>
                            </div>
                            <div class="flex">
                                <div class="flex items-center my-3 mr-4"">
                                    <!-- Display star ratings -->
                                <%# StarRatingHelper.GetStarRating((decimal)Eval("rating")) %>
                                    <%--<svg class="w-6 h-6 text-yellow-300 ms-1" aria-hidden="true" xmlns="http://www.w3.org/2000/svg" fill="currentColor" viewBox="0 0 22 20">
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
                                    </svg>--%>
                                </div>
                                <div class="flex items-center gap-2 my-3 mr-4">
                                    <asp:Label ID="createdAt" runat="server" CssClass="text-slate-500" Text='<%# Eval("ReviewDate") %>' />
                                    <%--<p class="text-slate-500">Nov 01, 2023</p>--%>
                                </div>
                            </div>
                            <div class="py-2">
                                <asp:Label ID="reviewDesc" runat="server" Text='<%# Eval("reviewDesc") %>' />
                                <%--<p>Very cozy place and enjoy green landscape. Host is very kind and helpful.</p>--%>
                            </div>
                        </div>
                    </ItemTemplate>

                    <EmptyDataTemplate>
                        <div class="text-gray-500 py-6">
                            No review found.
                        </div>
                    </EmptyDataTemplate>
                </asp:ListView>
                <asp:SqlDataSource ID="SqlDataSourceReview" runat="server" ConnectionString="<%$ ConnectionStrings:LocalSqlServer %>">
                </asp:SqlDataSource>
            </div>
    </div>
</section>
   <script>
       function goBack() {
           window.location.href = 'property_list.aspx'; 
       }
   </script>
</asp:Content>