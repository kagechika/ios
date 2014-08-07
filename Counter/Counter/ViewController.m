//
//  ViewController.m
//  Counter
//
//  Created by okitokagechika on 2014/03/23.
//  Copyright (c) 2014年 okitokagechika. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

// オブジェクトの定義
@implementation ViewController{
    // 合計値管理
    int count;
    //ラベル用文字列
    NSString *countLabelText;
    
    // ラベルのインスタンス
    IBOutlet UILabel *countLabel;
    // ボタンのインスタンス
    IBOutlet UIButton *plus;
    IBOutlet UIButton *minus;
    IBOutlet UIButton *reset;

}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    //初期化
    count = 0;
}

- (IBAction)plusPushed:(id)sender{
    // １を加算
    count++;
    // ラベル用に文字列を用意
    [self setColor:count];
}

- (IBAction)minusPushed:(id)sender{
    // 1を減算
    if(count>0){
        count--;
    }
    // ラベル用に文字列を用意
    [self setColor:count];
}

- (IBAction)resetPushed:(id)sender{
    // 初期値に戻す
    count = 0;
    // ラベル用に文字列を用意
    [self setColor:count];
}

// カウントの値による処理
- (void)setColor:(int)nowCount{
    if(nowCount>=0 && nowCount<10){
        countLabel.textColor = [UIColor whiteColor];
        
    }else if(nowCount>=10 && nowCount<20){
        countLabel.textColor = [UIColor greenColor];
        
    }else if(nowCount>=20 && nowCount<30){
        countLabel.textColor = [UIColor yellowColor];
        
    }else{
        countLabel.textColor = [UIColor redColor];
    }
    countLabelText = [NSString stringWithFormat:@"%d", nowCount];
    [countLabel setText:countLabelText];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
