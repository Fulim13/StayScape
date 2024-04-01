<%@ Page Language="C#" Inherits="StayScape.DesmondsPage.Login" %>

<!DOCTYPE html>
<html>
<head runat="server">
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <title>Login</title>
    <link href="./dist/output.css" rel="stylesheet" />

    <link rel="preconnect" href="https://fonts.googleapis.com">

    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin="anonymous">

    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@100;300;400;700;900&display=swap" rel="stylesheet">

    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@3.4.1/dist/css/bootstrap.min.css" integrity="sha384-HSMxcRTRxnN+Bdg0JdbxYKrThecOKuH5zCYotlSAcp1+c8xmyTe9GYg1l9a69psu" crossorigin="anonymous">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/slick-carousel/1.9.0/slick.css" />
</head>
<body>
    <form id="loginForm" runat="server">
        <div class="flex justify-center items-center">
            <div class="flex min-h-full flex-col justify-center px-6 py-12 lg:px-8 w-full">
                <div class="sm:mx-auto">
                    <h1 class="hero-title text-center mb-5">
                        <a href="property_list.aspx">
                            <img border="0" alt="" src="Images/house-transparent.png" width="200" height="200"></a></h1>
                    <h1 class="hero-title text-center mb-5">Sign In</h1>
                </div>

                <div class="mt-10 sm:mx-auto">
                    <asp:Panel runat="server" ID="pnlSignIn">
                        <div class="form-floating mb-4 p-0">
                            <label for="email" id="mailLabel">Email Address</label>
                            <asp:TextBox runat="server" ID="txtMail" CssClass="form-control" placeholder="Email address" Required="true"></asp:TextBox>
                        </div>
                        <div class="form-floating p-0">
                            <label for="password" id="pwdLabel">Password</label>
                            <asp:TextBox runat="server" ID="txtPassword" TextMode="Password" CssClass="form-control" placeholder="Password" Required="true"></asp:TextBox>
                        </div>
                        <br />
                        <div class="col text-center">
                            <asp:Button runat="server" ID="btnSignIn" Text="Sign in" CssClass="inline-flex justify-center py-4 px-8 border border-transparent shadow-sm text-2xl font-medium rounded-md text-white bg-indigo-600 hover:bg-indigo-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-indigo-500" OnClick="BtnSignIn_Click" />
                        </div>
                        <br />
                        <p class="text-center">Don’t have an account? Create One: <a href="Register.aspx">Customers</a>/<a href="HostRegister.aspx">Hosts</a></p>
                    </asp:Panel>
                </div>
            </div>

        </div>
    </form>
</body>
</html>
