package com.soundstep.somacolor {
	import com.greensock.plugins.TintPlugin;
	import com.greensock.plugins.TweenPlugin;
	import com.soma.core.Soma;
	import com.soma.core.interfaces.ISoma;
	import com.soma.debugger.SomaDebugger;
	import com.soma.debugger.events.SomaDebuggerEvent;
	import com.soma.debugger.vo.SomaDebuggerVO;
	import com.soundstep.somacolor.controllers.commands.ASyncCommand;
	import com.soundstep.somacolor.controllers.commands.ParallelTestCommand;
	import com.soundstep.somacolor.controllers.commands.SequenceStopCommand;
	import com.soundstep.somacolor.controllers.commands.SequenceTestCommand;
	import com.soundstep.somacolor.controllers.commands.StartCommand;
	import com.soundstep.somacolor.controllers.commands.TweenCommand;
	import com.soundstep.somacolor.controllers.commands.TweenSequenceCommand;
	import com.soundstep.somacolor.controllers.events.ASyncEvent;
	import com.soundstep.somacolor.controllers.events.ChainEvent;
	import com.soundstep.somacolor.controllers.events.SequenceEvent;
	import com.soundstep.somacolor.controllers.events.StartEvent;
	import com.soundstep.somacolor.controllers.events.TweenEvent;
	import com.soundstep.somacolor.controllers.events.TweenSequenceEvent;

	import flash.display.Stage;

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
	
	public class SomaApplication extends Soma implements ISoma {

		//------------------------------------
		// private, protected properties
		//------------------------------------
		
		private var _debug:Boolean;

		//------------------------------------
		// public properties
		//------------------------------------
		
		public var name:String = "Soma 1";
		
		//------------------------------------
		// constructor
		//------------------------------------
		
		public function SomaApplication(stage:Stage, debug:Boolean = false) {
			super(stage);
			_debug = debug;
			initialize();
		}
		
		//
		// PRIVATE, PROTECTED
		//________________________________________________________________________________________________
		
		private function initialize():void {
			TweenPlugin.activate([TintPlugin]);
			dispatchEvent(new StartEvent(StartEvent.START));
			createDebugger();
		}
		
		override protected function registerCommands():void {
			addCommand(StartEvent.START, StartCommand);
			addCommand(ChainEvent.CHAIN, ParallelTestCommand);
			addCommand(ASyncEvent.CALL, ASyncCommand);
			addCommand(ASyncEvent.CHAIN, SequenceTestCommand);
			addCommand(TweenEvent.TWEEN, TweenCommand);
			addCommand(TweenSequenceEvent.SEQUENCE, TweenSequenceCommand);
			addCommand(SequenceEvent.STOP_ALL_SEQUENCES, SequenceStopCommand);
		}
		
		private function createDebugger():void {
			if (_debug) {
				var pluginVO:SomaDebuggerVO = new SomaDebuggerVO(this, SomaDebugger.NAME_DEFAULT, getCommands(), true, false);
				createPlugin(SomaDebugger, pluginVO) as SomaDebugger;
			}
		}

		// PUBLIC
		//________________________________________________________________________________________________
		
		public function debug(value:Object):void {
			if (_debug) dispatchEvent(new SomaDebuggerEvent(SomaDebuggerEvent.PRINT, value));
		}
		
	}
}