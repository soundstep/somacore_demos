package com.soma.core.demo.twittersearch.controller.commands {
	import com.soma.core.demo.twittersearch.services.TwitterService;
	import com.soma.core.controller.Command;
	import com.soma.core.demo.twittersearch.controller.events.TwitterEvent;
	import com.soma.core.interfaces.ICommand;

	import flash.events.Event;

	/**
	 * @author romuald
	 */
	public class SearchCommand extends Command implements ICommand {
		
		public function execute(event:Event):void {
			var wire:TwitterService = getWire(TwitterService.NAME) as TwitterService;
			switch (event.type) {
				case TwitterEvent.SEARCH:
					wire.search(TwitterEvent(event).keywords);
					break;
			}
		}
		
	}
}
