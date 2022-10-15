Project #1 

Uno Game

John Critchlow


Description:

This is a single player fully functional Uno Game where the user plays against three computers.

The app starts with a nice start screen menu with options to view the high score or jump into the game. This is used with custom Navigation Links. 

The player is met with the game screen with the cards of the other players face down and the player's face up. All the cards are shuffled and dealt at the launch of the view.

All the cards have a random tilt degree assigned to show roughness of an actual card game.

The play starts with the users turn shown by a blue highlight around his cards for easy user experience. The play can tap to play a card or click the card pile to draw.

Once a move is decided, the computer AI begins. 

All the animations have a calculated offset to bring the card into the middle of the view into the discard pile. Once an animation is finished, the next players animation is triggered. This is done with delays and dispatch queues.

I decided to include special cards which all have different purposes like skips and reverses. When a special card is played text is shown. Wild cards bring up a color picker menu where the user selects the color. Play direction is shown by the arrows in a circle near the top. This changes when play is reversed for UX. 

When a player finishes their cards, a winner screen is brought up to show the winner and a button to start a new game.

If the user wins, their high score will be scored. Score is handles by how many cards and special cards are left in the opponent's hands. 


What I did well:

This is a really polished game and everything works and flows together very nicely. The animations work well even with multiple going on at the same time to the same views. The transitions took many algorithms to work out correctly to have everything offset to the right positions. The game is challenging and fun and the user experience is easy and enjoyable. So much math is needed to make everything fit together. It's very seamless and the communication is nice between the model, model view, and view. Doing my own project has really pushed me to learn so much more than I've been taught I struggled in so many spots but through hundreds of hours I was able to figure most of everything out and create something I am proud of.


What I didn't do well and bugs:

Since the positions of the cards change so often and calculations need to run to adjust the offset to the discard pile. On the first turn, the positions aren't perfect, but they correct themselves after. Also when the same player goes twice before the user can go the offsets get slightly off. Once the user goes, they are corrected again.
With a little more time I can polish just about everything that the app still needs.



This project was so fun and pushed my perspective limits. I grew so much and my coding abilities have been strengthened. I think I well deserve an A for the amount of coding and hours that went into the project. You can the amount of detail that went into each function and class. I fell in love with it and spent way more time including features I wanted than I should have haha. 