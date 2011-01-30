package com.soma.core.demo.helloworld {
	import flash.display.StageScaleMode;
	import flash.display.StageAlign;
	import com.soma.core.Soma;
	import com.soma.core.demo.helloworld.wires.MessageWire;
	import com.soma.core.interfaces.ISoma;

	/**
	 * @author romuald
	 */
	public class SomaApplication extends Soma implements ISoma {
		
		private var _container:Main;

		public function SomaApplication(container:Main) {
			_container = container;
			super(_container.stage);
		}

		override protected function initialize():void {
			stage.align = StageAlign.TOP_LEFT;			stage.scaleMode = StageScaleMode.NO_SCALE;
		}
		
		override protected function registerWires():void {
			addWire(MessageWire.NAME, new MessageWire());
		}
		
		public function get container():Main {
			return _container;
		}
		
	}
}
