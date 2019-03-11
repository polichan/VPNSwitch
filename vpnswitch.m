#import "vpnswitch.h"
#import <dlfcn.h>
#import <objc/runtime.h>
#import <substrate.h>


@interface VPNBundleController : NSObject
-(id)initWithParentListController:(id)arg1 properties:(id)arg2 ;
@end


@implementation vpnswitch

//Return the icon of your module here
- (UIImage *)iconGlyph
{
	return [UIImage imageNamed:@"Icon" inBundle:[NSBundle bundleForClass:[self class]] compatibleWithTraitCollection:nil];
}

//Return the color selection color of your module here
- (UIColor *)selectedColor
{
	return [UIColor blueColor];
}

- (BOOL)isSelected
{
  return _selected;
}

- (void)setSelected:(BOOL)selected
{
	_selected = selected;

  [super refreshState];

  if(_selected)
  {
    [self connectVPN];
  }
  else
  {
    [self disconnectVPN];
  }
}
- (void)connectVPN{
	NSBundle *VPNPreferences = [NSBundle bundleWithPath:@"/System/Library/PreferenceBundles/VPNPreferences.bundle"];
	if([VPNPreferences load]==YES){
		Class VPC = objc_getClass("VPNBundleController");
			if(VPC!=NULL){
					NSLog(@"VPNBundleController Loaded");
					VPNBundleController *VPNBC =[[VPC alloc] initWithParentListController:nil];
	  			if([VPNBC respondsToSelector:@selector(setVPNActive:)]){
	    			[VPNBC setVPNActive:YES];
	  			}
	  else if([VPNBC respondsToSelector:@selector(_setVPNActive:)]){
	      [VPNBC _setVPNActive:YES];
	  }
	[VPNBC release];
	}
	}
}

- (void)disconnectVPN{
	NSBundle *VPNPreferences = [NSBundle bundleWithPath:@"/System/Library/PreferenceBundles/VPNPreferences.bundle"];
	if([VPNPreferences load]==YES){
		Class VPC = objc_getClass("VPNBundleController");
			if(VPC!=NULL){
					NSLog(@"VPNBundleController Loaded");
					VPNBundleController *VPNBC =[[VPC alloc] initWithParentListController:nil];
					if([VPNBC respondsToSelector:@selector(setVPNActive:)]){
						[VPNBC setVPNActive:NO];
					}
		else if([VPNBC respondsToSelector:@selector(_setVPNActive:)]){
				[VPNBC _setVPNActive:NO];
		}
	[VPNBC release];
	}
	}
}
@end
