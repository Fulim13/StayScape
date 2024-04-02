# For teacher to run our project
1. Unzip the folder
2. Open the StayScape.sin
3. Clean and Rebuild Solution in Visual Studio
4. Run the Program
5. If encounter error, you may consider to update the package
![error](error.png)
Go to Visual Studio Tools > Nuget Package Manager > Package Manager Console
```
Update-Package Microsoft.CodeDom.Providers.DotNetCompilerPlatform -r
```

6. Run the program, if the program start page is not property_list.aspx, set it as a start page

Testing data for customer
```
dongweijie@gmail.com
W123.90a
```

Testing data for card payment
```
4242424242424242
12/34
111
```

7. After Complete Customer side, go to Dashboard.aspx for Host side

Testing data for host
```
des@gmail.com
W123.90a
```


# For other developers
# Prerequisite
1. Node Installed https://nodejs.org/en/download/current
2. Visual Studio

# Step to run our project
1. Change directory to this project directory
2. Install dependency
```
npm i
```
2. Build tailwind css folder
```
npm run build:css
```
3. Clean and Rebuild Solution in Visual Studio
4. Run the Program
5. If encounter error, you may consider to update the package
![error](error.png)
```
Update-Package Microsoft.CodeDom.Providers.DotNetCompilerPlatform -r
```

# Test Data
### Customer
```
dongweijie@gmail.com
```
```
W123.90a
```

### Host
```
des@gmail.com
```
```
W123.90a
```

### Card Payment
Card Number
```
4242424242424242
```
Expire Date
```
12/34
```
CVC
```
111
```

Other Payment method no need

For more information: https://docs.stripe.com/testing
