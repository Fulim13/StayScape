<%@ Page Language="C#" Inherits="StayScape.DesmondsPage.Login" %>
<!DOCTYPE html>
<html>
<head runat="server">
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">    
        
	<title>Login</title>
        
    <link rel="preconnect" href="https://fonts.googleapis.com">

    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin="anonymous">

    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@100;300;400;700;900&display=swap" rel="stylesheet">

    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@3.4.1/dist/css/bootstrap.min.css" integrity="sha384-HSMxcRTRxnN+Bdg0JdbxYKrThecOKuH5zCYotlSAcp1+c8xmyTe9GYg1l9a69psu" crossorigin="anonymous">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/slick-carousel/1.9.0/slick.css"/>
</head>
<body>
	<form id="loginForm" runat="server">
        <main>

            <section class="sign-in-form section-padding">
                <div class="container">
                    <div class="row">

                        <div class="col-lg-8 mx-auto col-12">

                            <h1 class="hero-title text-center mb-5">
                        <a href="#">
                            <img border="0" alt="" src="Images/house-transparent.png" width="200" height="200"></a></h1>
                            <h1 class="hero-title text-center mb-5">Sign In</h1>

                            <div class="row">
                                <div class="col-lg-8 col-11 mx-auto">
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
                                        <asp:Button runat="server" ID="btnSignIn" Text="Sign in" CssClass="btn btn-primary" OnClick="BtnSignIn_Click" />
                                        <p class="text-center">Don’t have an account? <a href="Register.aspx">Create One</a></p>
                                    </asp:Panel>
                                </div>
                            </div>
                            
                        </div>

                    </div>
                </div>
            </section>

        </main>
    </form>

        <footer class="site-footer">
            <div class="container">
                <div class="row">

                    <div class="col-lg-3 col-10 me-auto mb-4">
                        <a href="#">
                            &nbsp;</a><p class="copyright-text text-muted mt-lg-5 mb-4 mb-lg-0">Copyright © 2024 <strong>StayScape</strong></p>
                    </div>

                </div>
            </div>
        </footer>
</body>
</html>
