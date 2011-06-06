package com.soma.plugins.assets.demo.views {

	import com.soma.core.interfaces.IMediator;
	import com.soma.core.mediator.Mediator;

	import flash.display.Bitmap;

	/**
	 * @author Romuald Quantin
	 */
	public class ImageWhenAllLoadedMediator extends Mediator implements IMediator {

		[Inject]
		public var view:ImageWhenAllLoaded;
		
		// all the assets are loaded at this point
		// we can inject the asset (or loaders)
		[Inject(name="image0")]
		public var image:Bitmap;
		
		override public function initialize():void {
			image.scaleX = image.scaleY = 0.1;
			image.x = 130;
			view.addChild(image);
		}
		
		override public function dispose():void {
			while (view.numChildren > 0) view.removeChildAt(0);
			view = null;
			image = null;
		}
		
	}
}
