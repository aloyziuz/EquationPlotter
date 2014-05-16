package 
{
	import flash.geom.Point;

	public class Calculator
	{
		var xRatio:Number;
		var yRatio:Number;
		var xMin:int;
		var xMax:int;
		var yMin:int;
		var yMax:int;

		public function Calculator(xMin:int, xMax:int, yMin:int, yMax:int)
		{
			this.xMin = xMin;
			this.xMax = xMax;
			this.yMin = yMin;
			this.yMax = yMax;
			xRatio = 400 / (Math.abs(xMin)+Math.abs(xMax));
			yRatio = 400 / (Math.abs(yMin)+Math.abs(yMax));
		}

		public function CalculateLinearEquation(a:Number, b:Number):Array
		{
			var pointArray:Array = new Array();
			for (var x:Number = xMin; x <= xMax; x+=0.1)
			{
				var y:Number = a * x + b;
				if (y <= yMax && y >= yMin)
				{
					var point:Point = new Point(x,y);
					pointArray.push(point);
				}
			}
			return pointArray;
		}

		public function CalculateQuadraticEquation(a:Number, b:Number, c:Number):Array
		{
			var pointArray:Array = new Array();
			for (var x:Number = xMin; x <= xMax; x+=0.1)
			{
				var y:Number = a * (Math.pow(x, 2)) + b*x + c;

				if (y <= yMax && y >= yMin)
				{
					var point:Point = new Point(x,y);
					pointArray.push(point);
				}
			}
			return pointArray;
		}

		public function ConvertCartesianToPixel(pointsArray:Array):Array
		{
			var pixelPointsArray:Array = new Array();

			for (var i:int = 0; i < pointsArray.length; i++)
			{
				var point:Point = pointsArray[i] as Point;
				var newX:Number = 200 + point.x * xRatio;
				var newY:Number = 200 - point.y * yRatio;
				pixelPointsArray.push(new Point(newX, newY));
			}

			return pixelPointsArray;
		}
	}
}