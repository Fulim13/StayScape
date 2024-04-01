<%@ Page Title="" Language="C#" MasterPageFile="~/Customer.Master" AutoEventWireup="true" CodeBehind="Checkout.aspx.cs" Inherits="StayScape.Checkout" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder2" runat="server">
    <script src="https://js.stripe.com/v3/"></script>
    <div class="flex">
        <div class="h-screen max-w-lg mx-auto grid grid-cols-1 gap-x-24 gap-y-16 content-between lg:max-w-none lg:grid-cols-2">
            <div class="max-w-lg mx-auto px-4 pt-12 w-full">
                <div class="flex py-4 gap-5">
                    <asp:Image ID="imgProperty" Width="200" class="rounded-lg" runat="server" />
                    <div>
                        <asp:Label ID="lblPropertyName" class="text-lg font-medium text-gray-900" runat="server" Text="Fu Lim's Building"></asp:Label>
                        <br />
                        <asp:Label ID="lblPropertyPrice" class="text-sm text-gray-500" runat="server" Text="RM 200"></asp:Label>
                        <br />
                        <asp:Label ID="lblDate" class="text-sm text-gray-500" runat="server" Text="22/12/2024 - 25/12/2024"></asp:Label>
                    </div>
                </div>
                <div>
                    <div>
                        <%-- Apply Discout Code --%>
                        <label for="discount-code" class="block text-sm font-medium text-gray-700">Discount code</label>
                        <div class="flex space-x-4 mt-1">
                            <input type="text" id="discount-code" name="discount-code" class="block w-full border-gray-300 rounded-md shadow-sm focus:ring-indigo-500 focus:border-indigo-500 sm:text-sm">
                            <button type="submit" class="w-1/3 bg-indigo-600 text-white text-sm font-medium rounded-md px-4 hover:bg-indigo-800 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-indigo-600">Apply</button>
                        </div>
                    </div>
                    <dl class="text-sm font-medium text-gray-500 mt-10 space-y-6">
                        <div class="flex justify-between">
                            <dt>Subtotal</dt>
                            <asp:Label ID="lblSubtotal" class="text-gray-900" runat="server" Text="RM 11"></asp:Label>
                        </div>
                        <div class="flex justify-between">
                            <dt class="flex">Discount
                                <asp:Label ID="lblVoucherCode" class="ml-2 rounded-full bg-gray-200 text-xs text-gray-600 py-0.5 px-2 tracking-wide" runat="server" Text="CHEAPPRICE"></asp:Label>
                            </dt>
                            <asp:Label ID="lblDiscount" class="text-gray-900" runat="server" Text="RM 0"></asp:Label>
                        </div>
                        <div class="flex items-center justify-between border-t border-gray-200 text-gray-900 pt-6">
                            <dt>Total</dt>
                            <asp:Label ID="lblTotal" class="text-base" runat="server" Text="RM 11"></asp:Label>
                        </div>
                    </dl>
                </div>
            </div>

            <!-- Display a payment form -->
            <div class="mt-16">
                <form id="payment-form">
                    <div id="payment-element">
                        <!--Stripe.js injects the Payment Element-->
                    </div>
                    <button id="submit" class="w-full mt-6 bg-indigo-600 border border-transparent rounded-md shadow-sm py-2 px-4 text-sm font-medium text-white hover:bg-indigo-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-indigo-500">
                        <div class="spinner hidden" id="spinner"></div>
                        <span id="button-text">Pay now</span>
                    </button>
                    <div id="payment-message" class="hidden"></div>
                </form>
            </div>
        </div>
    </div>
    <script>
        const stripe = Stripe("pk_test_51OzyRiLGo9hdPl3qZ6587wCFjVaBePXtzGkecdW0llSKBnmD6QaHRVFhQQ4Uh1uCb0fiiP8OIctEqAZmrHokG9fX00rbuIh65w");

        const paymentAmount = parseInt(parseFloat('<%= Session["reservationAmount"] %>') * 100);

        initialize();

        document
            .querySelector("#payment-form")
            .addEventListener("submit", handleSubmit);

        // Fetches a payment intent and captures the client secret
        async function initialize() {
            const response = await fetch("/CreatePaymentIntent.ashx", {
                method: "POST",
                headers: { "Content-Type": "application/json" },
                body: JSON.stringify({ amount: paymentAmount }),
            });
            const { clientSecret } = await response.json();

            const appearance = {
                theme: 'stripe',
            };

            elements = stripe.elements({ appearance, clientSecret });

            const paymentElementOptions = {
                layout: "tabs",
            };

            const paymentElement = elements.create("payment", paymentElementOptions);
            paymentElement.mount("#payment-element");
        }

        async function handleSubmit(e) {
            e.preventDefault();
            setLoading(true);

            const { error } = await stripe.confirmPayment({
                elements,
                confirmParams: {
                    return_url: "https://localhost:44321/PaymentProcessing.aspx",
                },
            });

            if (error.type === "card_error" || error.type === "validation_error") {
                showMessage(error.message);
            } else {
                showMessage("An unexpected error occurred.");
            }

            setLoading(false);
        }

        // ------- UI helpers -------
        function showMessage(messageText) {
            const messageContainer = document.querySelector("#payment-message");

            messageContainer.classList.remove("hidden");
            messageContainer.textContent = messageText;

            setTimeout(function () {
                messageContainer.classList.add("hidden");
                messageContainer.textContent = "";
            }, 4000);
        }

        // Show a spinner on payment submission
        function setLoading(isLoading) {
            if (isLoading) {
                // Disable the button and show a spinner
                document.querySelector("#submit").disabled = true;
                document.querySelector("#spinner").classList.remove("hidden");
                document.querySelector("#button-text").classList.add("hidden");
            } else {
                document.querySelector("#submit").disabled = false;
                document.querySelector("#spinner").classList.add("hidden");
                document.querySelector("#button-text").classList.remove("hidden");
            }
        }
    </script>
</asp:Content>

