/**
 * Copyright (c) 2013, Digital Touch sp. z o.o.
 * All rights reserved.
 * 
 * Any use, copying, modification, distribution and selling of this source code and it's documentation
 * for any purposes without authors' written permission is hereby prohibited.
 */
package feathers.skins
{
	import feathers.controls.ImageLoader;
	import feathers.core.DisplayListWatcher;
	
	import starling.core.Starling;
	import starling.display.Image;
	import starling.textures.Texture;
	import starling.app.Logger;
	
	/**
	 * 
	 * @author developer
	 * 
	 */
	public class Skin extends DisplayListWatcher
	{
		
		//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
		
		public static const DISABLED_ALPHA: Number = 0.5;
		public static const ENABLED_ALPHA: Number = 1;
		
		//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
		
		/**
		 * 
		 */
		protected var scale: Number;
		
		//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
		
		/**
		 * 
		 * @param topLevelContainer
		 * @param assetManager
		 * 
		 */
		public function Skin()
		{
			super(Starling.current.stage);			
			this.scale = Starling.current.contentScaleFactor;
		}
		
		//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
		
		[PostConstruct]
		/**
		 * 
		 * 
		 */
		public function initialize(): void {
			Logger.log("initialize theme.", this);
		}
		
		//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
		
		[PreDestroy]
		/**
		 * 
		 * 
		 */
		override public function dispose(): void {
			super.dispose();
			Logger.log("dispose theme.", this);
		}
		
		//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
		
		/**
		 * 
		 * @param source
		 * @return 
		 * 
		 */
		protected function createImageLoader(source: * = null): ImageLoader {
			var loader: ImageLoader = new ImageLoader();
			loader.source = source;
			return loader;
		}
		
		//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
		
		/**
		 * 
		 * @param source
		 * @return 
		 * 
		 */
		protected function createImage(source: Texture = null): Image {
			if (!source) {
				source = Texture.empty(10, 10);
			}
			var image: Image = new Image(source);
			image.touchable = false;
			//Logger.log(source, "scale:", source.scale, "width:", source.width, "height:",source.height, "nativeWidth:", source.nativeWidth, "nativeHeight:",source.nativeHeight, "mipMapping:",source.mipMapping);
			image.readjustSize();
			return image;
		}
	}
}