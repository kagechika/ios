//
//  ViewController.h
//  MyAlarm
//
//  Created by okitokagechika on 2014/05/17.
//  Copyright (c) 2014年 okito.kagechika. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SettingViewController.h"
#import <AVFoundation/AVFoundation.h>

@interface ViewController : UIViewController<SettingViewControllerDelegate, AVAudioPlayerDelegate>

// 目覚まし設定時刻格納用
@property NSDate *dateForDate;

@end
