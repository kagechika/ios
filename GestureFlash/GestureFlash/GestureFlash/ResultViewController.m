//
//  ResultViewController.m
//  GestureFlash
//
//  Created by okitokagechika on 2014/04/12.
//  Copyright (c) 2014年 okito.kagechika. All rights reserved.
//

#import "ResultViewController.h"

@interface ResultViewController ()

@end

@implementation ResultViewController{
    //メンバー変数
    IBOutlet UILabel *timeLabel;
    IBOutlet UILabel *newHighScoreLabel;
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
    // Do any additional setup after loading the view.
    
    //タイムを表示
    timeLabel.text = [NSString stringWithFormat:@"%.3f 秒", _time];
    //ハイスコアの判定
    [self checkHighScore];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)checkHighScore{
    BOOL newHighScore = false;
    //ハイスコアラベルの非表示
    newHighScoreLabel.hidden = true;
    //UserDefaultsにアクセス
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    //1位から3位までのハイスコアを取得
    double highscores1 = [defaults doubleForKey:@"highscore1"];
    double highscores2 = [defaults doubleForKey:@"highscore2"];
    double highscores3 = [defaults doubleForKey:@"highscore3"];
    
    if (highscores1 != 0 && _time <= highscores1) {
        highscores3 = highscores2;
        highscores2 = highscores1;
        highscores1 = _time;
        newHighScore = true;
    } else if (highscores2 != 0 && _time <= highscores2) {
        highscores3 = highscores2;
        highscores2 = _time;
        newHighScore = true;
    } else if (highscores3 !=0 && _time <= highscores3) {
        highscores3 = _time;
        newHighScore = true;
        
    // ハイスコアが初期値(0)の場合
    } else if (highscores1 == 0) {
        highscores1 = _time;
        newHighScore = true;
    } else if (highscores2 == 0 && _time >= highscores1) {
        highscores2 = _time;
        newHighScore = true;
    } else if (highscores3 == 0 && _time >= highscores2) {
        highscores3 = _time;
        newHighScore = true;
    }
    
    //新しいハイスコアをUserDefaultsに保存
    [defaults setDouble:highscores1 forKey:@"highscore1"];
    [defaults setDouble:highscores2 forKey:@"highscore2"];
    [defaults setDouble:highscores3 forKey:@"highscore3"];
    
    //ハイスコア更新ラベルの表示
    if (newHighScore == true) {
        newHighScoreLabel.hidden = false;
    }
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
