package com.soundstep.somacolor.wires {
	import com.soma.core.interfaces.ISequenceCommand;
	import com.soma.core.interfaces.IWire;
	import com.soma.core.wire.Wire;
	import com.soundstep.somacolor.controllers.commands.ColorCommand;
	import com.soundstep.somacolor.controllers.commands.MoveViewCommand;
	import com.soundstep.somacolor.controllers.events.ColorDataEvent;
	import com.soundstep.somacolor.controllers.events.ColorEvent;
	import com.soundstep.somacolor.controllers.events.MoveViewEvent;
	import com.soundstep.somacolor.controllers.events.TweenSequenceEvent;
	import com.soundstep.somacolor.models.ColorModel;
	import com.soundstep.somacolor.views.ColorReceiver;
	import com.soundstep.somacolor.views.ColorSelector;
	import com.soundstep.somacolor.views.ColorSquare;
	import com.soundstep.somacolor.vo.ColorVO;

	import flash.events.Event;
	import flash.geom.ColorTransform;

	/**
	 * <b>Author:</b> Romuald Quantin - <a href="http://www.soundstep.com/" target="_blank">www.soundstep.com</a><br />* <b>Class version:</b> 1.0<br />
	 * <b>Actionscript version:</b> 3.0<br />
	 * <b>Copyright:</b> 
	 * <br />
	 * <b>Date:</b> Sep 18, 2009<br />
	 * <b>Usage:</b>
	 * @example
	 * <listing version="3.0"></listing>
	 */
	
	public class ColorWire extends Wire implements IWire {

		//------------------------------------
		// private, protected properties
		//------------------------------------
		
		private var _lastSequencer:ISequenceCommand;
		
		//------------------------------------
		// public properties
		//------------------------------------
		
		public static const NAME:String = "Wire:ColorWire";
		public static const NAME_VIEW_RECEIVER:String = "View::ColorReceiver";
		public static const NAME_VIEW_SELECTOR:String = "View::ColorSelector";
		public static const NAME_VIEW_SQUARE:String = "View::ColorSquare";
		
		//------------------------------------
		// constructor
		//------------------------------------
		
		public function ColorWire() {
			super(NAME);
		}
		
		//
		// PRIVATE, PROTECTED
		//________________________________________________________________________________________________
		
		override public function initialize():void {
			// register commands
			addCommand(ColorDataEvent.LOAD, ColorCommand);
			addCommand(ColorDataEvent.UPDATED, ColorCommand);
			addCommand(ColorEvent.CHANGE_COLOR, ColorCommand);
			addCommand(MoveViewEvent.MOVE_VIEW, MoveViewCommand);
			// register views
			var receiver:ColorReceiver = addView(NAME_VIEW_RECEIVER, new ColorReceiver()) as ColorReceiver;
			stage.addChild(receiver);
			receiver.addEventListener(ColorReceiver.START_TWEEN_SEQUENCE_EVENT, startTweenSequenceHandler);
			var selector:ColorSelector = addView(NAME_VIEW_SELECTOR, new ColorSelector()) as ColorSelector;
			stage.addChild(selector);
			var square:ColorSquare = addView(NAME_VIEW_SQUARE, new ColorSquare()) as ColorSquare;
			square.x = 20;
			square.y = 300;
			stage.addChild(square);
			// register model
			addModel(ColorModel.NAME, new ColorModel()) as ColorModel;
		}
		
		private function startTweenSequenceHandler(e:Event):void {
			if (_lastSequencer != null) _lastSequencer.stop();
			dispatchEvent(new TweenSequenceEvent(TweenSequenceEvent.SEQUENCE));
			_lastSequencer = getLastSequencer();
		}
		
		override public function dispose():void {
			
		}
		
		// PUBLIC
		//________________________________________________________________________________________________
		
		public function updateReceiverColor(color:uint):void {
			receiver.graphics.clear();
			receiver.graphics.beginFill(color, .3);
			receiver.graphics.drawRect(0, 0, 500, 400);
			receiver.graphics.endFill();
		}
		
		public function updateSquareColor(color:uint):void {
			var ct:ColorTransform = new ColorTransform();
			ct.color = color;
			square.transform.colorTransform = ct;
		}
		
		public function loadColorData():void {
			var model:ColorModel = getModel(ColorModel.NAME) as ColorModel;
			model.loadData();
		}
		
		public function updateViews():void {
			selector.updateColors(getModel(ColorModel.NAME).data);
			updateReceiverColor(ColorVO(getModel(ColorModel.NAME).data).color1);
			updateSquareColor(ColorVO(getModel(ColorModel.NAME).data).color1);
		}
		
		public function get receiver():ColorReceiver {
			return getView(NAME_VIEW_RECEIVER) as ColorReceiver;
		}
		
		public function get selector():ColorSelector {
			return getView(NAME_VIEW_SELECTOR) as ColorSelector;
		}
		
		public function get square():ColorSquare {
			return getView(NAME_VIEW_SQUARE) as ColorSquare;
		}
		
	}
}