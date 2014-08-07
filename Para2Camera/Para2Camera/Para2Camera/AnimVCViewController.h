//
//  AnimVCViewController.h
//  Para2Camera
//
//  Created by okitokagechika on 2014/05/24.
//  Copyright (c) 2014年 okito.kagechika. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AnimVCViewController : UIViewController

@property (nonatomic, retain) IBOutlet UIImageView *aImageView;
@property (nonatomic, retain) IBOutlet UISlider *aSlider;

// スライダー値の変更用
-(IBAction)doSliderValueChanged:(id)sender;

@end
