//
//  ViewController.h
//  ToyCamera
//
//  Created by okitokagechika on 2014/05/18.
//  Copyright (c) 2014年 okito.kagechika. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreImage/CoreImage.h>

@interface ViewController : UIViewController<UINavigationControllerDelegate, UIImagePickerControllerDelegate, UIActionSheetDelegate>

-(IBAction)doCamera:(id)sender;
-(IBAction)doFilter:(id)sender;
-(IBAction)doSave:(id)sender;

@end
