package com.soma.plugins.assets.demo.views {

	import flash.display.Bitmap;
	import com.soma.plugins.assets.SomaAssets;
	import com.soma.core.interfaces.IMediator;
	import com.soma.core.mediator.Mediator;
	import org.assetloader.core.IAssetLoader;
	import org.assetloader.core.ILoader;
	import org.assetloader.events.AssetLoaderErrorEvent;
	import org.assetloader.events.AssetLoaderEvent;
	import org.assetloader.events.AssetLoaderProgressEvent;
	import flash.utils.Dictionary;

	/**
	 * @author Romuald Quantin
	 */
	public class ImageGroupMediator extends Mediator implements IMediator {

		[Inject]
		public var view:ImageGroup;
		
		// here we get the plugin
		[Inject(name="assets")]
		public var assets:SomaAssets;

		// here we get a group using a path (ids + delimiter)
		[Inject(name="group0/group00")]
		public var imageGroup:IAssetLoader;
		
		// add some listeners to monitor the loading of a single group 
		override public function initialize():void {
			imageGroup.addEventListener(AssetLoaderErrorEvent.ERROR, errorHandler);
			imageGroup.addEventListener(AssetLoaderEvent.START, startHandler);
			imageGroup.addEventListener(AssetLoaderProgressEvent.PROGRESS, progressHandler);
			imageGroup.addEventListener(AssetLoaderEvent.COMPLETE, completeHandler);
		}

		private function errorHandler(event:AssetLoaderErrorEvent):void {
			trace("Error", event.errorType, event.message);
		}

		private function startHandler(event:AssetLoaderEvent):void {
			trace("Loading started (" + ILoader(event.currentTarget).id + ")");
		}

		private function progressHandler(event:AssetLoaderProgressEvent):void {
			trace("Loading progress (" + ILoader(event.currentTarget).id + ") progress:", event.progress, ", speed:", event.speed);
		}

		// now the group is loaded, get the 2 images from the group 
		private function completeHandler(event:AssetLoaderEvent):void {
			trace("Loading completed (" + ILoader(event.currentTarget).id + ")");
			var images:Dictionary = event.data;
			trace("asset from dictionary", images["image3"]);
			trace("asset from loader:", imageGroup.getAsset("image3"));
			trace("asset from plugin:", assets.getAssets("group0/group00/image3"));
			var image2:Bitmap = images["image2"];
			var image3:Bitmap = images["image3"];
			image2.x = 290;
			image2.scaleX = image2.scaleY = 0.1;
			image3.x = 340;
			image3.scaleX = image3.scaleY = 0.1;
			view.addChild(image2);
			view.addChild(image3);
		}
		
		override public function dispose():void {
			while (view.numChildren > 0) view.removeChildAt(0);
			view = null;
			imageGroup = null;
		}
		
	}
}
