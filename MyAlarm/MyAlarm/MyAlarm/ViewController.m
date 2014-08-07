//
//  ViewController.m
//  MyAlarm
//
//  Created by okitokagechika on 2014/05/17.
//  Copyright (c) 2014年 okito.kagechika. All rights reserved.
//

#import "ViewController.h"
#import "AppDelegate.h"

@interface ViewController ()

@end

@implementation ViewController {
    NSTimer *timer;
    
    // 時刻の各桁を格納する
    int hoursecond;
    int hourfirst;
    int minutesecond;
    int minutefirst;
    int secondsecond;
    int secondfirst;
    
    // 時刻用画像
    UIImage *image0;
    UIImage *image1;
    UIImage *image2;
    UIImage *image3;
    UIImage *image4;
    UIImage *image5;
    UIImage *image6;
    UIImage *image7;
    UIImage *image8;
    UIImage *image9;
    
    // 時刻表示用パス
    NSString *aImagePath0;
    NSString *aImagePath1;
    NSString *aImagePath2;
    NSString *aImagePath3;
    NSString *aImagePath4;
    NSString *aImagePath5;
    NSString *aImagePath6;
    NSString *aImagePath7;
    NSString *aImagePath8;
    NSString *aImagePath9;
    
    // 時計画像を格納する配列
    NSArray *imageArray;
    
    // 時刻各桁表示用のImageView
    IBOutlet UIImageView *imageview_hour10;
    IBOutlet UIImageView *imageview_hour0;
    IBOutlet UIImageView *imageview_min0;
    IBOutlet UIImageView *imageview_min10;
    
    // DatePickerのクラスを呼び出す
    SettingViewController *datePickerCotroller;
    
    // 目覚まし時刻表示用ラベル
    IBOutlet UILabel *labelForDate;
    
    // アラーム音声各格納用
    NSString *alarmSound;
    
    // 現在時刻設定用
    NSDate *now;
    
    // 現在時刻を文字列として出力するための変数
    NSString *now_Str;
    
    // アラームの再生する回数判別用
    int AlartFLG;
    
    // 目覚まし設定
    // 文字列型の目覚まし設定時刻格納用
    NSString *setDateStr;
    AVAudioPlayer *player;
}

// タイマー用のメソッド
-(void)time:(NSTimer *)timer{
    // 日付を取得するためのカレンダーを作成
    NSCalendar *cal = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    
    // カレンダーから時、分、秒を取得する
    unsigned int unitFlags = NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit;
    
    // ローカルの日付に置換する
    NSDateComponents *components = [cal components:unitFlags fromDate:[NSDate date]];
    
    // 現在時刻を取得
    now = [NSDate date];
    
    // NSString型に変換するフォーマッタを作成
    NSDateFormatter *nowTimeFormatter = [[NSDateFormatter alloc] init];
    
    // 値の時刻を「時:分」に設定
    [nowTimeFormatter setDateFormat:@"HH:mm"];
    
    // 取得した時刻を文字列型に置換する
    now_Str = [nowTimeFormatter stringFromDate:now];
    
    // ローカル時刻の「時」を取得
    int hour = [components hour];
    
    // ローカル時刻の「分」を取得
    int minute = [components minute];
    
    // ローカル時刻の「秒」を取得
    int second = [components second];
    
    NSLog(@"時刻は%d:%d:%d", hour, minute, second);
    
    // 「時」の一桁目と二桁目を分解
    if (hour > 9) {
        hoursecond = hour/10;
        hourfirst = hour - (floor(hour/10)*10);
    } else {
        hoursecond = 0;
        hourfirst = hour;
    }
    
    // 「分」の一桁目と二桁目を分解
    if (minute > 9) {
        minutesecond = minute/10;
        minutefirst = minute - (floor(minute/10)*10);
    } else {
        minutesecond = 0;
        minutefirst = minute;
    }
    
    // 「秒」の一桁目と二桁目を分解
    if (second > 9) {
        secondsecond = second/10;
        secondfirst = second - (floor(second/10)*10);
    } else {
        secondsecond = 0;
        secondfirst = second;
    }
    
    // 目覚まし判別
    // 目覚まし用設定時刻を文字列型に変換数フォーマッタを作成
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    
    // 値の種類を「HH:mm」に設定
    [formatter setDateFormat:@"HH:mm"];
    
    // 設定された時刻を文字列型に変換する
    setDateStr = [formatter stringFromDate:self.dateForDate];
    
    // 目覚ましの判別
    if ([setDateStr isEqualToString:now_Str]) {
        
        // アラームの再生回数を判別する
        if (AlartFLG<1) {
            
            // アラートを出す(アラーム停止)
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"ALARM" message:@"It's Time!!!" delegate:self cancelButtonTitle:@"STOP" otherButtonTitles:nil, nil];
            
            // アラートビューを出現させる
            [alertView show];
            
            // 再生するサウンドのパスを読み込む
            NSString *soundFilePath = [NSString stringWithFormat:@"%@", alarmSound];
            
            // サウンドのパスから再生するURLを作成する
            NSURL *soundURL = [NSURL fileURLWithPath:soundFilePath];
            
            // エラーの初期状態を設定
            NSError *error = nil;
            
            // サウンド再生用のプレイヤーを作成する
            player = [[AVAudioPlayer alloc] initWithContentsOfURL:soundURL error:&error];
            
            // エラーを判別する条件分
            if (error != nil) {
                NSLog(@"AVAudioPlayerのイニシャライズでエラー(%@)", [error localizedDescription]);
                return;
            }
            
            // 自分自身をdelegateに設定
            [player setDelegate:self];
            
            // プレイヤーを再生する
            [player play];
        }
        
        // 再生変数用の変数をプラス1
        AlartFLG++;
    }
    
    
    // 時計画像を配置するメソッドを呼び出す
    [self draw];
}

