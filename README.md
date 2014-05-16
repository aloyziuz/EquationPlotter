EquationPlotter
===============

Linear and quadratic equation graph plotter
Created in Adobe Flash CS5.5
Implemented completely using ActionScript 3.0

Line.as
Line class which extends from Sprite class
Contains starting point and ending point of a line
 - DrawLine
   - Param: uint of the line colour
   - Return: Sprite object
   - creates and returns Line object

GraphPlotter.as
Plot the graph of the equation by creating Line objects
 - DrawGraph
   - Param: Array containing coordinates in pixels
   - Return: Null
   - plotting the graph
 - DrawTangent
   - Param: MouseEvent
   - Return: Null
   - draw the tangent of the hovered line object
 - RemoveTangent
   - Param: MouseEvent
   - Return: Null
   - remove the drawn tangent on mouse out of the line object
 - ClearGraph
   - Param: Null
   - Return: Null
   - Clear all the graphs. Removes all Line objects on the stage
   
Calculator.as
Calculates and provide points for the GraphPlotter class
 - CalculateLinearEquation
   - Param: 2 Numbers
   - Return: Array of Point objects
   - calculate the linear equation and create points in cartesian coordinates
 - CalculateQuadraticEquation
   - Param: 3 Numbers
   - Return: Array of Point objects
   - calculate the quadratic equation and create points in cartesian coordinates
 - ConvertCartesianToPixel
   - Param: Array containing Point objects in cartesian coordinates
   - Return: Array containing Point objects in pixels coordinates
   - converts cartesian coordinates to pixel coordinates

Main.as
Initializes and control everything
