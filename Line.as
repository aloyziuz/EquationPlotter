package 
{
	import flash.geom.Point;
	import flash.display.Shape;
	import flash.display.Sprite;

	public class Line extends Sprite
	{
		internal var pointFrom:Point;
		internal var pointTo:Point;

		public function Line(from:Point, to:Point)
		{
			super();
			pointFrom = from;
			pointTo = to;
		}

		public function DrawLine(colour:uint):Sprite
		{
			super.graphics.lineStyle(4, colour, 0.75);
			super.graphics.moveTo(pointFrom.x, pointFrom.y);
			super.graphics.lineTo(pointTo.x, pointTo.y);
			return this;
		}

	}

}