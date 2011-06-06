package com.soma.plugins.assets.demo.wires {

	import com.soma.plugins.assets.demo.views.ImageGroup;
	import com.soma.core.interfaces.IWire;
	import com.soma.core.wire.Wire;
	import com.soma.plugins.assets.demo.SomaApplication;
	import com.soma.plugins.assets.demo.views.ImageWhenAllLoaded;
	import com.soma.plugins.assets.demo.views.ImageWhenNotLoaded;
	import com.soma.plugins.assets.events.SomaAssetsEvent;
	import flash.display.DisplayObjectContainer;
	import org.assetloader.core.IAssetLoader;

	/**
	 * @author Romuald Quantin
	 */
	public class InitializeWire extends Wire implements IWire {
		
		[Inject(name="assets")]
		public var loader:IAssetLoader;
		
		// register some SomaAssets events for monitoring
		override public function initialize():void {
			addEventListener(SomaAssetsEvent.CONFIG_LOADED, configLoaded);
			addEventListener(SomaAssetsEvent.LOADER_COMPLETE, assetsComplete);
			addEventListener(SomaAssetsEvent.ERROR, assetsErrorHandler);
		}
		
		// shortcut to get the document class
		private function get container():DisplayObjectContainer {
			return SomaApplication(instance).container;
		}

		// in case there's an error for both the assets config or the assets
		private function assetsErrorHandler(event:SomaAssetsEvent):void {
			trace("Asset Error:", event.errorMessage, event.errorType);
		}
		
		// the external XML assets config has been loaded here 
		private function configLoaded(event:SomaAssetsEvent):void {
			container.addChild(new ImageWhenNotLoaded());
			container.addChild(new ImageGroup());
			trace("config loaded");
			loader.start();
		}
		
		// all assets container in the config XML have been loaded here 
		private function assetsComplete(event:SomaAssetsEvent):void {
			container.addChild(new ImageWhenAllLoaded());
		}

	}
}
