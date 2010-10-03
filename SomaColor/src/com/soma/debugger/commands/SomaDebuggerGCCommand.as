package com.soma.debugger.commands {
	import com.soma.core.controller.Command;
	import com.soma.core.interfaces.ICommand;
	import com.soma.debugger.events.SomaDebuggerGCEvent;
	import com.soma.debugger.wires.SomaDebuggerGCWire;

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
	
	public class SomaDebuggerGCCommand extends Command implements ICommand {

		//------------------------------------
		// private, protected properties
		//------------------------------------
		
		

		//------------------------------------
		// public properties
		//------------------------------------
		
		
		
		//------------------------------------
		// constructor
		//------------------------------------
		
		public function SomaDebuggerGCCommand() {
			
		}
		
		//
		// PRIVATE, PROTECTED
		//________________________________________________________________________________________________
		
		
		
		// PUBLIC
		//________________________________________________________________________________________________
		
		public function execute(event:Event):void {
			try {
				var debuggerGCEvent:SomaDebuggerGCEvent = event as SomaDebuggerGCEvent;
				var debuggerName:String = (debuggerGCEvent.debuggerName == null || debuggerGCEvent.debuggerName == "") ? "Soma::SomaDebugger" : debuggerGCEvent.debuggerName;
				var wire:SomaDebuggerGCWire = getWire(debuggerName+"GCWire") as SomaDebuggerGCWire;
				if (wire != null) {
					switch (event.type) {
						case SomaDebuggerGCEvent.ADD_WATCHER:
							if (debuggerGCEvent.nameObjectToWatch == null ||
								debuggerGCEvent.nameObjectToWatch == "" ||
								debuggerGCEvent.objectToWatch == null) {
								return;
							}
							wire.addWatcher(debuggerGCEvent.nameObjectToWatch, debuggerGCEvent.objectToWatch);
							break;
						case SomaDebuggerGCEvent.REMOVE_WATCHER:
							if (debuggerGCEvent.nameObjectToWatch == null ||
								debuggerGCEvent.nameObjectToWatch == "") {
								return;
							}
							wire.removeWatcher(debuggerGCEvent.nameObjectToWatch);
							break;
						case SomaDebuggerGCEvent.REMOVE_ALL_WATCHERS:
							wire.removeAllWatchers();
							break;
						case SomaDebuggerGCEvent.FORCE_GC:
							wire.forceGC();
							break;
					}
				}
			} catch (err:Error) {
				trace("Error in ", this, " ", err.message);
			}
		}
		
	}
}