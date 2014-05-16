package 
{
	import flash.display.Shape;
	import flash.display.Stage;
	import flash.geom.Point;
	import flash.events.MouseEvent;
	import flash.display.Sprite;
	import fl.controls.Label;

	public class GraphPlotter
	{
		var graphsArray:Array;
		var stage:Stage;
		var tangent:Shape;

		public function GraphPlotter(stage:Stage)
		{
			graphsArray = new Array();
			this.stage = stage;
		}

		public function DrawGraph(pointsInPixelArray:Array):void
		{
			var graph:Sprite;
			var colour:uint = Math.random() * 0xFFFFFF;
			for (var i:int = 0; i < pointsInPixelArray.length; i++)
			{
				if ((i+1) < pointsInPixelArray.length)
				{
					var line:Line = new Line(pointsInPixelArray[i],pointsInPixelArray[i + 1]);
					graph = line.DrawLine(colour);

					graph.addEventListener(MouseEvent.MOUSE_OVER, DrawTangent);
					graph.addEventListener(MouseEvent.MOUSE_OUT, RemoveTangent);

					graphsArray.push(graph);
					stage.addChild(graph);
				}
			}
		}

		function DrawTangent(event:MouseEvent):void
		{
			var line:Line = event.target as Line;
			var pointTo:Point = line.pointTo;
			var pointFrom:Point = line.pointFrom;

			var diffX:Number = Math.abs((pointFrom.x - pointTo.x));
			var diffY:Number = Math.abs((pointFrom.y - pointTo.y));

			tangent = new Shape();
			tangent.graphics.lineStyle(2, 0x000000, 0.5);
			if (pointFrom.y > pointTo.y)
			{
				tangent.graphics.moveTo(pointFrom.x, pointFrom.y);
				tangent.graphics.lineTo(pointFrom.x - (diffX*30), pointFrom.y + (diffY*30));
				tangent.graphics.moveTo(pointFrom.x, pointFrom.y);
				tangent.graphics.lineTo(pointTo.x, pointTo.y);
				tangent.graphics.moveTo(pointTo.x, pointTo.y);
				tangent.graphics.lineTo(pointTo.x + (diffX*30), pointTo.y - (diffY*30));
			}
			else
			{
				tangent.graphics.moveTo(pointFrom.x, pointFrom.y);
				tangent.graphics.lineTo(pointFrom.x - (diffX*30), pointFrom.y - (diffY*30));
				tangent.graphics.moveTo(pointFrom.x, pointFrom.y);
				tangent.graphics.lineTo(pointTo.x, pointTo.y);
				tangent.graphics.moveTo(pointTo.x, pointTo.y);
				tangent.graphics.lineTo(pointTo.x + (diffX*30), pointTo.y + (diffY*30));
			}
			stage.addChild(tangent);
		}

		public function RemoveTangent(event:MouseEvent)
		{
			stage.removeChild(tangent);
		}

		public function ClearGraphs():void
		{
			for (var i:int = 0; i<graphsArray.length; i++)
			{
				stage.removeChild(graphsArray[i]);
			}
			graphsArray.length = 0;
		}
	}

}