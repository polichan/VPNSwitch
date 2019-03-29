#import "vpnswitch.h"
#import <dlfcn.h>
#import <objc/runtime.h>
#import <substrate.h>

@interface VPNBundleController : NSObject
-(id)initWithParentListController:(id)arg1 properties:(id)arg2 ;
@property(nonatomic,assign) BOOL VPNActive;
@end

@interface vpnswitch()
@property (nonatomic, strong) NSBundle *VPNPreferences;
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
	// if ([self canVPNConnect]) {
	// 	_selected = NO;
	// }else{
	// 	_selected = YES;
	// }
	_selected = selected;

  [super refreshState];

  if(_selected)
  {
		[self doVPNStuffWithStatus:1];
  }
  else
  {
    [self doVPNStuffWithStatus:0];
  }
}

- (BOOL)canVPNConnect{
	if([self.VPNPreferences load]){
		Class VPC = objc_getClass("VPNBundleController");
			if(VPC!=NULL){
					VPNBundleController *VPNBC =[[VPC alloc] initWithParentListController:nil];
						if([VPNBC respondsToSelector:@selector(setVPNActive:)]){
							if (VPNBC.VPNActive) {
								return YES;
							}else{
								return NO;
							}
						}
			else if([VPNBC respondsToSelector:@selector(_setVPNActive:)]){
						if (VPNBC.VPNActive) {
							return YES;
						}else{
							return NO;
						}
					}
				[VPNBC release];
	  }
	}
}
- (void)doVPNStuffWithStatus:(NSInteger)status{
	if([self.VPNPreferences load]){
		Class VPC = objc_getClass("VPNBundleController");
			if(VPC!=NULL){
					VPNBundleController *VPNBC =[[VPC alloc] initWithParentListController:nil];
	  			if([VPNBC respondsToSelector:@selector(setVPNActive:)]){
						if (status == 1) {
							[VPNBC setVPNActive:YES];
						}else{
							[VPNBC setVPNActive:NO];
						}
	  			}
	  else if([VPNBC respondsToSelector:@selector(_setVPNActive:)]){
			if (status == 1) {
				[VPNBC setVPNActive:YES];
			}else{
				[VPNBC setVPNActive:NO];
			}
	  }
	[VPNBC release];
	}
	}
}

- (NSBundle *)VPNPreferences{
	if (!_VPNPreferences) {
		_VPNPreferences = [NSBundle bundleWithPath:@"/System/Library/PreferenceBundles/VPNPreferences.bundle"];
	}
	return _VPNPreferences;
}
@end
