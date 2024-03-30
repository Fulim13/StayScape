<%@ Page Title="" Language="C#" MasterPageFile="~/Customer.Master" AutoEventWireup="true" CodeBehind="Checkout.aspx.cs" Inherits="StayScape.Checkout" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <script src="https://js.stripe.com/v3/"></script>
    <div class="flex justify-center items-center">
        <div class="h-screen max-w-lg mx-auto grid grid-cols-1 gap-x-32 gap-y-16 lg:max-w-none lg:grid-cols-2">
            <div class="max-w-lg mx-auto px-4 pt-12 w-full">
                <div class="flex py-4 gap-5">
                    <img src="/Images/testing.jpg" width="200" class="rounded-lg" />
                    <div>
                        <h3 class="text-lg font-medium text-gray-900">Fu Lim's Building</h3>
                        <p class="text-sm text-gray-500">RM 200</p>
                        <p class="text-sm text-gray-500">1 night</p>
                        <p class="text-sm text-gray-500">From 22/12/2024 - 25/12/2024 </p>
                    </div>
                </div>

                <div>
                    <div>
                        <label for="discount-code" class="block text-sm font-medium text-gray-700">Discount code</label>
                        <div class="flex space-x-4 mt-1">
                            <input type="text" id="discount-code" name="discount-code" class="block w-full border-gray-300 rounded-md shadow-sm focus:ring-indigo-500 focus:border-indigo-500 sm:text-sm">
                            <button type="submit" class="w-1/3 bg-indigo-600 text-white text-sm font-medium rounded-md px-4 hover:bg-indigo-800 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-indigo-600">Apply</button>
                        </div>
                    </div>
                    <dl class="text-sm font-medium text-gray-500 mt-10 space-y-6">
                        <div class="flex justify-between">
                            <dt>Subtotal</dt>
                            <dd class="text-gray-900">$108.00</dd>
                        </div>
                        <div class="flex justify-between">
                            <dt class="flex">Discount
                    <span class="ml-2 rounded-full bg-gray-200 text-xs text-gray-600 py-0.5 px-2 tracking-wide">CHEAPSKATE</span>
                            </dt>
                            <dd class="text-gray-900">-$16.00</dd>
                        </div>
                        <div class="flex justify-between">
                            <dt>Taxes</dt>
                            <dd class="text-gray-900">$9.92</dd>
                        </div>
                        <div class="flex justify-between">
                            <dt>Shipping</dt>
                            <dd class="text-gray-900">$8.00</dd>
                        </div>
                        <div class="flex items-center justify-between border-t border-gray-200 text-gray-900 pt-6">
                            <dt>Total</dt>
                            <dd class="text-base">$141.92</dd>
                        </div>
                    </dl>
                </div>
            </div>

            <!-- Display a payment form -->
            <div class="pt-20 w-full">
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

        // Set the payment amount in cents (adjust as needed)

        const paymentAmount = parseInt(parseFloat('<%= Session["reservationAmount"] %>') * 100);

        initialize();
        checkStatus();

        document
            .querySelector("#payment-form")
            .addEventListener("submit", handleSubmit);

        // Fetches a payment intent and captures the client secret
        async function initialize() {
            const response = await fetch("/CreatePaymentIntent.ashx", {
                method: "POST",
                headers: { "Content-Type": "application/json" },
                body: JSON.stringify({ amount: paymentAmount }), // Send only the payment amount
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
                    // Make sure to change this to your payment completion page
                    return_url: "https://localhost:44321/PaymentProcessing.aspx",
                },
            });

            // This point will only be reached if there is an immediate error when
            // confirming the payment. Otherwise, your customer will be redirected to
            // your `return_url`. For some payment methods like iDEAL, your customer will
            // be redirected to an intermediate site first to authorize the payment, then
            // redirected to the `return_url`.
            if (error.type === "card_error" || error.type === "validation_error") {
                showMessage(error.message);
            } else {
                showMessage("An unexpected error occurred.");
            }

            setLoading(false);
        }

        // Fetches the payment intent status after payment submission
        async function checkStatus() {
            const clientSecret = new URLSearchParams(window.location.search).get(
                "payment_intent_client_secret"
            );

            if (!clientSecret) {
                return;
            }

            const { paymentIntent } = await stripe.retrievePaymentIntent(clientSecret);

            switch (paymentIntent.status) {
                case "succeeded":
                    showMessage("Payment succeeded!");
                    break;
                case "processing":
                    showMessage("Your payment is processing.");
                    break;
                case "requires_payment_method":
                    showMessage("Your payment was not successful, please try again.");
                    break;
                default:
                    showMessage("Something went wrong.");
                    break;
            }
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
