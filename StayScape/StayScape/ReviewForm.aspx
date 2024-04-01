<%@ Page Title="" Language="C#" MasterPageFile="~/Customer.Master" AutoEventWireup="true" CodeBehind="ReviewForm.aspx.cs" Inherits="StayScape.ReviewForm" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        /* Hide the radio buttons */
        #ContentPlaceHolder1_RadioButtonList1 input[type="radio"] {
            display: none;
        }

        /* Style the labels */
        #ContentPlaceHolder1_RadioButtonList1 label {
            cursor: pointer;
            display: inline-block;
            margin-right: 5px;
            font-size: 32px;
            color: rgb(107, 114, 128); /* Gray color */
        }

        /* Style the labels to appear as stars */
        #ContentPlaceHolder1_RadioButtonList1 label:before {
            content: '\2605'; /* Unicode character for a star */
        }

        /* Style the selected labels */
        #ContentPlaceHolder1_RadioButtonList1 input[type="radio"]:checked + label:before,
        #ContentPlaceHolder1_RadioButtonList1 input[type="radio"]:checked + label {
            color: rgb(253, 224, 71); /* Yellow color for checked star */
        }

        /* Hide the span elements inside the labels */
        #ContentPlaceHolder1_RadioButtonList1 label span {
            display: none;
        }

        .toggle-button.selected {
            background-color: rgb(71 85 105);
            color: #fff;
        }

    </style>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

    <script>
        $(document).ready(function () {
            $('#ContentPlaceHolder1_RadioButtonList1 input[type="radio"]').change(function () {
                var selectedIndex = $(this).closest('td').index(); // Find the index of the clicked radio button's parent cell
                $(this).closest('table').find('tr td label').each(function (index) { // Traverse to the parent table, find all rows, and then find labels inside cells
                    if (index <= selectedIndex) {
                        // Apply yellow color directly
                        $(this).css('color', 'rgb(253, 224, 71)');
                    } else {
                        // Remove yellow color
                        $(this).css('color', ''); // Reset to default color
                    }
                });
            });

            // Initialize the colors based on the initially selected radio button
            $('#ContentPlaceHolder1_RadioButtonList1 input[type="radio"]:checked').trigger('change');

        });
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container mx-auto px-4 py-8">
        <div class="w-full max-w-3xl py-4 px-4 md:px-5 lg-6 mx-auto rounded-md shadow-xl">
            <h3 class="text-lg leading-6 font-medium text-gray-900 underline underline-offset-4">Review</h3>
            <div class="flex py-4">
                <div class="imageaaa flex items-center py-2 mr-4">
                  <img class="h-10 w-10 rounded-lg" src="Images/WorldviewGrandHotel.jpg" alt=""/>
                </div>
                <div class="flex flex-col">
                    <p class="font-semibold text-lg leading-8 text-indigo-600">Worldview Grand Hotel</p>
                    <p class="text-slate-500">29-35, Jalan 10/23a, Medan Makmur, 53300 Kuala Lumpur, Wilayah Persekutuan Kuala Lumpur</p>
                </div>
            </div>
            <div class="flex items-center space-x-5 mb-4 rating">
                <span class="mr-2">Property Quality: </span>
                <asp:RadioButtonList ID="RadioButtonList1" runat="server" RepeatDirection="Horizontal" Width="39px" AutoPostBack="True">
                    <asp:ListItem Value="1"><span>1</span></asp:ListItem>
                    <asp:ListItem Value="2"><span>2</span></asp:ListItem>
                    <asp:ListItem Value="3"><span>3</span></asp:ListItem>
                    <asp:ListItem Value="4"><span>4</span></asp:ListItem>
                    <asp:ListItem Value="5" Selected="True"><span>5</span></asp:ListItem>
                </asp:RadioButtonList>
            </div>
            <div class="sm:border-t sm:border-gray-200">
                <div class="mt-1 sm:mt-0">
                    <asp:TextBox 
                        ID="reviewTxtbx" 
                        runat="server" 
                        CssClass="py-2 px-3 block w-full border-gray-300 shadow-sm text-md rounded-lg focus:border-indigo-500 focus:ring-indigo-500" Height="100px"></asp:TextBox>
                </div>
            </div>
            <div class="pt-4">
                <asp:Button 
                    ID="btnCleanliness" 
                    runat="server" 
                    Text="Cleanliness" 
                    CssClass="toggle-button py-2 px-4 mr-4 border border-slate-300 rounded-2xl bg-slate-300 text-slate-500 cursor-pointer" 
                    OnClick="RatingButton_Click" 
                />
                <asp:Button 
                    ID="btnService" 
                    runat="server" 
                    Text="Service" 
                    CssClass="toggle-button py-2 px-4 mr-4 border border-slate-300 rounded-2xl bg-slate-300 text-slate-500 cursor-pointer" 
                    OnClick="RatingButton_Click" 
                />
                <asp:Button 
                    ID="btnComfort" 
                    runat="server" 
                    Text="Comfort" 
                    CssClass="toggle-button py-2 px-4 mr-4 border border-slate-300 rounded-2xl bg-slate-300 text-slate-500 cursor-pointer" 
                    OnClick="RatingButton_Click" 
                />
                <asp:Button 
                    ID="btnCondition" 
                    runat="server" 
                    Text="Condition" 
                    CssClass="toggle-button py-2 px-4 mr-4 border border-slate-300 rounded-2xl bg-slate-300 text-slate-500 cursor-pointer" 
                    OnClick="RatingButton_Click" 
                />
                <asp:Button 
                    ID="btnAmenities" 
                    runat="server" 
                    Text="Amenities" 
                    CssClass="toggle-button py-2 px-4 mr-4 border border-slate-300 rounded-2xl bg-slate-300 text-slate-500 cursor-pointer" 
                    OnClick="RatingButton_Click" 
                />
                <asp:Button 
                    ID="btnLocation" 
                    runat="server" 
                    Text="Location" 
                    CssClass="toggle-button py-2 px-4 mr-4 border border-slate-300 rounded-2xl bg-slate-300 text-slate-500 cursor-pointer" 
                    OnClick="RatingButton_Click" 
                />
            </div>
            <%-- Submit and Cancel Button --%>
            <div class="pt-5">
                <div class="flex justify-end">
                    <asp:Button 
                        ID="btnSubmit" 
                        runat="server" 
                        Text="Submit" 
                        CssClass="ml-3 inline-flex justify-center py-2 px-4 border border-transparent shadow-sm text-sm font-medium rounded-md text-white bg-indigo-600 hover:bg-indigo-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-indigo-500" 
                        OnClick="btnSubmit_Click" 
                    />
                    <asp:Button 
                        ID="btnCancel" 
                        runat="server" 
                        Text="Cancel" 
                        CssClass="ml-3 bg-white py-2 px-4 border border-gray-300 rounded-md shadow-sm text-sm font-medium text-gray-700 hover:bg-gray-50 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-indigo-500" 
                        OnClick="btnCancel_Click" 
                    />
                    <asp:Panel ID="thanksModal" runat="server" CssClass="hidden fixed z-10 inset-0 overflow-y-auto">
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
                                                    Thanks for your review!
                                                </h3>
                                                <div class="mt-2">
                                                    <p class="text-sm text-gray-500 text-center">
                                                        Your review has been submitted successfully.
                                                    </p>
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
