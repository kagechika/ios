//
//  SettingViewController.m
//  MyAlarm
//
//  Created by okitokagechika on 2014/05/17.
//  Copyright (c) 2014年 okito.kagechika. All rights reserved.
//

#import "SettingViewController.h"

@interface SettingViewController ()

@end

@implementation SettingViewController {
    // 時刻設定用ピッカー
    IBOutlet UIDatePicker *picker;
    
    // saveボタン
    IBOutlet UIBarItem *saveButton;
    
    // キャンセルボタン
    IBOutlet UIBarItem *cancelButton;
    
    // リフレッシュボタン
    IBOutlet UIBarItem *refreshButton;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

// Saveボタンが押されたときに呼ばれるメソッド
-(IBAction)saveButtonClicked:(id)sender{
    [self.delegate didSaveButtonClicked:self selectedDate:picker.date pickerName:self.pickerName];
}

// キャンセルボタンが押されたときに呼ばれるメソッド
-(IBAction)cancelButtonClicked:(id)sender{
    [self.delegate didCancelButtonClicked:self pickerName:self.pickerName];
}

// refreshボタンが押されたときに呼ばれるメソッド
-(IBAction)refreshButtonClicked:(id)sender{
    [self.delegate didRefreshButtonClicked:self pickerName:self.pickerName];
}

-(void)viewDidAppear:(BOOL)animated{
    // 設定時刻が空でない場合
    if (self.dispDate != nil) {
        // delegateを設定
        [picker setDate:self.dispDate];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
