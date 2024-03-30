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
</body>
</html>
