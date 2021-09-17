# AddRemoveSaUCE
Add or remove UCE files to/from your USB for AtGames Legends Ultimate Arcade

https://www.reddit.com/r/FansOfsaUCE/comments/nxo7oy/my_process_for_selecting_and_managing_a_curated/
https://www.reddit.com/r/FansOfsaUCE/comments/olhrwg/personal_coinopsx_build_download/

Let's say you just downloaded the v5 saUCE to your Downloads folder (and your name is Bob).
Your folder and files must look exactly like this -OR- you need to edit the script to match what you have:

C:\
├── Users
│   ├── Bob
│   │   ├── Downloads
│   │   │   ├── Coinops X Arcade Version 5 is Alive Saucey Edition
│   │   │   │   ├── 3 Player Build
│   │   │   │   ├── 4 Player Build
│   │   │   │   ├── Arcade
│   │   │   │   ├── content
│   │   │   │   ├── cox
│   │   │   │   ├── Daphne
│   │   │   │   └── Lightgun Build
│   │   │   ├── CoinopsX saUCEd ColecoVision Edition
│   │   │   │   ├── ColecoV
│   │   │   │   ├── cox
│   │   │   ├── Add or Remove saUCE.bat
│   │   │   ├── addlist.txt
│   │   │   └── removelist.txt

You only need to have addlist.txt and removelist.txt if you plan on using script options 2 and 5, respectively.


If you want to use options 3 or 6, then your USB drive needs to look like this (assuming it's mounted as your H: drive):

H:\
├── cox
│   ├── playlists
│   │   └── (at least one .txt file)


Don't forget to edit the saucepath line in the script. For the example above, it should be:
set saucepath=C:\Users\Bob\Downloads