-(void)draw{
    // 指定した画像をロードしてパスを作成する
    aImagePath0 = [[NSBundle mainBundle] pathForResource:@"0" ofType:@"png"];
    aImagePath1 = [[NSBundle mainBundle] pathForResource:@"1" ofType:@"png"];
    aImagePath2 = [[NSBundle mainBundle] pathForResource:@"2" ofType:@"png"];
    aImagePath3 = [[NSBundle mainBundle] pathForResource:@"3" ofType:@"png"];
    aImagePath4 = [[NSBundle mainBundle] pathForResource:@"4" ofType:@"png"];
    aImagePath5 = [[NSBundle mainBundle] pathForResource:@"5" ofType:@"png"];
    aImagePath6 = [[NSBundle mainBundle] pathForResource:@"6" ofType:@"png"];
    aImagePath7 = [[NSBundle mainBundle] pathForResource:@"7" ofType:@"png"];
    aImagePath8 = [[NSBundle mainBundle] pathForResource:@"8" ofType:@"png"];
    aImagePath9 = [[NSBundle mainBundle] pathForResource:@"9" ofType:@"png"];
    
    // UIImageにパスから画像を読み込む
    image0 = [UIImage imageWithContentsOfFile:aImagePath0];
    image1 = [UIImage imageWithContentsOfFile:aImagePath1];
    image2 = [UIImage imageWithContentsOfFile:aImagePath2];
    image3 = [UIImage imageWithContentsOfFile:aImagePath3];
    image4 = [UIImage imageWithContentsOfFile:aImagePath4];
    image5 = [UIImage imageWithContentsOfFile:aImagePath5];
    image6 = [UIImage imageWithContentsOfFile:aImagePath6];
    image7 = [UIImage imageWithContentsOfFile:aImagePath7];
    image8 = [UIImage imageWithContentsOfFile:aImagePath8];
    image9 = [UIImage imageWithContentsOfFile:aImagePath9];
    
    // 配列を生成して、画像を格納する
    imageArray = [NSArray arrayWithObjects:image0, image1, image2, image3, image4, image5, image6, image7, image8, image9, nil];
    
    // 各時刻に対応した画像を配列から呼び出す
    [imageview_hour10 setImage:[imageArray objectAtIndex:hoursecond]];
    [imageview_hour0 setImage:[imageArray objectAtIndex:hourfirst]];
    [imageview_min10 setImage:[imageArray objectAtIndex:minutesecond]];
    [imageview_min0 setImage:[imageArray objectAtIndex:minutefirst]];
}

// プラスボタンが押されたときに呼ばれるメソッド
-(IBAction)plusClicked:(id)sender{
    // SettingViewControllerを呼び出す
    datePickerCotroller = [[SettingViewController alloc] init];
    
    // pickerの名前を指定する
    datePickerCotroller.pickerName = @"pickerOfDate";
    
    // 取得する時刻のdelegate
    datePickerCotroller.dispDate = (self.dateForDate != nil) ? self.dateForDate : [NSDate date];
    
    // 設定画面をdelegate
    datePickerCotroller.delegate = self;
    
    // 設定画面をモーダルとして呼び出す
    [self showModal:datePickerCotroller.view];
}

