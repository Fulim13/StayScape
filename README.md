# StayScape
StayScape is a comprehensive property renting website designed to offer a seamless experience for both customers and hosts. Customers can browse through a wide variety of properties with detailed descriptions and high-quality images, get in-depth information about each property including amenities, location, and pricing, easily make reservations directly from the property details page, and enjoy a streamlined checkout process with support for voucher redemption. Additionally, customers can view a comprehensive history of their past reservations and share their experiences by leaving reviews on properties they have stayed at. For hosts, StayScape provides tools to access a detailed history of all reservations made on their properties, add, update, and delete property listings, create, update, and delete vouchers for customer redemption during checkout, engage with guests by replying to their reviews, and monitor all reviews left by guests. Hosts can also view a statistics page that offers an overview of their revenue, top customers, and top-performing properties.

Technologies Used
ASP.NET (C#), Tailwind CSS, MS SQL Server, Stripe API

# Demo
[Demo](Demo.pdf)

# Prerequisite
1. Node Installed https://nodejs.org/en/download/current
2. Visual Studio
3. Stripe API Key
<br/>

# Stripe API Key Setup
1. Setup a Stripe Developer Account
2. Get the test Publishable and Secret API key from the "API Keys" section
3. Create a .env file and put it on Web_Dev_Assignment/StayScape/StayScape
```
STRIPE_PUBLISHABLE_KEY=your_publishable_key
STRIPE_SECRET_KEY=your_secret_key
```

# How to Run Locally
1. git clone https://github.com/Fulim13/Web_Dev_Assignment.git
2. cd Web_Dev_Assignment
3. npm i
4. npm run build:css
5. Clean and Rebuild Solution in Visual Studio
6. Run the Program
7. If encounter error, you may consider to update the package
![error](error.png)
```
Update-Package Microsoft.CodeDom.Providers.DotNetCompilerPlatform -r
```
<br/>


# Test Data
### Customer (Email & Pwd)
```
Customer@gmail.com
W123.90a

Customer2@gmail.com
W123.90a

Customer3@gmail.com
W123.90a

Customer4@gmail.com
W123.90a

Customer5@gmail.com
W123.90a
```

### Host (Email & Pwd)
```
Host@gmail.com
W123.90a

Host2@gmail.com
W123.90a
```

### Card Payment
```
Card Number: 4242424242424242
Expire Date: 12/34
CVC: 111
```
For more information: https://docs.stripe.com/testing
<br />

# Deployment Information
[Documentation](https://learn.microsoft.com/en-us/azure/app-service/app-service-web-tutorial-dotnet-sqldatabase)

[Video](https://www.youtube.com/watch?v=TcghUb1NPCw)

# Extra Note on Tailwind CSS
CSS Builder
```
npm run build:css
```
Watch the CSS Update
```
npm run watch:css
```
