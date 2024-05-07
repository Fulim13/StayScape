<%@ Page Title="" Language="C#" MasterPageFile="~/Customer.Master" AutoEventWireup="true" CodeBehind="OrderHistory.aspx.cs" Inherits="StayScape.OrderHistory" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
 
    <div class="max-w-4xl mx-auto py-8 sm:px-6 sm:py-8">
        <div class="px-4 sm:px-0">
            <h1 class="text-2xl font-extrabold tracking-tight text-gray-900 sm:text-3xl">Reservation history</h1>
            <p class="mt-2 text-sm text-gray-500">View your reservation history, track cancellations, and submit reviews for past stays.</p>
        </div>

        <div class="mt-6">
            <h2 class="sr-only">Recent reservations</h2>
            <div class="flex mb-6">
                <asp:Button 
                    ID="btnFilterAll" 
                    runat="server" 
                    Text="All" 
                    CssClass="status-button py-2 px-4 mr-4 border border-slate-300 rounded-lg text-slate-500 cursor-pointer" 
                    OnClick="FilterStatus_Click" 
                />
                <asp:Button 
                    ID="btnFilterPaid" 
                    runat="server" 
                    Text="Paid" 
                    CssClass="status-button py-2 px-4 mr-4 border border-slate-300 rounded-lg text-slate-500 cursor-pointer" 
                    OnClick="FilterStatus_Click" 
                />
                <asp:Button 
                    ID="btnFilterFailed" 
                    runat="server" 
                    Text="Failed" 
                    CssClass="status-button py-2 px-4 mr-4 border border-slate-300 rounded-lg text-slate-500 cursor-pointer" 
                    OnClick="FilterStatus_Click" 
                />
                <asp:Button 
                    ID="btnFilterCancelled" 
                    runat="server" 
                    Text="Cancelled" 
                    CssClass="status-button py-2 px-4 mr-4 border border-slate-300 rounded-lg text-slate-500 cursor-pointer" 
                    OnClick="FilterStatus_Click" 
                />
            </div>
            <!-- ListView for displaying reservation history -->
            <asp:ListView ID="ReservationListView" runat="server" OnItemDataBound="ReservationListView_ItemDataBound">
                <LayoutTemplate>
                    <div class="space-y-4 sm:space-y-6">
                        <!-- Placeholder for ListView items -->
                        <asp:PlaceHolder ID="itemPlaceholder" runat="server" />
                    </div>
                </LayoutTemplate>

                <ItemTemplate>
                    <div class="px-6 py-6 rounded-md shadow-xl">
                        <div class="bg-gray-50 px-4 py-6 sm:rounded-lg sm:p-6 md:flex md:items-center md:justify-between md:space-x-6 lg:space-x-8">
                            <dl class="divide-y divide-gray-200 space-y-4 text-sm text-gray-600 flex-auto md:divide-y-0 md:space-y-0 md:grid md:grid-cols-4 md:gap-x-6 lg:w-1/2 lg:gap-x-8">
                                <div class="flex justify-between md:block">
                                    <dt class="font-medium text-gray-900">Reservation Number</dt>
                                    <asp:Label ID="lblOrderNum" runat="server" Text='<%# Eval("ReservationID") %>' />
                                </div>
                                <div class="flex justify-between pt-4 md:block md:pt-0">
                                    <dt class="font-medium text-gray-900">Duration</dt>
                                    <asp:Label ID="lblCheckInOutDate" runat="server" Text='<%# Eval("CheckInDate") + "-" + Eval("CheckOutDate") %>' />
                                </div>
                                <div class="flex justify-between pt-4 md:block md:pt-0">
                                    <dt class="font-medium text-gray-900">Date Placed</dt>
                                    <asp:Label ID="Label2" runat="server" Text='<%# Eval("DatePlaced") %>' />
                                </div>
                                <div class="flex justify-between pt-4 font-medium text-gray-900 md:block md:pt-0">
                                    <dt>Total Amount</dt>
                                    <asp:Label ID="lblTotal" runat="server" Text='<%# "RM " + Eval("TotalAmount") %>' />
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
                                                    <asp:Label ID="lblPropertyName" runat="server" Text='<%# Eval("PropertyName") %>' CssClass="font-medium text-gray-900" />
                                                    <asp:Label ID="lblPropertyAddress" runat="server" Text='<%# Eval("PropertyAddress") %>' CssClass="hidden mt-2 text-sm text-gray-500 sm:block" />
                                                </div>
                                                <asp:Label ID="lblStatus" runat="server" Text='<%# Eval("Status") %>' CssClass="mt-1 font-medium text-gray-900 sm:mt-0 sm:ml-24" />
                                                <asp:Label 
                                                    ID="lblRefundAmount" 
                                                    runat="server" 
                                                    Text='<%# "Refund: RM " + Eval("RefundAmount") %>' 
                                                    CssClass="mt-1 sm:mt-0 sm:ml-8 text-green-600" 
                                                    Visible='<%# Eval("Status").ToString() == "Cancelled" %>'
                                                />
                                            </div>
                                            <div class="mt-2 flex text-sm font-medium sm:mt-4">
                                                <asp:Button 
                                                    ID="btnAddReview" 
                                                    runat="server" 
                                                    Text="Add Review" 
                                                    CssClass="text-indigo-600 hover:text-indigo-500 cursor-pointer" 
                                                    OnClick="btnAddReview_Click" 
                                                />
                                                <%--<a href="ReviewForm.aspx" class="text-indigo-600 hover:text-indigo-500">Add Review</a>--%>
                                                <asp:Button 
                                                    ID="btnViewReview" 
                                                    runat="server" 
                                                    Text="View Review" 
                                                    CssClass="text-indigo-600 hover:text-indigo-500 cursor-pointer" 
                                                    Visible="false" 
                                                    OnClick="btnViewReview_Click" 
                                                />
                                                <div class="border-l border-gray-200 ml-4 pl-4 sm:ml-6 sm:pl-6"></div>
                                                <asp:Button 
                                                    ID="btnCancelReservation" 
                                                    runat="server" 
                                                    Text="Cancel Reservation" 
                                                    CssClass="text-indigo-600 hover:text-indigo-500 cursor-pointer" 
                                                    OnClick="btnCancelReservation_Click" 
                                                />
                                                <%--<a href="CancelReservation.aspx" class="text-indigo-600 hover:text-indigo-500">Cancel Reservation</a>--%>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="ml-4 flex-shrink-0 sm:m-0 sm:mr-6 sm:order-first">
                                        <asp:Image ID="imgProperty" runat="server" 
                                        CssClass="w-20 h-20 rounded-lg object-center object-cover sm:w-40 sm:h-40 lg:w-52 lg:h-52" 
                                        AlternateText="Property Image" />
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </ItemTemplate>

                <EmptyDataTemplate>
                    <div class="text-center text-gray-500 py-6">
                        No reservation found.
                    </div>
                </EmptyDataTemplate>
            </asp:ListView>
        </div>

        <asp:Panel 
            ID="ReviewModal" 
            runat="server" 
            CssClass="fixed-modal hidden fixed z-10 inset-0 overflow-y-auto bg-gray-500 bg-opacity-75">
            <div class="flex items-end justify-center min-h-screen pt-4 px-4 pb-20 text-center sm:block sm:p-0">
                <div 
                    class="inline-block align-bottom bg-white rounded-lg text-left overflow-hidden shadow-xl transform transition-all sm:my-8 sm:align-middle sm:max-w-lg sm:w-full" 
                    style="position: fixed; top: 50%; left: 50%; transform: translate(-50%, -50%);">
                    <div class="bg-white px-4 pt-5 pb-4 sm:p-6 sm:pb-4">
                        <h3 class="text-lg leading-6 font-medium text-gray-900 underline underline-offset-4">Your Review</h3>
                        <div class="mt-2">
                            <div class="flex items-center my-3 mr-4 space-x-1">
                                <asp:Literal ID="litStarRating" runat="server"></asp:Literal>
                                <asp:Label ID="lblCreatedAt" runat="server" CssClass="text-slate-500 ml-3" Text="Date"></asp:Label>
                            </div>
                            <div class="px-4 py-6">
                                <asp:TextBox 
                                    ID="txtReviewDesc" 
                                    runat="server" 
                                    TextMode="MultiLine" 
                                    CssClass="w-full p-2 border border-gray-300 rounded-md" 
                                    Rows="4"
                                />
                                <%--<asp:Label ID="lblReviewDesc" runat="server" Text="Review content goes here"></asp:Label>--%>
                            </div>
                        </div>
                    </div>
                    <div class="px-4 py-3 sm:px-6 flex justify-end">
                        <asp:Button 
                            ID="btnSubmitEditReview" 
                            runat="server" 
                            Text="Submit" 
                            CssClass="ml-3 inline-flex justify-center py-2 px-4 border border-transparent shadow-sm text-sm font-medium rounded-md text-white bg-indigo-600 hover:bg-indigo-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-indigo-500"
                            OnClick="btnSubmitEditReview_Click" 
                        />
                        <!-- Close button to close the modal -->
                        <asp:Button 
                            ID="btnCloseModal" 
                            runat="server" 
                            Text="Cancel" 
                            CssClass="ml-3 bg-white py-2 px-4 border border-gray-300 rounded-md shadow-sm text-sm font-medium text-gray-700 hover:bg-gray-50 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-indigo-500"
                            OnClick="btnCloseModal_Click" 
                        />
                        <%--<asp:Button 
                            ID="btnCloseModal" 
                            runat="server" 
                            Text="Close" 
                            CssClass="w-full inline-flex justify-center rounded-md border border-transparent shadow-sm px-4 py-2 bg-blue-500 text-base font-medium text-white hover:bg-blue-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-blue-500 sm:w-auto sm:text-sm"
                            OnClick="btnCloseModal_Click" 
                        />--%>
                    </div>
                </div>
            </div>
        </asp:Panel>
    </div>
    <style>
        /* Style for selected button */
        .status-button.selected {
            background-color: rgb(71 85 105);
            color: #fff;
        }
    </style>
    <script>
        function openReviewModal() {
            var modal = document.getElementById('<%= ReviewModal.ClientID %>');
            modal.classList.remove("hidden");
        }

        function closeReviewModal() {
            var modal = document.getElementById('<%= ReviewModal.ClientID %>');
            modal.classList.add("hidden");
        }
    </script>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder2" runat="server">
</asp:Content>
