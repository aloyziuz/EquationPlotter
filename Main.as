package 
{
	import flash.display.MovieClip;
	import fl.controls.Label;
	import flash.text.TextFormat;
	import fl.controls.ComboBox;
	import flash.events.Event;
	import flash.text.TextFieldAutoSize;
	import fl.controls.TextInput;
	import flash.events.MouseEvent;
	import flash.display.Shape;
	import flash.geom.Point;
	import fl.controls.Slider;
	import fl.events.SliderEvent;

	public class Main extends MovieClip
	{
		var comboBox:ComboBox;
		var eqLbl,cValueLbl,warningLbl,intervalLbl:Label;
		var aValueTxt,bValueTxt,cValueTxt:TextInput;
		var intervalSlider:Slider;
		var intervalLabelArray:Array;
		var calculator:Calculator;
		var graphPlotter:GraphPlotter;
		var interval:int = 1;

		public function Main()
		{
			var min = -14 * interval;
			var max = 14 * interval;
			calculator = new Calculator(min,max,min,max);
			graphPlotter = new GraphPlotter(this.stage);

			//background
			var gridbg:Gridbg = new Gridbg();
			gridbg.x = 0;
			gridbg.y = 0;
			addChild(gridbg);

			var panelbg:Panelbg = new Panelbg();
			panelbg.x = 400;
			panelbg.y = 0;
			addChild(panelbg);

			//axis labels
			var xlbl1:Label = new Label();
			xlbl1.x = 0;
			xlbl1.y = 182;
			xlbl1.text = "x";
			addChild(xlbl1);

			var xlbl2:Label = new Label();
			xlbl2.x = 388;
			xlbl2.y = 182;
			xlbl2.text = "x";
			addChild(xlbl2);

			var ylbl1:Label = new Label();
			ylbl1.x = 188;
			ylbl1.y = 0;
			ylbl1.text = "y";
			addChild(ylbl1);

			var ylbl2:Label = new Label();
			ylbl2.x = 188;
			ylbl2.y = 380;
			ylbl2.text = "y";
			addChild(ylbl2);

			intervalLabelArray = CreateAndShowIntervalLabels(interval);

			comboBox = new ComboBox();
			comboBox.x = 450;
			comboBox.y = 10;
			comboBox.addItem({data:1, label:"Linear"});
			comboBox.addItem({data:2, label:"Quadratic"});
			comboBox.addEventListener(Event.CHANGE, OnComboBoxChange);
			addChild(comboBox);

			eqLbl = new Label();
			eqLbl.x = 430;
			eqLbl.y = 40;
			eqLbl.autoSize = TextFieldAutoSize.LEFT;
			eqLbl.htmlText = "<b><font size = '16'>y = ax+b</font></b>";
			addChild(eqLbl);

			//text input and label
			var aValueLbl:Label = new Label();
			aValueLbl.x = 430;
			aValueLbl.y = 70;
			aValueLbl.htmlText = "<font size = '14'>a = </font>";
			addChild(aValueLbl);

			aValueTxt = new TextInput();
			aValueTxt.name = "a";
			aValueTxt.x = 460;
			aValueTxt.y = 70;
			aValueTxt.text = "0";
			addChild(aValueTxt);

			var bValueLbl:Label = new Label();
			bValueLbl.x = 430;
			bValueLbl.y = 100;
			bValueLbl.htmlText = "<font size = '14'>b = </font>";
			addChild(bValueLbl);

			bValueTxt = new TextInput();
			bValueTxt.name = "b";
			bValueTxt.x = 460;
			bValueTxt.y = 100;
			bValueTxt.text = "0";
			addChild(bValueTxt);

			cValueLbl = new Label();
			cValueLbl.x = 430;
			cValueLbl.y = 130;
			cValueLbl.htmlText = "<font size ='14'>c = </font>";

			cValueTxt = new TextInput();
			cValueTxt.name = "c";
			cValueTxt.x = 460;
			cValueTxt.y = 130;
			cValueTxt.text = "0";

			warningLbl = new Label();
			warningLbl.x = 430;
			warningLbl.y = 160;
			warningLbl.setStyle("color", "0xFF0000");
			warningLbl.text = "";
			addChild(warningLbl);

			//buttons 
			var plotBtn:PlotBtn = new PlotBtn();
			plotBtn.x = 410;
			plotBtn.y = 200;
			addChild(plotBtn);
			plotBtn.addEventListener(MouseEvent.CLICK, OnPlotClick);

			var clearBtn:ClearBtn = new ClearBtn();
			clearBtn.x = 510;
			clearBtn.y = 200;
			addChild(clearBtn);
			clearBtn.addEventListener(MouseEvent.CLICK, OnClearClick);

			intervalLbl = new Label();
			intervalLbl.x = 450;
			intervalLbl.y = 260;
			intervalLbl.htmlText = "<b><font size='14'>Axis Interval: 1</font></b>";
			intervalLbl.autoSize = TextFieldAutoSize.LEFT;
			addChild(intervalLbl);

			intervalSlider = new Slider();
			intervalSlider.x = 455;
			intervalSlider.y = 300;
			intervalSlider.maximum = 10;
			intervalSlider.minimum = 1;
			intervalSlider.value = 1;
			intervalSlider.width = 100;
			intervalSlider.addEventListener(SliderEvent.THUMB_DRAG, OnSliderDrag);
			addChild(intervalSlider);

			var changeBtn:ChangeBtn = new ChangeBtn();
			changeBtn.x = 465;
			changeBtn.y = 330;
			changeBtn.addEventListener(MouseEvent.CLICK, OnChangeClick);
			addChild(changeBtn);

		}

		function OnComboBoxChange(event:Event):void
		{
			if (event.target.selectedItem.label == "Quadratic")
			{
				eqLbl.htmlText = "<b><font size = '16'>y = ax^2 + bx + c</font><,/b>";
				addChild(cValueLbl);
				addChild(cValueTxt);
			}
			else
			{
				eqLbl.htmlText = "<b><font size = '16'>y = ax+b</font></b>";
				removeChild(cValueLbl);
				removeChild(cValueTxt);
			}
		}

		function OnPlotClick(event:MouseEvent):void
		{
			var pixelPointsArray:Array;
			var pointsArray:Array;

			switch (comboBox.selectedItem.label)
			{
				case "Quadratic" :
					if (! isNaN(Number(aValueTxt.text)) && ! isNaN(Number(bValueTxt.text)) && ! isNaN(Number(cValueTxt.text)))
					{
						warningLbl.text = "";
						var a:Number = Number(aValueTxt.text);
						var b:Number = Number(bValueTxt.text);
						var c:Number = Number(cValueTxt.text);

						pointsArray = calculator.CalculateQuadraticEquation(a,b,c);
					}
					else
					{
						warningLbl.text = "Invalid Value(s)!";
					}
					break;
				case "Linear" :
					if (! isNaN(Number(aValueTxt.text)) && ! isNaN(Number(bValueTxt.text)))
					{
						warningLbl.text = "";
						var a:Number = Number(aValueTxt.text);
						var b:Number = Number(bValueTxt.text);

						pointsArray = calculator.CalculateLinearEquation(a,b);
					}
					else
					{
						warningLbl.text = "Invalid Value(s)!";
					}
					break;
			}
			pixelPointsArray = calculator.ConvertCartesianToPixel(pointsArray);
			graphPlotter.DrawGraph(pixelPointsArray);
		}

		function OnClearClick(event:MouseEvent):void
		{
			graphPlotter.ClearGraphs();
		}

		function OnSliderDrag(event:SliderEvent):void
		{
			intervalLbl.htmlText = "<b><font size='14'>Axis Interval: " + event.target.value + "</font></b>";
		}

		function OnChangeClick(event:MouseEvent):void
		{
			interval = intervalSlider.value;
			
			//clear old interval label and graph
			for(var i:int = 0; i < intervalLabelArray.length; i++){
				removeChild(intervalLabelArray[i]);
			}
			intervalLabelArray.length = 0;
			graphPlotter.ClearGraphs();
			
			var min = -14 * interval;
			var max = 14 * interval;
			calculator = new Calculator(min,max,min,max);
			intervalLabelArray = CreateAndShowIntervalLabels(interval);
		}

		function CreateAndShowIntervalLabels(interval:int):Array
		{
			var labelArray:Array = new Array();
			
			var xGraphLabelPoints:Array = new Array();
			var yGraphLabelPoints:Array = new Array();
			var offset:Number = 0.4;

			for (var x:int = -13*interval; x <= 13*interval; x+=interval)
			{
				xGraphLabelPoints.push(new Point((x-offset), 0));
			}
			for (var y:int = -13*interval; y <= 13*interval; y+=interval)
			{
				yGraphLabelPoints.push(new Point(0, (y+offset)));
			}

			var xGraphLabelPixelPoints:Array = calculator.ConvertCartesianToPixel(xGraphLabelPoints);
			var yGraphLabelPixelPoints:Array = calculator.ConvertCartesianToPixel(yGraphLabelPoints);

			var num:int = -13 * interval;
			for (var i:int=0; i<xGraphLabelPixelPoints.length; i++)
			{
				var numLbl:Label = new Label();
				numLbl.x = xGraphLabelPixelPoints[i].x;
				numLbl.y = xGraphLabelPixelPoints[i].y;
				numLbl.htmlText = "<font size='9'>" + num + "</font>";
				num +=  interval;
				labelArray.push(numLbl);
				addChild(numLbl);
			}
			
			num = -13 * interval;
			for (var i:int=0; i<yGraphLabelPixelPoints.length; i++)
			{
				if (i != 13)
				{
					var numLbl:Label = new Label();
					numLbl.x = yGraphLabelPixelPoints[i].x;
					numLbl.y = yGraphLabelPixelPoints[i].y;
					numLbl.htmlText = "<font size='9'>" + num + "</font>";
					labelArray.push(numLbl);
					addChild(numLbl);
				}
				num +=  interval;
			}
			return labelArray;
		}
	}
}