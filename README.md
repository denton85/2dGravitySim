**This is a simple 2D gravity sim. **

Use up and down arrows to zoom in and out, and left and right arrows to adjust the speed scale. Press Tab to switch the camera from star to star. If you want to play around with this, download the project and open with Godot 4.2, from there you can run in editor.

**Customizing the starting conditions:**

The "Main" Scene has some exported variables for the minimum and maximum starting velocities. Each star chooses a random direction already, so you can adjust these values to test different speeds. 

Each "Star" Scene has an exported variable custom_velocity boolean that can be toggled. This enables the other exported variables, where you can choose the Vector2 values X and Y (C X and C Y in the editor). There is also custom min and max velocities for the randomized starting speed. 

In the editor, you can drag in new star scenes or delete existing stars. You can move them around or adjust their masses. There is also a "black hole" scene that is unfinished, it acts like a star with huge mass that doesn't move at all. It may be removed later.
