package com.soma.plugins.assets.demo {

	import com.soma.plugins.assets.demo.commands.ExampleAssetCommand;
	import com.soma.plugins.assets.events.SomaAssetsEvent;
	import com.soma.core.Soma;
	import com.soma.core.di.SomaInjector;
	import com.soma.core.interfaces.ISoma;
	import com.soma.plugins.assets.SomaAssets;
	import com.soma.plugins.assets.demo.views.ImageGroup;
	import com.soma.plugins.assets.demo.views.ImageGroupMediator;
	import com.soma.plugins.assets.demo.views.ImageWhenAllLoaded;
	import com.soma.plugins.assets.demo.views.ImageWhenAllLoadedMediator;
	import com.soma.plugins.assets.demo.views.ImageWhenNotLoaded;
	import com.soma.plugins.assets.demo.views.ImageWhenNotLoadedMediator;
	import com.soma.plugins.assets.demo.wires.InitializeWire;
	import com.soma.plugins.assets.vo.SomaAssetsVO;

	/**
	 * @author Romuald Quantin
	 */
	public class SomaApplication extends Soma implements ISoma {

		private var _container:Main;

		public function SomaApplication(container:Main) {
			_container = container;
			super(_container.stage, SomaInjector);
		}
		
		// create a command for a demo purpose to monitor the assets that are loaded
		override protected function registerCommands():void {
			addCommand(SomaAssetsEvent.ASSET_LOADED, ExampleAssetCommand);
		}
		
		// register mediators to views
		// the views won't be created at the same moment to show how you can handle your loading 
		override protected function registerViews():void {
			mediators.mapView(ImageWhenAllLoaded, ImageWhenAllLoadedMediator);
			mediators.mapView(ImageWhenNotLoaded, ImageWhenNotLoadedMediator);
			mediators.mapView(ImageGroup, ImageGroupMediator);
		}
		
		// create the plugin and register an external assets configuration to load
		override protected function registerPlugins():void {
			createPlugin(SomaAssets, new SomaAssetsVO(this, "xml/assets.xml"));
		}
		
		// create an wire where you could handle the "global" loading process
		override protected function start():void {
			injector.createInstance(InitializeWire);
		}
		
		// just the document class to add some views to
		public function get container():Main {
			return _container;
		}
		
	}
}
