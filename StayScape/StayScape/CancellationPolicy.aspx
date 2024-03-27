<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="CancellationPolicy.aspx.cs" Inherits="StayScape.CancellationPolicy" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Cancellation Policy</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <link href="./dist/output.css" rel="stylesheet" />
</head>
<body class="bg-gray-100">
    <form id="form1" runat="server">
        <div class="max-w-4xl mx-auto px-4 py-8">
            <div class="bg-white rounded-lg shadow-md p-8">
                <div class="flex justify-end">
                    <asp:ImageButton ID="imgbtnClose" runat="server" ImageUrl="data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' fill='none' viewBox='0 0 24 24' stroke-width='1.5' stroke='currentColor' %3E%3Cpath stroke-linecap='round' stroke-linejoin='round' d='M6 18 18 6M6 6l12 12' /%3E%3C/svg%3E" CssClass="w-6 h-6" OnClick="imgbtnClose_Click" />
                </div>
                <div class="mb-8">
                    <h2 class="text-lg font-semibold mb-4">Cancellation Timeframe and Charges
                    </h2>
                    <ul class="list-disc pl-5">
                        <li>Cancellation within 24 hours of Booking: If you cancel your booking within 24 hours of making the reservation, you will receive a full refund.</li>
                        <li class="mt-2">Cancellation before Check-in Date:</li>
                        <ul class="list-disc pl-5">
                            <li>Cancellation made 7 or more days prior to the scheduled check-in date: No cancellation charges.</li>
                            <li class="mt-2">Cancellation made between 3 to 6 days prior to the scheduled check-in date: 50% of the total booking amount will be charged as cancellation fee.</li>
                            <li class="mt-2">Cancellation made within 48 hours of the scheduled check-in date: 100% of the total booking amount will be charged as cancellation fee.</li>
                        </ul>
                    </ul>
                </div>
                <div class="mb-8">
                    <h2 class="text-lg font-semibold mb-4">Refund Process</h2>
                    <p>Refunds for cancellations will be processed within 5-7 business days from the date of cancellation request.</p>
                    <p>Refunds will be issued to the original payment method used for booking.</p>
                </div>
                <div class="mb-8">
                    <h2 class="text-lg font-semibold mb-4">Modifications</h2>
                    <p>Modifications to booking dates or room types may be permitted subject to availability and applicable charges. Please contact us directly to make modifications to your booking.</p>
                </div>
                <div class="mb-8">
                    <h2 class="text-lg font-semibold mb-4">No-Show Policy</h2>
                    <p>If you fail to arrive on the scheduled check-in date without prior notice, the entire booking amount will be charged as a no-show fee.</p>
                </div>
                <div>
                    <h2 class="text-lg font-semibold mb-4">Contact Information</h2>
                    <p>For any inquiries or assistance regarding booking cancellations or modifications, please contact our customer support team at <a href="mailto:stayscape@gmail.com" class="text-blue-500">stayscape@gmail.com</a> or call us at <a href="tel:+60-1167389201" class="text-blue-500">+60-1167389201</a>.</p>
                </div>
            </div>
        </div>
    </form>
</body>
</html>
