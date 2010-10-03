package com.soundstep.somacolor.controllers.commands {
	import com.soma.core.controller.Command;
	import com.soma.core.interfaces.ICommand;
	import com.soma.core.interfaces.ISequenceCommand;
	import com.soundstep.somacolor.SomaApplication;
	import com.soundstep.somacolor.controllers.events.MoveViewEvent;
	import com.soundstep.somacolor.wires.ColorWire;

	import flash.display.DisplayObject;
	import flash.events.Event;

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
	
	public class MoveViewCommand extends Command implements ICommand {

		//------------------------------------
		// private, protected properties
		//------------------------------------
		
		

		//------------------------------------
		// public properties
		//------------------------------------
		
		
		
		//------------------------------------
		// constructor
		//------------------------------------
		
		public function MoveViewCommand() {
			
		}
		
		//
		// PRIVATE, PROTECTED
		//________________________________________________________________________________________________
		
		
		
		// PUBLIC
		//________________________________________________________________________________________________
		
		public function execute(event:Event):void {
			var view:DisplayObject = getView(ColorWire.NAME_VIEW_RECEIVER) as DisplayObject;
			view.x = MoveViewEvent(event).x;
			view.y = MoveViewEvent(event).y;
			if (isPartOfASequence(event)) {
				var sequencer:ISequenceCommand = getSequencer(event);
				SomaApplication(instance).debug("Sequence continue, " + sequencer.length + " left!");
				sequencer.executeNextCommand();
			}
		}
	}
}