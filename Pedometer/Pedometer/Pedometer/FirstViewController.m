//
//  FirstViewController.m
//  Pedometer
//
//  Created by okitokagechika on 2014/04/27.
//  Copyright (c) 2014年 okito.kagechika. All rights reserved.
//

#import "FirstViewController.h"

@interface FirstViewController ()

@end

@implementation FirstViewController{
    //加速度
    Accelerometer *accel;
    //山の検出フラグ
    BOOL stepFlag;
    //歩数の合計
    int stepCount;
    //歩数の表示ラベル
    IBOutlet UILabel *stepCountLabel;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    //歩数をリセット
    [self reset];
    //加速度計をリセット
    [self initAccel];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//加速度計をスタート
-(void)initAccel{
    //加速度計のスタート
    accel = [[Accelerometer alloc] initWithDelegate:self];
    [accel addAcceleration];
}

//1/60秒ごとに呼ばれる、歩行を検知するメソッド
-(void)analyzeWalk:(UIAccelerationValue)x :(UIAccelerationValue)y :(UIAccelerationValue)z{
    //山の閾値
    UIAccelerationValue hiTreshold = 1.1;
    //谷の閾値
    UIAccelerationValue lowTreshold = 0.9;
    //合成加速度を算出
    UIAccelerationValue composite;
    composite = sqrt(pow(x, 2)+pow(y, 2)+pow(z, 2));
    //山の後に谷を検知すると1歩進んだと認識
    if (stepFlag == TRUE) {
        if (composite < lowTreshold) {
            stepCount++;
            stepFlag = FALSE;
        }
    } else {
        if (composite > hiTreshold) {
            stepFlag = TRUE;
        }
    }
    NSLog(@"%f %f %f %f", x, y, z, composite);
    //現在の歩数をラベルに表示
    stepCountLabel.text = [NSString stringWithFormat:@"%d", stepCount];
}

//メール送信ボタンが押されたときの処理
-(IBAction)sendMail:(id)sender{
    //件名と本文の内容
    NSString *subject = @"歩きました";
    NSString *message = [NSString stringWithFormat:@"たった今、私は %d 歩きました", stepCount];
    //MFMailComposeViewControllerを生成
    MFMailComposeViewController *mailPicker = [[MFMailComposeViewController alloc] init];
    if ([MFMailComposeViewController canSendMail]) {
        //MFMailComposeViewControllerからのDelegate通知を受け取り
        mailPicker.mailComposeDelegate = self;
        //件名を設定
        [mailPicker setSubject:subject];
        //本文を設定
        [mailPicker setMessageBody:message isHTML:false];
        //meilPickerを呼び出し
        [self presentViewController:mailPicker animated:YES completion:nil];
    }
}

//メール送信画面終了時に呼ばれる
-(void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error{
    //メール画面を閉じる
    [controller dismissViewControllerAnimated:YES completion:nil];
}

//リセットボタンが押されたとき
-(IBAction)resetButtonAction:(id)sender{
    [self reset];
}

//リセット処理
-(void)reset{
    //各変数をリセット
    stepFlag = FALSE;
    stepCount = 0;
    //ラベルの値をリセット
    stepCountLabel.text = [NSString stringWithFormat:@"%d", stepCount];
}

@end
