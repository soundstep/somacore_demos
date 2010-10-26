package com.soma.core.demo.twittersearch.wires {
	import com.soma.core.demo.twittersearch.controller.events.TwitterEvent;
	import com.soma.core.demo.twittersearch.services.TwitterService;
	import com.soma.core.demo.twittersearch.views.MainView;
	import com.soma.core.interfaces.IWire;
	import com.soma.core.wire.Wire;
	import com.swfjunkie.tweetr.data.objects.SearchResultData;

	/**
	 * @author romuald
	 */
	public class SearchWire extends Wire implements IWire {
		
		public static const NAME:String = "APP::SearchWire";
		public static const NAME_VIEW:String = "APP::View.MainView";
		
		public function SearchWire() {
			super(NAME);
		}
		
		override protected function initialize():void {
			// view
			addView(NAME_VIEW, new MainView());
			stage.addChild(view);
			// listeners
			addEventListener(TwitterEvent.SEARCH, searchHandler);
			addEventListener(TwitterEvent.SEARCH_RESULT, resultHandler);
		}

		private function searchHandler(event:TwitterEvent):void {
			view.setText("Search for \"" + event.keywords + "\"... Please wait.");
		}

		private function resultHandler(event:TwitterEvent):void {
			view.setText("");
			var i:Number = 0;
			var l:Number = service.lastResult.length;
			for (; i<l; ++i) {
				var result:SearchResultData = service.lastResult[i];
				view.appendText("--------------------------<br/>");
				view.appendText(result.text + "<br/>");
			}
		}

		private function get view():MainView {
			return getView(NAME_VIEW) as MainView;
		}
		
		private function get service():TwitterService {
			return getWire(TwitterService.NAME) as TwitterService;
		}
		
	}
}
