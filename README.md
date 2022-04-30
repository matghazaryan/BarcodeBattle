# Barcode Battle

To build barcode battle used the followings.

* Swift
* SwiftUI
* Swift Package Manager




## Libraries
* CodeScanner https://github.com/twostraws/CodeScanner
* LoadingButton https://github.com/Changemin/LoadingButton

The game contains very simple logic. No Additional architecture was applied for this project.

Here are the rules on how to test.

1. Open the application
2. Type the name and press start. 
3. On the next screen warrior should scan a QR code. Press Scan QR code. 
4. Find a QR code to scan in here. If you can't find just open any free QR generator and as a text type **"1"**
5. Next step is the same, generate a QR code and type the text like "**2"**
6. Warrior and Monster are ready to fight.
7. Press the Attack button 
8. There is very dummy logic that calculates to winner (doesn't matter for now)
9. Repeat all the above steps until one of the players will rich 1 life. 
10. If one of the players has 1 life the player can gain the additional life by scanning a QR code.
11. Generate QR code by typing the text **"3"**. 
12. Scan the QR code and the life will be gained by one of the players. 
13. Keep playing until one of the player's life will reaches to 0.
14. If one of the player's life is 0. The game is over.

Here is the generated QR code

for 1 value -> Warrior please scan this one

![qr-code (1)](https://user-images.githubusercontent.com/5268958/166117902-643c533a-bce0-4351-94b7-0ca0285b6899.png)

for 2 value -> Monster please scan this one

![qr-code (2)](https://user-images.githubusercontent.com/5268958/166117915-66751c86-c879-4d9c-ae53-2dc8911ac69e.png)

for 3 value -> Gain life please scan this one

![qr-code](https://user-images.githubusercontent.com/5268958/166117933-750de1e7-8e7c-4497-8d2b-d5e0ce95ddab.png)

Here are some screenshots


![merge_from_ofoct](https://user-images.githubusercontent.com/5268958/166117328-3ec75feb-6b86-4f31-ad38-5bc3420f8d36.jpg)
