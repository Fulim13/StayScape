# Prerequisite
1. Node
2. Visual Studio

# Payment Test Data
Credit Card
1. Card Number :
```
4242 4242 4242 4242
```

2. Date: Use a valid future date
```
12/34
```

3. Use any three-digit CVC (four digits for American Express cards).

For more information: https://docs.stripe.com/testing

Other payment type, no need testing data


# Step to run our project
1. Install dependency
```
npm i
```
2. Build tailwind css folder
```
npm run build:css
```
3. Clean and Rebuild Solution in Visual Studio


Note: If encounter error, you may consider to update the package
```
Update-Package Microsoft.CodeDom.Providers.DotNetCompilerPlatform -r
```
