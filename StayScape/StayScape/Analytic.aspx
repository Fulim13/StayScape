<%@ Page Title="" Language="C#" MasterPageFile="~/Main.Master" AutoEventWireup="true" CodeBehind="Analytic.aspx.cs" Inherits="StayScape.Report" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="mx-12">
        <h1 class="text-xl font-bold uppercase tracking-wide text-indigo-600 mb-8">Monthly Order Sales</h1>
        <div class="h-1/2 relative">
            <%--<button class="m-6 px-4 py-2 border border-transparent text-sm font-medium rounded-md shadow-sm text-white bg-indigo-600 hover:bg-indigo-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-indigo-500 absolute right-0">View More</button>--%>
            <canvas id="line-chart"></canvas>
        </div>
        <div class="flex justify-between mt-12">

            <div class="w-2/5 mt-12">
                <h1 class="text-xl font-bold uppercase tracking-wide text-indigo-600 mb-8">Distribution of Property Types</h1>
                <canvas id="pie-chart"></canvas>
            </div>

            <div class="w-1/2 mt-12">
                <h1 class="text-xl font-bold uppercase tracking-wide text-indigo-600 mb-8">Top Customers by Sales</h1>
                <canvas id="bar-chart"></canvas>
            </div>
        </div>
    </div>
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/luxon@3.4.4/build/global/luxon.min.js"></script>

    <script>
        // Function to generate month labels using Luxon
        function generateMonthLabels() {
            const months = [];
            for (let i = 1; i <= 12; i++) { // Generate labels for 7 months
                const monthName = luxon.DateTime.local(2000, i, 1).toFormat('LLLL');
                months.push(monthName);
            }
            return months;
        }

        // Call the function to generate labels
        const labels = generateMonthLabels();

        // Data for the chart
        const data = {
            labels: labels,
            datasets: [{
                label: 'Order Sales',
                data: [65, 59, 80, 81, 56, 55, 40, 100, 200, 300, 400, 80],
                fill: false,
                borderColor: 'rgb(75, 192, 192)',
                tension: 0.1
            }]
        };

        // Get the canvas element
        const ctx = document.getElementById('line-chart').getContext('2d');

        // Create the line chart
        new Chart(ctx, {
            type: 'line',
            data: data,
            options: {
                animations: {
                    tension: {
                        duration: 1000,
                        easing: 'easeInQuad',
                        from: 1,
                        to: 0,
                    }
                },
            }
        });

        // Pie chart
        const pieCtx = document.getElementById('pie-chart').getContext('2d');

        const data1 = {
            labels: [
                'Single-Family Home',
                'Townhouse',
                'Condo'
            ],
            datasets: [{
                label: 'Property Category Sales',
                data: [300, 50, 100],
                backgroundColor: [
                    'rgb(255, 99, 132)',
                    'rgb(54, 162, 235)',
                    'rgb(255, 205, 86)'
                ],
                hoverOffset: 4
            }]
        };

        new Chart(pieCtx, {
            type: 'doughnut',
            data: data1,
        });



        const barCtx = document.getElementById('bar-chart').getContext('2d');

        const data2 = {
            labels: ["James", "Stephen", "Jordan", "Shaq", "Kobe"],
            datasets: [{
                label: 'Customer Sales',
                data: [100, 85, 77, 66, 43],
                backgroundColor: [
                    'rgba(255, 99, 132, 0.2)',
                    'rgba(255, 159, 64, 0.2)',
                    'rgba(255, 205, 86, 0.2)',
                    'rgba(75, 192, 192, 0.2)',
                    'rgba(54, 162, 235, 0.2)',
                ],
                borderColor: [
                    'rgb(255, 99, 132)',
                    'rgb(255, 159, 64)',
                    'rgb(255, 205, 86)',
                    'rgb(75, 192, 192)',
                    'rgb(54, 162, 235)',
                ],
                borderWidth: 1
            }]
        };

        new Chart(barCtx, {
            type: 'bar',
            data: data2,
        });
    </script>
</asp:Content>
