<%@ Page Title="" Language="C#" MasterPageFile="~/Main.Master" AutoEventWireup="true" CodeBehind="BulkImportVoucher.aspx.cs" Inherits="StayScape.BulkImportVoucher" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="lg:mx-24 xl:mx-48 py-2">
        <div class="pb-4 border-b border-gray-200">
            <h3 class="text-lg leading-6 font-medium text-gray-900">Step 1: Download the CSV file provided</h3>
        </div>
        <asp:Button ID="Button1" runat="server" Text="Download" OnClick="btnDownload_Click" CssClass="mt-2 inline-flex items-center px-4 py-2 border border-transparent text-sm font-medium rounded-md shadow-sm text-white bg-indigo-600 hover:bg-indigo-700 hover:cursor-pointer focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-indigo-500" />
        <div class="mt-4 mb-8 pb-4 border-b border-gray-200">
            <h3 class="text-lg leading-6 font-medium text-gray-900">Step 2: Fill in the value in CSV form</h3>
        </div>
        <%--TODO: Add a example image here --%>
        <div class="mb-2 pb-4 border-b border-gray-200">
            <h3 class="text-lg leading-6 font-medium text-gray-900">Step 3: Upload back the CSV file</h3>
        </div>
        <asp:FileUpload ID="FileUpload1" runat="server"
            CssClass="text-sm file:font-medium file:px-4 file:py-2 file:rounded-md file:border-transparent file:text-white file:mr-5 file:py-1 file:px-3 file:border-[1px] file:text-sm file:font-medium file:bg-indigo-600 hover:file:cursor-pointer hover:file:bg-indigo-700 focus:outline-none" />
        <div class="mt-4 flex justify-center">
            <asp:Button ID="btn_upload" runat="server" Text="Upload" OnClick="btnUpload_Click" CssClass="inline-flex items-center px-4 py-2 border border-transparent text-sm font-medium rounded-md shadow-sm text-white bg-indigo-600 hover:bg-indigo-700 hover:cursor-pointer focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-indigo-500" />
        </div>
    </div>
</asp:Content>
