<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/Customer.Master" CodeBehind="Profile.aspx.cs" Inherits="StayScape.Profile" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <meta charset="utf-8">
    <title>Profile</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="flex justify-center items-center mt-8">
        <div class="flex flex-col items-start">
            <div>
                <h3 class="text-lg leading-6 font-medium text-gray-900">Applicant Information</h3>
                <p class="mt-1 max-w-2xl text-sm text-gray-500">Personal details and application.</p>
            </div>
            <div class="mt-5 border-t border-gray-200">
                <dl class="divide-y divide-gray-200">
                    <div class="py-4 sm:py-5 sm:grid sm:grid-cols-3 sm:gap-4">
                        <dt class="text-sm font-medium text-gray-500">Full name</dt>
                        <dd class="mt-1 flex text-sm text-gray-900 sm:mt-0 sm:col-span-2">
                            <asp:Label class="flex-grow" ID="nameLabel" runat="server"></asp:Label>
                            &nbsp;<span class="ml-4 flex-shrink-0">
                                <button type="button" class="bg-white rounded-md font-medium text-indigo-600 hover:text-indigo-500 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-indigo-500">Update</button>
                            </span>
                        </dd>
                    </div>
                    <div class="py-4 sm:grid sm:py-5 sm:grid-cols-3 sm:gap-4">
                        <dt class="text-sm font-medium text-gray-500">I am a</dt>
                        <dd class="mt-1 flex text-sm text-gray-900 sm:mt-0 sm:col-span-2">
                            <asp:Label class="flex-grow" ID="roleLabel" runat="server"></asp:Label>
                            <span class="ml-4 flex-shrink-0">
                                <button type="button" class="bg-white rounded-md font-medium text-indigo-600 hover:text-indigo-500 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-indigo-500">Update</button>
                            </span>
                        </dd>
                    </div>
                    <div class="py-4 sm:grid sm:py-5 sm:grid-cols-3 sm:gap-4">
                        <dt class="text-sm font-medium text-gray-500">Email address</dt>
                        <dd class="mt-1 flex text-sm text-gray-900 sm:mt-0 sm:col-span-2">
                            <asp:Label class="flex-grow" ID="emailLabel" runat="server"></asp:Label>
                            <span class="ml-4 flex-shrink-0">
                                <button type="button" class="bg-white rounded-md font-medium text-indigo-600 hover:text-indigo-500 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-indigo-500">Update</button>
                            </span>
                        </dd>
                    </div>
                    <div class="py-4 sm:grid sm:py-5 sm:grid-cols-3 sm:gap-4">
                        <dt class="text-sm font-medium text-gray-500">Phone Number</dt>
                        <dd class="mt-1 flex text-sm text-gray-900 sm:mt-0 sm:col-span-2">
                            <asp:Label class="flex-grow" ID="phoneLabel" runat="server"></asp:Label>
                            <span class="ml-4 flex-shrink-0">
                                <button type="button" class="bg-white rounded-md font-medium text-indigo-600 hover:text-indigo-500 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-indigo-500">Update</button>
                            </span>
                        </dd>
                    </div>
                    <div class="py-4 sm:grid sm:py-5 sm:grid-cols-3 sm:gap-4">
                        <dt class="text-sm font-medium text-gray-500">Gender</dt>
                        <dd class="mt-1 flex text-sm text-gray-900 sm:mt-0 sm:col-span-2">
                            <asp:Label class="flex-grow" ID="genderLabel" runat="server"></asp:Label>
                            <span class="ml-4 flex-shrink-0">
                                <button type="button" class="bg-white rounded-md font-medium text-indigo-600 hover:text-indigo-500 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-indigo-500">Update</button>
                            </span>
                        </dd>
                    </div>
                    <div class="py-4 sm:grid sm:py-5 sm:grid-cols-3 sm:gap-4">
                        <dt class="text-sm font-medium text-gray-500">Birth Date</dt>
                        <dd class="mt-1 flex text-sm text-gray-900 sm:mt-0 sm:col-span-2">
                            <asp:Label class="flex-grow" ID="bDateLabel" runat="server"></asp:Label>
                            <span class="ml-4 flex-shrink-0">
                                <button type="button" class="bg-white rounded-md font-medium text-indigo-600 hover:text-indigo-500 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-indigo-500">Update</button>
                            </span>
                        </dd>
                    </div>
                    <div class="py-4 sm:grid sm:py-5 sm:grid-cols-3 sm:gap-4">
                        <dt class="text-sm font-medium text-gray-500">Account Creation Date</dt>
                        <dd class="mt-1 flex text-sm text-gray-900 sm:mt-0 sm:col-span-2">
                            <asp:Label class="flex-grow" ID="aDateLabel" runat="server"></asp:Label>
                            <span class="ml-4 flex-shrink-0">
                                <button type="button" class="bg-white rounded-md font-medium text-indigo-600 hover:text-indigo-500 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-indigo-500">Update</button>
                            </span>
                        </dd>
                    </div>
                    <div class="py-4 sm:grid sm:py-4 sm:grid-cols-5 sm:gap-4">
                        <span class="ml-4 flex-shrink-0">
                            <asp:FileUpload ID="pfpUpload" runat="server" />
                            <asp:Button ID="pfpChange" runat="server" class="bg-white rounded-md font-medium text-indigo-600 hover:text-indigo-500 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-indigo-500" Text="Change Profile Picture" OnClick="pfpChange_Click" />
                        </span>
                    </div>
                </dl>
            </div>
        </div>
    </div>
</asp:Content>
