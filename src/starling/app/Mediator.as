/**
 * Copyright (c) 2013, Digital Touch sp. z o.o.
 * All rights reserved.
 * 
 * Any use, copying, modification, distribution and selling of this source code and it's documentation
 * for any purposes without authors' written permission is hereby prohibited.
 */
package starling.app
{
		
	import feathers.core.IFeathersControl;
	import feathers.events.FeathersEventType;
	
	import org.swiftsuspenders.Injector;
	
	import starling.display.DisplayObject;
	import starling.events.Event;
	import starling.events.EventDispatcher;
	
	/**
	 * 
	 * @author developer
	 * 
	 */
	public class Mediator
	{
		//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
		
		[Inject]
		/**
		 * 
		 */
		public var eventDispatcher: EventDispatcher;
		
		[Inject]
		/**
		 * 
		 */
		public var viewComponent: DisplayObject;
		
		//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
		
		[Inject]
		/**
		 * 
		 */
		public var injector: Injector;
		
		//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
		
		[PostConstruct]
		/**
		 * 
		 * 
		 */
		public function initialize(): void {
			if (viewComponent is IFeathersControl) { 
				viewComponent.addEventListener(FeathersEventType.INITIALIZE, onViewInitialize);
			}
			viewComponent.addEventListener(Event.ADDED_TO_STAGE, onViewAdded);
			viewComponent.addEventListener(Event.REMOVED_FROM_STAGE, onViewRemoved);
		}
		
		//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
		
		protected function onViewInitialize():void
		{	
			
		}
		
		protected function onViewAdded():void
		{	
			
		}
		
		protected function onViewRemoved():void
		{	
			
		}
		
		//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
		
		[PreDestroy]
		/**
		 * 
		 * 
		 */
		public function dispose(): void {
			Logger.log("dispose view mediator.", this);
			viewComponent.removeEventListener(Event.ADDED_TO_STAGE, onViewAdded);
			viewComponent.removeEventListener(Event.REMOVED_FROM_STAGE, onViewRemoved);
			if (viewComponent is IFeathersControl) { 
				viewComponent.removeEventListener(FeathersEventType.INITIALIZE, onViewInitialize);
			}
		}
		
		//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
		// bus
		//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
		
		protected function addEventListener(type: String, listener: Function): void {
			eventDispatcher.addEventListener(type, listener);
		}
		
		protected function removeEventListener(type: String, listener: Function): void {
			eventDispatcher.removeEventListener(type, listener);
		}
		
		protected function dispatchEvent(event: Event): void {
			eventDispatcher.dispatchEvent(event);
		}
		
		protected function dispatchEventWith(type: String, data: Object = null, bubbles: Boolean = false): void {
			eventDispatcher.dispatchEventWith(type, bubbles, data);
		}
		
		//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	}
}