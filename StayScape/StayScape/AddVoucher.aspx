<%@ Page Title="" Language="C#" MasterPageFile="~/Main.Master" AutoEventWireup="true" CodeBehind="AddVoucher.aspx.cs" Inherits="StayScape.AddVoucher" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
    <script>
        function toggleLabels() {
            const labelValue = document.querySelector('#lbl-value');
            const labelPercentage = document.querySelector('#lbl-percentage');
            const svgValueCheckCircle = document.querySelector('#value-check-circle');
            const svgPercentageCheckCircle = document.querySelector('#percentage-check-circle');
            const discountRate = document.querySelector('#discount-rate');
            const discountValue = document.querySelector('#discount-value');
            const capAt = document.querySelector('#cap-at');
            const hdnDiscountType = document.getElementById("<%= hdnDiscountType.ClientID %>");

            // Check if svgValueCheckCircle is visible
            const isVisible = !svgValueCheckCircle.classList.contains('invisible');

            // Toggle visibility of labels
            if (isVisible) {
                // Percentage on
                svgValueCheckCircle.classList.add('invisible');
                labelValue.classList.remove('border-indigo-500', "ring-2", "ring-indigo-500");

                svgPercentageCheckCircle.classList.remove('invisible');
                labelPercentage.classList.add('border-indigo-500', "ring-2", "ring-indigo-500");

                // hidden discount value column
                discountValue.classList.add('hidden', "sm:hidden");

                // display disocunt rate column
                discountRate.classList.remove('hidden', "sm:hidden");

                // display cap at column
                capAt.classList.remove('hidden', "sm:hidden");

                hdnDiscountType.value = "Percentage Discount Off";

            } else {
                // Value on
                svgPercentageCheckCircle.classList.add('invisible');
                labelPercentage.classList.remove('border-indigo-500', "ring-2", "ring-indigo-500");

                svgValueCheckCircle.classList.remove('invisible');
                labelValue.classList.add('border-indigo-500', "ring-2", "ring-indigo-500");

                // hidden discount percentage column
                discountRate.classList.add('hidden', "sm:hidden");

                // hidden  cap at column
                capAt.classList.add('hidden', "sm:hidden");

                // display disoucnt value column
                discountValue.classList.remove('hidden', "sm:hidden");

                hdnDiscountType.value = "Money Value Off";
            }
        }

    </script>
    <div class="lg:mx-24 xl:mx-48 py-2">
        <div class="space-y-8 divide-y divide-gray-200 sm:space-y-5">
            <div>
                <div>
                    <h3 class="text-lg leading-6 font-medium text-gray-900">Voucher Information</h3>
                    <p class="mt-1 max-w-2xl text-sm text-red-500">* Indicates required field.</p>
                </div>

                <div class="mt-6 sm:mt-5 space-y-6 sm:space-y-5">
                    <%-- Voucher Name --%>
                    <div class="sm:grid sm:grid-cols-3 sm:gap-4 sm:items-start sm:border-t sm:border-gray-200 sm:pt-5">
                        <label for="username" class="block text-sm font-medium text-gray-700 sm:mt-px sm:pt-2">Voucher Name </label>
                        <div class="mt-1 sm:mt-0 sm:col-span-2">
                            <asp:TextBox
                                ID="txtVoucherName"
                                runat="server"
                                placeholder="Enter voucher name"
                                CssClass="py-2 px-3 block w-full border-gray-300 shadow-sm text-md rounded-lg focus:border-indigo-500 focus:ring-indigo-500">
                            </asp:TextBox>
                        </div>
                    </div>

                    <%-- Voucher Code --%>
                    <%--                    <div class="sm:grid sm:grid-cols-3 sm:gap-4 sm:items-start sm:border-t sm:border-gray-200 sm:pt-5">
                        <label for="username" class="block text-sm font-medium text-gray-700 sm:mt-px sm:pt-2">Voucher Code </label>
                        <div class="mt-1 sm:mt-0 sm:col-span-2">
                            <asp:TextBox
                                ID="txtVoucherCode"
                                runat="server"
                                placeholder="Enter voucher code"
                                CssClass="py-2 px-3 block w-full border-gray-300 shadow-sm text-md rounded-lg focus:border-indigo-500 focus:ring-indigo-500">
                            </asp:TextBox>
                        </div>
                    </div>--%>

                    <%-- Total Voucher to be Issued --%>
                    <div class="sm:grid sm:grid-cols-3 sm:gap-4 sm:items-start sm:border-t sm:border-gray-200 sm:pt-5">
                        <label for="username" class="block text-sm font-medium text-gray-700 sm:mt-px sm:pt-2">
                            Total Voucher to be Issued
                        </label>
                        <div class="mt-1 sm:mt-0 sm:col-span-2">
                            <asp:TextBox
                                ID="txtTotalVoucher"
                                runat="server"
                                TextMode="Number"
                                min="1"
                                placeholder="Enter Total Voucher"
                                CssClass="py-2 px-3 block w-full border-gray-300 shadow-sm text-md rounded-lg focus:border-indigo-500 focus:ring-indigo-500">
                            </asp:TextBox>
                        </div>
                    </div>

                    <%-- Redeem Limit Per Customer --%>
                    <div class="sm:grid sm:grid-cols-3 sm:gap-4 sm:items-start sm:border-t sm:border-gray-200 sm:pt-5">
                        <label for="username" class="block text-sm font-medium text-gray-700 sm:mt-px sm:pt-2">Redeem Limit Per Customer </label>
                        <div class="mt-1 sm:mt-0 sm:col-span-2">
                            <asp:TextBox
                                ID="txtRedeemLimit"
                                runat="server"
                                TextMode="Number"
                                min="1"
                                placeholder="Enter Redeem limit"
                                CssClass="py-2 px-3 block w-full border-gray-300 shadow-sm text-md rounded-lg focus:border-indigo-500 focus:ring-indigo-500">
                            </asp:TextBox>
                        </div>
                    </div>

                    <%-- Redeem Period --%>
                    <div class="sm:grid sm:grid-cols-3 sm:gap-4 sm:items-start sm:border-t sm:border-gray-200 sm:pt-5">
                        <label for="username" class="block text-sm font-medium text-gray-700 sm:mt-px sm:pt-2">Redeem Period </label>
                        <div class="mt-1 sm:mt-0 sm:col-span-2 flex justify-between">
                            <asp:TextBox
                                ID="txtStartDate"
                                runat="server"
                                TextMode="DateTimeLocal"
                                CssClass="w-2/5 py-2 px-3 block w-full border-gray-300 shadow-sm text-md rounded-lg focus:border-indigo-500 focus:ring-indigo-500">
                            </asp:TextBox>
                            <div class="text-3xl">
                                -
                            </div>
                            <asp:TextBox
                                ID="txtEndDate"
                                runat="server"
                                TextMode="DateTimeLocal"
                                CssClass="w-2/5 py-2 px-3 block w-full border-gray-300 shadow-sm text-md rounded-lg focus:border-indigo-500 focus:ring-indigo-500">
                            </asp:TextBox>
                        </div>
                    </div>

                    <%-- Apply To --%>
                    <%--                    <div class="sm:grid sm:grid-cols-3 sm:gap-4 sm:items-start sm:border-t sm:border-gray-200 sm:pt-5">
                        <label class="block text-sm font-medium text-gray-700 sm:mt-px sm:pt-2">Apply To</label>
                        <div class="mt-1 sm:mt-0 sm:col-span-2 sm:pt-2">
                            <asp:RadioButton ID="rbAll" runat="server" GroupName="ApplyToGroup" Text="&nbsp; &nbsp;All Properties" Checked="true" OnCheckedChanged="toggleDDLPanel_ValueChanged" AutoPostBack="True" />
                            <asp:RadioButton ID="rbSpecific" runat="server" GroupName="ApplyToGroup" Text="&nbsp; &nbsp;Specific Property" CssClass="pl-5" OnCheckedChanged="toggleDDLPanel_ValueChanged" AutoPostBack="True" />
                        </div>
                    </div>--%>
                    <%--                    <asp:Panel runat="server" ID="pnlHostProperty" Visible="false">
                        <div class="sm:grid sm:grid-cols-3 sm:gap-4 sm:items-start sm:border-t sm:border-gray-200 sm:pt-5">
                            <label class="block text-sm font-medium text-gray-700 sm:mt-px sm:pt-2">Select Property</label>
                            <div class="mt-1 sm:mt-0 sm:col-span-2 sm:pt-2">
                                <asp:DropDownList ID="ddlHostProperty" runat="server" CssClass="rounded-md border border-gray-300 focus:outline-none focus:border-indigo-500 focus:ring-indigo-500"></asp:DropDownList>
                            </div>
                        </div>
                    </asp:Panel>--%>

                    <asp:UpdatePanel ID="updatePanel" runat="server" UpdateMode="Conditional">
                        <ContentTemplate>
                            <div class="sm:grid sm:grid-cols-3 sm:gap-4 sm:items-start sm:border-t sm:border-gray-200 mb-5 sm:pt-5">
                                <label class="block text-sm font-medium text-gray-700 sm:mt-px sm:pt-2">Apply To</label>
                                <div class="mt-1 sm:mt-0 sm:col-span-2 sm:pt-2">
                                    <asp:RadioButton ID="rbAll" runat="server" GroupName="ApplyToGroup" Text="&nbsp; &nbsp;All Properties" Checked="true" OnCheckedChanged="toggleDDLPanel_ValueChanged" AutoPostBack="True" />
                                    <asp:RadioButton ID="rbSpecific" runat="server" GroupName="ApplyToGroup" Text="&nbsp; &nbsp;Specific Property" CssClass="pl-5" OnCheckedChanged="toggleDDLPanel_ValueChanged" AutoPostBack="True" />
                                </div>
                            </div>

                            <asp:Panel runat="server" ID="pnlHostProperty" Visible="false" CssClass="sm:grid sm:grid-cols-3 sm:gap-4 sm:items-start sm:border-t sm:border-gray-200 sm:pt-5">
                                <label class="block text-sm font-medium text-gray-700 sm:mt-px sm:pt-2">Select Property</label>
                                <div class="mt-1 sm:mt-0 sm:col-span-2 sm:pt-2">
                                    <asp:DropDownList ID="ddlHostProperty" runat="server" CssClass="rounded-md border border-gray-300 focus:outline-none focus:border-indigo-500 focus:ring-indigo-500"></asp:DropDownList>
                                </div>
                            </asp:Panel>
                        </ContentTemplate>
                        <Triggers>
                            <asp:AsyncPostBackTrigger ControlID="rbAll" EventName="CheckedChanged" />
                            <asp:AsyncPostBackTrigger ControlID="rbSpecific" EventName="CheckedChanged" />
                        </Triggers>
                    </asp:UpdatePanel>



                    <%-- Discount Type --%>
                    <div class="sm:border-t sm:border-gray-200 sm:pt-4">
                        <div class="mt-4 grid grid-cols-1 gap-y-6 sm:grid-cols-2 sm:gap-x-4">
                            <%-- Money Value Offf --%>
                            <label id="lbl-value" class="relative bg-white border rounded-lg shadow-sm p-4 flex cursor-pointer focus:outline-none border-indigo-500 ring-2 ring-indigo-500">
                                <input onclick="toggleLabels()" type="radio" name="project-type" value="Newsletter" class="sr-only" aria-labelledby="project-type-0-label" aria-describedby="project-type-0-description-0 project-type-0-description-1">
                                <div class="flex-1 flex">
                                    <div class="flex">
                                        <span id="project-type-0-label" class="block text-sm font-medium text-gray-900">Money Value Off</span>
                                    </div>
                                </div>
                                <svg id="value-check-circle" class="h-5 w-5 text-indigo-600" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 20 20" fill="currentColor" aria-hidden="true">
                                    <path fill-rule="evenodd" d="M10 18a8 8 0 100-16 8 8 0 000 16zm3.707-9.293a1 1 0 00-1.414-1.414L9 10.586 7.707 9.293a1 1 0 00-1.414 1.414l2 2a1 1 0 001.414 0l4-4z" clip-rule="evenodd" />
                                </svg>
                                <div class="absolute -inset-px rounded-lg border-2 pointer-events-none" aria-hidden="true"></div>
                            </label>
                            <%-- Percentage Discount Off --%>
                            <label id="lbl-percentage" class="relative bg-white border rounded-lg shadow-sm p-4 flex cursor-pointer focus:outline-none">
                                <input onclick="toggleLabels()" type="radio" name="project-type" value="Existing Customers" class="sr-only" aria-labelledby="project-type-1-label" aria-describedby="project-type-1-description-0 project-type-1-description-1">
                                <div class="flex-1 flex">
                                    <div class="flex flex-col">
                                        <span id="project-type-1-label" class="block text-sm font-medium text-gray-900">Percentage Discount Off</span>
                                    </div>
                                </div>
                                <svg id="percentage-check-circle" class="h-5 w-5 text-indigo-600 invisible" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 20 20" fill="currentColor" aria-hidden="true">
                                    <path fill-rule="evenodd" d="M10 18a8 8 0 100-16 8 8 0 000 16zm3.707-9.293a1 1 0 00-1.414-1.414L9 10.586 7.707 9.293a1 1 0 00-1.414 1.414l2 2a1 1 0 001.414 0l4-4z" clip-rule="evenodd" />
                                </svg>
                                <div class="absolute -inset-px rounded-lg border-2 pointer-events-none" aria-hidden="true"></div>
                            </label>
                        </div>
                    </div>
                    <asp:HiddenField ID="hdnDiscountType" runat="server" Value="Money Value Off" />


                    <%-- Min Spend --%>
                    <div class="sm:grid sm:grid-cols-3 sm:gap-4 sm:items-start sm:border-t sm:border-gray-200 sm:pt-5">
                        <label class="block text-sm font-medium text-gray-700 sm:mt-px sm:pt-2">If Order Min.Spend</label>
                        <div class="mt-1 sm:mt-0 sm:col-span-2">
                            <asp:TextBox
                                ID="txtMinSpend"
                                runat="server"
                                placeholder="Enter Min Spend"
                                CssClass="py-2 px-3 block w-full border border-gray-300 shadow-sm text-md rounded-lg focus:outline-none focus:border-indigo-500 focus:ring-indigo-500">
                            </asp:TextBox>
                        </div>
                    </div>

                    <%-- Discount Value --%>
                    <div id="discount-value" class="sm:grid sm:grid-cols-3 sm:gap-4 sm:items-start sm:border-t sm:border-gray-200 sm:pt-5">
                        <label for="username" class="block text-sm font-medium text-gray-700 sm:mt-px sm:pt-2">Discount Value (RM)</label>
                        <div class="mt-1 sm:mt-0 sm:col-span-2">
                            <asp:TextBox
                                ID="txtDiscountValue"
                                runat="server"
                                placeholder="Enter Discount Value (RM)"
                                CssClass="py-2 px-3 block w-full border border-gray-300 shadow-sm text-md rounded-lg focus:outline-none focus:border-indigo-500 focus:ring-indigo-500">
                            </asp:TextBox>
                        </div>
                    </div>

                    <%-- Discount Rate --%>
                    <div id="discount-rate" class="hidden sm:grid sm:grid-cols-3 sm:gap-4 sm:items-start sm:border-t sm:border-gray-200 sm:pt-5 sm:hidden">
                        <label for="username" class="block text-sm font-medium text-gray-700 sm:mt-px sm:pt-2">Discount Rate %</label>
                        <div class="mt-1 sm:mt-0 sm:col-span-2">
                            <asp:TextBox
                                ID="txtDiscountRate"
                                runat="server"
                                TextMode="Number"
                                min="1"
                                max="99"
                                placeholder="Enter Discount Rate"
                                CssClass="py-2 px-3 block w-full border border-gray-300 shadow-sm text-md rounded-lg focus:outline-none focus:border-indigo-500 focus:ring-indigo-500">
                            </asp:TextBox>
                        </div>
                    </div>

                    <%-- Cap At --%>
                    <div id="cap-at" class="hidden sm:grid sm:grid-cols-3 sm:gap-4 sm:items-start sm:border-t sm:border-gray-200 sm:pt-5 sm:hidden">
                        <label for="username" class="block text-sm font-medium text-gray-700 sm:mt-px sm:pt-2">Cap At (RM)</label>
                        <div class="mt-1 sm:mt-0 sm:col-span-2">
                            <asp:TextBox
                                ID="txtCapAt"
                                runat="server"
                                placeholder="Enter Cat At (RM)"
                                CssClass="py-2 px-3 block w-full border border-gray-300 shadow-sm text-md rounded-lg focus:outline-none focus:border-indigo-500 focus:ring-indigo-500">
                            </asp:TextBox>
                        </div>
                    </div>
                </div>
            </div>

            <%-- Submit and Cancel Button --%>
            <div class="pt-5">
                <div class="flex justify-end">
                    <asp:Button ID="btnCancel" OnClick="btnCancel_Click" runat="server" Text="Cancel" CssClass="bg-white py-2 px-4 border border-gray-300 rounded-md shadow-sm text-sm font-medium text-gray-700 hover:bg-gray-50 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-indigo-500" />
                    <asp:Button ID="btnSubmit" OnClick="btnSubmit_Click" runat="server" Text="Submit" CssClass="ml-3 inline-flex justify-center py-2 px-4 border border-transparent shadow-sm text-sm font-medium rounded-md text-white bg-indigo-600 hover:bg-indigo-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-indigo-500" />
                </div>
            </div>
        </div>
    </div>
</asp:Content>
