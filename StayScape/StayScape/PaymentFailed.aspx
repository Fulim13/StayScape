<%@ Page Title="" Language="C#" MasterPageFile="~/Customer.Master" AutoEventWireup="true" CodeBehind="PaymentFailed.aspx.cs" Inherits="StayScape.PaymentFailed" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="mt-16 w-full flex justify-center items-center">
        <div class="flex flex-col w-1/2 items-center">
            <svg class="text-red-600 h-16 w-16" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor" class="w-6 h-6">
                <path stroke-linecap="round" stroke-linejoin="round" d="m9.75 9.75 4.5 4.5m0-4.5-4.5 4.5M21 12a9 9 0 1 1-18 0 9 9 0 0 1 18 0Z" />
            </svg>
            <h1 class="m-3 text-2xl">Payment failed</h1>
            <div class="mt-3 text-gray-500">The payment was unsucessfuol due to an abnormality.</div>
            <div class="text-gray-500">Please try again later or user another payment methods.</div>
            <asp:Button ID="btnTryAgain" CssClass="mt-6 py-3 px-8 bg-indigo-600 text-white text-sm font-medium rounded-md px-4 hover:bg-indigo-800 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-indigo-600" OnClick="btnTryAgain_Click" runat="server" Text="Try Again" />
            <asp:Button ID="btnOrderHistoryPage" CssClass="mt-3 bg-white py-2 px-4 border border-gray-300 rounded-md shadow-sm text-sm font-medium text-gray-700 hover:bg-gray-50 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-indigo-500" runat="server" Text="Back to Order History" OnClick="btnOrderHistoryPage_Click"/>
        </div>
    </div>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder2" runat="server">
</asp:Content>