// 設定画面を呼び出すメソッド
-(void)showModal:(UIView*)modalView{
    // モーダル画面として呼び出すための準備
    UIWindow *mainWindow = (((AppDelegate*)[UIApplication sharedApplication].delegate).window);
    
    // モーダル画面を配置する場所を指定
    CGPoint middleCenter = modalView.center;
    
    // モーダル画面のサイズを指定
    CGSize offSize = [UIScreen mainScreen].bounds.size;
    
    // 画面外に配置するモーダル画面の中心点を指定
    CGPoint offScreenCenter = CGPointMake(offSize.width / 2.0, offSize.height * 1.5);
    
    // モーダル画面を配置する(画面外)
    modalView.center = offScreenCenter;
    
    // メインの画面に設定画面を追加する
    [mainWindow addSubview:modalView];
    
    // アニメーションの設定
    [UIView beginAnimations:nil context:nil];
    
    // アニメーションの長さを指定
    [UIView setAnimationDuration:0.5];
    
    // モーダル画面を配置する
    modalView.center = middleCenter;
    
    // アニメーションをスタートさせる
    [UIView commitAnimations];
    
}

// 設定画面を隠すメソッド
-(void)hideModal:(UIView *)modalView{
    // モーダルの画面サイズを指定
    CGSize offSize = [UIScreen mainScreen].bounds.size;
    
    // 画面外に配置するモーダル画面の中心点を指定
    CGPoint offScreenCenter = CGPointMake(offSize.width/2.0, offSize.height*1.5);
    
    // アニメーションの設定
    [UIView beginAnimations:nil context:(__bridge void *)(modalView)];
    
    // アニメーションの長さを指定
    [UIView setAnimationDuration:0.3];
    
    // delegateを設定
    [UIView setAnimationDelegate:self];
    
    // アニメーションをストップすると呼ばれるメソッドを指定する
    [UIView setAnimationDidStopSelector:@selector(hideModalEnded:finished:context:)];
    
    // 画面外にモーダルを配置する
    modalView.center = offScreenCenter;
    
    // アニメーションを開始する
    [UIView commitAnimations];
}

// 設定画面が隠されたときに呼ばれるメソッド
-(void)hideModalEnded:(NSString *)animationID finished:(NSNumber *)finished context:(void *)context{
    
    UIView *modalView = (__bridge UIView *)context;
    
    // メインの画面からモーダル画面をリムーブする
    [modalView removeFromSuperview];
}

// Saveボタンが押されたときに呼び出されるメソッド
-(void)didSaveButtonClicked:(SettingViewController *)controller selectedDate:(NSDate *)selectedDate pickerName:(NSString *)pickerName{

    // 設定画面を隠す
    [self hideModal:datePickerCotroller.view];
    
    // 設定画面のインスタンスを空にする
    datePickerCotroller = nil;
    
    // 時刻用のフォーマッタを用意する
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    
    // フォーマッタの種類を指定
    [formatter setDateFormat:@"HH:mm"];
    
    // Pickerの名前がpickerOfDateの場合
    if ([pickerName isEqualToString:@"pickerOfDate"]) {
        
        // delegateを設定
        self.dateForDate = selectedDate;
        
        // ラベルに表示させる文字列を作成
        labelForDate.text = [formatter stringFromDate:self.dateForDate];
        
    }
}

// キャンセルボタンが押されたときに呼び出されるメソッド
-(void)didCancelButtonClicked:(SettingViewController *)controller pickerName:(NSString *)pickerName{
    
    // モーダルビューを隠すためのメソッドを呼ぶ
    [self hideModal:datePickerCotroller.view];
    
    // datePickerを空にする
    datePickerCotroller = nil;
}

// refreshボタンが押されたときに呼びだされるメソッド
-(void)didRefreshButtonClicked:(SettingViewController *)controller pickerName:(NSString *)pickerName{
    
    // モーダルビューを隠すためのメソッドを呼ぶ
    [self hideModal:datePickerCotroller.view];
    
    // datePickerを空にする
    datePickerCotroller = nil;
    
    // pickerの名前がpickerOfDateの場合
    if ([pickerName isEqualToString:@"pickerOfDate"]) {
        
        // 時刻を格納する変数を空
        self.dateForDate = nil;
        
        // ラベル表示をもとにもどす
        labelForDate.text = @"タイマー";
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    // タイマーを作成
    timer = [NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(time:) userInfo:nil repeats:YES];
    
    // アラーム用のサウンドを読み込む
    alarmSound = [[NSBundle mainBundle] pathForResource:@"koukaon1" ofType:@"wav"];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
