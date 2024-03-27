<%@ Page Title="" Language="C#" MasterPageFile="~/Main.Master" AutoEventWireup="true" CodeBehind="property_host_modify.aspx.cs" Inherits="StayScape.property_host_modify" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title></title>
</head>
<body>
        <div>
            <asp:ListView ID="ListView1" runat="server" DataKeyNames="propertyID" DataSourceID="SqlDataSource1" OnSelectedIndexChanged="ListView1_SelectedIndexChanged">
                <AlternatingItemTemplate>
                    <tr style="">
                        <td>
                            <asp:Button ID="EditButton" runat="server" CommandName="Edit" Text="Edit" />
                        </td>
                        <td>
                            <asp:Label ID="propertyIDLabel" runat="server" Text='<%# Eval("propertyID") %>' />
                        </td>
                        <td>
                            <asp:Label ID="propertyNameLabel" runat="server" Text='<%# Eval("propertyName") %>' />
                        </td>
                        <td>
                            <asp:Label ID="propertyPriceLabel" runat="server" Text='<%# Eval("propertyPrice") %>' />
                        </td>
                        <td>
                            <asp:Label ID="propertyDescLabel" runat="server" Text='<%# Eval("propertyDesc") %>' />
                        </td>
                        <td>
                            <asp:Label ID="propertyAddressLabel" runat="server" Text='<%# Eval("propertyAddress") %>' />
                        </td>
                        <td>
                            <asp:Label ID="totalBedroomLabel" runat="server" Text='<%# Eval("totalBedroom") %>' />
                        </td>
                        <td>
                            <asp:Label ID="totalBathroomLabel" runat="server" Text='<%# Eval("totalBathroom") %>' />
                        </td>
                        <td>
                            <asp:Label ID="createdAtLabel" runat="server" Text='<%# Eval("createdAt") %>' />
                        </td>
                        <td>
                            <asp:Label ID="lastUpdateLabel" runat="server" Text='<%# Eval("lastUpdate") %>' />
                        </td>
                        <td>
                            <asp:Label ID="categoryIDLabel" runat="server" Text='<%# Eval("categoryID") %>' />
                        </td>
                        <td>
                            <asp:Label ID="hostIDLabel" runat="server" Text='<%# Eval("hostID") %>' />
                        </td>
                    </tr>
                </AlternatingItemTemplate>
                <EditItemTemplate>
                    <tr style="">
                        <td>
                            <asp:Button ID="UpdateButton" runat="server" CommandName="Update" Text="Update" />
                            <asp:Button ID="CancelButton" runat="server" CommandName="Cancel" Text="Cancel" />
                        </td>
                        <td>
                            <asp:Label ID="propertyIDLabel1" runat="server" Text='<%# Eval("propertyID") %>' />
                        </td>
                        <td>
                            <asp:TextBox ID="propertyNameTextBox" runat="server" Text='<%# Bind("propertyName") %>' />
                        </td>
                        <td>
                            <asp:TextBox ID="propertyPriceTextBox" runat="server" Text='<%# Bind("propertyPrice") %>' />
                        </td>
                        <td>
                            <asp:TextBox ID="propertyDescTextBox" runat="server" Text='<%# Bind("propertyDesc") %>' />
                        </td>
                        <td>
                            <asp:TextBox ID="propertyAddressTextBox" runat="server" Text='<%# Bind("propertyAddress") %>' />
                        </td>
                        <td>
                            <asp:TextBox ID="totalBedroomTextBox" runat="server" Text='<%# Bind("totalBedroom") %>' />
                        </td>
                        <td>
                            <asp:TextBox ID="totalBathroomTextBox" runat="server" Text='<%# Bind("totalBathroom") %>' />
                        </td>
                        <td>
                            <asp:TextBox ID="createdAtTextBox" runat="server" Text='<%# Bind("createdAt") %>' />
                        </td>
                        <td>
                            <asp:TextBox ID="lastUpdateTextBox" runat="server" Text='<%# Bind("lastUpdate") %>' />
                        </td>
                        <td>
                            <asp:TextBox ID="categoryIDTextBox" runat="server" Text='<%# Bind("categoryID") %>' />
                        </td>
                        <td>
                            <asp:TextBox ID="hostIDTextBox" runat="server" Text='<%# Bind("hostID") %>' />
                        </td>
                    </tr>
                </EditItemTemplate>
                <EmptyDataTemplate>
                    <table runat="server" style="">
                        <tr>
                            <td>No data was returned.</td>
                        </tr>
                    </table>
                </EmptyDataTemplate>
                <InsertItemTemplate>
                    <tr style="">
                        <td>
                            <asp:Button ID="InsertButton" runat="server" CommandName="Insert" Text="Insert" />
                            <asp:Button ID="CancelButton" runat="server" CommandName="Cancel" Text="Clear" />
                        </td>
                        <td>
                            <asp:TextBox ID="propertyIDTextBox" runat="server" Text='<%# Bind("propertyID") %>' />
                        </td>
                        <td>
                            <asp:TextBox ID="propertyNameTextBox" runat="server" Text='<%# Bind("propertyName") %>' />
                        </td>
                        <td>
                            <asp:TextBox ID="propertyPriceTextBox" runat="server" Text='<%# Bind("propertyPrice") %>' />
                        </td>
                        <td>
                            <asp:TextBox ID="propertyDescTextBox" runat="server" Text='<%# Bind("propertyDesc") %>' />
                        </td>
                        <td>
                            <asp:TextBox ID="propertyAddressTextBox" runat="server" Text='<%# Bind("propertyAddress") %>' />
                        </td>
                        <td>
                            <asp:TextBox ID="totalBedroomTextBox" runat="server" Text='<%# Bind("totalBedroom") %>' />
                        </td>
                        <td>
                            <asp:TextBox ID="totalBathroomTextBox" runat="server" Text='<%# Bind("totalBathroom") %>' />
                        </td>
                        <td>
                            <asp:TextBox ID="createdAtTextBox" runat="server" Text='<%# Bind("createdAt") %>' />
                        </td>
                        <td>
                            <asp:TextBox ID="lastUpdateTextBox" runat="server" Text='<%# Bind("lastUpdate") %>' />
                        </td>
                        <td>
                            <asp:TextBox ID="categoryIDTextBox" runat="server" Text='<%# Bind("categoryID") %>' />
                        </td>
                        <td>
                            <asp:TextBox ID="hostIDTextBox" runat="server" Text='<%# Bind("hostID") %>' />
                        </td>
                    </tr>
                </InsertItemTemplate>
                <ItemTemplate>
                    <tr style="">
                        <td>
                            <asp:Button ID="EditButton" runat="server" CommandName="Edit" Text="Edit" />
                        </td>
                        <td>
                            <asp:Label ID="propertyIDLabel" runat="server" Text='<%# Eval("propertyID") %>' />
                        </td>
                        <td>
                            <asp:Label ID="propertyNameLabel" runat="server" Text='<%# Eval("propertyName") %>' />
                        </td>
                        <td>
                            <asp:Label ID="propertyPriceLabel" runat="server" Text='<%# Eval("propertyPrice") %>' />
                        </td>
                        <td>
                            <asp:Label ID="propertyDescLabel" runat="server" Text='<%# Eval("propertyDesc") %>' />
                        </td>
                        <td>
                            <asp:Label ID="propertyAddressLabel" runat="server" Text='<%# Eval("propertyAddress") %>' />
                        </td>
                        <td>
                            <asp:Label ID="totalBedroomLabel" runat="server" Text='<%# Eval("totalBedroom") %>' />
                        </td>
                        <td>
                            <asp:Label ID="totalBathroomLabel" runat="server" Text='<%# Eval("totalBathroom") %>' />
                        </td>
                        <td>
                            <asp:Label ID="createdAtLabel" runat="server" Text='<%# Eval("createdAt") %>' />
                        </td>
                        <td>
                            <asp:Label ID="lastUpdateLabel" runat="server" Text='<%# Eval("lastUpdate") %>' />
                        </td>
                        <td>
                            <asp:Label ID="categoryIDLabel" runat="server" Text='<%# Eval("categoryID") %>' />
                        </td>
                        <td>
                            <asp:Label ID="hostIDLabel" runat="server" Text='<%# Eval("hostID") %>' />
                        </td>
                    </tr>
                </ItemTemplate>
                <LayoutTemplate>
                    <table runat="server">
                        <tr runat="server">
                            <td runat="server">
                                <table id="itemPlaceholderContainer" runat="server" border="0" style="">
                                    <tr runat="server" style="">
                                        <th runat="server"></th>
                                        <th runat="server">propertyID</th>
                                        <th runat="server">propertyName</th>
                                        <th runat="server">propertyPrice</th>
                                        <th runat="server">propertyDesc</th>
                                        <th runat="server">propertyAddress</th>
                                        <th runat="server">totalBedroom</th>
                                        <th runat="server">totalBathroom</th>
                                        <th runat="server">createdAt</th>
                                        <th runat="server">lastUpdate</th>
                                        <th runat="server">categoryID</th>
                                        <th runat="server">hostID</th>
                                    </tr>
                                    <tr id="itemPlaceholder" runat="server">
                                    </tr>
                                </table>
                            </td>
                        </tr>
                        <tr runat="server">
                            <td runat="server" style="">
                                <asp:DataPager ID="DataPager1" runat="server">
                                    <Fields>
                                        <asp:NextPreviousPagerField ButtonType="Button" ShowFirstPageButton="True" ShowLastPageButton="True" />
                                    </Fields>
                                </asp:DataPager>
                            </td>
                        </tr>
                    </table>
                </LayoutTemplate>
                <SelectedItemTemplate>
                    <tr style="">
                        <td>
                            <asp:Button ID="EditButton" runat="server" CommandName="Edit" Text="Edit" />
                        </td>
                        <td>
                            <asp:Label ID="propertyIDLabel" runat="server" Text='<%# Eval("propertyID") %>' />
                        </td>
                        <td>
                            <asp:Label ID="propertyNameLabel" runat="server" Text='<%# Eval("propertyName") %>' />
                        </td>
                        <td>
                            <asp:Label ID="propertyPriceLabel" runat="server" Text='<%# Eval("propertyPrice") %>' />
                        </td>
                        <td>
                            <asp:Label ID="propertyDescLabel" runat="server" Text='<%# Eval("propertyDesc") %>' />
                        </td>
                        <td>
                            <asp:Label ID="propertyAddressLabel" runat="server" Text='<%# Eval("propertyAddress") %>' />
                        </td>
                        <td>
                            <asp:Label ID="totalBedroomLabel" runat="server" Text='<%# Eval("totalBedroom") %>' />
                        </td>
                        <td>
                            <asp:Label ID="totalBathroomLabel" runat="server" Text='<%# Eval("totalBathroom") %>' />
                        </td>
                        <td>
                            <asp:Label ID="createdAtLabel" runat="server" Text='<%# Eval("createdAt") %>' />
                        </td>
                        <td>
                            <asp:Label ID="lastUpdateLabel" runat="server" Text='<%# Eval("lastUpdate") %>' />
                        </td>
                        <td>
                            <asp:Label ID="categoryIDLabel" runat="server" Text='<%# Eval("categoryID") %>' />
                        </td>
                        <td>
                            <asp:Label ID="hostIDLabel" runat="server" Text='<%# Eval("hostID") %>' />
                        </td>
                    </tr>
                </SelectedItemTemplate>
            </asp:ListView>
            <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConflictDetection="CompareAllValues" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" DeleteCommand="DELETE FROM [Property] WHERE [propertyID] = @original_propertyID AND (([propertyName] = @original_propertyName) OR ([propertyName] IS NULL AND @original_propertyName IS NULL)) AND (([propertyPrice] = @original_propertyPrice) OR ([propertyPrice] IS NULL AND @original_propertyPrice IS NULL)) AND (([propertyDesc] = @original_propertyDesc) OR ([propertyDesc] IS NULL AND @original_propertyDesc IS NULL)) AND (([propertyAddress] = @original_propertyAddress) OR ([propertyAddress] IS NULL AND @original_propertyAddress IS NULL)) AND (([totalBedroom] = @original_totalBedroom) OR ([totalBedroom] IS NULL AND @original_totalBedroom IS NULL)) AND (([totalBathroom] = @original_totalBathroom) OR ([totalBathroom] IS NULL AND @original_totalBathroom IS NULL)) AND (([createdAt] = @original_createdAt) OR ([createdAt] IS NULL AND @original_createdAt IS NULL)) AND (([lastUpdate] = @original_lastUpdate) OR ([lastUpdate] IS NULL AND @original_lastUpdate IS NULL)) AND (([categoryID] = @original_categoryID) OR ([categoryID] IS NULL AND @original_categoryID IS NULL)) AND (([hostID] = @original_hostID) OR ([hostID] IS NULL AND @original_hostID IS NULL))" InsertCommand="INSERT INTO [Property] ([propertyID], [propertyName], [propertyPrice], [propertyDesc], [propertyAddress], [totalBedroom], [totalBathroom], [createdAt], [lastUpdate], [categoryID], [hostID]) VALUES (@propertyID, @propertyName, @propertyPrice, @propertyDesc, @propertyAddress, @totalBedroom, @totalBathroom, @createdAt, @lastUpdate, @categoryID, @hostID)" OldValuesParameterFormatString="original_{0}" SelectCommand="SELECT * FROM [Property]" UpdateCommand="UPDATE [Property] SET [propertyName] = @propertyName, [propertyPrice] = @propertyPrice, [propertyDesc] = @propertyDesc, [propertyAddress] = @propertyAddress, [totalBedroom] = @totalBedroom, [totalBathroom] = @totalBathroom, [createdAt] = @createdAt, [lastUpdate] = @lastUpdate, [categoryID] = @categoryID, [hostID] = @hostID WHERE [propertyID] = @original_propertyID AND (([propertyName] = @original_propertyName) OR ([propertyName] IS NULL AND @original_propertyName IS NULL)) AND (([propertyPrice] = @original_propertyPrice) OR ([propertyPrice] IS NULL AND @original_propertyPrice IS NULL)) AND (([propertyDesc] = @original_propertyDesc) OR ([propertyDesc] IS NULL AND @original_propertyDesc IS NULL)) AND (([propertyAddress] = @original_propertyAddress) OR ([propertyAddress] IS NULL AND @original_propertyAddress IS NULL)) AND (([totalBedroom] = @original_totalBedroom) OR ([totalBedroom] IS NULL AND @original_totalBedroom IS NULL)) AND (([totalBathroom] = @original_totalBathroom) OR ([totalBathroom] IS NULL AND @original_totalBathroom IS NULL)) AND (([createdAt] = @original_createdAt) OR ([createdAt] IS NULL AND @original_createdAt IS NULL)) AND (([lastUpdate] = @original_lastUpdate) OR ([lastUpdate] IS NULL AND @original_lastUpdate IS NULL)) AND (([categoryID] = @original_categoryID) OR ([categoryID] IS NULL AND @original_categoryID IS NULL)) AND (([hostID] = @original_hostID) OR ([hostID] IS NULL AND @original_hostID IS NULL))">
                <DeleteParameters>
                    <asp:Parameter Name="original_propertyID" Type="Int32" />
                    <asp:Parameter Name="original_propertyName" Type="String" />
                    <asp:Parameter Name="original_propertyPrice" Type="Decimal" />
                    <asp:Parameter Name="original_propertyDesc" Type="String" />
                    <asp:Parameter Name="original_propertyAddress" Type="String" />
                    <asp:Parameter Name="original_totalBedroom" Type="Int32" />
                    <asp:Parameter Name="original_totalBathroom" Type="Int32" />
                    <asp:Parameter Name="original_createdAt" Type="DateTime" />
                    <asp:Parameter Name="original_lastUpdate" Type="DateTime" />
                    <asp:Parameter Name="original_categoryID" Type="Int32" />
                    <asp:Parameter Name="original_hostID" Type="Int32" />
                </DeleteParameters>
                <InsertParameters>
                    <asp:Parameter Name="propertyID" Type="Int32" />
                    <asp:Parameter Name="propertyName" Type="String" />
                    <asp:Parameter Name="propertyPrice" Type="Decimal" />
                    <asp:Parameter Name="propertyDesc" Type="String" />
                    <asp:Parameter Name="propertyAddress" Type="String" />
                    <asp:Parameter Name="totalBedroom" Type="Int32" />
                    <asp:Parameter Name="totalBathroom" Type="Int32" />
                    <asp:Parameter Name="createdAt" Type="DateTime" />
                    <asp:Parameter Name="lastUpdate" Type="DateTime" />
                    <asp:Parameter Name="categoryID" Type="Int32" />
                    <asp:Parameter Name="hostID" Type="Int32" />
                </InsertParameters>
                <UpdateParameters>
                    <asp:Parameter Name="propertyName" Type="String" />
                    <asp:Parameter Name="propertyPrice" Type="Decimal" />
                    <asp:Parameter Name="propertyDesc" Type="String" />
                    <asp:Parameter Name="propertyAddress" Type="String" />
                    <asp:Parameter Name="totalBedroom" Type="Int32" />
                    <asp:Parameter Name="totalBathroom" Type="Int32" />
                    <asp:Parameter Name="createdAt" Type="DateTime" />
                    <asp:Parameter Name="lastUpdate" Type="DateTime" />
                    <asp:Parameter Name="categoryID" Type="Int32" />
                    <asp:Parameter Name="hostID" Type="Int32" />
                    <asp:Parameter Name="original_propertyID" Type="Int32" />
                    <asp:Parameter Name="original_propertyName" Type="String" />
                    <asp:Parameter Name="original_propertyPrice" Type="Decimal" />
                    <asp:Parameter Name="original_propertyDesc" Type="String" />
                    <asp:Parameter Name="original_propertyAddress" Type="String" />
                    <asp:Parameter Name="original_totalBedroom" Type="Int32" />
                    <asp:Parameter Name="original_totalBathroom" Type="Int32" />
                    <asp:Parameter Name="original_createdAt" Type="DateTime" />
                    <asp:Parameter Name="original_lastUpdate" Type="DateTime" />
                    <asp:Parameter Name="original_categoryID" Type="Int32" />
                    <asp:Parameter Name="original_hostID" Type="Int32" />
                </UpdateParameters>
            </asp:SqlDataSource>
        </div>
</body>
</html>

</asp:Content>

