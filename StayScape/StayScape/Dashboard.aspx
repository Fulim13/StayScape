<%@ Page Title="" Language="C#" MasterPageFile="~/Main.Master" AutoEventWireup="true" CodeBehind="Dashboard.aspx.cs" Inherits="StayScape.Dashboard" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <h3 class="text-lg leading-6 font-medium text-gray-900">Overview</h3>

    <dl class="mt-5 grid grid-cols-1 gap-5 sm:grid-cols-2 lg:grid-cols-3">
        <div class="relative bg-white pt-5 px-4 sm:pt-6 sm:px-6 shadow rounded-lg overflow-hidden">
            <dt>
                <div class="absolute bg-indigo-500 rounded-md p-3">
                    <!-- Heroicon name: outline/banknotes -->
                    <svg class="h-6 w-6 text-white" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor" class="w-6 h-6">
                        <path stroke-linecap="round" stroke-linejoin="round" d="M2.25 18.75a60.07 60.07 0 0 1 15.797 2.101c.727.198 1.453-.342 1.453-1.096V18.75M3.75 4.5v.75A.75.75 0 0 1 3 6h-.75m0 0v-.375c0-.621.504-1.125 1.125-1.125H20.25M2.25 6v9m18-10.5v.75c0 .414.336.75.75.75h.75m-1.5-1.5h.375c.621 0 1.125.504 1.125 1.125v9.75c0 .621-.504 1.125-1.125 1.125h-.375m1.5-1.5H21a.75.75 0 0 0-.75.75v.75m0 0H3.75m0 0h-.375a1.125 1.125 0 0 1-1.125-1.125V15m1.5 1.5v-.75A.75.75 0 0 0 3 15h-.75M15 10.5a3 3 0 1 1-6 0 3 3 0 0 1 6 0Zm3 0h.008v.008H18V10.5Zm-12 0h.008v.008H6V10.5Z" />
                    </svg>
                </div>
                <p class="ml-16 text-sm font-medium text-gray-500 truncate">Total Revenue (RM)</p>
            </dt>
            <dd class="ml-16 pb-6 flex items-baseline sm:pb-7">
                <p class="text-2xl font-semibold text-gray-900">71,897</p>
            </dd>
        </div>

        <div class="relative bg-white pt-5 px-4 sm:pt-6 sm:px-6 shadow rounded-lg overflow-hidden">
            <dt>
                <div class="absolute bg-indigo-500 rounded-md p-3">
                    <!-- Heroicon name: outline/home -->
                    <svg class="w-6 h-6 text-white" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor">
                        <path stroke-linecap="round" stroke-linejoin="round" d="M8.25 21v-4.875c0-.621.504-1.125 1.125-1.125h2.25c.621 0 1.125.504 1.125 1.125V21m0 0h4.5V3.545M12.75 21h7.5V10.75M2.25 21h1.5m18 0h-18M2.25 9l4.5-1.636M18.75 3l-1.5.545m0 6.205 3 1m1.5.5-1.5-.5M6.75 7.364V3h-3v18m3-13.636 10.5-3.819" />
                    </svg>
                </div>
                <p class="ml-16 text-sm font-medium text-gray-500 truncate">Total Reservation</p>
            </dt>
            <dd class="ml-16 pb-6 flex items-baseline sm:pb-7">
                <p class="text-2xl font-semibold text-gray-900">58.16%</p>
            </dd>
        </div>

        <div class="relative bg-white pt-5 px-4 sm:pt-6 sm:px-6 shadow rounded-lg overflow-hidden">
            <dt>
                <div class="absolute bg-indigo-500 rounded-md p-3">
                    <!-- Heroicon name: outline/user -->
                    <svg class="w-6 h-6 text-white" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor">
                        <path stroke-linecap="round" stroke-linejoin="round" d="M15.75 6a3.75 3.75 0 1 1-7.5 0 3.75 3.75 0 0 1 7.5 0ZM4.501 20.118a7.5 7.5 0 0 1 14.998 0A17.933 17.933 0 0 1 12 21.75c-2.676 0-5.216-.584-7.499-1.632Z" />
                    </svg>
                </div>
                <p class="ml-16 text-sm font-medium text-gray-500 truncate">Avg. Reservation Made (RM)</p>
            </dt>
            <dd class="ml-16 pb-6 flex items-baseline sm:pb-7">
                <p class="text-2xl font-semibold text-gray-900">24.57%</p>
            </dd>
        </div>
    </dl>
    <h3 class="text-lg leading-6 font-medium text-gray-900 mt-8">Recent Reservation</h3>
    <div class="mx-8">
        <asp:ListView ID="ListView1" runat="server" DataKeyNames="reservationID" DataSourceID="SqlDataSource1">
            <EmptyDataTemplate>
                <table runat="server" style="">
                    <tr>
                        <td>No data was returned.</td>
                    </tr>
                </table>
            </EmptyDataTemplate>
            <ItemTemplate>
                <tr class="border-y border-gray-200 hover:bg-gray-50 cursor-pointer" onclick='<%# Eval("reservationID", "window.location.href = \"HostReservationDetails.aspx?reservationID={0}\";") %>'>
                    <td class="whitespace-nowrap px-3 py-4 text-sm text-gray-500">
                        <asp:Label ID="reservationIDLabel" runat="server" Text='<%# Eval("reservationID") %>' />
                    </td>
                    <td class="whitespace-nowrap px-3 py-4 text-sm text-gray-500">
                        <asp:Label ID="reservationTotalLabel" runat="server" Text='<%# "RM" + Eval("reservationTotal") %>' />
                    </td>
                    <td class="whitespace-nowrap px-3 py-4 text-sm text-gray-500">
                        <asp:Label ID="checkInDateLabel" runat="server" Text='<%# Eval("checkInDate") %>' />
                    </td>
                    <td class="whitespace-nowrap px-3 py-4 text-sm text-gray-500">
                        <asp:Label ID="checkOutDateLabel" runat="server" Text='<%# Eval("checkOutDate") %>' />
                    </td>
                    <td class="whitespace-nowrap px-3 py-4 text-sm text-gray-500">
                        <asp:Label ID="reservationStatusLabel" Style='<%# GetStatusLabelCss((string)Eval("reservationStatus")) %>' runat="server" Text='<%# Eval("reservationStatus") %>' />
                    </td>
                </tr>
            </ItemTemplate>
            <LayoutTemplate>
                <div class="mt-8 flex flex-col">
                    <div class="-my-2 -mx-4 overflow-x-auto sm:-mx-6 lg:-mx-8">
                        <div class="inline-block min-w-full py-2 align-middle">
                            <div class="overflow-hidden shadow-sm ring-1 ring-black ring-opacity-5">
                                <table runat="server" class="min-w-full">
                                    <tr runat="server" class="min-w-full">
                                        <td runat="server" class="min-w-full">
                                            <table id="itemPlaceholderContainer" runat="server" class="min-w-full divide-y divide-gray-500">
                                                <tr runat="server" class="bg-gray-50">
                                                    <th runat="server" scope="col" class="px-3 py-3.5 text-left text-sm font-semibold text-gray-900">reservationID</th>
                                                    <th runat="server" scope="col" class="px-3 py-3.5 text-left text-sm font-semibold text-gray-900">reservationTotal</th>
                                                    <th runat="server" scope="col" class="px-3 py-3.5 text-left text-sm font-semibold text-gray-900">checkInDate</th>
                                                    <th runat="server" scope="col" class="px-3 py-3.5 text-left text-sm font-semibold text-gray-900">checkOutDate</th>
                                                    <th runat="server" scope="col" class="px-3 py-3.5 text-left text-sm font-semibold text-gray-900">reservationStatus</th>
                                                </tr>
                                                <tr id="itemPlaceholder" runat="server">
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                    <tr runat="server">
                                        <td runat="server" style=""></td>
                                    </tr>
                                </table>
                            </div>
                        </div>
                    </div>
                </div>
            </LayoutTemplate>
        </asp:ListView>
    </div>
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT r.reservationID, r.reservationTotal, r.checkInDate, r.checkOutDate, r.reservationStatus
FROM Reservation r
JOIN Property p ON r.propertyID = p.propertyID
JOIN Host h ON p.hostID = h.hostID
WHERE h.hostID = @hostID;">
        <SelectParameters>
            <asp:SessionParameter Name="hostID" SessionField="hostID" />
        </SelectParameters>
    </asp:SqlDataSource>
</asp:Content>
