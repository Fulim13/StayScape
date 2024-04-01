<%@ Page Title="" Language="C#" MasterPageFile="~/Customer.Master" AutoEventWireup="true" CodeBehind="OrderHistory.aspx.cs" Inherits="StayScape.OrderHistory" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
 
    <div class="max-w-4xl mx-auto py-8 sm:px-6 sm:py-8">
        <div class="px-4 sm:px-0">
            <h1 class="text-2xl font-extrabold tracking-tight text-gray-900 sm:text-3xl">Reservation history</h1>
            <p class="mt-2 text-sm text-gray-500">View your reservation history, track cancellations, and submit reviews for past stays.</p>
        </div>

        <div class="mt-16">
            <h2 class="sr-only">Recent reservations</h2>

            <div class="space-y-16 sm:space-y-24">
                <div>
                    <h3 class="sr-only">Reservation made on <time datetime="2024-04-02">April 2, 2024</time></h3>

                    <div class="bg-gray-50 px-4 py-6 sm:rounded-lg sm:p-6 md:flex md:items-center md:justify-between md:space-x-6 lg:space-x-8">
                        <dl class="divide-y divide-gray-200 space-y-4 text-sm text-gray-600 flex-auto md:divide-y-0 md:space-y-0 md:grid md:grid-cols-3 md:gap-x-6 lg:w-1/2 lg:gap-x-8">
                            <div class="flex justify-between md:block">
                                <dt class="font-medium text-gray-900">Reservation number</dt>
                                <dd class="md:mt-1">2bc78068-4b09-4ee3-86b0-93111be7b7e4</dd>
                            </div>
                            <div class="flex justify-between pt-4 md:block md:pt-0">
                                <dt class="font-medium text-gray-900">Date placed</dt>
                                <dd class="md:mt-1">
                                    <time datetime="2024-04-02">April 2, 2024</time>
                                </dd>
                            </div>
                            <div class="flex justify-between pt-4 font-medium text-gray-900 md:block md:pt-0">
                                <dt>Total amount</dt>
                                <dd class="md:mt-1">RM101.10</dd>
                            </div>
                        </dl>
                    </div>

                    <div class="mt-6 flow-root px-4 sm:mt-10 sm:px-0">
                        <div class="-my-6 divide-y divide-gray-200 sm:-my-10">
                            <div class="flex py-6 sm:py-10">
                                <div class="min-w-0 flex-1 lg:flex lg:flex-col">
                                    <div class="lg:flex-1">
                                        <div class="sm:flex">
                                            <div>
                                                <h4 class="font-medium text-gray-900">Fu Lim's Building</h4>
                                                <p class="hidden mt-2 text-sm text-gray-500 sm:block">29-35, Jalan 10/23a, Medan Makmur, 53300 Kuala Lumpur, Wilayah Persekutuan Kuala Lumpur.</p>
                                            </div>
                                            <p class="mt-1 font-medium text-gray-900 sm:mt-0 sm:ml-6">RM101.10</p>
                                        </div>
                                        <div class="mt-2 flex text-sm font-medium sm:mt-4">
                                            <a href="ReviewForm.aspx" class="text-indigo-600 hover:text-indigo-500">Add Review</a>
                                            <div class="border-l border-gray-200 ml-4 pl-4 sm:ml-6 sm:pl-6">
                                                <a href="CancelReservation.aspx" class="text-indigo-600 hover:text-indigo-500">Cancel Reservation</a>
                                            </div>
                                        </div>
                                    </div>
<%--                                    <div class="mt-6 font-medium">
                                        <p>Out for delivery</p>
                                    </div>--%>
                                </div>
                                <div class="ml-4 flex-shrink-0 sm:m-0 sm:mr-6 sm:order-first">
                                    <img src="PropertyImg/1.jpg" alt="Olive drab green insulated bottle with flared screw lid and flat top." class="col-start-2 col-end-3 sm:col-start-1 sm:row-start-1 sm:row-span-2 w-20 h-20 rounded-lg object-center object-cover sm:w-40 sm:h-40 lg:w-52 lg:h-52">
                                </div>
                            </div>

                            <!-- More products... -->
                        </div>
                    </div>
                </div>

                <!-- More orders... -->
            </div>
        </div>
    </div>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder2" runat="server">
</asp:Content>
