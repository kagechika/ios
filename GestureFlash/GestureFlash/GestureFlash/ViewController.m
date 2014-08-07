//
//  ViewController.m
//  GestureFlash
//
//  Created by okitokagechika on 2014/04/12.
//  Copyright (c) 2014年 okito.kagechika. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController{
    //メンバー変数
    IBOutlet UILabel *highscore1_label;
    IBOutlet UILabel *highscore2_label;
    IBOutlet UILabel *highscore3_label;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    // UserDefaultsにアクセス
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    //1位から3位までのハイスコアを取得。dataがない場合は0が返る
    double highscores1 = [defaults doubleForKey:@"highscore1"];
    double highscores2 = [defaults doubleForKey:@"highscore2"];
    double highscores3 = [defaults doubleForKey:@"highscore3"];
    
    NSLog(@"ハイスコア: 1-%f 2-%f 3-%f", highscores1, highscores2, highscores3);
    
    if(highscores1 != 0){
        highscore1_label.text = [NSString stringWithFormat:@"%.3f 秒", highscores1];
    }
    if(highscores2 != 0){
        highscore2_label.text = [NSString stringWithFormat:@"%.3f 秒", highscores2];
    }
    if(highscores3 != 0){
        highscore3_label.text = [NSString stringWithFormat:@"%.3f 秒", highscores3];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
