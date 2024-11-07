
<img width="561" alt="Screenshot 2024-11-06 at 7 53 51 PM" src="https://github.com/user-attachments/assets/64ef056a-3db4-447a-8172-cefbdddcb9cb">

**This is a simple 2D gravity sim. Mess around with different starting conditions and see if stable orbits emerge.**

If you want to change between fullscreen and windowed without going into settings, just toggle the exported Fullscreen variable in the Main scene sidebar on the right.

Use up and down arrows to zoom in and out, and left and right arrows to adjust the speed scale. Press Tab to switch the camera from star to star. If you want to play around with this, download the project and open with Godot 4.2, from there you can run in editor.

**Customizing the starting conditions:**

The "Main" Scene has some exported variables for the minimum and maximum starting velocities. Each star chooses a random direction already, so you can adjust these values to test different speeds. 

Each "Star" Scene has an exported variable custom_velocity boolean that can be toggled. This enables the other exported variables, where you can change the Vector2 (C Dir) which will be the custom initial direction of travel. An indicator Line2D will appear (in the Main scene, editor only) to show the direction you have chosen for that specific star. There is also custom min and max velocities for the randomized starting speed. 

In the editor, you can drag in new star scenes or delete existing stars. You can move them around or adjust their masses. There is also a "black hole" scene that is unfinished, it acts like a star with huge mass that doesn't move at all. It may be removed later.

IN-GAME EDITING:

Work in progress, when you open the game you can now adjust the inital velocity and the mass before starting the sim. You can also add stars, although this isn't finished. Currently you have to use the hotkey "p" to place AFTER you've pressed the Add Star button. The star will be added where your cursor is. You can still adjust from within the editor. Randomness and direction will all be editable at some point from within the game.
