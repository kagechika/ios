//
//  FirstViewController.h
//  Pedometer
//
//  Created by okitokagechika on 2014/04/27.
//  Copyright (c) 2014年 okito.kagechika. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Accelerometer.h"
#import <MessageUI/MessageUI.h>
#import <MessageUI/MFMailComposeViewController.h>

@interface FirstViewController : UIViewController<AccelerometerDelegate,MFMailComposeViewControllerDelegate>

@end
