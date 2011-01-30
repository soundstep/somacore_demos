package com.soma.core.demo.helloworld.wires {
	import com.soma.core.demo.helloworld.SomaApplication;
	import com.soma.core.demo.helloworld.controller.commands.MessageCommand;
	import com.soma.core.demo.helloworld.controller.events.MessageEvent;
	import com.soma.core.demo.helloworld.models.MessageModel;
	import com.soma.core.demo.helloworld.views.MessageView;
	import com.soma.core.interfaces.IWire;
	import com.soma.core.wire.Wire;

	/**
	 * @author romuald
	 */
	public class MessageWire extends Wire implements IWire {
		
		public static const NAME:String = "APP::MessageWire";		public static const NAME_VIEW:String = "APP::MessageView";
		
		public function MessageWire() {
			super(NAME);
		}

		override public function initialize():void {
			// model
			addModel(MessageModel.NAME, new MessageModel());
			// view
			addView(NAME_VIEW, new MessageView());
			SomaApplication(instance).container.addChild(messageView);
			// command
			addCommand(MessageEvent.REQUEST, MessageCommand);
			// listeners
			addEventListener(MessageEvent.READY, messageReady);
		}

		private function get messageView():MessageView {
			return getView(NAME_VIEW) as MessageView;
		}

		private function messageReady(event:MessageEvent):void {
			messageView.updateMessage(event.message);
		}
	}
}
