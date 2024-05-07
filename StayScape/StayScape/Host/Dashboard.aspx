<%@ Page Title="" Language="C#" MasterPageFile="/Host/Main.Master" AutoEventWireup="true" CodeBehind="Dashboard.aspx.cs" Inherits="StayScape.Dashboard" %>

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
                <asp:Label ID="lblTotalRevenue" class="text-2xl font-semibold text-gray-900" runat="server" Text="0"></asp:Label>
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
                <asp:Label ID="lblTotalReservation" class="text-2xl font-semibold text-gray-900" runat="server" Text=""></asp:Label>
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
                <asp:Label ID="lblAvgReservation" class="text-2xl font-semibold text-gray-900" runat="server" Text=""></asp:Label>
            </dd>
        </div>
    </dl>
    <h3 class="text-lg leading-6 font-medium text-gray-900 mt-8 mb-4">Recent Reservation</h3>
    <!-- Search -->
    <div class="sm:col-span-1">
        <label for="txtSearch" class="sr-only">Search</label>
        <div class="relative">
            <asp:TextBox runat="server" placeholder="Search reservation id" ID="txtSearch"
                AutoPostBack="true" OnTextChanged="txtSearch_TextChanged"
                class="py-2 px-3 ps-11 block w-full border-gray-200 rounded-lg text-sm focus:border-blue-500 focus:ring-blue-500 disabled:opacity-50 disabled:pointer-events-none">
            </asp:TextBox>
            <div class="absolute inset-y-0 start-0 flex items-center pointer-events-none ps-4">
                <svg class="h-4 w-4 text-gray-400" xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" viewBox="0 0 16 16">
                    <path d="M11.742 10.344a6.5 6.5 0 1 0-1.397 1.398h-.001c.03.04.062.078.098.115l3.85 3.85a1 1 0 0 0 1.415-1.414l-3.85-3.85a1.007 1.007 0 0 0-.115-.1zM12 6.5a5.5 5.5 0 1 1-11 0 5.5 5.5 0 0 1 11 0z" />
                </svg>
            </div>
        </div>
    </div>
    <!-- End Search -->
    <div class="sm:col-span-2 md:grow mt-4">
        <div class="flex justify-end gap-x-2">
            <asp:DropDownList runat="server" ID="ddlIsExpired" OnSelectedIndexChanged="ddlIsExpired_SelectedIndexChanged"
                class="py-2 pr-10 inline-flex items-center gap-x-2 text-sm font-medium rounded-lg border border-gray-200 bg-white text-gray-800 shadow-sm hover:bg-gray-50 disabled:opacity-50 disabled:pointer-events-none"
                AutoPostBack="True">
                <asp:ListItem Value="">All</asp:ListItem>
                <asp:ListItem Value="paid">Paid</asp:ListItem>
                <asp:ListItem Value="failed">Failed</asp:ListItem>
            </asp:DropDownList>
        </div>
    </div>
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
                    <td data-reservation-id='<%# Eval("reservationID") %>' class="clipboard-icon flex  whitespace-nowrap px-3 py-4 text-sm text-gray-500">
                        <asp:Label ID="reservationIDLabel" runat="server" Text='<%# Eval("reservationID") %>' />
                        <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor" class="w-6 h-6">
                            <path stroke-linecap="round" stroke-linejoin="round" d="M15.666 3.888A2.25 2.25 0 0 0 13.5 2.25h-3c-1.03 0-1.9.693-2.166 1.638m7.332 0c.055.194.084.4.084.612v0a.75.75 0 0 1-.75.75H9a.75.75 0 0 1-.75-.75v0c0-.212.03-.418.084-.612m7.332 0c.646.049 1.288.11 1.927.184 1.1.128 1.907 1.077 1.907 2.185V19.5a2.25 2.25 0 0 1-2.25 2.25H6.75A2.25 2.25 0 0 1 4.5 19.5V6.257c0-1.108.806-2.057 1.907-2.185a48.208 48.208 0 0 1 1.927-.184" />
                        </svg>
                    </td>
                    <td class="whitespace-nowrap px-3 py-4 text-sm text-gray-500">
                        <asp:Label ID="customerName" runat="server" Text='<%# Eval("customerName") %>' />
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
                                                    <th runat="server" scope="col" class="px-3 py-3.5 text-left text-sm font-semibold text-gray-900">Reservation ID</th>
                                                    <th runat="server" scope="col" class="px-3 py-3.5 text-left text-sm font-semibold text-gray-900">Customer Name</th>
                                                    <th runat="server" scope="col" class="px-3 py-3.5 text-left text-sm font-semibold text-gray-900">Reservation Total</th>
                                                    <th runat="server" scope="col" class="px-3 py-3.5 text-left text-sm font-semibold text-gray-900">Check-In Date</th>
                                                    <th runat="server" scope="col" class="px-3 py-3.5 text-left text-sm font-semibold text-gray-900">Check-Out Date</th>
                                                    <th runat="server" scope="col" class="px-3 py-3.5 text-left text-sm font-semibold text-gray-900">Reservation Status</th>
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
        <!-- Footer -->
        <div class="px-6 py-4 flex justify-end items-center">
            <div class="inline-flex gap-x-2">
                <asp:DataPager ID="DataPager2" runat="server" PagedControlID="ListView1" PageSize="10">
                    <Fields>
                        <asp:NextPreviousPagerField
                            ButtonCssClass="cursor-pointer min-h-[38px] min-w-[38px] py-2 px-2.5 text-sm rounded-lg text-gray-800 hover:bg-gray-100 focus:outline-none focus:bg-gray-100 disabled:opacity-50 disabled:pointer-events-none"
                            ButtonType="Button"
                            ShowFirstPageButton="True"
                            ShowPreviousPageButton="True"
                            ShowNextPageButton="False"
                            ShowLastPageButton="False"
                            RenderNonBreakingSpacesBetweenControls="false" />
                        <asp:NumericPagerField
                            NumericButtonCssClass="cursor-pointer min-h-[38px] min-w-[38px] text-gray-800 hover:bg-gray-100 py-2 px-3 text-sm rounded-lg focus:outline-none focus:bg-gray-100 disabled:opacity-50 disabled:pointer-events-none"
                            ButtonType="Button"
                            CurrentPageLabelCssClass="text-center inline-block min-h-[38px] min-w-[38px] bg-gray-200 text-gray-800 py-2 px-3 text-sm rounded-lg focus:outline-none focus:bg-gray-300 disabled:opacity-50 disabled:pointer-events-none"
                            ButtonCount="10" />
                        <asp:NextPreviousPagerField
                            ButtonCssClass="cursor-pointer  min-h-[38px] min-w-[38px] py-2 px-2.5 text-sm rounded-lg text-gray-800 hover:bg-gray-100 focus:outline-none focus:bg-gray-100 disabled:opacity-50 disabled:pointer-events-none"
                            ButtonType="Button"
                            ShowFirstPageButton="False"
                            ShowPreviousPageButton="False"
                            ShowNextPageButton="True"
                            ShowLastPageButton="True" />
                    </Fields>
                </asp:DataPager>
            </div>
        </div>
        <!-- End Footer -->
    </div>
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:LocalSqlServer %>" 
    SelectCommand="SELECT r.reservationID, r.reservationTotal, r.checkInDate, r.checkOutDate, r.reservationStatus, c.customerName
                   FROM Reservation r
                   JOIN Property p ON r.propertyID = p.propertyID
                   JOIN Host h ON p.hostID = h.hostID
                   JOIN Customer c ON r.custID = c.custID
                   WHERE h.hostID = @hostID;">
    <SelectParameters>
        <asp:SessionParameter Name="hostID" SessionField="hostID" />
    </SelectParameters>
