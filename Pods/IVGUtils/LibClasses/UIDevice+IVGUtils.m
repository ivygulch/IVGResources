//
//  UIDevice+IVGUtils.h
//  IVGUtils
//
//  Created by Douglas Sjoquist on 3/20/11.
//  Copyright 2011 Ivy Gulch, LLC. All rights reserved.
//

#import "UIDevice+IVGUtils.h"
#include <sys/types.h>
#include <sys/sysctl.h>

@implementation UIDevice (IVGUtils)

#pragma mark -
#pragma mark Device-specific interface control

- (NSString *)machine {
    size_t size;
    
    // Set 'oldp' parameter to NULL to get the size of the data
    // returned so we can allocate appropriate amount of space
    sysctlbyname("hw.machine", NULL, &size, NULL, 0); 
    
    // Allocate the space to store name
    char *name = malloc(size);
    
    // Get the platform name
    sysctlbyname("hw.machine", name, &size, NULL, 0);
    
    // Place name into a string
    NSString *machine = [NSString stringWithCString:name encoding:NSUTF8StringEncoding];

    // Done with this
    free(name);
    
    return machine;
}

- (BOOL) isLimitedMachine {
    NSString *m = [self machine];
    
    if ([m hasPrefix:@"iPhone1"]) {
        return YES;
    } else if ([m hasPrefix:@"iPhone2"]) {
        return YES;
    } else if ([m hasPrefix:@"iPod1"]) {
        return YES;
    } else if ([m hasPrefix:@"iPod2"]) {
        return YES;
    } else if ([m hasPrefix:@"i386"]) { 
        // for testing, need to switch this back and forth
        return NO; 
    } else {
        return NO;
    }
}

+ (BOOL) isRunningOniPad {
	static BOOL hasCheckediPadStatus = NO;
	static BOOL isRunningOniPad = NO;
	
	if (!hasCheckediPadStatus) {
		if ([[UIDevice currentDevice] respondsToSelector:@selector(userInterfaceIdiom)]) {
            UIUserInterfaceIdiom userInterfaceIdiom = UI_USER_INTERFACE_IDIOM();
			if (userInterfaceIdiom == UIUserInterfaceIdiomPad) {
				isRunningOniPad = YES;
				hasCheckediPadStatus = YES;
				return isRunningOniPad;
			}
		}
        
		hasCheckediPadStatus = YES;
	}
	
	return isRunningOniPad;
}

+ (BOOL) isPortrait {
    return UIDeviceOrientationIsPortrait([UIDevice deviceOrientation]);
}

+ (BOOL) isLandscape {
    return UIDeviceOrientationIsLandscape([UIDevice deviceOrientation]);
}

+ (UIDeviceOrientation) deviceOrientation {
    return [[UIDevice currentDevice] orientation];
}

+ (NSInteger) getSystemVersionAsAnInteger{
    int index = 0;
    NSInteger version = 0;
    NSArray* digits = [[UIDevice currentDevice].systemVersion componentsSeparatedByString:@"."];
    NSInteger multiplier = 10000;
    for (NSString *number in digits) {
        if (index>2) {
            break;
        }
        version += [number intValue]*multiplier;
        multiplier /= 100;
        index++;
    }
    return version;
}

+ (BOOL) systemVersionIsAtLeast:(NSInteger) minimumVersion {
    return [self getSystemVersionAsAnInteger] >= minimumVersion;
}

@end
