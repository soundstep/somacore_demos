package com.cafetownsend.commands {
	
	import com.soma.core.controller.Command;
	import com.soma.core.interfaces.ICommand;
	import com.cafetownsend.SomaApplication;
	import com.cafetownsend.events.NavigationEvent;
	
	import flash.events.Event;

	public class NavigationCommand extends Command implements ICommand {
		
		public function NavigationCommand() {
			
		}
		
		public function execute(event:Event):void {
			var app:SomaCoreCafeTownSend = SomaApplication(instance).app as SomaCoreCafeTownSend;
			app.navigationID = NavigationEvent(event).navigationID;
		}
		
	}
}