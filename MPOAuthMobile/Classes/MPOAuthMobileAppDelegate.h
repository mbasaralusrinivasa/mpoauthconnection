//
//  MPOAuthMobileAppDelegate.h
//  MPOAuthMobile
//
//  Created by Karl Adam on 08.12.14.
//  Copyright matrixPointer 2008. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MPOAuthAPI.h"

@interface MPOAuthMobileAppDelegate : NSObject <UIApplicationDelegate, MPOAuthAPIDelegate> {
    UIWindow *window;
    UINavigationController *navigationController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet UINavigationController *navigationController;

@end
