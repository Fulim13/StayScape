<%@ Page Title="" Language="C#" MasterPageFile="~/Main.Master" AutoEventWireup="true" CodeBehind="Report.aspx.cs" Inherits="StayScape.Report" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    
    <div class="bg-gray-100 w-50 relative">
        <button class="m-6 px-4 py-2 border border-transparent text-sm font-medium rounded-md shadow-sm text-white bg-indigo-600 hover:bg-indigo-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-indigo-500 absolute right-0">View More</button>
        <canvas id="line-chart"></canvas>
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
                label: 'My First Dataset',
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
    </script>
</asp:Content>
