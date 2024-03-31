<%@ Page Title="" Language="C#" MasterPageFile="~/Main.Master" AutoEventWireup="true" CodeBehind="HostReservationDetails.aspx.cs" Inherits="StayScape.HostReservationDetails" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="bg-white">
        <div class="max-w-3xl mx-auto px-4">
            <div class="max-w-xl">
                <h1 class="mb-4 text-xl font-semibold uppercase tracking-wide text-indigo-600">Payment Details</h1>
                <asp:Label ID="lblOrderNum" class="text-base text-gray-500" runat="server" Text="Order Number: "></asp:Label>
            </div>

            <div class="mt-2 border-t border-gray-200">
                <div class="py-4 border-b border-gray-200 flex space-x-6">
                    <%--<img src="Images/testing.jpg" class="flex-none w-20 h-20 object-center object-cover bg-gray-100 rounded-lg sm:w-40 sm:h-40">--%>
                    <asp:Image ID="imgProperty" width="200" class="rounded-lg" runat="server" />
                    <div class="flex-auto flex flex-col">
                        <div>
                            <h4 class="font-medium text-gray-900">
                                <asp:Label ID="lblProperty" runat="server" Text="Fu Lim's Building"></asp:Label>
                            </h4>
                            <asp:Label ID="lblDate" class="mt-2 text-sm text-gray-600" runat="server" Text="From 12/12/2024 to 14/12/2024"></asp:Label>
                        </div>
                        <div class="mt-6 flex-1 flex items-end">
                            <dl class="flex text-sm divide-x divide-gray-200 space-x-4 sm:space-x-6">
                                <div class="flex">
                                    <dt class="font-medium text-gray-900">Quantity</dt>
                                    <dd class="ml-2 text-gray-700">1</dd>
                                </div>
                                <div class="pl-4 pb-4 flex sm:pl-6">
                                    <dt class="font-medium text-gray-900">Price</dt>
                                    <asp:Label ID="lblPrice" class="ml-2 text-gray-700" runat="server" Text="RM 10.99"></asp:Label>
                                </div>
                            </dl>
                        </div>
                    </div>
                </div>

                <div class="sm:ml-40 sm:pl-6">
                    <dl class="grid grid-cols-2 gap-x-6 border-t border-gray-200 text-sm py-10">
                        <div>
                            <dt class="font-medium text-gray-900">Customer Information</dt>
                            <dd class="mt-2 text-gray-700">
                                <asp:Label ID="lblCustName" runat="server" Text="Wong Fu Lim"></asp:Label>
                                <br />
                                <asp:Label ID="lblCustEmail" runat="server" Text="fulim@gmail.com"></asp:Label>
                            </dd>
                        </div>
                        <div>
                            <dt class="font-medium text-gray-900">Payment method</dt>
                            <dd class="mt-2 text-gray-700">
                                <asp:Label ID="lblPaymentMethod" runat="server" Text="Mastercard"></asp:Label>
                                <asp:Label ID="lblPaymentDetails" runat="server" Text="Ending in 4242"></asp:Label>
                            </dd>
                        </div>
                    </dl>

                    <dl class="space-y-6 border-t border-gray-200 text-sm pt-10">
                        <div class="flex justify-between">
                            <dt class="font-medium text-gray-900">Subtotal</dt>
                            <asp:Label ID="lblSubtotal" class="text-gray-700" runat="server" Text="$36.00"></asp:Label>
                        </div>
                        <div class="flex justify-between">
                            <dt class="flex font-medium text-gray-900">Discount
    
                            </dt>
                            <asp:Label ID="lblDiscountPrice" class="text-gray-700" runat="server" Text="-$18.00 (50%)"></asp:Label>
                        </div>
                        <%--                        <div class="flex justify-between">
                    <dt class="font-medium text-gray-900">Tax</dt>
                    <dd class="text-gray-700">$5.00</dd>
                </div>--%>
                        <div class="flex justify-between">
                            <dt class="font-medium text-gray-900">Total</dt>
                            <asp:Label ID="lblTotal" class="text-gray-900" runat="server" Text="$23.00"></asp:Label>
                        </div>
                    </dl>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
