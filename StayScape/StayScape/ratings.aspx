<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ratings.aspx.cs" Inherits="StayScape.ratings" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <link rel="stylesheet" href="ratingsCSS.css" />
    <link href="~/Content/bootstrap.min.css" rel="stylesheet" />
    <script src="~/Scripts/bootstrap.bundle.min.js"></script>

</head>
<body>
    <form id="form1" runat="server">
        <div>
            <div class="container">
    <h2>Product Name</h2>
    <div class="row">
        <div class="col-md-6">
            <h4>Ratings</h4>
            <div class="ratings">
                <span class="star">&#9733;</span>
                <span class="star">&#9733;</span>
                <span class="star">&#9733;</span>
                <span class="star">&#9733;</span>
                <span class="star">&#9734;</span>
                <span class="rating-value">4.0</span>
            </div>
        </div>
        <div class="col-md-6">
            <h4>Reviews</h4>
            <ul class="list-group">
                <li class="list-group-item">Great product!</li>
                <li class="list-group-item">Fast shipping!</li>
                <li class="list-group-item">Good quality!</li>
            </ul>
        </div>
    </div>
</div>

        </div>
    </form>
</body>
</html>
