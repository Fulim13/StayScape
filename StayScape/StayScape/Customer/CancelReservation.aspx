﻿<%@ Page Title="" Language="C#" MasterPageFile="~/Customer.Master" AutoEventWireup="true" CodeBehind="CancelReservation.aspx.cs" Inherits="StayScape.CancelReservation" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        #ContentPlaceHolder1_reasonRbl label {
            margin-left: .5rem;
        }

        #ContentPlaceHolder1_reasonRbl td{
            padding-bottom: 1rem;
        }
    </style>

    <script type="text/javascript">
        function showAlert(message) {
            // Show the alert message
            alert(message);
        }
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container mx-auto px-4 py-8">
        <div class="w-full max-w-3xl py-4 px-4 md:px-5 lg-6 mx-auto rounded-md shadow-xl">
            <h3 class="text-lg leading-6 font-medium text-gray-900 underline underline-offset-4">Cancellation Of Reservation</h3>
            <div class="flex py-4">
                <div class="bg-gray-50 px-4 py-6 sm:rounded-lg sm:p-6 md:flex md:items-center md:justify-between md:space-x-2 lg:space-x-4">
                    <dl class="divide-y divide-gray-200 space-y-4 text-sm text-gray-600 flex-auto md:divide-y-0 md:space-y-0 md:grid md:grid-cols-4 md:gap-x-2 lg:w-1/2 lg:gap-x-4">
                        <div class="flex justify-between md:block">
                            <dt class="font-medium text-gray-900">Property Name</dt>
                            <asp:Label ID="lblPropertyName" runat="server" Text="propertyName"></asp:Label>
                        </div>
                        <div class="flex justify-between pt-4 md:block md:pt-0">
                            <dt class="font-medium text-gray-900">Duration</dt>
                            <asp:Label ID="lblCheckInOutDate" class="text-slate-500" runat="server" Text="Check-in and Check-out Date"></asp:Label>
                        </div>
                        <div class="flex justify-between pt-4 md:block md:pt-0">
                            <dt class="font-medium text-gray-900">Made Reservation On</dt>
                            <asp:Label ID="lblReservationDate" class="text-slate-500" runat="server" Text="Reservation Total"></asp:Label>
                        </div>
                        <div class="flex justify-between pt-4 font-medium text-gray-900 md:block md:pt-0">
                            <dt class="font-medium text-gray-900">Total</dt>
                            <asp:Label ID="lblReservationTotal" class="text-slate-500" runat="server" Text="Reservation Total"></asp:Label>
                        </div>
                    </dl>
                </div>
            </div>
            <p>Select Cancellation Reason: </p>
            <div class="flex items-center border-solid border-2 border-indigo-300 rounded-lg bg-slate-50 px-2 py-2 my-3">
                <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor" class="mr-3 w-6 h-6">
                  <path stroke-linecap="round" stroke-linejoin="round" d="m11.25 11.25.041-.02a.75.75 0 0 1 1.063.852l-.708 2.836a.75.75 0 0 0 1.063.853l.041-.021M21 12a9 9 0 1 1-18 0 9 9 0 0 1 18 0Zm-9-3.75h.008v.008H12V8.25Z" />
                </svg>
                <p>Please select a valid cancellation reason. Upon successful reservation cancellation, your refund will be processed immediately.</p>
            </div>
            <div>
                <asp:RadioButtonList ID="reasonRbl" runat="server" AutoPostBack="True" CssClass="px-2">
                    <asp:ListItem>Double Booking or Mistake</asp:ListItem>
                    <asp:ListItem>Change in Travel Plans</asp:ListItem>
                    <asp:ListItem>Found Better Deal or Accommodation</asp:ListItem>
                    <asp:ListItem>Unforeseen Circumstances at Home or Work</asp:ListItem>
                    <asp:ListItem>Personal Reasons</asp:ListItem>
                    <asp:ListItem>Other / Change of mind</asp:ListItem>
                </asp:RadioButtonList>
            </div>
            <%--<div class="sm:border-t sm:border-gray-200">
                <div class="mt-1 sm:mt-0">
                    <asp:TextBox 
                        ID="reasonTxtbx" 
                        runat="server" 
                        CssClass="mb-4 py-2 px-3 block w-full border-gray-300 shadow-sm text-md rounded-lg focus:border-indigo-500 focus:ring-indigo-500" 
                        Height="100px" 
                        Visible="False"
                        TextMode="MultiLine">
                    </asp:TextBox>
                </div>
                </div>--%>
            <asp:HyperLink ID="navLink" runat="server" NavigateUrl="~/CancellationPolicy.aspx" Text="View Policy" CssClass="text-indigo-600 hover:text-indigo-800" />
            <br />
            <asp:Label ID="lblError" runat="server" CssClass="text-red-500"></asp:Label>
            <%-- Submit and Cancel Button --%>
            <div class="pt-5">
                <div class="flex justify-end">
                    <asp:Button 
                        ID="btnConfirm" 
                        runat="server" 
                        Text="Confirm" 
                        CssClass="ml-3 inline-flex justify-center py-2 px-4 border border-transparent shadow-sm text-sm font-medium rounded-md text-white bg-indigo-600 hover:bg-indigo-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-indigo-500" 
                        OnClick="btnConfirm_Click" 
                    />
                    <asp:Button 
                        ID="btnCancel" 
                        runat="server" 
                        Text="Cancel" 
                        CssClass="ml-3 bg-white py-2 px-4 border border-gray-300 rounded-md shadow-sm text-sm font-medium text-gray-700 hover:bg-gray-50 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-indigo-500" 
                        OnClick="btnCancel_Click" 
                    />                    
                    <asp:Panel ID="successCancelModal" runat="server" CssClass="hidden fixed z-10 inset-0 overflow-y-auto">
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
                                                    Cancel Reservation Successful.
                                                </h3>
                                                <div class="mt-2 text-center">
                                                    <!-- Label for the refund information -->
                                                    <asp:Label ID="lblSuccessCancelText" runat="server" CssClass="text-center text-sm text-gray-500" Text="Cancellation details will appear here."></asp:Label>
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
    </div>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder2" runat="server">
</asp:Content>
