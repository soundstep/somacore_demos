package com.soundstep.somacolor.controllers.commands {
	import com.soma.core.controller.Command;
	import com.soma.core.interfaces.ICommandASync;
	import com.soma.core.interfaces.ISequenceCommand;
	import com.soundstep.somacolor.SomaApplication;
	import com.soundstep.somacolor.delegates.ASyncDelegate;

	import flash.events.Event;

	/**
	 * <b>Author:</b> Romuald Quantin - <a href="http://www.soundstep.com/" target="_blank">www.soundstep.com</a><br />* <b>Class version:</b> 1.0<br />
	 * <b>Actionscript version:</b> 3.0<br />
	 * <b>Copyright:</b> 
	 * <br />
	 * <b>Date:</b> Sep 22, 2009<br />
	 * <b>Usage:</b>
	 * @example
	 * <listing version="3.0"></listing>
	 */
	
	public class ASyncCommand extends Command implements ICommandASync {

		//------------------------------------
		// private, protected properties
		//------------------------------------
		
		private var _sequencer:ISequenceCommand;
		private var _event:Event;

		//------------------------------------
		// public properties
		//------------------------------------
		
		
		
		//------------------------------------
		// constructor
		//------------------------------------
		
		public function ASyncCommand() {
			
		}
		
		//
		// PRIVATE, PROTECTED
		//________________________________________________________________________________________________
		
		
		
		// PUBLIC
		//________________________________________________________________________________________________
		
		public function execute(event:Event):void {
			_event = event;
			_sequencer = getSequencer(_event);
			var delegate:ASyncDelegate = new ASyncDelegate(this);
			delegate.call();
			SomaApplication(instance).debug("waiting for response...");
		}
		
		public function fault(info:Object):void {
			SomaApplication(instance).debug(info);
			if (isPartOfASequence(_event)) {
				_sequencer.stop();
				SomaApplication(instance).debug("Sequence has been stopped on a fault!");
			}
		}
		
		public function result(data:Object):void {
			SomaApplication(instance).debug(data);
			if (isPartOfASequence(_event)) {
				if (_sequencer.length > 0) {
					SomaApplication(instance).debug("Sequence continue, " + _sequencer.length + " left!");
				}
				else {
					SomaApplication(instance).debug("Sequence end");
				}
				_sequencer.executeNextCommand();
			}
		}
		
	}
}