package com.soma.debugger.commands {
	import com.soma.core.controller.Command;
	import com.soma.core.interfaces.ICommand;
	import com.soma.debugger.events.SomaDebuggerEvent;
	import com.soma.debugger.wires.SomaDebuggerWire;

	import flash.events.Event;

	/**
	 * <b>Author:</b> Romuald Quantin - <a href="http://www.soundstep.com/" target="_blank">www.soundstep.com</a><br />* <b>Class version:</b> 1.0<br />
	 * <b>Actionscript version:</b> 3.0<br />
	 * <b>Copyright:</b> 
	 * <br />
	 * <b>Date:</b> Sep 24, 2009<br />
	 * <b>Usage:</b>
	 * @example
	 * <listing version="3.0"></listing>
	 */
	
	public class SomaDebuggerCommand extends Command implements ICommand {

		//------------------------------------
		// private, protected properties
		//------------------------------------
		
		

		//------------------------------------
		// public properties
		//------------------------------------
		
		
		
		//------------------------------------
		// constructor
		//------------------------------------
		
		public function SomaDebuggerCommand() {
			
		}
		
		//
		// PRIVATE, PROTECTED
		//________________________________________________________________________________________________
		
		
		
		// PUBLIC
		//________________________________________________________________________________________________
		
		public function execute(event:Event):void {
			try {
				var debuggerEvent:SomaDebuggerEvent = event as SomaDebuggerEvent;
				var debuggerName:String = (debuggerEvent.debuggerName == null || debuggerEvent.debuggerName == "") ? "Soma::SomaDebugger" : debuggerEvent.debuggerName;
				var wire:SomaDebuggerWire = getWire(debuggerName) as SomaDebuggerWire;
				if (wire != null) {
					switch (event.type) {
						case SomaDebuggerEvent.SHOW_DEBUGGER:
							wire.show();
							break;
						case SomaDebuggerEvent.HIDE_DEBUGGER:
							wire.hide();
							break;
						case SomaDebuggerEvent.MOVE_TO_TOP:
							wire.moveToTop();
							break;
						case SomaDebuggerEvent.PRINT:
							wire.print(SomaDebuggerEvent(event).message);
							break;
						case SomaDebuggerEvent.CLEAR:
							wire.clear();
							break;
					}
				}
			} catch (err:Error) {
				trace("Error in ", this, " ", err.message);
			}
		}
		
	}
}