</asp:SqlDataSource>
     <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
 <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/toastr.min.css">
 <script src="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/toastr.min.js"></script>
 <script>
     toastr.options = {
         "closeButton": false,
         "debug": false,
         "newestOnTop": false,
         "progressBar": true,
         "positionClass": "toast-top-right",
         "preventDuplicates": false,
         "onclick": null,
         "showDuration": "300",
         "hideDuration": "1000",
         "timeOut": "5000",
         "extendedTimeOut": "1000",
         "showEasing": "swing",
         "hideEasing": "linear",
         "showMethod": "fadeIn",
         "hideMethod": "fadeOut"
     }
 </script>
    <script>
        const clipboardIcons = document.querySelectorAll(".clipboard-icon");

        function handleClick(event) {
            event.stopPropagation();

            const reservationID = event.currentTarget.getAttribute("data-reservation-id");
            const textToCopy = reservationID;

            navigator.clipboard.writeText(textToCopy)
                .then(() => {
                    console.log("Text copied to clipboard:", textToCopy);
                    toastr["success"]("Text copied to clipboard!"); // TODO: Replace with Toast notification
                })
                .catch(err => {
                    console.error("Error copying text to clipboard:", err);
                    alert("Failed to copy text to clipboard. Please try again."); // TODO: Replace with Toast notification
                });
        }

        clipboardIcons.forEach(icon => {
            icon.addEventListener("click", handleClick);
        });
    </script>
</asp:Content>
