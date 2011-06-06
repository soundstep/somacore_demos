package com.soma.plugins.assets.demo.commands {

	import com.soma.core.controller.Command;
	import com.soma.core.interfaces.ICommand;
	import com.soma.plugins.assets.SomaAssets;
	import com.soma.plugins.assets.demo.SomaApplication;
	import com.soma.plugins.assets.events.SomaAssetsEvent;

	import flash.display.DisplayObjectContainer;
	import flash.events.Event;
	import flash.media.Sound;
	import flash.media.Video;
	import flash.net.NetStream;
	import flash.text.TextField;
	import flash.utils.getQualifiedClassName;

	/**
	 * @author Romuald Quantin
	 */
	public class ExampleAssetCommand extends Command implements ICommand {
		
		[Inject]
		public var evt:SomaAssetsEvent;
		
		[Inject(name="assets")]
		public var assets:SomaAssets;
		
		// just some examples
		public function execute(event:Event):void {
			var container:DisplayObjectContainer = SomaApplication(instance).container;
			trace("Command Example (" + evt.path + ") > " + assets.getLoader(evt.path).type + " Loaded: " +  getQualifiedClassName(evt.asset));
			// you can use a switch to find the assets:
			switch (evt.path) {
				case "group0/group01/css":
					break;
				case "group0/group01/json":
					break;
				case "group0/group01/sound":
					var sound:Sound = evt.asset;
					sound.play(0);
					break;
				case "group0/group01/text":
					var textfield:TextField = new TextField();
					textfield.multiline = textfield.wordWrap = true;
					textfield.text = evt.asset;
					container.addChild(textfield);
					break;
				case "group0/group01/xml":
					break;
				case "group0/group01/video":
					var video:Video = new Video();
					var stream:NetStream = evt.asset;
					container.addChild(video);
					video.y = 80;
					video.smoothing = true;
					video.attachNetStream(stream);
					stream.resume();
					break;
				case "group0/group01/zip":
					break;
			}
		}
		
	}
}
