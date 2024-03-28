<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="RoleManagement.aspx.cs" Inherits="C5.RoleManagement" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <style type="text/css">
        .auto-style1 {
            width: 81px;
        }
        .auto-style2 {
            width: 10px;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <table style="width:100%;">
                <tr>
                    <td class="auto-style1">Role</td>
                    <td class="auto-style2">:</td>
                    <td>
                        <asp:TextBox ID="txtRole" runat="server"></asp:TextBox>
                        <asp:Button ID="btnCreate" runat="server" OnClick="btnCreate_Click" Text="Create" />
                    </td>
                </tr>
                <tr>
                    <td class="auto-style1">&nbsp;</td>
                    <td class="auto-style2">&nbsp;</td>
                    <td>&nbsp;</td>
                </tr>
                <tr>
                    <td class="auto-style1">Display Role(s)<br />
                    </td>
                    <td class="auto-style2">:</td>
                    <td>
                        <asp:ListBox ID="lstRole" runat="server" AutoPostBack="True" OnSelectedIndexChanged="lstRole_SelectedIndexChanged"></asp:ListBox>
&nbsp;<asp:Button ID="btnRetrieve" runat="server" OnClick="btnRetrieve_Click" Text="Retrieve Role" />
                    </td>
                </tr>
                <tr>
                    <td class="auto-style1">&nbsp;</td>
                    <td class="auto-style2">&nbsp;</td>
                    <td>&nbsp;</td>
                </tr>
                <tr>
                    <td class="auto-style1">Display User(s)</td>
                    <td class="auto-style2">:</td>
                    <td>
                        <asp:ListBox ID="lstUser" runat="server" AutoPostBack="True" OnSelectedIndexChanged="lstUser_SelectedIndexChanged"></asp:ListBox>
&nbsp;<asp:Button ID="btnRetrieveU" runat="server" OnClick="btnRetrieveU_Click" Text="Retrieve User" />
                    </td>
                </tr>
                <tr>
                    <td class="auto-style1">&nbsp;</td>
                    <td class="auto-style2">&nbsp;</td>
                    <td>&nbsp;</td>
                </tr>
                <tr>
                    <td class="auto-style1">Assign user to Role</td>
                    <td class="auto-style2">:</td>
                    <td>&nbsp;<asp:TextBox ID="txtR" runat="server" BorderStyle="None"></asp:TextBox>
                        <asp:TextBox ID="txtU" runat="server"></asp:TextBox>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                        <asp:Button ID="btnAssign" runat="server" OnClick="btnAssign_Click" Text="Assign" />
                    </td>
                </tr>
                <tr>
                    <td class="auto-style1">&nbsp;</td>
                    <td class="auto-style2">&nbsp;</td>
                    <td>&nbsp;</td>
                </tr>
                <tr>
                    <td class="auto-style1">Display Users based on Role Selected</td>
                    <td class="auto-style2">:</td>
                    <td>
                        <asp:DropDownList ID="ddlRole" runat="server" AutoPostBack="True">
                        </asp:DropDownList>
&nbsp;&nbsp;
                        <asp:Button ID="btnGetRole" runat="server" OnClick="btnGetRole_Click" Text="Get Role" />
                    </td>
                </tr>
                <tr>
                    <td class="auto-style1">&nbsp;</td>
                    <td class="auto-style2">&nbsp;</td>
                    <td>&nbsp;</td>
                </tr>
                <tr>
                    <td class="auto-style1">&nbsp;</td>
                    <td class="auto-style2">&nbsp;</td>
                    <td>
                        <asp:ListBox ID="lstUR" runat="server"></asp:ListBox>
                        <asp:Button ID="btnDisplayU" runat="server" OnClick="btnDisplayU_Click" Text="Display User based on Role Selected" />
                    </td>
                </tr>
                <tr>
                    <td class="auto-style1">&nbsp;</td>
                    <td class="auto-style2">&nbsp;</td>
                    <td>&nbsp;</td>
                </tr>
                <tr>
                    <td class="auto-style1">&nbsp;</td>
                    <td class="auto-style2">&nbsp;</td>
                    <td>&nbsp;</td>
                </tr>
                <tr>
                    <td class="auto-style1">&nbsp;</td>
                    <td class="auto-style2">&nbsp;</td>
                    <td>&nbsp;</td>
                </tr>
                <tr>
                    <td class="auto-style1">&nbsp;</td>
                    <td class="auto-style2">&nbsp;</td>
                    <td>&nbsp;</td>
                </tr>
                <tr>
                    <td class="auto-style1">&nbsp;</td>
                    <td class="auto-style2">&nbsp;</td>
                    <td>&nbsp;</td>
                </tr>
            </table>
        </div>
    </form>
</body>
</html>
