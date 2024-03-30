<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Checkout.aspx.cs" Inherits="StayScape.Checkout" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta charset="utf-8" />
    <title>Accept a payment</title>
    <meta name="description" content="A demo of a payment on Stripe" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <link rel="stylesheet" href="checkout.css" />
    <link href="./dist/output.css" rel="stylesheet" />
    <script src="https://js.stripe.com/v3/"></script>
    <script src="checkout.js" defer></script>
</head>
<body>
    <div class="max-w-lg mx-auto grid grid-cols-1 gap-x-32 content-between gap-y-16 lg:max-w-none lg:grid-cols-2">
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
                        <button type="submit" class="bg-indigo-600 text-white text-sm font-medium rounded-md px-4 hover:bg-indigo-800 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-indigo-600">Apply</button>
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

</body>
</html>
