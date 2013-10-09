package starling.app
{
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.geom.Rectangle;
	
	import starling.core.Starling;
	
	public class StarlingApplication extends Sprite
	{
		public var stageWidth:Number=NaN;
		
		public var stageHeight:Number=NaN;
		
		protected function get current():Starling {
			return Starling.current;
		}
		
		public function StarlingApplication(splash: DisplayObject = null, stageWidth: Number = NaN, stageHeight: Number = NaN)
		{
			super();
					
			this.splash = splash;
			this.stageWidth = stageWidth;
			this.stageHeight = stageHeight;
			
			// support autoOrients
			stage.align = StageAlign.TOP_LEFT;
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.addEventListener(flash.events.Event.RESIZE, onStageResize);
		}
		
		private var _splash:DisplayObject;
		public function get splash():DisplayObject { return _splash; }
		
		public function set splash(value:DisplayObject):void
		{
			if (_splash == value)
				return;
			if (_splash) {
				removeChild(_splash);
			}
			_splash = value;
			if (value) {
				addChild(value);
				validateSize();
			}
		}
		
		/**
		 * 
		 * @param event
		 * 
		 */
		private function onStageResize(event:flash.events.Event):void
		{			
			//assetManager.scaleFactor = current.contentScaleFactor;
			
			Logger.log("onStageResize.", stage.fullScreenWidth, stage.fullScreenHeight);
			
			validateSize();
		}
		
		/**
		 * 
		 * 
		 */
		public function validateSize(): void {
			
			Logger.log("update");
			
			if (splash) {
				updateSplash()
			}
			
			if (current) {
				updateStage();
				updateViewport();
				if (current.root) {
					updateRoot();
				}
			}
		}
		
		private function updateRoot():void
		{
			current.root.width  = isNaN(stageWidth) ? screenWidth:stageWidth;
			current.root.height = isNaN(stageHeight) ? screenHeight:stageHeight;

		}
		
		protected function updateSplash():void
		{
			var screenWidth:int  = stage.stageWidth;
			var screenHeight:int = stage.stageHeight;
			
			splash.x = 0;
			splash.y = 0;
			splash.width = screenWidth;
			splash.height = screenHeight;
		}
		
		protected function updateViewport():void
		{		
			var screenWidth:int  = stage.stageWidth;
			var screenHeight:int = stage.stageHeight;
			
			var viewPort:Rectangle = new Rectangle(0, 0, screenWidth, screenHeight)
			current.viewPort = viewPort;			
		
		}
				
		private function get screenWidth():Number
		{
			return stage.stageWidth;
		}
		
		private function get screenHeight():Number
		{
			return stage.stageHeight;	
		}
		
		protected function updateStage():void
		{
			current.stage.stageWidth  = isNaN(stageWidth) ? screenWidth:stageWidth;
			current.stage.stageHeight = isNaN(stageHeight) ? screenHeight:stageHeight;
		}
		
		//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
		
	}
}