/**
 *
 * Copyright (C) Piotr Kucharski 2012 email: suspendmode@gmail.com
 * mobile: +48 791 630 277
 *
 * All rights reserved. Any use, copying, modification,
 * distribution and selling of this software and it's documentation
 * for any purposes without authors' written permission is hereby prohibited.
 *
 * Use this code to do whatever you want, just don't claim it as your own, because
 * I wrote it. Not you!
 *
 */
package feathers.controls
{
    
    import flash.geom.Point;
    
    import feathers.controls.renderers.IListItemRenderer;
    
    import starling.display.DisplayObject;
    import starling.events.Event;
    import starling.events.Touch;
    import starling.events.TouchEvent;
    import starling.events.TouchPhase;
    
    public class EmptyListItemRenderer extends ScrollContainer implements IListItemRenderer
    {
        ////////////////////////////////////////////////////////////////////////////////////////////////
        
        /**
         * @private
         */
        private static const HELPER_POINT : Point = new Point();
        
        /**
         * @private
         */
        private static const HELPER_TOUCHES_VECTOR : Vector.<Touch> = new <Touch>[];
        
        ////////////////////////////////////////////////////////////////////////////////////////////////
        
        /**
         *
         *
         */
        public function EmptyListItemRenderer()
        {
            
            super();
            addEventListener(TouchEvent.TOUCH, renderer_touchHandler);
        
        }
        
        ////////////////////////////////////////////////////////////////////////////////////////////////
        
        /**
         *
         */
        private var _isSelected : Boolean = false;
        
        /**
         *
         * @return
         *
         */
        public function get isSelected() : Boolean
        {
            
            return _isSelected;
        
        }
        
        /**
         *
         * @param value
         *
         */
        public function set isSelected(value : Boolean) : void
        {
            
            if (_isSelected == value)
                return;
            _isSelected = value;
            invalidate(INVALIDATION_FLAG_SELECTED);
			invalidate(INVALIDATION_FLAG_STYLES);
            dispatchEventWith(Event.CHANGE);
        
        }
        
        ////////////////////////////////////////////////////////////////////////////////////////////////
        
        /**
         *
         */
        private var _data : Object;
        
        /**
         *
         * @return
         *
         */
        public function get data() : Object
        {
            
            return _data;
        
        }
        
        /**
         *
         * @param value
         *
         */
        public function set data(value : Object) : void
        {
            
            if (_data == value)
                return;
            _data = value;
            invalidate(INVALIDATION_FLAG_DATA);
        
        }
        
        ////////////////////////////////////////////////////////////////////////////////////////////////
        
        /**
         *
         */
        private var _index : int;
        
        /**
         *
         * @return
         *
         */
        public function get index() : int
        {
            
            return _index;
        
        }
        
        /**
         *
         * @param value
         *
         */
        public function set index(value : int) : void
        {
            
            if (_index == value)
                return;
            _index = value;
        
        }
        
        ////////////////////////////////////////////////////////////////////////////////////////////////
        
        /**
         *
         */
        private var _owner : List;
        
        /**
         *
         * @return
         *
         */
        public function get owner() : List
        {
            
            return _owner;
        
        }
        
        /**
         *
         * @param value
         *
         */
        public function set owner(value : List) : void
        {
            
            if (_owner == value)
                return;
            _owner = value;
        
        }
        
        ////////////////////////////////////////////////////////////////////////////////////////////////
        
        /**
         *
         * @param event
         *
         */
        protected function renderer_touchHandler(event : TouchEvent) : void
        {
            
            if (!this._isEnabled)
            {
                return;
            }
            
            const touches : Vector.<Touch> = event.getTouches(this, null, HELPER_TOUCHES_VECTOR);
            if (touches.length == 0)
            {
                //end of hover				
                return;
            }
            if (this._touchPointID >= 0)
            {
                var touch : Touch;
                for each (var currentTouch : Touch in touches)
                {
                    if (currentTouch.id == this._touchPointID)
                    {
                        touch = currentTouch;
                        break;
                    }
                }
                
                if (!touch)
                {
                    //end of hover					
                    HELPER_TOUCHES_VECTOR.length = 0;
                    return;
                }
                
                touch.getLocation(this.stage, HELPER_POINT);
                var isInBounds : Boolean = this.contains(this.stage.hitTest(HELPER_POINT, true));
                if (touch.phase == TouchPhase.MOVED)
                {
                    
                }
                else if (touch.phase == TouchPhase.ENDED)
                {
                    this._touchPointID = -1;
                    if (isInBounds)
                    {
                        this.dispatchEventWith(Event.TRIGGERED);
                        this.isSelected = !this._isSelected;
                    }
                    
                }
            }
            else //if we get here, we don't have a saved touch ID yet
            {
                for each (touch in touches)
                {
                    if (touch.phase == TouchPhase.BEGAN)
                    {
                        
                        this._touchPointID = touch.id;
                        break;
                    }
                    else if (touch.phase == TouchPhase.HOVER)
                    {
                        
                        break;
                    }
                }
            }
            HELPER_TOUCHES_VECTOR.length = 0;
        
        }
    
        ////////////////////////////////////////////////////////////////////////////////////////////////
		
		override protected function refreshBackgroundSkin():void
		{
			this.currentBackgroundSkin = this._backgroundSkin;			
			
			if(!this._isEnabled && this._backgroundDisabledSkin)
			{
				if(this._backgroundSkin)
				{
					this._backgroundSkin.visible = false;
				}
				this.currentBackgroundSkin = this._backgroundDisabledSkin;
			}
			else if(this._backgroundDisabledSkin)
			{
				this._backgroundDisabledSkin.visible = false;
			}
			
			if(this._isSelected && this._backgroundSelectedSkin)
			{
				if(this._backgroundSkin)
				{
					this._backgroundSkin.visible = false;
				}
				if(this._backgroundDisabledSkin)
				{
					this._backgroundDisabledSkin.visible = false;
				}
				this.currentBackgroundSkin = this._backgroundSelectedSkin;
			}
			else if(this._backgroundSelectedSkin)
			{
				this._backgroundSelectedSkin.visible = false;
			}
			
			if(this.currentBackgroundSkin)
			{
				this.currentBackgroundSkin.visible = true;
				
				if(isNaN(this.originalBackgroundWidth))
				{
					this.originalBackgroundWidth = this.currentBackgroundSkin.width;
				}
				if(isNaN(this.originalBackgroundHeight))
				{
					this.originalBackgroundHeight = this.currentBackgroundSkin.height;
				}
			}
		}				
		
		/**
		 * @private
		 */
		protected var _backgroundSelectedSkin:DisplayObject;
		
		/**
		 * The default background to display.
		 */
		public function get backgroundSelectedSkin():DisplayObject
		{
			return this._backgroundSelectedSkin;
		}
		
		/**
		 * @private
		 */
		public function set backgroundSelectedSkin(value:DisplayObject):void
		{
			if(this._backgroundSelectedSkin == value)
			{
				return;
			}
			const oldDisplayListBypassEnabled:Boolean = this.displayListBypassEnabled;
			this.displayListBypassEnabled = false;
			
			if(this._backgroundSelectedSkin && this._backgroundSelectedSkin != this._backgroundDisabledSkin)
			{
				this.removeChild(this._backgroundSelectedSkin);
			}
			this._backgroundSelectedSkin = value;
			if(this._backgroundSelectedSkin && this._backgroundSelectedSkin.parent != this)
			{
				this._backgroundSelectedSkin.visible = false;
				this.addChildAt(this._backgroundSelectedSkin, 0);
			}
			this.invalidate(INVALIDATION_FLAG_STYLES);
			this.displayListBypassEnabled = oldDisplayListBypassEnabled;
		}
    }
}
