<%@ Page Title="" Language="C#" MasterPageFile="~/Main.Master" AutoEventWireup="true" CodeBehind="Voucher.aspx.cs" Inherits="StayScape.Voucher" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <%-- New Voucher Section: Only Display when host do not have any vouchers --%>
    <asp:Panel ID="newVoucherSection" runat="server" Visible="false">
        <div class="flex custom-height justify-center items-center">
            <div class="text-center">
                <!-- Heroicon name: outline/credit-card -->
                <svg class="mx-auto h-12 w-12 text-gray-400" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor">
                    <path stroke-linecap="round" stroke-linejoin="round" d="M2.25 8.25h19.5M2.25 9h19.5m-16.5 5.25h6m-6 2.25h3m-3.75 3h15a2.25 2.25 0 0 0 2.25-2.25V6.75A2.25 2.25 0 0 0 19.5 4.5h-15a2.25 2.25 0 0 0-2.25 2.25v10.5A2.25 2.25 0 0 0 4.5 19.5Z" />
                </svg>
                <h3 class="mt-2 text-sm font-medium text-gray-900">No vouchers</h3>
                <p class="mt-1 text-sm text-gray-500">Get started by creating a new voucher.</p>
                <div class="mt-6">
                    <asp:HyperLink ID="AddVoucherLink" runat="server" NavigateUrl="~/AddVoucher.aspx" class="inline-flex items-center px-4 py-2.5 border border-transparent shadow-sm text-sm font-medium rounded-md text-white bg-indigo-600 hover:bg-indigo-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-indigo-500">
                     <!-- Heroicon name: solid/plus -->
                     <svg class="-ml-1 mr-2 h-5 w-5" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 20 20" fill="currentColor" aria-hidden="true">
                         <path fill-rule="evenodd" d="M10 3a1 1 0 011 1v5h5a1 1 0 110 2h-5v5a1 1 0 11-2 0v-5H4a1 1 0 110-2h5V4a1 1 0 011-1z" clip-rule="evenodd" />
                     </svg>
                     New Voucher
                    </asp:HyperLink>
                </div>
                <div class="relative py-3">
                    <div class="absolute inset-0 flex items-center" aria-hidden="true">
                        <div class="w-full border-t border-gray-300"></div>
                    </div>
                    <div class="relative flex justify-center">
                        <span class="px-2 bg-white text-sm text-gray-500">Or </span>
                    </div>
                </div>
                <div class="mt-1">
                    <asp:HyperLink ID="HyperLink1" runat="server" NavigateUrl="~/BulkImportVoucher.aspx" class="inline-flex items-center px-5 py-2.5 border border-transparent shadow-sm text-sm font-medium rounded-md text-white bg-indigo-600 hover:bg-indigo-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-indigo-500">
                         <!-- Heroicon name: solid/plus -->
                        <svg class="-ml-1 mr-2 h-5 w-5" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor">
                            <path stroke-linecap="round" stroke-linejoin="round" d="M12 10.5v6m3-3H9m4.06-7.19-2.12-2.12a1.5 1.5 0 0 0-1.061-.44H4.5A2.25 2.25 0 0 0 2.25 6v12a2.25 2.25 0 0 0 2.25 2.25h15A2.25 2.25 0 0 0 21.75 18V9a2.25 2.25 0 0 0-2.25-2.25h-5.379a1.5 1.5 0 0 1-1.06-.44Z" />
                        </svg>
                         Bulk Import
                    </asp:HyperLink>
                </div>
            </div>
        </div>
    </asp:Panel>

    <%-- Vouchers Table: Only Display when host have vouchers --%>
    <asp:Panel ID="vouchersTable" runat="server" Visible="false">
        <div class="px-4 sm:px-6 lg:px-8">
            <div class="sm:flex sm:items-center">
                <div class="sm:flex-auto">
                    <h1 class="text-xl font-semibold text-gray-900">Voucher List</h1>
                </div>
                <div class="mt-4 sm:mt-0 sm:ml-16 sm:flex-none">
                    <asp:HyperLink ID="HyperLink3" runat="server" NavigateUrl="~/BulkImportVoucher.aspx" class="inline-flex items-center px-5 py-2.5 border border-transparent shadow-sm text-sm font-medium rounded-md text-white bg-indigo-600 hover:bg-indigo-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-indigo-500">
                    <!-- Heroicon name: outline/folder-plus -->
                    <svg class="-ml-1 mr-2 h-5 w-5" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor">
                        <path stroke-linecap="round" stroke-linejoin="round" d="M12 10.5v6m3-3H9m4.06-7.19-2.12-2.12a1.5 1.5 0 0 0-1.061-.44H4.5A2.25 2.25 0 0 0 2.25 6v12a2.25 2.25 0 0 0 2.25 2.25h15A2.25 2.25 0 0 0 21.75 18V9a2.25 2.25 0 0 0-2.25-2.25h-5.379a1.5 1.5 0 0 1-1.06-.44Z" />
                    </svg>
                        Bulk Import
                    </asp:HyperLink>
                    <asp:HyperLink ID="HyperLink2" runat="server" NavigateUrl="~/AddVoucher.aspx" class="ml-4 inline-flex items-center px-4 py-2.5 border border-transparent shadow-sm text-sm font-medium rounded-md text-white bg-indigo-600 hover:bg-indigo-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-indigo-500">
                     <!-- Heroicon name: solid/plus -->
                     <svg class="-ml-1 mr-2 h-5 w-5" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 20 20" fill="currentColor" aria-hidden="true">
                         <path fill-rule="evenodd" d="M10 3a1 1 0 011 1v5h5a1 1 0 110 2h-5v5a1 1 0 11-2 0v-5H4a1 1 0 110-2h5V4a1 1 0 011-1z" clip-rule="evenodd" />
                     </svg>
                     New Voucher
                    </asp:HyperLink>
                </div>
            </div>
            <asp:ListView ID="ListView1" runat="server" DataKeyNames="voucherID" DataSourceID="SqlDataSource1">
                <ItemTemplate>
                    <%-- --%>
                    <tr class=" border-y border-gray-200 hover:bg-gray-50 cursor-pointer" onclick='<%# Eval("voucherID", "window.location.href = \"VoucherDetails.aspx?voucherID={0}\";") %>'>
                        <td class="whitespace-nowrap px-3 py-4 text-sm text-gray-500">
                            <asp:Label ID="voucherNameLabel" runat="server" Text='<%# Eval("voucherName") %>' />
                        </td>
                        <td class="whitespace-nowrap px-3 py-4 text-sm text-gray-500">
                            <asp:Label ID="totalVoucherLabel" runat="server"
                                Text='<%# Eval("TotalRedemptions", "{0}") + " / " + Eval("totalVoucher") %>' />
                        </td>
                        <td class="whitespace-nowrap px-3 py-4 text-sm text-gray-500">
                            <asp:Label ID="dateRangeLabel" runat="server"
                                Text='<%# Eval("startDate", "{0:yyyy-MM-dd HH:mm:ss}")  +" ~ " + Eval("expiredDate", "{0:yyyy-MM-dd HH:mm:ss}") %>' />
                        </td>
                        <td class="whitespace-nowrap px-3 py-4 text-sm text-gray-500">
                            <asp:Label ID="discountDetail" runat="server" Text='<%# (string)Eval("discountType") == "Value Off" ? GetDiscountDetailFromValue((decimal)Eval("minSpend"), (decimal)Eval("discountPrice")) : GetDiscountDetailFromDiscount((decimal)Eval("minSpend"), (decimal)Eval("discountRate"), (decimal)Eval("capAt")) %>' />
                        </td>
                        <td class="whitespace-nowrap px-3 py-4 text-sm text-gray-500">
                            <asp:Label ID="Label1" Style='<%# GetStatusLabelCss((bool)Eval("activeStatus"), (DateTime)Eval("expiredDate")) %>' runat="server" Text='<%# GetStatusLabelText((bool)Eval("activeStatus"), (DateTime)Eval("expiredDate")) %>' />
                        </td>
                        <td data-voucher-code='<%# Eval("voucherCode") %>' class="clipboard-icon flex items-center justify-end whitespace-nowrap px-3 py-4 text-sm text-gray-500">
                            <asp:Label ID="voucherCodeLabel" CssClass="pr-2" runat="server" Text='<%# Eval("voucherCode") %>' />
                            <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor" class="w-6 h-6">
                                <path stroke-linecap="round" stroke-linejoin="round" d="M15.666 3.888A2.25 2.25 0 0 0 13.5 2.25h-3c-1.03 0-1.9.693-2.166 1.638m7.332 0c.055.194.084.4.084.612v0a.75.75 0 0 1-.75.75H9a.75.75 0 0 1-.75-.75v0c0-.212.03-.418.084-.612m7.332 0c.646.049 1.288.11 1.927.184 1.1.128 1.907 1.077 1.907 2.185V19.5a2.25 2.25 0 0 1-2.25 2.25H6.75A2.25 2.25 0 0 1 4.5 19.5V6.257c0-1.108.806-2.057 1.907-2.185a48.208 48.208 0 0 1 1.927-.184" />
                            </svg>
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
                                                        <th runat="server" scope="col" class="px-3 py-3.5 text-left text-sm font-semibold text-gray-900">Name</th>
                                                        <th runat="server" scope="col" class="px-3 py-3.5 text-left text-sm font-semibold text-gray-900">Voucher Issued</th>
                                                        <th runat="server" scope="col" class="px-3 py-3.5 text-left text-sm font-semibold text-gray-900">Collect Start Time ~ Redeem End Time</th>
                                                        <th runat="server" scope="col" class="px-3 py-3.5 text-left text-sm font-semibold text-gray-900">Discount Details</th>
                                                        <th runat="server" scope="col" class="px-3 py-3.5 text-left text-sm font-semibold text-gray-900">Status</th>
                                                        <th runat="server" scope="col" class="px-3 py-3.5 text-right text-sm font-semibold text-gray-900">Code</th>
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
        <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="
    SELECT
        Voucher.voucherID, Voucher.voucherName, Voucher.totalVoucher, Voucher.startDate, Voucher.expiredDate, Voucher.minSpend, Voucher.voucherCode,Voucher.activeStatus, Voucher.discountType, Voucher.discountRate, Voucher.discountPrice, Voucher.capAt,
        COUNT(Redemption.redemptionID) AS TotalRedemptions
    FROM
        Voucher
    LEFT JOIN
        Redemption ON Voucher.voucherID = Redemption.voucherID
    GROUP BY Voucher.voucherID, Voucher.voucherName, Voucher.totalVoucher, Voucher.startDate, Voucher.expiredDate, Voucher.minSpend, Voucher.voucherCode, Voucher.activeStatus, Voucher.discountType, Voucher.discountRate, Voucher.discountPrice, Voucher.capAt
    "></asp:SqlDataSource>
    </asp:Panel>
    <script>
        // Get all clipboard icons
        const clipboardIcons = document.querySelectorAll(".clipboard-icon");

        // Function to handle click event
        function handleClick(event) {
            event.stopPropagation(); // Stop event propagation

            // Get the voucher code associated with the clicked element
            const voucherCode = event.currentTarget.getAttribute("data-voucher-code");
            console.log(voucherCode)

            // Text to copy to clipboard
            const textToCopy = voucherCode;

            // Use the Clipboard API to copy text to clipboard
            navigator.clipboard.writeText(textToCopy)
                .then(() => {
                    console.log("Text copied to clipboard:", textToCopy);
                    alert("Text copied to clipboard!"); // Optional: Show an alert message
                })
                .catch(err => {
                    console.error("Error copying text to clipboard:", err);
                    alert("Failed to copy text to clipboard. Please try again."); // Optional: Show an alert message
                });
        }

        // Attach click event listeners to all clipboard icons
        clipboardIcons.forEach(icon => {
            icon.addEventListener("click", handleClick);
        });
    </script>
</asp:Content>
