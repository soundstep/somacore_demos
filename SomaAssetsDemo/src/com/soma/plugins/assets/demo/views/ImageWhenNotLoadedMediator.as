package com.soma.plugins.assets.demo.views {

	import flash.display.Bitmap;
	import com.soma.core.interfaces.IMediator;
	import com.soma.core.mediator.Mediator;

	import org.assetloader.core.ILoader;
	import org.assetloader.events.AssetLoaderErrorEvent;
	import org.assetloader.events.AssetLoaderEvent;
	import org.assetloader.events.AssetLoaderProgressEvent;

	/**
	 * @author Romuald Quantin
	 */
	public class ImageWhenNotLoadedMediator extends Mediator implements IMediator {

		[Inject]
		public var view:ImageWhenNotLoaded;
		
		// here we get the loader of an asset for monitoring purpose
		// this one is an ImageLoader but we keep the interface as a type
		[Inject(name="image1")]
		public var imageLoader:ILoader;
		
		// add some listeners to monitor the loading of a single loader 
		override public function initialize():void {
			imageLoader.addEventListener(AssetLoaderErrorEvent.ERROR, errorHandler);
			imageLoader.addEventListener(AssetLoaderEvent.START, startHandler);
			imageLoader.addEventListener(AssetLoaderProgressEvent.PROGRESS, progressHandler);
			imageLoader.addEventListener(AssetLoaderEvent.COMPLETE, completeHandler);
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
		
		// the loader is complete, the asset is ready
		private function completeHandler(event:AssetLoaderEvent):void {
			trace("Loading completed (" + ILoader(event.currentTarget).id + ")");
			var image:Bitmap = event.data;
			image.scaleX = image.scaleY = 0.1;
			view.addChild(image);
		}
		
		override public function dispose():void {
			while (view.numChildren > 0) view.removeChildAt(0);
			view = null;
			imageLoader = null;
		}
		
	}
}
