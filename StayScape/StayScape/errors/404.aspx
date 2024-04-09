<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="404.aspx.cs" Inherits="StayScape.errors._404" %>

<!DOCTYPE html>

<html class="h-full">
<head runat="server">
    <title>404 Error</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <link href="../dist/output.css" rel="stylesheet" />
</head>
<body class="h-full">
    <form class="h-full" id="form1" runat="server">
        <div class="bg-white min-h-full px-4 py-16 sm:px-6 sm:py-24 md:grid md:place-items-center lg:px-8">
            <div class="max-w-max mx-auto">
                <main class="sm:flex">
                    <p class="text-4xl font-extrabold text-indigo-600 sm:text-5xl">404</p>
                    <div class="sm:ml-6">
                        <div class="sm:border-l sm:border-gray-200 sm:pl-6">
                            <h1 class="text-4xl font-extrabold text-gray-900 tracking-tight sm:text-5xl">Page not found</h1>
                            <p class="mt-1 text-base text-gray-500">Please check the URL in the address bar and try again.</p>
                        </div>
                        <div class="mt-10 flex space-x-3 sm:border-l sm:border-transparent sm:pl-6">
                            <asp:Button ID="btnBackHome" OnClick="btnBackHome_Click" class="inline-flex items-center px-4 py-2 border border-transparent text-sm font-medium rounded-md shadow-sm text-white bg-indigo-600 hover:bg-indigo-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-indigo-500" runat="server" Text="Go back home " /></div>
                    </div>
                </main>
            </div>
        </div>
    </form>
</body>
</html>
