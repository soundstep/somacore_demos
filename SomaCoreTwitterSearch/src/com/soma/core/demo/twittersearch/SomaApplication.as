package com.soma.core.demo.twittersearch {
	import flash.display.StageScaleMode;
	import flash.display.StageAlign;
	import com.soma.core.demo.twittersearch.services.TwitterService;
	import com.soma.core.demo.twittersearch.controller.commands.SearchCommand;
	import com.soma.core.demo.twittersearch.controller.events.TwitterEvent;
	import com.soma.core.Soma;
	import com.soma.core.demo.twittersearch.wires.SearchWire;
	import com.soma.core.interfaces.ISoma;

	/**
	 * @author romuald
	 */
	public class SomaApplication extends Soma implements ISoma {
		
		private var _container:Main;

		public function SomaApplication(container:Main) {
			_container = container;
			super(_container.stage);
			initialize();
		}

		private function initialize():void {
			stage.align = StageAlign.TOP_LEFT;
			stage.scaleMode = StageScaleMode.NO_SCALE;
		}
		
		override protected function registerWires():void {
			addWire(SearchWire.NAME, new SearchWire());			addWire(TwitterService.NAME, new TwitterService());
		}
		
		override protected function registerCommands():void {
			addCommand(TwitterEvent.SEARCH, SearchCommand);
		}
		
	}
}
