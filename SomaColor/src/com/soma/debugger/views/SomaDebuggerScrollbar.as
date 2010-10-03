package com.soma.debugger.views {
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.text.TextField;

	/**
	 * <b>Author:</b> Romuald Quantin - <a href="http://www.soundstep.com/" target="_blank">www.soundstep.com</a><br />* <b>Class version:</b> 1.0<br />
	 * <b>Actionscript version:</b> 3.0<br />
	 * <b>Copyright:</b> 
	 * <br />
	 * <b>Date:</b> Sep 21, 2009<br />
	 * <b>Usage:</b>
	 * @example
	 * <listing version="3.0"></listing>
	 */
	
	public class SomaDebuggerScrollbar extends Sprite {

		//------------------------------------
		// private, protected properties
		//------------------------------------
		
		private var _textfield:TextField;
		
		private var _track:Sprite;
		private var _grip:Sprite;
		private var _dragBounds:Rectangle;
		private var _isDragging:Boolean;
		private var _isClicking:Boolean;
		private var _scrollAmount:Number;
		private var _scrollCount:Number;
		
		//------------------------------------
		// public properties
		//------------------------------------
		
		

		//------------------------------------
		// constructor
		//------------------------------------
		
		public function SomaDebuggerScrollbar(textfield:TextField) {
			_textfield = textfield;
			addEventListener(Event.ADDED_TO_STAGE, added, false, 0, true);
		}

		//
		// PRIVATE, PROTECTED
		//________________________________________________________________________________________________
		
		private function added(e:Event):void {
			removeEventListener(Event.ADDED_TO_STAGE, added, false);
			initialize();
		}
		
		private function initialize():void {
			stage.addEventListener(Event.MOUSE_LEAVE, stageLeavehandler);
			stage.addEventListener(MouseEvent.MOUSE_UP, mouseClean);
			_textfield.addEventListener(Event.SCROLL, scrollEventHandler);
			_scrollAmount = 4;
			_scrollCount = 0;
			_isDragging = false;
			_isClicking = false;
			createTrack();
			createScrollbar();
			updateLayout();
		}
		
		private function createTrack():void {
			_track = addChild(new Sprite) as Sprite;
			_track.addEventListener(MouseEvent.MOUSE_DOWN, trackClickHandler);			_track.addEventListener(MouseEvent.MOUSE_UP, trackClickHandler);			_track.addEventListener(MouseEvent.MOUSE_OUT, mouseClean);
			addChild(_track);
		}
		
		private function createScrollbar():void {
			_grip = new Sprite();
			_grip.visible = false;
			_grip.graphics.beginFill(0xFF0000, 0); 
			_grip.graphics.drawRect(0, 0, 3, 30);
			_grip.graphics.beginFill(0x363636); 
			_grip.graphics.drawRect(3, 0, 10, 30);
			_grip.graphics.beginFill(0xFF0000, 0); 
			_grip.graphics.drawRect(8, 0, 3, 30);
			_grip.graphics.endFill();
			addChild(_grip);
			_grip.buttonMode = true;
			_grip.mouseChildren = false;
			_grip.addEventListener(MouseEvent.MOUSE_DOWN, gripMouseDownHandler);
		}
		
		private function scrollEventHandler(e:Event):void {
			var percent:Number = (_textfield.scrollV-1) / (_textfield.maxScrollV-1);
			if (!_isDragging && !_isClicking) {
				_grip.y = _dragBounds.height * percent;
			}
			if (_textfield.textHeight > _textfield.height) _grip.visible = true;
		}
		
		private function trackClickHandler(e:MouseEvent):void {
			if (_textfield.textHeight < _textfield.height) return;
			switch (e.type) {
				case MouseEvent.MOUSE_DOWN:
					_isClicking = true;
					addEventListener(Event.ENTER_FRAME, scrollGripHandler);
					break;
				case MouseEvent.MOUSE_UP:
					_isClicking = false;
					removeScrollGripHandler();
					break;
			}
		}
		
		private function removeScrollGripHandler():void {
			removeEventListener(Event.ENTER_FRAME, scrollGripHandler);
			_scrollCount = 0;
			stopDragAndClean();
		}
		
		private function scrollGripHandler(e:Event):void {
			if (_scrollCount++ % _scrollAmount != 0) return;
			var point:Point = _grip.localToGlobal(new Point(_grip.mouseX, _grip.mouseY));
			if (_grip.hitTestPoint(point.x, point.y)) {
				removeScrollGripHandler();
				return;
			}
			var gripVal:Number = _grip.y + (_grip.height*.5);
			if (_track.mouseY > gripVal) {
				_grip.y += (_track.height / 10);
				if (_grip.y > _dragBounds.height) _grip.y = _dragBounds.height;
			}
			else {
				_grip.y -= (_track.height / 10);
				if (_grip.y < 0) _grip.y = 0;
			}
			moveHandler();
			if (_textfield.scrollV == 1 || _textfield.scrollV == _textfield.maxScrollV) {
				removeScrollGripHandler();
			}
		}

		private function updateLayout():void {
			_track.graphics.clear();
			_track.graphics.beginFill(0x9B9B9B); 
			_track.graphics.drawRect(0, 0, 10, _textfield.height);
			_track.graphics.endFill();
			x = _textfield.x + _textfield.width;
			y = _textfield.y;
			_grip.x = _track.x - 3;
			_grip.y = _track.y;
			_dragBounds = new Rectangle(_grip.x, _grip.y, 0, _track.height - _grip.height);
		}

		private function gripMouseDownHandler(e:MouseEvent):void {
			switch (e.type) {
				case MouseEvent.MOUSE_DOWN:
					addEventListener(Event.ENTER_FRAME, moveHandler);
					_isDragging = true;
					_grip.startDrag(false, _dragBounds);
					break;
			}
		}
		
		private function mouseClean(e:MouseEvent):void {
			stopDragAndClean();
		}

		private function stageLeavehandler(e:Event):void {
			stopDragAndClean();
		}

		private function stopDragAndClean():void {
			_isDragging = false;
			_isClicking = false;
			_grip.stopDrag();
			removeEventListener(Event.ENTER_FRAME, moveHandler);
			removeEventListener(Event.ENTER_FRAME, scrollGripHandler);
		}
		
		private function moveHandler(e:Event = null):void {
			_textfield.scrollV = _textfield.maxScrollV * _grip.y / _dragBounds.height;
		}

		// PUBLIC
		//________________________________________________________________________________________________
		
		public function get isDragging():Boolean {
			return _isDragging;
		}
		
		public function dispose() : void {
			// dispose objects, graphics and events listeners
			try {
				removeEventListener(Event.ADDED_TO_STAGE, added, false);
				stage.removeEventListener(Event.MOUSE_LEAVE, stageLeavehandler);
				stage.removeEventListener(MouseEvent.MOUSE_UP, mouseClean);
				_textfield.removeEventListener(Event.SCROLL, scrollEventHandler);
				_track.removeEventListener(MouseEvent.MOUSE_DOWN, trackClickHandler);
				_track.removeEventListener(MouseEvent.MOUSE_UP, trackClickHandler);
				_track.removeEventListener(MouseEvent.MOUSE_OUT, mouseClean);
				_grip.removeEventListener(MouseEvent.MOUSE_DOWN, gripMouseDownHandler);
				removeEventListener(Event.ENTER_FRAME, scrollGripHandler);
				removeEventListener(Event.ENTER_FRAME, moveHandler);
				while (numChildren > 0) removeChildAt(0);
				_track = null;
				_grip = null;
			} catch(e:Error) {
				trace("Error in", this, "(dispose method):", e.message);
			}
		}
		
	}
}
