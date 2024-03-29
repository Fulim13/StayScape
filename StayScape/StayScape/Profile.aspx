<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Profile.aspx.cs" Inherits="StayScape.Profile" %>

<!DOCTYPE html>
<html>
<head runat="server">
    <meta charset="utf-8">
    <title>Profile</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@4.4.1/dist/css/bootstrap.min.css" rel="stylesheet">
        
    <style type="text/css">
        body{
            margin-top:20px;
            color: #1a202c;
            text-align: left;
            background-color: #e2e8f0;    
        }
        .main-body {
            padding: 15px;
        }
        .card {
            box-shadow: 0 1px 3px 0 rgba(0,0,0,.1), 0 1px 2px 0 rgba(0,0,0,.06);
        }

        .card {
            position: relative;
            display: flex;
            flex-direction: column;
            min-width: 0;
            word-wrap: break-word;
            background-color: #fff;
            background-clip: border-box;
            border: 0 solid rgba(0,0,0,.125);
            border-radius: .25rem;
        }

        .card-body {
            flex: 1 1 auto;
            min-height: 1px;
            padding: 1rem;
        }

        .gutters-sm {
            margin-right: -8px;
            margin-left: -8px;
        }

        .gutters-sm>.col, .gutters-sm>[class*=col-] {
            padding-right: 8px;
            padding-left: 8px;
        }
        .mb-3, .my-3 {
            margin-bottom: 1rem!important;
        }

        .bg-gray-300 {
            background-color: #e2e8f0;
        }
        .h-100 {
            height: 100%!important;
        }
        .shadow-none {
            box-shadow: none!important;
        }
        .no-border {
            border: 0;
            box-shadow: none;
        }
    </style>
</head>
<body>
	<form id="form1" runat="server">
        <div class="container">
        <div class="main-body">

        <div class="card mb-3">
        <div class="card-body">
            
        <div class="row">
        <div class="col-sm-5">
        <h4 class="mb-2">Profile Details - Customer</h4>
        </div>
        </div>
        <hr>

        <div class="row">
        <div class="col-sm-5">
            <img src="https://bootdey.com/img/Content/avatar/avatar7.png" alt="pfp" class="rounded-circle" width="150">
            <button class="btn btn-primary">Change Avatar</button>          
        </div>
        </div>
        <hr>

        <div class="row">
        <div class="col-sm-3">
        <h6 class="mb-0">Full Name</h6>
        </div>
        <div class="col-sm-9 text-secondary">
        <span id="editable1" class="editable" contenteditable="false">Kenneth Valdez</span>
        <button class="btn btn-light" onclick="toggleEditable('editable1'); return false;">&#128221;</button>
        </div>
        </div>
        <hr>

        <div class="row">
        <div class="col-sm-3">
        <h6 class="mb-0">Email</h6>
        </div>
        <div class="col-sm-9 text-secondary">
        <span id="editable2" class="editable" contenteditable="false">kennethVal12@gmail.com</span>
        <button class="btn btn-light" onclick="toggleEditable('editable2'); return false;">&#128221;</button>
        </div>
        </div>
        <hr>

        <div class="row">
        <div class="col-sm-3">
        <h6 class="mb-0">Phone Number</h6>
        </div>
        <div class="col-sm-9 text-secondary">
        <span id="editable3" class="editable" contenteditable="false">016-8765467</span>
        <button class="btn btn-light" onclick="toggleEditable('editable3'); return false;">&#128221;</button>
        </div>
        </div>
        <hr>

        <div class="row">
        <div class="col-sm-3">
        <h6 class="mb-0">Birth Date</h6>
        </div>
        <div class="col-sm-9 text-secondary">
        <input type="date" class="no-border" id="dateInput" value="1996-12-26" disabled>
        <button class="btn btn-light" onclick="toggleDateEditable(); return false;">&#128221;</button>
        </div>
        </div>
        <hr>

        <div class="row">
        <div class="col-sm-3">
        <h6 class="mb-0">Account Creation Date</h6>
        </div>
        <div class="col-sm-9 text-secondary">
        2024-03-26
        </div>
        </div>
        <hr>

        <div class="row">
        <div class="col-sm-3">
            <h6 class="mb-0">Gender</h6>
        </div>
        <div class="col-sm-9 text-secondary">
            <select id="dropdown" disabled>
                <option value="option1">Male</option>
                <option value="option2">Female</option>
            </select>
            <button class="btn btn-light" onclick="toggleDropdownEditable(); return false;">&#128221;</button>
        </div>
        
        <hr>
        <div class="col-sm-10">
            <button class="btn btn-primary">Change Password</button>
        </div>

        </div>
        </div>
        </div>
        </div>
        </div>  
	</form>
        
<script>
    function toggleEditable(fieldId) {
        var field = document.getElementById(fieldId);
        var isEditable = field.getAttribute('contenteditable') === 'true';
        field.setAttribute('contenteditable', !isEditable);
        if (!isEditable) {
            field.focus();
        }
    }

    function toggleDateEditable() {
        var dateInput = document.getElementById('dateInput');
        dateInput.disabled = !dateInput.disabled;
        if (!dateInput.disabled) {
            dateInput.focus();
        }
    }

    function toggleDropdownEditable() {
        var dropdown = document.getElementById('dropdown');
        dropdown.disabled = !dropdown.disabled;
        if (!dropdown.disabled) {
            dropdown.focus();
        }
    }
</script>
</body>
</html>
