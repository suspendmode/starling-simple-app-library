package starling.app
{
	
	import flash.geom.Rectangle;
	
	import org.swiftsuspenders.Injector;
	
	import starling.core.Starling;
	import starling.events.Event;
	import starling.events.EventDispatcher;
	import starling.utils.AssetManager;

	public class Context
		extends EventDispatcher {
	
		public var injector: Injector = new Injector();		
		
		//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
		
		protected var application: StarlingApplication;
		
		protected var current:Starling;
		
		protected var starlingRootClass: Class;
		
		public var assetManager:AssetManager;
		
		public var mediatorMap:MediatorMap;

		public function Context(application: StarlingApplication, starlingRootClass: Class = null, starlingConfigProperties: Object = null, backgroundColor: uint = 0xFFFFFF, autoInitialize: Boolean = true, autoDispose: Boolean = true)
		{		
			super();
			
			injector.map(Injector).toValue(injector);
			injector.map(EventDispatcher).toValue(this);			

			this.application = application;
			this.starlingRootClass = starlingRootClass;			
			
			if (!assetManager) {
				assetManager = new AssetManager();
				assetManager.verbose = true;
				injector.map(AssetManager).toValue(assetManager);				
			}
			
			current = new Starling(starlingRootClass, application.stage, new Rectangle(0,0,screenWidth,screenHeight));
			apply(current, starlingConfigProperties);
			current.stage.color = backgroundColor;
			current.addEventListener(Event.ROOT_CREATED, onRootCreated);
			mediatorMap = new MediatorMap(injector);
			injector.map(MediatorMap).toValue(mediatorMap);
			
			if (autoInitialize) {
				if (application.stage) {
					initialize();
				} else {
					var onAddedToStage: Function = function(event: Object): void {
						application.removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
						initialize();
					}
					application.addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
					
				}
			}
			if (autoDispose) {
				if (!application.stage) {
					dispose();
				} else {
					var onRemovedFromStage: Function = function(event: Object): void {
						application.removeEventListener(Event.REMOVED_FROM_STAGE, onRemovedFromStage);
						dispose();
					}
					application.addEventListener(Event.REMOVED_FROM_STAGE, onRemovedFromStage);					
				}
			}
		}
		
		private function apply(current:Starling, properties:Object):void
		{
			if (!properties) {
				return;
			}
			for (var n: String in properties) {
				current[n] = properties[n];
			}
		}
		
		private function onRootCreated():void
		{			
			application.validateSize();
		}
		
		private function get screenWidth():Number
		{
			return application.stage.stageWidth;
		}
		
		private function get screenHeight():Number
		{
			return application.stage.stageHeight;	
		}
		
		//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
		
		/**
		 * 
		 * 
		 */
		public function initialize(): void {
			
			Logger.addTraceTarget(trace);

			Logger.log("initialize {0}", this);
			
			//current.showStatsAt("left","top",4);
			//current.showStats = false;
			
			current.start();						
		}				
		
		//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
		
		/**
		 * 
		 * 
		 */
		public function dispose(): void {
			
			Logger.log("dispose {0}", this);
			
			Logger.removeTraceTarget(trace);
			
			current.stop();
			
			current.dispose();
		}
		
		//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	}
}

