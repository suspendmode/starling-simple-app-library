package starling.app
{
	
	import feathers.core.DisplayListWatcher;
	import feathers.core.FeathersControl;
	
	import org.swiftsuspenders.Injector;
	
	import starling.core.Starling;
	import starling.display.DisplayObject;
	import starling.events.Event;
	
	public class MediatorMap extends DisplayListWatcher {
		
		private var mediators: Vector.<Mediator> = new Vector.<Mediator>();
		
		private var injector: Injector;
		
		public function MediatorMap(injector: Injector) {	
			super(Starling.current.stage);
			this.injector = injector;
			setInitializerForClassAndSubclasses(FeathersControl, mediatorInitializer);
		}
		
		private function mediatorInitializer(view: FeathersControl):void
		{			
			var generator: Class = view["constructor"];
			if (!injector.hasDirectMapping(generator)) {
				return;
			}
			
			var onViewRemovedFromStage: Function = function ():void
			{				
				view.removeEventListener(starling.events.Event.REMOVED_FROM_STAGE, onViewRemovedFromStage);
				injector.destroyInstance(mediator);
				Logger.log("mediatorInitializer->onViewRemovedFromStage:{0}", view);
				var mediatorIndex: int = mediators.indexOf(mediator); 
				mediators.splice(mediatorIndex, 1);
			}
			
			Logger.log("mediatorInitializer->view:{0}", view);
			
			view.addEventListener(starling.events.Event.REMOVED_FROM_STAGE, onViewRemovedFromStage);
			
			var mediatorFactory: Class = injector.getInstance(generator);
			
			var mediator: Mediator = new mediatorFactory();
			
			mediators.push(mediator);
			
			injector.unmap(generator);
			injector.map(generator).toValue(view);
			injector.map(DisplayObject).toValue(view);
			injector.injectInto(mediator);
			if (injector.hasMapping(generator)) {
				injector.unmap(generator);
			}
			if (injector.hasMapping(DisplayObject)) {
				injector.unmap(DisplayObject);
			}
			injector.map(generator).toValue(mediatorFactory);
			
			Logger.log("mediatorInitializer->mediator:{0} view:{1}/{2}", mediator, view, generator);
		}
	}
}