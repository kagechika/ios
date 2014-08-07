//
//  ViewController.m
//  MyVeryFirstApp
//
//  Created by okitokagechika on 2014/03/23.
//  Copyright (c) 2014年 okitokagechika. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController{
    // ラベル用インスタンス
    IBOutlet UILabel *myLabel;
    // ボタン用インスタンス
    IBOutlet UIButton *myButton;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// ボタン押下
- (IBAction) buttonPushed{
    // myLabelの表示非表示の切り替え
    if(myLabel.isHidden == NO){
        [myLabel setHidden:YES];
    }else{
        [myLabel setHidden:NO];
    }
}

@end
