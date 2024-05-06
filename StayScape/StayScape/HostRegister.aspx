<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="HostRegister.aspx.cs" Inherits="StayScape.HostRegister" %>

<!DOCTYPE html>
<html>
<head runat="server">
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <title>Register</title>
    <link href="./dist/output.css" rel="stylesheet" />

    <link rel="preconnect" href="https://fonts.googleapis.com">

    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin="anonymous">

    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@100;300;400;700;900&display=swap" rel="stylesheet">

    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@3.4.1/dist/css/bootstrap.min.css" integrity="sha384-HSMxcRTRxnN+Bdg0JdbxYKrThecOKuH5zCYotlSAcp1+c8xmyTe9GYg1l9a69psu" crossorigin="anonymous">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/slick-carousel/1.9.0/slick.css" />
</head>
<body>
    <form id="registerForm" runat="server">
        <main class="flex flex-col justify-center items-center">

            <h1 class="hero-title text-center mb-5">
                <a href="#">
                    <img border="0" alt="" src="Images/house-transparent.png" width="200" height="200"></a>
            </h1>
            <asp:HiddenField ID="userIDSetup" runat="server" />

            <div class="flex min-h-full flex-col justify-center px-6 py-12 lg:px-8">
                <div class="sm:mx-auto w-3/5">
                    <h2 class="mt-10 text-center text-2xl font-bold leading-9 tracking-tight text-gray-900">Register - Host</h2>

                    <asp:Panel runat="server" ID="pnlRegister">
                        <div class="form-floating mb-4 p-0">
                            <label for="name">Full Name</label>
                            <asp:TextBox runat="server" ID="txtName" CssClass="form-control" placeholder="Full Name" Required="true"></asp:TextBox>
                        </div>

                        <div class="form-floating mb-4 p-0">
                            <label for="email">Email address</label>
                            <asp:TextBox runat="server" ID="txtEmail" TextMode="Email" CssClass="form-control" placeholder="Email address" Required="true"></asp:TextBox>

                            <asp:RegularExpressionValidator ID="EmailValidator" runat="server"
                                ControlToValidate="txtEmail"
                                ErrorMessage="Invalid email address"
                                ValidationExpression="^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$"
                                ValidationGroup="Registration" Font-Bold="True" ForeColor="Red"></asp:RegularExpressionValidator>
                        </div>

                        <div class="form-floating mb-4 p-0">
                            <label for="phone">Phone Number</label>
                            <asp:TextBox runat="server" ID="txtPhone" TextMode="Phone" CssClass="form-control" placeholder="Phone Number" Required="true"></asp:TextBox>

                            <asp:RegularExpressionValidator ID="PhoneNumberValidator" runat="server"
                                ControlToValidate="txtPhone"
                                ErrorMessage="Invalid Malaysian phone number"
                                ValidationExpression="^(01[0-46-9]-\d{7,8}|03-\d{7,8}|04-\d{7,8}|05-\d{7,8}|06-\d{7,8}|07-\d{7,8}|08-\d{7,8}|09-\d{7,8})$"
                                ValidationGroup="Registration" Font-Bold="True" ForeColor="Red"></asp:RegularExpressionValidator>
                        </div>

                        <div class="form-floating mb-4 p-0">
                            <label for="birthDate">Birth Date</label>
                            <asp:TextBox runat="server" ID="txtbDate" TextMode="Date" CssClass="form-control" placeholder="Birth Date" Required="true"></asp:TextBox>
                            <asp:RangeValidator ID="ageRangeValidator" runat="server"
                                ControlToValidate="txtbDate"
                                Type="Date"
                                MinimumValue="1900-01-01"
                                MaximumValue="2004-12-31"
                                ErrorMessage="You must be between 18 and 120 years old."
                                Display="Dynamic"
                                CssClass="text-danger"
                                ValidationGroup="Registration" Font-Bold="True" ForeColor="Red"></asp:RangeValidator>
                        </div>

                        <div class="form-floating mb-4 p-0">
                            <label for="gender">Gender</label>
                            <asp:DropDownList ID="genderDropdown" CssClass="form-control" runat="server" AppendDataBoundItems="true">
                                <asp:ListItem Text="-- Select Gender --" Value="" />
                                <asp:ListItem>Male</asp:ListItem>
                                <asp:ListItem>Female</asp:ListItem>
                            </asp:DropDownList>
                            <asp:RequiredFieldValidator ID="genderValidator" runat="server"
                                ControlToValidate="genderDropdown"
                                InitialValue=""
                                ErrorMessage="Please select a gender."
                                Display="Dynamic"
                                CssClass="text-danger"
                                ValidationGroup="Registration" Font-Bold="True" ForeColor="Red"></asp:RequiredFieldValidator>
                        </div>

                        <div class="form-floating p-0">
                            <label for="password">Password</label>
                            <asp:TextBox runat="server" ID="txtPassword" TextMode="Password" CssClass="form-control" placeholder="Password" Required="true"></asp:TextBox>

                            <asp:RegularExpressionValidator ID="PasswordValidator" runat="server"
                                ControlToValidate="txtPassword"
                                ErrorMessage="Password must be at least 8 characters long and contain at least one uppercase letter, one lowercase letter, one digit, and one special character"
                                ValidationExpression="^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[^\da-zA-Z]).{8,}$"
                                ValidationGroup="Registration" Font-Bold="True" ForeColor="Red"></asp:RegularExpressionValidator>
                        </div>

                        <div class="form-floating p-0">
                            <label for="passwordConfirm">Confirm Password</label>
                            <asp:TextBox runat="server" ID="txtPasswordConfirm" TextMode="Password" CssClass="form-control" placeholder="Confirm Password" Required="true"></asp:TextBox>

                            <asp:CompareValidator ID="PasswordCompareValidator" runat="server"
                                ControlToValidate="txtPasswordConfirm"
                                ControlToCompare="txtPassword"
                                ErrorMessage="Passwords do not match"
                                Display="Dynamic"
                                ValidationGroup="Registration" Font-Bold="True" ForeColor="Red"></asp:CompareValidator>
                        </div>

                        <br />

                        <div class="col text-center">
                            <asp:Button runat="server" ID="btnRegister" Text="Register" CssClass="inline-flex justify-center py-4 px-8 border border-transparent shadow-sm text-2xl font-medium rounded-md text-white bg-indigo-600 hover:bg-indigo-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-indigo-500" OnClick="BtnRegister_Click" ValidationGroup="Registration" />
                        </div>

                        <p class="text-center">Already have an account? <a href="Login.aspx">Sign In</a></p>
                    </asp:Panel>
                </div>
            </div>


        </main>
    </form>
</body>
</html>
